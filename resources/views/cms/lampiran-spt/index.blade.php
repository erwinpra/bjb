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
                                        <div class="input-group">
                                            <input type="file" name="file" class="form-control" accept=".xlsx,.xls,.csv" required>
                                            <button type="submit" class="btn btn-success">
                                                <i class="bi bi-eye me-1"></i> Preview
                                            </button>
                                        </div>
                                        <small class="text-muted d-block mt-1">
                                            <i class="bi bi-info-circle me-1"></i>
                                            Client dan tahun akan dibaca dari file Excel (baris NIK/NPWP dan tahun).
                                        </small>
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

                    {{-- Per Page & Pagination --}}
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <form method="GET" action="{{ route('cms.lampiran-spt.index') }}" class="d-flex align-items-center gap-2">
                            <input type="hidden" name="client_id" value="{{ $clientId }}">
                            <input type="hidden" name="tahun" value="{{ $tahun }}">
                            <label class="small text-muted mb-0">Tampilkan</label>
                            <select name="per_page" class="form-select form-select-sm" style="width:auto" onchange="this.form.submit()">
                                <option value="10" {{ ($perPage ?? 10) == 10 ? 'selected' : '' }}>10</option>
                                <option value="20" {{ ($perPage ?? 10) == 20 ? 'selected' : '' }}>20</option>
                                <option value="50" {{ ($perPage ?? 10) == 50 ? 'selected' : '' }}>50</option>
                            </select>
                            <small class="text-muted">{{ $details->total() ?? 0 }} data</small>
                        </form>
                    </div>

                    {{-- Input Table --}}
                    <form method="POST" action="{{ route('cms.lampiran-spt.store') }}" id="formLampiran" onsubmit="return false;">
                        @csrf
                        <input type="hidden" name="client_id" value="{{ $clientId }}">
                        <input type="hidden" name="tahun" value="{{ $tahun }}">

                        @php $masterByKode = $masterItems->keyBy('sub_kode'); @endphp
                        <div class="table-responsive">
                            <table class="table table-bordered align-middle" id="tableLampiran">
                                <thead class="table-dark" style="font-size:0.8rem">
                                    <tr>
                                        <th style="width:120px">KODE</th>
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
                                    <tr class="row-edit" data-row-id="{{ $d->id }}">
                                        <td>
                                            <span class="kode-text">{{ $d->kode }}</span>
                                            <select class="cell-input cell-select d-none">
                                                <option value="">--</option>
                                                @foreach($activeMasterItems as $m)
                                                    <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>
                                                        {{ $m->sub_kode }} - {{ $m->nama }}
                                                    </option>
                                                @endforeach
                                            </select>
                                        </td>
                                        <td>
                                            <span class="field-display">{{ isset($masterByKode[$d->kode]) ? $masterByKode[$d->kode]->nama : ($d->deskripsi ?: '-') }}</span>
                                            <input type="text" class="cell-input cell-edit d-none" value="{{ $d->deskripsi }}" readonly>
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->nomor_akun ?: '-' }}</span>
                                            <input type="text" class="cell-input cell-edit d-none" value="{{ $d->nomor_akun }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->atas_nama ?: '-' }}</span>
                                            <input type="text" class="cell-input cell-edit d-none" value="{{ $d->atas_nama }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->nama_bank_institusi ?: '-' }}</span>
                                            <input type="text" class="cell-input cell-edit d-none" value="{{ $d->nama_bank_institusi }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->lokasi_harta ?: '-' }}</span>
                                            <input type="text" class="cell-input cell-edit d-none" value="{{ $d->lokasi_harta }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->kurs ?: '-' }}</span>
                                            <input type="text" class="cell-input cell-edit d-none" value="{{ $d->kurs }}">
                                        </td>
                                        <td>
                                            <span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span>
                                            <select class="cell-input cell-select cell-edit d-none">
                                                <option value="">--</option>
                                                @foreach($tahunPerolehanList as $t)
                                                    <option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>
                                                @endforeach
                                            </select>
                                        </td>
                                        <td>
                                            <span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span>
                                            <input type="text" class="cell-input cell-edit format-number text-end d-none" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}">
                                        </td>
                                        <td>
                                            <span class="field-display text-end">{{ $d->saldo_bentuk_awal > 0 ? number_format($d->saldo_bentuk_awal, 2, ',', '.') : '-' }}</span>
                                            <input type="text" class="cell-input cell-edit format-currency text-end d-none" value="{{ $d->saldo_bentuk_awal > 0 ? number_format($d->saldo_bentuk_awal, 2, ',', '.') : '' }}">
                                        </td>
                                        <td>
                                            <span class="field-display text-end">{{ $d->nilai_kurs > 0 ? number_format($d->nilai_kurs, 2, ',', '.') : '-' }}</span>
                                            <input type="text" class="cell-input cell-edit format-currency text-end d-none" value="{{ $d->nilai_kurs > 0 ? number_format($d->nilai_kurs, 2, ',', '.') : '' }}">
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
                                        <td colspan="12" class="text-center text-muted py-4">
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
                            <button type="button" class="btn btn-primary px-4" id="btnSimpan">
                                <i class="bi bi-save me-1"></i> Simpan
                            </button>
                            @endCmsCan
                        </div>
                    </form>

                    @if($details->hasPages())
                    <div class="mt-3 d-flex justify-content-center">
                        {{ $details->appends(['client_id' => $clientId, 'tahun' => $tahun, 'per_page' => $perPage])->links('pagination::bootstrap-4') }}
                    </div>
                    @endif
                </div>

                {{-- Tab: Recap --}}
                <div class="tab-pane fade" id="tabContent-recap" role="tabpanel">
                    @php
                        $hutangHarga = $recapGroups->where('kategori.label', 'TOTAL HUTANG')->sum('subHarga');
                        $hutangNilai = $recapGroups->where('kategori.label', 'TOTAL HUTANG')->sum('subNilai');
                        $totalPerolehanHarga = $recapGroups->sum('subHarga') - $hutangHarga;
                        $totalPerolehanNilai = $recapGroups->sum('subNilai') - $hutangNilai;
                        $netHarga = $totalPerolehanHarga - $hutangHarga;
                        $netNilai = $totalPerolehanNilai - $hutangNilai;
                    @endphp
                    @foreach($recapGroups as $rg)
                        @php
                            $collapseId = 'recap-collapse-' . $loop->index;
                            $kat = $rg['kategori'];
                            $kodeGroups = $rg['kodeGroups'];
                            $hasItems = $kodeGroups->isNotEmpty();
                        @endphp
                        <div class="card border mb-3">
                            <div class="card-header bg-light py-2 collapse-toggle"
                                role="button" data-bs-toggle="collapse"
                                data-bs-target="#{{ $collapseId }}" aria-expanded="false">
                                <h6 class="fw-semibold mb-0 d-flex justify-content-between align-items-center">
                                    <span>{{ $kat->label }}</span>
                                    <i class="bi bi-chevron-down collapse-icon transition-rotate"></i>
                                </h6>
                            </div>
                            <div class="collapse" id="{{ $collapseId }}">
                                <div class="card-body p-0">
                                    @if($hasItems)
                                    <table class="table table-sm mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th style="width:40px">#</th>
                                                <th style="width:80px">KODE</th>
                                                <th>DESKRIPSI</th>
                                                <th class="text-end" style="width:180px">HARGA PEROLEHAN</th>
                                                <th class="text-end" style="width:180px">NILAI SAAT INI</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach($kodeGroups as $idx => $g)
                                            <tr>
                                                <td>{{ $idx + 1 }}</td>
                                                <td><code>{{ $g['kode'] }}</code></td>
                                                <td>{{ $g['deskripsi'] }}</td>
                                                <td class="text-end">{{ number_format($g['total_harga'], 0, ',', '.') }}</td>
                                                <td class="text-end">{{ number_format($g['total_nilai'], 0, ',', '.') }}</td>
                                            </tr>
                                            @endforeach
                                            <tr class="table-active fw-bold">
                                                <td colspan="3" class="text-end">TOTAL {{ $kat->label }}</td>
                                                <td class="text-end text-primary">{{ number_format($rg['subHarga'], 0, ',', '.') }}</td>
                                                <td class="text-end text-primary">{{ number_format($rg['subNilai'], 0, ',', '.') }}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    @else
                                    <div class="text-center text-muted py-3">
                                        <small>Belum ada data untuk kategori ini.</small>
                                    </div>
                                    @endif
                                </div>
                            </div>
                        </div>
                    @endforeach
                    <div class="d-flex justify-content-end mt-3">
                        <div class="bg-primary text-white fw-bold fs-6 px-4 py-2 rounded d-flex gap-5">
                            <span>TOTAL PEROLEHAN: {{ number_format($totalPerolehanHarga, 0, ',', '.') }}</span>
                            <span>TOTAL NILAI SAAT INI: {{ number_format($totalPerolehanNilai, 0, ',', '.') }}</span>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end mt-2">
                        <div class="bg-dark text-white fw-bold fs-6 px-4 py-2 rounded d-flex gap-5">
                            <span>NET: {{ number_format($netHarga, 0, ',', '.') }}</span>
                            <span>NET: {{ number_format($netNilai, 0, ',', '.') }}</span>
                        </div>
                    </div>

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
.select2-container--default .select2-selection--single .select2-selection__arrow {
    height: calc(2.25rem + 2px);
}
#tableLampiran .select2-container {
    width: 100% !important;
}
#tableLampiran .select2-container--default .select2-selection--single {
    height: auto;
    min-height: 28px;
    padding: 1px 4px;
    font-size: 0.8rem;
    border-color: #ced4da;
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

