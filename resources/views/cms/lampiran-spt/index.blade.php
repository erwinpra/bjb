@extends('cms::layouts.app')

@section('title', 'Lampiran SPT Tahunan')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Lampiran SPT</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-file-earmark-text me-2"></i>Lampiran SPT Tahunan</h6>
    </div>
    <div class="card-body p-4">
        <form method="GET" action="{{ route('cms.lampiran-spt.index') }}" class="row g-3 mb-4">
            <div class="col-md-5">
                <label class="form-label fw-semibold small">Client</label>
                <select name="client_id" class="form-select" required>
                    <option value="">-- Pilih Client --</option>
                    @foreach($clients as $c)
                        <option value="{{ $c->id }}" {{ $clientId == $c->id ? 'selected' : '' }}>
                            {{ $c->nama_client }} ({{ $c->npwp ?: '-' }})
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3">
                <label class="form-label fw-semibold small">Tahun</label>
                <select name="tahun" class="form-select">
                    @foreach($tahunList as $t)
                        <option value="{{ $t }}" {{ $tahun == $t ? 'selected' : '' }}>{{ $t }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-4 d-flex align-items-end">
                <button type="submit" class="btn btn-primary px-4">
                    <i class="bi bi-search me-1"></i> Tampilkan
                </button>
                @cmsCan('master_lampiran_spt', 'view')
                <a href="{{ route('cms.lampiran-spt.master') }}" class="btn btn-outline-secondary ms-2">
                    <i class="bi bi-gear me-1"></i> Kelola Master
                </a>
                @endCmsCan
            </div>
        </form>

        @if($clientId)
            <ul class="nav nav-tabs mb-3" id="lampiranTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="tab-input" data-bs-toggle="tab"
                        data-bs-target="#tabContent-input" type="button" role="tab">
                        <i class="bi bi-pencil-square me-1"></i> Lampiran SPT
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="tab-recap" data-bs-toggle="tab"
                        data-bs-target="#tabContent-recap" type="button" role="tab">
                        <i class="bi bi-bar-chart-line me-1"></i> Recap
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="lampiranTabContent">
                {{-- Tab: Lampiran SPT (Input) --}}
                <div class="tab-pane fade show active" id="tabContent-input" role="tabpanel">
                    {{-- Upload Section --}}
                    <div class="card border mb-4">
                        <div class="card-header bg-light py-2">
                            <h6 class="fw-semibold mb-0"><i class="bi bi-upload me-1"></i> Import dari Excel</h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3 align-items-end">
                                @cmsCan('lampiran_spt', 'create')
                                <div class="col-md-6">
                                    <form method="POST" action="{{ route('cms.lampiran-spt.import.preview') }}" enctype="multipart/form-data" id="formImport">
                                        @csrf
                                        <input type="hidden" name="client_id" value="{{ $clientId }}">
                                        <input type="hidden" name="tahun" value="{{ $tahun }}">
                                        <div class="input-group">
                                            <input type="file" name="file" class="form-control" accept=".xlsx,.xls,.csv" required>
                                            <button type="submit" class="btn btn-success">
                                                <i class="bi bi-eye me-1"></i> Preview
                                            </button>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-md-6">
                                    <a href="{{ route('cms.lampiran-spt.import.template') }}" class="btn btn-outline-primary">
                                        <i class="bi bi-download me-1"></i> Download Template
                                    </a>
                                    <small class="text-muted d-block mt-1">
                                        Download template Excel, isi data, lalu upload.
                                    </small>
                                </div>
                                @endCmsCan
                            </div>
                        </div>
                    </div>

                    {{-- Input Table --}}
                    <form method="POST" action="{{ route('cms.lampiran-spt.store') }}" id="formLampiran">
                        @csrf
                        <input type="hidden" name="client_id" value="{{ $clientId }}">
                        <input type="hidden" name="tahun" value="{{ $tahun }}">

                        <div class="table-responsive">
                            <table class="table table-bordered align-middle" id="tableLampiran">
                                <thead class="table-dark" style="font-size:0.8rem">
                                    <tr>
                                        <th style="width:120px">KODE</th>
                                        <th style="width:200px">NIK/NPWP</th>
                                        <th style="width:200px">DESKRIPSI</th>
                                        <th style="width:200px">NOMOR AKUN</th>
                                        <th style="width:200px">ATAS NAMA</th>
                                        <th style="width:220px">NAMA BANK/INSTITUSI</th>
                                        <th style="width:200px">LOKASI HARTA</th>
                                        <th style="width:100px">KURS</th>
                                        <th style="width:140px">THN PEROLEHAN</th>
                                        <th style="width:200px">SALDO SAAT INI</th>
                                        <th style="width:200px">SALDO BENTUK AWAL</th>
                                        <th style="width:160px">NILAI KURS</th>
                                        <th style="width:100px">AKSI</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @forelse($details as $d)
                                    <tr class="row-edit">
                                        <td>
                                            <input type="hidden" name="row_id[]" value="{{ $d->id }}">
                                            <span class="kode-text">{{ $d->kode }}</span>
                                            <select name="kode[]" class="cell-input cell-select d-none">
                                                <option value="">--</option>
                                                @foreach($masterItems as $m)
                                                    <option value="{{ $m->sub_kode }}" {{ $d->kode == $m->sub_kode ? 'selected' : '' }}>
                                                        {{ $m->sub_kode }} - {{ $m->nama }}
                                                    </option>
                                                @endforeach
                                            </select>
                                        </td>
                                        <td>
                                            @php
                                                $clientData = \App\Models\Cms\DataClient::find($clientId);
                                            @endphp
                                            <input type="text" name="nik_npwp[]" class="cell-input" value="{{ optional($clientData)->npwp ?? '' }}" readonly>
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->deskripsi ?: '-' }}</span>
                                            <input type="text" name="deskripsi[]" class="cell-input cell-edit d-none" value="{{ $d->deskripsi }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->nomor_akun ?: '-' }}</span>
                                            <input type="text" name="nomor_akun[]" class="cell-input cell-edit d-none" value="{{ $d->nomor_akun }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->atas_nama ?: '-' }}</span>
                                            <input type="text" name="atas_nama[]" class="cell-input cell-edit d-none" value="{{ $d->atas_nama }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->nama_bank_institusi ?: '-' }}</span>
                                            <input type="text" name="nama_bank_institusi[]" class="cell-input cell-edit d-none" value="{{ $d->nama_bank_institusi }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->lokasi_harta ?: '-' }}</span>
                                            <input type="text" name="lokasi_harta[]" class="cell-input cell-edit d-none" value="{{ $d->lokasi_harta }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->kurs ?: '-' }}</span>
                                            <input type="text" name="kurs[]" class="cell-input cell-edit d-none" value="{{ $d->kurs }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span>
                                            <select name="tahun_perolehan[]" class="cell-input cell-select cell-edit d-none">
                                                <option value="">--</option>
                                                @foreach($tahunPerolehanList as $t)
                                                    <option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>
                                                @endforeach
                                            </select>
                                        </td>
                                        <td>
                                            <span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? 'Rp ' . number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span>
                                            <input type="text" name="saldo_saat_ini[]" class="cell-input cell-edit format-currency text-end d-none" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}">
                                        </td>
                                        <td>
                                            <span class="field-display text-end">{{ $d->saldo_bentuk_awal > 0 ? 'Rp ' . number_format($d->saldo_bentuk_awal, 0, ',', '.') : '-' }}</span>
                                            <input type="text" name="saldo_bentuk_awal[]" class="cell-input cell-edit format-currency text-end d-none" value="{{ $d->saldo_bentuk_awal > 0 ? number_format($d->saldo_bentuk_awal, 0, ',', '.') : '' }}">
                                        </td>
                                        <td>
                                            <span class="field-display text-end">{{ $d->nilai_kurs > 0 ? number_format($d->nilai_kurs, 0, ',', '.') : '-' }}</span>
                                            <input type="text" name="nilai_kurs[]" class="cell-input cell-edit format-currency text-end d-none" value="{{ $d->nilai_kurs > 0 ? number_format($d->nilai_kurs, 0, ',', '.') : '' }}">
                                        </td>
                                        <td class="text-center">
                                            @cmsCan('lampiran_spt', 'edit')
                                            <button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            @endCmsCan
                                            @cmsCan('lampiran_spt', 'delete')
                                            <button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}">
                                                <i class="bi bi-trash3"></i>
                                            </button>
                                            @endCmsCan
                                        </td>
                                    </tr>
                                    @empty
                                    <tr class="empty-row">
                                        <td colspan="13" class="text-center text-muted py-4">
                                            <i class="bi bi-plus-circle d-block mb-1 fs-4"></i>
                                            Klik "Tambah Baris" untuk menambah data
                                        </td>
                                    </tr>
                                    @endforelse
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-between mt-3">
                            @cmsCan('lampiran_spt', 'create')
                            <button type="button" class="btn btn-outline-primary" id="btnAddRow">
                                <i class="bi bi-plus-lg me-1"></i> Tambah Baris
                            </button>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi bi-save me-1"></i> Simpan
                            </button>
                            @endCmsCan
                        </div>
                    </form>
                </div>

                {{-- Tab: Recap --}}
                <div class="tab-pane fade" id="tabContent-recap" role="tabpanel">
                    @if($details->isNotEmpty())
                        @php
                            $grouped = $details->groupBy('kode');
                            $grandTotal = $details->sum('saldo_saat_ini');
                        @endphp
                        @foreach($grouped as $kode => $items)
                            @php
                                $collapseId = 'recap-collapse-' . $loop->index;
                                $subTotal = $items->sum('saldo_saat_ini');
                                $first = $items->first();
                                $masterLabel = $masterItems->where('sub_kode', $kode)->first();
                                $label = $masterLabel ? $masterLabel->sub_kode . ' - ' . $masterLabel->nama : $kode;
                            @endphp
                            <div class="card border mb-3">
                                <div class="card-header bg-light py-2 collapse-toggle"
                                    role="button" data-bs-toggle="collapse"
                                    data-bs-target="#{{ $collapseId }}" aria-expanded="false">
                                    <h6 class="fw-semibold mb-0 d-flex justify-content-between align-items-center">
                                        <span>{{ $label }} <small class="text-muted fw-normal">(Rp {{ number_format($subTotal, 0, ',', '.') }})</small></span>
                                        <i class="bi bi-chevron-down collapse-icon transition-rotate"></i>
                                    </h6>
                                </div>
                                <div class="collapse" id="{{ $collapseId }}">
                                    <div class="card-body p-0">
                                        <table class="table table-sm mb-0">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>#</th>
                                                    <th>NOMOR AKUN</th>
                                                    <th>ATAS NAMA</th>
                                                    <th>BANK/INSTITUSI</th>
                                                    <th>LOKASI</th>
                                                    <th>KURS</th>
                                                    <th>THN PEROLEHAN</th>
                                                    <th class="text-end">SALDO SAAT INI</th>
                                                    <th class="text-end">SALDO AWAL</th>
                                                    <th class="text-end">NILAI KURS</th>
                                                    <th style="width:50px">AKSI</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                @foreach($items as $idx => $item)
                                                <tr data-row-id="{{ $item->id }}">
                                                    <td>{{ $idx + 1 }}</td>
                                                    <td>{{ $item->nomor_akun }}</td>
                                                    <td>{{ $item->atas_nama }}</td>
                                                    <td>{{ $item->nama_bank_institusi }}</td>
                                                    <td>{{ $item->lokasi_harta }}</td>
                                                    <td>{{ $item->kurs }}</td>
                                                    <td>{{ $item->tahun_perolehan }}</td>
                                                    <td class="text-end">Rp {{ number_format($item->saldo_saat_ini, 0, ',', '.') }}</td>
                                                    <td class="text-end">Rp {{ number_format($item->saldo_bentuk_awal, 0, ',', '.') }}</td>
                                                    <td class="text-end">{{ number_format($item->nilai_kurs, 2, ',', '.') }}</td>
                                                    <td class="text-center">
                                                        @cmsCan('lampiran_spt', 'delete')
                                                        <button type="button" class="btn btn-outline-danger btn-sm btn-delete-row" data-id="{{ $item->id }}" title="Hapus">
                                                            <i class="bi bi-trash3"></i>
                                                        </button>
                                                        @endCmsCan
                                                    </td>
                                                </tr>
                                                @endforeach
                                                <tr class="table-active fw-bold">
                                                    <td colspan="7" class="text-end">TOTAL {{ $label }}</td>
                                                    <td class="text-end text-primary">Rp {{ number_format($subTotal, 0, ',', '.') }}</td>
                                                    <td class="text-end text-primary">Rp {{ number_format($items->sum('saldo_bentuk_awal'), 0, ',', '.') }}</td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                        <div class="d-flex justify-content-end mt-2">
                            <div class="bg-danger text-white fw-bold fs-6 px-4 py-2 rounded">
                                TOTAL HARTA: Rp {{ number_format($grandTotal, 0, ',', '.') }}
                            </div>
                        </div>
                    @else
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-hand-index display-4 d-block mb-2 text-secondary opacity-50"></i>
                            Belum ada data Lampiran SPT untuk client ini.
                            <br><small>Isi data pada tab <strong>Lampiran SPT</strong> terlebih dahulu.</small>
                        </div>
                    @endif
                </div>
            </div>
        @else
            <div class="text-center text-muted py-5">
                <i class="bi bi-hand-index display-4 d-block mb-2 text-secondary opacity-50"></i>
                Pilih client dan tahun untuk mengisi Lampiran SPT Tahunan.
            </div>
        @endif
    </div>
