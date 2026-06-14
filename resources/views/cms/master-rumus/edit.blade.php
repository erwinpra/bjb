@extends('cms::layouts.app')

@section('title', $rumus ? 'Edit Master Rumus' : 'Create Master Rumus')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.master-rumus.index') }}" class="text-decoration-none">Master Rumus</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $rumus ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $rumus ? 'bi-pencil-square' : 'bi-plus-circle' }} me-2"></i>
                {{ $rumus ? 'Edit Master Rumus' : 'Create Master Rumus' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $rumus ? route('cms.master-rumus.update', $rumus) : route('cms.master-rumus.store') }}">
                @csrf
                @if($rumus) @method('PUT') @endif
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Tipe Badan <span class="text-danger">*</span></label>
                        <select name="tipe_badan" class="form-select" required>
                            <option value="">-- Pilih --</option>
                            @foreach($badan as $b)
                                <option value="{{ $b->tipe }}" {{ old('tipe_badan', $rumus->tipe_badan ?? '') == $b->tipe ? 'selected' : '' }}>{{ $b->tipe }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Max Value <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text">Rp</span>
                            <input type="number" name="max_value" value="{{ old('max_value', $rumus->max_value ?? '') }}" required step="0.01" min="0" class="form-control">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Potongan Persentase (%) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="number" name="potongan_persentase" value="{{ old('potongan_persentase', $rumus->potongan_persentase ?? '') }}" required step="0.01" min="0" max="100" class="form-control">
                            <span class="input-group-text">%</span>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.master-rumus.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4"><i class="bi bi-check-lg me-1"></i> {{ $rumus ? 'Update' : 'Save' }}</button>
                </div>
            </form>
        </div>
    </div>
@endsection
