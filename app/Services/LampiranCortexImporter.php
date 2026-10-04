<?php

namespace App\Services;

use PhpOffice\PhpSpreadsheet\IOFactory;

class LampiranCortexImporter
{
    // sheet_code => kategori_id
    public static function sheetCodeToKategori($sheetCode)
    {
        if ($sheetCode === '01') return 1;
        if ($sheetCode === '02') return 2;
        if ($sheetCode === '03') return 3;
        if ($sheetCode === '04') return 4;
        if ($sheetCode === '05') return 5;
        if ($sheetCode === '1') return 7;
        // 06-99 => harta lainnya
        if (preg_match('/^\d{1,2}$/', (string) $sheetCode)) {
            $n = (int) $sheetCode;
            if ($n >= 6 && $n <= 99) return 6;
        }
        return null;
    }

    // Deteksi sheet_code dari nama sheet. Prioritas: awalan digit ("01", "1", ...),
    // lalu title kategori ("KAS", "HARTA BERGERAK", "TOTAL HUTANG", ...).
    // Tidak cocok => null (sheet di-skip).
    public static function detectSheetCode($title)
    {
        $t = trim((string) $title);
        // prioritas: awalan digit, misal "01", "01 - KAS", "1", "1 HUTANG", "06"
        if (preg_match('/^(\d{1,2})\b/', $t, $m)) {
            if (strlen($m[1]) === 2) {
                // "01".."09" pertahankan nol depan
                return $m[1];
            }
            $code = ltrim($m[1], '0');
            return $code === '' ? '0' : $code; // "1" => "1"
        }
        // samakan dengan title kategori lampiran (case/spasi/tanda bebas)
        $upper = strtoupper($t);
        $norm = preg_replace('/[^A-Z0-9]/', '', $upper);
        if (strpos($norm, 'TIDAKBERGERAK') !== false) return '05';
        if (strpos($norm, 'BERGERAK') !== false) return '04';
        if (strpos($norm, 'LAINNYA') !== false) return '06';
        if (strpos($norm, 'PIUTANG') !== false) return '02';
        if (strpos($norm, 'INVEST') !== false) return '03';
        if (strpos($norm, 'HUTANG') !== false || strpos($norm, 'UTANG') !== false) return '1';
        // KAS paling akhir + harus kata utuh (biar "RINGKASAN" tidak ikut cocok)
        if ($norm === 'KAS' || preg_match('/(^|[^A-Z])KAS([^A-Z]|$)/', $upper)) return '01';
        return null;
    }

    public static function kodeMatchesSheet($kode, $sheetCode)
    {
        $kode = trim((string) $kode);
        if ($kode === '' || $kode === '-') return false;
        // hutang: 3 digit diawali 1 (101,102,103,109)
        $isHutangKode = (bool) preg_match('/^1\d{2}$/', $kode);
        if ($sheetCode === '01') return strpos($kode, '01') === 0;
        if ($sheetCode === '02') return strpos($kode, '02') === 0;
        if ($sheetCode === '03') return strpos($kode, '03') === 0;
        if ($sheetCode === '04') return strpos($kode, '04') === 0;
        if ($sheetCode === '05') return strpos($kode, '05') === 0;
        if ($sheetCode === '1') return $isHutangKode || (strpos($kode, '1') === 0 && strlen($kode) === 3);
        // 06-99 harta lainnya: tolak 01-05 dan tolak hutang
        if (preg_match('/^\d{2}/', (string) $sheetCode) || $sheetCode === '06') {
            if ($isHutangKode) return false;
            foreach (['01', '02', '03', '04', '05'] as $p) {
                if (strpos($kode, $p) === 0) return false;
            }
            return true;
        }
        return true;
    }