function formatIdCurrency(val) {
    if (!val) return '';
    var num = parseFloat(val.replace(/\./g, '').replace(',', '.'));
    if (isNaN(num)) return val;
    return new Intl.NumberFormat('id-ID', { minimumFractionDigits: 2, maximumFractionDigits: 2 }).format(num);
}

function formatNumber(val) {
    if (!val) return '';
    var num = parseInt(val.replace(/\./g, ''), 10);
    if (isNaN(num)) return val;
    return new Intl.NumberFormat('id-ID', { minimumFractionDigits: 0, maximumFractionDigits: 0 }).format(num);
}

// Format inputs (blur for currency to allow free typing, input for number only)
document.addEventListener('blur', function(e) {
    if (e.target.classList.contains('format-currency')) {
        var val = e.target.value.replace(/\./g, '').replace(',', '.');
        var num = parseFloat(val);
        if (!isNaN(num)) {
            e.target.value = new Intl.NumberFormat('id-ID', { minimumFractionDigits: 2, maximumFractionDigits: 2 }).format(num);
        }
    }
}, true);
document.addEventListener('input', function(e) {
    if (e.target.classList.contains('format-number')) {
        e.target.value = formatNumber(e.target.value);
    }
});

// Populate deskripsi from option text
function populateDeskripsi(sel) {
    var tr = sel.closest('tr');
    if (!tr) return;
    var text = sel.options[sel.selectedIndex] ? sel.options[sel.selectedIndex].text : '';
    var parts = text.split(' - ');
    var nama = parts.length > 1 ? parts.slice(1).join(' - ') : '';
    var deskTd = tr.cells[1];
    if (deskTd) {
        var inp = deskTd.querySelector('input');
        if (inp) inp.value = nama;
        var display = deskTd.querySelector('.field-display');
        if (display) display.textContent = nama || '-';
    }
}

