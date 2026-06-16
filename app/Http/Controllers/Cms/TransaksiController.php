<?php

namespace App\Http\Controllers\Cms;

use App\Http\Controllers\Controller;
use App\Models\Cms\DataClient;
use App\Models\Cms\MasterRumus;
use App\Models\Cms\Transaksi;
use App\Models\Cms\TransaksiHarta;
use App\Models\Cms\TransaksiOmset;
use App\Models\Cms\Badan;
use Illuminate\Http\Request;
use PDF;

class TransaksiController extends Controller
{
    public function create()
    {
        $clients = DataClient::all();
        $rumus = MasterRumus::all();
        $badan = Badan::all();
        return view('cms::transaksi.form', compact('clients', 'rumus', 'badan'));
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer|min:2000|max:2100',
            'harta_nama' => 'nullable|array',
            'harta_nilai' => 'nullable|array',
            'omset_tahunan' => 'nullable|string',
            'omset_bulanan' => 'nullable|array',
            'total_omset' => 'nullable|string',
            'total_pph' => 'nullable|string',
        ]);

        $client = DataClient::findOrFail($request->client_id);
        $tipeBadanId = $client->tipe_badan;

        $totalHarta = 0;
        $totalOmset = 0;
        $totalPph = 0;

        $transaksi = Transaksi::create([
            'client_id' => $request->client_id,
            'tahun' => $request->tahun,
            'tipe_badan_id' => $tipeBadanId,
            'total_omset' => 0,
            'total_harta' => 0,
            'total_pph' => 0,
        ]);

        if ($request->harta_nama) {
            foreach ($request->harta_nama as $i => $nama) {
                if (!$nama) continue;
                $nilai = isset($request->harta_nilai[$i]) ? (float) preg_replace('/[^0-9]/', '', $request->harta_nilai[$i]) : 0;
                TransaksiHarta::create([
                    'transaksi_id' => $transaksi->id,
                    'nama' => $nama,
                    'nilai' => $nilai,
                ]);
                $totalHarta += $nilai;
            }
        }

        $rumus = MasterRumus::where('tipe_badan', $tipeBadanId)->first();
        $persen = $rumus ? (float) $rumus->potongan_persentase : 0;

        $badanEntry = Badan::find($tipeBadanId);
        $isId1 = $badanEntry && $badanEntry->id === 1;

        if ($isId1) {
            $omset = (float) preg_replace('/[^0-9]/', '', $request->omset_tahunan ?? '0');
            $totalOmset = $omset;
            TransaksiOmset::create([
                'transaksi_id' => $transaksi->id,
                'bulan' => 0,
                'nominal' => $omset,
            ]);
        } else {
            $omsetData = $request->omset_bulanan ?? [];
            foreach ($omsetData as $mo => $val) {
                $nominal = (float) preg_replace('/[^0-9]/', '', $val ?? '0');
                if ($nominal > 0) {
                    TransaksiOmset::create([
                        'transaksi_id' => $transaksi->id,
                        'bulan' => (int) $mo,
                        'nominal' => $nominal,
                    ]);
                }
                $totalOmset += $nominal;
            }
        }

        $totalPph = $totalOmset * $persen / 100;

        $transaksi->update([
            'total_omset' => $totalOmset,
            'total_harta' => $totalHarta,
            'total_pph' => $totalPph,
        ]);

        return redirect()->route('cms.transaksi.index')
            ->with('success', 'Transaksi berhasil disimpan.');
    }

    public function loadData(Request $request)
    {
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer',
        ]);

        $transaksi = Transaksi::where('client_id', $request->client_id)
            ->where('tahun', $request->tahun)
            ->with(['harta', 'omset'])
            ->latest('id')
            ->first();

        if (!$transaksi) {
            return response()->json(['exists' => false]);
        }

        return response()->json([
            'exists' => true,
            'transaksi' => $transaksi,
            'harta' => $transaksi->harta,
            'omset' => $transaksi->omset,
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

        if ($result['isId1']) {
            fputcsv($handle, ['Omset Tahunan']);
            fputcsv($handle, ['Tahunan', number_format($result['totalOmset'], 0, ',', '.')]);
        } else {
            fputcsv($handle, ['Omset Per Bulan']);
            fputcsv($handle, ['Bulan', 'Omset', 'Total Peredaran Bruto', 'PPH Final 0.5%', 'PPh Final yg harus dibayar']);
            foreach ($result['detailBulan'] as $row) {
                fputcsv($handle, [$row['bulan'], $row['omset'], $row['totalBruto'], $row['pphFinal'], $row['pphBayar']]);
            }
            fputcsv($handle, ['Total', number_format($result['totalOmset'], 0, ',', '.'), '', '', number_format($result['totalPotongan'], 0, ',', '.')]);
        }

        fputcsv($handle, []);
        fputcsv($handle, ['Total ' . $result['hartaLabel'], number_format($result['totalHarta'], 0, ',', '.')]);
        fputcsv($handle, ['Total Omset', number_format($result['totalOmset'], 0, ',', '.')]);

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
        $request->validate([
            'client_id' => 'required|exists:cms_data_client,id',
            'tahun' => 'required|integer',
            'harta_nama' => 'nullable|array',
            'harta_nilai' => 'nullable|array',
            'omset_tahunan' => 'nullable|string',
            'omset_bulanan' => 'nullable|array',
        ]);
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

        // Omset
        $totalOmset = 0;
        $detailBulan = [];
        $totalPotongan = 0;
        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

        if ($isId1) {
            $totalOmset = (float) preg_replace('/[^0-9]/', '', $request->omset_tahunan ?? '0');
        } else {
            $omsetData = $request->omset_bulanan ?? [];
            $cumulative = 0;
            for ($mo = 1; $mo <= 12; $mo++) {
                $nominal = isset($omsetData[$mo]) ? (float) preg_replace('/[^0-9]/', '', $omsetData[$mo]) : 0;
                $totalOmset += $nominal;
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
        }

        return compact(
            'client', 'isId1', 'hartaLabel', 'tipeName',
            'harta', 'totalHarta', 'totalOmset', 'totalPotongan',
            'detailBulan', 'bulanLabels', 'persen'
        );
    }
}
