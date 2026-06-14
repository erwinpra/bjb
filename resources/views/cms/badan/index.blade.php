@extends('cms::layouts.app')

@section('title', 'Badan')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Badan</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-building me-2"></i>Daftar Badan</h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Tipe</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($badan as $b)
                        <tr>
                            <td class="ps-4 text-muted small">#{{ $b->id }}</td>
                            <td class="fw-medium">{{ $b->tipe }}</td>
                            <td class="text-end pe-4">
                                <a href="{{ route('cms.badan.edit', $b) }}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="3" class="text-center py-5 text-muted">
                                <i class="bi bi-building display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No badan yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($badan->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $badan->links('pagination::bootstrap-5') }}</div>
        @endif
    </div>
@endsection
