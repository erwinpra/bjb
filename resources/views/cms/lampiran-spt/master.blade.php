@extends('cms::layouts.app')

@section('title', 'Master Lampiran SPT')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.lampiran-spt.index') }}" class="text-decoration-none">Lampiran SPT</a></li>
    <li class="breadcrumb-item active" aria-current="page">Master Kategori</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
        <h6 class="fw-semibold mb-0"><i class="bi bi-diagram-3 me-2"></i>Master Kategori Lampiran SPT</h6>
    </div>
    <div class="card-body p-4">
        <p class="text-muted small mb-4">
            Berikut adalah daftar kategori dan sub-item Lampiran SPT Tahunan.
            Data ini adalah referensi master yang digunakan untuk mengisi nilai SPT per client.
        </p>

        @forelse($kategoris as $kat)
        <div class="card border mb-3">
            <div class="card-header bg-light py-2">
                <h6 class="fw-semibold mb-0">
                    {{ $kategoriLabels[$kat->label] ?? $kat->label }}
                </h6>
            </div>
            <div class="card-body p-0">
                <table class="table table-sm mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4" style="width:100px">Kode</th>
                            <th>Nama</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($kat->masterLampiranSpts as $item)
                        <tr>
                            <td class="ps-4"><code>{{ $item->sub_kode }}</code></td>
                            <td>{{ $item->nama }}</td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
        @empty
        <div class="text-center text-muted py-5">
            <i class="bi bi-inbox display-4 d-block mb-2 text-secondary opacity-50"></i>
            Belum ada data master. Jalankan seeder untuk mengisi data default.
        </div>
        @endforelse

        <div class="d-flex justify-content-end mt-3">
            <a href="{{ route('cms.lampiran-spt.index') }}" class="btn btn-primary px-4">
                <i class="bi bi-arrow-left me-1"></i> Kembali ke Input SPT
            </a>
        </div>
    </div>
</div>
@endsection
