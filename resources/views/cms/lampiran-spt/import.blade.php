@extends('cms::layouts.app')

@section('title', 'Preview Import Lampiran SPT')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.lampiran-spt.index') }}" class="text-decoration-none">Lampiran SPT</a></li>
    <li class="breadcrumb-item active" aria-current="page">Preview Import</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-file-earmark-spreadsheet me-2"></i>Preview Import Lampiran SPT</h6>
    </div>
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <span class="badge bg-info fs-6 me-2">
                    <i class="bi bi-person me-1"></i>{{ $client->nama_client ?? 'Unknown' }}
                    <span class="ms-1 text-white-50">({{ $client->npwp ?? 'N/A' }})</span>
                </span>
                <span class="badge bg-primary fs-6 me-2">
                    <i class="bi bi-calendar me-1"></i>Tahun {{ $tahun }}
                </span>
                <span class="badge bg-success fs-6 me-2">{{ $validCount }} data valid</span>
                <span class="badge bg-secondary fs-6">{{ $totalRows }} total baris</span>
            </div>
        </div>

        @if($totalRows > 0)
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle" style="font-size:0.85rem">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>KODE</th>
                        <th>DESKRIPSI</th>
                        <th>NOMOR AKUN</th>
                        <th>ATAS NAMA</th>
                        <th>BANK/INSTITUSI</th>
                        <th>LOKASI HARTA</th>
                        <th>KURS</th>
                        <th>THN PEROLEHAN</th>
                        <th class="text-end">SALDO SAAT INI</th>
                        <th class="text-end">SALDO AWAL</th>
                        <th>STATUS</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($preview as $idx => $item)
                    <tr class="{{ $item['valid'] ? '' : 'table-danger' }}">
                        <td>{{ $idx + 1 }}</td>
                        <td><code>{{ $item['kode'] }}</code></td>
                        <td>{{ $item['deskripsi'] }}</td>
                        <td>{{ $item['nomor_akun'] }}</td>
                        <td>{{ $item['atas_nama'] }}</td>
                        <td>{{ $item['nama_bank_institusi'] }}</td>
                        <td>{{ $item['lokasi_harta'] }}</td>
                        <td>{{ $item['kurs'] }}</td>
                        <td>{{ $item['tahun_perolehan'] }}</td>
                        <td class="text-end">{{ $item['saldo_saat_ini'] !== '' ? (strpos($item['saldo_saat_ini'], '.') !== false ? $item['saldo_saat_ini'] : $item['saldo_saat_ini'] . '.00') : '-' }}</td>
                        <td class="text-end">{{ $item['saldo_bentuk_awal'] !== '' ? (strpos($item['saldo_bentuk_awal'], '.') !== false ? $item['saldo_bentuk_awal'] : $item['saldo_bentuk_awal'] . '.00') : '-' }}</td>
                        <td>
                            @if($item['valid'])
                                <span class="badge bg-success">Valid</span>
                            @else
                                <span class="badge bg-danger">{{ implode(', ', $item['errors']) }}</span>
                            @endif
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>

        <form method="POST" action="{{ route('cms.lampiran-spt.import.confirm') }}" class="d-flex justify-content-between mt-3">
            @csrf
            <input type="hidden" name="temp_path" value="{{ $tempPath }}">
            <input type="hidden" name="client_id" value="{{ $clientId }}">
            <input type="hidden" name="tahun" value="{{ $tahun }}">
            <a href="{{ route('cms.lampiran-spt.index') }}" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Kembali
            </a>
            @if($validCount > 0)
            <button type="submit" class="btn btn-success px-4">
                <i class="bi bi-check-lg me-1"></i> Konfirmasi Import
            </button>
            @endif
        </form>
        @else
        <div class="text-center text-muted py-5">
            <i class="bi bi-inbox display-4 d-block mb-2 text-secondary opacity-50"></i>
            Tidak ada data yang ditemukan.
        </div>
        @endif
    </div>
</div>
@endsection
