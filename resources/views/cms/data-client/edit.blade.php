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
                        <label class="form-label fw-semibold small" id="npwpLabel">NIK</label>
                        <input type="text" name="npwp" id="npwpField" value="{{ old('npwp', $dataClient->npwp ?? '') }}" class="form-control @error('npwp') is-invalid @enderror" placeholder="15-16 digit angka" maxlength="16" inputmode="numeric">
                        <div id="npwpWarning" class="text-danger small mt-1 d-none"><i class="bi bi-exclamation-triangle me-1"></i><span id="npwpWarningText"></span></div>
                        @error('npwp') <div class="invalid-feedback">{{ $message }}</div> @enderror
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
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">PTKP</label>
                        <input type="text" name="ptkp" value="{{ old('ptkp', $dataClient->ptkp ?? '') }}" class="form-control" placeholder="PTKP">
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
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Alamat NPWP</label>
                        <textarea name="alamat_npwp" rows="3" class="form-control" placeholder="Alamat sesuai NPWP">{{ old('alamat_npwp', $dataClient->alamat_npwp ?? '') }}</textarea>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Alamat Tagihan</label>
                        <textarea name="alamat_tagihan" rows="3" class="form-control" placeholder="Alamat untuk penagihan">{{ old('alamat_tagihan', $dataClient->alamat_tagihan ?? '') }}</textarea>
                    </div>
                </div>

                {{-- Cabang --}}
                <div class="mt-4 pt-3 border-top">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="fw-semibold mb-0"><i class="bi bi-diagram-2 me-2"></i>Cabang</h6>
                        @cmsCan('data_client', 'edit')
                        <button type="button" class="btn btn-sm btn-outline-primary" onclick="addCabangRow()">
                            <i class="bi bi-plus-lg me-1"></i> Tambah Cabang
                        </button>
                        @endCmsCan
                    </div>
                    <div style="overflow-x: auto;">
                        <table class="table table-sm table-bordered mb-0" id="cabangTable">
                            <thead class="table-light">
                                <tr>
                                    <th style="min-width:140px">Nama</th>
                                    <th style="min-width:120px">NIK</th>
                                    <th style="min-width:120px">KPP</th>
                                    <th style="min-width:160px">Email</th>
                                    <th style="min-width:110px">No. Telp</th>
                                    <th style="min-width:160px">Alamat NPWP</th>
                                    <th style="min-width:160px">Alamat Tagihan</th>
                                    <th style="min-width:80px">PTKP</th>
                                    <th style="width:50px"></th>
                                </tr>
                            </thead>
                            <tbody id="cabangTableBody">
                                @php $cabangIdx = 0; @endphp
                                @if($dataClient)
                                    @foreach($dataClient->cabangs as $cab)
                                    <tr>
                                        <td>
                                            <input type="hidden" name="cabang_id[]" value="{{ $cab->id }}">
                                            <input type="text" name="cabang_nama[]" value="{{ $cab->nama_client }}" class="form-control form-control-sm">
                                        </td>
                                        <td><input type="text" name="cabang_npwp[]" value="{{ $cab->npwp }}" class="form-control form-control-sm"></td>
                                        <td><input type="text" name="cabang_kpp[]" value="{{ $cab->kpp }}" class="form-control form-control-sm"></td>
                                        <td><input type="email" name="cabang_email[]" value="{{ $cab->email }}" class="form-control form-control-sm"></td>
                                        <td><input type="text" name="cabang_no_telephone[]" value="{{ $cab->no_telephone }}" class="form-control form-control-sm"></td>
                                        <td><input type="text" name="cabang_alamat_npwp[]" value="{{ $cab->alamat_npwp }}" class="form-control form-control-sm"></td>
                                        <td><input type="text" name="cabang_alamat_tagihan[]" value="{{ $cab->alamat_tagihan }}" class="form-control form-control-sm"></td>
                                        <td><input type="text" name="cabang_ptkp[]" value="{{ $cab->ptkp }}" class="form-control form-control-sm"></td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('tr').remove()">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    @php $cabangIdx++; @endphp
                                    @endforeach
                                @endif
                            </tbody>
                        </table>
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
            input.placeholder = '15-16 digit angka';
            input.maxLength = 16;
        } else {
            label.textContent = 'NPWP';
            input.placeholder = '15-16 digit angka';
            input.maxLength = 16;
        }
        validateNpwpField();
    });

    document.getElementById('npwpField').addEventListener('input', validateNpwpField);
    document.getElementById('npwpField').addEventListener('blur', validateNpwpField);

    function validateNpwpField() {
        const input = document.getElementById('npwpField');
        const warning = document.getElementById('npwpWarning');
        const warningText = document.getElementById('npwpWarningText');
        const val = input.value;

        if (!val) {
            warning.classList.add('d-none');
            return;
        }

        const hasNonDigit = /[^0-9]/.test(val);

        if (hasNonDigit) {
            warningText.textContent = 'NIK hanya boleh terdiri dari 15-16 digit angka. Simbol atau huruf tidak diperbolehkan.';
            warning.classList.remove('d-none');
        } else if (val.length > 0 && val.length < 15) {
            warningText.textContent = 'NIK minimal 15 digit angka (saat ini ' + val.length + ' digit).';
            warning.classList.remove('d-none');
        } else {
            warning.classList.add('d-none');
        }
    }

    function generatePassword() {
        const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjkmnpqrstuvwxyz23456789!@#$%';
        let pwd = '';
        for (let i = 0; i < 12; i++) {
            pwd += chars.charAt(Math.floor(Math.random() * chars.length));
        }
        document.getElementById('passwordField').value = pwd;
    }

    function addCabangRow() {
        const tbody = document.getElementById('cabangTableBody');
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>
                <input type="hidden" name="cabang_id[]" value="">
                <input type="text" name="cabang_nama[]" class="form-control form-control-sm" placeholder="Nama cabang">
            </td>
            <td><input type="text" name="cabang_npwp[]" class="form-control form-control-sm" placeholder="NIK"></td>
            <td><input type="text" name="cabang_kpp[]" class="form-control form-control-sm" placeholder="KPP"></td>
            <td><input type="email" name="cabang_email[]" class="form-control form-control-sm" placeholder="Email"></td>
            <td><input type="text" name="cabang_no_telephone[]" class="form-control form-control-sm" placeholder="No. Telp"></td>
            <td><input type="text" name="cabang_alamat_npwp[]" class="form-control form-control-sm" placeholder="Alamat NPWP"></td>
            <td><input type="text" name="cabang_alamat_tagihan[]" class="form-control form-control-sm" placeholder="Alamat Tagihan"></td>
            <td><input type="text" name="cabang_ptkp[]" class="form-control form-control-sm" placeholder="PTKP"></td>
            <td class="text-center">
                <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('tr').remove()">
                    <i class="bi bi-trash"></i>
                </button>
            </td>
        `;
        tbody.appendChild(tr);
    }
</script>
@endpush