</div>
@endsection

@push('styles')
<meta name="csrf-token" content="{{ csrf_token() }}">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
.select2-container--default .select2-selection--single {
    border: 1px solid #dee2e6;
    height: calc(2.25rem + 2px);
    padding: .25rem .5rem;
}
.select2-container--default .select2-selection--single .select2-selection__rendered {
    line-height: 1.5;
}
.collapse-toggle { cursor: pointer; user-select: none; }
.collapse-toggle:hover { background-color: #e9ecef; }
.cell-input, .cell-select {
    font-size: 0.8rem;
    width: 100%;
    border: none !important;
    background: transparent !important;
    padding: 2px 4px !important;
    outline: none;
    box-shadow: none !important;
    border-radius: 0 !important;
    -webkit-appearance: none;
    appearance: none;
}
.cell-input:focus, .cell-select:focus {
    outline: none;
}
#tableLampiran td, #tableLampiran th {
    padding: 2px 4px;
    vertical-align: middle;
    white-space: nowrap;
}
#tableLampiran tr .cell-input,
#tableLampiran tr .cell-select {
    border: 1px solid #ced4da !important;
    background: #fff !important;
    padding: 2px 4px !important;
    border-radius: 3px !important;
}
.cell-select { cursor: pointer; }
.field-display {
    display: inline-block;
    padding: 2px 4px;
    font-size: 0.8rem;
    min-height: 24px;
    line-height: 1.5;
}
</style>
@endpush

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
$(document).ready(function() {
    $('select[name="client_id"]').select2({
        placeholder: '-- Cari & Pilih Client --',
        allowClear: true,
        width: '100%'
    });
});

