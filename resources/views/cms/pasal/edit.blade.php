@extends('cms::layouts.app')

@section('title', $pasal ? 'Edit Pasal' : 'Create Pasal')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.pasal.index') }}" class="text-decoration-none">Pasal</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $pasal ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $pasal ? 'bi-pencil-square' : 'bi-plus-circle' }} me-2"></i>
                {{ $pasal ? 'Edit Pasal' : 'Create Pasal' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $pasal ? route('cms.pasal.update', $pasal) : route('cms.pasal.store') }}">
                @csrf
                @if($pasal) @method('PUT') @endif
                <div class="row g-4">
                    <div class="col-md-8">
                        <label class="form-label fw-semibold small">Nama Pasal <span class="text-danger">*</span></label>
                        <input type="text" name="nama_pasal" value="{{ old('nama_pasal', $pasal->nama_pasal ?? '') }}" required class="form-control" placeholder="Nama pasal">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold small">Status</label>
                        <div class="form-check form-switch mt-2">
                            <input type="checkbox" class="form-check-input" name="is_active" value="1" id="isActive" {{ ($pasal && $pasal->is_active) || !$pasal ? 'checked' : '' }}>
                            <label class="form-check-label small" for="isActive">Active</label>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.pasal.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $pasal ? 'Update' : 'Create' }} Pasal
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
