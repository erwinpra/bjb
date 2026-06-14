@extends('cms::layouts.app')

@section('title', 'Edit Badan')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.badan.index') }}" class="text-decoration-none">Badan</a></li>
    <li class="breadcrumb-item active" aria-current="page">Edit</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0"><i class="bi bi-pencil-square me-2"></i>Edit Badan</h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ route('cms.badan.update', $badan) }}">
                @csrf @method('PUT')
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Tipe <span class="text-danger">*</span></label>
                        <input type="text" name="tipe" value="{{ old('tipe', $badan->tipe) }}" required class="form-control">
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.badan.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4"><i class="bi bi-check-lg me-1"></i> Update Badan</button>
                </div>
            </form>
        </div>
    </div>
@endsection
