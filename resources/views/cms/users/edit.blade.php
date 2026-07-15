@extends('cms::layouts.app')

@section('title', $user ? 'Edit User' : 'Create User')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.users.index') }}" class="text-decoration-none">Users</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $user ? 'Edit' : 'Create' }}</li>
@endpush

@if(!$user)
@push('styles')
<style>
#loading-overlay {
    display: none;
    position: fixed; top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(255,255,255,.85); z-index: 9999;
    justify-content: center; align-items: center; flex-direction: column;
}
#loading-overlay.show { display: flex; }
</style>
@endpush
@endif

@section('content')
    <div id="loading-overlay">
        <div class="spinner-border text-primary mb-3" role="status" style="width:3rem;height:3rem"></div>
        <p class="text-muted fw-semibold">Menyimpan data & mengirim email…</p>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $user ? 'bi-pencil-square' : 'bi-person-plus' }} me-2"></i>
                {{ $user ? 'Edit User' : 'Create User' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" id="user-form" action="{{ $user ? route('cms.users.update', $user) : route('cms.users.store') }}">
                @csrf
                @if($user) @method('PUT') @endif

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Name <span class="text-danger">*</span></label>
                        <input type="text" name="name" value="{{ old('name', $user->name ?? '') }}" required
                               class="form-control @error('name') is-invalid @enderror" placeholder="John Doe">
                        @error('name') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" value="{{ old('email', $user->email ?? '') }}" required
                               class="form-control @error('email') is-invalid @enderror" placeholder="john@example.com">
                        @error('email') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    @if($user)
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Password</label>
                        <input type="password" name="password"
                               class="form-control @error('password') is-invalid @enderror"
                               placeholder="Leave empty to keep current">
                        @error('password') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    @endif
                    <div class="{{ $user ? 'col-md-6' : 'col-md-12' }}">
                        <label class="form-label fw-semibold small">Roles</label>
                        <div class="border rounded p-3 bg-light" style="max-height: 160px; overflow-y: auto;">
                            @forelse($roles as $role)
                            <div class="form-check">
                                <input type="checkbox"
                                       class="form-check-input"
                                       name="roles[]"
                                       value="{{ $role->id }}"
                                       id="role_{{ $role->id }}"
                                       {{ $user && $user->roles->contains($role->id) ? 'checked' : '' }}>
                                <label class="form-check-label small" for="role_{{ $role->id }}">
                                    {{ $role->name }}
                                </label>
                            </div>
                            @empty
                                <p class="small text-muted mb-0">No roles available. <a href="{{ route('cms.roles.create') }}">Create one</a>.</p>
                            @endforelse
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 pt-3 border-top">
                    <a href="{{ route('cms.users.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $user ? 'Update' : 'Create' }} User
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection

@if(!$user)
@push('scripts')
<script>
document.getElementById('user-form').addEventListener('submit', function() {
    document.getElementById('loading-overlay').classList.add('show');
});
</script>
@endpush
@endif
