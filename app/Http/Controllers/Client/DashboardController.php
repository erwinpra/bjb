<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Cms\Badan;
use App\Models\Cms\DataClient;
use App\Models\Cms\MasterRumus;
use App\Models\Cms\Transaksi;
use App\Models\Cms\LampiranSptDetail;
use App\Models\Cms\KategoriLampiran;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PDF;

class DashboardController extends Controller
{
    protected function resolveClient()
    {
        $client = Auth::guard('client')->user();
        $viewClientId = request('view_client_id', $client->id);

        if ($viewClientId != $client->id && $client->hasClientPermission('client.view-all')) {
            $viewClient = DataClient::find($viewClientId);
            if ($viewClient) {
                return $viewClient;
            }
        }

        return $client;
    }

    public function index()
    {
        $client = $this->resolveClient();
        $tahun = request('tahun', date('Y'));
        $clientRole = $client->clientRole;
        $allClients = collect();

        $loggedClient = Auth::guard('client')->user();
        if ($loggedClient->hasClientPermission('client.view-all')) {
            $allClients = DataClient::with('badan')
                ->where('id', '!=', $loggedClient->id)
                ->orderBy('nama_client')
                ->get();
        }

        return view('client.dashboard', compact('client', 'tahun', 'clientRole', 'allClients'));
    }

    public function data(Request $request)
    {
        $client = $this->resolveClient();
        $tahun = $request->tahun ?? date('Y');
        $tahunBanding = $request->tahun_banding;

        $ini = $this->loadYearData($client, $tahun);
        $banding = $tahunBanding ? $this->loadYearData($client, $tahunBanding) : null;

        $vsTahunan = null;
        if ($banding) {
            $growth = function ($now, $prev) {
                return $prev > 0 ? round(($now - $prev) / $prev * 100, 1) : null;
            };
            $vsTahunan = [
                'tahun_ini' => (int) $tahun,
                'tahun_banding' => (int) $tahunBanding,
                'growth_omset' => $growth($ini['total_omset'], $banding['total_omset']),
                'growth_harta' => $growth($ini['total_harta'], $banding['total_harta']),
                'growth_pph' => $growth($ini['total_pph'], $banding['total_pph']),
            ];
        }

        return response()->json([
            'exists' => $ini['exists'],
            'total_harta' => $ini['total_harta'],
            'total_omset' => $ini['total_omset'],
            'total_pph' => $ini['total_pph'],
            'harta_detail' => $ini['harta_detail'],
            'harta_by_kategori' => $ini['harta_by_kategori'],
            'omset_per_bulan' => $ini['omset_per_bulan'],
            'bulan_labels' => ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'],
            'cabang_count' => $ini['cabang_count'],
            'tabs' => $ini['tabs'],
            'banding' => $banding ? [
                'exists' => $banding['exists'],
                'total_harta' => $banding['total_harta'],
                'total_omset' => $banding['total_omset'],
                'total_pph' => $banding['total_pph'],
                'harta_detail' => $banding['harta_detail'],
                'harta_by_kategori' => $banding['harta_by_kategori'],
                'omset_per_bulan' => $banding['omset_per_bulan'],
                'cabang_count' => $banding['cabang_count'],
                'tabs' => $banding['tabs'],
            ] : null,
            'vs_tahunan' => $vsTahunan,
        ]);
    }