// Format currency inputs
document.addEventListener('input', function(e) {
    if (e.target.classList.contains('format-currency')) {
        var val = e.target.value.replace(/[^0-9]/g, '');
        if (val) {
            e.target.value = new Intl.NumberFormat('id-ID').format(parseInt(val, 10));
        }
    }
});

// Add row
document.getElementById('btnAddRow')?.addEventListener('click', function() {
    var tbody = document.querySelector('#tableLampiran tbody');
    var emptyRow = tbody.querySelector('.empty-row');
    if (emptyRow) emptyRow.remove();

    var options = '<option value="">--</option>';
    @foreach($masterItems as $m)
        options += '<option value="{{ $m->sub_kode }}">{{ $m->sub_kode }} - {{ $m->nama }}</option>';
    @endforeach

    var tr = document.createElement('tr');
    tr.className = 'row-new';
    var clientNpwp = '{{ optional(\App\Models\Cms\DataClient::find($clientId))->npwp ?? '' }}';
    tr.innerHTML = `
        <td>
            <select name="kode[]" class="cell-input cell-select">${options}</select>
        </td>
        <td><input type="text" name="nik_npwp[]" class="cell-input" value="` + clientNpwp + `"></td>
        <td><input type="text" name="deskripsi[]" class="cell-input"></td>
        <td><input type="text" name="nomor_akun[]" class="cell-input"></td>
        <td><input type="text" name="atas_nama[]" class="cell-input"></td>
        <td><input type="text" name="nama_bank_institusi[]" class="cell-input"></td>
        <td><input type="text" name="lokasi_harta[]" class="cell-input"></td>
        <td><input type="text" name="kurs[]" class="cell-input"></td>
        <td>
            <select name="tahun_perolehan[]" class="cell-input cell-select">
                <option value="">--</option>
                @foreach($tahunPerolehanList as $t)
                    <option value="{{ $t }}">{{ $t }}</option>
                @endforeach
            </select>
        </td>
        <td><input type="text" name="saldo_saat_ini[]" class="cell-input format-currency text-end"></td>
        <td><input type="text" name="saldo_bentuk_awal[]" class="cell-input format-currency text-end"></td>
        <td><input type="text" name="nilai_kurs[]" class="cell-input format-currency text-end"></td>
        <td class="text-center">
            <button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris">
                <i class="bi bi-trash3"></i>
            </button>
        </td>
    `;
    tbody.appendChild(tr);
});

