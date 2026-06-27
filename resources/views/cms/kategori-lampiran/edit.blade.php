@extends('cms::layouts.app')

@section('title', $kategori ? 'Edit Kategori' : 'Create Kategori')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.kategori-lampiran.index') }}" class="text-decoration-none">Kategori Lampiran</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $kategori ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $kategori ? 'bi-pencil-square' : 'bi-plus-circle' }} me-2"></i>
                {{ $kategori ? 'Edit Kategori' : 'Create Kategori' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $kategori ? route('cms.kategori-lampiran.update', $kategori) : route('cms.kategori-lampiran.store') }}">
                @csrf
                @if($kategori) @method('PUT') @endif
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Label <span class="text-danger">*</span></label>
                        <input type="text" name="label" value="{{ old('label', $kategori->label ?? '') }}" required class="form-control" placeholder="e.g. KAS, PIUTANG">
                        @error('label') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.kategori-lampiran.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $kategori ? 'Update' : 'Create' }} Kategori
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
