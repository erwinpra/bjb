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
use Illuminate\Http\Request;
use PDF;

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
        return view('cms::transaksi.form', compact('clients', 'rumus', 'badan', 'cabangs'));
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

        $totalOmset = 0;
        $totalHarta = 0;
        $totalPph = 0;

        $tabs = ['induk'];
        foreach (array_keys($request->all()) as $key) {
            if (strpos($key, 'cabang_') === 0) $tabs[] = $key;
        }

        foreach ($tabs as $tab) {
            $tabData = $tab === 'induk' ? ($request->input('induk') ?? []) : ($request->input($tab) ?? []);
            $npwpCabangId = $tab === 'induk' ? null : ($tabData['npwp_cabang_id'] ?? null);

            $transaksi = Transaksi::updateOrCreate(
                ['client_id' => $request->client_id, 'npwp_cabang_id' => $npwpCabangId, 'tahun' => $request->tahun],
                ['tipe_badan_id' => $tipeBadanId, 'total_omset' => 0, 'total_harta' => 0, 'total_pph' => 0]
            );

            // Delete existing omset for this transaksi
            TransaksiOmset::where('transaksi_id', $transaksi->id)->delete();

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
        $indukTransaksi = Transaksi::where('client_id', $request->client_id)
            ->where('tahun', $request->tahun)
            ->whereNull('npwp_cabang_id')
            ->latest('id')
            ->first();

        if ($indukTransaksi && $request->harta_nama) {
            TransaksiHarta::where('transaksi_id', $indukTransaksi->id)->delete();
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
                fputcsv($handle, ['Bulan', 'Omset', 'Total Peredaran Bruto', 'PPH Final 0.5%', 'PPh Final yg harus dibayar']);
                foreach ($tab['detail_bulan'] as $row) {
                    if ($row['omset'] !== '') {
                        fputcsv($handle, [$row['bulan'], $row['omset'], $row['totalBruto'], $row['pphFinal'], $row['pphBayar']]);
                    }
                }
                fputcsv($handle, ['Total', number_format($tab['total_omset'], 0, ',', '.'), '', '', number_format($tab['total_potongan'], 0, ',', '.')]);
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

        // For backward compat with existing views
        $detailBulan = $detailBulanInduk ?? [];

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
        ];
    }

    public function getCabangs(DataClient $client)
    {
        $cabangs = NpwpCabang::where('data_client_id', $client->id)->get(['id', 'nama_client', 'npwp', 'kpp', 'email', 'no_telephone', 'alamat_npwp', 'alamat_tagihan', 'AR', 'ptkp']);
        return response()->json($cabangs);
    }
}
