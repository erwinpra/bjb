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
        .sub-section-title { font-size: 10pt; font-weight: bold; margin: 15px 0 5px; border-bottom: 1px solid #999; padding-bottom: 2px; }
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

    @foreach($allTabs as $tab)
    <div class="section-title">{{ $tab['label'] }}</div>

    @if($tab['npwp'])
    <table class="client-info">
        <tr><td style="width:80px"><strong>NPWP</strong></td><td>{{ $tab['npwp'] }}</td></tr>
    </table>
    @endif

    @if($isId1)
    <table>
        <tr><th>Periode</th><th class="text-end">Peredaran Bruto</th></tr>
        <tr><td>Tahunan</td><td class="text-end">Rp {{ number_format($tab['total_omset'], 0, ',', '.') }}</td></tr>
    </table>
    @else
    <table>
        <thead>
            <tr>
                <th>Bulan</th>
                <th class="text-end">Peredaran Bruto</th>
                <th class="text-end">Total Peredaran Bruto Cabang</th>
                <th class="text-end">Total Peredaran Bruto Akum ({{ $cabangCount }} Cabang)</th>
                <th class="text-end">PPH Final {{ number_format($persen, 1) }}%</th>
                <th class="text-end">PPh Final yg harus dibayar</th>
            </tr>
        </thead>
        <tbody>
            @foreach($tab['detail_bulan'] as $row)
            @if($row['omset'] !== '')
            <tr>
                <td>{{ $row['bulan'] }}</td>
                <td class="text-end">{{ $row['omset'] }}</td>
                <td class="text-end">{{ $row['totalBruto'] }}</td>
                <td class="text-end">{{ $row['totalBrutoAkum'] ?: '-' }}</td>
                <td class="text-end">{{ $row['pphFinal'] }}</td>
                <td class="text-end">{{ $row['pphBayar'] }}</td>
            </tr>
            @endif
            @endforeach
            <tr class="fw-bold">
                <td>Total</td>
                <td class="text-end">Rp {{ number_format($tab['total_omset'], 0, ',', '.') }}</td>
                <td></td>
                <td></td>
                <td></td>
                <td class="text-end">Rp {{ number_format($tab['total_potongan'], 0, ',', '.') }}</td>
            </tr>
        </tbody>
    </table>
    @endif
    @endforeach

    <div class="section-title">Total Keseluruhan</div>
    @foreach($allTabs as $tab)
    <div class="sub-section-title">{{ $tab['label'] }} ({{ $tab['npwp'] ?: 'NPWP: -' }})</div>
    <table>
        <tr><td style="width:200px"><strong>KPP</strong></td><td>{{ $tab['kpp'] ?: '-' }}</td></tr>
        <tr><td><strong>Total Omset</strong></td><td class="text-end fw-bold">Rp {{ number_format($tab['total_omset'], 0, ',', '.') }}</td></tr>
        @if(!$isId1)
        <tr><td><strong>Total PPh Final yg harus dibayar</strong></td><td class="text-end fw-bold">Rp {{ number_format($tab['total_potongan'], 0, ',', '.') }}</td></tr>
        @endif
    </table>
    @endforeach
</body>
</html>
