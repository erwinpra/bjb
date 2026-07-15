@extends('cms::layouts.app')

@section('title', 'Activity Logs')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Activity Logs</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-bottom py-3">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <h6 class="fw-semibold mb-0"><i class="bi bi-activity me-2"></i>Activity Logs</h6>
                <div class="d-flex gap-2">
                    <form method="GET" action="{{ route('cms.activity-logs.index') }}" class="d-flex gap-2 align-items-center">
                        <input type="text" name="search" class="form-control form-control-sm" placeholder="Cari log..." value="{{ $search ?? '' }}" style="width:180px">
                        <button type="submit" class="btn btn-sm btn-outline-secondary"><i class="bi bi-search"></i></button>
                        @if(!empty($search))
                            <a href="{{ route('cms.activity-logs.index') }}" class="btn btn-sm btn-outline-danger"><i class="bi bi-x-lg"></i></a>
                        @endif
                        <select name="per_page" class="form-select form-select-sm" style="width:auto" onchange="this.form.submit()">
                            <option value="10" {{ ($perPage ?? 20) == 10 ? 'selected' : '' }}>10</option>
                            <option value="20" {{ ($perPage ?? 20) == 20 ? 'selected' : '' }}>20</option>
                            <option value="50" {{ ($perPage ?? 20) == 50 ? 'selected' : '' }}>50</option>
                            <option value="100" {{ ($perPage ?? 20) == 100 ? 'selected' : '' }}>100</option>
                        </select>
                    </form>

                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>User</th>
                            <th>Action</th>
                            <th>Module</th>
                            <th>Description</th>
                            <th>IP</th>
                            <th>Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($logs as $log)
                        <tr>
                            <td>{{ $logs->firstItem() + $loop->index }}</td>
                            <td>
                                <a href="{{ route('cms.activity-logs.show', $log) }}" class="text-decoration-none">
                                    {{ $log->user->name ?? 'Unknown' }}
                                </a>
                                <br><small class="text-muted">{{ $log->user->email ?? '' }}</small>
                            </td>
                            <td>
                                @php
                                    $action = $log->action;
                                    $badge = $action === 'login' ? 'success' : ($action === 'logout' ? 'secondary' : ($action === 'create' ? 'primary' : ($action === 'update' ? 'warning' : ($action === 'delete' ? 'danger' : 'info'))));
                                @endphp
                                <span class="badge bg-{{ $badge }}">{{ $log->action }}</span>
                            </td>
                            <td>{{ $log->module }}</td>
                            <td class="text-truncate" style="max-width:300px">{{ $log->description }}</td>
                            <td><code>{{ $log->ip_address }}</code></td>
                            <td><small class="text-muted" title="{{ $log->created_at }}">{{ $log->created_at->diffForHumans() }}</small></td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">No activity logs yet.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($logs->hasPages())
        <div class="card-footer bg-white border-top d-flex justify-content-center">
            {{ $logs->appends(['search' => $search, 'per_page' => $perPage])->links() }}
        </div>
        @endif
    </div>
@endsection
