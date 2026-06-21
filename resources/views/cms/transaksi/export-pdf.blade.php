<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Transaksi - {{ $client->nama_client }}</title>
    <style>
        body { font-family: sans-serif; font-size: 11pt; color: #333; }
        h2 { text-align: center; margin-bottom: 5px; }
        h4 { text-align: center; margin-top: 0; color: #666; font-weight: normal; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 15px; font-size: 10pt; }
        th, td { padding: 5px 8px; border: 1px solid #ccc; text-align: left; }
        th { background: #f0f0f0; }
        .text-end { text-align: right; }
        .fw-bold { font-weight: bold; }
        .text-muted { color: #999; }
        .section-title { font-size: 11pt; font-weight: bold; margin: 20px 0 5px; border-bottom: 2px solid #333; padding-bottom: 3px; }
        .client-info { margin-bottom: 20px; }
        .client-info td { border: none; padding: 2px 8px; }
    </style>
</head>
<body>
    <h2>Laporan Transaksi</h2>
    <h4>Tahun {{ request('tahun') }}</h4>

    <table class="client-info">
        <tr><td style="width:100px"><strong>Nama</strong></td><td>{{ $client->nama_client }}</td></tr>
        <tr><td><strong>NPWP</strong></td><td>{{ $client->npwp ?? '-' }}</td></tr>
        <tr><td><strong>Tipe</strong></td><td>{{ $tipeName }}</td></tr>
        <tr><td><strong>Tahun</strong></td><td>{{ request('tahun') }}</td></tr>
    </table>

    @if(count($harta))
    <div class="section-title">{{ $hartaLabel }}</div>
    <table>
        <thead>
            <tr><th>Nama</th><th class="text-end">Nilai</th></tr>
        </thead>
        <tbody>
            @foreach($harta as $h)
            <tr><td>{{ $h['nama'] }}</td><td class="text-end">Rp {{ number_format($h['nilai'], 0, ',', '.') }}</td></tr>
            @endforeach
            <tr class="fw-bold"><td>Total {{ $hartaLabel }}</td><td class="text-end">Rp {{ number_format($totalHarta, 0, ',', '.') }}</td></tr>
        </tbody>
    </table>
    @endif

    @if($isId1)
    <div class="section-title">Omset Tahunan</div>
    <table>
        <tr><th>Periode</th><th class="text-end">Omset</th></tr>
        <tr><td>Tahunan</td><td class="text-end">Rp {{ number_format($totalOmset, 0, ',', '.') }}</td></tr>
    </table>
    @else
    <div class="section-title">Omset Per Bulan & Perhitungan PPh Final</div>
    <table>
        <thead>
            <tr>
                <th>Bulan</th>
                <th class="text-end">Omset</th>
                <th class="text-end">Total Peredaran Bruto</th>
                <th class="text-end">PPH Final 0.5%</th>
                <th class="text-end">PPh Final yg harus dibayar</th>
            </tr>
        </thead>
        <tbody>
            @foreach($detailBulan as $row)
            <tr>
                <td>{{ $row['bulan'] }}</td>
                <td class="text-end">{{ $row['omset'] }}</td>
                <td class="text-end">{{ $row['totalBruto'] }}</td>
                <td class="text-end">{{ $row['pphFinal'] }}</td>
                <td class="text-end">{{ $row['pphBayar'] }}</td>
            </tr>
            @endforeach
        </tbody>
    </table>
    @endif

    <div class="section-title">Total Keseluruhan</div>
    <table>
        <tr><td style="width:200px"><strong>Total {{ $hartaLabel }}</strong></td><td class="text-end fw-bold">Rp {{ number_format($totalHarta, 0, ',', '.') }}</td></tr>
        <tr><td><strong>Total Omset</strong></td><td class="text-end fw-bold">Rp {{ number_format($totalOmset, 0, ',', '.') }}</td></tr>
        @if(!$isId1)
        <tr><td><strong>Total PPh Final yg harus dibayar</strong></td><td class="text-end fw-bold">Rp {{ number_format($totalPotongan, 0, ',', '.') }}</td></tr>
        @endif
    </table>
</body>
</html>
