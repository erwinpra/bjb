<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\LampiranSpt;
use App\Models\Cms\MasterLampiranSpt;
use App\Models\Cms\KategoriLampiran;
use App\Models\Cms\DataClient;
use Illuminate\Http\Request;

class LampiranSptController extends Controller
{
    protected function buildTabItems($kategoris, $clientId, $tahun, $npwpCabangId = null)
    {
        $query = LampiranSpt::where('client_id', $clientId)->where('tahun', $tahun);
        if ($npwpCabangId) {
            $query->where('npwp_cabang_id', $npwpCabangId);
        } else {
            $query->whereNull('npwp_cabang_id');
        }
        $existingItems = $query->get()->keyBy('lampiran_spt_id');

        $items = collect();
        foreach ($kategoris as $kat) {
            $rows = collect();
            foreach ($kat->masterLampiranSpts as $m) {
                $existing = $existingItems->get($m->id);
                $rows->push([
                    'id' => $m->id,
                    'sub_kode' => $m->sub_kode,
                    'sub_nama' => $m->nama,
                    'nilai' => $existing ? $existing->nilai : 0,
                ]);
            }
            $items->put($kat->label, $rows);
        }

        return $items;
    }

    public function index()
    {
        $clientId = request('client_id');
        $tahun = request('tahun', date('Y'));

        $clients = DataClient::orderBy('nama_client')->get();
        $tahunList = range(date('Y'), date('Y') - 5);

        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();
        $kategoriLabels = $kategoris->pluck('label', 'label')->toArray();

        $cabangs = collect();
        $tabs = collect();
        $activeTab = request('tab', 'induk');

        if ($clientId) {
            $client = DataClient::find($clientId);
            $cabangs = $client ? $client->cabangs : collect();

            // Build induk tab data
            $tabs->put('induk', [
                'label' => $client ? $client->nama_client : 'Induk',
                'npwp' => $client ? ($client->npwp ?? '-') : '-',
                'npwp_cabang_id' => null,
                'items' => $this->buildTabItems($kategoris, $clientId, $tahun, null),
            ]);

            // Build cabang tabs data
            foreach ($cabangs as $cabang) {
                $key = 'cabang_' . $cabang->id;
                $tabs->put($key, [
                    'label' => $cabang->nama_client,
                    'npwp' => $cabang->npwp ?? '-',
                    'npwp_cabang_id' => $cabang->id,
                    'items' => $this->buildTabItems($kategoris, $clientId, $tahun, $cabang->id),
                ]);
            }
        }

        return view('cms::lampiran-spt.index', compact(
            'clients', 'tahunList', 'clientId', 'tahun',
            'kategoriLabels', 'kategoris', 'cabangs', 'tabs', 'activeTab'
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

        $tabs = ['induk'];
        foreach (array_keys($request->all()) as $key) {
            if (strpos($key, 'cabang_') === 0) $tabs[] = $key;
        }

        foreach ($tabs as $tab) {
            $tabData = $tab === 'induk' ? ($request->input('induk') ?? []) : ($request->input($tab) ?? []);
            $nilaiData = $tabData['nilai'] ?? [];
            $npwpCabangId = $tab === 'induk' ? null : ($tabData['npwp_cabang_id'] ?? null);

            foreach ($nilaiData as $lampiranSptId => $nilai) {
                $lampiranSptId = (int) $lampiranSptId;
                $nilaiClean = (float) preg_replace('/[^0-9]/', '', $nilai ?? '0');

                $master = MasterLampiranSpt::find($lampiranSptId);
                if (!$master) continue;

                if ($nilaiClean > 0) {
                    LampiranSpt::updateOrCreate(
                        [
                            'client_id' => $clientId,
                            'npwp_cabang_id' => $npwpCabangId,
                            'tahun' => $tahun,
                            'lampiran_spt_id' => $lampiranSptId,
                        ],
                        ['nilai' => $nilaiClean]
                    );
                } else {
                    LampiranSpt::where('client_id', $clientId)
                        ->where('npwp_cabang_id', $npwpCabangId)
                        ->where('tahun', $tahun)
                        ->where('lampiran_spt_id', $lampiranSptId)
                        ->delete();
                }
            }
        }

        $redirectTab = $request->input('active_tab', 'induk');

        return redirect()->route('cms.lampiran-spt.index', ['client_id' => $clientId, 'tahun' => $tahun, 'tab' => $redirectTab])
            ->with('success', 'Nilai SPT berhasil disimpan.');
    }

    public function dashboard()
    {
        $clientId = request('client_id');
        $clients = DataClient::orderBy('nama_client')->get();

        $years = [2024, 2025];
        $sources = ['2024', 'djp', 'ctx'];

        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();

        $nilaiByKey = collect();
        if ($clientId) {
            $nilaiByKey = LampiranSpt::where('client_id', $clientId)
                ->whereIn('tahun', $years)
                ->get()
                ->groupBy(function ($i) {
                    return $i->tahun . '|' . $i->lampiran_spt_id;
                });
        }

        $comparison = [];
        foreach ($kategoris as $kat) {
            foreach ($kat->masterLampiranSpts as $m) {
                $row = [
                    'kategori' => $kat->label,
                    'sub_kode' => $m->sub_kode,
                    'sub_nama' => $m->nama,
                    'val_2024' => 0,
                    'val_2025_djp' => 0,
                    'val_2025_ctx' => 0,
                ];

                foreach ($years as $year) {
                    foreach ($sources as $src) {
                        $lookupKey = $year . '|' . $m->id;
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

        $kategoriLabels = $kategoris->pluck('label', 'label')->toArray();

        return view('cms::lampiran-spt.dashboard', compact(
            'clients', 'clientId', 'kategoriLabels',
            'grouped', 'totals', 'grandTotal'
        ));
    }

    public function editMaster()
    {
        $kategoris = KategoriLampiran::with('masterLampiranSpts')->orderBy('id')->get();
        $kategoriLabels = $kategoris->pluck('label', 'label')->toArray();

        return view('cms::lampiran-spt.master', compact('kategoris', 'kategoriLabels'));
    }
}
