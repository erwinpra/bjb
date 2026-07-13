@extends('cms::layouts.app')

@section('title', 'Master Rumus')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Master Rumus</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-calculator me-2"></i>All Master Rumus</h6>
            <div class="d-flex gap-2">
                @cmsCan('master_rumus', 'create')
                <a href="{{ route('cms.master-rumus.create') }}" class="btn btn-primary btn-sm">
                    <i class="bi bi-plus-lg me-1"></i> Create Master Rumus
                </a>
                @endCmsCan
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Tipe Badan</th>
                            <th>Max Value</th>
                            <th>Potongan %</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($rumus as $r)
                        <tr>
                            <td class="ps-4 text-muted small">#{{ $r->id }}</td>
                            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $r->badan->tipe ?? $r->tipe_badan }}</span></td>
                            <td>Rp {{ number_format($r->max_value, 0, ',', '.') }}</td>
                            <td>{{ number_format($r->potongan_persentase, 2) }}%</td>
                            <td class="text-end pe-4">
                                @cmsCan('master_rumus', 'edit')
                                <a href="{{ route('cms.master-rumus.edit', $r) }}" class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></a>
                                @endCmsCan
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-calculator display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No master rumus yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($rumus->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $rumus->links('pagination::bootstrap-4') }}</div>
        @endif
    </div>
@endsection
