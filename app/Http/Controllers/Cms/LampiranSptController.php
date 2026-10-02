<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\LampiranSptDetail;
use App\Models\Cms\MasterLampiranSpt;
use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\DataClient;
use App\Models\Cms\ActivityLog;
use App\Services\LampiranCortexImporter;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class LampiranSptController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:lampiran_spt,view')->only(['index', 'editMaster']);
        $this->middleware('cms.permission:lampiran_spt,create')->only(['store', 'saveRow', 'downloadTemplate', 'previewImport', 'confirmImport']);
        $this->middleware('cms.permission:lampiran_spt,edit')->only([]);
        $this->middleware('cms.permission:lampiran_spt,delete')->only(['destroyRow', 'destroyAll']);
    }

    public function index(Request $request)
    {
        $clientId = $request->get('client_id');
        $tahun = $request->get('tahun', date('Y'));
        $perPage = $request->get('per_page', 10);

        $clients = DataClient::orderBy('nama_client')->get();
        $currentYear = (int) date('Y');
        $tahunList = range($currentYear, 2025);
        $tahunPerolehanList = range($currentYear, 2025);

        $masterItems = MasterLampiranSpt::orderBy('sub_kode')->get();
        $activeMasterItems = MasterLampiranSpt::where('is_active', true)->orderBy('sub_kode')->get();
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();

        $details = collect();
        $recapGroups = collect();
        $detailsByKategori = collect();
        if ($clientId) {
            $allDetails = LampiranSptDetail::where('client_id', $clientId)
                ->where('tahun', $tahun)
                ->orderBy('id')
                ->get();

            // Backfill kategori_id untuk data lama yang masih null (turunan prefix kode)
            foreach ($allDetails as $d) {
                if (empty($d->kategori_id)) {
                    $d->kategori_id = $this->deriveKategoriId($d->kode);
                }
            }

            $details = LampiranSptDetail::where('client_id', $clientId)
                ->where('tahun', $tahun)
                ->orderBy('id')
                ->paginate($perPage);

            $detailsByKategori = $kategoris->map(function ($kat) use ($allDetails) {
                $items = $allDetails->filter(function ($d) use ($kat) {
                    if (!empty($d->kategori_id)) return (int) $d->kategori_id === (int) $kat->id;
                    return false;
                })->values();
                return [
                    'kategori' => $kat,
                    'items' => $items,
                    'count' => $items->count(),
                    'total' => $items->sum('saldo_saat_ini'),
                ];
            });

            $recapGroups = $kategoris->map(function ($kat) use ($allDetails) {
                $masterSubs = $kat->masterLampiranSpts->sortBy('sub_kode');

                $kodeGroups = $masterSubs->map(function ($ms) use ($allDetails) {
                    $sk = (string) $ms->sub_kode;
                    $items = $allDetails->filter(function ($d) use ($sk) {
                        return (string) $d->kode === $sk;
                    });
                    return [
                        'kode' => $sk,
                        'deskripsi' => $ms->nama,
                        'total_harga' => $items->sum('saldo_saat_ini'),
                        'total_nilai' => $items->sum('saldo_bentuk_awal'),
                    ];
                })->filter(function ($g) {
                    return $g['total_harga'] > 0 || $g['total_nilai'] > 0;
                })->values();

                return [
                    'kategori' => $kat,
                    'kodeGroups' => $kodeGroups,
                    'subHarga' => $kodeGroups->sum('total_harga'),
                    'subNilai' => $kodeGroups->sum('total_nilai'),
                ];
            })->values();
        }

        return view('cms::lampiran-spt.index', compact(
            'clients', 'tahunList', 'tahunPerolehanList', 'clientId', 'tahun',
            'masterItems', 'activeMasterItems', 'kategoris', 'details', 'recapGroups',
            'detailsByKategori', 'perPage'
        ));
    }

    private function deriveKategoriId($kode)
    {
        $kode = trim((string) $kode);
        if ($kode === '' || $kode === '-') return null;
        if (strpos($kode, '01') === 0) return 1;
        if (strpos($kode, '02') === 0) return 2;
        if (strpos($kode, '03') === 0) return 3;
        if (strpos($kode, '04') === 0) return 4;
        if (strpos($kode, '05') === 0) return 5;
        if (preg_match('/^1\d{2}$/', $kode)) return 7;
        return 6; // 06-99 harta lainnya
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

        $allRows = $request->input('rows', []);
        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        foreach ($allRows as $row) {
            $kodeVal = $row['kode'] ?? '';
            if ($kodeVal === '') continue;

            $rowId = $row['row_id'] ?? null;

            $data = [
                'client_id' => $clientId,
                'tahun' => $tahun,
                'kode' => $kodeVal,
                'kategori_id' => $this->deriveKategoriId($kodeVal),
                'sheet_code' => $row['sheet_code'] ?? null,
                'deskripsi' => $masterLookup[$kodeVal] ?? ($row['deskripsi'] ?? ''),
                'nomor_akun' => $row['nomor_akun'] ?? ($row['nopol_sertifikat'] ?? ''),
                'atas_nama' => $row['atas_nama'] ?? ($row['nama_pihak'] ?? ''),
                'nama_bank_institusi' => $row['nama_bank_institusi'] ?? ($row['merk_tipe'] ?? ''),
                'lokasi_harta' => $row['lokasi_harta'] ?? '',
                'kurs' => $row['kurs'] ?? '',
                'tahun_perolehan' => $row['tahun_perolehan'] ?? ($row['tahun_mulai'] ?? null),
                'saldo_saat_ini' => $this->parseNumericValue($row['saldo_saat_ini'] ?? '0'),
                'saldo_bentuk_awal' => $this->parseNumericValue($row['saldo_bentuk_awal'] ?? ($row['harga_perolehan'] ?? '0')),
                'nilai_kurs' => $this->parseNumericValue($row['nilai_kurs'] ?? '0'),
                'harga_perolehan' => $this->parseNumericValue($row['harga_perolehan'] ?? ($row['saldo_bentuk_awal'] ?? '0')),
                'merk_tipe' => $row['merk_tipe'] ?? null,
                'nopol_sertifikat' => $row['nopol_sertifikat'] ?? null,
                'kepemilikan' => $row['kepemilikan'] ?? null,
                'nik_npwp_pihak' => $row['nik_npwp_pihak'] ?? null,
                'nama_pihak' => $row['nama_pihak'] ?? null,
                'negara_kreditur' => $row['negara_kreditur'] ?? null,
                'ukuran_tanah' => $row['ukuran_tanah'] ?? null,
                'ukuran_bangunan' => $row['ukuran_bangunan'] ?? null,
                'sumber_kepemilikan' => $row['sumber_kepemilikan'] ?? null,
                'detail_info' => $row['detail_info'] ?? null,
                'tahun_mulai' => $row['tahun_mulai'] ?? null,
            ];

            if ($rowId) {
                $record = LampiranSptDetail::find($rowId);
                if ($record) {
                    $record->update($data);
                }
            } else {
                LampiranSptDetail::create($data);
            }
        }

        ActivityLog::log('create', 'lampiran_spt', 'Saved Lampiran SPT for client: ' . ($client->nama_client ?? $clientId) . ' tahun: ' . $tahun);
        return response()->json(['success' => true]);
    }

    public function downloadTemplate()
    {
        $katToSheet = [1 => '01', 2 => '02', 3 => '03', 4 => '04', 5 => '05', 6 => '06', 7 => '1'];
        $masterRows = MasterLampiranSpt::where('is_active', true)
            ->orderBy('sub_kode')
            ->get()
            ->map(function ($m) use ($katToSheet) {
                return [
                    'sheet' => $katToSheet[$m->kategori_id] ?? '',
                    'kode' => $m->sub_kode,
                    'nama' => $m->nama,
                ];
            })->toArray();

        $spreadsheet = LampiranCortexImporter::buildTemplate($masterRows);

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

        if (!extension_loaded('zip')) {
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'Ekstensi PHP zip belum aktif di server (ZipArchive not found). Jalankan server dengan PHP yang ada zip-nya, mis. php8.1 artisan serve.');
        }

        $clientId = (int) $request->client_id;
        $tahun = (int) $request->tahun;
        $client = DataClient::find($clientId);

        $file = $request->file('file');
        $filename = $file->hashName();
        $importDir = storage_path('app') . DIRECTORY_SEPARATOR . 'imports';
        if (!is_dir($importDir)) {
            mkdir($importDir, 0755, true);
        }
        $file->move($importDir, $filename);
        $tempPath = 'imports/' . $filename;
        $fullPath = $importDir . DIRECTORY_SEPARATOR . $filename;

        try {
            $parsed = LampiranCortexImporter::parseFile($fullPath);
        } catch (\Exception $e) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'Gagal membaca file: ' . $e->getMessage());
        }
        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        // Lengkapi deskripsi dari master bila kosong, hitung valid
        $grouped = [];
        $validCount = 0;
        $totalRows = 0;
        $totalSkipped = 0;
        foreach ($parsed['sheets'] as $sheetCode => $info) {
            $rows = [];
            foreach ($info['rows'] as $r) {
                if (empty($r['deskripsi']) && isset($masterLookup[$r['kode']])) {
                    $r['deskripsi'] = $masterLookup[$r['kode']];
                }
                $r['valid'] = true;
                $r['errors'] = [];
                $rows[] = $r;
                $validCount++;
                $totalRows++;
            }
            $totalSkipped += $info['skipped_mismatch'] ?? 0;
            $grouped[$sheetCode] = [
                'title' => $info['title'],
                'kategori_id' => $info['kategori_id'],
                'rows' => $rows,
                'skipped_mismatch' => $info['skipped_mismatch'] ?? 0,
            ];
        }

        if ($totalRows === 0) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'Tidak ada data valid. ' . $totalSkipped . ' baris diabaikan karena kode tidak sesuai sheet (mis. kode 02 di sheet 01).');
        }

        // Backward-compat untuk view lama: preview flat
        $preview = [];
        foreach ($grouped as $sheetCode => $g) {
            foreach ($g['rows'] as $r) {
                $preview[] = array_merge(['sheet_code' => $sheetCode], $r);
            }
        }

        $kategoris = KategoriLampiran::orderBy('id')->get()->keyBy('id');
        $skippedSheets = $parsed['skipped_sheets'] ?? [];

        return view('cms::lampiran-spt.import', compact(
            'preview', 'grouped', 'kategoris', 'totalRows', 'validCount', 'totalSkipped', 'tempPath',
            'clientId', 'tahun', 'client', 'skippedSheets'
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
        $fullPath = storage_path('app') . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $request->temp_path);

        if (!file_exists($fullPath)) {
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'File temporary tidak ditemukan. Silakan upload ulang.');
        }

        try {
            $parsed = LampiranCortexImporter::parseFile($fullPath);
        } catch (\Exception $e) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'Gagal membaca file: ' . $e->getMessage());
        }

        // Client & tahun dari form (tidak lagi dibaca dari file).
        // Replace total sesuai permintaan: hapus semua dulu
        LampiranSptDetail::where('client_id', $clientId)
            ->where('tahun', $tahun)
            ->delete();

        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        $imported = 0;
        $skipped = 0;
        $errors = [];

        foreach ($parsed['sheets'] as $sheetCode => $info) {
            $skipped += $info['skipped_mismatch'] ?? 0;
            foreach ($info['rows'] as $r) {
                try {
                    LampiranSptDetail::create([
                        'client_id' => $clientId,
                        'kategori_id' => $info['kategori_id'],
                        'sheet_code' => (string) $sheetCode,
                        'tahun' => $tahun,
                        'kode' => $r['kode'],
                        'deskripsi' => !empty($r['deskripsi']) ? $r['deskripsi'] : ($masterLookup[$r['kode']] ?? ''),
                        'nomor_akun' => $r['nomor_akun'] ?? ($r['nopol_sertifikat'] ?? ''),
                        'atas_nama' => $r['atas_nama'] ?? ($r['nama_pihak'] ?? ''),
                        'nama_bank_institusi' => $r['nama_bank_institusi'] ?? ($r['merk_tipe'] ?? ($r['nama_pihak'] ?? '')),
                        'lokasi_harta' => $r['lokasi_harta'] ?? '',
                        'kurs' => $r['kurs'] ?? '',
                        'tahun_perolehan' => $r['tahun_perolehan'] ?? $r['tahun_mulai'] ?? null,
                        'saldo_saat_ini' => $r['saldo_saat_ini'] ?? 0,
                        'saldo_bentuk_awal' => $r['saldo_bentuk_awal'] ?? 0,
                        'nilai_kurs' => $r['nilai_kurs'] ?? 0,
                        'harga_perolehan' => $r['harga_perolehan'] ?? 0,
                        'merk_tipe' => $r['merk_tipe'] ?? null,
                        'nopol_sertifikat' => $r['nopol_sertifikat'] ?? null,
                        'kepemilikan' => $r['kepemilikan'] ?? null,
                        'nik_npwp_pihak' => $r['nik_npwp_pihak'] ?? null,
                        'nama_pihak' => $r['nama_pihak'] ?? null,
                        'negara_kreditur' => $r['negara_kreditur'] ?? null,
                        'ukuran_tanah' => $r['ukuran_tanah'] ?? null,
                        'ukuran_bangunan' => $r['ukuran_bangunan'] ?? null,
                        'sumber_kepemilikan' => $r['sumber_kepemilikan'] ?? null,
                        'detail_info' => $r['detail_info'] ?? null,
                        'tahun_mulai' => $r['tahun_mulai'] ?? null,
                    ]);
                    $imported++;
                } catch (\Exception $e) {
                    $errors[] = "Sheet {$sheetCode} ({$r['kode']}): " . $e->getMessage();
                }
            }
        }

        @unlink($fullPath);

        $message = "Import selesai. {$imported} data diimport.";
        if ($skipped) $message .= " {$skipped} baris diabaikan (kode tidak sesuai sheet).";
        if (count($errors)) {
            $message .= " " . count($errors) . " error: " . implode('; ', array_slice($errors, 0, 5));
        }

        ActivityLog::log('create', 'lampiran_spt', 'Import Lampiran SPT client: ' . ($client->nama_client ?? $clientId) . ' tahun: ' . $tahun . ' — ' . $imported . ' rows');
        return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
            ->with('success', $message);
    }

    private function parseNumericValue($value): float
    {
        $val = preg_replace('/[^0-9.,]/', '', trim((string) ($value ?? '0')));
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

    public function saveRow(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
            'kode' => 'required|string',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;
        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        $data = [
            'client_id' => $clientId,
            'tahun' => $tahun,
            'kode' => $request->kode,
            'deskripsi' => $masterLookup[$request->kode] ?? ($request->deskripsi ?? ''),
            'nomor_akun' => $request->nomor_akun ?? '',
            'atas_nama' => $request->atas_nama ?? '',
            'nama_bank_institusi' => $request->nama_bank_institusi ?? '',
            'lokasi_harta' => $request->lokasi_harta ?? '',
            'kurs' => $request->kurs ?? '',
            'tahun_perolehan' => $request->tahun_perolehan ?? null,
            'saldo_saat_ini' => $this->parseNumericValue($request->saldo_saat_ini ?? '0'),
            'saldo_bentuk_awal' => $this->parseNumericValue($request->saldo_bentuk_awal ?? '0'),
            'nilai_kurs' => $this->parseNumericValue($request->nilai_kurs ?? '0'),
        ];

        LampiranSptDetail::create($data);

        return response()->json(['success' => true]);
    }

    public function destroyRow($id)
    {
        $record = LampiranSptDetail::find($id);
        if ($record) {
            ActivityLog::log('delete', 'lampiran_spt', 'Deleted row ID: ' . $id . ' client: ' . $record->client_id . ' kode: ' . $record->kode, (string) $id);
            $record->delete();
            return response()->json(['success' => true]);
        }
        return response()->json(['success' => false, 'message' => 'Data tidak ditemukan.'], 404);
    }

    public function destroyAll(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
            'ids' => 'nullable|array',
            'ids.*' => 'integer|exists:cms_lampiran_spt_detail,id',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;

        $query = LampiranSptDetail::where('client_id', $clientId)->where('tahun', $tahun);

        if ($request->filled('ids')) {
            $ids = $request->ids;
            $query->whereIn('id', $ids);
            ActivityLog::log('delete', 'lampiran_spt', 'Deleted ' . count($ids) . ' rows for client: ' . $clientId . ' tahun: ' . $tahun);
        } else {
            ActivityLog::log('delete', 'lampiran_spt', 'Deleted all records for client: ' . $clientId . ' tahun: ' . $tahun);
        }

        $deleted = $query->delete();

        return response()->json(['success' => true, 'deleted' => $deleted]);
    }

    public function editMaster()
    {
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();
        $kategoriLabels = $kategoris->pluck('label', 'label')->toArray();

        return view('cms::lampiran-spt.master', compact('kategoris', 'kategoriLabels'));
    }
}
