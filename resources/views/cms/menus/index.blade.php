@extends('cms::layouts.app')

@section('title', 'Menus')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Menus</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-list me-2"></i>All Menus</h6>
            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#createMenuModal">
                <i class="bi bi-plus-lg me-1"></i> Create Menu
            </button>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Name</th>
                            <th>Slug</th>
                            <th>Items</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($menus as $menu)
                        <tr>
                            <td class="ps-4 fw-medium">{{ $menu->name }}</td>
                            <td><code class="small">{{ $menu->slug }}</code></td>
                            <td><span class="badge bg-secondary rounded-pill">{{ $menu->items_count }}</span></td>
                            <td class="text-end pe-4">
                                <a href="{{ route('cms.menus.edit', $menu) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-list"></i> Manage
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteMenu{{ $menu->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>
                                {{-- Delete Modal --}}
                                <div class="modal fade" id="deleteMenu{{ $menu->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0">
                                                <h6 class="fw-semibold">Confirm Delete</h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-start">
                                                <p class="small mb-0">Delete menu <strong>"{{ $menu->name }}"</strong>? All items will be removed.</p>
                                            </div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.menus.destroy', $menu) }}">
                                                    @csrf @method('DELETE')
                                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="4" class="text-center py-5 text-muted">
                                <i class="bi bi-list display-4 d-block mb-2 text-secondary opacity-50"></i>
                                No menus yet.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    {{-- Create Modal --}}
    <div class="modal fade" id="createMenuModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom">
                    <h6 class="fw-semibold"><i class="bi bi-plus-circle me-2"></i>Create Menu</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="{{ route('cms.menus.store') }}">
                    @csrf
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Name</label>
                            <input type="text" name="name" required class="form-control" placeholder="Main Menu">
                        </div>
                        <div class="mb-0">
                            <label class="form-label small fw-semibold">Slug</label>
                            <input type="text" name="slug" required class="form-control" placeholder="main-menu">
                        </div>
                    </div>
                    <div class="modal-footer border-top pt-3">
                        <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary btn-sm px-3">Create</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