    protected function loadYearData($client, $tahun)
    {
        $transaksis = Transaksi::where('client_id', $client->id)
            ->where('tahun', $tahun)
            ->with(['harta', 'omset'])
            ->get()
            ->keyBy(function ($t) {
                return $t->npwp_cabang_id ? 'cabang_' . $t->npwp_cabang_id : 'induk';
            });

        $allTabs = $this->buildTabsData($client, $tahun, $transaksis);

        $omsetPerBulan = [];
        for ($mo = 1; $mo <= 12; $mo++) $omsetPerBulan[$mo] = 0;
        foreach ($allTabs as $tab) {
            foreach ($tab['omset_per_bulan'] as $mo => $val) {
                $omsetPerBulan[$mo] += $val;
            }
        }

        $totalOmset = array_sum($omsetPerBulan);
        $totalPph = 0;
        foreach ($allTabs as $tab) {
            $totalPph += $tab['total_potongan'];
        }

        // Compute totalBrutoAkum for induk tab
        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
        $perMonthAkum = [];
        for ($mo = 1; $mo <= 12; $mo++) {
            $perMonthAkum[$mo] = 0;
            foreach ($allTabs as $at) {
                $perMonthAkum[$mo] += $at['omset_per_bulan'][$mo] ?? 0;
            }
        }
        foreach ($allTabs as &$at) {
            if ($at['key'] === 'induk') {
                $cumAkum = 0;
                foreach ($at['detail_bulan'] as &$db) {
                    $moIdx = array_search($db['bulan'], $bulanLabels);
                    if ($moIdx !== false) {
                        $mo = $moIdx + 1;
                        $cumAkum += $perMonthAkum[$mo];
                        $db['totalBrutoAkum'] = $cumAkum > 0 ? 'Rp ' . number_format($cumAkum, 0, ',', '.') : '';
                    } else {
                        $db['totalBrutoAkum'] = '';
                    }
                }
            } else {
                foreach ($at['detail_bulan'] as &$db) {
                    $db['totalBrutoAkum'] = '';
                }
            }
        }
        unset($at, $db);

        // Harta from LampiranSptDetail
        $chartColors = ['#dc3545','#fd7e14','#ffc107','#198754','#0d6efd','#6f42c1','#20c997'];
        $allDetailItems = LampiranSptDetail::where('client_id', $client->id)
            ->where('tahun', $tahun)
            ->where('saldo_saat_ini', '>', 0)
            ->with('masterItem.kategori')
            ->get();

        $itemsByKode = $allDetailItems->groupBy('kode');
        $totalHarta = 0;
        $hartaDetail = [];
        $hartaByKategori = [];

        foreach ($itemsByKode as $kode => $detailItems) {
            $first = $detailItems->first();
            $master = $first->masterItem;
            $katLabel = $master->kategori->label ?? 'Lainnya';
            $nama = ($master->sub_kode ?? $kode) . ' ' . ($master->nama ?? '');
            $nilai = (float) $detailItems->sum('saldo_saat_ini');
            $totalHarta += $nilai;
            $hartaDetail[] = [
                'kategori' => $katLabel,
                'kategori_id' => $master->kategori_id,
                'kode' => $kode,
                'nama' => $nama,
                'nilai' => $nilai,
                'records' => $detailItems->map(function ($d) { return [
                    'id' => $d->id,
                    'deskripsi' => $d->deskripsi,
                    'nomor_akun' => $d->nomor_akun,
                    'atas_nama' => $d->atas_nama,
                    'nama_bank_institusi' => $d->nama_bank_institusi,
                    'lokasi_harta' => $d->lokasi_harta,
                    'kurs' => $d->kurs,
                    'tahun_perolehan' => $d->tahun_perolehan,
                    'saldo_saat_ini' => $d->saldo_saat_ini,
                    'saldo_bentuk_awal' => $d->saldo_bentuk_awal,
                    'nilai_kurs' => $d->nilai_kurs,
                ]; })->toArray(),
            ];
            $hartaByKategori[$katLabel] = ($hartaByKategori[$katLabel] ?? 0) + $nilai;
        }

        foreach ($allTabs as &$at) {
            $isInduk = $at['key'] === 'induk';
            $katLabels = array_keys($hartaByKategori);
            $katValues = array_values($hartaByKategori);
            $katColors = [];
            foreach ($katLabels as $i => $l) {
                $katColors[] = $chartColors[$i % count($chartColors)];
            }
            $at['harta'] = $isInduk ? [
                'total' => $totalHarta, 'detail' => $hartaDetail,
                'by_kategori' => ['labels' => $katLabels, 'values' => $katValues, 'colors' => $katColors],
            ] : ['total' => 0, 'detail' => [], 'by_kategori' => ['labels' => [], 'values' => [], 'colors' => []]];
        }
        unset($at);

        $katLabels = array_keys($hartaByKategori);
        $katValues = array_values($hartaByKategori);
        $katColors = [];
        foreach ($katLabels as $i => $l) {
            $katColors[] = $chartColors[$i % count($chartColors)];
        }

        return [
            'exists' => $transaksis->isNotEmpty(),
            'total_harta' => $totalHarta,
            'total_omset' => $totalOmset,
            'total_pph' => $totalPph,
            'harta_detail' => $hartaDetail,
            'harta_by_kategori' => ['labels' => $katLabels, 'values' => $katValues, 'colors' => $katColors],
            'omset_per_bulan' => array_values($omsetPerBulan),
            'cabang_count' => count($allTabs) - 1,
            'tabs' => $allTabs,
        ];
    }