// Toggle edit row
document.addEventListener('click', function(e) {
    var btn = e.target.closest('.btn-edit-row');
    if (!btn) return;
    var tr = btn.closest('tr');
    if (!tr) return;
    var isEditing = tr.classList.toggle('editing');

    // Toggle display text vs edit inputs
    tr.querySelectorAll('.field-display').forEach(function(el) {
        el.classList.toggle('d-none', isEditing);
    });
    tr.querySelectorAll('.cell-edit').forEach(function(el) {
        el.classList.toggle('d-none', !isEditing);
    });

    // Toggle kode text vs select
    var kodeText = tr.querySelector('.kode-text');
    var kodeSelect = tr.querySelector('td select[name="kode[]"]');
    if (kodeText && kodeSelect) {
        kodeText.classList.toggle('d-none', isEditing);
        kodeSelect.classList.toggle('d-none', !isEditing);
    }

    if (isEditing) {
        // Format currency on newly shown inputs
        tr.querySelectorAll('.format-currency').forEach(function(inp) {
            if (inp.value) {
                var num = inp.value.replace(/[^0-9]/g, '');
                if (num) inp.value = new Intl.NumberFormat('id-ID').format(parseInt(num, 10));
            }
        });
    } else {
        // Sync display spans with current input values
        tr.querySelectorAll('.cell-edit').forEach(function(inp) {
            var td = inp.closest('td');
            if (!td) return;
            var display = td.querySelector('.field-display');
            if (!display) return;
            var val = inp.value.trim();
            var isCurrency = inp.classList.contains('format-currency');
            if (isCurrency) {
                var num = val.replace(/[^0-9]/g, '');
                display.textContent = num ? 'Rp ' + new Intl.NumberFormat('id-ID').format(parseInt(num, 10)) : '-';
            } else if (inp.tagName === 'SELECT') {
                display.textContent = val || '-';
            } else {
                display.textContent = val || '-';
            }
        });
        // Sync kode
        var kodeSelect = tr.querySelector('td select[name="kode[]"]');
        var kodeText = tr.querySelector('.kode-text');
        if (kodeSelect && kodeText) {
            kodeText.textContent = kodeSelect.value || '';
        }
    }

    // Toggle button icon & color
    var icon = btn.querySelector('i');
    if (isEditing) {
        btn.classList.remove('btn-outline-primary');
        btn.classList.add('btn-outline-success');
        icon.className = 'bi bi-check-lg';
    } else {
        btn.classList.remove('btn-outline-success');
        btn.classList.add('btn-outline-primary');
        icon.className = 'bi bi-pencil';
    }
});

