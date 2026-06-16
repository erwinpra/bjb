@extends('cms::layouts.app')

@section('title', 'Media')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Media</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-images me-2"></i>All Media</h6>
            <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#uploadModal">
                <i class="bi bi-cloud-arrow-up me-1"></i> Upload
            </button>
        </div>
        @if($media->count())
        <div class="card-body p-4">
            <div class="row g-3">
                @foreach($media as $item)
                <div class="col-6 col-md-3 col-lg-2">
                    <div class="card border h-100">
                        @if(str_starts_with($item->mime_type, 'image/'))
                            <div class="card-img-top bg-dark d-flex align-items-center justify-content-center" style="height: 150px;">
                                <img src="{{ $item->url }}" alt="{{ $item->name }}" class="img-fluid" style="max-height: 150px; object-fit: cover;">
                            </div>
                        @else
                            <div class="card-img-top bg-light d-flex align-items-center justify-content-center" style="height: 150px;">
                                <i class="bi bi-file-earmark display-4 text-muted"></i>
                            </div>
                        @endif
                        <div class="card-body p-2">
                            <p class="small text-truncate mb-1 fw-medium">{{ $item->name }}</p>
                            <p class="small text-muted mb-2">{{ number_format($item->size / 1024, 1) }} KB</p>
                            <button type="button" class="btn btn-outline-danger btn-sm w-100" data-bs-toggle="modal" data-bs-target="#deleteMedia{{ $item->id }}">
                                <i class="bi bi-trash"></i> Delete
                            </button>
                        </div>
                    </div>

                    {{-- Delete Modal --}}
                    <div class="modal fade" id="deleteMedia{{ $item->id }}" tabindex="-1">
                        <div class="modal-dialog modal-sm modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header border-0">
                                    <h6 class="fw-semibold">Confirm Delete</h6>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body text-start">
                                    <p class="small mb-0">Delete <strong>"{{ $item->name }}"</strong>?</p>
                                </div>
                                <div class="modal-footer border-0 pt-0">
                                    <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                                    <form method="POST" action="{{ route('cms.media.destroy', $item) }}">
                                        @csrf @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>
        </div>
        @if($media->hasPages())
        <div class="card-footer bg-white border-top py-3">
            {{ $media->links('pagination::bootstrap-4') }}
        </div>
        @endif
        @else
        <div class="card-body text-center py-5 text-muted">
            <i class="bi bi-images display-4 d-block mb-3 text-secondary opacity-50"></i>
            <p>No media uploaded yet.</p>
        </div>
        @endif
    </div>

    {{-- Upload Modal --}}
    <div class="modal fade" id="uploadModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom">
                    <h6 class="fw-semibold"><i class="bi bi-cloud-arrow-up me-2"></i>Upload File</h6>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="POST" action="{{ route('cms.media.store') }}" enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">
                        <div class="mb-0">
                            <label class="form-label small fw-semibold">Choose File</label>
                            <input type="file" name="file" required class="form-control">
                        </div>
                    </div>
                    <div class="modal-footer border-top pt-3">
                        <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary btn-sm px-3">
                            <i class="bi bi-cloud-arrow-up me-1"></i> Upload
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
