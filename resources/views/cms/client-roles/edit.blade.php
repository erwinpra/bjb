@extends('cms::layouts.app')

@section('title', $role ? 'Edit Client Role' : 'Create Client Role')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.client-roles.index') }}" class="text-decoration-none">Client Roles</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $role ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi bi-person-lock me-2"></i>
                {{ $role ? 'Edit Client Role' : 'Create Client Role' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $role ? route('cms.client-roles.update', $role) : route('cms.client-roles.store') }}">
                @csrf
                @if($role) @method('PUT') @endif

                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Name <span class="text-danger">*</span></label>
                        <input type="text" name="name" value="{{ old('name', $role->name ?? '') }}" required class="form-control" placeholder="e.g. Super Admin Kantor">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Slug <span class="text-danger">*</span></label>
                        <input type="text" name="slug" value="{{ old('slug', $role->slug ?? '') }}" required class="form-control" placeholder="e.g. super_admin">
                        <div class="form-text small">Unique identifier, gunakan snake_case.</div>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Description</label>
                        <textarea name="description" rows="2" class="form-control" placeholder="Deskripsi role">{{ old('description', $role->description ?? '') }}</textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Permissions</label>
                        <div class="row g-2">
                            @php
                                $allPermissions = [
                                    'dashboard.view' => 'View Dashboard',
                                    'dashboard.export' => 'Export PDF/CSV',
                                    'dashboard.change-password' => 'Change Password',
                                    'client.view-all' => 'View All Clients Data',
                                    'client.manage-staff' => 'Manage Staff',
                                ];
                                $selected = old('permissions', $role->permissions ?? []);
                            @endphp
                            @foreach($allPermissions as $key => $label)
                                <div class="col-md-4">
                                    <div class="form-check">
                                        <input type="checkbox" name="permissions[]" value="{{ $key }}" id="perm_{{ $key }}"
                                            class="form-check-input" {{ in_array($key, $selected) ? 'checked' : '' }}>
                                        <label class="form-check-label small" for="perm_{{ $key }}">{{ $label }}</label>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.client-roles.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $role ? 'Update' : 'Create' }} Role
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