// Init Select2 on kode select with search
function initKodeSelect(select) {
    if (!select) return;
    $(select).select2({
        placeholder: '-- Cari Kode --',
        allowClear: true,
        width: '100%',
        dropdownAutoWidth: true,
    }).on('select2:select select2:clear', function(e) {
        populateDeskripsi(this);
    });
}

// Destroy Select2 on kode select
function destroyKodeSelect(select) {
    if (!select) return;
    var $sel = $(select);
    if ($sel.hasClass('select2-hidden-accessible')) {
        $sel.select2('destroy');
    }
}

// Auto-populate deskripsi from master when kode changes (native fallback)
document.addEventListener('change', function(e) {
    var td = e.target.closest('td');
    if (e.target.tagName === 'SELECT' && td && td.cellIndex === 0) {
        populateDeskripsi(e.target);
    }
});

// Add row
document.getElementById('btnAddRow')?.addEventListener('click', function() {
    var tbody = document.querySelector('#tableLampiran tbody');
    var emptyRow = tbody.querySelector('.empty-row');
    if (emptyRow) emptyRow.remove();

    var tr = document.createElement('tr');
    tr.className = 'row-new';

    function makeTd() {
        return document.createElement('td');
    }

    // KODE
    var td1 = makeTd();
    var selKode = document.createElement('select');
    selKode.className = 'cell-input cell-select';
    var opt0 = document.createElement('option');
    opt0.value = '';
    opt0.textContent = '--';
    selKode.appendChild(opt0);
    @foreach($activeMasterItems as $m)
    (function() {
        var o = document.createElement('option');
        o.value = '{{ $m->sub_kode }}';
        o.textContent = '{{ $m->sub_kode }} - {{ $m->nama }}';
        selKode.appendChild(o);
    })();
    @endforeach
    td1.appendChild(selKode);
    tr.appendChild(td1);

    // DESKRIPSI
    var td2 = makeTd();
    var inpDesk = document.createElement('input');
    inpDesk.type = 'text';
    inpDesk.className = 'cell-input';
    inpDesk.readOnly = true;
    td2.appendChild(inpDesk);
    tr.appendChild(td2);

    // NOMOR AKUN
    var td3 = makeTd();
    var inpAkun = document.createElement('input');
    inpAkun.type = 'text';
    inpAkun.className = 'cell-input';
    td3.appendChild(inpAkun);
    tr.appendChild(td3);

    // ATAS NAMA
    var td4 = makeTd();
    var inpNama = document.createElement('input');
    inpNama.type = 'text';
    inpNama.className = 'cell-input';
    td4.appendChild(inpNama);
    tr.appendChild(td4);

    // NAMA BANK/INSTITUSI
    var td5 = makeTd();
    var inpBank = document.createElement('input');
    inpBank.type = 'text';
    inpBank.className = 'cell-input';
    td5.appendChild(inpBank);
    tr.appendChild(td5);

    // LOKASI HARTA
    var td6 = makeTd();
    var inpLokasi = document.createElement('input');
    inpLokasi.type = 'text';
    inpLokasi.className = 'cell-input';
    td6.appendChild(inpLokasi);
    tr.appendChild(td6);

    // KURS
    var td7 = makeTd();
    var inpKurs = document.createElement('input');
    inpKurs.type = 'text';
    inpKurs.className = 'cell-input';
    td7.appendChild(inpKurs);
    tr.appendChild(td7);

    // THN PEROLEHAN
    var td8 = makeTd();
    var selTahun = document.createElement('select');
    selTahun.className = 'cell-input cell-select';
    var topt0 = document.createElement('option');
    topt0.value = '';
    topt0.textContent = '--';
    selTahun.appendChild(topt0);
    @foreach($tahunPerolehanList as $t)
    (function() {
        var o = document.createElement('option');
        o.value = '{{ $t }}';
        o.textContent = '{{ $t }}';
        selTahun.appendChild(o);
    })();
    @endforeach
    td8.appendChild(selTahun);
    tr.appendChild(td8);

    // SALDO SAAT INI
    var td9 = makeTd();
    var inpSaldoIni = document.createElement('input');
    inpSaldoIni.type = 'text';
    inpSaldoIni.className = 'cell-input format-number text-end';
    td9.appendChild(inpSaldoIni);
    tr.appendChild(td9);

    // SALDO BENTUK AWAL
    var td10 = makeTd();
    var inpSaldoAwal = document.createElement('input');
    inpSaldoAwal.type = 'text';
    inpSaldoAwal.className = 'cell-input format-currency text-end';
    td10.appendChild(inpSaldoAwal);
    tr.appendChild(td10);

    // NILAI KURS
    var td11 = makeTd();
    var inpNilaiKurs = document.createElement('input');
    inpNilaiKurs.type = 'text';
    inpNilaiKurs.className = 'cell-input format-currency text-end';
    td11.appendChild(inpNilaiKurs);
    tr.appendChild(td11);

    // AKSI
    var td12 = document.createElement('td');
    td12.className = 'text-center';
    var btnSave = document.createElement('button');
    btnSave.type = 'button';
    btnSave.className = 'btn btn-outline-success btn-sm';
    btnSave.title = 'Simpan baris';
    var iconSave = document.createElement('i');
    iconSave.className = 'bi bi-check-lg';
    btnSave.appendChild(iconSave);
    td12.appendChild(btnSave);

    var btnHapus = document.createElement('button');
    btnHapus.type = 'button';
    btnHapus.className = 'btn btn-outline-danger btn-sm btn-remove-row';
    btnHapus.title = 'Hapus baris';
    var iconHapus = document.createElement('i');
    iconHapus.className = 'bi bi-trash3';
    btnHapus.appendChild(iconHapus);
    td12.appendChild(btnHapus);
    tr.appendChild(td12);

    tbody.appendChild(tr);

    selKode.addEventListener('change', function() {
        var text = this.options[this.selectedIndex] ? this.options[this.selectedIndex].text : '';
        var idx = text.indexOf(' - ');
        inpDesk.value = idx > 0 ? text.substring(idx + 3) : '';
    });

    // Save only this new row via AJAX
    btnSave.addEventListener('click', function() {
        var csrf = document.querySelector('meta[name="csrf-token"]');
        var form = document.getElementById('formLampiran');
        var data = new URLSearchParams();
        data.append('_token', csrf ? csrf.getAttribute('content') : '');
        data.append('client_id', form.querySelector('input[name="client_id"]').value);
        data.append('tahun', form.querySelector('input[name="tahun"]').value);
        data.append('kode', selKode.value);
        data.append('deskripsi', inpDesk.value);
        data.append('nomor_akun', inpAkun.value);
        data.append('atas_nama', inpNama.value);
        data.append('nama_bank_institusi', inpBank.value);
        data.append('lokasi_harta', inpLokasi.value);
        data.append('kurs', inpKurs.value);
        data.append('tahun_perolehan', selTahun.value);
        data.append('saldo_saat_ini', inpSaldoIni.value.replace(/\./g, ''));
        data.append('saldo_bentuk_awal', inpSaldoAwal.value.replace(/\./g, ''));
        data.append('nilai_kurs', inpNilaiKurs.value.replace(/\./g, ''));

        fetch('{{ route('cms.lampiran-spt.row.save') }}', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded', 'X-CSRF-TOKEN': csrf ? csrf.getAttribute('content') : '' },
            body: data.toString(),
        }).then(function(r) {
            if (r.ok) location.reload();
            else alert('Gagal menyimpan data.');
        }).catch(function() { alert('Terjadi kesalahan.'); });
    });
});

