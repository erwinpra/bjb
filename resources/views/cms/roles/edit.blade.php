@extends('cms::layouts.app')

@section('title', $role ? 'Edit Role' : 'Create Role')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.roles.index') }}" class="text-decoration-none">Roles</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $role ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $role ? 'bi-pencil-square' : 'bi-plus-circle' }} me-2"></i>
                {{ $role ? 'Edit Role' : 'Create Role' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $role ? route('cms.roles.update', $role) : route('cms.roles.store') }}">
                @csrf
                @if($role) @method('PUT') @endif

                <div class="row g-4 mb-4">
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Name <span class="text-danger">*</span></label>
                        <input type="text" name="name" value="{{ old('name', $role->name ?? '') }}" required class="form-control" placeholder="Administrator">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Slug <span class="text-danger">*</span></label>
                        <input type="text" name="slug" value="{{ old('slug', $role->slug ?? '') }}" required class="form-control" placeholder="administrator">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Description</label>
                        <textarea name="description" rows="1" class="form-control" placeholder="Role description">{{ old('description', $role->description ?? '') }}</textarea>
                    </div>
                </div>

                <div class="mb-0">
                    <label class="form-label fw-semibold small mb-3">Permissions</label>
                    @foreach($permissions as $module => $actions)
                    <div class="card bg-light border-0 mb-3">
                        <div class="card-body py-3 px-4">
                            <h6 class="fw-semibold text-capitalize mb-3 small">{{ $module }}</h6>
                            <div class="d-flex flex-wrap gap-3">
                                @foreach($actions as $action => $label)
                                <div class="form-check form-check-inline">
                                    <input type="checkbox"
                                           class="form-check-input"
                                           name="permissions[{{ $module }}][{{ $action }}]"
                                           value="1"
                                           id="perm_{{ $module }}_{{ $action }}"
                                           {{ $role && $role->hasPermission($module, $action) ? 'checked' : '' }}>
                                    <label class="form-check-label small" for="perm_{{ $module }}_{{ $action }}">
                                        {{ $label }}
                                    </label>
                                </div>
                                @endforeach
                            </div>
                        </div>
                    </div>
                    @endforeach
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.roles.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $role ? 'Update' : 'Create' }} Role
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
