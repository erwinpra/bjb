@extends('cms::layouts.app')

@section('title', $dataClient ? 'Edit Data Client' : 'Create Data Client')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.data-client.index') }}" class="text-decoration-none">Data Client</a></li>
    <li class="breadcrumb-item active" aria-current="page">{{ $dataClient ? 'Edit' : 'Create' }}</li>
@endpush

@section('content')
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="fw-semibold mb-0">
                <i class="bi {{ $dataClient ? 'bi-pencil-square' : 'bi-person-plus' }} me-2"></i>
                {{ $dataClient ? 'Edit Data Client' : 'Create Data Client' }}
            </h6>
        </div>
        <div class="card-body p-4">
            <form method="POST" action="{{ $dataClient ? route('cms.data-client.update', $dataClient) : route('cms.data-client.store') }}">
                @csrf
                @if($dataClient) @method('PUT') @endif

                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Nama Client <span class="text-danger">*</span></label>
                        <input type="text" name="nama_client" value="{{ old('nama_client', $dataClient->nama_client ?? '') }}" required class="form-control" placeholder="Nama lengkap client">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Tipe Badan</label>
                        <select name="tipe_badan" id="tipeBadan" class="form-select">
                            <option value="">-- Pilih Tipe --</option>
                            @foreach($badan as $b)
                                <option value="{{ $b->id }}" data-tipe="{{ $b->tipe }}"
                                    {{ old('tipe_badan', optional($dataClient)->tipe_badan ?? '') == $b->id ? 'selected' : '' }}>
                                    {{ $b->tipe }}
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small" id="npwpLabel">NPWP</label>
                        <input type="text" name="npwp" id="npwpField" value="{{ old('npwp', $dataClient->npwp ?? '') }}" class="form-control @error('npwp') is-invalid @enderror" placeholder="16 digit angka" maxlength="16" inputmode="numeric">
                        @error('npwp') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Client Role</label>
                        <select name="client_role_id" class="form-select">
                            <option value="">-- Default Client --</option>
                            @foreach($clientRoles as $role)
                                <option value="{{ $role->id }}"
                                    {{ old('client_role_id', optional($dataClient)->client_role_id ?? '') == $role->id ? 'selected' : '' }}>
                                    {{ $role->name }}
                                </option>
                            @endforeach
                        </select>
                        <div class="form-text small">Tentukan level akses untuk client ini.</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">KPP</label>
                        <input type="text" name="kpp" value="{{ old('kpp', $dataClient->kpp ?? '') }}" class="form-control" placeholder="Kantor Pelayanan Pajak">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">No. Telephone</label>
                        <input type="text" name="no_telephone" value="{{ old('no_telephone', $dataClient->no_telephone ?? '') }}" class="form-control" placeholder="0812-XXXX-XXXX">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Email</label>
                        <input type="email" name="email" value="{{ old('email', $dataClient->email ?? '') }}" class="form-control" placeholder="client@example.com">
                    </div>
                    @if($dataClient)
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Password</label>
                            <div class="input-group">
                                <input type="text" name="password" id="passwordField" class="form-control" placeholder="Kosongkan jika tidak diubah" value="{{ old('password') }}">
                                <button type="button" class="btn btn-outline-secondary" onclick="generatePassword()"><i class="bi bi-arrow-repeat"></i></button>
                            </div>
                            <div class="form-text small">Kosongkan jika tidak ingin mengubah password.</div>
                        </div>
                    @else
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Password <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <input type="text" name="password" id="passwordField" class="form-control" value="{{ $generatedPassword ?? '' }}" readonly>
                                <button type="button" class="btn btn-outline-secondary" onclick="generatePassword()"><i class="bi bi-arrow-repeat"></i></button>
                            </div>
                            <div class="form-text small text-info">Simpan password ini dan bagikan ke client.</div>
                        </div>
                    @endif
                    <div class="col-12">
                        <label class="form-label fw-semibold small">Alamat</label>
                        <textarea name="alamat" rows="3" class="form-control" placeholder="Alamat lengkap">{{ old('alamat', $dataClient->alamat ?? '') }}</textarea>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top">
                    <a href="{{ route('cms.data-client.index') }}" class="btn btn-light">Cancel</a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-check-lg me-1"></i> {{ $dataClient ? 'Update' : 'Create' }} Data Client
                    </button>
                </div>
            </form>
        </div>
    </div>
@endsection

@push('scripts')
<script>
    const peroranganList = ['Perorangan', 'Perseorangan', 'Individual'];

    document.getElementById('tipeBadan').addEventListener('change', function() {
        const label = document.getElementById('npwpLabel');
        const input = document.getElementById('npwpField');
        const opt = this.options[this.selectedIndex];
        const tipe = opt ? opt.dataset.tipe : '';

        if (peroranganList.includes(tipe)) {
            label.textContent = 'NIK';
            input.placeholder = '16 digit angka';
            input.maxLength = 16;
        } else {
            label.textContent = 'NPWP';
            input.placeholder = '16 digit angka';
            input.maxLength = 16;
        }
    });
    function generatePassword() {
        const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789!@#$%';
        let pwd = '';
        for (let i = 0; i < 12; i++) {
            pwd += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        document.getElementById('passwordField').value = pwd;
    }
</script>
@endpush
