@extends('cms::layouts.app')

@section('title', 'Transaksi Baru')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Transaksi Baru</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
        <h6 class="fw-semibold mb-0"><i class="bi bi-arrow-left-right me-2"></i>Form Transaksi</h6>
    </div>
    <div class="card-body p-4">
        <form id="formTransaksi" method="POST" action="{{ route('cms.transaksi.store') }}">
            @csrf

            {{-- Loading Overlay --}}
            <div id="loadingOverlay" class="d-none" style="position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(255,255,255,0.85);z-index:1060;display:flex;align-items:center;justify-content:center;">
                <div class="text-center">
                    <div class="spinner-border text-primary mb-2" role="status" style="width:2.5rem;height:2.5rem;"></div>
                    <div class="small text-muted">Memuat data...</div>
                </div>
            </div>

            {{-- Data Client --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-primary border-bottom pb-2"><i class="bi bi-person-badge me-2"></i>Data Client</h6>
                </div>
                <div class="col-md-8">
                    <label class="form-label fw-semibold small">Pilih Client <span class="text-danger">*</span></label>
                    <div class="d-flex gap-2 flex-nowrap">
                        <select id="clientSelect" name="client_id" class="form-select" required style="flex:1">
                            <option value="">-- Pilih Client --</option>
                            @foreach($clients as $c)
                                <option value="{{ $c->id }}" data-nama="{{ $c->nama_client }}" data-npwp="{{ $c->npwp }}" data-phone="{{ $c->no_telephone }}" data-alamat-npwp="{{ $c->alamat_npwp }}" data-kpp="{{ $c->kpp }}" data-tipe-id="{{ $c->tipe_badan }}">
                                    {{ $c->nama_client }} — {{ $c->npwp ?: 'NPWP: -' }}
                                </option>
                            @endforeach
                        </select>
                        @cmsCan('transaksi', 'create')
                        <a href="{{ route('cms.transaksi.import') }}" class="btn btn-outline-success btn-sm btn-import-transaksi d-none text-nowrap" id="btnImportTransaksi"><i class="bi bi-upload me-1"></i>Import Excel</a>
                        @endCmsCan
                    </div>
                </div>
            </div>

            {{-- Tahun --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-secondary border-bottom pb-2"><i class="bi bi-calendar me-2"></i>Periode</h6>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold small">Tahun <span class="text-danger">*</span></label>
                    <select id="tahunSelect" name="tahun" class="form-select" required>
                        <option value="">-- Pilih Tahun --</option>
                        @for($y = now()->year; $y >= now()->year - 10; $y--)
                            <option value="{{ $y }}" {{ $y == now()->year ? 'selected' : '' }}>{{ $y }}</option>
                        @endfor
                    </select>
                </div>
            </div>

            <hr>

            {{-- Lampiran SPT Tahunan --}}
            <div id="hartaSection" class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-success border-bottom pb-2 position-relative">
                        <span style="vertical-align:middle"><i class="bi bi-building me-2"></i>Harta / Aktiva</span>
                        <a href="{{ route('cms.lampiran-spt.index') }}?client_id={{ old('client_id', '') }}&tahun={{ old('tahun', date('Y')) }}"
                           class="btn btn-sm btn-outline-primary position-absolute end-0 top-50 translate-middle-y" id="btnLampiranSpt" target="_blank">
                            <i class="bi bi-pencil-square me-1"></i> Update / Import Harta
                        </a>
                    </h6>
                    <div class="alert alert-info small py-2 mb-0">
                        <i class="bi bi-info-circle me-1"></i>
                        Input harta/aktiva sekarang dikelola melalui menu 
                        <strong>Lampiran SPT Tahunan</strong>. 
                        Klik tombol <strong>"Update / Import Harta"</strong> di atas untuk mengisi data harta.
                    </div>
                </div>
            </div>

            {{-- Omset Per Tahun (untuk PT) --}}
            <div id="omsetTahunanSection" class="row g-4 mb-4 d-none">
                <div class="col-12">
                    <h6 class="fw-semibold text-warning border-bottom pb-2"><i class="bi bi-graph-up-arrow me-2"></i>Omset Tahunan</h6>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold small">Jumlah Omset</label>
                    <div class="input-group">
                        <span class="input-group-text">Rp</span>
                        <input type="text" id="omsetTahunan" name="omset_tahunan" class="form-control format-currency" placeholder="0">
                    </div>
                </div>
            </div>

            {{-- Omset Per Bulan — Table format (Reguler + E-Commerce) --}}
            @php $monthsList = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des']; @endphp
            <div id="omsetBulananSection" class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-warning border-bottom pb-2"><i class="bi bi-table me-2"></i>Data Omset</h6>
                </div>
                <div class="col-12">
                    <div class="table-responsive">
                        <table class="table table-bordered table-sm mb-2" id="omsetTable">
                            <thead class="table-warning">
                                <tr>
                                    <th colspan="2" style="min-width:210px">Kategori - NIK</th>
                                    @foreach($monthsList as $m)
                                        <th class="text-end" style="min-width:90px">{{ $m }}</th>
                                    @endforeach
                                    <th style="width:110px">Aksi</th>
                                </tr>
                            </thead>
                            <tbody id="omsetTableBody">
                                {{-- Populated by JS --}}
                            </tbody>
                        </table>
                    </div>
                    {{-- E-Commerce add row --}}
                    <div class="d-flex align-items-center gap-2" id="ecommerceAddRow">
                        <select id="ecommerceSelect" class="form-select form-select-sm" style="width:auto;min-width:180px">
                            <option value="">-- Tambah E-Commerce --</option>
                            @foreach($masterEcommerce as $ec)
                                <option value="{{ $ec->id }}" data-kode="{{ $ec->kode_ecommerce }}" data-deskripsi="{{ $ec->deskripsi }}">{{ $ec->kode_ecommerce }} - {{ $ec->deskripsi }}</option>
                            @endforeach
                        </select>
                        <button type="button" class="btn btn-sm btn-outline-primary" id="btnAddEcommerce"><i class="bi bi-plus-lg"></i> Tambah</button>
                    </div>
                </div>
            </div>

            {{-- Hidden fields --}}
            <input type="hidden" name="total_omset" id="totalOmsetHidden" value="0">
            <input type="hidden" name="total_pph" id="totalPphHidden" value="0">

            {{-- Actions --}}
            <div class="d-flex justify-content-end gap-2 pt-3">
                <button type="reset" class="btn btn-light">Reset</button>
                <button type="button" class="btn btn-primary px-4" id="btnPreview" disabled>
                    <i class="bi bi-eye me-1"></i> Preview
                </button>
                <button type="button" class="btn btn-info px-4 text-white" id="btnExportPdf" disabled>
                    <i class="bi bi-filetype-pdf me-1"></i> PDF
                </button>
                <button type="button" class="btn btn-info px-4 text-white" id="btnExportExcel" disabled>
                    <i class="bi bi-file-earmark-spreadsheet me-1"></i> Excel
                </button>
                @cmsCan('transaksi', 'create')
                <button type="button" class="btn btn-success px-4" id="btnSimpan" disabled>
                    <i class="bi bi-check-lg me-1"></i> Simpan
                </button>
                @endCmsCan
            </div>
        </form>
    </div>
</div>

{{-- Preview Modal --}}
<div class="modal fade" id="previewModal" tabindex="-1" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h6 class="fw-semibold mb-0"><i class="bi bi-eye me-2"></i>Preview Transaksi</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4" id="previewContent">
            </div>
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Tutup</button>
            </div>
        </div>
    </div>
</div>

{{-- Harta Confirmation Modal --}}
<div class="modal fade" id="hartaConfirmModal" tabindex="-1" data-bs-backdrop="static">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-warning text-dark">
                <h6 class="fw-semibold mb-0"><i class="bi bi-exclamation-triangle me-2"></i>Peringatan</h6>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center py-4">
                <i class="bi bi-building-slash display-3 d-block mb-3 text-warning"></i>
                <p class="fw-semibold mb-0" id="hartaConfirmMsg">DATA AKTIVA BELUM DI INSERT, YAKIN MAU MELANJUTKAN?</p>
            </div>
            <div class="modal-footer border-0 justify-content-center gap-2">
                <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">
                    <i class="bi bi-x-circle me-1"></i> Tutup
                </button>
                <button type="button" class="btn btn-success px-4" id="btnHartaLanjutkan">
                    <i class="bi bi-check-lg me-1"></i> Lanjutkan
                </button>
                <button type="button" class="btn btn-primary px-4" id="btnHartaInput">
                    <i class="bi bi-pencil-square me-1"></i> Input Harta
                </button>
            </div>
        </div>
    </div>
</div>

{{-- Harta Input Modal --}}
<div class="modal fade" id="hartaInputModal" tabindex="-1" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h6 class="fw-semibold mb-0"><i class="bi bi-building me-2"></i>Input Harta / Aktiva</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-0">
                <div id="hartaInputTabNav" class="border-bottom d-none">
                    <ul class="nav nav-tabs px-3 pt-2" id="hartaInputTabs" role="tablist" style="font-size:0.85rem"></ul>
                </div>
                <div class="p-3" id="hartaInputContainer">
                    <div class="text-center py-4"><div class="spinner-border text-primary"></div></div>
                </div>
            </div>
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-light px-4" id="btnHartaBatal">
                    <i class="bi bi-arrow-left me-1"></i> Batal
                </button>
                <button type="button" class="btn btn-success px-4" id="btnHartaSimpan">
                    <i class="bi bi-check-lg me-1"></i> Simpan
                </button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('styles')
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
</style>
@endpush

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
const clients = @json($clients);
const badanList = @json($badan);
const rumusList = @json($rumus);
const bulanList = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
const cabangData = @json($cabangs ?? []);
const masterEcommerce = @json($masterEcommerce ?? []);
const bulanListShort = @json($monthsList);
var tabData = {};
var hasCabang = false;

// New table-based data
var tableRows = { reguler: [], ecommerce: [] };
var ecommerceRowCounter = 0;

$(document).ready(function() {
    $('#clientSelect').select2({
        placeholder: '-- Cari & Pilih Client --',
        allowClear: true,
        width: '100%'
    });
    $('#clientSelect').on('select2:select select2:clear change', function() {
        handleClientChange();
    });
});

function handleClientChange() {
    const el = document.getElementById('clientSelect');
    const id = parseInt(el.value);
    var btnImport = document.getElementById('btnImportTransaksi');
    if (!id) {
        if (btnImport) btnImport.classList.add('d-none');
        document.getElementById('hartaSection').classList.add('d-none');
        document.getElementById('omsetTahunanSection').classList.add('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
        toggleButtons();
        return;
    }
    if (btnImport) btnImport.classList.remove('d-none');

    tabData = {};
    tableRows = { reguler: [], ecommerce: [] };
    ecommerceRowCounter = 0;
    hasCabang = false;

    const opt = el.options[el.selectedIndex];
    if (!opt) return;
    const tipeId = parseInt(opt.dataset.tipeId);
    const c = clients.find(x => x.id === id);

    clearInputs();

    tabData['induk'] = {
        nama: c ? c.nama_client : 'Induk',
        npwp: c ? (c.npwp || '-') : '-',
        npwp_cabang_id: null,
        tipeId: tipeId,
        kpp: c ? (c.kpp || '-') : '-',
        no_telephone: c ? (c.no_telephone || '-') : '-',
        alamat_npwp: c ? (c.alamat_npwp || '-') : '-',
        omsetTahunan: '',
        omsetBulanan: {}
    };
    for (let mo = 1; mo <= 12; mo++) tabData['induk'].omsetBulanan[mo] = '';

    document.getElementById('hartaSection').classList.remove('d-none');

    const clientCabangs = cabangData[id] || [];

    if (clientCabangs && clientCabangs.length > 0) {
        hasCabang = true;
        clientCabangs.sort(function(a, b) {
            return (a.npwp || '').slice(-3).localeCompare((b.npwp || '').slice(-3));
        });
        var ecommerceLookup = {};
        masterEcommerce.forEach(function(me) { ecommerceLookup[me.id] = me.kode_ecommerce; });

        clientCabangs.forEach(function(cabang, i) {
            var pfx = 'cabang_' + i;
            var isEcommerce = cabang.master_ecommerce_id ? true : false;
            tabData[pfx] = {
                nama: cabang.nama_client || 'Cabang ' + (i + 1),
                npwp: cabang.npwp || '-',
                npwp_cabang_id: cabang.id,
                master_ecommerce_id: cabang.master_ecommerce_id || null,
                kode_ecommerce: isEcommerce ? (ecommerceLookup[cabang.master_ecommerce_id] || '') : '',
                tipeId: tipeId,
                kpp: cabang.kpp || '-',
                no_telephone: cabang.no_telephone || '-',
                alamat_npwp: cabang.alamat_npwp || '-',
                omsetTahunan: '',
                omsetBulanan: {}
            };
            for (let mo = 1; mo <= 12; mo++) tabData[pfx].omsetBulanan[mo] = '';
        });
    }

    // Show omset section based on tipe
    if (tipeId === 1) {
        document.getElementById('omsetTahunanSection').classList.remove('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
    } else {
        document.getElementById('omsetTahunanSection').classList.add('d-none');
        document.getElementById('omsetBulananSection').classList.remove('d-none');
    }

    const lampiranUrl = document.getElementById('btnLampiranSpt').href.split('?')[0];
    document.getElementById('btnLampiranSpt').href = lampiranUrl + '?client_id=' + id + '&tahun=' + (document.getElementById('tahunSelect').value || '{{ date("Y") }}');

    loadDataFromDb();
}



function getTipeName(tipeId) {
    const b = badanList.find(x => x.id === tipeId);
    return b ? b.tipe : '';
}

function clearInputs() {
    document.getElementById('omsetTahunan').value = '';
    document.getElementById('omsetTableBody').innerHTML = '';
    tableRows = { reguler: [], ecommerce: [] };
    toggleButtons();
}

// --- New Omset Table Management ---

function syncTabDataToTableRows() {
    tableRows.reguler = [];
    tableRows.ecommerce = [];
    Object.keys(tabData).forEach(function(p) {
        var td = tabData[p];
        if (!td) return;
        if (td.master_ecommerce_id) {
            var row = {
                type: 'ecommerce',
                idx: 0,
                kode: td.kode_ecommerce || '',
                label: td.nama || (p === 'induk' ? 'Pusat' : 'Cabang'),
                npwp: td.npwp || '',
                omset: {}
            };
            for (let mo = 1; mo <= 12; mo++) {
                row.omset[mo] = (td.omsetBulanan && td.omsetBulanan[mo]) || '';
            }
            tableRows.ecommerce.push(row);
        } else {
            var row = {
                type: 'reguler',
                prefix: p,
                label: td.nama || (p === 'induk' ? 'Pusat' : 'Cabang'),
                npwp: td.npwp || '',
                tipeId: td.tipeId,
                omset: {}
            };
            for (let mo = 1; mo <= 12; mo++) {
                row.omset[mo] = (td.omsetBulanan && td.omsetBulanan[mo]) || '';
            }
            tableRows.reguler.push(row);
        }
    });
    // Update ecommerceRowCounter so new manual additions get unique indices
    ecommerceRowCounter = tableRows.ecommerce.length;
}

function syncTableRowsToTabData() {
    tableRows.reguler.forEach(function(row) {
        if (!tabData[row.prefix]) return;
        for (let mo = 1; mo <= 12; mo++) {
            tabData[row.prefix].omsetBulanan[mo] = row.omset[mo] || '';
        }
    });
    // Sync ecommerce rows back to tabData
    tableRows.ecommerce.forEach(function(row) {
        Object.keys(tabData).forEach(function(p) {
            var td = tabData[p];
            if (td && td.master_ecommerce_id && td.kode_ecommerce === row.kode) {
                for (let mo = 1; mo <= 12; mo++) {
                    td.omsetBulanan[mo] = row.omset[mo] || '';
                }
            }
        });
    });
}

function rebuildTable() {
    syncTableRowsToTabData();
    buildOmsetTable();
}

function buildOmsetTable() {
    var tbody = document.getElementById('omsetTableBody');
    if (!tbody) return;
    tbody.innerHTML = '';

    // Gather rumus
    var tipeId = null;
    Object.keys(tabData).forEach(function(k) { if (tabData[k] && tipeId === null) tipeId = tabData[k].tipeId; });
    var rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(tipeId); });
    var maxVal = Number(rumus?.max_value || 0);
    var persen = Number(rumus?.potongan_persentase || 0);

    var perMonthTotal = {};
    var perMonthPph = {};
    for (let mo = 1; mo <= 12; mo++) { perMonthTotal[mo] = 0; perMonthPph[mo] = 0; }

    // --- Reguler Section ---
    if (tableRows.reguler.length > 0) {
        var catRow = tbody.insertRow();
        catRow.className = 'table-secondary';
        catRow.innerHTML = '<td colspan="15"><strong>Reguler</strong></td>';

        tableRows.reguler.forEach(function(row, idx) {
            var tr = tbody.insertRow();
            tr.setAttribute('data-type', 'reguler');
            tr.setAttribute('data-prefix', row.prefix);
            tr.setAttribute('data-row', 'reguler-' + idx);

            var isInduk = row.prefix === 'induk';
            var labelContent = isInduk ? '<span class="fw-medium">Pusat</span>' : '<small class="text-muted">Cabang</small>';
            var npwpDisplay = row.npwp ? ' <code>' + row.npwp + '</code>' : '';

            var tdLabel = tr.insertCell();
            tdLabel.setAttribute('colspan', '2');
            tdLabel.innerHTML = labelContent + npwpDisplay;

            for (let mo = 1; mo <= 12; mo++) {
                var td = tr.insertCell();
                td.className = 'text-end';
                var raw = row.omset[mo] || '';
                var num = Number(raw.replace(/[^0-9]/g, '') || 0);
                td.innerHTML = '<span class="omset-view">' + (num ? formatNum(raw) : '-') + '</span>' +
                    '<input type="text" class="form-control form-control-sm text-end omset-input d-none format-currency" data-prefix="' + row.prefix + '" data-month="' + mo + '" data-row="reguler-' + idx + '" value="' + raw + '" placeholder="0" style="min-width:80px">';
                perMonthTotal[mo] += num;
                perMonthPph[mo] += num * persen / 100;
            }

            var tdAction = tr.insertCell();
            tdAction.className = 'text-center';
            tdAction.innerHTML = '<button type="button" class="btn btn-sm btn-outline-primary me-1 btn-edit-row" title="Edit"><i class="bi bi-pencil"></i></button>' +
                '<button type="button" class="btn btn-sm btn-success d-none btn-save-row" title="Simpan"><i class="bi bi-check-lg"></i></button>';
        });
    }

    // --- E-Commerce Section ---
    if (tableRows.ecommerce.length > 0) {
        var catRow2 = tbody.insertRow();
        catRow2.className = 'table-secondary';
        catRow2.innerHTML = '<td colspan="15"><strong>E-Commerce</strong></td>';

        tableRows.ecommerce.forEach(function(row, idx) {
            var tr = tbody.insertRow();
            tr.setAttribute('data-type', 'ecommerce');
            tr.setAttribute('data-ec-idx', idx);

            var kodeDisplay = row.kode ? '<span class="fw-medium">' + row.kode + '</span>' : '';
            var npwpDisplay = row.npwp ? ' <code>' + row.npwp + '</code>' : '';

            var tdLabel = tr.insertCell();
            tdLabel.setAttribute('colspan', '2');
            tdLabel.innerHTML = '<i class="bi bi-cart me-1"></i>' + kodeDisplay + npwpDisplay;

            for (let mo = 1; mo <= 12; mo++) {
                var td = tr.insertCell();
                td.className = 'text-end';
                var raw = row.omset[mo] || '';
                var num = Number(raw.replace(/[^0-9]/g, '') || 0);
                td.innerHTML = '<span class="omset-view">' + (num ? formatNum(raw) : '-') + '</span>' +
                    '<input type="text" class="form-control form-control-sm text-end omset-input d-none format-currency" data-ec-idx="' + idx + '" data-month="' + mo + '" value="' + raw + '" placeholder="0" style="min-width:80px">';
                perMonthTotal[mo] += num;
                perMonthPph[mo] += num * persen / 100;
            }

            var tdAction = tr.insertCell();
            tdAction.className = 'text-center';
            tdAction.innerHTML = '<button type="button" class="btn btn-sm btn-outline-primary me-1 btn-edit-row" title="Edit"><i class="bi bi-pencil"></i></button>' +
                '<button type="button" class="btn btn-sm btn-success d-none btn-save-row" title="Simpan"><i class="bi bi-check-lg"></i></button>' +
                '<button type="button" class="btn btn-sm btn-outline-danger ms-1 btn-remove-ec" title="Hapus"><i class="bi bi-trash"></i></button>';
        });
    }

    // --- Computed Rows ---
    var cumulative = 0;
    var totalPphDue = 0;

    for (let mo = 1; mo <= 12; mo++) {
        var totalOmset = perMonthTotal[mo];
        if (totalOmset === 0) continue;
        var totalWithCurrent = cumulative + totalOmset;

        var pphBayar = 0;
        if (rumus) {
            if (cumulative >= maxVal) {
                pphBayar = totalOmset * persen / 100;
            } else if (totalWithCurrent > maxVal) {
                var kelebihan = totalWithCurrent - maxVal;
                pphBayar = kelebihan * persen / 100;
            }
        }
        totalPphDue += pphBayar;
        cumulative += totalOmset;
    }

    // Summary row
    var totalAll = 0;
    for (let mo = 1; mo <= 12; mo++) totalAll += perMonthTotal[mo];

    var sumRow = tbody.insertRow();
    sumRow.className = 'fw-bold';
    sumRow.innerHTML = '<td colspan="2" class="text-end">Total</td>';
    for (let mo = 1; mo <= 12; mo++) {
        sumRow.insertCell().innerHTML = '<span class="text-end d-block">' + (perMonthTotal[mo] > 0 ? formatNum(String(perMonthTotal[mo])) : '-') + '</span>';
    }
    sumRow.insertCell().innerHTML = '<span class="text-end text-primary fw-bold d-block"></span>';

    // PPh Final row
    var pphTotalAll = 0;
    for (let mo = 1; mo <= 12; mo++) pphTotalAll += perMonthPph[mo];
    var pphRow = tbody.insertRow();
    pphRow.className = 'table-light';
    pphRow.innerHTML = '<td colspan="2" class="text-end text-danger">PPh Final <span class="pph-persen">' + (persen > 0 ? persen.toString().replace('.', ',') : '0') + '</span>%</td>';
    for (let mo = 1; mo <= 12; mo++) {
        pphRow.insertCell().innerHTML = '<span class="text-end text-danger d-block">' + (perMonthPph[mo] > 0 ? formatNum(String(perMonthPph[mo])) : '-') + '</span>';
    }
    pphRow.insertCell().innerHTML = '<span class="text-end text-danger d-block"></span>';

    // Total Peredaran Bruto row
    var cumulativeForDisplay = 0;
    var pbRow = tbody.insertRow();
    pbRow.innerHTML = '<td colspan="2" class="text-end">Total Peredaran Bruto</td>';
    for (let mo = 1; mo <= 12; mo++) {
        cumulativeForDisplay += perMonthTotal[mo];
        pbRow.insertCell().innerHTML = '<span class="text-end d-block">' + (perMonthTotal[mo] > 0 ? formatNum(String(cumulativeForDisplay)) : '-') + '</span>';
    }
    pbRow.insertCell().innerHTML = '<span class="text-end d-block"></span>';

    // Perhitungan Pengurangan row
    var cumulativeForPeng = 0;
    var pengRow = tbody.insertRow();
    pengRow.innerHTML = '<td colspan="2" class="text-end">Perhitungan Pengurangan</td>';
    for (let mo = 1; mo <= 12; mo++) {
        cumulativeForPeng += perMonthTotal[mo];
        var pengurangan = maxVal > 0 ? cumulativeForPeng - maxVal : 0;
        var display = '-';
        if (perMonthTotal[mo] > 0) {
            if (cumulativeForPeng < maxVal) {
                display = '(' + formatNum(String(Math.abs(pengurangan))) + ')';
            } else {
                display = formatNum(String(pengurangan));
            }
        }
        pengRow.insertCell().innerHTML = '<span class="text-end d-block">' + display + '</span>';
    }
    pengRow.insertCell();

    // PPh Final Harus Dibayar row
    var cumulativeForBayar = 0;
    var bayarRow = tbody.insertRow();
    bayarRow.className = 'table-info fw-bold';
    bayarRow.innerHTML = '<td colspan="2" class="text-end">PPh Final<br>Harus Dibayar</td>';
    var totalPphAll = 0;
    for (let mo = 1; mo <= 12; mo++) {
        var omsetMo = perMonthTotal[mo];
        if (omsetMo === 0) { bayarRow.insertCell().innerHTML = '-'; cumulativeForBayar += omsetMo; continue; }
        var totWithCum = cumulativeForBayar + omsetMo;
        var bayar = 0;
        if (rumus) {
            if (cumulativeForBayar >= maxVal) {
                bayar = omsetMo * persen / 100;
            } else if (totWithCum > maxVal) {
                var kelebihan = totWithCum - maxVal;
                bayar = kelebihan * persen / 100;
            }
        }
        totalPphAll += bayar;
        bayarRow.insertCell().innerHTML = '<span class="text-end text-danger d-block">' + (bayar > 0 ? formatNum(String(bayar)) : '<span class="text-success">FREE</span>') + '</span>';
        cumulativeForBayar += omsetMo;
    }
    bayarRow.insertCell().innerHTML = '<span class="text-end text-danger fw-bold d-block"></span>';

    // Store totals for hidden fields
    window._omsetTotalAll = totalAll;
    window._omsetTotalPph = totalPphAll;

    toggleButtons();
    syncTableRowsToTabData();
}

function addEcommerceRow() {
    var sel = document.getElementById('ecommerceSelect');
    var opt = sel.options[sel.selectedIndex];
    if (!opt || !opt.value) { alert('Pilih ecommerce terlebih dahulu.'); return; }
    var kode = opt.getAttribute('data-kode');
    var deskripsi = opt.getAttribute('data-deskripsi') || kode;
    // Check if already added
    var exists = tableRows.ecommerce.some(function(r) { return r.kode === kode; });
    if (exists) { alert('E-Commerce "' + kode + '" sudah ditambahkan.'); return; }
    var idx = ecommerceRowCounter++;
    tableRows.ecommerce.push({
        type: 'ecommerce',
        idx: idx,
        kode: kode,
        label: deskripsi || kode,
        omset: {}
    });
    for (let mo = 1; mo <= 12; mo++) tableRows.ecommerce[tableRows.ecommerce.length - 1].omset[mo] = '';
    sel.value = '';
    buildOmsetTable();
}

function removeEcommerceRow(idx) {
    if (!confirm('Hapus baris e-commerce "' + tableRows.ecommerce[idx].label + '"?')) return;
    tableRows.ecommerce.splice(idx, 1);
    buildOmsetTable();
}

function saveCurrentInputs() {
    // Persist table rows data back to tabData for preview/save
    var data = tabData['induk'];
    if (!data) return;
    if (data.tipeId === 1) {
        data.omsetTahunan = document.getElementById('omsetTahunan').value;
    } else {
        syncTableRowsToTabData();
    }
}

function restoreCurrentInputs() {
    var data = tabData['induk'];
    if (!data) { clearInputs(); return; }

    document.getElementById('omsetTahunan').name = 'omset_tahunan';

    if (data.tipeId === 1) {
        document.getElementById('omsetTahunanSection').classList.remove('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
        document.getElementById('omsetTahunan').value = data.omsetTahunan || '';
    } else {
        document.getElementById('omsetTahunanSection').classList.add('d-none');
        document.getElementById('omsetBulananSection').classList.remove('d-none');
        syncTabDataToTableRows();
        buildOmsetTable();
    }
    toggleButtons();
}

function toggleButtons() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (!clientId) { disableAllButtons(true); return; }

    var hasData = false;
    // Check reguler rows
    tableRows.reguler.forEach(function(row) {
        for (let mo = 1; mo <= 12; mo++) {
            if (Number((row.omset[mo] || '').replace(/[^0-9]/g, '') || 0) > 0) hasData = true;
        }
    });
    // Check ecommerce rows
    tableRows.ecommerce.forEach(function(row) {
        for (let mo = 1; mo <= 12; mo++) {
            if (Number((row.omset[mo] || '').replace(/[^0-9]/g, '') || 0) > 0) hasData = true;
        }
    });
    // Check tahunan
    Object.keys(tabData).forEach(function(p) {
        var td = tabData[p];
        if (!td) return;
        if (td.tipeId === 1) {
            if (Number((td.omsetTahunan || '').replace(/[^0-9]/g, '') || 0) > 0) hasData = true;
        }
    });
    disableAllButtons(!hasData);
}

function disableAllButtons(v) {
    document.getElementById('btnPreview').disabled = v;
    document.getElementById('btnExportPdf').disabled = v;
    document.getElementById('btnExportExcel').disabled = v;
    var bs = document.getElementById('btnSimpan');
    if (bs) bs.disabled = v;
}



function loadDataFromDb() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    const tahun = document.getElementById('tahunSelect').value;
    if (!clientId || !tahun) return Promise.resolve();

    var overlay = document.getElementById('loadingOverlay');
    if (overlay) overlay.classList.remove('d-none');

    return fetch('/admin/transaksi/load-data?client_id=' + clientId + '&tahun=' + tahun)
        .then(function(res) { if (!res.ok) throw new Error('HTTP ' + res.status); return res.json(); })
        .then(function(data) {
            if (data.exists) {
                if (data.omset && data.omset.length > 0) {
                    var isTahunan = data.omset[0].bulan === null || data.omset[0].bulan === undefined;
                    if (isTahunan) {
                        tabData['induk'].omsetTahunan = Number(data.omset[0].nominal).toLocaleString('id-ID');
                    } else {
                        data.omset.forEach(function(o) { tabData['induk'].omsetBulanan[o.bulan] = Number(o.nominal).toLocaleString('id-ID'); });
                    }
                }
                if (data.cabangs) {
                    data.cabangs.forEach(function(cb) {
                        var pfx = null;
                        Object.keys(tabData).forEach(function(p) { if (tabData[p].npwp_cabang_id && tabData[p].npwp_cabang_id == cb.npwp_cabang_id) pfx = p; });
                        if (!pfx) return;
                        var isTahunan = cb.omset && cb.omset.length > 0 && (cb.omset[0].bulan === null || cb.omset[0].bulan === undefined);
                        if (isTahunan) tabData[pfx].omsetTahunan = Number(cb.omset[0].nominal).toLocaleString('id-ID');
                        else if (cb.omset) cb.omset.forEach(function(o) { tabData[pfx].omsetBulanan[o.bulan] = Number(o.nominal).toLocaleString('id-ID'); });
                    });
                }
            }
            restoreCurrentInputs();
            toggleButtons();
        })
        .catch(function(err) { console.error('Load data error:', err); })
        .finally(function() {
            if (overlay) overlay.classList.add('d-none');
        });
}

document.getElementById('tahunSelect').addEventListener('change', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (clientId && this.value) {
        document.getElementById('btnLampiranSpt').href = document.getElementById('btnLampiranSpt').href.split('?')[0] + '?client_id=' + clientId + '&tahun=' + this.value;
    }
    if (!clientId) return;
    // Clear current tabData omset values
    Object.keys(tabData).forEach(function(p) {
        var td = tabData[p];
        if (!td) return;
        td.omsetTahunan = '';
        for (let mo = 1; mo <= 12; mo++) td.omsetBulanan[mo] = '';
    });
    // Load data for the new year from DB
    loadDataFromDb();
});

document.getElementById('omsetTahunan').addEventListener('input', function() {
    if (tabData['induk']) tabData['induk'].omsetTahunan = this.value;
    toggleButtons();
});

// --- New Table Event Listeners (delegated) ---

document.getElementById('omsetTableBody').addEventListener('click', function(e) {
    var target = e.target.closest('button');
    if (!target) return;

    // Edit row
    if (target.classList.contains('btn-edit-row')) {
        var tr = target.closest('tr');
        tr.querySelectorAll('.omset-view').forEach(function(el) { el.classList.add('d-none'); });
        tr.querySelectorAll('.omset-input').forEach(function(el) { el.classList.remove('d-none'); });
        target.classList.add('d-none');
        tr.querySelector('.btn-save-row').classList.remove('d-none');
    }

    // Save row
    if (target.classList.contains('btn-save-row')) {
        var tr = target.closest('tr');
        var type = tr.getAttribute('data-type');
        var isReguler = type === 'reguler';

        tr.querySelectorAll('.omset-input').forEach(function(inp) {
            var mo = inp.getAttribute('data-month');
            var raw = inp.value;
            var num = Number(raw.replace(/[^0-9]/g, '') || 0);
            var viewEl = tr.querySelector('.omset-view[data-month-view="' + mo + '"]');
            // Update the omset-view span
            var spans = tr.querySelectorAll('.omset-view');
            var idx = Array.from(inp.parentNode.parentNode.querySelectorAll('.omset-view')).indexOf(
                inp.parentNode.previousElementSibling ? inp.parentNode.previousElementSibling : null
            );
            // Simpler approach: find sibling span
            var span = inp.parentNode.querySelector('.omset-view');
            if (!span) span = inp.parentNode.previousElementSibling;
            if (span && span.classList.contains('omset-view')) {
                span.textContent = num ? formatNum(raw) : '-';
            }

            // Update data in tableRows
            var rowPrefix = inp.getAttribute('data-prefix');
            var ecIdx = inp.getAttribute('data-ec-idx');
            if (rowPrefix) {
                var row = tableRows.reguler.find(function(r) { return r.prefix === rowPrefix; });
                if (row) row.omset[mo] = raw;
            } else if (ecIdx !== null && ecIdx !== undefined) {
                if (tableRows.ecommerce[ecIdx]) tableRows.ecommerce[ecIdx].omset[mo] = raw;
            }

            inp.classList.add('d-none');
            if (span) span.classList.remove('d-none');
        });

        target.classList.add('d-none');
        tr.querySelector('.btn-edit-row').classList.remove('d-none');

        // Rebuild table to refresh computed rows
        buildOmsetTable();
    }

    // Remove ecommerce row
    if (target.classList.contains('btn-remove-ec')) {
        var tr = target.closest('tr');
        var idx = parseInt(tr.getAttribute('data-ec-idx'));
        if (!isNaN(idx)) removeEcommerceRow(idx);
    }
});

// Input events on the omset table inputs (delegated)
document.getElementById('omsetTableBody').addEventListener('input', function(e) {
    if (e.target.classList.contains('omset-input') || e.target.classList.contains('format-currency')) {
        var v = e.target.value.replace(/[^0-9]/g, '');
        e.target.value = v ? parseInt(v, 10).toLocaleString('id-ID') : '';
    }
});

// Add ecommerce button
document.getElementById('btnAddEcommerce').addEventListener('click', addEcommerceRow);
document.getElementById('ecommerceSelect').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') { e.preventDefault(); addEcommerceRow(); }
});

