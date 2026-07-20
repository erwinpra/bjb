@extends('cms::layouts.app')

@section('title', 'Import Transaksi')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.transaksi.index') }}" class="text-decoration-none">Transaksi</a></li>
    <li class="breadcrumb-item active" aria-current="page">Import</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-upload me-2"></i>Import Transaksi dari Excel</h6>
    </div>
    <div class="card-body p-4">
        @if(!isset($preview))
            <form method="POST" action="{{ route('cms.transaksi.import.preview') }}" enctype="multipart/form-data">
                @csrf
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">File Excel <span class="text-danger">*</span></label>
                        <input type="file" name="file" class="form-control @error('file') is-invalid @enderror" accept=".xlsx,.xls" required>
                        @error('file') <div class="invalid-feedback">{{ $message }}</div> @enderror
                        <div class="form-text small">Format: NPWP Client, NPWP Cabang (kosongkan untuk induk), Tahun, Omset Tahunan/Bulanan, Harta</div>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                    <a href="{{ route('cms.transaksi.import.template') }}" class="btn btn-outline-secondary btn-sm">
                        <i class="bi bi-download me-1"></i> Download Template Excel
                    </a>
                    <div class="d-flex gap-2">
                        <a href="{{ route('cms.transaksi.index') }}" class="btn btn-light">Batal</a>
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-eye me-1"></i> Preview Data
                        </button>
                    </div>
                </div>
            </form>
        @else
            <div class="alert alert-info small">
                <i class="bi bi-info-circle-fill me-1"></i>
                Ditemukan <strong>{{ $totalRows }}</strong> baris data. Data akan di-import sesuai dengan tipe badan masing-masing client.
            </div>

            @php
                $validCount = count(array_filter($preview, function ($p) { return $p['valid']; }));
                $invalidCount = $totalRows - $validCount;
            @endphp

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="card bg-primary bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-primary">{{ $totalRows }}</div>
                        <small class="text-muted">Total Baris</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-success bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-success">{{ $validCount }}</div>
                        <small class="text-muted">Valid</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card bg-danger bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-danger">{{ $invalidCount }}</div>
                        <small class="text-muted">Error</small>
                    </div>
                </div>
            </div>

            @if($invalidCount > 0)
            <div class="alert alert-warning py-2 small mb-4">
                <i class="bi bi-exclamation-triangle me-1"></i>
                <strong>{{ $invalidCount }}</strong> baris memiliki error dan tidak akan diimport. Perbaiki data di Excel lalu upload ulang.
            </div>
            @endif

            <div style="overflow-x: auto; max-height:450px">
                <table class="table table-sm table-hover mb-0" id="previewTable">
                    <thead class="table-light sticky-top">
                        <tr>
                            <th>#</th>
                            <th>NPWP Client</th>
                            <th>Nama Client</th>
                            <th>NPWP Cabang</th>
                            <th>Nama Cabang</th>
                            <th>Tahun</th>
                            @foreach($months as $m)
                            <th class="text-end">{{ $m }}</th>
                            @endforeach
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($preview as $i => $item)
                        <tr class="{{ $item['valid'] ? ($item['is_cabang'] ? 'table-info' : '') : 'table-danger' }}">
                            <td>{{ $i + 1 }}</td>
                            <td><code>{{ $item['npwp_client'] ?: '-' }}</code></td>
                            <td>{{ $item['client_nama'] }}</td>
                            <td><code>{{ $item['npwp_cabang'] ?: '-' }}</code></td>
                            <td>{{ $item['cabang_nama'] ?: '-' }}</td>
                            <td>{{ $item['tahun'] }}</td>
                            @foreach($item['omset_bulanan'] as $om)
                            <td class="text-end">{{ $om ?: '-' }}</td>
                            @endforeach
                            <td>
                                @if($item['valid'])
                                    @if($item['is_cabang'])
                                        <span class="badge bg-info text-white">Cabang</span>
                                    @else
                                        <span class="badge bg-success">Induk</span>
                                    @endif
                                @else
                                    <span class="badge bg-danger" title="{{ implode('; ', $item['errors']) }}">Error</span>
                                @endif
                            </td>
                        </tr>
                        @if(!$item['valid'])
                        <tr class="table-danger">
                            <td colspan="{{ 8 + 12 }}">
                                <small class="text-danger"><i class="bi bi-x-circle me-1"></i>{{ implode('; ', $item['errors']) }}</small>
                            </td>
                        </tr>
                        @endif
                        @empty
                        <tr><td colspan="{{ 8 + 12 }}" class="text-center text-muted py-4">Tidak ada data.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                <a href="{{ route('cms.transaksi.import') }}" class="btn btn-light">
                    <i class="bi bi-arrow-left me-1"></i> Upload Ulang
                </a>
                <form method="POST" action="{{ route('cms.transaksi.import.confirm') }}" id="confirmForm">
                    @csrf
                    <input type="hidden" name="temp_path" value="{{ $tempPath }}">
                    <button type="submit" class="btn btn-primary px-4" id="confirmBtn" {{ $validCount === 0 ? 'disabled' : '' }}>
                        <i class="bi bi-check-lg me-1"></i> Import {{ $validCount }} Data
                    </button>
                </form>
            </div>

            <div id="loadingBackdrop" class="d-none" style="position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);z-index:9999;display:flex;align-items:center;justify-content:center;">
                <div class="text-center text-white">
                    <div class="spinner-border mb-3" role="status" style="width:3rem;height:3rem;"></div>
                    <div class="fw-semibold">Sedang memproses import...</div>
                </div>
            </div>

            @push('scripts')
            <script>
            document.getElementById('confirmForm')?.addEventListener('submit', function(e) {
                var count = {{ $validCount }};
                if (!confirm('Import ' + count + ' data transaksi? Data dengan NPWP Client + Tahun + NPWP Cabang yang sama akan diperbarui.')) {
                    e.preventDefault();
                } else {
                    document.getElementById('loadingBackdrop').classList.remove('d-none');
                }
            });
            </script>
            @endpush
        @endif
    </div>
</div>
@endsection
