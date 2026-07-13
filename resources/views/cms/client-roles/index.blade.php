@extends('cms::layouts.app')

@section('title', 'Client Roles')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Client Roles</li>
@endpush

@section('content')
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h6 class="fw-semibold mb-0">Client Roles</h6>
        @cmsCan('client_roles', 'create')
        <a href="{{ route('cms.client-roles.create') }}" class="btn btn-primary btn-sm">
            <i class="bi bi-plus-lg me-1"></i> Create Role
        </a>
        @endCmsCan
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-4">Name</th>
                        <th>Slug</th>
                        <th>Description</th>
                        <th>Permissions</th>
                        <th class="text-center">Clients</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($roles as $role)
                        <tr>
                            <td class="ps-4 fw-medium">{{ $role->name }}</td>
                            <td><code>{{ $role->slug }}</code></td>
                            <td class="small text-muted">{{ $role->description ?? '-' }}</td>
                            <td>
                                @if($role->permissions)
                                    @foreach($role->permissions as $perm)
                                        <span class="badge bg-info me-1">{{ $perm }}</span>
                                    @endforeach
                                @else
                                    <span class="text-muted small">None</span>
                                @endif
                            </td>
                            <td class="text-center">{{ $role->clients_count }}</td>
                            <td class="text-end pe-4">
                                @cmsCan('client_roles', 'edit')
                                <a href="{{ route('cms.client-roles.edit', $role) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                @endCmsCan
                                @cmsCan('client_roles', 'delete')
                                @if($role->slug !== 'client')
                                    <form action="{{ route('cms.client-roles.destroy', $role) }}" method="POST" class="d-inline"
                                          onsubmit="return confirm('Delete this role?')">
                                        @csrf @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                    </form>
                                @endif
                                @endCmsCan
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="6" class="text-center text-muted py-4">No roles yet.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
