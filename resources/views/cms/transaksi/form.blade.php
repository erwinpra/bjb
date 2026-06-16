@extends('cms::layouts.app')

@section('title', 'Transaksi Baru')

@push('breadcrumb')
    <li class="breadcrumb-item active" aria-current="page">Transaksi Baru</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
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
                    <select id="clientSelect" name="client_id" class="form-select" required>
                        <option value="">-- Pilih Client --</option>
                        @foreach($clients as $c)
                            <option value="{{ $c->id }}" data-nama="{{ $c->nama_client }}" data-npwp="{{ $c->npwp }}" data-phone="{{ $c->no_telephone }}" data-alamat="{{ $c->alamat }}" data-kpp="{{ $c->kpp }}" data-tipe-id="{{ $c->tipe_badan }}">
                                {{ $c->nama_client }} — {{ $c->npwp ?: 'NPWP: -' }}
                            </option>
                        @endforeach
                    </select>
                </div>
            </div>

            <div id="clientDetail" class="row g-3 mb-4 d-none">
                <div class="col-12">
                    <div class="card bg-light border">
                        <div class="card-body py-3 px-4">
                            <div class="row g-2 small">
                                <div class="col-md-3"><span class="text-muted">Nama:</span> <span id="detailNama" class="fw-medium"></span></div>
                                <div class="col-md-3"><span class="text-muted">NPWP:</span> <span id="detailNpwp"></span></div>
                                <div class="col-md-2"><span class="text-muted">Tipe:</span> <span id="detailTipe"></span></div>
                                <div class="col-md-2"><span class="text-muted">KPP:</span> <span id="detailKpp"></span></div>
                                <div class="col-md-2"><span class="text-muted">No. Telp:</span> <span id="detailPhone"></span></div>
                                <div class="col-12 mt-2"><span class="text-muted">Alamat:</span> <span id="detailAlamat"></span></div>
                            </div>
                        </div>
                    </div>
                </div>
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

            <hr>

            {{-- Harta / Inventaris (per tahun) --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-success border-bottom pb-2">
                        <i class="bi bi-building me-2"></i><span id="hartaLabel">Harta</span>
                        <button type="button" class="btn btn-sm btn-outline-success float-end" id="addHarta">
                            <i class="bi bi-plus-lg"></i> <span id="addHartaLabel">Tambah Harta</span>
                        </button>
                    </h6>
                </div>
            </div>
            <div id="hartaContainer" class="row g-3 mb-4">
                {{-- Dynamic rows inserted here --}}
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
                    <h6 class="fw-semibold text-warning border-bottom pb-2"><i class="bi bi-calendar-month me-2"></i>Omset Per Bulan</h6>
                </div>
                <div class="col-12">
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
                                    <div class="col-12">
                                        <div id="omsetResult-{{ $mo }}" class="p-3 rounded d-none"></div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
            </div>

            <hr class="mt-5">

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
                <button type="submit" class="btn btn-success px-4" id="btnSimpan" disabled>
                    <i class="bi bi-check-lg me-1"></i> Simpan
                </button>
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

$(document).ready(function() {
    $('#clientSelect').select2({
        placeholder: '-- Cari & Pilih Client --',
        allowClear: true,
        width: '100%'
    });
});

function getTipeName(tipeId) {
    const b = badanList.find(x => x.id === tipeId);
    return b ? b.tipe : '';
}

// --- Toggle buttons based on form completeness ---
function toggleButtons() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    const hasClient = !!clientId;

    const hartaFilled = document.querySelectorAll('#hartaContainer [name="harta_nama[]"]').length > 0
        && Array.from(document.querySelectorAll('#hartaContainer [name="harta_nama[]"]')).some(inp => inp.value.trim());

    const isId1 = !document.getElementById('omsetTahunanSection').classList.contains('d-none');
    const omsetTahunanVal = document.getElementById('omsetTahunan').value.replace(/[^0-9]/g, '') || '0';
    const omsetBulananFilled = Array.from(document.querySelectorAll('.omset-input')).some(inp => {
        return parseInt(inp.value.replace(/[^0-9]/g, '') || 0) > 0;
    });

    const hasOmset = isId1 ? parseInt(omsetTahunanVal) > 0 : omsetBulananFilled;
    const hasData = hasClient && (hartaFilled || hasOmset);

    document.getElementById('btnPreview').disabled = !hasData;
    document.getElementById('btnExportPdf').disabled = !hasData;
    document.getElementById('btnExportExcel').disabled = !hasData;
    document.getElementById('btnSimpan').disabled = !hasData;
}

// --- Reset form ---
function resetForm() {
    document.getElementById('hartaContainer').innerHTML = '';
    hartaIndex = 0;
    document.querySelectorAll('.omset-input').forEach(el => el.value = '');
    document.getElementById('omsetTahunan').value = '';
    for (let mo = 1; mo <= 12; mo++) {
        document.getElementById(`omsetResult-${mo}`).classList.add('d-none');
    }
    toggleButtons();
}

// --- Client Detail & Toggle Mode ---
document.getElementById('clientSelect').addEventListener('change', function() {
    const id = parseInt(this.value);
    const detail = document.getElementById('clientDetail');
    if (!id) {
        detail.classList.add('d-none');
        toggleButtons();
        return;
    }

    resetForm();

    const opt = this.options[this.selectedIndex];
    const tipeId = parseInt(opt.dataset.tipeId);
    const tipeName = getTipeName(tipeId);

    const c = clients.find(x => x.id === id);
    if (c) {
        document.getElementById('detailNama').textContent = c.nama_client;
        document.getElementById('detailNpwp').textContent = c.npwp || '-';
        document.getElementById('detailTipe').textContent = tipeName || '-';
        document.getElementById('detailKpp').textContent = c.kpp || '-';
        document.getElementById('detailPhone').textContent = c.no_telephone || '-';
        document.getElementById('detailAlamat').textContent = c.alamat || '-';
        detail.classList.remove('d-none');
    }

    const isId1 = tipeId === 1;
    document.getElementById('hartaLabel').textContent = isId1 ? 'Inventaris' : 'Harta';
    document.getElementById('addHartaLabel').textContent = isId1 ? 'Tambah Inventaris' : 'Tambah Harta';

    if (isId1) {
        document.getElementById('omsetTahunanSection').classList.remove('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
        for (let mo = 1; mo <= 12; mo++) {
            document.getElementById(`omsetResult-${mo}`).classList.add('d-none');
        }
    } else {
        document.getElementById('omsetTahunanSection').classList.add('d-none');
        document.getElementById('omsetBulananSection').classList.remove('d-none');
        hitungOmset();
    }

    loadDataFromDb();
});

// --- Load existing data from DB ---
function loadDataFromDb() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    const tahun = document.getElementById('tahunSelect').value;
    if (!clientId || !tahun) return;

    resetForm();

    fetch(`/admin/transaksi/load-data?client_id=${clientId}&tahun=${tahun}`)
        .then(res => {
            if (!res.ok) throw new Error('HTTP ' + res.status);
            return res.json();
        })
        .then(data => {
            if (!data.exists) return;

            const opt = document.querySelector(`#clientSelect option[value="${clientId}"]`);
            const tipeId = parseInt(opt.dataset.tipeId);
            const tipeName = getTipeName(tipeId);
            const c = clients.find(x => x.id === clientId);
            if (c) {
                document.getElementById('detailNama').textContent = c.nama_client;
                document.getElementById('detailNpwp').textContent = c.npwp || '-';
                document.getElementById('detailTipe').textContent = tipeName || '-';
                document.getElementById('detailKpp').textContent = c.kpp || '-';
                document.getElementById('detailPhone').textContent = c.no_telephone || '-';
                document.getElementById('detailAlamat').textContent = c.alamat || '-';
                document.getElementById('clientDetail').classList.remove('d-none');
            }

            const isId1 = tipeId === 1;
            document.getElementById('hartaLabel').textContent = isId1 ? 'Inventaris' : 'Harta';
            document.getElementById('addHartaLabel').textContent = isId1 ? 'Tambah Inventaris' : 'Tambah Harta';

            if (isId1) {
                document.getElementById('omsetTahunanSection').classList.remove('d-none');
                document.getElementById('omsetBulananSection').classList.add('d-none');
            } else {
                document.getElementById('omsetTahunanSection').classList.add('d-none');
                document.getElementById('omsetBulananSection').classList.remove('d-none');
            }

            // Load harta
            data.harta.forEach(h => {
                const isId1 = tipeId === 1;
                const label = isId1 ? 'Inventaris' : 'Harta';
                hartaIndex++;
                const div = document.createElement('div');
                div.className = 'col-md-6';
                div.innerHTML = `
                    <div class="card border h-100">
                        <div class="card-body py-3 px-4">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="small fw-semibold">${label} #${hartaIndex}</span>
                                <button type="button" class="btn btn-sm btn-outline-danger remove-row"><i class="bi bi-x-lg"></i></button>
                            </div>
                            <div class="row g-2">
                                <div class="col-7">
                                    <input type="text" class="form-control form-control-sm" name="harta_nama[]" value="${h.nama}" placeholder="Nama ${label.toLowerCase()}">
                                </div>
                                <div class="col-5">
                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text">Rp</span>
                                        <input type="text" class="form-control format-currency" name="harta_nilai[]" value="${Number(h.nilai).toLocaleString('id-ID')}" placeholder="Nilai">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>`;
                document.getElementById('hartaContainer').appendChild(div);
                attachRemove(div);
            });

            // Load omset
            if (isId1) {
                const omset = data.omset[0];
                if (omset) {
                    document.getElementById('omsetTahunan').value = Number(omset.nominal).toLocaleString('id-ID');
                }
            } else {
                data.omset.forEach(o => {
                    const input = document.querySelector(`.omset-input[data-month="${o.bulan}"]`);
                    if (input) {
                        input.value = Number(o.nominal).toLocaleString('id-ID');
                    }
                });
                hitungOmset();
            }

            toggleButtons();
        })
        .catch(err => console.error('Load data error:', err));
}

// --- Omset calculation per bulan ---
function hitungOmset() {
    const rumus = rumusList.find(r => String(r.tipe_badan) === '7');
    if (!rumus) {
        for (let mo = 1; mo <= 12; mo++) {
            document.getElementById(`omsetResult-${mo}`).classList.add('d-none');
        }
        return;
    }

    const maxVal = Number(rumus.max_value);
    const persen = Number(rumus.potongan_persentase);
    let cumulative = 0;

    for (let mo = 1; mo <= 12; mo++) {
        const val = document.querySelector(`.omset-input[data-month="${mo}"]`)?.value || '0';
        const current = Number(val.replace(/[^0-9]/g, '') || 0);
        const display = document.getElementById(`omsetResult-${mo}`);

        if (current === 0) {
            display.classList.add('d-none');
            cumulative += current;
            continue;
        }

        const totalWithCurrent = cumulative + current;
        let cumulativeStatus = '';
        let cumulativeClass = '';

        if (cumulative >= maxVal) {
            const potongan = current * persen / 100;
            cumulativeStatus = `Rp ${formatNum(String(potongan))}`;
            cumulativeClass = 'text-danger';
        } else if (totalWithCurrent > maxVal) {
            const kelebihan = totalWithCurrent - maxVal;
            const potongan = kelebihan * persen / 100;
            cumulativeStatus = `Rp ${formatNum(String(potongan))}`;
            cumulativeClass = 'text-warning';
        } else {
            cumulativeStatus = 'Free';
            cumulativeClass = 'text-success';
        }

        // PPH Final per bulan
        const pphStatus = current < 500 ? 'Free' : 'Rp ' + formatNum(String(current * persen / 100));

        display.className = 'p-3 rounded bg-light border';
        display.innerHTML = `
            <div class="row g-2">
                <div class="col-4">
                    <span class="text-muted small">Total Peredaran Bruto</span>
                    <div class="fw-semibold">Rp ${formatNum(String(totalWithCurrent))}</div>
                </div>
                <div class="col-4">
                    <span class="text-muted small">PPH Final 0.5%</span>
                    <div class="fw-semibold ${current < 500 ? 'text-success' : 'text-danger'}">${pphStatus}</div>
                </div>
                <div class="col-4">
                    <span class="text-muted small">PPh Final yang harus di bayar</span>
                    <div class="fw-semibold ${cumulativeClass}">
                        <i class="bi bi-${cumulative >= maxVal ? 'exclamation-triangle' : totalWithCurrent > maxVal ? 'exclamation-triangle' : 'check-circle'} me-1"></i>${cumulativeStatus}
                    </div>
                </div>
            </div>`;
        display.classList.remove('d-none');

        cumulative += current;
    }
}

document.getElementById('tahunSelect').addEventListener('change', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (clientId && this.value) {
        loadDataFromDb();
    }
});

document.querySelectorAll('.omset-input').forEach(input => {
    input.addEventListener('input', function() {
        hitungOmset();
        toggleButtons();
    });
});

// --- Harta Dynamic Rows ---
let hartaIndex = 0;
document.getElementById('addHarta').addEventListener('click', function() {
    hartaIndex++;
    const isId1 = !document.getElementById('omsetTahunanSection').classList.contains('d-none');
    const label = isId1 ? 'Inventaris' : 'Harta';
    const div = document.createElement('div');
    div.className = 'col-md-6';
    div.innerHTML = `
        <div class="card border h-100">
            <div class="card-body py-3 px-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <span class="small fw-semibold">${label} #${hartaIndex}</span>
                    <button type="button" class="btn btn-sm btn-outline-danger remove-row"><i class="bi bi-x-lg"></i></button>
                </div>
                <div class="row g-2">
                    <div class="col-7">
                        <input type="text" class="form-control form-control-sm" name="harta_nama[]" placeholder="Nama ${label.toLowerCase()}">
                    </div>
                    <div class="col-5">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">Rp</span>
                            <input type="text" class="form-control format-currency" name="harta_nilai[]" placeholder="Nilai">
                        </div>
                    </div>
                </div>
            </div>
        </div>`;
    document.getElementById('hartaContainer').appendChild(div);
    attachRemove(div);
    toggleButtons();
});

