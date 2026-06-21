<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\Controller;
use App\Models\Cms\Badan;
use App\Models\Cms\MasterRumus;
use App\Models\Cms\Transaksi;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use PDF;

class DashboardController extends Controller
{
    public function index()
    {
        $client = Auth::guard('client')->user();
        $tahun = request('tahun', date('Y'));
        return view('client.dashboard', compact('client', 'tahun'));
    }

    public function data(Request $request)
    {
        $client = Auth::guard('client')->user();
        $tahun = $request->tahun ?? date('Y');

        $transaksi = Transaksi::where('client_id', $client->id)
            ->where('tahun', $tahun)
            ->with(['harta', 'omset'])
            ->latest('id')
            ->first();

        $omsetPerBulan = [];
        for ($mo = 1; $mo <= 12; $mo++) {
            $omsetPerBulan[$mo] = 0;
        }

        if ($transaksi) {
            foreach ($transaksi->omset as $o) {
                $omsetPerBulan[(int) $o->bulan] = (float) $o->nominal;
            }
        }

        $hartaDetail = [];
        if ($transaksi) {
            foreach ($transaksi->harta as $h) {
                $hartaDetail[] = ['nama' => $h->nama, 'nilai' => (float) $h->nilai];
            }
        }

        return response()->json([
            'exists' => $transaksi ? true : false,
            'total_harta' => $transaksi ? (float) $transaksi->harta->sum('nilai') : 0,
            'total_omset' => $transaksi ? (float) $transaksi->omset->sum('nominal') : 0,
            'total_pph' => $transaksi ? (float) $transaksi->total_pph : 0,
            'harta_detail' => $hartaDetail,
            'omset_per_bulan' => array_values($omsetPerBulan),
            'bulan_labels' => ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'],
        ]);
    }

    public function exportPdf(Request $request)
    {
        $client = Auth::guard('client')->user();
        $tahun = $request->tahun ?? date('Y');
        $data = $this->buildDashboardExport($client, $tahun);

        $pdf = PDF::loadView('client.export-pdf', $data);
        return $pdf->download('dashboard_' . $client->nama_client . '_' . $tahun . '.pdf');
    }

    public function exportExcel(Request $request)
    {
        $client = Auth::guard('client')->user();
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

        $transaksi = Transaksi::where('client_id', $client->id)
            ->where('tahun', $tahun)
            ->with(['harta', 'omset'])
            ->latest('id')
            ->first();

        $harta = [];
        $totalHarta = 0;
        if ($transaksi) {
            foreach ($transaksi->harta as $h) {
                $harta[] = ['nama' => $h->nama, 'nilai' => (float) $h->nilai];
                $totalHarta += (float) $h->nilai;
            }
        }

        $bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
        $totalOmset = 0;
        $totalPotongan = 0;
        $detailBulan = [];
        $cumulative = 0;

        for ($mo = 1; $mo <= 12; $mo++) {
            $nominal = 0;
            if ($transaksi) {
                $omsetItem = $transaksi->omset->firstWhere('bulan', $mo);
                $nominal = $omsetItem ? (float) $omsetItem->nominal : 0;
            }
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

        return compact(
            'client', 'tahun', 'isId1', 'hartaLabel', 'tipeName',
            'harta', 'totalHarta', 'totalOmset', 'totalPotongan',
            'detailBulan', 'persen'
        );
    }
}
