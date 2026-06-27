@extends('cms::layouts.app')

@section('title', 'Detail Data Client')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.data-client.index') }}" class="text-decoration-none">Data Client</a></li>
    <li class="breadcrumb-item active" aria-current="page">Detail</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-person-badge me-2"></i>Detail Data Client</h6>
        <div class="d-flex gap-2">
            <a href="{{ route('cms.data-client.edit', $dataClient) }}" class="btn btn-primary btn-sm">
                <i class="bi bi-pencil me-1"></i> Edit
            </a>
            <a href="{{ route('cms.data-client.index') }}" class="btn btn-light btn-sm">
                <i class="bi bi-arrow-left me-1"></i> Kembali
            </a>
        </div>
    </div>
    <div class="card-body p-4">
        <div class="row g-4">
            <div class="col-md-6">
                <table class="table table-sm table-borderless mb-0">
                    <tr>
                        <td class="text-muted" style="width:140px">Nama Client</td>
                        <td class="fw-medium">{{ $dataClient->nama_client }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Tipe Badan</td>
                        <td><span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $dataClient->badan->tipe ?? '-' }}</span></td>
                    </tr>

                    <tr>
                        <td class="text-muted">NPWP/NIK</td>
                        <td><code>{{ $dataClient->npwp ?: '-' }}</code></td>
                    </tr>
                    <tr>
                        <td class="text-muted">NPWP Cabang</td>
                        <td><code>{{ $dataClient->npwp_cabang ?: '-' }}</code></td>
                    </tr>
                    <tr>
                        <td class="text-muted">KPP</td>
                        <td>{{ $dataClient->kpp ?: '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">AR</td>
                        <td>{{ $dataClient->AR ?: '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">PTKP</td>
                        <td>{{ $dataClient->ptkp ?: '-' }}</td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <table class="table table-sm table-borderless mb-0">
                    <tr>
                        <td class="text-muted" style="width:140px">Email</td>
                        <td>{{ $dataClient->email ?: '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">No. Telephone</td>
                        <td>{{ $dataClient->no_telephone ?: '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Alamat NPWP</td>
                        <td>{{ $dataClient->alamat_npwp ?: '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Alamat Tagihan</td>
                        <td>{{ $dataClient->alamat_tagihan ?: '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Terdaftar</td>
                        <td>{{ $dataClient->created_at ? $dataClient->created_at->format('d M Y H:i') : '-' }}</td>
                    </tr>
                    <tr>
                        <td class="text-muted">Diperbarui</td>
                        <td>{{ $dataClient->updated_at ? $dataClient->updated_at->format('d M Y H:i') : '-' }}</td>
                    </tr>
                </table>
            </div>
        </div>

        @if(($dataClient->cabangs_count ?? 0) > 0)
        <div class="mt-4 pt-3 border-top">
            <h6 class="fw-semibold mb-3"><i class="bi bi-diagram-2 me-2"></i>Cabang ({{ $dataClient->cabangs_count }})</h6>
            <div style="overflow-x: auto;">
                <table class="table table-sm table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Nama</th>
                            <th>NPWP</th>
                            <th>KPP</th>
                            <th>Email</th>
                            <th>No. Telp</th>
                            <th>Alamat NPWP</th>
                            <th>AR</th>
                            <th>PTKP</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($dataClient->cabangs as $cab)
                        <tr>
                            <td class="fw-medium">{{ $cab->nama_client }}</td>
                            <td><code>{{ $cab->npwp ?: '-' }}</code></td>
                            <td>{{ $cab->kpp ?: '-' }}</td>
                            <td><small>{{ $cab->email ?: '-' }}</small></td>
                            <td>{{ $cab->no_telephone ?: '-' }}</td>
                            <td><small class="text-muted">{{ Str::limit($cab->alamat_npwp, 40) ?: '-' }}</small></td>
                            <td>{{ $cab->AR ?: '-' }}</td>
                            <td>{{ $cab->ptkp ?: '-' }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
        @endif
    </div>
</div>
@endsection
