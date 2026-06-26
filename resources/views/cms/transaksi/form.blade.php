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
                            <option value="{{ $c->id }}" data-nama="{{ $c->nama_client }}" data-npwp="{{ $c->npwp }}" data-phone="{{ $c->no_telephone }}" data-alamat-npwp="{{ $c->alamat_npwp }}" data-kpp="{{ $c->kpp }}" data-tipe-id="{{ $c->tipe_badan }}">
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
                                <div class="col-12 mt-2"><span class="text-muted">Alamat NPWP:</span> <span id="detailAlamatNpwp"></span></div>
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

            {{-- Lampiran SPT Tahunan --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-success border-bottom pb-2">
                        <i class="bi bi-building me-2"></i>Harta / Aktiva
                        <a href="{{ route('cms.lampiran-spt.index') }}?client_id={{ old('client_id', '') }}&tahun={{ old('tahun', date('Y')) }}"
                           class="btn btn-sm btn-outline-primary float-end" id="btnLampiranSpt" target="_blank">
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
                    <h6 class="fw-semibold text-warning border-bottom pb-2">
                        <i class="bi bi-calendar-month me-2"></i>Omset Per Bulan
                        <button type="button" class="btn btn-sm btn-outline-warning float-end" id="toggleOmsetInput">
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
                    <h6 class="fw-semibold text-info border-bottom pb-2">
                        <i class="bi bi-table me-2"></i>Hasil Perhitungan Per Bulan
                        <button type="button" class="btn btn-sm btn-outline-info float-end" id="toggleHasilTable">
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
                                    <th class="text-end">Omset</th>
                                    <th class="text-end">Total Peredaran Bruto</th>
                                    <th class="text-end">PPH Final 0.5%</th>
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
                                    <td class="text-end" id="hasilPph-{{ $i + 1 }}">-</td>
                                    <td class="text-end" id="hasilFinal-{{ $i + 1 }}">-</td>
                                    <td class="text-center" id="hasilStatus-{{ $i + 1 }}">-</td>
                                </tr>
                                @endforeach
                                <tr class="fw-bold table-secondary" id="hasilTotalRow">
                                    <td>Total PPh Final yg harus dibayar</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td class="text-end text-danger" id="hasilTotalPph">Rp 0</td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
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

    const isId1 = !document.getElementById('omsetTahunanSection').classList.contains('d-none');
    const omsetTahunanVal = document.getElementById('omsetTahunan').value.replace(/[^0-9]/g, '') || '0';
    const omsetBulananFilled = Array.from(document.querySelectorAll('.omset-input')).some(inp => {
        return parseInt(inp.value.replace(/[^0-9]/g, '') || 0) > 0;
    });

    const hasOmset = isId1 ? parseInt(omsetTahunanVal) > 0 : omsetBulananFilled;
    const hasData = hasClient && hasOmset;

    document.getElementById('btnPreview').disabled = !hasData;
    document.getElementById('btnExportPdf').disabled = !hasData;
    document.getElementById('btnExportExcel').disabled = !hasData;
    document.getElementById('btnSimpan').disabled = !hasData;
}

// --- Reset form ---
function resetForm() {
    document.querySelectorAll('.omset-input').forEach(el => el.value = '');
    document.getElementById('omsetTahunan').value = '';
    for (let mo = 1; mo <= 12; mo++) {
        document.getElementById(`hasilRow-${mo}`).classList.add('d-none');
    }
    document.getElementById('hasilPerhitunganSection').classList.add('d-none');
    document.getElementById('hasilTotalPph').textContent = 'Rp 0';
    let alert4M = document.getElementById('alert4M');
    if (alert4M) alert4M.remove();
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
        document.getElementById('detailAlamatNpwp').textContent = c.alamat_npwp || '-';
        detail.classList.remove('d-none');
    }

    const lampiranUrl = document.getElementById('btnLampiranSpt').href.split('?')[0];
    document.getElementById('btnLampiranSpt').href = lampiranUrl + '?client_id=' + id + '&tahun=' + (document.getElementById('tahunSelect').value || '{{ date("Y") }}');

    const isId1 = tipeId === 1;

    if (isId1) {
        document.getElementById('omsetTahunanSection').classList.remove('d-none');
        document.getElementById('omsetBulananSection').classList.add('d-none');
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
                document.getElementById('detailAlamatNpwp').textContent = c.alamat_npwp || '-';
                document.getElementById('clientDetail').classList.remove('d-none');
            }

            const isId1 = tipeId === 1;

            if (isId1) {
                document.getElementById('omsetTahunanSection').classList.remove('d-none');
                document.getElementById('omsetBulananSection').classList.add('d-none');
            } else {
                document.getElementById('omsetTahunanSection').classList.add('d-none');
                document.getElementById('omsetBulananSection').classList.remove('d-none');
            }

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

// --- Toggle Omset Input ---
document.getElementById('toggleOmsetInput').addEventListener('click', function() {
    const container = document.getElementById('omsetInputContainer');
    const isHidden = container.classList.toggle('d-none');
    this.querySelector('i').className = isHidden ? 'bi bi-eye me-1' : 'bi bi-eye-slash me-1';
    document.getElementById('toggleOmsetInputLabel').textContent = isHidden ? 'Tampilkan' : 'Sembunyikan';
});

// --- Toggle Hasil Perhitungan Table ---
document.getElementById('toggleHasilTable').addEventListener('click', function() {
    const container = document.getElementById('hasilTableContainer');
    const isHidden = container.classList.toggle('d-none');
    this.querySelector('i').className = isHidden ? 'bi bi-eye me-1' : 'bi bi-eye-slash me-1';
    document.getElementById('toggleHasilTableLabel').textContent = isHidden ? 'Tampilkan' : 'Sembunyikan';
});

// --- Omset calculation per bulan ---
function hitungOmset() {
    const rumus = rumusList.find(r => String(r.tipe_badan) === '7');
    const maxVal = Number(rumus?.max_value || 0);
    const persen = Number(rumus?.potongan_persentase || 0);
    const LIMIT_400JT = 400000000;
    const LIMIT_4M = 4000000000;

    let cumulative = 0;
    let totalPotongan = 0;
    let cumulativeExceeds4M = false;

    for (let mo = 1; mo <= 12; mo++) {
        const val = document.querySelector(`.omset-input[data-month="${mo}"]`)?.value || '0';
        const current = Number(val.replace(/[^0-9]/g, '') || 0);
        const row = document.getElementById(`hasilRow-${mo}`);

        if (current === 0) {
            row.classList.add('d-none');
            cumulative += current;
            continue;
        }

        const totalWithCurrent = cumulative + current;

        // --- Validasi > 400jt per bulan (Item 6) ---
        const exceeds400 = current > LIMIT_400JT;
        const omsetCell = document.getElementById(`hasilOmset-${mo}`);
        if (exceeds400) {
            omsetCell.innerHTML = `<span class="text-danger fw-bold"><i class="bi bi-exclamation-triangle-fill me-1"></i>Rp ${formatNum(String(current))} <span class="badge bg-danger ms-1">>400JT</span></span>`;
        } else {
            omsetCell.textContent = 'Rp ' + formatNum(String(current));
        }

        // --- Validasi akumulasi 4 Milyar (Item 7) ---
        if (totalWithCurrent >= LIMIT_4M) {
            cumulativeExceeds4M = true;
        }

        // --- PPh Calculation ---
        let finalStatus = '';
        let finalClass = '';

        if (rumus) {
            if (cumulative >= maxVal) {
                const potongan = current * persen / 100;
                totalPotongan += potongan;
                finalStatus = `Rp ${formatNum(String(potongan))}`;
                finalClass = 'text-danger';
            } else if (totalWithCurrent > maxVal) {
                const kelebihan = totalWithCurrent - maxVal;
                const potongan = kelebihan * persen / 100;
                totalPotongan += potongan;
                finalStatus = `Rp ${formatNum(String(potongan))}`;
                finalClass = 'text-warning';
            } else {
                finalStatus = 'Free';
                finalClass = 'text-success';
            }
        } else {
            finalStatus = '-';
            finalClass = '';
        }

        const pphStatus = !rumus ? '-' : (current < 500 ? 'Free' : 'Rp ' + formatNum(String(current * persen / 100)));

        // --- Populate table ---
        document.getElementById(`hasilBruto-${mo}`).textContent = 'Rp ' + formatNum(String(totalWithCurrent));
        document.getElementById(`hasilPph-${mo}`).innerHTML = pphStatus === 'Free'
            ? '<span class="text-success">Free</span>'
            : '<span class="text-danger fw-semibold">' + pphStatus + '</span>';
        document.getElementById(`hasilFinal-${mo}`).innerHTML = `<span class="fw-semibold ${finalClass}">${finalStatus}</span>`;

        // Status column
        const statusCell = document.getElementById(`hasilStatus-${mo}`);
        let statusIcons = '';
        if (exceeds400) statusIcons += '<span class="text-danger" title="Omset > 400 Juta"><i class="bi bi-exclamation-triangle-fill"></i></span>';
        if (totalWithCurrent >= LIMIT_4M) statusIcons += ' <span class="text-danger" title="Akumulasi >= 4 Milyar"><i class="bi bi-arrow-up-circle-fill"></i></span>';
        if (!statusIcons) statusIcons = '<span class="text-success"><i class="bi bi-check-circle"></i></span>';
        statusCell.innerHTML = statusIcons;

        row.classList.remove('d-none');
        cumulative += current;
    }

    // Total Row
    document.getElementById('hasilTotalPph').textContent = 'Rp ' + formatNum(String(totalPotongan));

    // Show/hide section
    const hasData = cumulative > 0;
    document.getElementById('hasilPerhitunganSection').classList.toggle('d-none', !hasData);
    if (hasData) {
        document.getElementById('omsetBulananSection').classList.remove('d-none');
    }

    // Alert for cumulative > 4 Milyar
    let existingAlert = document.getElementById('alert4M');
    if (cumulativeExceeds4M) {
        if (!existingAlert) {
            const alertDiv = document.createElement('div');
            alertDiv.id = 'alert4M';
            alertDiv.className = 'alert alert-danger d-flex align-items-center gap-2 py-2 mb-3';
            alertDiv.innerHTML = '<i class="bi bi-exclamation-triangle-fill"></i> <strong>Perhatian!</strong> Omset telah mencapai atau melebihi <strong>Rp 4.000.000.000</strong>.';
            document.getElementById('omsetBulananSection').querySelector('.border-bottom').after(alertDiv);
        }
    } else if (existingAlert) {
        existingAlert.remove();
    }
}

document.getElementById('tahunSelect').addEventListener('change', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (clientId && this.value) {
        const lampiranUrl = document.getElementById('btnLampiranSpt').href.split('?')[0];
        document.getElementById('btnLampiranSpt').href = lampiranUrl + '?client_id=' + clientId + '&tahun=' + this.value;
        loadDataFromDb();
    }
});

document.querySelectorAll('.omset-input').forEach(input => {
    input.addEventListener('input', function() {
        hitungOmset();
        toggleButtons();
    });
});

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
                <tr><td class="text-muted">Alamat NPWP</td><td>${client.alamat_npwp || '-'}</td></tr>
                <tr><td class="text-muted">Periode</td><td class="fw-medium">Tahun ${tahun}</td></tr>
            </table>
        </div>`;

    if (omsetDetails && isId1) {
        html += `
            <div class="mb-4">
                <h6 class="fw-semibold text-warning border-bottom pb-2">Omset Tahunan</h6>
                <table class="table table-sm small mb-0">
                    <thead><tr><th>Periode</th><th class="text-end">Omset</th></tr></thead>
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
        const maxVal = Number(rumus?.max_value || 0);
        const persen = Number(rumus?.potongan_persentase || 0);
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

    html += `
        <div class="mb-4">
            <h6 class="fw-semibold text-secondary border-bottom pb-2">Total Keseluruhan</h6>
            <table class="table table-sm small mb-0">
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
