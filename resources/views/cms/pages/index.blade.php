@extends('cms::layouts.app')

@section('title', 'Pages')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Pages</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-file-text me-2"></i>All Pages</h6>
            <a href="{{ route('cms.pages.create') }}" class="btn btn-primary btn-sm">
                <i class="bi bi-plus-lg me-1"></i> Create Page
            </a>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Title</th>
                            <th>Slug</th>
                            <th>Template</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($pages as $page)
                        <tr>
                            <td class="ps-4 fw-medium">{{ $page->title }}</td>
                            <td><code class="small">{{ $page->slug }}</code></td>
                            <td><span class="badge bg-secondary bg-opacity-10 text-secondary">{{ $page->template }}</span></td>
                            <td>
                                @if($page->status)
                                    <span class="badge bg-success-subtle text-success px-3 py-1 rounded-pill">
                                        <i class="bi bi-check-circle-fill me-1 small"></i> Published
                                    </span>
                                @else
                                    <span class="badge bg-warning-subtle text-warning px-3 py-1 rounded-pill">
                                        <i class="bi bi-clock me-1 small"></i> Draft
                                    </span>
                                @endif
                            </td>
                            <td class="text-end pe-4">
                                <a href="{{ route('cms.pages.edit', $page) }}" class="btn btn-sm btn-outline-primary">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button type="button" class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteModal{{ $page->id }}">
                                    <i class="bi bi-trash"></i>
                                </button>

                                {{-- Delete Modal --}}
                                <div class="modal fade" id="deleteModal{{ $page->id }}" tabindex="-1">
                                    <div class="modal-dialog modal-sm modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header border-0">
                                                <h6 class="modal-title fw-semibold">Confirm Delete</h6>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body text-start">
                                                <p class="small mb-0">Delete <strong>"{{ $page->title }}"</strong>? This cannot be undone.</p>
                                            </div>
                                            <div class="modal-footer border-0 pt-0">
                                                <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                                <form method="POST" action="{{ route('cms.pages.destroy', $page) }}">
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
                            <td colspan="5" class="text-center py-5 text-muted">
                                <i class="bi bi-file-earmark-text display-6 d-block mb-2 text-secondary opacity-50"></i>
                                No pages yet. <a href="{{ route('cms.pages.create') }}" class="text-decoration-none">Create one</a>.
                            </td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($pages->hasPages())
        <div class="card-footer bg-white border-top py-3">
            {{ $pages->links('pagination::bootstrap-4') }}
        </div>
        @endif
    </div>
@endsection
