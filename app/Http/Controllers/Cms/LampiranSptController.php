<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\LampiranSptDetail;
use App\Models\Cms\MasterLampiranSpt;
use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\DataClient;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use Shuchkin\SimpleXLSX;

class LampiranSptController extends Controller
{
    public function index()
    {
        $clientId = request('client_id');
        $tahun = request('tahun', date('Y'));

        $clients = DataClient::orderBy('nama_client')->get();
        $currentYear = (int) date('Y');
        $tahunList = range($currentYear, 2025);
        $tahunPerolehanList = range($currentYear, 2025);

        $masterItems = MasterLampiranSpt::orderBy('sub_kode')->get();
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();

        $details = collect();
        if ($clientId) {
            $details = LampiranSptDetail::where('client_id', $clientId)
                ->where('tahun', $tahun)
                ->orderBy('kode')
                ->get();
        }

        return view('cms::lampiran-spt.index', compact(
            'clients', 'tahunList', 'tahunPerolehanList', 'clientId', 'tahun',
            'masterItems', 'kategoris', 'details'
        ));
    }

    public function store(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;
        $client = DataClient::find($clientId);

        $kode = $request->input('kode', []);
        $deskripsi = $request->input('deskripsi', []);
        $nomorAkun = $request->input('nomor_akun', []);
        $atasNama = $request->input('atas_nama', []);
        $bank = $request->input('nama_bank_institusi', []);
        $lokasi = $request->input('lokasi_harta', []);
        $kurs = $request->input('kurs', []);
        $tahunPerolehan = $request->input('tahun_perolehan', []);
        $saldoIni = $request->input('saldo_saat_ini', []);
        $saldoAwal = $request->input('saldo_bentuk_awal', []);
        $nilaiKurs = $request->input('nilai_kurs', []);
        $nikNpwp = $request->input('nik_npwp', []);

        // Validate NIK/NPWP against selected client
        $clientNpwp = $client ? trim($client->npwp ?? '') : '';

        $npwpMismatch = false;
        foreach ($kode as $idx => $val) {
            if (empty($val)) continue;

            $npwpInput = trim($nikNpwp[$idx] ?? '');

            if (empty($clientNpwp)) {
                $npwpMismatch = true;
                break;
            }

            if (empty($npwpInput)) {
                $npwpMismatch = true;
                break;
            }

            if (strtolower($npwpInput) !== strtolower($clientNpwp)) {
                $npwpMismatch = true;
                break;
            }
        }

        if ($npwpMismatch) {
            $errorMsg = empty($clientNpwp)
                ? 'Data gagal disimpan. Client tidak memiliki NIK/NPWP.'
                : 'Data gagal disimpan. NIK/NPWP tidak sesuai dengan client terpilih.';
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', $errorMsg);
        }

        $savedIds = [];

        foreach ($kode as $idx => $val) {
            if (empty($val)) continue;

            $rowId = $request->input('row_id.' . $idx);

            $data = [
                'client_id' => $clientId,
                'tahun' => $tahun,
                'kode' => $val,
                'deskripsi' => $deskripsi[$idx] ?? '',
                'nomor_akun' => $nomorAkun[$idx] ?? '',
                'atas_nama' => $atasNama[$idx] ?? '',
                'nama_bank_institusi' => $bank[$idx] ?? '',
                'lokasi_harta' => $lokasi[$idx] ?? '',
                'kurs' => $kurs[$idx] ?? '',
                'tahun_perolehan' => $tahunPerolehan[$idx] ?? null,
                'saldo_saat_ini' => (float) preg_replace('/[^0-9]/', '', $saldoIni[$idx] ?? '0'),
                'saldo_bentuk_awal' => (float) preg_replace('/[^0-9]/', '', $saldoAwal[$idx] ?? '0'),
                'nilai_kurs' => (float) preg_replace('/[^0-9]/', '', $nilaiKurs[$idx] ?? '0'),
            ];

            if ($rowId) {
                $record = LampiranSptDetail::find($rowId);
                if ($record) {
                    $record->update($data);
                    $savedIds[] = $record->id;
                }
            } else {
                $record = LampiranSptDetail::create($data);
                $savedIds[] = $record->id;
            }
        }

        // Delete removed rows (only if there are saved rows)
        if (!empty($savedIds)) {
            LampiranSptDetail::where('client_id', $clientId)
                ->where('tahun', $tahun)
                ->whereNotIn('id', $savedIds)
                ->delete();
        }

        return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
            ->with('success', 'Data Lampiran SPT berhasil disimpan.');
    }

    public function downloadTemplate()
    {
        $masterItems = MasterLampiranSpt::orderBy('sub_kode')->get();

        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        $headers = [
            'NIK/NPWP', 'KODE', 'DESKRIPSI', 'NOMOR AKUN', 'ATAS NAMA',
            'NAMA BANK/INSTITUSI', 'LOKASI HARTA', 'KURS',
            'TAHUN PEROLEHAN', 'SALDO SAAT INI', 'SALDO DALAM BENTUK AWAL', 'NILAI KURS'
        ];

        foreach ($headers as $i => $header) {
            $col = chr(65 + $i);
            $sheet->setCellValue($col . '1', $header);
            $sheet->getStyle($col . '1')->getFont()->setBold(true);
        }

        $sheet->getColumnDimension('A')->setWidth(20);
        $sheet->getColumnDimension('B')->setWidth(8);
        $sheet->getColumnDimension('C')->setWidth(20);
        $sheet->getColumnDimension('D')->setWidth(18);
        $sheet->getColumnDimension('E')->setWidth(22);
        $sheet->getColumnDimension('F')->setWidth(24);
        $sheet->getColumnDimension('G')->setWidth(16);
        $sheet->getColumnDimension('H')->setWidth(8);
        $sheet->getColumnDimension('I')->setWidth(10);
        $sheet->getColumnDimension('J')->setWidth(18);
        $sheet->getColumnDimension('K')->setWidth(18);
        $sheet->getColumnDimension('L')->setWidth(12);

        // Note row
        $sheet->setCellValue('A2', 'Isi NIK/NPWP client');
        $sheet->getStyle('A2')->getFont()->setItalic(true)->getColor()->setARGB('FF999999');

        $row = 3;
        foreach ($masterItems as $m) {
            $sheet->setCellValue('B' . $row, $m->sub_kode);
            $sheet->setCellValue('C' . $row, $m->nama);
            $sheet->getStyle('J' . $row)->getNumberFormat()->setFormatCode('#,##0');
            $sheet->getStyle('K' . $row)->getNumberFormat()->setFormatCode('#,##0');
            $sheet->getStyle('L' . $row)->getNumberFormat()->setFormatCode('#,##0');
            $row++;
        }

        $writer = new Xlsx($spreadsheet);
        $filename = 'Template_Import_Lampiran_SPT.xlsx';

        return response()->streamDownload(function () use ($writer) {
            $writer->save('php://output');
        }, $filename, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        ]);
    }

    public function previewImport(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:xlsx,xls,csv',
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;
        $client = DataClient::find($clientId);

        $file = $request->file('file');
        $tempPath = $file->store('imports', 'local');
        $fullPath = storage_path('app/' . $tempPath);

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'Gagal membaca file: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();
        $totalRows = max(0, count($rows) - 1);

        if ($totalRows === 0) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'File kosong.');
        }

        $preview = [];
        $validCount = 0;
        $npwpMismatch = false;

        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $npwpFile = isset($row[0]) ? ltrim(trim((string) $row[0]), "'") : '';
            $kode = isset($row[1]) ? trim((string) $row[1]) : '';

            if (empty($kode)) continue;

            $rowErrors = [];
            $valid = true;

            if ($npwpFile && $client && strtolower($npwpFile) !== strtolower(trim($client->npwp ?? ''))) {
                $rowErrors[] = 'NIK/NPWP tidak sesuai dengan client terpilih';
                $valid = false;
                $npwpMismatch = true;
            }

            $preview[] = [
                'kode' => $kode,
                'deskripsi' => isset($row[2]) ? trim((string) $row[2]) : '',
                'nomor_akun' => isset($row[3]) ? trim((string) $row[3]) : '',
                'atas_nama' => isset($row[4]) ? trim((string) $row[4]) : '',
                'nama_bank_institusi' => isset($row[5]) ? trim((string) $row[5]) : '',
                'lokasi_harta' => isset($row[6]) ? trim((string) $row[6]) : '',
                'kurs' => isset($row[7]) ? trim((string) $row[7]) : '',
                'tahun_perolehan' => isset($row[8]) ? trim((string) $row[8]) : '',
                'saldo_saat_ini' => isset($row[9]) ? trim((string) $row[9]) : '0',
                'saldo_bentuk_awal' => isset($row[10]) ? trim((string) $row[10]) : '0',
                'nilai_kurs' => isset($row[11]) ? trim((string) $row[11]) : '0',
                'errors' => $rowErrors,
                'valid' => $valid,
            ];

            if ($valid) $validCount++;
        }

        return view('cms::lampiran-spt.import', compact(
            'preview', 'totalRows', 'validCount', 'tempPath',
            'clientId', 'tahun', 'npwpMismatch'
        ));
    }

    public function confirmImport(Request $request)
    {
        $request->validate([
            'temp_path' => 'required|string',
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;
        $client = DataClient::find($clientId);
        $fullPath = storage_path('app/' . $request->temp_path);

        if (!file_exists($fullPath)) {
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'File temporary tidak ditemukan. Silakan upload ulang.');
        }

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'Gagal membaca file: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();

        // Validate ALL rows first before importing
        $npwpMismatch = false;
        $validationErrors = [];
        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $npwpFile = isset($row[0]) ? ltrim(trim((string) $row[0]), "'") : '';
            $kode = isset($row[1]) ? trim((string) $row[1]) : '';

            if (empty($kode)) continue;

            if ($npwpFile && $client && strtolower($npwpFile) !== strtolower(trim($client->npwp ?? ''))) {
                $npwpMismatch = true;
                $validationErrors[] = "Baris " . ($r + 1) . ": NIK/NPWP tidak sesuai dengan client terpilih";
            }
        }

        if ($npwpMismatch) {
            @unlink($fullPath);
            $msg = "Import dibatalkan. Ditemukan NIK/NPWP tidak sesuai: " . implode('; ', $validationErrors);
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', $msg);
        }

        // Delete existing records and import
        LampiranSptDetail::where('client_id', $clientId)
            ->where('tahun', $tahun)
            ->delete();

        $imported = 0;
        $errors = [];

        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kode = isset($row[1]) ? trim((string) $row[1]) : '';

            if (empty($kode)) continue;

            try {
                LampiranSptDetail::create([
                    'client_id' => $clientId,
                    'tahun' => $tahun,
                    'kode' => $kode,
                    'deskripsi' => isset($row[2]) ? trim((string) $row[2]) : '',
                    'nomor_akun' => isset($row[3]) ? trim((string) $row[3]) : '',
                    'atas_nama' => isset($row[4]) ? trim((string) $row[4]) : '',
                    'nama_bank_institusi' => isset($row[5]) ? trim((string) $row[5]) : '',
                    'lokasi_harta' => isset($row[6]) ? trim((string) $row[6]) : '',
                    'kurs' => isset($row[7]) ? trim((string) $row[7]) : '',
                    'tahun_perolehan' => isset($row[8]) ? (int) trim((string) $row[8]) : null,
                    'saldo_saat_ini' => (float) preg_replace('/[^0-9]/', '', $row[9] ?? '0'),
                    'saldo_bentuk_awal' => (float) preg_replace('/[^0-9]/', '', $row[10] ?? '0'),
                    'nilai_kurs' => (float) preg_replace('/[^0-9]/', '', $row[11] ?? '0'),
                ]);
                $imported++;
            } catch (\Exception $e) {
                $errors[] = "Baris " . ($r + 1) . " ({$kode}): " . $e->getMessage();
            }
        }

        @unlink($fullPath);

        $message = "Import selesai. {$imported} data diimport.";
        if (count($errors)) {
            $message .= " " . count($errors) . " error: " . implode('; ', array_slice($errors, 0, 5));
        }

        return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
            ->with('success', $message);
    }

    public function destroyRow($id)
    {
        $record = LampiranSptDetail::find($id);
        if ($record) {
            $record->delete();
            return response()->json(['success' => true]);
        }
        return response()->json(['success' => false, 'message' => 'Data tidak ditemukan.'], 404);
    }

    public function editMaster()
    {
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();
        $kategoriLabels = $kategoris->pluck('label', 'label')->toArray();

        return view('cms::lampiran-spt.master', compact('kategoris', 'kategoriLabels'));
    }
}
