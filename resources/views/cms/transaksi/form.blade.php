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
        <form id="formTransaksi">
            @csrf

            {{-- Data Client --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-primary border-bottom pb-2"><i class="bi bi-person-badge me-2"></i>Data Client</h6>
                </div>
                <div class="col-md-8">
                    <label class="form-label fw-semibold small">Pilih Client <span class="text-danger">*</span></label>
                    <select id="clientSelect" class="form-select" required>
                        <option value="">-- Pilih Client --</option>
                        @foreach($clients as $c)
                            <option value="{{ $c->id }}" data-nama="{{ $c->nama_client }}" data-npwp="{{ $c->npwp }}" data-phone="{{ $c->no_telephone }}" data-alamat="{{ $c->alamat }}" data-kpp="{{ $c->kpp }}" data-tipe="{{ $c->tipe_badan }}">
                                {{ $c->nama_client }} — {{ $c->npwp ?: 'NPWP: -' }}
                            </option>
                        @endforeach
                    </select>
                </div>
            </div>

            {{-- Client Detail --}}
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

            {{-- Harta --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-success border-bottom pb-2">
                        <i class="bi bi-building me-2"></i>Harta
                        <button type="button" class="btn btn-sm btn-outline-success float-end" id="addHarta">
                            <i class="bi bi-plus-lg"></i> Tambah Harta
                        </button>
                    </h6>
                </div>
            </div>
            <div id="hartaContainer" class="row g-3 mb-4">
                {{-- Dynamic rows inserted here --}}
            </div>

            <hr>

            {{-- Omset --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-warning border-bottom pb-2"><i class="bi bi-graph-up-arrow me-2"></i>Omset</h6>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold small">Jumlah Omset</label>
                    <div class="input-group">
                        <span class="input-group-text">Rp</span>
                        <input type="text" id="omset" class="form-control format-currency" placeholder="0">
                    </div>
                </div>
            </div>

            <hr>

            {{-- Investasi --}}
            <div class="row g-4 mb-4">
                <div class="col-12">
                    <h6 class="fw-semibold text-info border-bottom pb-2">
                        <i class="bi bi-pie-chart me-2"></i>Investasi
                        <button type="button" class="btn btn-sm btn-outline-info float-end" id="addInvestasi">
                            <i class="bi bi-plus-lg"></i> Tambah Investasi
                        </button>
                    </h6>
                </div>
            </div>
            <div id="investasiContainer" class="row g-3 mb-4">
                {{-- Dynamic rows inserted here --}}
            </div>

            <hr class="mt-5">

            {{-- Actions --}}
            <div class="d-flex justify-content-end gap-2 pt-3">
                <button type="reset" class="btn btn-light">Reset</button>
                <button type="button" class="btn btn-primary px-4" id="btnPreview">
                    <i class="bi bi-eye me-1"></i> Preview
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
                {{-- filled by JS --}}
            </div>
            <div class="modal-footer border-top">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Tutup</button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
const clients = @json($clients);
const rumusList = @json($rumus);

// --- Client Detail ---
document.getElementById('clientSelect').addEventListener('change', function() {
    const id = parseInt(this.value);
    const detail = document.getElementById('clientDetail');

    if (!id) {
        detail.classList.add('d-none');
        return;
    }

    const c = clients.find(x => x.id === id);
    if (c) {
        document.getElementById('detailNama').textContent = c.nama_client;
        document.getElementById('detailNpwp').textContent = c.npwp || '-';
        document.getElementById('detailTipe').textContent = c.tipe_badan || '-';
        document.getElementById('detailKpp').textContent = c.kpp || '-';
        document.getElementById('detailPhone').textContent = c.no_telephone || '-';
        document.getElementById('detailAlamat').textContent = c.alamat || '-';
        detail.classList.remove('d-none');
    }
});

// --- Harta Dynamic Rows ---
let hartaIndex = 0;
document.getElementById('addHarta').addEventListener('click', function() {
    hartaIndex++;
    const div = document.createElement('div');
    div.className = 'col-md-6';
    div.innerHTML = `
        <div class="card border h-100">
            <div class="card-body py-3 px-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <span class="small fw-semibold">Harta #${hartaIndex}</span>
                    <button type="button" class="btn btn-sm btn-outline-danger remove-row"><i class="bi bi-x-lg"></i></button>
                </div>
                <div class="row g-2">
                    <div class="col-7">
                        <input type="text" class="form-control form-control-sm" name="harta_nama[]" placeholder="Nama harta">
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
});

// --- Investasi Dynamic Rows ---
let investasiIndex = 0;
document.getElementById('addInvestasi').addEventListener('click', function() {
    investasiIndex++;
    const div = document.createElement('div');
    div.className = 'col-md-6';
    div.innerHTML = `
        <div class="card border h-100">
            <div class="card-body py-3 px-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <span class="small fw-semibold">Investasi #${investasiIndex}</span>
                    <button type="button" class="btn btn-sm btn-outline-danger remove-row"><i class="bi bi-x-lg"></i></button>
                </div>
                <div class="row g-2">
                    <div class="col-7">
                        <input type="text" class="form-control form-control-sm" name="investasi_nama[]" placeholder="Nama investasi">
                    </div>
                    <div class="col-5">
                        <div class="input-group input-group-sm">
                            <span class="input-group-text">Rp</span>
                            <input type="text" class="form-control format-currency" name="investasi_nilai[]" placeholder="Nilai">
                        </div>
                    </div>
                </div>
            </div>
        </div>`;
    document.getElementById('investasiContainer').appendChild(div);
    attachRemove(div);
});

function attachRemove(el) {
    el.querySelector('.remove-row').addEventListener('click', function() {
        el.remove();
    });
}

// --- Preview ---
document.getElementById('btnPreview').addEventListener('click', function() {
    const clientId = parseInt(document.getElementById('clientSelect').value);
    if (!clientId) {
        alert('Pilih client terlebih dahulu.');
        return;
    }

    const client = clients.find(x => x.id === clientId);
    const omset = document.getElementById('omset').value || '0';

    // Collect harta
    const harta = [];
    document.querySelectorAll('#hartaContainer .card').forEach(card => {
        const nama = card.querySelector('[name="harta_nama[]"]').value;
        const nilai = card.querySelector('[name="harta_nilai[]"]').value || '0';
        if (nama) harta.push({ nama, nilai });
    });

    // Collect investasi
    const investasi = [];
    document.querySelectorAll('#investasiContainer .card').forEach(card => {
        const nama = card.querySelector('[name="investasi_nama[]"]').value;
        const nilai = card.querySelector('[name="investasi_nilai[]"]').value || '0';
        if (nama) investasi.push({ nama, nilai });
    });

    // Build preview HTML
    let html = `
        <div class="mb-4">
            <h6 class="fw-semibold text-primary border-bottom pb-2">Data Client</h6>
            <table class="table table-sm small mb-0">
                <tr><td style="width:140px" class="text-muted">Nama</td><td class="fw-medium">${client.nama_client}</td></tr>
                <tr><td class="text-muted">NPWP</td><td>${client.npwp || '-'}</td></tr>
                <tr><td class="text-muted">Tipe</td><td>${client.tipe_badan || '-'}</td></tr>
                <tr><td class="text-muted">KPP</td><td>${client.kpp || '-'}</td></tr>
                <tr><td class="text-muted">No. Telp</td><td>${client.no_telephone || '-'}</td></tr>
                <tr><td class="text-muted">Alamat</td><td>${client.alamat || '-'}</td></tr>
            </table>
        </div>`;

    if (harta.length) {
        html += `
            <div class="mb-4">
                <h6 class="fw-semibold text-success border-bottom pb-2">Harta</h6>
                <table class="table table-sm small mb-0">
                    <thead><tr><th>Nama</th><th class="text-end">Nilai</th></tr></thead>
                    <tbody>
                        ${harta.map(h => `<tr><td>${h.nama}</td><td class="text-end">Rp ${formatNum(h.nilai)}</td></tr>`).join('')}
                    </tbody>
                </table>
            </div>`;
    }

    html += `
        <div class="mb-4">
            <h6 class="fw-semibold text-warning border-bottom pb-2">Omset</h6>
            <p class="fw-bold mb-0">Rp ${formatNum(omset)}</p>
        </div>`;

    if (investasi.length) {
        html += `
            <div class="mb-4">
                <h6 class="fw-semibold text-info border-bottom pb-2">Investasi</h6>
                <table class="table table-sm small mb-0">
                    <thead><tr><th>Nama</th><th class="text-end">Nilai</th></tr></thead>
                    <tbody>
                        ${investasi.map(i => `<tr><td>${i.nama}</td><td class="text-end">Rp ${formatNum(i.nilai)}</td></tr>`).join('')}
                    </tbody>
                </table>
            </div>`;
    }

    // Hitung total investasi
    let totalInvestasi = 0;
    investasi.forEach(i => {
        totalInvestasi += Number(i.nilai.replace(/[^0-9]/g, '') || 0);
    });

    // Cari rumus berdasarkan tipe badan client
    const rumus = rumusList.find(r => r.tipe_badan === client.tipe_badan);

    if (rumus) {
        const maxVal = Number(rumus.max_value);
        const persen = Number(rumus.potongan_persentase);
        let kelebihan = 0, potongan = 0, free = false;
        if (totalInvestasi > maxVal) {
            kelebihan = totalInvestasi - maxVal;
            potongan = kelebihan * persen / 100;
        } else {
            free = true;
        }
        html += `
            <div class="mb-4">
                <h6 class="fw-semibold text-secondary border-bottom pb-2">Perhitungan Master Rumus</h6>
                <table class="table table-sm small mb-0">
                    <tr><td style="width:140px" class="text-muted">Total Investasi</td><td class="fw-medium">Rp ${formatNum(String(totalInvestasi))}</td></tr>
                    <tr><td class="text-muted">Max Value</td><td>Rp ${formatNum(String(maxVal))}</td></tr>` +
                    (free ? `<tr><td class="text-muted">Status</td><td class="text-success fw-semibold">Free</td></tr>`
                    : `<tr><td class="text-muted">Kelebihan</td><td>Rp ${formatNum(String(kelebihan))}</td></tr>
                    <tr><td class="text-muted">Potongan Persentase</td><td>${persen}%</td></tr>
                    <tr><td class="text-muted">Potongan</td><td class="text-danger fw-semibold">Rp ${formatNum(String(potongan))}</td></tr>`) +
                `</table>
            </div>`;
    }

    document.getElementById('previewContent').innerHTML = html;

    const modal = new bootstrap.Modal(document.getElementById('previewModal'));
    modal.show();
});

function formatNum(v) {
    return Number(v.replace(/[^0-9]/g, '') || 0).toLocaleString('id-ID');
}
</script>
@endpush
