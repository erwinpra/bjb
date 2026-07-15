@extends('cms::layouts.app')

@section('title', 'Activity Logs')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Activity Logs</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-bottom d-flex justify-content-between align-items-center py-3">
            <h6 class="fw-semibold mb-0"><i class="bi bi-activity me-2"></i>Activity Logs</h6>
            @if(auth()->user()->hasCmsPermission('activity_log', 'delete'))
            <form action="{{ route('cms.activity-logs.clear') }}" method="POST" onsubmit="return confirm('Clear all logs?')">
                @csrf
                <button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash me-1"></i>Clear All</button>
            </form>
            @endif
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
                            @if(auth()->user()->hasCmsPermission('activity_log', 'delete'))
                            <th></th>
                            @endif
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($logs as $log)
                        <tr>
                            <td>{{ $loop->iteration }}</td>
                            <td>
                                <a href="{{ route('cms.activity-logs.show', $log) }}" class="text-decoration-none">
                                    {{ $log->user->name ?? 'Unknown' }}
                                </a>
                                <br><small class="text-muted">{{ $log->user->email ?? '' }}</small>
                            </td>
                            <td>
                                @php
                                    $badge = match($log->action) {
                                        'login' => 'success',
                                        'logout' => 'secondary',
                                        'create' => 'primary',
                                        'update' => 'warning',
                                        'delete' => 'danger',
                                        default => 'info',
                                    };
                                @endphp
                                <span class="badge bg-{{ $badge }}">{{ $log->action }}</span>
                            </td>
                            <td>{{ $log->module }}</td>
                            <td class="text-truncate" style="max-width:300px">{{ $log->description }}</td>
                            <td><code>{{ $log->ip_address }}</code></td>
                            <td><small class="text-muted" title="{{ $log->created_at }}">{{ $log->created_at->diffForHumans() }}</small></td>
                            @if(auth()->user()->hasCmsPermission('activity_log', 'delete'))
                            <td>
                                <form action="{{ route('cms.activity-logs.destroy', $log) }}" method="POST" onsubmit="return confirm('Delete this log?')">
                                    @csrf @method('DELETE')
                                    <button class="btn btn-sm btn-outline-danger"><i class="bi bi-x"></i></button>
                                </form>
                            </td>
                            @endif
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
        <div class="card-footer bg-white border-top d-flex justify-content-center">
            {{ $logs->links() }}
        </div>
    </div>
@endsection