    public static function parseNumeric($value): float
    {
        $val = preg_replace('/[^0-9.,]/', '', trim((string) ($value ?? '0')));
        if ($val === '' || $val === '.' || $val === ',') return 0;
        $dotCount = substr_count($val, '.');
        $commaCount = substr_count($val, ',');
        if ($commaCount > 0) {
            if ($commaCount > 1 && $dotCount <= 1) {
                $val = str_replace(',', '', $val);
            } else {
                $val = str_replace('.', '', $val);
                $val = str_replace(',', '.', $val);
            }
        } elseif ($dotCount > 1) {
            $val = str_replace('.', '', $val);
        }
        return (float) $val;
    }

    protected static function norm($v)
    {
        $v = strtolower(trim((string) $v));
        $v = preg_replace('/[^a-z0-9]/', '', $v);
        return $v;
    }

    // Kunci header: normalisasi + buang angka tahun di ekor,
    // mis. "NILAI SAAT INI (2025)" => "nilaisaatini"
    protected static function headerKey($value)
    {
        return preg_replace('/\d+$/', '', self::norm($value));
    }

    // Cari baris header yang mengandung KODE. Return index atau null.
    public static function findHeaderRow(array $rows)
    {
        $maxScan = min(count($rows), 25);
        for ($i = 0; $i < $maxScan; $i++) {
            $foundKode = false;
            $foundNo = false;
            foreach ($rows[$i] as $cell) {
                $n = self::norm($cell);
                if ($n === 'kode') $foundKode = true;
                if ($n === 'no') $foundNo = true;
            }
            if ($foundKode && $foundNo) return $i;
            if ($foundKode) return $i; // fallback: kode saja cukup
        }
        return null;
    }

