@extends('cms::layouts.app')

@section('title', 'Manage Menu')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.menus.index') }}" class="text-decoration-none">Menus</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $menu->name }}</li>
@endpush

@section('content')
    <div class="row g-4">
        {{-- Add Item --}}
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-plus-circle me-2"></i>Add Item</h6>
                </div>
                <div class="card-body p-4">
                    <form method="POST" action="{{ route('cms.menus.items.store', $menu) }}">
                        @csrf
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Label <span class="text-danger">*</span></label>
                            <input type="text" name="label" required class="form-control" placeholder="Menu label">
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">URL</label>
                            <input type="text" name="url" class="form-control" placeholder="/about or https://...">
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Parent</label>
                            <select name="parent_id" class="form-select">
                                <option value="">None (top level)</option>
                                @foreach($menu->items as $item)
                                    <option value="{{ $item->id }}">{{ $item->label }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Target</label>
                            <select name="target" class="form-select">
                                <option value="_self">Same Tab</option>
                                <option value="_blank">New Tab</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="bi bi-plus-lg me-1"></i> Add Item
                        </button>
                    </form>
                </div>
            </div>
        </div>

        {{-- Menu Items & Settings --}}
        <div class="col-lg-8">
            {{-- Items List --}}
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-list me-2"></i>Menu Items</h6>
                </div>
                <div class="card-body p-0">
                    @if($menu->items->isEmpty())
                        <div class="text-center py-5 text-muted">
                            <i class="bi bi-list display-4 d-block mb-2 text-secondary opacity-50"></i>
                            <p class="small">No items in this menu.</p>
                        </div>
                    @else
                        <div class="list-group list-group-flush">
                            @foreach($menu->items as $item)
                                <div class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                                    <div>
                                        <span class="fw-medium">{{ $item->label }}</span>
                                        <br>
                                        <span class="small text-muted">
                                            <code>{{ $item->url ?: ($item->route ?: '—') }}</code>
                                            @if($item->children->count())
                                                <span class="badge bg-info ms-2">{{ $item->children->count() }} children</span>
                                            @endif
                                        </span>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#removeItem{{ $item->id }}">
                                            <i class="bi bi-x-lg"></i>
                                        </button>
                                    </div>
                                </div>
                                {{-- Delete Item Modal --}}
                                <div class="modal fade" id="removeItem{{ $item->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0">
                                                <h6 class="fw-semibold">Remove Item</h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-start">
                                                <p class="small mb-0">Remove <strong>"{{ $item->label }}"</strong> from menu?</p>
                                            </div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.menus.items.destroy', $item) }}">
                                                    @csrf @method('DELETE')
                                                    <button type="submit" class="btn btn-danger btn-sm">Remove</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    @endif
                </div>
            </div>

            {{-- Menu Settings --}}
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="fw-semibold mb-0"><i class="bi bi-gear me-2"></i>Menu Settings</h6>
                </div>
                <div class="card-body p-4">
                    <form method="POST" action="{{ route('cms.menus.update', $menu) }}">
                        @csrf @method('PUT')
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold">Name</label>
                                <input type="text" name="name" value="{{ $menu->name }}" class="form-control">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold">Slug</label>
                                <input type="text" name="slug" value="{{ $menu->slug }}" class="form-control">
                            </div>
                        </div>
                        <div class="d-flex justify-content-end mt-3">
                            <button type="submit" class="btn btn-primary btn-sm px-3">
                                <i class="bi bi-check-lg me-1"></i> Update Menu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection
