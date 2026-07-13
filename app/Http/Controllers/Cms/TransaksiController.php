<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use App\Models\Cms\MasterRumus;
use App\Models\Cms\Transaksi;
use App\Models\Cms\TransaksiHarta;
use App\Models\Cms\TransaksiOmset;
use App\Models\Cms\Badan;
use App\Models\Cms\NpwpCabang;
use App\Models\Cms\LampiranSpt;
use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\MasterLampiranSpt;
use Illuminate\Http\Request;
use PDF;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;
use Shuchkin\SimpleXLSX;

class TransaksiController extends Controller
{
    public function create()
    {
        $clients = DataClient::all();
        $cabangs = NpwpCabang::select(['id', 'data_client_id', 'nama_client', 'npwp', 'kpp', 'email', 'no_telephone', 'alamat_npwp', 'alamat_tagihan', 'AR', 'ptkp'])
            ->whereIn('data_client_id', $clients->pluck('id'))
            ->get()
            ->groupBy('data_client_id')
            ->toArray();
        $rumus = MasterRumus::all();
        $badan = Badan::all();
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();
        return view('cms::transaksi.form', compact('clients', 'rumus', 'badan', 'cabangs', 'kategoris'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000|max:2100',
            'harta_nama' => 'nullable|array',
            'harta_nilai' => 'nullable|array',
            'total_omset' => 'nullable|string',
            'total_pph' => 'nullable|string',
            'induk' => 'nullable|array',
            'induk.omset_tahunan' => 'nullable|string',
            'induk.omset_bulanan' => 'nullable|array',
        ]);

        // Dynamic validation for cabang_* fields
        foreach ($request->all() as $key => $val) {
            if (strpos($key, 'cabang_') === 0) {
                $request->validate([
                    $key => 'nullable|array',
                    $key . '.npwp_cabang_id' => 'nullable|exists:cms_npwp_cabang,id',
                    $key . '.omset_tahunan' => 'nullable|string',
                    $key . '.omset_bulanan' => 'nullable|array',
                ]);
            }
        }

        $client = DataClient::findOrFail($request->client_id);
        $tipeBadanId = $client->tipe_badan;

        $badanEntry = Badan::find($tipeBadanId);
        $isId1 = $badanEntry && $badanEntry->id === 1;
        $rumus = MasterRumus::where('tipe_badan', $tipeBadanId)->first();
        $persen = $rumus ? (float) $rumus->potongan_persentase : 0;

        // Delete all existing transaksi (plus cascade omset/harta) for this client+tahun
        $existingIds = Transaksi::where('client_id', $request->client_id)
            ->where('tahun', $request->tahun)
            ->pluck('id');
        if ($existingIds->isNotEmpty()) {
            TransaksiOmset::whereIn('transaksi_id', $existingIds)->delete();
            TransaksiHarta::whereIn('transaksi_id', $existingIds)->delete();
            Transaksi::whereIn('id', $existingIds)->delete();
        }

        $totalOmset = 0;
        $totalHarta = 0;
        $totalPph = 0;

        $tabs = ['induk'];
        foreach (array_keys($request->all()) as $key) {
            if (strpos($key, 'cabang_') === 0) $tabs[] = $key;
        }

        $indukTransaksi = null;

        foreach ($tabs as $tab) {
            $tabData = $tab === 'induk' ? ($request->input('induk') ?? []) : ($request->input($tab) ?? []);
            $npwpCabangId = $tab === 'induk' ? null : ($tabData['npwp_cabang_id'] ?? null);

            $transaksi = Transaksi::create([
                'client_id' => $request->client_id,
                'npwp_cabang_id' => $npwpCabangId,
                'tahun' => $request->tahun,
                'tipe_badan_id' => $tipeBadanId,
                'total_omset' => 0,
                'total_harta' => 0,
                'total_pph' => 0,
            ]);

            if ($tab === 'induk') {
                $indukTransaksi = $transaksi;
            }

            $tabOmset = 0;
            if ($isId1) {
                $omset = (float) preg_replace('/[^0-9]/', '', $tabData['omset_tahunan'] ?? '0');
                $tabOmset = $omset;
                if ($omset > 0) {
                    TransaksiOmset::create([
                        'transaksi_id' => $transaksi->id,
                        'bulan' => 0,
                        'nominal' => $omset,
                    ]);
                }
            } else {
                $omsetData = $tabData['omset_bulanan'] ?? [];
                foreach ($omsetData as $mo => $val) {
                    $nominal = (float) preg_replace('/[^0-9]/', '', $val ?? '0');
                    if ($nominal > 0) {
                        TransaksiOmset::create([
                            'transaksi_id' => $transaksi->id,
                            'bulan' => (int) $mo,
                            'nominal' => $nominal,
                        ]);
                    }
                    $tabOmset += $nominal;
                }
            }

            $transaksi->update(['total_omset' => $tabOmset]);
            $totalOmset += $tabOmset;
        }

        // Harta only for induk transaksi
        if ($indukTransaksi && $request->harta_nama) {
            foreach ($request->harta_nama as $i => $nama) {
                if (!$nama) continue;
                $nilai = isset($request->harta_nilai[$i]) ? (float) preg_replace('/[^0-9]/', '', $request->harta_nilai[$i]) : 0;
                TransaksiHarta::create([
                    'transaksi_id' => $indukTransaksi->id,
                    'nama' => $nama,
                    'nilai' => $nilai,
                ]);
                $totalHarta += $nilai;
            }
            $indukTransaksi->update(['total_harta' => $totalHarta]);
        }

        $totalPph = $totalOmset * $persen / 100;

        return redirect()->route('cms.transaksi.index')
            ->with('success', 'Transaksi berhasil disimpan.');
    }

