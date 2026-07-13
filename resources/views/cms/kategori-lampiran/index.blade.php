@extends('cms::layouts.app')

@section('title', 'Kategori Lampiran')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Kategori Lampiran</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-tags me-2"></i>All Kategori Lampiran</h6>
            @cmsCan('kategori_lampiran', 'create')
            <a href="{{ route('cms.kategori-lampiran.create') }}" class="btn btn-primary btn-sm">
                <i class="bi bi-plus-lg me-1"></i> Create Kategori
            </a>
            @endCmsCan
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Label</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($kategoris as $k)
                        <tr>
                            <td class="ps-4 text-muted small">#{{ $k->id }}</td>
                            <td class="fw-medium">{{ $k->label }}</td>
                            <td class="text-end pe-4">
                                @cmsCan('kategori_lampiran', 'edit')
                                <a href="{{ route('cms.kategori-lampiran.edit', $k) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                @endCmsCan
                                @cmsCan('kategori_lampiran', 'delete')
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteKategori{{ $k->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                                <div class="modal fade" id="deleteKategori{{ $k->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0"><h6 class="fw-semibold">Confirm Delete</h6><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                            <div class="modal-body text-start"><p class="small mb-0">Delete kategori <strong>"{{ $k->label }}"</strong>?</p></div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.kategori-lampiran.destroy', $k) }}">
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
                            <td colspan="3" class="text-center py-5 text-muted">
                                <i class="bi bi-tags display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No kategori yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($kategoris->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $kategoris->links('pagination::bootstrap-4') }}</div>
        @endif
    </div>
@endsection
