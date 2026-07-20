@extends('cms::layouts.app')

@section('title', 'Master Ecommerce')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Master Ecommerce</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h6 class="fw-semibold mb-0"><i class="bi bi-cart me-2"></i>All Master Ecommerce</h6>
                <div class="d-flex gap-2">
                    <form method="GET" action="{{ route('cms.master-ecommerce.index') }}" class="d-flex gap-2 align-items-center">
                        <input type="text" name="search" class="form-control form-control-sm" placeholder="Cari ecommerce..." value="{{ $search ?? '' }}" style="width:200px">
                        <button type="submit" class="btn btn-sm btn-outline-secondary"><i class="bi bi-search"></i></button>
                        @if(!empty($search))
                            <a href="{{ route('cms.master-ecommerce.index') }}" class="btn btn-sm btn-outline-danger"><i class="bi bi-x-lg"></i></a>
                        @endif
                    </form>
                    @cmsCan('master_ecommerce', 'create')
                    <a href="{{ route('cms.master-ecommerce.create') }}" class="btn btn-primary btn-sm">
                        <i class="bi bi-plus-lg me-1"></i> Create
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
                            <th>Kode Ecommerce</th>
                            <th>Deskripsi</th>
                            <th style="width:100px">Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($items as $item)
                        <tr>
                            <td class="ps-4 text-muted small">#{{ $item->id }}</td>
                            <td><code>{{ $item->kode_ecommerce }}</code></td>
                            <td>{{ $item->deskripsi ?? '-' }}</td>
                            <td>
                                @if($item->is_active)
                                    <span class="badge bg-success">Active</span>
                                @else
                                    <span class="badge bg-secondary">Inactive</span>
                                @endif
                            </td>
                            <td class="text-end pe-4">
                                @cmsCan('master_ecommerce', 'edit')
                                <a href="{{ route('cms.master-ecommerce.edit', $item) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                @endCmsCan
                                @cmsCan('master_ecommerce', 'delete')
                                <form method="POST" action="{{ route('cms.master-ecommerce.destroy', $item) }}" class="d-inline" onsubmit="return confirm('{{ $item->is_active ? 'Deactivate' : 'Activate' }} ecommerce &quot;{{ $item->kode_ecommerce }}&quot;?')">
                                    @csrf @method('DELETE')
                                    <button type="submit" class="btn btn-sm {{ $item->is_active ? 'btn-outline-warning' : 'btn-outline-success' }}" title="{{ $item->is_active ? 'Deactivate' : 'Activate' }}">
                                        <i class="bi {{ $item->is_active ? 'bi-pause-circle' : 'bi-play-circle' }}"></i>
                                    </button>
                                </form>
                                @endCmsCan
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-cart display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No master ecommerce yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($items->hasPages())
        <div class="card-footer bg-white border-top py-3">{{ $items->appends(['search' => $search])->links('pagination::bootstrap-4') }}</div>
        @endif
    </div>
@endsection
