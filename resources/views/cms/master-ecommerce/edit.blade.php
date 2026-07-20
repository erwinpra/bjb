@extends('cms::layouts.app')

@section('title', $item ? 'Edit Master Ecommerce' : 'Create Master Ecommerce')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.master-ecommerce.index') }}" class="text-decoration-none">Master Ecommerce</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $item ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $item ? 'bi-pencil-square' : 'bi-plus-circle' }} me-2"></i>
                {{ $item ? 'Edit Master Ecommerce' : 'Create Master Ecommerce' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $item ? route('cms.master-ecommerce.update', $item) : route('cms.master-ecommerce.store') }}">
                @csrf
                @if($item) @method('PUT') @endif
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Kode Ecommerce <span class="text-danger">*</span></label>
                        <input type="text" name="kode_ecommerce" value="{{ old('kode_ecommerce', $item->kode_ecommerce ?? '') }}" required class="form-control" placeholder="e.g. SHOPEE">
                        @error('kode_ecommerce') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Deskripsi</label>
                        <input type="text" name="deskripsi" value="{{ old('deskripsi', $item->deskripsi ?? '') }}" class="form-control" placeholder="e.g. Shopee Indonesia">
                        @error('deskripsi') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.master-ecommerce.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $item ? 'Update' : 'Save' }}
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
