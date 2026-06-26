@extends('cms::layouts.app')

@section('title', 'Data Client')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Data Client</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-person-badge me-2"></i>All Data Client</h6>
            <div class="d-flex gap-2">
                <a href="{{ route('cms.data-client.import') }}" class="btn btn-info btn-sm text-white">
                    <i class="bi bi-upload me-1"></i> Import Excel
                </a>
                <a href="{{ route('cms.data-client.create') }}" class="btn btn-primary btn-sm">
                    <i class="bi bi-plus-lg me-1"></i> Create Data Client
                </a>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Nama Client</th>
                            <th>Tipe Badan</th>
                            <th>Client Role</th>
                            <th>NPWP/NIK</th>
                            <th>Email</th>
                            <th>KPP</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($dataClients as $d)
                        <tr>
                            <td class="fw-medium">{{ $d->nama_client }}</td>
                            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $d->badan->tipe ?? '-' }}</span></td>
                            <td>
                                @if($d->clientRole)
                                    <span class="badge bg-info bg-opacity-10 text-info">{{ $d->clientRole->name }}</span>
                                @else
                                    <span class="text-muted small">-</span>
                                @endif
                            </td>
                            <td><code class="small">{{ $d->npwp ?: '-' }}</code></td>
                            <td><span class="small">{{ $d->email ?: '-' }}</span></td>
                            <td><span class="small">{{ $d->kpp ?: '-' }}</span></td>
                            <td class="text-end pe-4">
                                <a href="{{ route('cms.data-client.edit', $d) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteDC{{ $d->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                                <div class="modal fade" id="deleteDC{{ $d->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0"><h6 class="fw-semibold">Confirm Delete</h6><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
                                            <div class="modal-body text-start"><p class="small mb-0">Delete <strong>"{{ $d->nama_client }}"</strong>?</p></div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.data-client.destroy', $d) }}">
                                                    @csrf @method('DELETE')
                                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                <i class="bi bi-person-badge display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No data client yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($dataClients->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $dataClients->links('pagination::bootstrap-4') }}</div>
        @endif
    </div>
@endsection
