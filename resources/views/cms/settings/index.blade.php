@extends('cms::layouts.app')

@section('title', 'Settings')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Settings</li>
@endpush

@section('content')
    <div class="row g-4">
        @forelse($groups as $group => $settings)
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h6 class="fw-semibold mb-0 text-capitalize"><i class="bi bi-gear me-2"></i>{{ $group }}</h6>
                </div>
                <div class="card-body p-4">
                    <form method="POST" action="{{ route('cms.settings.update') }}">
                        @csrf
                        @foreach($settings as $setting)
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">{{ ucfirst(str_replace('_', ' ', $setting->key)) }}</label>
                            @if($setting->type === 'textarea')
                                <textarea name="setting_{{ $setting->key }}" rows="3" class="form-control">{{ $setting->value }}</textarea>
                            @else
                                <div class="input-group">
                                    @if($setting->type === 'password')<span class="input-group-text"><i class="bi bi-lock"></i></span>@endif
                                    <input type="{{ $setting->type === 'password' ? 'password' : 'text' }}"
                                           name="setting_{{ $setting->key }}"
                                           value="{{ $setting->type !== 'password' ? $setting->value : '' }}"
                                           class="form-control">
                                </div>
                            @endif
                        </div>
                        @endforeach
                        <div class="d-flex justify-content-end gap-2">
                            <button type="submit" class="btn btn-primary btn-sm px-4">
                                <i class="bi bi-check-lg me-1"></i> Save
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        @empty
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center py-5 text-muted">
                    <i class="bi bi-gear display-4 d-block mb-3 text-secondary opacity-50"></i>
                    <p>No settings configured.</p>
                </div>
            </div>
        </div>
        @endforelse

        {{-- Add Setting --}}
        <div class="col-lg-6">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-plus-circle me-2"></i>Add Setting</h6>
                </div>
                <div class="card-body p-4">
                    <form method="POST" action="{{ route('cms.settings.store') }}">
                        @csrf
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Key</label>
                            <input type="text" name="key" required class="form-control" placeholder="setting_key">
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Value</label>
                            <input type="text" name="value" class="form-control">
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-6">
                                <label class="form-label small fw-semibold">Group</label>
                                <input type="text" name="group" value="general" class="form-control">
                            </div>
                            <div class="col-6">
                                <label class="form-label small fw-semibold">Type</label>
                                <select name="type" class="form-select">
                                    <option value="text">Text</option>
                                    <option value="textarea">Textarea</option>
                                    <option value="password">Password</option>
                                </select>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-sm px-4">
                            <i class="bi bi-plus-lg me-1"></i> Add
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
