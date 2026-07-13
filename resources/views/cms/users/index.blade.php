@extends('cms::layouts.app')

@section('title', 'Users')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Users</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-people me-2"></i>All Users</h6>
            @cmsCan('user', 'create')
            <a href="{{ route('cms.users.create') }}" class="btn btn-primary btn-sm">
                <i class="bi bi-plus-lg me-1"></i> Create User
            </a>
            @endCmsCan
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Name</th>
                            <th>Email</th>
                            <th>Roles</th>
                            <th>Joined</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($users as $user)
                        <tr>
                            <td class="ps-4">
                                <div class="d-flex align-items-center gap-2">
                                    <i class="bi bi-person-circle fs-4 text-secondary"></i>
                                    <span class="fw-medium">{{ $user->name }}</span>
                                </div>
                            </td>
                            <td><span class="small text-muted">{{ $user->email }}</span></td>
                            <td>
                                @forelse($user->roles as $role)
                                    <span class="badge bg-info bg-opacity-10 text-info me-1">{{ $role->name }}</span>
                                @empty
                                    <span class="badge bg-secondary bg-opacity-10 text-secondary">No role</span>
                                @endforelse
                            </td>
                            <td><span class="small text-muted">{{ $user->created_at->format('d M Y') }}</span></td>
                            <td class="text-end pe-4">
                                @cmsCan('user', 'edit')
                                <a href="{{ route('cms.users.edit', $user) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                @endCmsCan
                                @cmsCan('user', 'delete')
                                @if($user->id !== auth()->id())
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteUser{{ $user->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                                @endif
                                @if($user->id !== auth()->id())
                                <div class="modal fade" id="deleteUser{{ $user->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0">
                                                <h6 class="fw-semibold">Confirm Delete</h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-start">
                                                <p class="small mb-0">Delete user <strong>"{{ $user->name }}"</strong>?</p>
                                            </div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.users.destroy', $user) }}">
                                                    @csrf @method('DELETE')
                                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                @endif
                                @endCmsCan
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-people display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No users found.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($users->hasPages())
        <div class="card-footer bg-white border-top py-3">
            {{ $users->links('pagination::bootstrap-4') }}
        </div>
        @endif
    </div>
@endsection