document.getElementById('formTransaksi').addEventListener('input', function(e) {
    if (e.target.classList.contains('format-currency')) {
        var v = e.target.value.replace(/[^0-9]/g, '');
        e.target.value = v ? parseInt(v, 10).toLocaleString('id-ID') : '';
    }
});

// --- Preview ---
document.getElementById('btnPreview').addEventListener('click', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (!clientId) { alert('Pilih client terlebih dahulu.'); return; }
    const tahun = document.getElementById('tahunSelect').value;
    if (!tahun) { alert('Pilih tahun terlebih dahulu.'); return; }

    saveCurrentInputs();

    // Rebuild tableRows from current inputs
    syncTabDataToTableRows();

    var tipeId = null;
    Object.keys(tabData).forEach(function(k) { if (tabData[k] && tipeId === null) tipeId = tabData[k].tipeId; });

    var bulanList = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

    var html = '<div class="table-responsive"><table class="table table-sm table-bordered mb-0">';
    html += '<thead class="table-warning"><tr><th colspan="2" style="min-width:210px">Kategori - NIK</th>';
    for (let mo = 0; mo < 12; mo++) { html += '<th class="text-end" style="min-width:90px">' + bulanList[mo] + '</th>'; }
    html += '<th style="width:70px">Total</th></tr></thead><tbody>';

    var perMonthTotal = {};
    var perMonthPph = {};
    for (let mo = 1; mo <= 12; mo++) { perMonthTotal[mo] = 0; perMonthPph[mo] = 0; }

    // Reguler section
    if (tableRows.reguler.length > 0) {
        html += '<tr class="table-secondary"><td colspan="15"><strong>Reguler</strong></td></tr>';
        tableRows.reguler.forEach(function(row) {
            var isInduk = row.prefix === 'induk';
            var labelCell = isInduk ? '<span class="fw-medium">Pusat</span>' : '<small class="text-muted">Cabang</small>';
            if (row.npwp) labelCell += ' <code>' + row.npwp + '</code>';
            html += '<tr><td colspan="2">' + labelCell + '</td>';

            var rowTotal = 0;
            for (let mo = 1; mo <= 12; mo++) {
                var raw = row.omset[mo] || '';
                var num = Number(raw.replace(/[^0-9]/g, '') || 0);
                html += '<td class="text-end">' + (num ? formatNum(raw) : '-') + '</td>';
                perMonthTotal[mo] += num;
                perMonthPph[mo] += num;
                rowTotal += num;
            }
            html += '<td class="text-end fw-bold">' + formatNum(String(rowTotal)) + '</td></tr>';
        });
    }

    // E-Commerce section
    if (tableRows.ecommerce.length > 0) {
        html += '<tr class="table-secondary"><td colspan="15"><strong>E-Commerce</strong></td></tr>';
        tableRows.ecommerce.forEach(function(row) {
            var labelCell = '<i class="bi bi-cart me-1"></i>';
            if (row.kode) labelCell += '<span class="fw-medium">' + row.kode + '</span>';
            if (row.npwp) labelCell += ' <code>' + row.npwp + '</code>';
            html += '<tr><td colspan="2">' + labelCell + '</td>';

            var rowTotal = 0;
            for (let mo = 1; mo <= 12; mo++) {
                var raw = row.omset[mo] || '';
                var num = Number(raw.replace(/[^0-9]/g, '') || 0);
                html += '<td class="text-end">' + (num ? formatNum(raw) : '-') + '</td>';
                perMonthTotal[mo] += num;
                perMonthPph[mo] += num;
                rowTotal += num;
            }
            html += '<td class="text-end fw-bold">' + formatNum(String(rowTotal)) + '</td></tr>';
        });
    }

    // Compute totals
    var totalAll = 0;
    for (let mo = 1; mo <= 12; mo++) totalAll += perMonthTotal[mo];

    var rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(tipeId); });
    var maxVal = Number(rumus?.max_value || 0);
    var persen = Number(rumus?.potongan_persentase || 0);

    // Computed rows
    var cumulative = 0;
    var totalPphDue = 0;

    // Total row
    html += '<tr class="fw-bold"><td colspan="2" class="text-end">Total</td>';
    for (let mo = 1; mo <= 12; mo++) {
        html += '<td class="text-end">' + (perMonthTotal[mo] > 0 ? formatNum(String(perMonthTotal[mo])) : '-') + '</td>';
    }
    html += '<td class="text-end text-primary">' + formatNum(String(totalAll)) + '</td></tr>';

    // PPh Final row
    var pphTotalAll = 0;
    for (let mo = 1; mo <= 12; mo++) pphTotalAll += perMonthPph[mo];
    html += '<tr class="table-light"><td colspan="2" class="text-end text-danger">PPh Final ' + (persen > 0 ? persen.toString().replace('.', ',') : '0') + '%</td>';
    for (let mo = 1; mo <= 12; mo++) {
        html += '<td class="text-end text-danger">' + (perMonthPph[mo] > 0 ? formatNum(String(Math.round(perMonthPph[mo]))) : '-') + '</td>';
    }
    html += '<td class="text-end text-danger">' + (pphTotalAll > 0 ? formatNum(String(Math.round(pphTotalAll))) : '-') + '</td></tr>';

    // Total Peredaran Bruto row
    var cumulativeForDisplay = 0;
    html += '<tr><td colspan="2" class="text-end">Total Peredaran Bruto</td>';
    for (let mo = 1; mo <= 12; mo++) {
        cumulativeForDisplay += perMonthTotal[mo];
        html += '<td class="text-end">' + (perMonthTotal[mo] > 0 ? formatNum(String(cumulativeForDisplay)) : '-') + '</td>';
    }
    html += '<td class="text-end">' + (totalAll > 0 ? formatNum(String(totalAll)) : '-') + '</td></tr>';

    // Perhitungan Pengurangan row
    var cumulativeForPeng = 0;
    html += '<tr><td colspan="2" class="text-end">Perhitungan Pengurangan</td>';
    for (let mo = 1; mo <= 12; mo++) {
        cumulativeForPeng += perMonthTotal[mo];
        var pengurangan = maxVal > 0 ? cumulativeForPeng - maxVal : 0;
        var display = '-';
        if (perMonthTotal[mo] > 0) {
            if (cumulativeForPeng < maxVal) {
                display = '(' + formatNum(String(Math.round(Math.abs(pengurangan)))) + ')';
            } else {
                display = formatNum(String(Math.round(pengurangan)));
            }
        }
        html += '<td class="text-end">' + display + '</td>';
    }
    html += '<td></td></tr>';

    // PPh Final Harus Dibayar row
    var cumulativeForBayar = 0;
    var totalPphAll = 0;
    html += '<tr class="table-info fw-bold"><td colspan="2" class="text-end">PPh Final<br>Harus Dibayar</td>';
    for (let mo = 1; mo <= 12; mo++) {
        var omsetMo = perMonthTotal[mo];
        if (omsetMo === 0) { html += '<td class="text-end">-</td>'; cumulativeForBayar += omsetMo; continue; }
        var totWithCum = cumulativeForBayar + omsetMo;
        var bayar = 0;
        if (rumus) {
            if (cumulativeForBayar >= maxVal) {
                bayar = omsetMo * persen / 100;
            } else if (totWithCum > maxVal) {
                var kelebihan = totWithCum - maxVal;
                bayar = kelebihan * persen / 100;
            }
        }
        totalPphAll += bayar;
        var displayBayar = bayar > 0 ? formatNum(String(Math.round(bayar))) : '<span class="text-success">FREE</span>';
        html += '<td class="text-end text-danger">' + displayBayar + '</td>';
        cumulativeForBayar += omsetMo;
    }
    html += '<td class="text-end text-danger fw-bold">' + formatNum(String(Math.round(totalPphAll))) + '</td></tr>';

    html += '</tbody></table></div>';

    document.getElementById('previewContent').innerHTML = html;
    var modal = new bootstrap.Modal(document.getElementById('previewModal'));
    modal.show();
});

// --- Helper: prepare form data for submission ---
function prepareFormData() {
    saveCurrentInputs();
    // Remove name from visible omset inputs
    document.querySelectorAll('#omsetTahunan, #omsetTable input.omset-input').forEach(function(el) { el.removeAttribute('name'); });
    // Remove old per-tab hidden fields
    document.querySelectorAll('[data-tabhidden]').forEach(function(el) { el.remove(); });
    var form = document.getElementById('formTransaksi');
    var totalOmset = 0;
    Object.keys(tabData).forEach(function(p) {
        var td = tabData[p]; if (!td) return;
        var prefix = p;
        var isTahunan = td.tipeId === 1;
        if (td.npwp_cabang_id) {
            var h = document.createElement('input');
            h.type = 'hidden'; h.name = prefix + '[npwp_cabang_id]'; h.value = td.npwp_cabang_id;
            h.setAttribute('data-tabhidden', '1');
            form.appendChild(h);
        }
        if (isTahunan) {
            var raw = td.omsetTahunan || '';
            var num = Number(raw.replace(/[^0-9]/g, '') || 0);
            totalOmset += num;
            if (num > 0) {
                var h = document.createElement('input');
                h.type = 'hidden'; h.name = prefix + '[omset_tahunan]'; h.value = raw;
                h.setAttribute('data-tabhidden', '1');
                form.appendChild(h);
            }
        } else {
            for (let mo = 1; mo <= 12; mo++) {
                var raw = td.omsetBulanan[mo] || '';
                var num = Number(raw.replace(/[^0-9]/g, '') || 0);
                totalOmset += num;
                if (num > 0) {
                    var h = document.createElement('input');
                    h.type = 'hidden'; h.name = prefix + '[omset_bulanan][' + mo + ']'; h.value = raw;
                    h.setAttribute('data-tabhidden', '1');
                    form.appendChild(h);
                }
            }
        }
    });
    // E-Commerce rows
    tableRows.ecommerce.forEach(function(row, idx) {
        for (let mo = 1; mo <= 12; mo++) {
            var raw = row.omset[mo] || '';
            var num = Number(raw.replace(/[^0-9]/g, '') || 0);
            totalOmset += num;
            if (num > 0) {
                var h = document.createElement('input');
                h.type = 'hidden'; h.name = 'ecommerce[' + idx + '][kode]'; h.value = row.kode;
                h.setAttribute('data-tabhidden', '1');
                form.appendChild(h);
                var h2 = document.createElement('input');
                h2.type = 'hidden'; h2.name = 'ecommerce[' + idx + '][omset][' + mo + ']'; h2.value = raw;
                h2.setAttribute('data-tabhidden', '1');
                form.appendChild(h2);
            }
        }
    });
    const rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(tabData['induk']?.tipeId); });
    var persen = rumus ? Number(rumus.potongan_persentase) : 0;
    document.getElementById('totalOmsetHidden').value = totalOmset;
    document.getElementById('totalPphHidden').value = totalOmset * persen / 100;
}

// --- Simpan button ---
var btnSimpan = document.getElementById('btnSimpan');
if (btnSimpan) btnSimpan.addEventListener('click', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    const tahun = document.getElementById('tahunSelect').value;
    if (!clientId || !tahun) { alert('Pilih client dan tahun terlebih dahulu.'); return; }

    // Check if harta exists for all tabs via AJAX
    fetch('{{ route("cms.transaksi.check-harta") }}?client_id=' + clientId + '&tahun=' + tahun)
        .then(function(res) { return res.json(); })
        .then(function(data) {
            if (data.has_harta) {
                // All tabs have harta, proceed to submit
                doSimpan();
            } else {
                // Some tabs missing harta — build info message
                var missing = [];
                var tabs = data.tabs || {};
                Object.keys(tabs).forEach(function(key) {
                    if (!tabs[key].has_harta) {
                        missing.push(tabs[key].npwp || key);
                    }
                });
                var msgEl = document.getElementById('hartaConfirmMsg');
                if (missing.length) {
                    msgEl.innerHTML = '<span class="fw-semibold">DATA AKTIVA BELUM DIINSERT UNTUK:</span><br><span class="text-danger">' + missing.join(', ') + '</span>';
                } else {
                    msgEl.innerHTML = '<span class="fw-semibold">DATA AKTIVA BELUM DI INSERT, YAKIN MAU MELANJUTKAN?</span>';
                }
                var modal = new bootstrap.Modal(document.getElementById('hartaConfirmModal'));
                modal.show();
            }
        })
        .catch(function() {
            // If check fails, still show warning
            var modal = new bootstrap.Modal(document.getElementById('hartaConfirmModal'));
            modal.show();
        });
});

function doSimpan() {
    prepareFormData();
    document.getElementById('formTransaksi').submit();
}

document.getElementById('btnHartaLanjutkan').addEventListener('click', function() {
    var modal = bootstrap.Modal.getInstance(document.getElementById('hartaConfirmModal'));
    modal.hide();
    doSimpan();
});

document.getElementById('btnHartaInput').addEventListener('click', function() {
    var modalConfirm = bootstrap.Modal.getInstance(document.getElementById('hartaConfirmModal'));
    modalConfirm.hide();
    loadHartaModalData();
    var modalInput = new bootstrap.Modal(document.getElementById('hartaInputModal'));
    modalInput.show();
});

document.getElementById('btnHartaBatal').addEventListener('click', function() {
    var modalInput = bootstrap.Modal.getInstance(document.getElementById('hartaInputModal'));
    modalInput.hide();
    var modalConfirm = new bootstrap.Modal(document.getElementById('hartaConfirmModal'));
    modalConfirm.show();
});

document.getElementById('btnHartaSimpan').addEventListener('click', function() {
    var clientId = document.getElementById('clientSelect').value;
    var tahun = document.getElementById('tahunSelect').value;
    var formData = new FormData();
    formData.append('client_id', clientId);
    formData.append('tahun', tahun);
    var hasValue = false;
    // Collect values from all tab panes using input names (nilai[induk][id], nilai[cabang_5][id], etc.)
    document.querySelectorAll('#hartaInputModal input.harta-nilai').forEach(function(inp) {
        var val = inp.value.trim();
        formData.append(inp.getAttribute('name'), val);
        if (val.replace(/[^0-9]/g, '') > 0) hasValue = true;
    });
    document.getElementById('btnHartaSimpan').disabled = true;
    document.getElementById('btnHartaSimpan').innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span> Menyimpan...';
    fetch('{{ route("cms.transaksi.save-harta-ajax") }}', {
        method: 'POST',
        headers: { 'X-CSRF-TOKEN': '{{ csrf_token() }}' },
        body: formData
    }).then(function(res) { return res.json(); }).then(function(data) {
        if (data.success) {
            var modalInput = bootstrap.Modal.getInstance(document.getElementById('hartaInputModal'));
            modalInput.hide();
            doSimpan();
        } else {
            alert('Gagal menyimpan harta.');
            document.getElementById('btnHartaSimpan').disabled = false;
            document.getElementById('btnHartaSimpan').innerHTML = '<i class="bi bi-check-lg me-1"></i> Simpan';
        }
    });
});

function loadHartaModalData() {
    var clientId = document.getElementById('clientSelect').value;
    var tahun = document.getElementById('tahunSelect').value;
    var container = document.getElementById('hartaInputContainer');
    container.innerHTML = '<div class="text-center py-4"><div class="spinner-border text-primary"></div></div>';

    // Build tab list from cabangData for the selected client
    var clientObj = clients.find(function(c) { return c.id === parseInt(clientId); });
    var hartaTabs = [];
    hartaTabs.push({ key: 'induk', label: 'Induk', npwp: clientObj ? (clientObj.npwp || 'Induk') : 'Induk' });
    var clientCabangs = cabangData[parseInt(clientId)] || [];
    clientCabangs.forEach(function(c) {
        hartaTabs.push({ key: 'cabang_' + c.id, label: c.npwp || 'Cabang', npwp: c.npwp || '-', npwp_cabang_id: c.id });
    });

    fetch('{{ route("cms.transaksi.check-harta") }}?client_id=' + clientId + '&tahun=' + tahun)
        .then(function(r) { return r.json(); })
        .then(function(data) {
            var tabsData = data.tabs || {};
            renderHartaForm(hartaTabs, tabsData);
        })
        .catch(function(err) {
            console.error('Harta load error:', err);
            document.getElementById('hartaInputContainer').innerHTML =
                '<div class="text-center text-danger py-4"><i class="bi bi-exclamation-circle fs-1 d-block mb-2"></i>Gagal memuat data harta.</div>';
        });
}

function renderHartaForm(tabList, tabsData) {
    var kategoris = @json($kategoris);
    var container = document.getElementById('hartaInputContainer');
    var tabNav = document.getElementById('hartaInputTabs');
    var tabNavWrap = document.getElementById('hartaInputTabNav');

    // Clear container (removes spinner) and tab nav
    container.innerHTML = '';
    tabNav.innerHTML = '';
    tabNavWrap.classList.add('d-none');

    if (!tabList.length) return;

    // Show tab nav only if more than 1 tab
    if (tabList.length > 1) {
        tabNavWrap.classList.remove('d-none');
    }

    // Create tab-content wrapper to prevent layout jumps
    var tabContent = document.createElement('div');
    tabContent.className = 'tab-content';

    tabList.forEach(function(tab, idx) {
        var isActive = idx === 0;
        var tabId = 'hartaInputTab-' + idx;

        // Nav button — use NPWP as label
        var li = document.createElement('li');
        li.className = 'nav-item';
        var btn = document.createElement('button');
        btn.className = 'nav-link' + (isActive ? ' active' : '');
        btn.id = tabId + '-btn';
        btn.setAttribute('data-bs-toggle', 'tab');
        btn.setAttribute('data-bs-target', '#' + tabId);
        btn.setAttribute('type', 'button');
        btn.setAttribute('role', 'tab');
        btn.textContent = tab.npwp;
        li.appendChild(btn);
        tabNav.appendChild(li);

        // Tab pane — contains the harta form for this tab
        var pane = document.createElement('div');
        pane.className = 'harta-tab-pane tab-pane fade' + (isActive ? ' show active' : '');
        pane.id = tabId;
        pane.setAttribute('role', 'tabpanel');

        // Build harta form HTML for this tab
        var tabKey = tab.key;
        var tabValues = (tabsData[tabKey] && tabsData[tabKey].values) || {};
        var html = '';
        var prefix = 'nilai[' + tabKey + ']';
        kategoris.forEach(function(kat) {
            html += '<div class="card border mb-2"><div class="card-header bg-light py-1"><h6 class="fw-semibold mb-0 small">' + kat.label + '</h6></div><div class="card-body p-0"><table class="table table-sm mb-0"><thead class="table-light"><tr><th class="ps-3" style="width:80px">Kode</th><th>Nama</th><th class="text-end pe-3" style="width:200px">Nilai (Rp)</th></tr></thead><tbody>';
            (kat.master_lampiran_spts || []).forEach(function(m) {
                var val = tabValues[m.id] ? new Intl.NumberFormat('id-ID').format(parseInt(tabValues[m.id], 10)) : '';
                html += '<tr><td class="ps-3"><code>' + m.sub_kode + '</code></td><td>' + m.nama + '</td><td class="pe-3"><input type="text" class="form-control form-control-sm format-currency text-end harta-nilai" name="' + prefix + '[' + m.id + ']" value="' + val + '"></td></tr>';
            });
            html += '</tbody></table></div></div>';
        });
        pane.innerHTML = html;
        tabContent.appendChild(pane);
    });

    container.appendChild(tabContent);

    // Re-attach currency formatting on all panes
    container.querySelectorAll('.format-currency').forEach(function(el) {
        el.addEventListener('input', function(e) {
            var v = this.value.replace(/[^0-9]/g, '');
            if (v) this.value = new Intl.NumberFormat('id-ID').format(parseInt(v, 10));
        });
    });
}

function formatNum(v) {
    return Number(v.replace(/[^0-9]/g, '') || 0).toLocaleString('id-ID');
}

document.getElementById('btnExportPdf').addEventListener('click', function() {
    prepareFormData();
    var f = document.getElementById('formTransaksi');
    f.action = '{{ route("cms.transaksi.export-pdf") }}'; f.submit();
    f.action = '{{ route("cms.transaksi.store") }}';
});

document.getElementById('btnExportExcel').addEventListener('click', function() {
    prepareFormData();
    var f = document.getElementById('formTransaksi');
    f.action = '{{ route("cms.transaksi.export-excel") }}'; f.submit();
    f.action = '{{ route("cms.transaksi.store") }}';
});

document.querySelector('button[type="reset"]').addEventListener('click', function(e) {
    e.preventDefault();
    Object.keys(tabData).forEach(function(p) {
        tabData[p].omsetTahunan = '';
        for (let mo = 1; mo <= 12; mo++) tabData[p].omsetBulanan[mo] = '';
    });
    clearInputs();
    restoreCurrentInputs();
});


</script>
@endpush