    public function checkHarta(Request $request)
    {
        $clientId = $request->client_id;
        $tahun = $request->tahun;

        $client = DataClient::find($clientId);
        $tabs = [];

        // Induk
        $indukItems = LampiranSpt::where('client_id', $clientId)
            ->where('tahun', $tahun)
            ->whereNull('npwp_cabang_id')
            ->get();
        $indukValues = [];
        foreach ($indukItems as $item) {
            $indukValues[$item->lampiran_spt_id] = $item->nilai;
        }
        $tabs['induk'] = [
            'npwp' => $client ? ($client->npwp ?? '-') : '-',
            'has_harta' => $indukItems->where('nilai', '>', 0)->count() > 0,
            'values' => $indukValues,
        ];

        // Cabangs
        $cabangs = NpwpCabang::where('data_client_id', $clientId)->get();
        foreach ($cabangs as $cabang) {
            $key = 'cabang_' . $cabang->id;
            $items = LampiranSpt::where('client_id', $clientId)
                ->where('tahun', $tahun)
                ->where('npwp_cabang_id', $cabang->id)
                ->get();
            $values = [];
            foreach ($items as $item) {
                $values[$item->lampiran_spt_id] = $item->nilai;
            }
            $tabs[$key] = [
                'npwp' => $cabang->npwp ?? '-',
                'has_harta' => $items->where('nilai', '>', 0)->count() > 0,
                'values' => $values,
            ];
        }

        $allHaveHarta = collect($tabs)->every(function ($t) {
            return $t['has_harta'];
        });

        return response()->json(['has_harta' => $allHaveHarta, 'tabs' => $tabs]);
    }

    public function saveHartaAjax(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
            'nilai' => 'required|array',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;

        foreach ($request->nilai as $key => $values) {
            $npwpCabangId = $key === 'induk' ? null : (int) str_replace('cabang_', '', $key);

            if (!is_array($values)) continue;

            foreach ($values as $lampiranSptId => $nilai) {
                $lampiranSptId = (int) $lampiranSptId;
                $nilaiClean = (float) preg_replace('/[^0-9]/', '', $nilai ?? '0');

                $master = MasterLampiranSpt::find($lampiranSptId);
                if (!$master) continue;

                if ($nilaiClean > 0) {
                    LampiranSpt::updateOrCreate(
                        [
                            'client_id' => $clientId,
                            'tahun' => $tahun,
                            'lampiran_spt_id' => $lampiranSptId,
                            'npwp_cabang_id' => $npwpCabangId,
                        ],
                        ['nilai' => $nilaiClean]
                    );
                } else {
                    LampiranSpt::where('client_id', $clientId)
                        ->where('tahun', $tahun)
                        ->where('lampiran_spt_id', $lampiranSptId)
                        ->where('npwp_cabang_id', $npwpCabangId)
                        ->delete();
                }
            }
        }

        return response()->json(['success' => true]);
    }

