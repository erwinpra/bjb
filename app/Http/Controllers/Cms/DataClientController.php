<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use App\Models\Cms\Badan;
use App\Models\Cms\ClientRole;
use App\Models\Cms\NpwpCabang;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Shuchkin\SimpleXLSX;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class DataClientController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->get('search');
        $query = DataClient::with('badan', 'clientRole')->withCount('cabangs');
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('nama_client', 'like', "%{$search}%")
                  ->orWhere('npwp', 'like', "%{$search}%")
                  ->orWhere('email', 'like', "%{$search}%")
                  ->orWhere('kpp', 'like', "%{$search}%");
            });
        }
        $dataClients = $query->latest()->paginate(15);
        return view('cms::data-client.index', compact('dataClients', 'search'));
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
        $request->merge([
            'npwp' => ltrim($request->npwp ?? '', "'"),
            'npwp_cabang' => ltrim($request->npwp_cabang ?? '', "'"),
        ]);

        $data = $request->validate([
            'nama_client' => 'required|max:255',
            'tipe_badan' => 'nullable',
            'npwp' => 'nullable|digits_between:15,16',
            'npwp_cabang' => 'nullable|digits_between:15,33',
            'kpp' => 'nullable|max:50',
            'alamat_npwp' => 'nullable',
            'alamat_tagihan' => 'nullable',
            'no_telephone' => 'nullable|max:30',
            'email' => 'nullable|email|max:255|unique:cms_data_client,email',
        ]);

        $data['tipe_badan'] = $this->resolveTipeBadan($request->tipe_badan);
        $data['password'] = Hash::make($request->password ?? Str::random(12));

        $client = DataClient::create($data);

        $this->saveCabangs($request, $client);

        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client created.');
    }

    public function show(DataClient $dataClient)
    {
        $dataClient->load('badan', 'clientRole')->loadCount('cabangs');
        $dataClient->load('cabangs');
        return view('cms::data-client.show', compact('dataClient'));
    }

    public function downloadTemplate()
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();

        $headers = ['No', 'KPP', 'Nama', 'NIK', 'NPWP Cabang', 'Email', 'HP', 'Alamat NPWP', 'Alamat Tagihan', 'AR', 'PTKP'];
        foreach ($headers as $i => $header) {
            $col = chr(65 + $i);
            $sheet->setCellValue($col . '1', $header);
            $sheet->getStyle($col . '1')->getFont()->setBold(true);
        }

        $sheet->getColumnDimension('A')->setWidth(5);
        $sheet->getColumnDimension('B')->setWidth(15);
        $sheet->getColumnDimension('C')->setWidth(30);
        $sheet->getColumnDimension('D')->setWidth(20);
        $sheet->getColumnDimension('E')->setWidth(20);
        $sheet->getColumnDimension('F')->setWidth(30);
        $sheet->getColumnDimension('G')->setWidth(20);
        $sheet->getColumnDimension('H')->setWidth(40);
        $sheet->getColumnDimension('I')->setWidth(40);
        $sheet->getColumnDimension('J')->setWidth(15);
        $sheet->getColumnDimension('K')->setWidth(15);

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

        $existingNPs = DataClient::whereNotNull('npwp')->pluck('npwp')->map(function ($v) {
            return strtolower(trim($v));
        })->filter()->values()->toArray();

        $preview = [];
        $newCount = 0;
        $updateCount = 0;
        $cabangCount = 0;
        $invalidNpwp = [];
        $lastPreviewNpwp = null;
        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kpp = isset($row[1]) ? trim((string) $row[1]) : '';
            $nama = isset($row[2]) ? trim((string) $row[2]) : '';
            $npwp = isset($row[3]) ? ltrim(trim((string) $row[3]), "'") : '';
            $npwpCabang = isset($row[4]) ? ltrim(trim((string) $row[4]), "'") : '';

            if (!$nama && !$npwp) continue;

            $npwpKey = $npwp ? strtolower(trim($npwp)) : '';

            $npwpValid = true;
            if ($npwp !== '' && !preg_match('/^\d{15,16}$/', $npwp)) {
                $npwpValid = false;
                $invalidNpwp[] = $nama ?: $npwp;
            }

            $isCabang = $lastPreviewNpwp !== null && $npwpKey === $lastPreviewNpwp && $npwpCabang !== '';
            $exists = !$isCabang && $npwp !== '' && in_array($npwpKey, $existingNPs);

            if ($isCabang) {
                $cabangCount++;
            } elseif ($exists) {
                $updateCount++;
            } else {
                $newCount++;
            }

            $preview[] = [
                'kpp' => $kpp,
                'nama' => $nama,
                'npwp' => $npwp,
                'npwp_cabang' => $npwpCabang ?: '',
                'email' => isset($row[5]) ? trim((string) $row[5]) : '',
                'hp' => isset($row[6]) ? trim((string) $row[6]) : '',
                'alamat_npwp' => isset($row[7]) ? trim((string) $row[7]) : '',
                'alamat_tagihan' => isset($row[8]) ? trim((string) $row[8]) : '',
                'ar' => isset($row[9]) ? trim((string) $row[9]) : '',
                'ptkp' => isset($row[10]) ? trim((string) $row[10]) : '',
                'exists' => $exists,
                'is_cabang' => $isCabang,
                'npwp_valid' => $npwpValid,
            ];

            if (!$isCabang) {
                $lastPreviewNpwp = $npwpKey;
            }
        }

        $badan = Badan::all();

        return view('cms::data-client.import', compact(
            'badan', 'headers', 'totalRows', 'preview', 'newCount', 'updateCount', 'cabangCount', 'tipeBadan', 'tempPath'
        ));

        if (count($invalidNpwp)) {
            @unlink($fullPath);
            return redirect()->route('cms.data-client.import')
                ->with('error', 'NPWP harus 15-16 digit angka. Data berikut memiliki NPWP tidak valid: ' . implode(', ', array_slice($invalidNpwp, 0, 10)));
        }

        $badan = Badan::all();

        return view('cms::data-client.import', compact(
            'badan', 'headers', 'totalRows', 'preview', 'newCount', 'updateCount', 'tipeBadan', 'tempPath'
        ));
    }

    public function confirmImport(Request $request)
    {
        $request->validate([
            'tipe_badan' => 'required',
            'temp_path' => 'required|string',
            'import_mode' => 'required|in:skip,update',
        ]);

        $importMode = $request->import_mode;
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
        $updated = 0;
        $skipped = 0;
        $cabangCreated = 0;
        $errors = [];

        $existingClients = DataClient::whereNotNull('npwp')->get()->keyBy(function ($d) {
            return strtolower(trim($d->npwp));
        });
        $existingEmails = $existingClients->pluck('email')->filter()->map(function ($v) { return strtolower($v); })->toArray();
        $existingNpwps = $existingClients->keys()->toArray();

        $defaultRole = \App\Models\Cms\ClientRole::where('slug', 'client')->first();
        $defaultRoleId = $defaultRole ? $defaultRole->id : null;

        $lastNpwp = null;
        $lastClientId = null;

        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $kpp = isset($row[1]) ? trim((string) $row[1]) : '';
            $nama = isset($row[2]) ? trim((string) $row[2]) : '';
            $npwp = isset($row[3]) ? ltrim(trim((string) $row[3]), "'") : '';
            $npwpCabang = isset($row[4]) ? ltrim(trim((string) $row[4]), "'") : '';

            if (!$nama && !$npwp) continue;

            $npwpKey = $npwp ? strtolower(trim($npwp)) : '';

            if ($lastNpwp !== null && $npwpKey === $lastNpwp && $npwpCabang !== '') {
                $cabangData = [
                    'data_client_id' => $lastClientId,
                    'nama_client' => $nama ?: '-',
                    'tipe_badan' => $tipeBadan,
                    'client_role_id' => $defaultRoleId,
                    'npwp' => $npwpCabang ?: null,
                    'kpp' => $kpp ?: null,
                    'email' => isset($row[5]) ? trim((string) $row[5]) : null,
                    'no_telephone' => isset($row[6]) ? trim((string) $row[6]) : null,
                    'alamat_npwp' => isset($row[7]) ? trim((string) $row[7]) : null,
                    'alamat_tagihan' => isset($row[8]) ? trim((string) $row[8]) : null,
                    'AR' => isset($row[9]) ? trim((string) $row[9]) : null,
                    'ptkp' => isset($row[10]) ? trim((string) $row[10]) : null,
                    'password' => Hash::make(Str::random(12)),
                ];

                if ($cabangData['email'] === '') $cabangData['email'] = null;

                try {
                    $cabang = NpwpCabang::create($cabangData);
                    DataClient::where('id', $lastClientId)->update(['npwp_cabang_id' => $cabang->id]);
                    $cabangCreated++;
                } catch (\Exception $e) {
                    $errors[] = "Baris " . ($r + 1) . " ({$nama} - cabang): " . $e->getMessage();
                }
                continue;
            }

            $email = isset($row[5]) ? trim((string) $row[5]) : '';
            if ($email === '') $email = null;

            $rowData = [
                'nama_client' => $nama ?: '-',
                'tipe_badan' => $tipeBadan,
                'client_role_id' => $defaultRoleId,
                'npwp' => $npwp ?: null,
                'npwp_cabang' => $npwpCabang ?: null,
                'kpp' => $kpp ?: null,
                'email' => $email,
                'no_telephone' => isset($row[6]) ? trim((string) $row[6]) : null,
                'alamat_npwp' => isset($row[7]) ? trim((string) $row[7]) : null,
                'alamat_tagihan' => isset($row[8]) ? trim((string) $row[8]) : null,
                'AR' => isset($row[9]) ? trim((string) $row[9]) : null,
                'ptkp' => isset($row[10]) ? trim((string) $row[10]) : null,
            ];

            if ($npwpKey && isset($existingClients[$npwpKey])) {
                if ($importMode === 'update') {
                    $client = $existingClients[$npwpKey];

                    if ($email && strtolower($email) !== strtolower(trim($client->email ?? ''))) {
                        $dupCheck = DataClient::where('email', $email)->where('id', '!=', $client->id)->exists();
                        if ($dupCheck) {
                            $rowData['email'] = $client->email;
                        }
                    }

                    try {
                        $client->update($rowData);
                        $updated++;
                        $lastClientId = $client->id;
                    } catch (\Exception $e) {
                        $errors[] = "Baris " . ($r + 1) . " ({$nama}): " . $e->getMessage();
                    }
                } else {
                    $skipped++;
                    $lastClientId = $existingClients[$npwpKey]->id;
                }
                $lastNpwp = $npwpKey;
                continue;
            }

            if ($email && in_array(strtolower($email), $existingEmails)) {
                $email = null;
                $rowData['email'] = null;
            }

            $rowData['password'] = Hash::make(Str::random(12));

            try {
                $client = DataClient::create($rowData);
                $imported++;
                $existingNpwps[] = $npwpKey;
                if ($email) $existingEmails[] = strtolower($email);
                $lastClientId = $client->id;
            } catch (\Exception $e) {
                if ($email && str_contains($e->getMessage(), 'email_unique')) {
                    $rowData['email'] = null;
                    try {
                        $client = DataClient::create($rowData);
                        $imported++;
                        $lastClientId = $client->id;
                    } catch (\Exception $e2) {
                        $errors[] = "Baris " . ($r + 1) . " ({$nama}): " . $e2->getMessage();
                        $lastClientId = null;
                    }
                } else {
                    $errors[] = "Baris " . ($r + 1) . " ({$nama}): " . $e->getMessage();
                    $lastClientId = null;
                }
            }

            $lastNpwp = $npwpKey;
        }

        @unlink($fullPath);

        $parts = [];
        if ($imported > 0) $parts[] = "{$imported} data baru ditambahkan";
        if ($updated > 0) $parts[] = "{$updated} data diupdate";
        if ($skipped > 0) $parts[] = "{$skipped} data dilewati";
        if ($cabangCreated > 0) $parts[] = "{$cabangCreated} cabang ditambahkan";
        $message = "Import selesai. " . implode(', ', $parts) . ".";
        if (count($errors)) {
            $message .= " " . count($errors) . " error: " . implode('; ', array_slice($errors, 0, 5));
        }

        return redirect()->route('cms.data-client.index')
            ->with('success', $message);
    }

    public function edit(DataClient $dataClient)
    {
        $dataClient->loadCount('cabangs');
        $dataClient->load('cabangs');
        $badan = Badan::all();
        return view('cms::data-client.edit', compact('dataClient', 'badan'));
    }

    public function update(Request $request, DataClient $dataClient)
    {
        $request->merge([
            'npwp' => ltrim($request->npwp ?? '', "'"),
            'npwp_cabang' => ltrim($request->npwp_cabang ?? '', "'"),
        ]);

        $data = $request->validate([
            'nama_client' => 'required|max:255',
            'tipe_badan' => 'nullable',
            'npwp' => 'nullable|digits_between:15,16',
            'npwp_cabang' => 'nullable|digits_between:15,33',
            'kpp' => 'nullable|max:50',
            'alamat_npwp' => 'nullable',
            'alamat_tagihan' => 'nullable',
            'no_telephone' => 'nullable|max:30',
            'email' => 'nullable|email|max:255|unique:cms_data_client,email,' . $dataClient->id,
        ]);

        $data['tipe_badan'] = $this->resolveTipeBadan($request->tipe_badan);

        if ($request->filled('password')) {
            $data['password'] = Hash::make($request->password);
        }

        $dataClient->update($data);

        $this->saveCabangs($request, $dataClient);

        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client updated.');
    }

    public function destroy(DataClient $dataClient)
    {
        $dataClient->delete();
        return redirect()->route('cms.data-client.index')
            ->with('success', 'Data client deleted.');
    }

    protected function saveCabangs(Request $request, DataClient $client)
    {
        $ids = $request->cabang_id ?? [];
        $names = $request->cabang_nama ?? [];
        $npwps = $request->cabang_npwp ?? [];
        $kpps = $request->cabang_kpp ?? [];
        $emails = $request->cabang_email ?? [];
        $phones = $request->cabang_no_telephone ?? [];
        $ars = $request->cabang_AR ?? [];
        $ptkps = $request->cabang_ptkp ?? [];

        $existingIds = $client->cabangs()->pluck('id')->toArray();
        $submittedIds = [];

        foreach ($names as $i => $name) {
            $name = trim($name);
            if (!$name) continue;

            $cabangId = isset($ids[$i]) && $ids[$i] ? (int) $ids[$i] : null;
            $data = [
                'nama_client' => $name,
                'npwp' => isset($npwps[$i]) ? ltrim(trim($npwps[$i]), "'") : null,
                'kpp' => isset($kpps[$i]) ? trim($kpps[$i]) : null,
                'email' => isset($emails[$i]) ? trim($emails[$i]) : null,
                'no_telephone' => isset($phones[$i]) ? trim($phones[$i]) : null,
                'AR' => isset($ars[$i]) ? trim($ars[$i]) : null,
                'ptkp' => isset($ptkps[$i]) ? trim($ptkps[$i]) : null,
            ];

            if ($cabangId && in_array($cabangId, $existingIds)) {
                NpwpCabang::where('id', $cabangId)->update($data);
                $submittedIds[] = $cabangId;
            } else {
                $data['data_client_id'] = $client->id;
                $data['tipe_badan'] = $client->tipe_badan;
                $data['client_role_id'] = $client->client_role_id;
                $data['alamat_npwp'] = $client->alamat_npwp;
                $data['alamat_tagihan'] = $client->alamat_tagihan;
                $data['password'] = Hash::make(Str::random(12));
                $cabang = NpwpCabang::create($data);
                $submittedIds[] = $cabang->id;
            }
        }

        $toDelete = array_diff($existingIds, $submittedIds);
        if (count($toDelete)) {
            NpwpCabang::whereIn('id', $toDelete)->delete();
        }

        $firstCabang = NpwpCabang::where('data_client_id', $client->id)->first();
        $client->update(['npwp_cabang_id' => $firstCabang ? $firstCabang->id : null]);
    }

    protected function resolveTipeBadan($value)
    {
        if (!$value) return null;

        $badan = Badan::find($value);
        return $badan ? $badan->id : $value;
    }
}