// Delete row (AJAX with confirmation)
function deleteRow(id, tr) {
    if (!confirm('Hapus data ini?')) return;
    var csrf = document.querySelector('meta[name="csrf-token"]');
    var token = csrf ? csrf.getAttribute('content') : '';
    fetch('/admin/lampiran-spt/row/' + id, {
        method: 'DELETE',
        headers: { 'X-CSRF-TOKEN': token }
    }).then(function(r) { return r.json(); }).then(function(res) {
        if (res.success) {
            if (tr) tr.remove();
        } else {
            alert('Gagal menghapus data.');
        }
    }).catch(function() { alert('Terjadi kesalahan.'); });
}

// Remove row (from input tab - AJAX if has ID, else just remove DOM)
document.addEventListener('click', function(e) {
    var btn = e.target.closest('.btn-remove-row');
    if (btn) {
        var tr = btn.closest('tr');
        var id = btn.getAttribute('data-id');
        if (id) {
            deleteRow(id, tr);
        } else if (tr) {
            tr.remove();
        }
    }
});

// Delete row from recap tab
document.addEventListener('click', function(e) {
    var btn = e.target.closest('.btn-delete-row');
    if (btn) {
        var tr = btn.closest('tr');
        var id = btn.getAttribute('data-id');
        if (id) deleteRow(id, tr);
    }
});

// Collapse toggle icons
document.querySelectorAll('.collapse-toggle').forEach(function(header) {
    var icon = header.querySelector('.collapse-icon');
    if (icon) {
        var target = document.querySelector(header.getAttribute('data-bs-target'));
        if (target) {
            target.addEventListener('show.bs.collapse', function() { icon.classList.add('rotate-180'); });
            target.addEventListener('hide.bs.collapse', function() { icon.classList.remove('rotate-180'); });
        }
    }
});

// Persist active tab
var tabKey = localStorage.getItem('lampiranSptTab');
if (tabKey) {
    var tab = document.querySelector('#lampiranTabs button[data-bs-target="' + tabKey + '"]');
    if (tab) { var trigger = new bootstrap.Tab(tab); trigger.show(); }
}
document.querySelectorAll('#lampiranTabs button[data-bs-toggle="tab"]').forEach(function(btn) {
    btn.addEventListener('shown.bs.tab', function(e) {
        localStorage.setItem('lampiranSptTab', btn.getAttribute('data-bs-target'));
    });
});
</script>
@endpush
