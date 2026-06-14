@extends('cms::layouts.app')

@section('title', 'Create Page')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.pages.index') }}" class="text-decoration-none">Pages</a></li>
    <li class="breadcrumb-item active" aria-current="page">Create</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-plus-circle me-2"></i>New Page</h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ route('cms.pages.store') }}">
                @csrf
                <div class="row g-4">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold small">Title <span class="text-danger">*</span></label>
                        <input type="text" name="title" value="{{ old('title') }}" required
                               class="form-control @error('title') is-invalid @enderror" placeholder="Page title">
                        @error('title') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Slug <span class="text-danger">*</span></label>
                        <input type="text" name="slug" value="{{ old('slug') }}" required
                               class="form-control @error('slug') is-invalid @enderror" placeholder="page-slug">
                        @error('slug') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Content</label>
                        <textarea name="content" rows="15" class="form-control font-monospace small">{{ old('content') }}</textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Template</label>
                        <select name="template" class="form-select">
                            @foreach($templates as $key => $template)
                                <option value="{{ $key }}" {{ old('template') == $key ? 'selected' : '' }}>{{ $template['label'] }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Status</label>
                        <select name="status" class="form-select">
                            <option value="1">Published</option>
                            <option value="0">Draft</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Published At</label>
                        <input type="date" name="published_at" value="{{ old('published_at', date('Y-m-d')) }}" class="form-control">
                    </div>
                    <div class="col-12"><hr></div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Meta Title</label>
                        <input type="text" name="meta_title" value="{{ old('meta_title') }}" class="form-control" placeholder="SEO title">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Meta Description</label>
                        <textarea name="meta_description" rows="2" class="form-control" placeholder="SEO description">{{ old('meta_description') }}</textarea>
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.pages.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> Save Page
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
