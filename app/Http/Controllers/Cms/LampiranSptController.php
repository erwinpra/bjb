<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\LampiranSpt;
use App\Models\Cms\DataClient;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LampiranSptController extends Controller
{
    public function index()
    {
        $clientId = request('client_id');
        $tahun = request('tahun', date('Y'));

        $clients = DataClient::orderBy('nama_client')->get();
        $tahunList = range(date('Y'), date('Y') - 5);

        $masterItems = LampiranSpt::master()->orderBy('kategori')->orderBy('sub_kode')->get();

        $clientItems = collect();
        if ($clientId) {
            $clientItems = LampiranSpt::forClient($clientId, $tahun)->get()->keyBy(function ($i) {
                return $i->kategori . '|' . $i->sub_kode;
            });
        }

        $items = $masterItems->map(function ($m) use ($clientItems) {
            $key = $m->kategori . '|' . $m->sub_kode;
            $nilai = isset($clientItems[$key]) ? $clientItems[$key]->nilai : 0;
            return [
                'id' => $m->id,
                'kategori' => $m->kategori,
                'sub_kode' => $m->sub_kode,
                'sub_nama' => $m->sub_nama,
                'nilai' => $nilai,
            ];
        })->groupBy('kategori');

        $kategoriLabels = [
            'KAS' => 'Kas',
            'PIUTANG' => 'Piutang',
            'INVESTASI' => 'Investasi',
            'HARTA_BERGERAK' => 'Harta Bergerak',
            'HARTA_TIDAK_BERGERAK' => 'Harta Tidak Bergerak',
            'HARTA_LAINNYA' => 'Harta Lainnya',
            'TOTAL_HUTANG' => 'Total Hutang',
        ];

        return view('cms::lampiran-spt.index', compact(
            'clients', 'tahunList', 'clientId', 'tahun',
            'items', 'kategoriLabels', 'masterItems'
        ));
    }

    public function store(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000',
            'nilai' => 'required|array',
        ]);

        $clientId = $request->client_id;
        $tahun = $request->tahun;

        foreach ($request->nilai as $key => $nilai) {
            $parts = explode('|', $key);
            if (count($parts) !== 2) continue;

            $kategori = $parts[0];
            $subKode = $parts[1];
            $nilaiClean = (float) preg_replace('/[^0-9]/', '', $nilai ?? '0');

            $master = LampiranSpt::master()
                ->where('kategori', $kategori)
                ->where('sub_kode', $subKode)
                ->first();

            if (!$master) continue;

            LampiranSpt::updateOrCreate(
                [
                    'client_id' => $clientId,
                    'tahun' => $tahun,
                    'kategori' => $kategori,
                    'sub_kode' => $subKode,
                ],
                [
                    'sub_nama' => $master->sub_nama,
                    'nilai' => $nilaiClean,
                ]
            );
        }

        return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun])
            ->with('success', 'Nilai SPT berhasil disimpan.');
    }

    public function dashboard()
    {
        $clientId = request('client_id');
        $clients = DataClient::orderBy('nama_client')->get();

        $years = [2024, 2025];
        $sources = ['2024', 'djp', 'ctx'];

        $kategoriLabels = [
            'KAS' => 'Kas',
            'PIUTANG' => 'Piutang',
            'INVESTASI' => 'Investasi',
            'HARTA_BERGERAK' => 'Harta Bergerak',
            'HARTA_TIDAK_BERGERAK' => 'Harta Tidak Bergerak',
            'HARTA_LAINNYA' => 'Harta Lainnya',
            'TOTAL_HUTANG' => 'Total Hutang',
        ];

        $masterItems = LampiranSpt::master()->orderBy('kategori')->orderBy('sub_kode')->get();

        $nilaiByKey = collect();
        if ($clientId) {
            $nilaiByKey = LampiranSpt::where('client_id', $clientId)
                ->whereIn('tahun', $years)
                ->get()
                ->groupBy(function ($i) {
                    return $i->tahun . '|' . $i->kategori . '|' . $i->sub_kode;
                });
        }

        $comparison = [];
        foreach ($masterItems as $item) {
            $key = $item->kategori . '|' . $item->sub_kode;
            $row = [
                'kategori' => $item->kategori,
                'sub_kode' => $item->sub_kode,
                'sub_nama' => $item->sub_nama,
                'val_2024' => 0,
                'val_2025_djp' => 0,
                'val_2025_ctx' => 0,
            ];

            foreach ($years as $year) {
                foreach ($sources as $src) {
                    $lookupKey = $year . '|' . $item->kategori . '|' . $item->sub_kode;
                    $entries = $nilaiByKey->get($lookupKey, collect());
                    $totalNilai = $entries->sum('nilai');

                    if ($src === '2024') {
                        $row['val_2024'] += $totalNilai;
                    } elseif ($src === 'djp') {
                        $row['val_2025_djp'] += $totalNilai;
                    } elseif ($src === 'ctx') {
                        $row['val_2025_ctx'] += $totalNilai;
                    }
                }
            }

            $comparison[] = $row;
        }

        $grouped = collect($comparison)->groupBy('kategori');
        $totals = [];
        foreach ($grouped as $kat => $items) {
            $totals[$kat] = [
                'val_2024' => $items->sum('val_2024'),
                'val_2025_djp' => $items->sum('val_2025_djp'),
                'val_2025_ctx' => $items->sum('val_2025_ctx'),
            ];
        }

        $grandTotal = [
            'val_2024' => collect($totals)->sum('val_2024'),
            'val_2025_djp' => collect($totals)->sum('val_2025_djp'),
            'val_2025_ctx' => collect($totals)->sum('val_2025_ctx'),
        ];

        return view('cms::lampiran-spt.dashboard', compact(
            'clients', 'clientId', 'kategoriLabels',
            'grouped', 'totals', 'grandTotal'
        ));
    }

    public function editMaster()
    {
        $kategoriLabels = [
            'KAS' => 'Kas',
            'PIUTANG' => 'Piutang',
            'INVESTASI' => 'Investasi',
            'HARTA_BERGERAK' => 'Harta Bergerak',
            'HARTA_TIDAK_BERGERAK' => 'Harta Tidak Bergerak',
            'HARTA_LAINNYA' => 'Harta Lainnya',
            'TOTAL_HUTANG' => 'Total Hutang',
        ];

        $masterItems = LampiranSpt::master()->orderBy('kategori')->orderBy('sub_kode')->get()
            ->groupBy('kategori');

        return view('cms::lampiran-spt.master', compact('masterItems', 'kategoriLabels'));
    }
}