function attachRemove(el) {
    el.querySelector('.remove-row').addEventListener('click', function() {
        el.remove();
        toggleButtons();
    });
    el.querySelectorAll('input').forEach(inp => {
        inp.addEventListener('input', toggleButtons);
    });
}

// --- Preview ---
document.getElementById('btnPreview').addEventListener('click', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (!clientId) {
        alert('Pilih client terlebih dahulu.');
        return;
    }

    const tahun = document.getElementById('tahunSelect').value;
    if (!tahun) {
        alert('Pilih tahun terlebih dahulu.');
        return;
    }

    const client = clients.find(x => x.id === clientId);
    const opt = document.querySelector(`#clientSelect option[value="${clientId}"]`);
    const tipeId = parseInt(opt.dataset.tipeId);
    const tipeName = getTipeName(tipeId);
    const isId1 = tipeId === 1;

    const hartaLabel = isId1 ? 'Inventaris' : 'Harta';

    // Collect Harta (per tahun)
    const harta = [];
    document.querySelectorAll('#hartaContainer .card').forEach(card => {
        const nama = card.querySelector('[name="harta_nama[]"]').value;
        const nilai = card.querySelector('[name="harta_nilai[]"]').value || '0';
        if (nama) harta.push({ nama, nilai: Number(nilai.replace(/[^0-9]/g, '') || 0) });
    });

    // Collect Omset
    let totalOmset = 0;
    let omsetDetails = '';

    if (isId1) {
        const omsetVal = document.getElementById('omsetTahunan').value || '0';
        totalOmset = Number(omsetVal.replace(/[^0-9]/g, '') || 0);
        if (totalOmset > 0) {
            omsetDetails = `<tr><td class="text-muted">Tahunan</td><td class="text-end">Rp ${formatNum(String(totalOmset))}</td></tr>`;
        }
    } else {
        for (let mo = 1; mo <= 12; mo++) {
            const bulan = bulanList[mo - 1];
            const omsetVal = document.querySelector(`.omset-input[data-month="${mo}"]`)?.value || '0';
            const omsetNum = Number(omsetVal.replace(/[^0-9]/g, '') || 0);
            totalOmset += omsetNum;
            if (omsetNum > 0) {
                omsetDetails += `<tr><td class="text-muted ps-4">${bulan}</td><td class="text-end">Rp ${formatNum(String(omsetNum))}</td></tr>`;
            }
        }
    }

    let html = `
        <div class="mb-4">
            <h6 class="fw-semibold text-primary border-bottom pb-2">Data Client</h6>
            <table class="table table-sm small mb-0">
                <tr><td style="width:140px" class="text-muted">Nama</td><td class="fw-medium">${client.nama_client}</td></tr>
                <tr><td class="text-muted">NPWP</td><td>${client.npwp || '-'}</td></tr>
                <tr><td class="text-muted">Tipe</td><td>${tipeName || '-'}</td></tr>
                <tr><td class="text-muted">KPP</td><td>${client.kpp || '-'}</td></tr>
                <tr><td class="text-muted">No. Telp</td><td>${client.no_telephone || '-'}</td></tr>
                <tr><td class="text-muted">Alamat</td><td>${client.alamat || '-'}</td></tr>
                <tr><td class="text-muted">Periode</td><td class="fw-medium">Tahun ${tahun}</td></tr>
            </table>
        </div>`;

    if (harta.length) {
        html += `
            <div class="mb-4">
                <h6 class="fw-semibold text-success border-bottom pb-2">${hartaLabel}</h6>
                <table class="table table-sm small mb-0">
                    <thead><tr><th>Nama</th><th class="text-end">Nilai</th></tr></thead>
                    <tbody>
                        ${harta.map(h => `<tr><td>${h.nama}</td><td class="text-end">Rp ${formatNum(String(h.nilai))}</td></tr>`).join('')}
                    </tbody>
                </table>
            </div>`;
    }

    if (omsetDetails) {
        const title = isId1 ? 'Omset Tahunan' : 'Omset Per Bulan';
        html += `
            <div class="mb-4">
                <h6 class="fw-semibold text-warning border-bottom pb-2">${title}</h6>
                <table class="table table-sm small mb-0">
                    <thead><tr><th>${isId1 ? 'Periode' : 'Bulan'}</th><th class="text-end">Omset</th></tr></thead>
                    <tbody>
                        ${omsetDetails}
                        <tr class="fw-bold"><td>Total</td><td class="text-end">Rp ${formatNum(String(totalOmset))}</td></tr>
                    </tbody>
                </table>
            </div>`;
    }

    // Calculation result in preview
    if (!isId1) {
        const rumus = rumusList.find(r => String(r.tipe_badan) === '7');
        if (rumus) {
            const maxVal = Number(rumus.max_value);
            const persen = Number(rumus.potongan_persentase);
            let cumulative = 0;
            let totalPotongan = 0;
            let calcRows = '';

            for (let mo = 1; mo <= 12; mo++) {
                const bulan = bulanList[mo - 1];
                const omsetVal = document.querySelector(`.omset-input[data-month="${mo}"]`)?.value || '0';
                const current = Number(omsetVal.replace(/[^0-9]/g, '') || 0);
                if (current === 0) { cumulative += current; continue; }

                const totalWithCurrent = cumulative + current;
                let status, mark;
                let pphStatus, pphMark;

                if (cumulative >= maxVal) {
                    const potongan = current * persen / 100;
                    totalPotongan += potongan;
                    status = `Rp ${formatNum(String(potongan))}`;
                    mark = 'text-danger';
                } else if (totalWithCurrent > maxVal) {
                    const kelebihan = totalWithCurrent - maxVal;
                    const potongan = kelebihan * persen / 100;
                    totalPotongan += potongan;
                    status = `Rp ${formatNum(String(potongan))}`;
                    mark = 'text-warning';
                } else {
                    status = 'Free';
                    mark = 'text-success';
                }

                if (current < 500) {
                    pphStatus = 'Free';
                    pphMark = 'text-success';
                } else {
                    pphStatus = 'Rp ' + formatNum(String(current * persen / 100));
                    pphMark = 'text-danger';
                }

                calcRows += `<tr><td class="text-muted ps-4">${bulan}</td><td class="text-end">Rp ${formatNum(String(current))}</td><td class="text-end">Rp ${formatNum(String(totalWithCurrent))}</td><td class="text-end ${pphMark} fw-semibold">${pphStatus}</td><td class="text-end ${mark} fw-semibold">${status}</td></tr>`;
                cumulative += current;
            }

            html += `
                <div class="mb-4">
                    <h6 class="fw-semibold text-secondary border-bottom pb-2">Hasil Perhitungan Per Bulan</h6>
                    <table class="table table-sm small mb-0">
                        <thead><tr><th>Bulan</th><th class="text-end">Omset</th><th class="text-end">Total Peredaran Bruto</th><th class="text-end">PPH Final 0.5%</th><th class="text-end">PPh Final yg harus dibayar</th></tr></thead>
                        <tbody>
                            ${calcRows}
                            <tr class="fw-bold table-secondary">
                                <td>Total PPh Final yg harus dibayar</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="text-end text-danger">Rp ${formatNum(String(totalPotongan))}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>`;
        }
    }

    html += `
        <div class="mb-4">
            <h6 class="fw-semibold text-secondary border-bottom pb-2">Total Keseluruhan</h6>
            <table class="table table-sm small mb-0">
                <tr><td class="fw-semibold text-success">Total ${hartaLabel}</td><td class="text-end">Rp ${formatNum(String(harta.reduce((s, h) => s + h.nilai, 0)))}</td></tr>
                <tr><td class="fw-semibold text-warning">Total Omset</td><td class="text-end fw-bold">Rp ${formatNum(String(totalOmset))}</td></tr>
            </table>
        </div>`;

    document.getElementById('previewContent').innerHTML = html;

    const modal = new bootstrap.Modal(document.getElementById('previewModal'));
    modal.show();
});