    protected function buildTabsData($client, $tahun, $transaksis = null)
    {
        if ($transaksis === null) {
            $transaksis = Transaksi::where('client_id', $client->id)
                ->where('tahun', $tahun)
                ->with(['omset'])
                ->get()
                ->keyBy(function ($t) {
                    return $t->npwp_cabang_id ? 'cabang_' . $t->npwp_cabang_id : 'induk';
                });
        }

        $tipeBadanId = $client->tipe_badan;
        $badanEntry = Badan::find($tipeBadanId);
        $isId1 = $badanEntry && $badanEntry->id === 1;

        $rumus = MasterRumus::where('tipe_badan', $tipeBadanId)->first();
        $persen = $rumus ? (float) $rumus->potongan_persentase : 0;
        $maxVal = $rumus ? (float) $rumus->max_value : 0;

        $cabangs = $client->cabangs;
        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

        $allTabs = [];

        // Induk tab
        $indukTransaksi = $transaksis->get('induk');
        $indukOmsetBulanan = [];
        for ($mo = 1; $mo <= 12; $mo++) {
            $indukOmsetBulanan[$mo] = 0;
        }
        if ($indukTransaksi) {
            foreach ($indukTransaksi->omset as $o) {
                $indukOmsetBulanan[(int) $o->bulan] = (float) $o->nominal;
            }
        }

        $allTabs[] = $this->buildSingleTabData(
            'induk', $client->nama_client, $client->npwp ?? '', $client->kpp ?? '',
            $isId1, $indukOmsetBulanan, $indukTransaksi ? (float) $indukTransaksi->total_omset : 0,
            $persen, $maxVal, $bulanLabels, null
        );

        // Cabang tabs
        foreach ($cabangs as $cabang) {
            $key = 'cabang_' . $cabang->id;
            $cabangTransaksi = $transaksis->get($key);
            $cabangOmsetBulanan = [];
            for ($mo = 1; $mo <= 12; $mo++) {
                $cabangOmsetBulanan[$mo] = 0;
            }
            if ($cabangTransaksi) {
                foreach ($cabangTransaksi->omset as $o) {
                    $cabangOmsetBulanan[(int) $o->bulan] = (float) $o->nominal;
                }
            }

            $allTabs[] = $this->buildSingleTabData(
                $key, $cabang->nama_client, $cabang->npwp ?? '', $cabang->kpp ?? '',
                $isId1, $cabangOmsetBulanan, $cabangTransaksi ? (float) $cabangTransaksi->total_omset : 0,
                $persen, $maxVal, $bulanLabels, $cabang->id
            );
        }

        return $allTabs;
    }

