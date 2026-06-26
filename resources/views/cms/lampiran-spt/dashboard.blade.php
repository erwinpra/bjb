@extends('cms::layouts.app')

@section('title', 'Dashboard Client')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Dashboard Client</li>
@endpush

@push('styles')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
.select2-container--default .select2-selection--single {
    border: 1px solid #dee2e6;
    height: calc(2.25rem + 2px);
    padding: .25rem .5rem;
}
.select2-container--default .select2-selection--single .select2-selection__rendered {
    line-height: 1.5;
}
</style>
@endpush

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
$(document).ready(function() {
    $('select[name="client_id"]').select2({
        placeholder: '-- Cari & Pilih Client --',
        allowClear: true,
        width: '100%'
    });
});
</script>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-bar-chart-line me-2"></i>Dashboard Perbandingan Harta Client</h6>
    </div>
    <div class="card-body p-4">
        <form method="GET" action="{{ route('cms.lampiran-spt.dashboard') }}" class="row g-3 mb-4">
            <div class="col-md-6">
                <label class="form-label fw-semibold small">Client</label>
                <select name="client_id" class="form-select" required>
                    <option value="">-- Pilih Client --</option>
                    @foreach($clients as $c)
                        <option value="{{ $c->id }}" {{ $clientId == $c->id ? 'selected' : '' }}>
                            {{ $c->nama_client }} ({{ $c->npwp ?: '-' }})
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-6 d-flex align-items-end">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="bi bi-search me-1"></i> Tampilkan
                </button>
            </div>
        </form>

        @if($clientId)
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th style="width:40px">#</th>
                            <th>POINT</th>
                            <th class="text-end">2024</th>
                            <th class="text-end">2025 DJP</th>
                            <th class="text-end">2025 CTX</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php $rowNum = 0; @endphp
                        @foreach($grouped as $kategori => $items)
                            <tr class="table-secondary">
                                <td colspan="5" class="fw-bold">
                                    {{ $kategoriLabels[$kategori] ?? $kategori }}
                                </td>
                            </tr>
                            @foreach($items as $item)
                                @php $rowNum++; @endphp
                                <tr>
                                    <td class="text-muted small">{{ $rowNum }}</td>
                                    <td>
                                        <code>{{ $item['sub_kode'] }}</code>
                                        {{ $item['sub_nama'] }}
                                    </td>
                                    <td class="text-end">{{ $item['val_2024'] > 0 ? 'Rp ' . number_format($item['val_2024'], 0, ',', '.') : '-' }}</td>
                                    <td class="text-end">{{ $item['val_2025_djp'] > 0 ? 'Rp ' . number_format($item['val_2025_djp'], 0, ',', '.') : '-' }}</td>
                                    <td class="text-end">{{ $item['val_2025_ctx'] > 0 ? 'Rp ' . number_format($item['val_2025_ctx'], 0, ',', '.') : '-' }}</td>
                                </tr>
                            @endforeach
                            <tr class="table-active fw-bold">
                                <td colspan="2" class="text-end">TOTAL {{ $kategoriLabels[$kategori] ?? $kategori }}</td>
                                <td class="text-end text-primary">
                                    Rp {{ number_format($totals[$kategori]['val_2024'], 0, ',', '.') }}
                                </td>
                                <td class="text-end text-primary">
                                    Rp {{ number_format($totals[$kategori]['val_2025_djp'], 0, ',', '.') }}
                                </td>
                                <td class="text-end text-primary">
                                    Rp {{ number_format($totals[$kategori]['val_2025_ctx'], 0, ',', '.') }}
                                </td>
                            </tr>
                        @endforeach
                        <tr class="table-danger fw-bold fs-6">
                            <td colspan="2" class="text-end">TOTAL HARTA</td>
                            <td class="text-end">
                                Rp {{ number_format($grandTotal['val_2024'], 0, ',', '.') }}
                            </td>
                            <td class="text-end">
                                Rp {{ number_format($grandTotal['val_2025_djp'], 0, ',', '.') }}
                            </td>
                            <td class="text-end">
                                Rp {{ number_format($grandTotal['val_2025_ctx'], 0, ',', '.') }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        @else
            <div class="text-center text-muted py-5">
                <i class="bi bi-hand-index display-4 d-block mb-2 text-secondary opacity-50"></i>
                Pilih client untuk melihat perbandingan harta.
            </div>
        @endif
    </div>
</div>
@endsection
