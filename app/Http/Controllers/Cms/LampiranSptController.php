<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\LampiranSptDetail;
use App\Models\Cms\MasterLampiranSpt;
use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\DataClient;
use App\Models\Cms\ActivityLog;
use Illuminate\Http\Request;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use Shuchkin\SimpleXLSX;

class LampiranSptController extends Controller
{
    public function __construct()
    {
        $this->middleware('cms.permission:lampiran_spt,view')->only(['index', 'editMaster']);
        $this->middleware('cms.permission:lampiran_spt,create')->only(['store', 'downloadTemplate', 'previewImport', 'confirmImport']);
        $this->middleware('cms.permission:lampiran_spt,edit')->only([]);
        $this->middleware('cms.permission:lampiran_spt,delete')->only(['destroyRow']);
    }

    public function index()
    {
        $clientId = request('client_id');
        $tahun = request('tahun', date('Y'));

        $clients = DataClient::orderBy('nama_client')->get();
        $currentYear = (int) date('Y');
        $tahunList = range($currentYear, 2025);
        $tahunPerolehanList = range($currentYear, 2025);

        $masterItems = MasterLampiranSpt::orderBy('sub_kode')->get();
        $activeMasterItems = MasterLampiranSpt::where('is_active', true)->orderBy('sub_kode')->get();
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();

        $details = collect();
        $recapGroups = collect();
        if ($clientId) {
            $details = LampiranSptDetail::where('client_id', $clientId)
                ->where('tahun', $tahun)
                ->orderBy('id')
                ->get();

            $recapGroups = $kategoris->map(function ($kat) use ($details, $masterItems) {
                $subKodes = $kat->masterLampiranSpts->pluck('sub_kode');
                $katDetails = $details->whereIn('kode', $subKodes->toArray(), true);

                $kodeGroups = $katDetails->groupBy('kode')->map(function ($items, $kode) use ($masterItems) {
                    $master = $masterItems->firstWhere('sub_kode', $kode);
                    return [
                        'kode' => $kode,
                        'deskripsi' => $master ? $master->nama : '-',
                        'total_harga' => $items->sum('saldo_saat_ini'),
                        'total_nilai' => $items->sum('saldo_bentuk_awal'),
                    ];
                })->filter(function ($g) {
                    return $g['total_harga'] > 0 || $g['total_nilai'] > 0;
                })->sortBy('kode')->values();

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
            'masterItems', 'activeMasterItems', 'kategoris', 'details', 'recapGroups'
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

        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        $savedIds = [];

        foreach ($kode as $idx => $val) {
            if (empty($val)) continue;

            $rowId = $request->input('row_id.' . $idx);

            $data = [
                'client_id' => $clientId,
                'tahun' => $tahun,
                'kode' => $val,
                'deskripsi' => $masterLookup[$val] ?? ($deskripsi[$idx] ?? ''),
                'nomor_akun' => $nomorAkun[$idx] ?? '',
                'atas_nama' => $atasNama[$idx] ?? '',
                'nama_bank_institusi' => $bank[$idx] ?? '',
                'lokasi_harta' => $lokasi[$idx] ?? '',
                'kurs' => $kurs[$idx] ?? '',
                'tahun_perolehan' => $tahunPerolehan[$idx] ?? null,
                'saldo_saat_ini' => $this->parseNumericValue($saldoIni[$idx] ?? '0'),
                'saldo_bentuk_awal' => $this->parseNumericValue($saldoAwal[$idx] ?? '0'),
                'nilai_kurs' => $this->parseNumericValue($nilaiKurs[$idx] ?? '0'),
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

        ActivityLog::log('create', 'lampiran_spt', 'Saved Lampiran SPT for client: ' . ($client->nama_client ?? $clientId) . ' tahun: ' . $tahun);
        return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
            ->with('success', 'Data Lampiran SPT berhasil disimpan.');
    }

    public function downloadTemplate()
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        // Row 1: NIK/NPWP
        $sheet->setCellValue('A1', 'NIK/NPWP');
        $sheet->getStyle('A1')->getFont()->setBold(true);
        $sheet->setCellValue('B1', '');
        $sheet->getStyle('A1')->getNumberFormat()->setFormatCode('@');
        $sheet->getStyle('B1')->getNumberFormat()->setFormatCode('@');

        // Row 2: Tahun
        $sheet->setCellValue('A2', 'tahun');
        $sheet->getStyle('A2')->getFont()->setBold(true);
        $sheet->setCellValue('B2', '');

        // Row 3: Header kolom data
        $headers = ['KODE', 'DESKRIPSI', 'NOMOR AKUN', 'ATAS NAMA',
            'NAMA BANK/INSTITUSI', 'LOKASI HARTA', 'KURS',
            'TAHUN PEROLEHAN', 'SALDO SAAT INI', 'SALDO DALAM BENTUK AWAL', 'NILAI KURS'];

        foreach ($headers as $i => $header) {
            $col = chr(65 + $i);
            $sheet->setCellValue($col . '3', $header);
            $sheet->getStyle($col . '3')->getFont()->setBold(true);
        }

        $sheet->getColumnDimension('A')->setWidth(10);
        $sheet->getColumnDimension('B')->setWidth(24);
        $sheet->getColumnDimension('C')->setWidth(20);
        $sheet->getColumnDimension('D')->setWidth(22);
        $sheet->getColumnDimension('E')->setWidth(28);
        $sheet->getColumnDimension('F')->setWidth(18);
        $sheet->getColumnDimension('G')->setWidth(8);
        $sheet->getColumnDimension('H')->setWidth(16);
        $sheet->getColumnDimension('I')->setWidth(20);
        $sheet->getColumnDimension('J')->setWidth(20);
        $sheet->getColumnDimension('K')->setWidth(14);

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
        ]);

        $file = $request->file('file');
        $tempPath = $file->store('imports', 'local');
        $fullPath = storage_path('app/' . $tempPath);

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'Gagal membaca file: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();

        if (count($rows) < 3) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'File tidak valid. Minimal harus ada baris NIK/NPWP, tahun, dan header kolom.');
        }

        // Parse NIK/NPWP from B1 (row 0, col 1)
        $npwpFile = isset($rows[0][1]) ? ltrim(trim((string) $rows[0][1]), "'") : '';

        if (empty($npwpFile)) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'NIK/NPWP belum diisi pada sel B1.');
        }

        // Parse tahun from B2 (row 1, col 1)
        $tahun = isset($rows[1][1]) ? trim((string) $rows[1][1]) : '';

        if (empty($tahun) || !is_numeric($tahun) || (int) $tahun < 2000) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'Tahun tidak valid pada sel B2.');
        }

        $tahun = (int) $tahun;

        // Look up client by NPWP/NIK
        $client = DataClient::where('npwp', $npwpFile)->first();

        if (!$client) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index')
                ->with('error', 'Client dengan NIK/NPWP "' . $npwpFile . '" tidak ditemukan di database.');
        }

        $clientId = $client->id;

        // Build master lookup
        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        // Parse data rows starting from row 4 (0-indexed), skipping header rows
        $preview = [];
        $validCount = 0;

        for ($r = 3; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kode = isset($row[0]) ? trim((string) $row[0]) : '';

            if (empty($kode)) continue;

            $preview[] = [
                'kode' => $kode,
                'deskripsi' => $masterLookup[$kode] ?? '',
                'nomor_akun' => isset($row[2]) ? trim((string) $row[2]) : '',
                'atas_nama' => isset($row[3]) ? trim((string) $row[3]) : '',
                'nama_bank_institusi' => isset($row[4]) ? trim((string) $row[4]) : '',
                'lokasi_harta' => isset($row[5]) ? trim((string) $row[5]) : '',
                'kurs' => isset($row[6]) ? trim((string) $row[6]) : '',
                'tahun_perolehan' => isset($row[7]) ? trim((string) $row[7]) : '',
                'saldo_saat_ini' => isset($row[8]) ? trim((string) $row[8]) : '',
                'saldo_bentuk_awal' => isset($row[9]) ? trim((string) $row[9]) : '',
                'errors' => [],
                'valid' => true,
            ];

            $validCount++;
        }

        $totalRows = $validCount;

        return view('cms::lampiran-spt.import', compact(
            'preview', 'totalRows', 'validCount', 'tempPath',
            'clientId', 'tahun', 'client'
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

        // Re-validate NPWP from file matches the client_id
        $npwpFile = isset($rows[0][1]) ? ltrim(trim((string) $rows[0][1]), "'") : '';
        if ($npwpFile && strtolower($npwpFile) !== strtolower(trim($client->npwp ?? ''))) {
            @unlink($fullPath);
            return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
                ->with('error', 'NIK/NPWP pada file tidak sesuai dengan data client.');
        }

        // Delete existing records and import
        LampiranSptDetail::where('client_id', $clientId)
            ->where('tahun', $tahun)
            ->delete();

        $masterLookup = MasterLampiranSpt::pluck('nama', 'sub_kode');

        $imported = 0;
        $errors = [];

        for ($r = 3; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kode = isset($row[0]) ? trim((string) $row[0]) : '';

            if (empty($kode)) continue;

            try {
                LampiranSptDetail::create([
                    'client_id' => $clientId,
                    'tahun' => $tahun,
                    'kode' => $kode,
                    'deskripsi' => $masterLookup[$kode] ?? '',
                    'nomor_akun' => isset($row[2]) ? trim((string) $row[2]) : '',
                    'atas_nama' => isset($row[3]) ? trim((string) $row[3]) : '',
                    'nama_bank_institusi' => isset($row[4]) ? trim((string) $row[4]) : '',
                    'lokasi_harta' => isset($row[5]) ? trim((string) $row[5]) : '',
                    'kurs' => isset($row[6]) ? trim((string) $row[6]) : '',
                    'tahun_perolehan' => isset($row[7]) ? (int) trim((string) $row[7]) : null,
                    'saldo_saat_ini' => $this->parseNumericValue($row[8] ?? '0'),
                    'saldo_bentuk_awal' => $this->parseNumericValue($row[9] ?? '0'),
                    'nilai_kurs' => $this->parseNumericValue($row[10] ?? '0'),
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

    public function editMaster()
    {
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();
        $kategoriLabels = $kategoris->pluck('label', 'label')->toArray();

        return view('cms::lampiran-spt.master', compact('kategoris', 'kategoriLabels'));
    }
}