// --- Format Rupiah otomatis ---
document.getElementById('formTransaksi').addEventListener('input', function(e) {
    if (e.target.classList.contains('format-currency')) {
        const cleaned = e.target.value.replace(/[^0-9]/g, '');
        e.target.value = cleaned ? parseInt(cleaned, 10).toLocaleString('id-ID') : '';
    }
    toggleButtons();
});

// --- Form submit ---
document.getElementById('formTransaksi').addEventListener('submit', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    const tahun = document.getElementById('tahunSelect').value;
    if (!clientId || !tahun) {
        alert('Pilih client dan tahun terlebih dahulu.');
        return false;
    }

    const opt = document.querySelector(`#clientSelect option[value="${clientId}"]`);
    const tipeId = parseInt(opt.dataset.tipeId);
    const isId1 = tipeId === 1;

    let totalOmset = 0;
    if (isId1) {
        const val = document.getElementById('omsetTahunan').value || '0';
        totalOmset = Number(val.replace(/[^0-9]/g, '') || 0);
    } else {
        for (let mo = 1; mo <= 12; mo++) {
            const val = document.querySelector(`.omset-input[data-month="${mo}"]`)?.value || '0';
            totalOmset += Number(val.replace(/[^0-9]/g, '') || 0);
        }
    }

    const rumus = rumusList.find(r => String(r.tipe_badan) === String(tipeId));
    const persen = rumus ? Number(rumus.potongan_persentase) : 0;
    const totalPph = totalOmset * persen / 100;

    document.getElementById('totalOmsetHidden').value = totalOmset;
    document.getElementById('totalPphHidden').value = totalPph;
});

function formatNum(v) {
    return Number(v.replace(/[^0-9]/g, '') || 0).toLocaleString('id-ID');
}

// --- Export buttons ---
document.getElementById('btnExportPdf').addEventListener('click', function() {
    const form = document.getElementById('formTransaksi');
    form.action = '{{ route("cms.transaksi.export-pdf") }}';
    form.submit();
    form.action = '{{ route("cms.transaksi.store") }}';
});

document.getElementById('btnExportExcel').addEventListener('click', function() {
    const form = document.getElementById('formTransaksi');
    form.action = '{{ route("cms.transaksi.export-excel") }}';
    form.submit();
    form.action = '{{ route("cms.transaksi.store") }}';
});
</script>
@endpush
