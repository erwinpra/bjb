<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Shuchkin\SimpleXLSX;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class DataClientController extends Controller
{
    public function index()
    {
        $dataClients = DataClient::with('badan')->latest()->paginate(15);
        return view('cms::data-client.index', compact('dataClients'));
    }

    public function create()
    {
        $badan = Badan::all();
        $generatedPassword = Str::random(12);
        return view('cms::data-client.edit', [
            'dataClient' => null,
            'badan' => $badan,
            'generatedPassword' => $generatedPassword,
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'nama_client' => 'required|max:255',
            'tipe_badan' => 'nullable',
            'npwp' => 'nullable|digits:16',
            'kpp' => 'nullable|max:50',
            'alamat' => 'nullable',
            'no_telephone' => 'nullable|max:30',
            'email' => 'nullable|email|max:255|unique:cms_data_client,email',
        ]);

        $data['tipe_badan'] = $this->resolveTipeBadan($request->tipe_badan);
        $data['password'] = Hash::make($request->password ?? Str::random(12));

        DataClient::create($data);

        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client created.');
    }

    public function downloadTemplate()
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        $headers = ['No', 'KPP', 'Nama', 'NIK', 'Email', 'HP', 'Alamat NPWP', 'AR', 'PTKP'];
        foreach ($headers as $i => $header) {
            $col = chr(65 + $i);
            $sheet->setCellValue($col . '1', $header);
            $sheet->getStyle($col . '1')->getFont()->setBold(true);
        }

        $sheet->getColumnDimension('A')->setWidth(5);
        $sheet->getColumnDimension('B')->setWidth(15);
        $sheet->getColumnDimension('C')->setWidth(30);
        $sheet->getColumnDimension('D')->setWidth(20);
        $sheet->getColumnDimension('E')->setWidth(30);
        $sheet->getColumnDimension('F')->setWidth(20);
        $sheet->getColumnDimension('G')->setWidth(40);
        $sheet->getColumnDimension('H')->setWidth(15);
        $sheet->getColumnDimension('I')->setWidth(15);

        $writer = new Xlsx($spreadsheet);
        $filename = 'Template_Import_Data_Client.xlsx';

        return response()->streamDownload(function () use ($writer) {
            $writer->save('php://output');
        }, $filename, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        ]);
    }

    public function showImport()
    {
        $badan = Badan::all();
        return view('cms::data-client.import', compact('badan'));
    }

    public function previewImport(Request $request)
    {
        $request->validate([
            'tipe_badan' => 'required',
            'file' => 'required|file|mimes:xlsx,xls',
        ]);

        $tipeBadan = $request->tipe_badan;

        $file = $request->file('file');
        $tempPath = $file->store('imports', 'local');
        $fullPath = storage_path('app/' . $tempPath);

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.data-client.import')
                ->with('error', 'Gagal membaca file Excel: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();
        $headers = $rows[0] ?? [];
        $totalRows = max(0, count($rows) - 1);

        if ($totalRows === 0) {
            @unlink($fullPath);
            return redirect()->route('cms.data-client.import')
                ->with('error', 'File Excel kosong.');
        }

        $existing = DataClient::select('kpp', 'nama_client', 'npwp')->get()->map(function ($d) {
            return strtolower(trim((string) $d->kpp)) . '|' . strtolower(trim((string) $d->nama_client)) . '|' . strtolower(trim((string) $d->npwp));
        })->toArray();

        $preview = [];
        $newCount = 0;
        $skipCount = 0;
        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kpp = isset($row[1]) ? trim((string) $row[1]) : '';
            $nama = isset($row[2]) ? trim((string) $row[2]) : '';
            $npwp = isset($row[3]) ? trim((string) $row[3]) : '';

            if (!$nama && !$npwp) continue;

            $key = strtolower($kpp) . '|' . strtolower($nama) . '|' . strtolower($npwp);
            $exists = in_array($key, $existing);

            if ($exists) {
                $skipCount++;
            } else {
                $newCount++;
            }

            $preview[] = [
                'kpp' => $kpp,
                'nama' => $nama,
                'npwp' => $npwp,
                'email' => isset($row[4]) ? trim((string) $row[4]) : '',
                'hp' => isset($row[5]) ? trim((string) $row[5]) : '',
                'alamat' => isset($row[6]) ? trim((string) $row[6]) : '',
                'ar' => isset($row[7]) ? trim((string) $row[7]) : '',
                'ptkp' => isset($row[8]) ? trim((string) $row[8]) : '',
                'exists' => $exists,
            ];

        }

        $badan = Badan::all();

        return view('cms::data-client.import', compact(
            'badan', 'headers', 'totalRows', 'preview', 'newCount', 'skipCount', 'tipeBadan', 'tempPath'
        ));
    }

    public function confirmImport(Request $request)
    {
        $request->validate([
            'tipe_badan' => 'required',
            'temp_path' => 'required|string',
        ]);

        $tipeBadan = $request->tipe_badan;
        $fullPath = storage_path('app/' . $request->temp_path);

        if (!file_exists($fullPath)) {
            return redirect()->route('cms.data-client.import')
                ->with('error', 'File temporary tidak ditemukan. Silakan upload ulang.');
        }

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.data-client.import')
                ->with('error', 'Gagal membaca file Excel: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();
        $imported = 0;
        $skipped = 0;
        $errors = [];

        $existing = DataClient::select('kpp', 'nama_client', 'npwp', 'email')->get();
        $existingKeys = $existing->map(function ($d) {
            return strtolower(trim((string) $d->kpp)) . '|' . strtolower(trim((string) $d->nama_client)) . '|' . strtolower(trim((string) $d->npwp));
        })->toArray();
        $existingEmails = $existing->pluck('email')->filter()->map(function ($v) { return strtolower($v); })->toArray();

        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kpp = isset($row[1]) ? trim((string) $row[1]) : '';
            $nama = isset($row[2]) ? trim((string) $row[2]) : '';
            $npwp = isset($row[3]) ? trim((string) $row[3]) : '';

            if (!$nama && !$npwp) continue;

            $key = strtolower($kpp) . '|' . strtolower($nama) . '|' . strtolower($npwp);
            if (in_array($key, $existingKeys)) {
                $skipped++;
                continue;
            }

            $email = isset($row[4]) ? trim((string) $row[4]) : '';
            if ($email === '') $email = null;

            if ($email && in_array(strtolower($email), $existingEmails)) {
                $email = null;
            }

            $insertData = [
                'nama_client' => $nama ?: '-',
                'tipe_badan' => $tipeBadan,
                'npwp' => $npwp ?: null,
                'kpp' => $kpp ?: null,
                'email' => $email,
                'no_telephone' => isset($row[5]) ? trim((string) $row[5]) : null,
                'alamat' => isset($row[6]) ? trim((string) $row[6]) : null,
                'AR' => isset($row[7]) ? trim((string) $row[7]) : null,
                'ptkp' => isset($row[8]) ? trim((string) $row[8]) : null,
                'password' => Hash::make(Str::random(12)),
            ];

            try {
                DataClient::create($insertData);
                $imported++;
                $existingKeys[] = $key;
                if ($email) $existingEmails[] = strtolower($email);
            } catch (\Exception $e) {
                if ($email && str_contains($e->getMessage(), 'email_unique')) {
                    $insertData['email'] = null;
                    try {
                        DataClient::create($insertData);
                        $imported++;
                        $existingKeys[] = $key;
                    } catch (\Exception $e2) {
                        $errors[] = "Baris " . ($r + 1) . " ({$nama}): " . $e2->getMessage();
                    }
                } else {
                    $errors[] = "Baris " . ($r + 1) . " ({$nama}): " . $e->getMessage();
                }
            }
        }

        @unlink($fullPath);

        $message = "Import selesai. {$imported} data baru ditambahkan, {$skipped} data sudah ada.";
        if (count($errors)) {
            $message .= " " . count($errors) . " error: " . implode('; ', array_slice($errors, 0, 5));
        }

        return redirect()->route('cms.data-client.index')
            ->with('success', $message);
    }

    public function edit(DataClient $dataClient)
    {
        $badan = Badan::all();
        return view('cms::data-client.edit', compact('dataClient', 'badan'));
    }

    public function update(Request $request, DataClient $dataClient)
    {
        $data = $request->validate([
            'nama_client' => 'required|max:255',
            'tipe_badan' => 'nullable',
            'npwp' => 'nullable|digits:16',
            'kpp' => 'nullable|max:50',
            'alamat' => 'nullable',
            'no_telephone' => 'nullable|max:30',
            'email' => 'nullable|email|max:255|unique:cms_data_client,email,' . $dataClient->id,
        ]);

        $data['tipe_badan'] = $this->resolveTipeBadan($request->tipe_badan);

        if ($request->filled('password')) {
            $data['password'] = Hash::make($request->password);
        }

        $dataClient->update($data);

        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client updated.');
    }

    public function destroy(DataClient $dataClient)
    {
        $dataClient->delete();
        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client deleted.');
    }

    protected function resolveTipeBadan($value)
    {
        if (!$value) return null;

        $badan = Badan::find($value);
        return $badan ? $badan->id : $value;
    }
}
