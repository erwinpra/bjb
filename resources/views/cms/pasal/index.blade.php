@extends('cms::layouts.app')

@section('title', 'Pasal')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Pasal</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h6 class="fw-semibold mb-0"><i class="bi bi-journal-text me-2"></i>All Pasal</h6>
                <div class="d-flex gap-2">
                    <form method="GET" action="{{ route('cms.pasal.index') }}" class="d-flex gap-2">
                        <input type="text" name="search" class="form-control form-control-sm" placeholder="Cari pasal..." value="{{ $search ?? '' }}">
                        <button type="submit" class="btn btn-sm btn-outline-secondary"><i class="bi bi-search"></i></button>
                        @if(!empty($search))
                            <a href="{{ route('cms.pasal.index') }}" class="btn btn-sm btn-outline-danger"><i class="bi bi-x-lg"></i></a>
                        @endif
                    </form>
                    @cmsCan('pasal', 'create')
                    <a href="{{ route('cms.pasal.create') }}" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus-lg me-1"></i> Create Pasal
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
                            <th>Nama Pasal</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($pasal as $p)
                        <tr>
                            <td class="ps-4 text-muted small">#{{ $p->id }}</td>
                            <td class="fw-medium">{{ $p->nama_pasal }}</td>
                            <td>
                                @if($p->is_active)
                                    <span class="badge bg-success-subtle text-success px-3 py-1 rounded-pill">
                                        <i class="bi bi-check-circle-fill me-1 small"></i> Active
                                    </span>
                                @else
                                    <span class="badge bg-secondary-subtle text-secondary px-3 py-1 rounded-pill">Inactive</span>
                                @endif
                            </td>
                            <td class="text-end pe-4">
                                @cmsCan('pasal', 'edit')
                                <a href="{{ route('cms.pasal.edit', $p) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                @endCmsCan
                                @cmsCan('pasal', 'delete')
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deletePasal{{ $p->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                                <div class="modal fade" id="deletePasal{{ $p->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0"><h6 class="fw-semibold">Confirm Delete</h6><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                            <div class="modal-body text-start"><p class="small mb-0">Delete pasal <strong>"{{ $p->nama_pasal }}"</strong>?</p></div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.pasal.destroy', $p) }}">
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
                            <td colspan="4" class="text-center py-5 text-muted">
                                <i class="bi bi-journal-text display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No pasal yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($pasal->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $pasal->appends(['search' => $search])->links('pagination::bootstrap-4') }}</div>
        @endif
    </div>
@endsection
