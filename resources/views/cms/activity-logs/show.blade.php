@extends('cms::layouts.app')

@section('title', 'Activity Log Detail')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.activity-logs.index') }}">Activity Logs</a></li>
    <li class="breadcrumb-item active" aria-current="page">Detail</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-bottom py-3">
            <h6 class="fw-semibold mb-0"><i class="bi bi-activity me-2"></i>Activity Log Detail</h6>
        </div>
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-3 text-muted">User</div>
                <div class="col-md-9">{{ $activityLog->user->name ?? 'Unknown' }} ({{ $activityLog->user->email ?? '' }})</div>
                <div class="col-md-3 text-muted">Action</div>
                <div class="col-md-9"><span class="badge bg-info">{{ $activityLog->action }}</span></div>
                <div class="col-md-3 text-muted">Module</div>
                <div class="col-md-9">{{ $activityLog->module }}</div>
                <div class="col-md-3 text-muted">Target ID</div>
                <div class="col-md-9">{{ $activityLog->target_id ?? '-' }}</div>
                <div class="col-md-3 text-muted">Description</div>
                <div class="col-md-9">{{ $activityLog->description }}</div>
                <div class="col-md-3 text-muted">IP Address</div>
                <div class="col-md-9"><code>{{ $activityLog->ip_address }}</code></div>
                <div class="col-md-3 text-muted">User Agent</div>
                <div class="col-md-9"><small class="text-break">{{ $activityLog->user_agent }}</small></div>
                <div class="col-md-3 text-muted">Time</div>
                <div class="col-md-9">{{ $activityLog->created_at->format('d M Y H:i:s') }}</div>
            </div>
        </div>
        <div class="card-footer bg-white border-top">
            <a href="{{ route('cms.activity-logs.index') }}" class="btn btn-secondary btn-sm"><i class="bi bi-arrow-left me-1"></i>Back</a>
        </div>
    </div>
@endsection
