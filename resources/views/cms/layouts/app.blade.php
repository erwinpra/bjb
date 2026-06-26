<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title') - {{ config('app.name') }} CMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    @stack('styles')
</head>
<body class="bg-light">
    <div class="d-flex min-vh-100 position-relative">
        {{-- Sidebar --}}
        <nav class="sidebar d-flex flex-column bg-dark text-white flex-shrink-0 position-fixed h-100" style="width: 260px;">
            <div class="p-3 border-bottom border-secondary">
                <a href="{{ route('cms.dashboard') }}" class="text-white text-decoration-none d-flex align-items-center gap-2">
                    <i class="bi bi-grid-3x3-gap-fill fs-4"></i>
                    <span class="fw-bold fs-6">{{ config('app.name') }} CMS</span>
                </a>
            </div>

            <div class="flex-grow-1 overflow-auto p-2">
                {{-- Dashboard --}}
                <div class="px-2 mb-1">
                    <a href="{{ route('cms.dashboard') }}"
                       class="nav-link text-white-50 d-flex align-items-center gap-2 px-3 py-2 rounded @if(request()->routeIs('cms.dashboard')) text-white bg-secondary @else hover-bg-secondary @endif">
                        <i class="bi bi-speedometer2"></i>
                        <span>Dashboard</span>
                    </a>
                </div>

                {{-- Grouped Modules --}}
                @php
                    $groups = config('cms.sidebar.groups', []);
                    $grouped = [];
                    foreach ($cmsModules as $module) {
                        $g = $module->getGroup() ?? '_ungrouped';
                        $grouped[$g][] = $module;
                    }
                @endphp

                @foreach($groups as $groupKey => $groupConfig)
                    @php
                        $modules = $grouped[$groupKey] ?? [];
                        if (empty($modules)) continue;
                        $groupIcon = $groupConfig['icon'] ?? 'circle';
                        $groupLabel = $groupConfig['label'] ?? ucfirst($groupKey);
                        $hasActive = false;
                        foreach ($modules as $m) {
                            if (request()->routeIs("cms.{$m->getRoute()}.*")) {
                                $hasActive = true;
                                break;
                            }
                        }
                        $collapseId = 'collapse-' . $groupKey;
                    @endphp
                    <div class="mb-1">
                        <button class="btn btn-sm d-flex align-items-center gap-2 w-100 text-start px-3 py-2 rounded border-0 text-white-50 hover-bg-secondary"
                                data-bs-toggle="collapse" data-bs-target="#{{ $collapseId }}"
                                aria-expanded="{{ $hasActive ? 'true' : 'false' }}">
                            <i class="bi bi-{{ $groupIcon }}"></i>
                            <span class="flex-grow-1 small fw-semibold">{{ $groupLabel }}</span>
                            <i class="bi bi-chevron-down small transition-rotate {{ $hasActive ? 'rotate-180' : '' }}"></i>
                        </button>
                        <div class="collapse {{ $hasActive ? 'show' : '' }}" id="{{ $collapseId }}">
                            <div class="ps-3 pe-2 pt-1">
                                @foreach($modules as $module)
                                    @php
                                        $active = request()->routeIs("cms.{$module->getRoute()}.*");
                                    @endphp
                                    <a href="{{ route("cms.{$module->getRoute()}.index") }}"
                                       class="nav-link d-flex align-items-center gap-2 px-3 py-1 rounded small @if($active) text-white bg-secondary @else text-white-50 @endif">
                                        <i class="bi bi-{{ $module->getIcon() }}"></i>
                                        {{ $module->getLabel() }}
                                    </a>
                                @endforeach
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>

            <div class="p-3 border-top border-secondary">
                <div class="d-flex align-items-center gap-2 text-white-50 small mb-2">
                    <i class="bi bi-person-circle fs-5"></i>
                    {{ auth()->user()->name ?? '' }}
                </div>
                <a href="{{ route('cms.profile') }}" class="btn btn-outline-light btn-sm w-100 mb-2">
                    <i class="bi bi-gear"></i> Profile
                </a>
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="btn btn-outline-light btn-sm w-100">
                        <i class="bi bi-box-arrow-left"></i> Logout
                    </button>
                </form>
            </div>
        </nav>

        {{-- Main Content --}}
        <div class="flex-grow-1 d-flex flex-column" style="margin-left: 260px; overflow-x: hidden; min-width: 0;">
            <header class="bg-white shadow-sm border-bottom py-3 px-4">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">@yield('title')</h5>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 small">
                            <li class="breadcrumb-item"><a href="{{ route('cms.dashboard') }}" class="text-decoration-none">Home</a></li>
                            @stack('breadcrumb')
                        </ol>
                    </nav>
                </div>
            </header>

            <main class="flex-grow-1 p-4" style="min-width: 0;">
                @if(session('success'))
                    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center gap-2">
                        <i class="bi bi-check-circle-fill"></i> {{ session('success') }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                @endif

                @if(session('error'))
                    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2">
                        <i class="bi bi-exclamation-triangle-fill"></i> {{ session('error') }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                @endif

                @yield('content')
            </main>

            <footer class="bg-white border-top py-3 px-4 text-center text-muted small">
                &copy; {{ date('Y') }} {{ config('app.name') }}. All rights reserved.
            </footer>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .sidebar .hover-bg-secondary:hover { background-color: rgba(255,255,255,0.08) !important; }
        .transition-rotate { transition: transform 0.2s ease; }
        .rotate-180 { transform: rotate(180deg); }
        .sidebar .nav-link { transition: background-color 0.15s ease; }
        .sidebar .nav-link:not(.text-white):hover { background-color: rgba(255,255,255,0.05); }
    </style>
    @stack('scripts')
</body>
</html>
