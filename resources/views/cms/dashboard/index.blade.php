@extends('cms::layouts.app')

@section('title', 'Dashboard')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
@endpush

@section('content')
    <h6 class="fw-semibold text-muted mb-3">Overview</h6>
    <div class="row g-4 mb-4">
        @foreach([
            ['label' => 'Roles',   'key' => 'roles',      'color' => 'primary',   'icon' => 'shield-check', 'route' => 'cms.roles.index'],
            ['label' => 'Users',   'key' => 'users',      'color' => 'success',   'icon' => 'people',       'route' => 'cms.users.index'],
            ['label' => 'Pasal',   'key' => 'pasal',      'color' => 'warning',   'icon' => 'journal-text', 'route' => 'cms.pasal.index'],
            ['label' => 'Badan',   'key' => 'badan',      'color' => 'danger',    'icon' => 'building',     'route' => 'cms.badan.index'],
            ['label' => 'Data Client', 'key' => 'data_client', 'color' => 'info', 'icon' => 'person-badge', 'route' => 'cms.data-client.index'],
        ] as $card)
        <div class="col-md-6 col-lg-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <p class="text-muted small mb-1">{{ $card['label'] }}</p>
                            <h3 class="fw-bold mb-0 text-{{ $card['color'] }}">{{ $stats[$card['key']] }}</h3>
                        </div>
                        <div class="bg-{{ $card['color'] }} bg-opacity-10 p-3 rounded-3">
                            <i class="bi bi-{{ $card['icon'] }} text-{{ $card['color'] }} fs-4"></i>
                        </div>
                    </div>
                    <a href="{{ route($card['route']) }}" class="btn btn-sm btn-outline-{{ $card['color'] }} mt-3 w-100">Manage <i class="bi bi-arrow-right ms-1"></i></a>
                </div>
            </div>
        </div>
        @endforeach
    </div>

    <div class="row g-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-bottom py-3">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-info-circle me-2"></i>System Info</h6>
                </div>
                <div class="card-body">
                    <div class="row g-2 small">
                        <div class="col-3 text-muted">Laravel</div>
                        <div class="col-3">{{ app()->version() }}</div>
                        <div class="col-3 text-muted">PHP</div>
                        <div class="col-3">{{ PHP_VERSION }}</div>
                        <div class="col-3 text-muted">Environment</div>
                        <div class="col-3">{{ app()->environment() }}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
