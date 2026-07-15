@extends('cms::layouts.app')

@section('title', 'Master Lampiran SPT')

@push('styles')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
.select2-container--default .select2-selection--multiple {
    border: 1px solid #dee2e6;
    border-radius: 0.25rem;
    min-height: 31px;
}
.select2-container--default .select2-selection--multiple .select2-selection__choice {
    font-size: 0.8rem;
    padding: 1px 6px;
}
</style>
@endpush

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Master Lampiran SPT</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h6 class="fw-semibold mb-0"><i class="bi bi-list-check me-2"></i>All Master Lampiran SPT</h6>
                <div class="d-flex gap-2">
                    <form method="GET" action="{{ route('cms.master-lampiran-spt.index') }}" class="d-flex gap-2 align-items-center">
                        <select name="kategori_ids[]" id="kategoriFilter" class="form-select form-select-sm" multiple style="min-width:180px; max-width:240px">
                            @foreach($kategoris as $k)
                                <option value="{{ $k->id }}" {{ in_array($k->id, $kategoriIds ?? []) ? 'selected' : '' }}>{{ $k->label }}</option>
                            @endforeach
                        </select>
                        <input type="text" name="search" class="form-control form-control-sm" placeholder="Cari item..." value="{{ $search ?? '' }}" style="width:150px">
                        <button type="submit" class="btn btn-sm btn-outline-secondary"><i class="bi bi-search"></i></button>
                        @if(!empty($search) || !empty($kategoriIds))
                            <a href="{{ route('cms.master-lampiran-spt.index') }}" class="btn btn-sm btn-outline-danger"><i class="bi bi-x-lg"></i></a>
                        @endif
                    </form>
                    @cmsCan('master_lampiran_spt', 'create')
                    <a href="{{ route('cms.master-lampiran-spt.create') }}" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus-lg me-1"></i> Create Item
                    </a>
                    @endCmsCan
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Kategori</th>
                            <th>Sub Kode</th>
                            <th>Nama</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($items as $item)
                        <tr>
                            <td class="ps-4 text-muted small">#{{ $item->id }}</td>
                            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $item->kategori->label ?? '-' }}</span></td>
                            <td><code>{{ $item->sub_kode }}</code></td>
                            <td class="fw-medium">{{ $item->nama }}</td>
                            <td class="text-end pe-4">
                                @cmsCan('master_lampiran_spt', 'edit')
                                <a href="{{ route('cms.master-lampiran-spt.edit', $item) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                @endCmsCan
                                @cmsCan('master_lampiran_spt', 'delete')
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteItem{{ $item->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                                <div class="modal fade" id="deleteItem{{ $item->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0"><h6 class="fw-semibold">Confirm Delete</h6><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                            <div class="modal-body text-start"><p class="small mb-0">Delete master item <strong>"{{ $item->sub_kode }} - {{ $item->nama }}"</strong>?</p></div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.master-lampiran-spt.destroy', $item) }}">
                                                    @csrf @method('DELETE')
                                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                @endCmsCan
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-list-check display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No master items yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($items->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $items->appends(['search' => $search, 'kategori_ids' => $kategoriIds])->links('pagination::bootstrap-4') }}</div>
        @endif
    </div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
$(document).ready(function() {
    $('#kategoriFilter').select2({
        placeholder: 'Filter Kategori',
        allowClear: true,
        width: '100%',
    });
});
</script>
@endpush