    // Spesifikasi field per sheet: field DB =>alias nama header.
    // Urutan kolom bebas — yang penting nama headernya cocok.
    protected static function fieldSpecs($sheetCode)
    {
        switch ($sheetCode) {
            case '01': // KAS
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi'],
                    'nomor_akun' => ['nomorakun', 'noakun', 'akun'],
                    'atas_nama' => ['atasnama'],
                    'nama_bank_institusi' => ['namabankinstitusi', 'bankinstitusi', 'bank', 'institusi'],
                    'lokasi_harta' => ['lokasiharta', 'lokasi'],
                    'kurs' => ['kurs'],
                    'tahun_perolehan' => ['tahunperolehan'],
                    'saldo_bentuk_awal' => ['saldodalambentukawal', 'saldobentukawal', 'saldoawal'],
                    'saldo_saat_ini' => ['nilaisaatini', 'saldosaatini', 'nilai', 'saldo'],
                ];
            case '02': // PIUTANG
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi'],
                    'lokasi_harta' => ['lokasipenerimapinjaman', 'lokasi'],
                    'nik_npwp_pihak' => ['niknpwp', 'nik', 'npwp'],
                    'nama_pihak' => ['nama'],
                    'nilaipiutang' => ['nilaipiutang'],
                    'tahun_mulai' => ['tahundimulai'],
                    'saldo_saat_ini' => ['nilaipiutangsaatini', 'nilaisaatini', 'nilai', 'saldo'],
                ];
            case '03': // INVESTASI
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi'],
                    'lokasi_harta' => ['lokasiharta', 'lokasi'],
                    'nik_npwp_pihak' => ['npwp', 'niknpwp', 'nik'],
                    'nama_pihak' => ['nama'],
                    'nomor_akun' => ['nomorakun', 'noakun', 'akun'],
                    'kurs' => ['kurs'],
                    'harga_perolehan' => ['hargaperolehan'],
                    'saldo_bentuk_awal' => ['saldodalambentukawal', 'saldobentukawal', 'saldoawal'],
                    'tahun_perolehan' => ['tahunperolehan'],
                    'saldo_saat_ini' => ['nilaisaatini', 'nilai', 'saldo'],
                ];
            case '04': // HARTA BERGERAK
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi', 'tipe'],
                    'merk_tipe' => ['merkmodel', 'merekmodel', 'merkemodel', 'merk', 'model'],
                    'nopol_sertifikat' => ['nomorpolisiregistrasi', 'nopol', 'noregistrasi', 'registrasi', 'nomorakun'],
                    'kepemilikan' => ['kepemilikan'],
                    'nik_npwp_pihak' => ['niknpwp', 'nik', 'npwp'],
                    'nama_pihak' => ['nama'],
                    'tahun_perolehan' => ['tahunperolehan'],
                    'harga_perolehan' => ['hargaperolehan'],
                    'saldo_saat_ini' => ['nilaisaatini', 'nilai', 'saldo'],
                ];
            case '05': // HARTA TIDAK BERGERAK
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi'],
                    'lokasi_harta' => ['lokasiharta', 'lokasi'],
                    'detail_info' => ['detail'],
                    'ukuran_tanah' => ['tanah'],
                    'ukuran_bangunan' => ['bangunan'],
                    'sumber_kepemilikan' => ['sumberkepemilikan', 'sumber'],
                    'nopol_sertifikat' => ['nomorsertifikat', 'sertifikat', 'nomorakun'],
                    'tahun_perolehan' => ['tahunperolehan'],
                    'harga_perolehan' => ['hargaperolehan'],
                    'saldo_saat_ini' => ['nilaisaatini', 'nilai', 'saldo'],
                ];
            case '1': // HUTANG
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi'],
                    'nik_npwp_pihak' => ['niknpwp', 'nik', 'npwp'],
                    'nama_pihak' => ['nama'],
                    'negara_kreditur' => ['negarakreditur', 'negara'],
                    'tahun_mulai' => ['tahunpeminjaman', 'tahun'],
                    'saldo_saat_ini' => ['nilaisaatini', 'nilaipiutangsaatini', 'nilai', 'saldo'],
                    'detail_info' => ['keterangan'],
                ];
            default: // 06-99 HARTA LAINNYA
                return [
                    'kode' => ['kode'],
                    'deskripsi' => ['deskripsi'],
                    'tahun_perolehan' => ['tahunperolehan'],
                    'nomor_akun' => ['buktikepemilikannomorakun', 'buktikepemilikan', 'bukti', 'nomorakun', 'noakun'],
                    'detail_info' => ['informasitambahan', 'info', 'keterangan'],
                    'harga_perolehan' => ['hargaperolehan'],
                    'saldo_saat_ini' => ['nilaisaatini', 'nilai', 'saldo'],
                ];
        }
    }

    // Petakan nama header => index kolom.
    // Sel header kosong diisi dari baris bawahnya (subheader, mis. TIPE/MEREK di cortex),
    // kecuali sel angka (baris subheader tahun) yang diabaikan.
    public static function buildColMap(array $headerRow, array $nextRow = [])
    {
        $map = [];
        $n = max(count($headerRow), count($nextRow));
        for ($i = 0; $i < $n; $i++) {
            $h = trim((string) ($headerRow[$i] ?? ''));
            if ($h === '' && isset($nextRow[$i])) {
                $cand = trim((string) $nextRow[$i]);
                if ($cand !== '' && !is_numeric($cand)) {
                    $h = $cand;
                }
            }
            if ($h === '') continue;
            $key = self::headerKey($h);
            if ($key === '' || $key === 'no') continue;
            if (!isset($map[$key])) {
                $map[$key] = $i;
            }
        }
        return $map;
    }

    // Baca semua sheet yang dikenali. Client & tahun TIDAK dibaca dari file
    // (diambil dari form — user sudah memilih client sebelum import).
    public static function parseFile($fullPath)
    {
        $spreadsheet = IOFactory::load($fullPath);
        $result = ['sheets' => [], 'skipped_sheets' => []];
        foreach ($spreadsheet->getAllSheets() as $ws) {
            $title = $ws->getTitle();
            $rows = array_values($ws->toArray(null, true, true, false));
            $sheetCode = self::detectSheetCode($title);
            if ($sheetCode === null) {
                $result['skipped_sheets'][] = ['title' => $title, 'reason' => 'Nama sheet tidak dikenali (bukan 01/02/.../1 atau title kategori)'];
                continue;
            }
            $kategoriId = self::sheetCodeToKategori($sheetCode);
            if ($kategoriId === null) {
                $result['skipped_sheets'][] = ['title' => $title, 'reason' => 'Kode sheet tidak valid: ' . $sheetCode];
                continue;
            }
            $headerIdx = self::findHeaderRow($rows);
            if ($headerIdx === null) {
                $result['skipped_sheets'][] = ['title' => $title, 'reason' => 'Baris header (KODE) tidak ditemukan'];
                continue;
            }
            $nextRow = isset($rows[$headerIdx + 1]) ? array_values($rows[$headerIdx + 1]) : [];
            $colMap = self::buildColMap(array_values($rows[$headerIdx]), $nextRow);
            if (!isset($colMap['kode'])) {
                $result['sheets'][$sheetCode] = [
                    'title' => $title,
                    'kategori_id' => $kategoriId,
                    'header_idx' => $headerIdx,
                    'data_start' => $headerIdx + 1,
                    'rows' => [],
                    'skipped_mismatch' => 0,
                    'error' => 'Kolom KODE tidak ditemukan di sheet ' . $title,
                ];
                continue;
            }
            $kodeIdx = $colMap['kode'];
            $parsed = [];
            $skipped = 0;
            for ($r = $headerIdx + 1; $r < count($rows); $r++) {
                $row = array_values($rows[$r]);
                $kode = isset($row[$kodeIdx]) ? trim((string) $row[$kodeIdx]) : '';
                if ($kode === '' || $kode === '-') continue;
                // kode tidak sesuai sheet => abaikan
                if (!self::kodeMatchesSheet($kode, $sheetCode)) {
                    $skipped++;
                    continue;
                }
                $parsed[] = self::mapRow($sheetCode, $row, $kode, $colMap);
            }
            $result['sheets'][$sheetCode] = [
                'title' => $title,
                'kategori_id' => $kategoriId,
                'header_idx' => $headerIdx,
                'data_start' => $headerIdx + 1,
                'rows' => $parsed,
                'skipped_mismatch' => $skipped,
            ];
        }
        return $result;
    }

    // Mapping posisi kolom per sheet_code ke field DB (berdasar nama header,
    // bukan posisi — urutan kolom di Excel boleh acak).
    protected static function mapRow($sheetCode, array $row, $kode, array $colMap)
    {
        $specs = self::fieldSpecs($sheetCode);
        $get = function ($field) use ($row, $colMap, $specs) {
            foreach ((array) ($specs[$field] ?? []) as $alias) {
                if (isset($colMap[$alias]) && isset($row[$colMap[$alias]])) {
                    return trim((string) $row[$colMap[$alias]]);
                }
            }
            return '';
        };
        $num = function ($field) use ($get) {
            return self::parseNumeric($get($field));
        };
        $int = function ($field) use ($get) {
            $v = $get($field);
            return is_numeric($v) ? (int) $v : null;
        };

        $base = ['kode' => $kode, 'kurs' => '', 'nilai_kurs' => 0];
        switch ($sheetCode) {
            case '01': // KAS
                $base += [
                    'deskripsi' => $get('deskripsi'),
                    'nomor_akun' => $get('nomor_akun'),
                    'atas_nama' => $get('atas_nama'),
                    'nama_bank_institusi' => $get('nama_bank_institusi'),
                    'lokasi_harta' => $get('lokasi_harta'),
                    'tahun_perolehan' => $int('tahun_perolehan'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                    'saldo_bentuk_awal' => $num('saldo_bentuk_awal'),
                    'harga_perolehan' => 0,
                ];
                $base['kurs'] = $get('kurs');
                break;
            case '02': // PIUTANG
                $nama = $get('nama_pihak');
                $base += [
                    'deskripsi' => $get('deskripsi') !== '' ? $get('deskripsi') : 'PIUTANG',
                    'lokasi_harta' => $get('lokasi_harta'),
                    'nik_npwp_pihak' => $get('nik_npwp_pihak'),
                    'nama_pihak' => $nama,
                    'atas_nama' => $nama,
                    'tahun_mulai' => $int('tahun_mulai'),
                    'tahun_perolehan' => $int('tahun_mulai'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                    'saldo_bentuk_awal' => $num('nilaipiutang'),
                    'harga_perolehan' => $num('nilaipiutang'),
                ];
                break;
            case '03': // INVEST
                $nama = $get('nama_pihak');
                $harga = $num('harga_perolehan');
                $awal = $num('saldo_bentuk_awal');
                if (!$awal) $awal = $harga;
                $base += [
                    'deskripsi' => $get('deskripsi'),
                    'lokasi_harta' => $get('lokasi_harta'),
                    'nik_npwp_pihak' => $get('nik_npwp_pihak'),
                    'nama_pihak' => $nama,
                    'merk_tipe' => $nama,
                    'nomor_akun' => $get('nomor_akun'),
                    'harga_perolehan' => $harga,
                    'saldo_bentuk_awal' => $awal,
                    'tahun_perolehan' => $int('tahun_perolehan'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                ];
                $base['kurs'] = $get('kurs');
                break;
            case '04': // HARTA BERGERAK
                $desk = $get('deskripsi');
                $merk = $get('merk_tipe');
                $nama = $get('nama_pihak');
                $base += [
                    'deskripsi' => $desk !== '' ? $desk : $merk,
                    'merk_tipe' => trim($desk . ' ' . $merk),
                    'nopol_sertifikat' => $get('nopol_sertifikat'),
                    'nomor_akun' => $get('nopol_sertifikat'),
                    'kepemilikan' => $get('kepemilikan'),
                    'nik_npwp_pihak' => $get('nik_npwp_pihak'),
                    'nama_pihak' => $nama,
                    'atas_nama' => $nama,
                    'tahun_perolehan' => $int('tahun_perolehan'),
                    'harga_perolehan' => $num('harga_perolehan'),
                    'saldo_bentuk_awal' => $num('harga_perolehan'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                ];
                break;
            case '05': // HARTA TIDAK BERGERAK
                $base += [
                    'deskripsi' => $get('deskripsi'),
                    'lokasi_harta' => $get('lokasi_harta'),
                    'detail_info' => $get('detail_info'),
                    'ukuran_tanah' => $get('ukuran_tanah'),
                    'ukuran_bangunan' => $get('ukuran_bangunan'),
                    'sumber_kepemilikan' => $get('sumber_kepemilikan'),
                    'nopol_sertifikat' => $get('nopol_sertifikat'),
                    'nomor_akun' => $get('nopol_sertifikat'),
                    'tahun_perolehan' => $int('tahun_perolehan'),
                    'harga_perolehan' => $num('harga_perolehan'),
                    'saldo_bentuk_awal' => $num('harga_perolehan'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                ];
                break;
            case '1': // HUTANG
                $nama = $get('nama_pihak');
                $negara = $get('negara_kreditur');
                $desk = $get('deskripsi');
                $base += [
                    'deskripsi' => ($desk !== '' && $desk !== '-') ? $desk : 'HUTANG',
                    'nik_npwp_pihak' => $get('nik_npwp_pihak'),
                    'nama_pihak' => $nama,
                    'atas_nama' => $nama,
                    'negara_kreditur' => $negara,
                    'lokasi_harta' => $negara,
                    'tahun_mulai' => $int('tahun_mulai'),
                    'tahun_perolehan' => $int('tahun_mulai'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                    'detail_info' => $get('detail_info'),
                ];
                break;
            default: // 06-99 HARTA LAINNYA
                $base += [
                    'deskripsi' => $get('deskripsi') !== '' ? $get('deskripsi') : 'HARTA LAINNYA',
                    'tahun_perolehan' => $int('tahun_perolehan'),
                    'nomor_akun' => $get('nomor_akun'),
                    'nopol_sertifikat' => $get('nomor_akun'),
                    'detail_info' => $get('detail_info'),
                    'harga_perolehan' => $num('harga_perolehan'),
                    'saldo_bentuk_awal' => $num('harga_perolehan'),
                    'saldo_saat_ini' => $num('saldo_saat_ini'),
                ];
                break;
        }
        return $base;
    }

    // Header template per sheet — kolom hanya sampai NILAI SAAT INI.
    public static function sheetMeta()
    {
        return [
            '01' => [
                'label' => 'KAS',
                'headers' => ['NO', 'KODE', 'DESKRIPSI', 'NOMOR AKUN', 'ATAS NAMA', 'NAMA BANK/INSTITUSI', 'LOKASI HARTA', 'TAHUN PEROLEHAN', 'NILAI SAAT INI'],
                'widths' => [6, 10, 28, 20, 26, 28, 16, 16, 20],
                'example' => [1, '0102', 'TABUNGAN', '8740120558', 'NAMA WAJIB PAJAK', 'BANK CENTRAL ASIA', 'Indonesia', 2025, 1000000],
            ],
            '02' => [
                'label' => 'PIUTANG',
                'headers' => ['NO', 'KODE', 'DESKRIPSI', 'LOKASI PENERIMA PINJAMAN', 'NIK / NPWP', 'NAMA', 'NILAI PIUTANG', 'TAHUN DIMULAI', 'NILAI PIUTANG SAAT INI'],
                'widths' => [6, 10, 22, 26, 20, 26, 18, 14, 24],
                'example' => [1, '0201', 'PIUTANG USAHA', 'Jakarta', '3173015410840006', 'NAMA PENERIMA', 5000000, 2024, 5000000],
            ],
            '03' => [
                'label' => 'INVESTASI',
                'headers' => ['NO', 'KODE', 'DESKRIPSI', 'LOKASI HARTA', 'NPWP', 'NAMA', 'NOMOR AKUN', 'HARGA PEROLEHAN', 'TAHUN PEROLEHAN', 'NILAI SAAT INI'],
                'widths' => [6, 10, 28, 14, 20, 30, 16, 18, 16, 20],
                'example' => [1, '0311', 'UNIT LINK DI ASURANSI', 'Indonesia', '0012345678900000', 'NAMA INSTITUSI', '12345', 50000000, 2025, 55000000],
            ],
            '04' => [
                'label' => 'HARTA BERGERAK',
                'headers' => ['NO', 'KODE', 'TIPE', 'MERK/MODEL', 'NOMOR POLISI/REGISTRASI', 'KEPEMILIKAN', 'NIK/NPWP', 'NAMA', 'TAHUN PEROLEHAN', 'HARGA PEROLEHAN', 'NILAI SAAT INI'],
                'widths' => [6, 10, 22, 22, 22, 16, 20, 26, 16, 18, 20],
                'example' => [1, '0402', 'SEPEDA MOTOR', 'MERK CONTOH', 'B 1234 ABC', 'TAXPAYER', '3173015410840005', 'NAMA WAJIB PAJAK', 2010, 15000000, 5000000],
            ],
            '05' => [
                'label' => 'HARTA TIDAK BERGERAK',
                'headers' => ['NO', 'KODE', 'DESKRIPSI', 'LOKASI HARTA', 'DETAIL', 'TANAH', 'BANGUNAN', 'SUMBER KEPEMILIKAN', 'NOMOR SERTIFIKAT', 'TAHUN PEROLEHAN', 'HARGA PEROLEHAN', 'NILAI SAAT INI'],
                'widths' => [6, 10, 30, 16, 30, 12, 12, 18, 20, 16, 18, 20],
                'example' => [1, '0502', 'TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL', 'INDONESIA', 'ALAMAT LENGKAP', '86 M2', '66 M2', 'Grant', '123456789', 2012, 78500000, 342530000],
            ],
            '06' => [
                'label' => 'HARTA LAINNYA',
                'headers' => ['NO', 'KODE', 'DESKRIPSI', 'TAHUN PEROLEHAN', 'BUKTI KEPEMILIKAN/NOMOR AKUN', 'INFORMASI TAMBAHAN', 'HARGA PEROLEHAN', 'NILAI SAAT INI'],
                'widths' => [6, 10, 28, 16, 28, 28, 18, 20],
                'example' => [1, '0712', 'PERSEDIAAN USAHA', 2025, '-', 'KETERANGAN', 27500000, 27500000],
            ],
            '1' => [
                'label' => 'HUTANG',
                'headers' => ['NO', 'KODE', 'DESKRIPSI', 'NIK / NPWP', 'NAMA', 'NEGARA KREDITUR', 'TAHUN PEMINJAMAN', 'NILAI SAAT INI', 'KETERANGAN'],
                'widths' => [6, 10, 34, 20, 26, 18, 16, 20, 28],
                'example' => [1, '101', 'UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK', '3173015410840007', 'NAMA KREDITUR', 'Indonesia', 2024, 100000000, 'KETERANGAN'],
            ],
        ];
    }

    // Bangun file template 7 sheet. $masterRows opsional: [['sheet'=>'01','kode'=>'0101','nama'=>'...'],...]
    // untuk sheet referensi MASTER (diabaikan importer karena nama tak dikenali).
    // Client & tahun tidak diminta di template — diisi lewat form sebelum import.
    public static function buildTemplate(array $masterRows = [])
    {
        $spreadsheet = new \PhpOffice\PhpSpreadsheet\Spreadsheet();
        $spreadsheet->removeSheetByIndex(0);
        $headerRow = 2;
        $exampleRow = 3;

        foreach (self::sheetMeta() as $code => $meta) {
            $ws = new \PhpOffice\PhpSpreadsheet\Worksheet\Worksheet($spreadsheet, (string) $code);
            $spreadsheet->addSheet($ws);
            $ws->setCellValue('A1', 'Isi data mulai baris 3, hapus baris contoh sebelum upload. Client dan tahun dipilih di form sebelum import.');
            foreach ($meta['headers'] as $i => $h) {
                $col = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($i + 1);
                $ws->setCellValue($col . $headerRow, $h);
                $ws->getStyle($col . $headerRow)->getFont()->setBold(true);
                if (isset($meta['widths'][$i])) {
                    $ws->getColumnDimension($col)->setWidth($meta['widths'][$i]);
                }
            }
            foreach ($meta['example'] as $i => $v) {
                $col = \PhpOffice\PhpSpreadsheet\Cell\Coordinate::stringFromColumnIndex($i + 1);
                $ws->setCellValue($col . $exampleRow, $v);
            }
        }

        if (!empty($masterRows)) {
            $ws = new \PhpOffice\PhpSpreadsheet\Worksheet\Worksheet($spreadsheet, 'MASTER');
            $spreadsheet->addSheet($ws);
            $ws->setCellValue('A1', 'SHEET');
            $ws->setCellValue('B1', 'KODE');
            $ws->setCellValue('C1', 'NAMA');
            $ws->getStyle('A1:C1')->getFont()->setBold(true);
            $r = 2;
            foreach ($masterRows as $m) {
                $ws->setCellValue('A' . $r, $m['sheet']);
                $ws->setCellValue('B' . $r, $m['kode']);
                $ws->setCellValue('C' . $r, $m['nama']);
                $r++;
            }
            $ws->getColumnDimension('A')->setWidth(10);
            $ws->getColumnDimension('B')->setWidth(12);
            $ws->getColumnDimension('C')->setWidth(60);
        }

        $spreadsheet->setActiveSheetIndex(0);
        return $spreadsheet;
    }
}