// Global Simpan via JSON
document.getElementById('btnSimpan')?.addEventListener('click', function() {
    var csrf = document.querySelector('meta[name="csrf-token"]');
    var form = document.getElementById('formLampiran');
    var clientId = form.querySelector('input[name="client_id"]').value;
    var tahun = form.querySelector('input[name="tahun"]').value;

    function cellVal(tr, idx) {
        var td = tr.children[idx];
        if (!td) return '';
        var inp = td.querySelector('input, select');
        return inp ? inp.value : '';
    }
    function cellNum(tr, idx) {
        return cellVal(tr, idx).replace(/\./g, '').replace(',', '.');
    }

    var rows = [];
    document.querySelectorAll('#tableLampiran tbody tr.row-edit, #tableLampiran tbody tr.row-new').forEach(function(tr) {
        var kode = cellVal(tr, 0);
        if (!kode) return;

        rows.push({
            row_id: tr.getAttribute('data-row-id') || null,
            kode: kode,
            deskripsi: cellVal(tr, 1),
            nomor_akun: cellVal(tr, 2),
            atas_nama: cellVal(tr, 3),
            nama_bank_institusi: cellVal(tr, 4),
            lokasi_harta: cellVal(tr, 5),
            kurs: cellVal(tr, 6),
            tahun_perolehan: cellVal(tr, 7),
            saldo_saat_ini: cellNum(tr, 8),
            saldo_bentuk_awal: cellNum(tr, 9),
            nilai_kurs: cellNum(tr, 10),
        });
    });

    if (!rows.length) { alert('Tidak ada data untuk disimpan.'); return; }

    var body = { _token: csrf ? csrf.getAttribute('content') : '', client_id: clientId, tahun: tahun, rows: rows };

    fetch(form.action, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrf ? csrf.getAttribute('content') : '' },
        body: JSON.stringify(body),
    }).then(function(r) {
        if (r.ok) location.reload();
        else return r.text().then(function(t) { alert('Gagal menyimpan: ' + t); });
    }).catch(function() { alert('Terjadi kesalahan.'); });

    var body = { _token: csrf ? csrf.getAttribute('content') : '', client_id: clientId, tahun: tahun, rows: rows };

    fetch(form.action, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': csrf ? csrf.getAttribute('content') : '' },
        body: JSON.stringify(body),
    }).then(function(r) {
        if (r.ok) location.reload();
        else return r.text().then(function(t) { alert('Gagal menyimpan: ' + t); });
    }).catch(function() { alert('Terjadi kesalahan.'); });
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
    var kodeSelect = tr.cells[0] ? tr.cells[0].querySelector('select') : null;
    if (kodeText && kodeSelect) {
        kodeText.classList.toggle('d-none', isEditing);
        kodeSelect.classList.toggle('d-none', !isEditing);
    }

    if (isEditing) {
        // Init Select2 on kode select for search
        if (kodeSelect) {
            initKodeSelect(kodeSelect);
        }
        // Format inputs on newly shown fields
        tr.querySelectorAll('.format-currency').forEach(function(inp) {
            if (inp.value) inp.value = formatIdCurrency(inp.value);
        });
        tr.querySelectorAll('.format-number').forEach(function(inp) {
            if (inp.value) inp.value = formatNumber(inp.value);
        });
        // Populate deskripsi from master based on current kode selection
        if (kodeSelect) {
            var text = kodeSelect.options[kodeSelect.selectedIndex] ? kodeSelect.options[kodeSelect.selectedIndex].text : '';
            var parts = text.split(' - ');
            var nama = parts.length > 1 ? parts.slice(1).join(' - ') : '';
            var deskInput = tr.cells[1] ? tr.cells[1].querySelector('input') : null;
            if (deskInput) deskInput.value = nama;
        }
    } else {
        // Destroy Select2 on kode select
        if (kodeSelect) {
            destroyKodeSelect(kodeSelect);
        }
        // Sync display spans with current input values
        tr.querySelectorAll('.cell-edit').forEach(function(inp) {
            var td = inp.closest('td');
            if (!td) return;
            var display = td.querySelector('.field-display');
            if (!display) return;
            var val = inp.value.trim();
            var isCurrency = inp.classList.contains('format-currency');
            var isNumber = inp.classList.contains('format-number');
            if (isCurrency) {
                display.textContent = formatIdCurrency(val) || '-';
            } else if (isNumber) {
                display.textContent = formatNumber(val) || '-';
            } else if (inp.tagName === 'SELECT') {
                display.textContent = val || '-';
            } else {
                display.textContent = val || '-';
            }
        });
        // Sync kode
        var kodeSelect = tr.cells[0] ? tr.cells[0].querySelector('select') : null;
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