    protected function buildSingleTabData($key, $label, $npwp, $kpp, $isId1, $omsetBulanan, $totalOmsetDb, $persen, $maxVal, $bulanLabels, $npwpCabangId = null)
    {
        $tabOmset = 0;
        $cumulative = 0;
        $totalPotongan = 0;
        $detailBulan = [];

        for ($mo = 1; $mo <= 12; $mo++) {
            $nominal = $omsetBulanan[$mo] ?? 0;
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

        return [
            'key' => $key,
            'label' => $label,
            'npwp' => $npwp,
            'kpp' => $kpp,
            'npwp_cabang_id' => $npwpCabangId,
            'total_omset' => $tabOmset,
            'total_potongan' => $totalPotongan,
            'omset_per_bulan' => $omsetBulanan,
            'detail_bulan' => $detailBulan,
        ];
    }

    public function exportPdf(Request $request)
    {
        $client = $this->resolveClient();
        $tahun = $request->tahun ?? date('Y');
        $data = $this->buildDashboardExport($client, $tahun);

        $pdf = PDF::loadView('client.export-pdf', $data);
        return $pdf->download('dashboard_' . $client->nama_client . '_' . $tahun . '.pdf');
    }

    public function exportExcel(Request $request)
    {
        $client = $this->resolveClient();
        $tahun = $request->tahun ?? date('Y');
        $data = $this->buildDashboardExport($client, $tahun);

        $filename = 'dashboard_' . $client->nama_client . '_' . $tahun . '.csv';
        $handle = fopen('php://temp', 'r+');

        fputcsv($handle, ['Dashboard', $client->nama_client, 'Tahun', $tahun]);
        fputcsv($handle, []);

        if (!empty($data['harta'])) {
            fputcsv($handle, ['Daftar ' . $data['hartaLabel']]);
            fputcsv($handle, ['Nama', 'Nilai']);
            foreach ($data['harta'] as $h) {
                fputcsv($handle, [$h['nama'], number_format($h['nilai'], 0, ',', '.')]);
            }
            fputcsv($handle, ['Total', number_format(collect($data['harta'])->sum('nilai'), 0, ',', '.')]);
            fputcsv($handle, []);
        }

        fputcsv($handle, ['Omset Per Bulan']);
        fputcsv($handle, ['Bulan', 'Omset', 'Total Peredaran Bruto', 'PPH Final 0.5%', 'PPh Final yg harus dibayar']);
        foreach ($data['detailBulan'] as $row) {
            fputcsv($handle, [$row['bulan'], $row['omset'], $row['totalBruto'], $row['pphFinal'], $row['pphBayar']]);
        }
        fputcsv($handle, []);
        fputcsv($handle, ['Total ' . $data['hartaLabel'], number_format($data['totalHarta'], 0, ',', '.')]);
        fputcsv($handle, ['Total Omset', number_format($data['totalOmset'], 0, ',', '.')]);
        fputcsv($handle, ['Total PPh Final', number_format($data['totalPotongan'], 0, ',', '.')]);

        rewind($handle);
        $content = stream_get_contents($handle);
        fclose($handle);

        return response($content, 200, [
            'Content-Type' => 'text/csv; charset=UTF-8',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }

    protected function buildDashboardExport($client, $tahun)
    {
        $tipeBadanId = $client->tipe_badan;
        $badanEntry = Badan::find($tipeBadanId);
        $isId1 = $badanEntry && $badanEntry->id === 1;
        $hartaLabel = $isId1 ? 'Inventaris' : 'Harta';
        $tipeName = $badanEntry ? $badanEntry->tipe : '-';

        $rumus = MasterRumus::where('tipe_badan', $tipeBadanId)->first();
        $persen = $rumus ? (float) $rumus->potongan_persentase : 0;
        $maxVal = $rumus ? (float) $rumus->max_value : 0;

        $allTabs = $this->buildTabsData($client, $tahun);

        // Load harta from LampiranSptDetail
        $detailItems = LampiranSptDetail::where('client_id', $client->id)
            ->where('tahun', $tahun)
            ->where('saldo_saat_ini', '>', 0)
            ->with('masterItem.kategori')
            ->get()
            ->groupBy('kode');

        $harta = [];
        $totalHarta = 0;
        foreach ($detailItems as $kode => $items) {
            $first = $items->first();
            $master = $first->masterItem;
            $katLabel = $master->kategori->label ?? 'Lainnya';
            $nama = $katLabel . ' - ' . ($master->sub_kode ?? $kode) . ' ' . ($master->nama ?? '');
            $nilai = (float) $items->sum('saldo_saat_ini');
            $harta[] = ['nama' => $nama, 'nilai' => $nilai];
            $totalHarta += $nilai;
        }

        $detailBulan = [];
        $totalOmset = 0;
        $totalPotongan = 0;
        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

        // Aggregate across all tabs for the main table
        $perMonthTotal = [];
        for ($mo = 1; $mo <= 12; $mo++) {
            $perMonthTotal[$mo] = 0;
        }
        foreach ($allTabs as $tab) {
            foreach ($tab['omset_per_bulan'] as $mo => $val) {
                $perMonthTotal[$mo] += $val;
            }
            $totalOmset += $tab['total_omset'];
            $totalPotongan += $tab['total_potongan'];
        }

        $cumulative = 0;
        for ($mo = 1; $mo <= 12; $mo++) {
            $nominal = $perMonthTotal[$mo];
            $totalWithCurrent = $cumulative + $nominal;

            $pphFinal = $nominal < 500 ? 'Free' : 'Rp ' . number_format($nominal * $persen / 100, 0, ',', '.');

            $pphBayar = '';
            if ($cumulative >= $maxVal) {
                $potongan = $nominal * $persen / 100;
                $pphBayar = 'Rp ' . number_format($potongan, 0, ',', '.');
            } elseif ($totalWithCurrent > $maxVal) {
                $kelebihan = $totalWithCurrent - $maxVal;
                $potongan = $kelebihan * $persen / 100;
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

        // Compute per-month akum across all tabs for induk
        $perMonthAkum = [];
        for ($mo = 1; $mo <= 12; $mo++) {
            $perMonthAkum[$mo] = 0;
            foreach ($allTabs as $at) {
                $perMonthAkum[$mo] += $at['omset_per_bulan'][$mo] ?? 0;
            }
        }

        // Add akum to induk's detail_bulan
        foreach ($allTabs as &$at) {
            if ($at['key'] === 'induk') {
                $cumAkum = 0;
                foreach ($at['detail_bulan'] as &$db) {
                    $moIdx = array_search($db['bulan'], $bulanLabels);
                    if ($moIdx !== false) {
                        $mo = $moIdx + 1;
                        $cumAkum += $perMonthAkum[$mo];
                        $db['totalBrutoAkum'] = $cumAkum > 0 ? 'Rp ' . number_format($cumAkum, 0, ',', '.') : '';
                    } else {
                        $db['totalBrutoAkum'] = '';
                    }
                }
            } else {
                foreach ($at['detail_bulan'] as &$db) {
                    $db['totalBrutoAkum'] = '';
                }
            }
        }
        unset($at, $db);

        $cabangCount = count($allTabs) - 1;

        return compact(
            'client', 'tahun', 'isId1', 'hartaLabel', 'tipeName',
            'harta', 'totalHarta', 'totalOmset', 'totalPotongan',
            'detailBulan', 'persen', 'allTabs', 'cabangCount'
        );
    }
}