    public function loadData(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer',
        ]);

        // Load induk transaksi
        $indukTransaksi = Transaksi::where('client_id', $request->client_id)
            ->where('tahun', $request->tahun)
            ->whereNull('npwp_cabang_id')
            ->with(['harta', 'omset'])
            ->latest('id')
            ->first();

        // Load cabang transaksi
        $cabangTransaksi = Transaksi::where('client_id', $request->client_id)
            ->where('tahun', $request->tahun)
            ->whereNotNull('npwp_cabang_id')
            ->with(['omset'])
            ->get();

        if (!$indukTransaksi && $cabangTransaksi->isEmpty()) {
            return response()->json(['exists' => false]);
        }

        $cabangs = [];
        foreach ($cabangTransaksi as $ct) {
            $cabangs[] = [
                'npwp_cabang_id' => $ct->npwp_cabang_id,
                'omset' => $ct->omset,
            ];
        }

        return response()->json([
            'exists' => true,
            'transaksi' => $indukTransaksi,
            'harta' => $indukTransaksi ? $indukTransaksi->harta : [],
            'omset' => $indukTransaksi ? $indukTransaksi->omset : [],
            'cabangs' => $cabangs,
        ]);
    }

    public function preview(Request $request)
    {
        $data = $request->all();
        $client = DataClient::find($request->client_id);
        return view('cms::transaksi.preview', compact('data', 'client'));
    }

    public function exportPdf(Request $request)
    {
        $this->validateExport($request);

        $client = DataClient::findOrFail($request->client_id);
        $result = $this->buildExportData($request, $client);

        $pdf = PDF::loadView('cms::transaksi.export-pdf', $result);
        return $pdf->download('transaksi_' . $client->nama_client . '_' . $request->tahun . '.pdf');
    }

    public function exportExcel(Request $request)
    {
        $this->validateExport($request);

        $client = DataClient::findOrFail($request->client_id);
        $result = $this->buildExportData($request, $client);

        $filename = 'transaksi_' . $client->nama_client . '_' . $request->tahun . '.csv';

        $handle = fopen('php://temp', 'r+');

        // Header CSV
        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
        fputcsv($handle, ['Laporan Transaksi', $client->nama_client, 'Tahun', $request->tahun]);
        fputcsv($handle, []);

        if (!empty($result['harta'])) {
            fputcsv($handle, ['Daftar ' . $result['hartaLabel']]);
            fputcsv($handle, ['Nama', 'Nilai']);
            foreach ($result['harta'] as $h) {
                fputcsv($handle, [$h['nama'], number_format($h['nilai'], 0, ',', '.')]);
            }
            fputcsv($handle, ['Total', number_format(collect($result['harta'])->sum('nilai'), 0, ',', '.')]);
            fputcsv($handle, []);
        }

        foreach ($result['allTabs'] as $tab) {
            if ($tab['label'] !== 'Induk') {
                fputcsv($handle, ['Cabang: ' . $tab['label']]);
            }
            if ($result['isId1']) {
                fputcsv($handle, ['Tahunan', number_format($tab['total_omset'], 0, ',', '.')]);
            } else {
                $akumColLabel = 'Total Peredaran Bruto Akum (' . $result['cabangCount'] . ' Cabang)';
                $akumCols = [$akumColLabel];
                fputcsv($handle, array_merge(['Bulan', 'Peredaran Bruto', 'Total Peredaran Bruto Cabang'], $akumCols, ['PPH Final ' . number_format($result['persen'], 1) . '%', 'PPh Final yg harus dibayar']));
                foreach ($tab['detail_bulan'] as $row) {
                    if ($row['omset'] !== '') {
                        $rowData = [$row['bulan'], $row['omset'], $row['totalBruto']];
                        $rowData[] = $row['totalBrutoAkum'];
                        $rowData[] = $row['pphFinal'];
                        $rowData[] = $row['pphBayar'];
                        fputcsv($handle, $rowData);
                    }
                }
                $totalRow = ['Total', number_format($tab['total_omset'], 0, ',', '.'), ''];
                $totalRow[] = '';
                $totalRow[] = '';
                $totalRow[] = number_format($tab['total_potongan'], 0, ',', '.');
                fputcsv($handle, $totalRow);
            }
            fputcsv($handle, []);
        }

        fputcsv($handle, ['Total ' . $result['hartaLabel'], number_format($result['totalHarta'], 0, ',', '.')]);
        fputcsv($handle, ['Total Omset', number_format($result['grandTotalOmset'], 0, ',', '.')]);
        if (!$result['isId1']) {
            fputcsv($handle, ['Total PPh Final yg harus dibayar', number_format($result['grandTotalPotongan'], 0, ',', '.')]);
        }

        rewind($handle);
        $content = stream_get_contents($handle);
        fclose($handle);

        return response($content, 200, [
            'Content-Type' => 'text/csv; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    protected function validateExport(Request $request)
    {
        $rules = [
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer',
            'harta_nama' => 'nullable|array',
            'harta_nilai' => 'nullable|array',
            'induk' => 'nullable|array',
        ];
        foreach ($request->all() as $key => $val) {
            if (strpos($key, 'cabang_') === 0) {
                $rules[$key] = 'nullable|array';
            }
        }
        $request->validate($rules);
    }

    protected function buildExportData(Request $request, $client)
    {
        $tipeBadanId = $client->tipe_badan;
        $badanEntry = Badan::find($tipeBadanId);
        $isId1 = $badanEntry && $badanEntry->id === 1;
        $hartaLabel = $isId1 ? 'Inventaris' : 'Harta';
        $tipeName = $badanEntry ? $badanEntry->tipe : '-';

        $rumus = MasterRumus::where('tipe_badan', $tipeBadanId)->first();
        $persen = $rumus ? (float) $rumus->potongan_persentase : 0;
        $maxVal = $rumus ? (float) $rumus->max_value : 0;

        // Harta
        $harta = [];
        $totalHarta = 0;
        if ($request->harta_nama) {
            foreach ($request->harta_nama as $i => $nama) {
                if (!$nama) continue;
                $nilai = isset($request->harta_nilai[$i]) ? (float) preg_replace('/[^0-9]/', '', $request->harta_nilai[$i]) : 0;
                $harta[] = ['nama' => $nama, 'nilai' => $nilai];
                $totalHarta += $nilai;
            }
        }

        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

        // Discover all tabs (induk + cabang)
        $tabs = ['induk'];
        foreach (array_keys($request->all()) as $key) {
            if (strpos($key, 'cabang_') === 0) $tabs[] = $key;
        }

        $allTabs = [];
        $grandTotalOmset = 0;
        $grandTotalPotongan = 0;
        $detailBulanInduk = [];
        $totalPotonganInduk = 0;
        $totalOmset = 0;
        $firstTab = true;

        foreach ($tabs as $tab) {
            $tabData = $tab === 'induk' ? ($request->input('induk') ?? []) : ($request->input($tab) ?? []);
            $npwpCabangId = $tab === 'induk' ? null : ($tabData['npwp_cabang_id'] ?? null);

            // Look up label, npwp, kpp
            $label = 'Induk';
            $npwp = '';
            $kpp = '';
            if ($tab === 'induk') {
                $label = $client->nama_client;
                $npwp = $client->npwp ?? '';
                $kpp = $client->kpp ?? '';
            } elseif ($npwpCabangId) {
                $cabangRecord = \App\Models\Cms\NpwpCabang::find($npwpCabangId);
                if ($cabangRecord) {
                    $label = $cabangRecord->nama_client;
                    $npwp = $cabangRecord->npwp ?? '';
                    $kpp = $cabangRecord->kpp ?? '';
                }
            }

            $tabOmset = 0;
            $detailBulan = [];
            $totalPotongan = 0;
            $cumulative = 0;

            if ($isId1) {
                $tabOmset = (float) preg_replace('/[^0-9]/', '', $tabData['omset_tahunan'] ?? '0');
            } else {
                $omsetData = $tabData['omset_bulanan'] ?? [];
                for ($mo = 1; $mo <= 12; $mo++) {
                    $nominal = isset($omsetData[$mo]) ? (float) preg_replace('/[^0-9]/', '', $omsetData[$mo]) : 0;
                    $tabOmset += $nominal;
                    $totalWithCurrent = $cumulative + $nominal;

                    $pphFinal = $nominal < 500 ? 'Free' : 'Rp ' . number_format($nominal * $persen / 100, 0, ',', '.');

                    $pphBayar = '';
                    if ($cumulative >= $maxVal) {
                        $potongan = $nominal * $persen / 100;
                        $totalPotongan += $potongan;
                        $pphBayar = 'Rp ' . number_format($potongan, 0, ',', '.');
                    } elseif ($totalWithCurrent > $maxVal) {
                        $kelebihan = $totalWithCurrent - $maxVal;
                        $potongan = $kelebihan * $persen / 100;
                        $totalPotongan += $potongan;
                        $pphBayar = 'Rp ' . number_format($potongan, 0, ',', '.');
                    } else {
                        $pphBayar = 'Free';
                    }

                    $detailBulan[] = [
                        'bulan' => $bulanLabels[$mo - 1],
                        'omset' => $nominal > 0 ? 'Rp ' . number_format($nominal, 0, ',', '.') : '',
                        'totalBruto' => $nominal > 0 ? 'Rp ' . number_format($totalWithCurrent, 0, ',', '.') : '',
                        'pphFinal' => $nominal > 0 ? $pphFinal : '',
                        'pphBayar' => $nominal > 0 ? $pphBayar : '',
                    ];

                    $cumulative += $nominal;
                }

                // Fill remaining months with empty data
                while (count($detailBulan) < 12) {
                    $detailBulan[] = [
                        'bulan' => $bulanLabels[count($detailBulan)],
                        'omset' => '', 'totalBruto' => '', 'pphFinal' => '', 'pphBayar' => '',
                    ];
                }
            }

            // For first tab (induk), keep backward-compat vars
            if ($firstTab) {
                $totalOmset = $tabOmset;
                $detailBulanInduk = $detailBulan;
                $totalPotonganInduk = $totalPotongan;
                $firstTab = false;
            }

            $allTabs[] = [
                'key' => $tab,
                'label' => $label,
                'npwp' => $npwp,
                'kpp' => $kpp,
                'total_omset' => $tabOmset,
                'total_potongan' => $totalPotongan,
                'detail_bulan' => $detailBulan,
            ];

            $grandTotalOmset += $tabOmset;
            $grandTotalPotongan += $totalPotongan;
        }

        // Sort cabang tabs by NPWP last 3 digits for cascading akum
        $cabangTabs = [];
        foreach ($tabs as $tab) {
            if ($tab !== 'induk') $cabangTabs[] = $tab;
        }
        $tabNpwpMap = [];
        foreach ($allTabs as $at) {
            $tabNpwpMap[$at['key']] = $at['npwp'] ?? '';
        }
        usort($cabangTabs, function ($a, $b) use ($tabNpwpMap) {
            return substr($tabNpwpMap[$a] ?? '', -3) <=> substr($tabNpwpMap[$b] ?? '', -3);
        });
        $cabangCount = count($cabangTabs);

        // Compute cascading akum per month per tab
        $akumCache = [];
        for ($mo = 1; $mo <= 12; $mo++) {
            if ($cabangCount === 0) {
                $akumCache['induk'][$mo] = 0;
            } else {
                $pusatInput = $request->input('induk') ?? [];
                $pusatPB = $isId1
                    ? (float) preg_replace('/[^0-9]/', '', $pusatInput['omset_tahunan'] ?? '0')
                    : (float) preg_replace('/[^0-9]/', '', $pusatInput['omset_bulanan'][$mo] ?? '0');

                if ($mo === 1) {
                    $akumCache['induk'][$mo] = $pusatPB;
                } else {
                    $lastCp = $cabangTabs[$cabangCount - 1];
                    $prevLast = $akumCache[$lastCp][$mo - 1] ?? 0;
                    $akumCache['induk'][$mo] = $pusatPB + $prevLast;
                }

                $prevAkum = $akumCache['induk'][$mo];
                foreach ($cabangTabs as $cp) {
                    $cabangInput = $request->input($cp) ?? [];
                    $cabangPB = $isId1
                        ? (float) preg_replace('/[^0-9]/', '', $cabangInput['omset_tahunan'] ?? '0')
                        : (float) preg_replace('/[^0-9]/', '', $cabangInput['omset_bulanan'][$mo] ?? '0');
                    $akumCache[$cp][$mo] = $cabangPB + $prevAkum;
                    $prevAkum = $akumCache[$cp][$mo];
                }
            }
        }

        // Assign akum to each tab's detail_bulan
        foreach ($allTabs as &$at) {
            $key = $at['key'];
            foreach ($at['detail_bulan'] as &$db) {
                $moIdx = array_search($db['bulan'], $bulanLabels);
                if ($moIdx !== false) {
                    $mo = $moIdx + 1;
                    $akumVal = $akumCache[$key][$mo] ?? 0;
                    $db['totalBrutoAkum'] = $akumVal > 0 ? 'Rp ' . number_format($akumVal, 0, ',', '.') : '';
                } else {
                    $db['totalBrutoAkum'] = '';
                }
            }
        }
        unset($at, $db);

        // For backward compat with existing views
        $detailBulan = $detailBulanInduk ?? [];

        $cabangCount = count($tabs) - 1;

        return [
            'client' => $client,
            'isId1' => $isId1,
            'hartaLabel' => $hartaLabel,
            'tipeName' => $tipeName,
            'harta' => $harta,
            'totalHarta' => $totalHarta,
            'totalOmset' => $totalOmset,
            'totalPotongan' => $totalPotonganInduk,
            'detailBulan' => $detailBulan,
            'bulanLabels' => $bulanLabels,
            'persen' => $persen,
            'allTabs' => $allTabs,
            'grandTotalOmset' => $grandTotalOmset,
            'grandTotalPotongan' => $grandTotalPotongan,
            'cabangCount' => $cabangCount,
        ];
    }

    public function getCabangs(DataClient $client)
    {
        $cabangs = NpwpCabang::where('data_client_id', $client->id)->get(['id', 'nama_client', 'npwp', 'kpp', 'email', 'no_telephone', 'alamat_npwp', 'alamat_tagihan', 'AR', 'ptkp']);
        return response()->json($cabangs);
    }

    public function downloadTemplate()
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
        $sheet->setTitle('Template');

        $months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
        $headers = ['No', 'NPWP Client', 'NPWP Cabang', 'Tahun'];
        foreach ($months as $m) {
            $headers[] = 'Omset ' . $m;
        }

        // Header row
        $headerStyle = $sheet->getStyle('A1:' . chr(65 + count($headers) - 1) . '1');
        $headerStyle->getFont()->setBold(true)->setColor(new \PhpOffice\PhpSpreadsheet\Style\Color('FFFFFF'));
        $headerStyle->getFill()->setFillType(\PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID)->getStartColor()->setARGB('FF4472C4');
        $headerStyle->getAlignment()->setHorizontal(\PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER);
        $headerStyle->getBorders()->applyFromArray(['allBorders' => ['style' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN]]);

        foreach ($headers as $i => $header) {
            $col = chr(65 + $i);
            $sheet->setCellValue($col . '1', $header);
        }

        // Column widths
        $sheet->getColumnDimension('A')->setWidth(5);
        $sheet->getColumnDimension('B')->setWidth(24);
        $sheet->getColumnDimension('C')->setWidth(24);
        $sheet->getColumnDimension('D')->setWidth(8);
        for ($i = 0; $i < 12; $i++) {
            $sheet->getColumnDimension(chr(69 + $i))->setWidth(15);
        }

        // --- Instructions ---
        $sheet->setCellValue('A3', 'INSTRUKSI:');
        $sheet->getStyle('A3')->getFont()->setBold(true)->setSize(11);
        $sheet->setCellValue('A4', 'Isi data mulai dari baris 5. Kolom B = NPWP Client, C = NPWP Cabang (kosongkan jika induk), D = Tahun, E-P = Omset Jan-Des.');
        $sheet->getStyle('A4')->getFont()->setColor(new \PhpOffice\PhpSpreadsheet\Style\Color('FF555555'))->setSize(9);

        $writer = new Xlsx($spreadsheet);
        $filename = 'Template_Import_Transaksi.xlsx';

        return response()->streamDownload(function () use ($writer) {
            $writer->save('php://output');
        }, $filename, [
            'Content-Type' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        ]);
    }

    public function showImport()
    {
        return view('cms::transaksi.import');
    }

    public function previewImport(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:xlsx,xls',
        ]);

        $file = $request->file('file');
        $tempPath = $file->store('imports', 'local');
        $fullPath = storage_path('app/' . $tempPath);

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'Gagal membaca file Excel: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();

        $months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

        $dataRows = [];
        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $npwpClient = isset($row[1]) ? ltrim(trim((string) $row[1]), "'") : '';
            if ($npwpClient === '') continue;
            $dataRows[] = $row;
        }

        if (empty($dataRows)) {
            @unlink($fullPath);
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'Tidak ada data valid. Pastikan kolom NPWP Client terisi.');
        }

        $npwpList = [];
        foreach ($dataRows as $row) {
            $npwpClient = isset($row[1]) ? ltrim(trim((string) $row[1]), "'") : '';
            if ($npwpClient) $npwpList[] = $npwpClient;
        }
        $npwpList = array_unique($npwpList);
        $existingNpwps = DataClient::whereNotNull('npwp')->pluck('npwp')->map(function ($v) { return strtolower(trim($v)); })->filter()->values()->toArray();
        $missingNpwps = [];
        foreach ($npwpList as $np) {
            $cleanNp = strtolower(ltrim(trim($np), "'"));
            if (!in_array($cleanNp, $existingNpwps)) {
                $missingNpwps[] = $np;
            }
        }
        if (!empty($missingNpwps)) {
            @unlink($fullPath);
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'Import dibatalkan. Data NPWP tidak tersedia: ' . implode(', ', array_slice($missingNpwps, 0, 10)));
        }

        $preview = [];

        foreach ($dataRows as $row) {
            $npwpClient = isset($row[1]) ? ltrim(trim((string) $row[1]), "'") : '';
            $npwpCabang = isset($row[2]) ? ltrim(trim((string) $row[2]), "'") : '';
            $tahun = isset($row[3]) ? trim((string) $row[3]) : '';

            $client = DataClient::where('npwp', $npwpClient)->first();

            $rowErrors = [];
            if (!$npwpClient) $rowErrors[] = 'NPWP Client kosong';
            if (!$tahun || !is_numeric($tahun)) $rowErrors[] = 'Tahun tidak valid';

            $cabangRecord = null;
            if ($npwpCabang && $client) {
                $cabangRecord = NpwpCabang::where('data_client_id', $client->id)
                    ->where('npwp', $npwpCabang)->first();
                if (!$cabangRecord) $rowErrors[] = 'Cabang NPWP ' . $npwpCabang . ' tidak ditemukan untuk client ini';
            }

            $preview[] = [
                'npwp_client' => $npwpClient,
                'npwp_cabang' => $npwpCabang,
                'tahun' => $tahun,
                'omset_bulanan' => array_slice($row, 4, 12),
                'client_nama' => $client ? $client->nama_client : '-',
                'cabang_nama' => $cabangRecord ? $cabangRecord->nama_client : ($npwpCabang ? 'Not Found' : ''),
                'errors' => $rowErrors,
                'valid' => empty($rowErrors),
                'is_cabang' => $npwpCabang !== '',
            ];
        }

        $totalRows = count($preview);

        return view('cms::transaksi.import', compact(
            'preview', 'totalRows', 'tempPath', 'months'
        ));
    }

    public function confirmImport(Request $request)
    {
        $request->validate([
            'temp_path' => 'required|string',
        ]);

        $fullPath = storage_path('app/' . $request->temp_path);
        if (!file_exists($fullPath)) {
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'File temporary tidak ditemukan. Silakan upload ulang.');
        }

        $xlsx = SimpleXLSX::parse($fullPath);
        if (!$xlsx) {
            @unlink($fullPath);
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'Gagal membaca file Excel: ' . SimpleXLSX::parseError());
        }

        $rows = $xlsx->rows();

        $dataRows = [];
        for ($r = 1; $r < count($rows); $r++) {
            $row = $rows[$r];
            $npwpClient = isset($row[1]) ? ltrim(trim((string) $row[1]), "'") : '';
            if ($npwpClient === '') continue;
            $dataRows[] = $row;
        }

        if (empty($dataRows)) {
            @unlink($fullPath);
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'Tidak ada data valid. Pastikan kolom NPWP Client terisi.');
        }

        $npwpList = [];
        foreach ($dataRows as $row) {
            $npwpClient = isset($row[1]) ? ltrim(trim((string) $row[1]), "'") : '';
            if ($npwpClient) $npwpList[] = $npwpClient;
        }
        $npwpList = array_unique($npwpList);
        $existingNpwps = DataClient::whereNotNull('npwp')->pluck('npwp')->map(function ($v) { return strtolower(trim($v)); })->filter()->values()->toArray();
        $missingNpwps = [];
        foreach ($npwpList as $np) {
            $cleanNp = strtolower(ltrim(trim($np), "'"));
            if (!in_array($cleanNp, $existingNpwps)) {
                $missingNpwps[] = $np;
            }
        }
        if (!empty($missingNpwps)) {
            @unlink($fullPath);
            return redirect()->route('cms.transaksi.import')
                ->with('error', 'Import dibatalkan. Data NPWP tidak tersedia: ' . implode(', ', array_slice($missingNpwps, 0, 10)));
        }

        $imported = 0;
        $errors = [];

        foreach ($dataRows as $row) {
            $npwpClient = isset($row[1]) ? ltrim(trim((string) $row[1]), "'") : '';
            $npwpCabang = isset($row[2]) ? ltrim(trim((string) $row[2]), "'") : '';
            $tahun = isset($row[3]) ? trim((string) $row[3]) : '';

            $client = DataClient::where('npwp', $npwpClient)->first();

            $cabangId = null;
            if ($npwpCabang) {
                $cabang = NpwpCabang::where('data_client_id', $client->id)
                    ->where('npwp', $npwpCabang)->first();
                if (!$cabang) {
                    $errors[] = "Baris " . ($r + 1) . ": Cabang NPWP {$npwpCabang} tidak ditemukan untuk client {$client->nama_client}";
                    continue;
                }
                $cabangId = $cabang->id;
            }

            $tipeBadanId = $client->tipe_badan;

            // UpdateOrCreate transaksi record
            try {
                $transaksi = Transaksi::updateOrCreate(
                    ['client_id' => $client->id, 'npwp_cabang_id' => $cabangId, 'tahun' => (int) $tahun],
                    ['tipe_badan_id' => $tipeBadanId, 'total_omset' => 0, 'total_harta' => 0, 'total_pph' => 0]
                );

                // Delete existing omset
                TransaksiOmset::where('transaksi_id', $transaksi->id)->delete();

                $tabOmset = 0;
                for ($mo = 0; $mo < 12; $mo++) {
                    $val = isset($row[4 + $mo]) ? trim((string) $row[4 + $mo]) : '0';
                    $nominal = (float) preg_replace('/[^0-9]/', '', $val);
                    if ($nominal > 0) {
                        TransaksiOmset::create([
                            'transaksi_id' => $transaksi->id,
                            'bulan' => $mo + 1,
                            'nominal' => $nominal,
                        ]);
                    }
                    $tabOmset += $nominal;
                }

                $transaksi->update(['total_omset' => $tabOmset]);

                $imported++;
            } catch (\Exception $e) {
                $errors[] = "Baris " . ($r + 1) . " ({$client->nama_client}): " . $e->getMessage();
            }
        }

        @unlink($fullPath);

        $message = "Import selesai. {$imported} data diimport.";
        if (count($errors)) {
            $message .= " " . count($errors) . " error: " . implode('; ', array_slice($errors, 0, 5));
        }

        return redirect()->route('cms.transaksi.index')
            ->with('success', $message);
    }
}
