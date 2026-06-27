@extends('cms::layouts.app')

@section('title', $item ? 'Edit Master Item' : 'Create Master Item')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.master-lampiran-spt.index') }}" class="text-decoration-none">Master Lampiran SPT</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $item ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $item ? 'bi-pencil-square' : 'bi-plus-circle' }} me-2"></i>
                {{ $item ? 'Edit Master Item' : 'Create Master Item' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $item ? route('cms.master-lampiran-spt.update', $item) : route('cms.master-lampiran-spt.store') }}">
                @csrf
                @if($item) @method('PUT') @endif
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Kategori <span class="text-danger">*</span></label>
                        <select name="kategori_id" class="form-select" required>
                            <option value="">-- Pilih Kategori --</option>
                            @foreach($kategoris as $k)
                                <option value="{{ $k->id }}" {{ old('kategori_id', $item->kategori_id ?? '') == $k->id ? 'selected' : '' }}>{{ $k->label }}</option>
                            @endforeach
                        </select>
                        @error('kategori_id') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Sub Kode <span class="text-danger">*</span></label>
                        <input type="text" name="sub_kode" value="{{ old('sub_kode', $item->sub_kode ?? '') }}" required class="form-control" placeholder="e.g. 0101">
                        @error('sub_kode') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold small">Nama <span class="text-danger">*</span></label>
                        <input type="text" name="nama" value="{{ old('nama', $item->nama ?? '') }}" required class="form-control" placeholder="e.g. UANG TUNAI">
                        @error('nama') <div class="text-danger small mt-1">{{ $message }}</div> @enderror
                    </div>
                </div>
                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.master-lampiran-spt.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $item ? 'Update' : 'Save' }}
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection
