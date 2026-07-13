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

            {{-- Cabang Tabs --}}
            <div id="cabangSection" class="d-none mb-4">
                <div id="cabangTabsWrap" style="background:#fff;padding-top:4px">
                    <ul class="nav nav-tabs" id="cabangTabs" role="tablist"></ul>
                </div>
                <div class="tab-content border border-top-0 rounded-bottom p-3 bg-light" id="cabangTabContent"></div>
            </div>

            <hr>

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

            {{-- Total Peredaran Bruto Summary --}}
            <div id="summarySection" class="row g-4 mb-4 d-none">
                <div class="col-12">
                    <h6 class="fw-semibold text-info border-bottom pb-2"><i class="bi bi-calculator me-2"></i>Total Peredaran Bruto</h6>
                    <div class="mb-2"><span class="text-muted small">Periode:</span> <span class="fw-medium" id="summaryPeriodeLabel">Tahun <span id="summaryTahunText">{{ date('Y') }}</span></span></div>
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered mb-0" id="summaryTable">
                            <thead class="table-info">
                                <tr>
                                    <th>Bulan</th>
                                    <th class="text-end">Omset</th>
                                    <th class="text-end">PPH Final</th>
                                    <th class="text-end">Total Peredaran Bruto</th>
                                    <th class="text-end">Perhitungan Pengurangan</th>
                                    <th class="text-end">PPH Final Harus dibayar</th>
                                </tr>
                            </thead>
                            <tbody id="summaryTableBody"></tbody>
                        </table>
                    </div>
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

            {{-- Omset Per Bulan (untuk Perorangan) --}}
            <div id="omsetBulananSection" class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-warning border-bottom pb-2 position-relative">
                        <span style="vertical-align:middle"><i class="bi bi-calendar-month me-2"></i>Omset Per Bulan</span>
                        <button type="button" class="btn btn-sm btn-outline-warning position-absolute end-0 top-50 translate-middle-y" id="toggleOmsetInput">
                            <i class="bi bi-eye-slash me-1"></i> <span id="toggleOmsetInputLabel">Sembunyikan</span>
                        </button>
                    </h6>
                </div>
                <div id="omsetInputContainer" class="col-12">
                    <ul class="nav nav-tabs nav-fill" id="monthTabs" role="tablist">
                        @php $months = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des']; @endphp
                        @foreach($months as $i => $monthName)
                            @php $mo = $i + 1; @endphp
                            <li class="nav-item" role="presentation">
                                <button class="nav-link {{ $mo === 1 ? 'active' : '' }}" id="tab-{{ $mo }}" data-bs-toggle="tab" data-bs-target="#month-{{ $mo }}" type="button" role="tab" aria-controls="month-{{ $mo }}" aria-selected="{{ $mo === 1 ? 'true' : 'false' }}">
                                    {{ $monthName }}
                                </button>
                            </li>
                        @endforeach
                    </ul>
                    <div class="tab-content border border-top-0 rounded-bottom p-4 bg-white" id="monthTabsContent">
                        @foreach($months as $i => $monthName)
                            @php $mo = $i + 1; @endphp
                            <div class="tab-pane fade {{ $mo === 1 ? 'show active' : '' }}" id="month-{{ $mo }}" role="tabpanel" aria-labelledby="tab-{{ $mo }}">
                                <div class="row g-4">
                                    <div class="col-12">
                                        <h6 class="fw-semibold text-warning border-bottom pb-2"><i class="bi bi-graph-up-arrow me-2"></i>Omset - {{ $monthName }}</h6>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-semibold small">Jumlah Omset</label>
                                        <div class="input-group">
                                            <span class="input-group-text">Rp</span>
                                            <input type="text" class="form-control format-currency omset-input" name="omset_bulanan[{{ $mo }}]" data-month="{{ $mo }}" placeholder="0">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>

            {{-- Hasil Perhitungan Per Bulan --}}
            <div id="hasilPerhitunganSection" class="row g-4 mb-4 d-none">
                <div class="col-12">
                    <h6 class="fw-semibold text-info border-bottom pb-2 position-relative">
                        <span style="vertical-align:middle"><i class="bi bi-table me-2"></i>Hasil Perhitungan Per Bulan</span>
                        <button type="button" class="btn btn-sm btn-outline-info position-absolute end-0 top-50 translate-middle-y" id="toggleHasilTable">
                            <i class="bi bi-eye-slash me-1"></i> <span id="toggleHasilTableLabel">Sembunyikan</span>
                        </button>
                    </h6>
                </div>
                <div id="hasilTableContainer" class="col-12">
                    <div class="table-responsive">
                        <table class="table table-sm table-bordered mb-0" id="hasilPerhitunganTable">
                            <thead class="table-info">
                                <tr>
                                    <th style="width:80px">Bulan</th>
                                    <th class="text-end">Peredaran Bruto</th>
                                    <th class="text-end">Total Peredaran Bruto Cabang</th>
                                    <th class="text-end" id="akumColHeader">Total Peredaran Bruto Akum <small class="text-muted fw-normal" id="akumCabangLabel"></small></th>
                                    <th class="text-end">PPH Final <span id="pphPersenLabel">0.5</span>%</th>
                                    <th class="text-end">PPh Final yg harus dibayar</th>
                                    <th style="width:40px" class="text-center">Status</th>
                                </tr>
                            </thead>
                            <tbody id="hasilTableBody">
                                @foreach(['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'] as $i => $bulan)
                                <tr id="hasilRow-{{ $i + 1 }}" class="d-none">
                                    <td class="text-muted">{{ $bulan }}</td>
                                    <td class="text-end" id="hasilOmset-{{ $i + 1 }}">-</td>
                                    <td class="text-end" id="hasilBruto-{{ $i + 1 }}">-</td>
                                    <td class="text-end akum-col" id="hasilBrutoAkum-{{ $i + 1 }}">-</td>
                                    <td class="text-end" id="hasilPph-{{ $i + 1 }}">-</td>
                                    <td class="text-end" id="hasilFinal-{{ $i + 1 }}">-</td>
                                    <td class="text-center" id="hasilStatus-{{ $i + 1 }}">-</td>
                                </tr>
                                @endforeach
                                <tr class="fw-bold table-secondary" id="hasilTotalRow">
                                    <td colspan="6" class="text-center">Total</td>
                                    <td class="text-end text-danger" id="hasilTotalPph">Rp 0</td>
                                </tr>
                            </tbody>
                        </table>
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

var activeTabPrefix = 'induk';
var tabData = {};
var hasCabang = false;

$(document).ready(function() {
    $('#clientSelect').select2({
        placeholder: '-- Cari & Pilih Client --',
        allowClear: true,
        width: '100%'
    });
    $('#clientSelect').on('select2:select select2:clear change', function() {
        handleClientChange();
    });
    $('body').on('shown.bs.tab', '#cabangTabs button[data-bs-toggle="tab"]', function() {
        var prefix = $(this).data('prefix');
        var ss = document.getElementById('summarySection');
        if (prefix === 'summary') {
            saveCurrentInputs();
            activeTabPrefix = 'summary';
            document.getElementById('hartaSection').classList.add('d-none');
            document.getElementById('omsetTahunanSection').classList.add('d-none');
            document.getElementById('omsetBulananSection').classList.add('d-none');
            document.getElementById('hasilPerhitunganSection').classList.add('d-none');
            if (ss) ss.classList.remove('d-none');
            populateSummaryTable();
        } else {
            saveCurrentInputs();
            activeTabPrefix = prefix;
            document.getElementById('hartaSection').classList.remove('d-none');
            if (ss) ss.classList.add('d-none');
            restoreCurrentInputs();
        }
    });
});

function handleClientChange() {
    const el = document.getElementById('clientSelect');
    const id = parseInt(el.value);
    var btnImport = document.getElementById('btnImportTransaksi');
    if (!id) {
        if (btnImport) btnImport.classList.add('d-none');
        document.getElementById('cabangSection').classList.add('d-none');
        document.getElementById('summarySection').classList.add('d-none');
        document.getElementById('hartaSection').classList.add('d-none');
        document.getElementById('omsetTahunanSection').classList.add('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
        document.getElementById('hasilPerhitunganSection').classList.add('d-none');
        toggleButtons();
        return;
    }
    if (btnImport) btnImport.classList.remove('d-none');

    document.getElementById('summarySection').classList.add('d-none');
    tabData = {};
    activeTabPrefix = 'induk';
    hasCabang = false;

    const opt = el.options[el.selectedIndex];
    if (!opt) return;
    const tipeId = parseInt(opt.dataset.tipeId);
    const tipeName = getTipeName(tipeId);
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

    const cabangSection = document.getElementById('cabangSection');
    const tabsContainer = document.getElementById('cabangTabs');
    const contentContainer = document.getElementById('cabangTabContent');
    const clientCabangs = cabangData[id] || [];

    if (clientCabangs && clientCabangs.length > 0) {
        hasCabang = true;
        tabsContainer.innerHTML = '';
        contentContainer.innerHTML = '';
        buildTab('induk', c ? c.nama_client : 'Induk', c ? (c.npwp || '-') : '-', null, true, c ? (c.kpp || '-') : '-');

        // Sort cabangs by last 3 digits of NPWP
        clientCabangs.sort(function(a, b) {
            return (a.npwp || '').slice(-3).localeCompare((b.npwp || '').slice(-3));
        });
        clientCabangs.forEach(function(cabang, i) {
            var pfx = 'cabang_' + i;
            tabData[pfx] = {
                nama: cabang.nama_client || 'Cabang ' + (i + 1),
                npwp: cabang.npwp || '-',
                npwp_cabang_id: cabang.id,
                tipeId: tipeId,
                kpp: cabang.kpp || '-',
                no_telephone: cabang.no_telephone || '-',
                alamat_npwp: cabang.alamat_npwp || '-',
                omsetTahunan: '',
                omsetBulanan: {}
            };
            for (let mo = 1; mo <= 12; mo++) tabData[pfx].omsetBulanan[mo] = '';
            buildTab(pfx, tabData[pfx].nama, tabData[pfx].npwp, cabang.id, false, cabang.kpp || '-');
        });
        cabangSection.classList.remove('d-none');
        buildSummaryTab();
    } else {
        cabangSection.classList.add('d-none');
        buildSummaryTab();
    }

    // Update PPH percentage label from rumus
    const rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(tipeId); });
    document.getElementById('pphPersenLabel').textContent = rumus ? String(rumus.potongan_persentase) : '0';

    // Update akum cabang label
    var cabangCountLabel = 0;
    Object.keys(tabData).forEach(function(k) { if (k !== 'induk') cabangCountLabel++; });
    document.getElementById('akumCabangLabel').textContent = '(' + cabangCountLabel + ' Cabang)';
    document.getElementById('akumColHeader').classList.remove('d-none');
    document.querySelectorAll('.akum-col').forEach(function(el) { el.classList.remove('d-none'); });

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

function buildTab(prefix, nama, npwp, npwpCabangId, isActive, kpp) {
    var tabsContainer = document.getElementById('cabangTabs');
    var contentContainer = document.getElementById('cabangTabContent');
    var tabId = 'cabTab_' + prefix;

    var li = document.createElement('li');
    li.className = 'nav-item';
    li.innerHTML = '<button class="nav-link ' + (isActive ? 'active' : '') + '" data-bs-toggle="tab" data-bs-target="#' + tabId + '" type="button" role="tab" data-prefix="' + prefix + '">' +
        '<i class="bi ' + (prefix === 'induk' ? 'bi-building' : 'bi-diagram-2') + ' me-1"></i> ' + (npwp || 'Induk') + '</button>';
    tabsContainer.appendChild(li);

    var pane = document.createElement('div');
    pane.className = 'tab-pane fade' + (isActive ? ' show active' : '');
    pane.id = tabId;
    pane.setAttribute('role', 'tabpanel');
    pane.setAttribute('data-prefix', prefix);
    pane.innerHTML = '<div class="row g-2 small">' +
        '<div class="col-6"><span class="text-muted">Nama:</span> <span class="fw-medium">' + (nama || '-') + '</span></div>' +
        '<div class="col-6"><span class="text-muted">NPWP:</span> <span>' + (npwp || '-') + '</span></div>' +
        '<div class="col-6"><span class="text-muted">KPP:</span> <span>' + (kpp || '-') + '</span></div>' +
        (npwpCabangId ? '<div class="col-12"><input type="hidden" name="' + prefix + '[npwp_cabang_id]" value="' + npwpCabangId + '"></div>' : '') +
        '</div>';
    contentContainer.appendChild(pane);
}

function buildSummaryTab() {
    var tabsContainer = document.getElementById('cabangTabs');
    if (!tabsContainer) return;
    var li = document.createElement('li');
    li.className = 'nav-item';
    li.innerHTML = '<button class="nav-link" data-bs-toggle="tab" data-bs-target="#cabTab_summary" type="button" role="tab" data-prefix="summary">' +
        '<i class="bi bi-calculator me-1"></i> Total Peredaran Bruto</button>';
    tabsContainer.appendChild(li);
}

function populateSummaryTable() {
    var tbody = document.getElementById('summaryTableBody');
    if (!tbody) return;
    tbody.innerHTML = '';

    var tipeId = null;
    Object.keys(tabData).forEach(function(k) { var td = tabData[k]; if (td && tipeId === null) tipeId = td.tipeId; });
    var rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(tipeId); });
    var maxVal = Number(rumus?.max_value || 0);
    var persen = Number(rumus?.potongan_persentase || 0);
    var bulanList = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];

    function getOmset(prefix, mo) {
        var td = tabData[prefix];
        if (!td) return 0;
        if (td.tipeId === 1) {
            return Number((td.omsetTahunan || '').replace(/[^0-9]/g, '') || 0);
        }
        return Number((td.omsetBulanan[mo] || '').replace(/[^0-9]/g, '') || 0);
    }

    var cumulative = 0;
    for (let mo = 1; mo <= 12; mo++) {
        var totalOmset = 0;
        var totalPph = 0;
        Object.keys(tabData).forEach(function(p) {
            var o = getOmset(p, mo);
            totalOmset += o;
            totalPph += o * persen / 100;
        });

        var showTotalPb = cumulative + totalOmset;
        var pengurangan = maxVal > 0 ? Math.max(0, maxVal - cumulative) : 0;
        var pphBayar;
        if (maxVal > 0 && cumulative > maxVal) {
            pphBayar = 'Rp ' + formatNum(String(cumulative * persen / 100));
        } else {
            pphBayar = 'FREE';
        }

        // Jika bulan kosong, timpa dengan Rp 0
        if (totalOmset === 0) {
            showTotalPb = 0;
            pengurangan = 0;
            pphBayar = 'FREE';
        }

        cumulative += totalOmset;

        var tr = document.createElement('tr');
        tr.innerHTML = '<td>' + bulanList[mo - 1] + '</td>' +
            '<td class="text-end">Rp ' + formatNum(String(totalOmset)) + '</td>' +
            '<td class="text-end">Rp ' + formatNum(String(totalPph)) + '</td>' +
            '<td class="text-end">Rp ' + formatNum(String(showTotalPb)) + '</td>' +
            '<td class="text-end">' + (maxVal > 0 ? 'Rp ' + formatNum(String(pengurangan)) : '-') + '</td>' +
            '<td class="text-end fw-semibold ' + (pphBayar === 'FREE' ? 'text-success' : 'text-danger') + '">' + pphBayar + '</td>';
        tbody.appendChild(tr);
    }
}

function getTipeName(tipeId) {
    const b = badanList.find(x => x.id === tipeId);
    return b ? b.tipe : '';
}

function clearInputs() {
    document.querySelectorAll('.omset-input').forEach(function(el) { el.value = ''; });
    document.getElementById('omsetTahunan').value = '';
    for (let mo = 1; mo <= 12; mo++) {
        document.getElementById('hasilRow-' + mo).classList.add('d-none');
        document.getElementById('hasilOmset-' + mo).textContent = '-';
        document.getElementById('hasilBruto-' + mo).textContent = '-';
        document.getElementById('hasilBrutoAkum-' + mo).textContent = '-';
        document.getElementById('hasilPph-' + mo).textContent = '-';
        document.getElementById('hasilFinal-' + mo).textContent = '-';
        document.getElementById('hasilStatus-' + mo).textContent = '-';
    }
    document.getElementById('hasilPerhitunganSection').classList.add('d-none');
    document.getElementById('hasilTotalPph').textContent = 'Rp 0';
    var a = document.getElementById('alert4M');
    if (a) a.remove();
    toggleButtons();
}

function saveCurrentInputs() {
    var prefix = activeTabPrefix;
    if (!tabData[prefix]) return;
    var isTahunan = tabData[prefix].tipeId === 1;
    if (isTahunan) {
        tabData[prefix].omsetTahunan = document.getElementById('omsetTahunan').value;
    } else {
        document.querySelectorAll('.omset-input').forEach(function(inp) {
            var mo = inp.getAttribute('data-month');
            tabData[prefix].omsetBulanan[mo] = inp.value;
        });
    }
}

function restoreCurrentInputs() {
    var prefix = activeTabPrefix;
    var data = tabData[prefix];
    if (!data) { clearInputs(); return; }

    // Restore name attributes on visible omset inputs
    document.getElementById('omsetTahunan').name = 'omset_tahunan';
    document.querySelectorAll('.omset-input').forEach(function(inp) {
        var mo = inp.getAttribute('data-month');
        inp.name = 'omset_bulanan[' + mo + ']';
    });

    var isTahunan = data.tipeId === 1;
    if (isTahunan) {
        document.getElementById('omsetTahunanSection').classList.remove('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
        document.getElementById('omsetTahunan').value = data.omsetTahunan || '';
    } else {
        document.getElementById('omsetTahunanSection').classList.add('d-none');
        document.getElementById('omsetBulananSection').classList.remove('d-none');
        document.querySelectorAll('.omset-input').forEach(function(inp) {
            var mo = inp.getAttribute('data-month');
            inp.value = (data.omsetBulanan && data.omsetBulanan[mo]) || '';
        });
        hitungOmset();
    }
    toggleButtons();
}

function toggleButtons() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (!clientId) { disableAllButtons(true); return; }

    var hasData = false;
    Object.keys(tabData).forEach(function(p) {
        var td = tabData[p];
        if (!td) return;
        if (td.tipeId === 1) {
            if (Number((td.omsetTahunan || '').replace(/[^0-9]/g, '') || 0) > 0) hasData = true;
        } else {
            for (let mo = 1; mo <= 12; mo++) {
                if (Number((td.omsetBulanan[mo] || '').replace(/[^0-9]/g, '') || 0) > 0) hasData = true;
            }
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

function hitungOmset() {
    const tipeId = tabData[activeTabPrefix]?.tipeId;
    if (!tipeId) return;
    const rumus = rumusList.find(r => String(r.tipe_badan) === String(tipeId));
    const maxVal = Number(rumus?.max_value || 0);
    const persen = Number(rumus?.potongan_persentase || 0);
    const LIMIT_400JT = 400000000;
    const LIMIT_4M = 4000000000;

    let cumulative = 0, totalPotongan = 0, cumulativeExceeds4M = false;

    // Build ordered tab list (pusat first, then cabangs sorted by NPWP last 3 digits)
    var cabangPrefixes = [];
    Object.keys(tabData).forEach(function(k) { if (k !== 'induk') cabangPrefixes.push(k); });
    cabangPrefixes.sort(function(a, b) {
        return (tabData[a].npwp || '').slice(-3).localeCompare((tabData[b].npwp || '').slice(-3));
    });
    var cascCabangCount = cabangPrefixes.length;

    // Compute cascading akum per month per tab
    var akumCache = {};
    function getPB(prefix, month) {
        var td = tabData[prefix];
        if (!td) return 0;
        if (td.tipeId === 1) {
            return Number((td.omsetTahunan || '').replace(/[^0-9]/g, '') || 0);
        }
        return Number((td.omsetBulanan[month] || '').replace(/[^0-9]/g, '') || 0);
    }
    for (let mo = 1; mo <= 12; mo++) {
        if (cascCabangCount === 0) {
            akumCache['induk'] = akumCache['induk'] || {};
            akumCache['induk'][mo] = 0;
        } else {
            var pusatPB = getPB('induk', mo);
            if (mo === 1) {
                akumCache['induk'] = akumCache['induk'] || {};
                akumCache['induk'][mo] = pusatPB;
            } else {
                var lastCp = cabangPrefixes[cabangPrefixes.length - 1];
                var prevAkumLast = akumCache[lastCp] ? (akumCache[lastCp][mo - 1] || 0) : 0;
                akumCache['induk'] = akumCache['induk'] || {};
                akumCache['induk'][mo] = pusatPB + prevAkumLast;
            }
            var prevAkum = akumCache['induk'][mo];
            for (let ci = 0; ci < cascCabangCount; ci++) {
                var cp = cabangPrefixes[ci];
                var cabangPB = getPB(cp, mo);
                akumCache[cp] = akumCache[cp] || {};
                akumCache[cp][mo] = cabangPB + prevAkum;
                prevAkum = akumCache[cp][mo];
            }
        }
    }

    for (let mo = 1; mo <= 12; mo++) {
        var inp = document.querySelector('.omset-input[data-month="' + mo + '"]');
        var val = inp ? inp.value : '0';
        const current = Number(val.replace(/[^0-9]/g, '') || 0);
        const row = document.getElementById('hasilRow-' + mo);

        if (current === 0) {
            if (row) row.classList.add('d-none');
            cumulative += current; continue;
        }

        const totalWithCurrent = cumulative + current;
        const exceeds400 = current > LIMIT_400JT;
        const omsetCell = document.getElementById('hasilOmset-' + mo);
        if (omsetCell) {
            omsetCell.innerHTML = exceeds400
                ? '<span class="text-danger fw-bold"><i class="bi bi-exclamation-triangle-fill me-1"></i>Rp ' + formatNum(String(current)) + ' <span class="badge bg-danger ms-1">>400JT</span></span>'
                : 'Rp ' + formatNum(String(current));
        }

        if (totalWithCurrent >= LIMIT_4M) cumulativeExceeds4M = true;

        let pphBayar = '', pphClass = '';
        if (rumus) {
            if (cumulative >= maxVal) {
                const potongan = current * persen / 100;
                totalPotongan += potongan;
                pphBayar = 'Rp ' + formatNum(String(potongan)); pphClass = 'text-danger';
            } else if (totalWithCurrent > maxVal) {
                const kelebihan = totalWithCurrent - maxVal;
                const potongan = kelebihan * persen / 100;
                totalPotongan += potongan;
                pphBayar = 'Rp ' + formatNum(String(potongan)); pphClass = 'text-warning';
            } else { pphBayar = 'Free'; pphClass = 'text-success'; }
        } else { pphBayar = '-'; pphClass = ''; }

        const pphFinal = !rumus ? '-' : 'Rp ' + formatNum(String(current * persen / 100));

        document.getElementById('hasilBruto-' + mo).textContent = 'Rp ' + formatNum(String(totalWithCurrent));
        var akumEl = document.getElementById('hasilBrutoAkum-' + mo);
        var akumVal = akumCache[activeTabPrefix] ? (akumCache[activeTabPrefix][mo] || 0) : 0;
        akumEl.textContent = 'Rp ' + formatNum(String(akumVal));
        document.getElementById('hasilPph-' + mo).innerHTML = '<span class="text-danger fw-semibold">' + pphFinal + '</span>';
        document.getElementById('hasilFinal-' + mo).innerHTML = '<span class="fw-semibold ' + pphClass + '">' + pphBayar + '</span>';

        var st = document.getElementById('hasilStatus-' + mo);
        if (st) {
            var ic = '';
            if (exceeds400) ic += '<span class="text-danger" title="Omset > 400 Juta"><i class="bi bi-exclamation-triangle-fill"></i></span>';
            if (totalWithCurrent >= LIMIT_4M) ic += ' <span class="text-danger" title="Akumulasi >= 4 Milyar"><i class="bi bi-arrow-up-circle-fill"></i></span>';
            if (!ic) ic = '<span class="text-success"><i class="bi bi-check-circle"></i></span>';
            st.innerHTML = ic;
        }

        row.classList.remove('d-none');
        cumulative += current;
    }

    document.getElementById('hasilTotalPph').textContent = 'Rp ' + formatNum(String(totalPotongan));
    var hasData = cumulative > 0;
    document.getElementById('hasilPerhitunganSection').classList.toggle('d-none', !hasData);
}

function loadDataFromDb() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    const tahun = document.getElementById('tahunSelect').value;
    if (!clientId || !tahun) return;

    fetch('/admin/transaksi/load-data?client_id=' + clientId + '&tahun=' + tahun)
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
        .catch(function(err) { console.error('Load data error:', err); });
}

document.getElementById('tahunSelect').addEventListener('change', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (clientId && this.value) {
        document.getElementById('btnLampiranSpt').href = document.getElementById('btnLampiranSpt').href.split('?')[0] + '?client_id=' + clientId + '&tahun=' + this.value;
    }
    var tt = document.getElementById('summaryTahunText');
    if (tt) tt.textContent = this.value || '{{ date("Y") }}';
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
    // If summary tab is active, refresh after load completes
    if (activeTabPrefix === 'summary') {
        var checkLoaded = setInterval(function() {
            var hasData = false;
            Object.keys(tabData).forEach(function(p) {
                var td = tabData[p]; if (!td) return;
                if (td.tipeId === 1 && (td.omsetTahunan || '') !== '') hasData = true;
                else if (td.tipeId !== 1) {
                    for (let mo = 1; mo <= 12; mo++) {
                        if ((td.omsetBulanan[mo] || '') !== '') hasData = true;
                    }
                }
            });
            populateSummaryTable();
            if (hasData) clearInterval(checkLoaded);
            // Also stop after 3 seconds max
            setTimeout(function() { clearInterval(checkLoaded); }, 3000);
        }, 200);
    }
});

document.getElementById('toggleOmsetInput').addEventListener('click', function() {
    var container = document.getElementById('omsetInputContainer');
    var label = document.getElementById('toggleOmsetInputLabel');
    if (container.classList.toggle('d-none')) {
        label.textContent = 'Tampilkan';
    } else {
        label.textContent = 'Sembunyikan';
    }
});

document.getElementById('toggleHasilTable').addEventListener('click', function() {
    var container = document.getElementById('hasilTableContainer');
    var label = document.getElementById('toggleHasilTableLabel');
    if (container.classList.toggle('d-none')) {
        label.textContent = 'Tampilkan';
    } else {
        label.textContent = 'Sembunyikan';
    }
});

document.querySelectorAll('.omset-input').forEach(function(inp) {
    inp.addEventListener('input', function() {
        var mo = inp.getAttribute('data-month');
        if (tabData[activeTabPrefix]) tabData[activeTabPrefix].omsetBulanan[mo] = this.value;
        hitungOmset(); toggleButtons();
    });
});

document.getElementById('omsetTahunan').addEventListener('input', function() {
    if (tabData[activeTabPrefix]) tabData[activeTabPrefix].omsetTahunan = this.value;
    toggleButtons();
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

    const client = clients.find(function(x) { return x.id === clientId; });
    var tipeName = '';
    if (client) {
        var b = badanList.find(function(x) { return x.id === client.tipe_badan; });
        if (b) tipeName = b.tipe;
    }

    var tabsHtml = '<ul class="nav nav-tabs" id="previewTabs" role="tablist">';
    var contentHtml = '<div class="tab-content border border-top-0 p-3 bg-white" id="previewTabContent">';
    var first = true;

    // Build ordered cabang list sorted by NPWP last 3 digits
    var previewCabangPrefixes = [];
    Object.keys(tabData).forEach(function(k) { if (k !== 'induk') previewCabangPrefixes.push(k); });
    previewCabangPrefixes.sort(function(a, b) {
        return (tabData[a].npwp || '').slice(-3).localeCompare((tabData[b].npwp || '').slice(-3));
    });
    var previewCabangCount = previewCabangPrefixes.length;

    // Compute cascading akum per month per tab
    var previewAkumCache = {};
    function previewGetPB(prefix, month) {
        var td = tabData[prefix];
        if (!td) return 0;
        if (td.tipeId === 1) {
            return Number((td.omsetTahunan || '').replace(/[^0-9]/g, '') || 0);
        }
        return Number((td.omsetBulanan && td.omsetBulanan[month] || '0').replace(/[^0-9]/g, '') || 0);
    }
    for (let mo = 1; mo <= 12; mo++) {
        if (previewCabangCount === 0) {
            previewAkumCache['induk'] = previewAkumCache['induk'] || {};
            previewAkumCache['induk'][mo] = 0;
        } else {
            var pusatPB = previewGetPB('induk', mo);
            if (mo === 1) {
                previewAkumCache['induk'] = previewAkumCache['induk'] || {};
                previewAkumCache['induk'][mo] = pusatPB;
            } else {
                var lastCp = previewCabangPrefixes[previewCabangPrefixes.length - 1];
                var prevLast = previewAkumCache[lastCp] ? (previewAkumCache[lastCp][mo - 1] || 0) : 0;
                previewAkumCache['induk'] = previewAkumCache['induk'] || {};
                previewAkumCache['induk'][mo] = pusatPB + prevLast;
            }
            var prevAkum = previewAkumCache['induk'][mo];
            for (let ci = 0; ci < previewCabangCount; ci++) {
                var cp = previewCabangPrefixes[ci];
                var cabangPB = previewGetPB(cp, mo);
                previewAkumCache[cp] = previewAkumCache[cp] || {};
                previewAkumCache[cp][mo] = cabangPB + prevAkum;
                prevAkum = previewAkumCache[cp][mo];
            }
        }
    }

    Object.keys(tabData).forEach(function(prefix) {
        var td = tabData[prefix];
        if (!td) return;
        var tabId = 'prev_' + prefix;
        var label = td.npwp || (prefix === 'induk' ? 'Induk' : 'Cabang');
        var isActive = first ? 'active show' : '';

        tabsHtml += '<li class="nav-item"><button class="nav-link ' + (first ? 'active' : '') + '" data-bs-toggle="tab" data-bs-target="#' + tabId + '" type="button" role="tab"><i class="bi ' + (prefix === 'induk' ? 'bi-building' : 'bi-diagram-2') + ' me-1"></i> ' + label + '</button></li>';

        var isId1 = td.tipeId === 1;
        var omsetDetails = '';
        var totalOmset = 0;

        if (isId1) {
            totalOmset = Number((td.omsetTahunan || '').replace(/[^0-9]/g, '') || 0);
            if (totalOmset > 0) omsetDetails = '<tr><td class="text-muted">Tahunan</td><td class="text-end">Rp ' + formatNum(String(totalOmset)) + '</td></tr>';
        } else {
            for (let mo = 1; mo <= 12; mo++) {
                var omsetVal = (td.omsetBulanan && td.omsetBulanan[mo]) || '0';
                var omsetNum = Number(omsetVal.replace(/[^0-9]/g, '') || 0);
                totalOmset += omsetNum;
                if (omsetNum > 0) omsetDetails += '<tr><td class="text-muted ps-4">' + bulanList[mo - 1] + '</td><td class="text-end">Rp ' + formatNum(String(omsetNum)) + '</td></tr>';
            }
        }

        var paneHtml = '<div class="table-responsive mb-3"><table class="table table-sm small mb-0">' +
            '<tr><td style="width:140px" class="text-muted">Nama</td><td class="fw-medium">' + (td.nama || '-') + '</td></tr>' +
            '<tr><td class="text-muted">NPWP</td><td>' + (td.npwp || '-') + '</td></tr>' +
            '<tr><td class="text-muted">Tipe</td><td>' + (tipeName || '-') + '</td></tr>' +
            '<tr><td class="text-muted">KPP</td><td>' + (td.kpp || '-') + '</td></tr>' +
            '<tr><td class="text-muted">No. Telp</td><td>' + (td.no_telephone || '-') + '</td></tr>' +
            '<tr><td class="text-muted">Alamat NPWP</td><td>' + (td.alamat_npwp || '-') + '</td></tr>' +
            '<tr><td class="text-muted">Periode</td><td class="fw-medium">Tahun ' + tahun + '</td></tr>' +
            '</table></div>';

        if (omsetDetails && isId1) {
            paneHtml += '<div class="mb-3"><h6 class="fw-semibold text-warning border-bottom pb-2">Omset Tahunan</h6>' +
                '<table class="table table-sm small mb-0"><thead><tr><th>Periode</th><th class="text-end">Omset</th></tr></thead><tbody>' +
                omsetDetails +
                '<tr class="fw-bold"><td>Total</td><td class="text-end">Rp ' + formatNum(String(totalOmset)) + '</td></tr>' +
                '</tbody></table></div>';
        }

        if (!isId1) {
            const rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(td.tipeId); });
            const maxVal = Number(rumus?.max_value || 0);
            const persen = Number(rumus?.potongan_persentase || 0);
            let cumulative = 0, totalPotongan = 0, calcRows = '';

            for (let mo = 1; mo <= 12; mo++) {
                var omsetVal = (td.omsetBulanan && td.omsetBulanan[mo]) || '0';
                var current = Number(omsetVal.replace(/[^0-9]/g, '') || 0);
                if (current === 0) { cumulative += current; continue; }
                const tot = cumulative + current;
                let ppb, ppc, ppf;
                if (cumulative >= maxVal) {
                    const p = current * persen / 100; totalPotongan += p; ppb = 'Rp ' + formatNum(String(p)); ppc = 'text-danger';
                } else if (tot > maxVal) {
                    const kelebihan = tot - maxVal; const p = kelebihan * persen / 100; totalPotongan += p; ppb = 'Rp ' + formatNum(String(p)); ppc = 'text-warning';
                } else { ppb = 'Free'; ppc = 'text-success'; }
                ppf = 'Rp ' + formatNum(String(current * persen / 100));
                var akumPreview = '<td class="text-end">Rp ' + formatNum(String(previewAkumCache[prefix] ? (previewAkumCache[prefix][mo] || 0) : 0)) + '</td>';
                calcRows += '<tr><td class="text-muted ps-4">' + bulanList[mo - 1] + '</td><td class="text-end">Rp ' + formatNum(String(current)) + '</td><td class="text-end">Rp ' + formatNum(String(tot)) + '</td>' + akumPreview + '<td class="text-end text-danger fw-semibold">' + ppf + '</td><td class="text-end ' + ppc + ' fw-semibold">' + ppb + '</td></tr>';
                cumulative += current;
            }

            var persenLabel = persen > 0 ? persen.toString().replace('.', ',') : '0';
            var cabangLabelPreview = ' (' + previewCabangCount + ' Cabang)';
            var akumHeader = '<th class="text-end">Total Peredaran Bruto Akum' + cabangLabelPreview + '</th>';
            paneHtml += '<h6 class="fw-semibold text-secondary border-bottom pb-2">Hasil Perhitungan</h6>' +
                '<div class="table-responsive"><table class="table table-sm small mb-0"><thead><tr><th>Bulan</th><th class="text-end">Peredaran Bruto</th><th class="text-end">Total Peredaran Bruto Cabang</th>' + akumHeader + '<th class="text-end">PPH Final ' + persenLabel + '%</th><th class="text-end">PPh Final yg harus dibayar</th></tr></thead><tbody>' +
                calcRows +
                '<tr class="fw-bold table-secondary"><td colspan="5" class="text-center">Total</td><td class="text-end text-danger">Rp ' + formatNum(String(totalPotongan)) + '</td></tr>' +
                '</tbody></table></div>';
        }

        paneHtml += '<div class="mt-3 pt-2 border-top"><strong>Total Omset:</strong> <span class="text-warning fw-bold">Rp ' + formatNum(String(totalOmset)) + '</span></div>';
        contentHtml += '<div class="tab-pane fade ' + isActive + '" id="' + tabId + '" role="tabpanel">' + paneHtml + '</div>';
        first = false;
    });

    document.getElementById('previewContent').innerHTML = tabsHtml + contentHtml + '</div>';
    var modal = new bootstrap.Modal(document.getElementById('previewModal'));
    modal.show();
});

// --- Helper: prepare form data for submission ---
function prepareFormData() {
    saveCurrentInputs();
    // Remove name from visible omset inputs so they don't duplicate hidden per-tab fields
    document.querySelectorAll('#omsetTahunan, #omsetInputContainer input.omset-input').forEach(function(el) { el.removeAttribute('name'); });
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
    const rumus = rumusList.find(function(r) { return String(r.tipe_badan) === String(tabData['induk'].tipeId); });
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

// Floating NPWP tabs on scroll
(function() {
    var wrap = document.getElementById('cabangTabsWrap');
    if (!wrap) return;
    var floatState = { active: false, left: 0, width: 0, offsetTop: 0 };
    var spacer = null;

    function updateFloat() {
        var section = document.getElementById('cabangSection');
        if (!section || section.classList.contains('d-none')) {
            if (spacer) { spacer.remove(); spacer = null; }
            floatState.active = false;
            wrap.style.position = '';
            wrap.style.top = '';
            wrap.style.left = '';
            wrap.style.width = '';
            wrap.style.zIndex = '';
            wrap.style.boxShadow = '';
            return;
        }
        if (!floatState.active) {
            var rect = wrap.getBoundingClientRect();
            if (rect.top <= 0) {
                floatState.active = true;
                floatState.left = rect.left;
                floatState.width = rect.width;
                floatState.offsetTop = window.pageYOffset + rect.top;
                spacer = document.createElement('div');
                spacer.style.height = rect.height + 'px';
                wrap.parentNode.insertBefore(spacer, wrap.nextSibling);
            }
        }
        if (floatState.active) {
            if (window.pageYOffset < floatState.offsetTop) {
                floatState.active = false;
                if (spacer) { spacer.remove(); spacer = null; }
                wrap.style.position = '';
                wrap.style.top = '';
                wrap.style.left = '';
                wrap.style.width = '';
                wrap.style.zIndex = '';
                wrap.style.boxShadow = '';
                return;
            }
            wrap.style.position = 'fixed';
            wrap.style.top = '0';
            wrap.style.left = floatState.left + 'px';
            wrap.style.width = floatState.width + 'px';
            wrap.style.zIndex = '1020';
            wrap.style.boxShadow = '0 2px 8px rgba(0,0,0,0.1)';
        }
    }

    document.addEventListener('scroll', updateFloat, { passive: true });
    new MutationObserver(function() { setTimeout(updateFloat, 50); })
        .observe(document.getElementById('cabangSection'), { attributes: true, attributeFilter: ['class'] });
})();
</script>
@endpush
