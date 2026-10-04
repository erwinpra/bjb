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
                        <i class="bi bi-pencil-square me-1"></i> Semua
                    </button>
                </li>
                {{-- Tab per kategori dihapus: diganti satu tabel gabungan section per kategori di tab Semua --}}
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
                                        <small class="text-muted d-block mt-1">
                                            <i class="bi bi-info-circle me-1"></i>
                                            Data akan diimport ke client & tahun yang dipilih di atas. Urutan kolom bebas, asal nama header sesuai.
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

                    @php $masterByKode = $masterItems->keyBy('sub_kode'); @endphp
                    {{-- Form hidden: dipakai JS simpan (per kategori & simpan semua) untuk client_id/tahun/action --}}
                    <form method="POST" action="{{ route('cms.lampiran-spt.store') }}" id="formLampiran" onsubmit="return false;">
                        @csrf
                        <input type="hidden" name="client_id" value="{{ $clientId }}">
                        <input type="hidden" name="tahun" value="{{ $tahun }}">
                    </form>

                    {{-- Toolbar global tabel gabungan --}}
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-outline-secondary btn-sm" id="btnExpandAll">
                                <i class="bi bi-arrows-expand me-1"></i> Buka Semua
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm" id="btnCollapseAll">
                                <i class="bi bi-arrows-collapse me-1"></i> Tutup Semua
                            </button>
                        </div>
                        @cmsCan('lampiran_spt', 'create')
                        <button type="button" class="btn btn-primary btn-sm px-3" id="btnSimpanSemua">
                            <i class="bi bi-save me-1"></i> Simpan Semua Kategori
                        </button>
                        @endCmsCan
                    </div>

                    {{-- Tabel generik dihapus: diganti tabel gabungan section per kategori di bawah --}}

                {{-- Satu tabel gabungan: section per kategori, title full-width (colspan) + expand/collapse.
                     Struktur kolom tiap section sama seperti tabel per kategori sebelumnya. --}}
                @foreach($detailsByKategori ?? [] as $dbk)
                @php $katId = (int) $dbk['kategori']->id; $items = $dbk['items']; $katCollapseId = 'kat-collapse-' . $katId; @endphp
                <div class="card border mb-3 kat-section">
                    <div class="card-header py-2 collapse-toggle kat-title"
                         role="button" data-bs-toggle="collapse"
                         data-bs-target="#{{ $katCollapseId }}" aria-expanded="true"
                         style="background-color:#212529; color:#fff; cursor:pointer;">
                        <h6 class="fw-semibold mb-0 d-flex justify-content-between align-items-center">
                            <span><i class="bi bi-chevron-down collapse-icon me-2"></i>{{ $dbk['kategori']->label }}
                                <span class="badge bg-secondary ms-2">{{ $dbk['count'] }} data</span>
                            </span>
                            <span class="badge bg-primary">Total: Rp {{ number_format($dbk['total'], 0, ',', '.') }}</span>
                        </h6>
                    </div>
                    <div class="collapse show kat-collapse" id="{{ $katCollapseId }}">
                        <div class="p-2">
                    <div class="table-responsive">
                        @if($katId === 1)
                        {{-- KAS: NOMOR AKUN, ATAS NAMA, BANK, LOKASI, THN, SALDO --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>DESKRIPSI</th><th>NOMOR AKUN</th><th>ATAS NAMA</th><th>BANK/INSTITUSI</th><th>LOKASI</th><th>THN</th><th class="text-end">SALDO SAAT INI</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td><span class="field-display">{{ $masterByKode[$d->kode]->nama ?? ($d->deskripsi ?: '-') }}</span><input type="text" class="cell-input cell-edit d-none" data-field="deskripsi" value="{{ $d->deskripsi }}" readonly></td>
                                    <td><span class="field-display">{{ $d->nomor_akun ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nomor_akun" value="{{ $d->nomor_akun }}"></td>
                                    <td><span class="field-display">{{ $d->atas_nama ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="atas_nama" value="{{ $d->atas_nama }}"></td>
                                    <td><span class="field-display">{{ $d->nama_bank_institusi ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"></td>
                                    <td><span class="field-display">{{ $d->lokasi_harta ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"></td>
                                    <td><span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_perolehan"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="harga_perolehan" value="{{ $d->harga_perolehan }}"><input type="hidden" data-field="merk_tipe" value="{{ $d->merk_tipe }}"><input type="hidden" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"><input type="hidden" data-field="kepemilikan" value="{{ $d->kepemilikan }}"><input type="hidden" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"><input type="hidden" data-field="nama_pihak" value="{{ $d->nama_pihak }}"><input type="hidden" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"><input type="hidden" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"><input type="hidden" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"><input type="hidden" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}"><input type="hidden" data-field="detail_info" value="{{ $d->detail_info }}"><input type="hidden" data-field="tahun_mulai" value="{{ $d->tahun_mulai }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="9" class="text-center text-muted py-4">Belum ada data KAS. Import sheet 01 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @elseif($katId === 2)
                        {{-- PIUTANG: LOKASI PENERIMA, NIK/NPWP, NAMA, THN MULAI, NILAI --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>DESKRIPSI</th><th>LOKASI PENERIMA</th><th>NIK/NPWP</th><th>NAMA PENERIMA</th><th>THN MULAI</th><th class="text-end">NILAI SAAT INI</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td><span class="field-display">{{ $masterByKode[$d->kode]->nama ?? ($d->deskripsi ?: '-') }}</span><input type="text" class="cell-input cell-edit d-none" data-field="deskripsi" value="{{ $d->deskripsi }}" readonly></td>
                                    <td><span class="field-display">{{ $d->lokasi_harta ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"></td>
                                    <td><span class="field-display"><code>{{ $d->nik_npwp_pihak ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->nama_pihak ?: $d->atas_nama ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nama_pihak" value="{{ $d->nama_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->tahun_mulai ?: $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_mulai"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ ($d->tahun_mulai ?: $d->tahun_perolehan) == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="nomor_akun" value="{{ $d->nomor_akun }}"><input type="hidden" data-field="atas_nama" value="{{ $d->atas_nama }}"><input type="hidden" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"><input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="tahun_perolehan" value="{{ $d->tahun_perolehan }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="harga_perolehan" value="{{ $d->harga_perolehan }}"><input type="hidden" data-field="merk_tipe" value="{{ $d->merk_tipe }}"><input type="hidden" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"><input type="hidden" data-field="kepemilikan" value="{{ $d->kepemilikan }}"><input type="hidden" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"><input type="hidden" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"><input type="hidden" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"><input type="hidden" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}"><input type="hidden" data-field="detail_info" value="{{ $d->detail_info }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="8" class="text-center text-muted py-4">Belum ada data PIUTANG. Import sheet 02 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @elseif($katId === 3)
                        {{-- INVESTASI: LOKASI, NPWP, NAMA, NOMOR AKUN, HARGA, THN, NILAI --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>DESKRIPSI</th><th>LOKASI</th><th>NPWP</th><th>NAMA INSTITUSI</th><th>NOMOR AKUN</th><th>THN</th><th class="text-end">HARGA PEROLEHAN</th><th class="text-end">NILAI SAAT INI</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td><span class="field-display">{{ $masterByKode[$d->kode]->nama ?? ($d->deskripsi ?: '-') }}</span><input type="text" class="cell-input cell-edit d-none" data-field="deskripsi" value="{{ $d->deskripsi }}" readonly></td>
                                    <td><span class="field-display">{{ $d->lokasi_harta ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"></td>
                                    <td><span class="field-display"><code>{{ $d->nik_npwp_pihak ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->nama_pihak ?: $d->merk_tipe ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nama_pihak" value="{{ $d->nama_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->nomor_akun ?: $d->nopol_sertifikat ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nomor_akun" value="{{ $d->nomor_akun }}"></td>
                                    <td><span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_perolehan"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display text-end">{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="harga_perolehan" value="{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '' }}"></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="atas_nama" value="{{ $d->atas_nama }}"><input type="hidden" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"><input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="merk_tipe" value="{{ $d->merk_tipe }}"><input type="hidden" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"><input type="hidden" data-field="kepemilikan" value="{{ $d->kepemilikan }}"><input type="hidden" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"><input type="hidden" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"><input type="hidden" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"><input type="hidden" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}"><input type="hidden" data-field="detail_info" value="{{ $d->detail_info }}"><input type="hidden" data-field="tahun_mulai" value="{{ $d->tahun_mulai }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="10" class="text-center text-muted py-4">Belum ada data INVESTASI. Import sheet 03 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @elseif($katId === 4)
                        {{-- HARTA BERGERAK: MERK/TIPE, NOPOL, KEPEMILIKAN, NIK/NPWP, NAMA, TAHUN, HARGA, NILAI --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>MERK/TIPE</th><th>NOPOL/REGISTRASI</th><th>KEPEMILIKAN</th><th>NIK/NPWP</th><th>NAMA</th><th>TAHUN</th><th class="text-end">HARGA</th><th class="text-end">NILAI</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                        <input type="hidden" data-field="deskripsi" value="{{ $d->deskripsi }}">
                                    </td>
                                    <td><span class="field-display">{{ $d->merk_tipe ?: $d->deskripsi ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="merk_tipe" value="{{ $d->merk_tipe }}"></td>
                                    <td><span class="field-display"><code>{{ $d->nopol_sertifikat ?: $d->nomor_akun ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"></td>
                                    <td><span class="field-display">{{ $d->kepemilikan ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="kepemilikan" value="{{ $d->kepemilikan }}"></td>
                                    <td><span class="field-display"><code>{{ $d->nik_npwp_pihak ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->nama_pihak ?: $d->atas_nama ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nama_pihak" value="{{ $d->nama_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_perolehan"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display text-end">{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="harga_perolehan" value="{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '' }}"></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="nomor_akun" value="{{ $d->nomor_akun }}"><input type="hidden" data-field="atas_nama" value="{{ $d->atas_nama }}"><input type="hidden" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"><input type="hidden" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"><input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"><input type="hidden" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"><input type="hidden" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"><input type="hidden" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}"><input type="hidden" data-field="detail_info" value="{{ $d->detail_info }}"><input type="hidden" data-field="tahun_mulai" value="{{ $d->tahun_mulai }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="10" class="text-center text-muted py-4">Belum ada data HARTA BERGERAK. Import sheet 04 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @elseif($katId === 5)
                        {{-- HARTA TIDAK BERGERAK: LOKASI, DETAIL, TANAH, BANGUNAN, SUMBER, SERTIFIKAT, TAHUN, HARGA, NILAI --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>DESKRIPSI</th><th>LOKASI</th><th>DETAIL</th><th>TANAH</th><th>BANGUNAN</th><th>SUMBER</th><th>SERTIFIKAT</th><th>THN</th><th class="text-end">HARGA</th><th class="text-end">NILAI</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td><span class="field-display">{{ $masterByKode[$d->kode]->nama ?? ($d->deskripsi ?: '-') }}</span><input type="text" class="cell-input cell-edit d-none" data-field="deskripsi" value="{{ $d->deskripsi }}" readonly></td>
                                    <td><span class="field-display">{{ $d->lokasi_harta ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"></td>
                                    <td><span class="field-display small">{{ $d->detail_info ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="detail_info" value="{{ $d->detail_info }}"></td>
                                    <td><span class="field-display">{{ $d->ukuran_tanah ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"></td>
                                    <td><span class="field-display">{{ $d->ukuran_bangunan ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"></td>
                                    <td><span class="field-display">{{ $d->sumber_kepemilikan ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}"></td>
                                    <td><span class="field-display"><code>{{ $d->nopol_sertifikat ?: $d->nomor_akun ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"></td>
                                    <td><span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_perolehan"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display text-end">{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="harga_perolehan" value="{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '' }}"></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="nomor_akun" value="{{ $d->nomor_akun }}"><input type="hidden" data-field="atas_nama" value="{{ $d->atas_nama }}"><input type="hidden" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"><input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="merk_tipe" value="{{ $d->merk_tipe }}"><input type="hidden" data-field="kepemilikan" value="{{ $d->kepemilikan }}"><input type="hidden" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"><input type="hidden" data-field="nama_pihak" value="{{ $d->nama_pihak }}"><input type="hidden" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"><input type="hidden" data-field="tahun_mulai" value="{{ $d->tahun_mulai }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="12" class="text-center text-muted py-4">Belum ada data HARTA TIDAK BERGERAK. Import sheet 05 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @elseif($katId === 7)
                        {{-- HUTANG: NIK/NPWP, NAMA, NEGARA, TAHUN, NILAI, KETERANGAN --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>DESKRIPSI</th><th>NIK/NPWP</th><th>NAMA PEMBERI</th><th>NEGARA</th><th>THN PINJAM</th><th class="text-end">NILAI</th><th>KETERANGAN</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td><span class="field-display">{{ $masterByKode[$d->kode]->nama ?? ($d->deskripsi ?: '-') }}</span><input type="text" class="cell-input cell-edit d-none" data-field="deskripsi" value="{{ $d->deskripsi }}" readonly></td>
                                    <td><span class="field-display"><code>{{ $d->nik_npwp_pihak ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->nama_pihak ?: $d->atas_nama ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="nama_pihak" value="{{ $d->nama_pihak }}"></td>
                                    <td><span class="field-display">{{ $d->negara_kreditur ?: $d->lokasi_harta ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"></td>
                                    <td><span class="field-display">{{ $d->tahun_mulai ?: $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_mulai"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ ($d->tahun_mulai ?: $d->tahun_perolehan) == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td><span class="field-display small">{{ $d->detail_info ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="detail_info" value="{{ $d->detail_info }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="nomor_akun" value="{{ $d->nomor_akun }}"><input type="hidden" data-field="atas_nama" value="{{ $d->atas_nama }}"><input type="hidden" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"><input type="hidden" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"><input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="tahun_perolehan" value="{{ $d->tahun_perolehan }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="harga_perolehan" value="{{ $d->harga_perolehan }}"><input type="hidden" data-field="merk_tipe" value="{{ $d->merk_tipe }}"><input type="hidden" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"><input type="hidden" data-field="kepemilikan" value="{{ $d->kepemilikan }}"><input type="hidden" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"><input type="hidden" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"><input type="hidden" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="9" class="text-center text-muted py-4">Belum ada data HUTANG. Import sheet 1 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @else
                        {{-- HARTA LAINNYA (06-99): TAHUN, BUKTI, INFO, HARGA, NILAI --}}
                        <table class="table table-bordered align-middle table-lampiran" id="tableKat-{{ $katId }}" style="font-size:0.8rem">
                            <thead class="table-dark"><tr><th>KODE</th><th>DESKRIPSI</th><th>TAHUN</th><th>BUKTI/NO AKUN</th><th>INFO TAMBAHAN</th><th class="text-end">HARGA</th><th class="text-end">NILAI SAAT INI</th><th>AKSI</th></tr></thead>
                            <tbody>
                                @forelse($items as $d)
                                <tr class="row-edit" data-row-id="{{ $d->id }}">
                                    <td>
                                        <span class="kode-text">{{ $d->kode }}</span>
                                        <select class="cell-input cell-select d-none" data-field="kode">
                                            <option value="">--</option>
                                            @foreach($activeMasterItems->where('kategori_id', $katId) as $m)
                                                <option value="{{ $m->sub_kode }}" {{ $d->kode === $m->sub_kode ? 'selected' : '' }}>{{ $m->sub_kode }} - {{ $m->nama }}</option>
                                            @endforeach
                                        </select>
                                    </td>
                                    <td><span class="field-display">{{ $masterByKode[$d->kode]->nama ?? ($d->deskripsi ?: '-') }}</span><input type="text" class="cell-input cell-edit d-none" data-field="deskripsi" value="{{ $d->deskripsi }}" readonly></td>
                                    <td><span class="field-display">{{ $d->tahun_perolehan ?: '-' }}</span><select class="cell-input cell-select cell-edit d-none" data-field="tahun_perolehan"><option value="">--</option>@foreach($tahunPerolehanList as $t)<option value="{{ $t }}" {{ $d->tahun_perolehan == $t ? 'selected' : '' }}>{{ $t }}</option>@endforeach</select></td>
                                    <td><span class="field-display"><code>{{ $d->nopol_sertifikat ?: $d->nomor_akun ?: '-' }}</code></span><input type="text" class="cell-input cell-edit d-none" data-field="nopol_sertifikat" value="{{ $d->nopol_sertifikat }}"></td>
                                    <td><span class="field-display small">{{ $d->detail_info ?: '-' }}</span><input type="text" class="cell-input cell-edit d-none" data-field="detail_info" value="{{ $d->detail_info }}"></td>
                                    <td><span class="field-display text-end">{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="harga_perolehan" value="{{ ($d->harga_perolehan ?: $d->saldo_bentuk_awal) > 0 ? number_format($d->harga_perolehan ?: $d->saldo_bentuk_awal, 0, ',', '.') : '' }}"></td>
                                    <td><span class="field-display text-end">{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '-' }}</span><input type="text" class="cell-input cell-edit format-number text-end d-none" data-field="saldo_saat_ini" value="{{ $d->saldo_saat_ini > 0 ? number_format($d->saldo_saat_ini, 0, ',', '.') : '' }}"></td>
                                    <td class="d-none">
                                        <input type="hidden" data-field="nomor_akun" value="{{ $d->nomor_akun }}"><input type="hidden" data-field="atas_nama" value="{{ $d->atas_nama }}"><input type="hidden" data-field="nama_bank_institusi" value="{{ $d->nama_bank_institusi }}"><input type="hidden" data-field="lokasi_harta" value="{{ $d->lokasi_harta }}"><input type="hidden" data-field="kurs" value="{{ $d->kurs }}"><input type="hidden" data-field="saldo_bentuk_awal" value="{{ $d->saldo_bentuk_awal }}"><input type="hidden" data-field="nilai_kurs" value="{{ $d->nilai_kurs }}"><input type="hidden" data-field="merk_tipe" value="{{ $d->merk_tipe }}"><input type="hidden" data-field="kepemilikan" value="{{ $d->kepemilikan }}"><input type="hidden" data-field="nik_npwp_pihak" value="{{ $d->nik_npwp_pihak }}"><input type="hidden" data-field="nama_pihak" value="{{ $d->nama_pihak }}"><input type="hidden" data-field="negara_kreditur" value="{{ $d->negara_kreditur }}"><input type="hidden" data-field="ukuran_tanah" value="{{ $d->ukuran_tanah }}"><input type="hidden" data-field="ukuran_bangunan" value="{{ $d->ukuran_bangunan }}"><input type="hidden" data-field="sumber_kepemilikan" value="{{ $d->sumber_kepemilikan }}"><input type="hidden" data-field="tahun_mulai" value="{{ $d->tahun_mulai }}">
                                    </td>
                                    <td class="text-center text-nowrap">
                                        @cmsCan('lampiran_spt', 'edit')<button type="button" class="btn btn-outline-primary btn-sm btn-edit-row" title="Edit baris"><i class="bi bi-pencil"></i></button>@endCmsCan
                                        @cmsCan('lampiran_spt', 'delete')<button type="button" class="btn btn-outline-danger btn-sm btn-remove-row" title="Hapus baris" data-id="{{ $d->id }}"><i class="bi bi-trash3"></i></button>@endCmsCan
                                    </td>
                                </tr>
                                @empty
                                <tr class="empty-row"><td colspan="8" class="text-center text-muted py-4">Belum ada data HARTA LAINNYA. Import sheet 06-99 atau klik "Tambah Baris".</td></tr>
                                @endforelse
                            </tbody>
                        </table>
                        @endif
                    </div>
                    <div class="kat-pagination d-flex justify-content-between align-items-center mt-2" data-table="tableKat-{{ $katId }}" style="font-size:0.8rem"></div>
                    <div class="d-flex justify-content-between mt-3 kat-toolbar" data-table="tableKat-{{ $katId }}" data-kat="{{ $katId }}">
                        @cmsCan('lampiran_spt', 'create')
                        <button type="button" class="btn btn-outline-primary btn-kat-add" data-kode-opts='@json($activeMasterItems->where("kategori_id", $katId)->map(function($m){ return ["kode" => $m->sub_kode, "nama" => $m->nama]; })->values())'>
                            <i class="bi bi-plus-lg me-1"></i> Tambah Baris
                        </button>
                        <button type="button" class="btn btn-primary px-4 btn-kat-save">
                            <i class="bi bi-save me-1"></i> Simpan
                        </button>
                        @endCmsCan
                    </div>
                        </div>
                    </div>
                </div>
                @endforeach
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
#tableLampiran .select2-container, .table-lampiran .select2-container {
    width: 100% !important;
}
#tableLampiran .select2-container--default .select2-selection--single, .table-lampiran .select2-container--default .select2-selection--single {
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
#tableLampiran td, #tableLampiran th, .table-lampiran td, .table-lampiran th {
    padding: 2px 4px;
    vertical-align: middle;
    white-space: nowrap;
}
#tableLampiran tr .cell-input,
#tableLampiran tr .cell-select,
.table-lampiran tr .cell-input,
.table-lampiran tr .cell-select {
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
var masterByKat = @json($activeMasterItems->groupBy('kategori_id')->map(function($items){ return $items->map(function($m){ return ['kode' => $m->sub_kode, 'nama' => $m->nama]; })->values(); }));
var allMasters = @json($activeMasterItems->map(function($m){ return ['kode' => $m->sub_kode, 'nama' => $m->nama]; })->values());
var tahunOpts = @json(array_values($tahunPerolehanList ?? []));
var ALL_FIELDS = ['deskripsi','nomor_akun','atas_nama','nama_bank_institusi','lokasi_harta','kurs','tahun_perolehan','saldo_saat_ini','saldo_bentuk_awal','nilai_kurs','harga_perolehan','merk_tipe','nopol_sertifikat','kepemilikan','nik_npwp_pihak','nama_pihak','negara_kreditur','ukuran_tanah','ukuran_bangunan','sumber_kepemilikan','detail_info','tahun_mulai'];
var NUM_FIELDS = ['saldo_saat_ini','saldo_bentuk_awal','nilai_kurs','harga_perolehan'];
// Kolom visible (selain KODE) untuk builder tambah-baris per tab
var KAT_FIELDS = {
    1: [{f:'deskripsi',ro:1},{f:'nomor_akun'},{f:'atas_nama'},{f:'nama_bank_institusi'},{f:'lokasi_harta'},{f:'tahun_perolehan',type:'tahun'},{f:'saldo_saat_ini',type:'number'}],
    2: [{f:'deskripsi',ro:1},{f:'lokasi_harta'},{f:'nik_npwp_pihak'},{f:'nama_pihak'},{f:'tahun_mulai',type:'tahun'},{f:'saldo_saat_ini',type:'number'}],
    3: [{f:'deskripsi',ro:1},{f:'lokasi_harta'},{f:'nik_npwp_pihak'},{f:'nama_pihak'},{f:'nomor_akun'},{f:'tahun_perolehan',type:'tahun'},{f:'harga_perolehan',type:'number'},{f:'saldo_saat_ini',type:'number'}],
    4: [{f:'merk_tipe'},{f:'nopol_sertifikat'},{f:'kepemilikan'},{f:'nik_npwp_pihak'},{f:'nama_pihak'},{f:'tahun_perolehan',type:'tahun'},{f:'harga_perolehan',type:'number'},{f:'saldo_saat_ini',type:'number'}],
    5: [{f:'deskripsi',ro:1},{f:'lokasi_harta'},{f:'detail_info'},{f:'ukuran_tanah'},{f:'ukuran_bangunan'},{f:'sumber_kepemilikan'},{f:'nopol_sertifikat'},{f:'tahun_perolehan',type:'tahun'},{f:'harga_perolehan',type:'number'},{f:'saldo_saat_ini',type:'number'}],
    6: [{f:'deskripsi',ro:1},{f:'tahun_perolehan',type:'tahun'},{f:'nopol_sertifikat'},{f:'detail_info'},{f:'harga_perolehan',type:'number'},{f:'saldo_saat_ini',type:'number'}],
    7: [{f:'deskripsi',ro:1},{f:'nik_npwp_pihak'},{f:'nama_pihak'},{f:'negara_kreditur'},{f:'tahun_mulai',type:'tahun'},{f:'saldo_saat_ini',type:'number'},{f:'detail_info'}]
};
var SEMUA_FIELDS = [{f:'deskripsi',ro:1},{f:'nomor_akun'},{f:'atas_nama'},{f:'nama_bank_institusi'},{f:'lokasi_harta'},{f:'kurs'},{f:'tahun_perolehan',type:'tahun'},{f:'saldo_saat_ini',type:'number'},{f:'saldo_bentuk_awal',type:'currency'},{f:'nilai_kurs',type:'currency'}];

// Bangun <tr class="row-new"> editable generik (kode + field visible + hidden sisanya)
function buildEditableRow(kodeOpts, fields) {
    var tr = document.createElement('tr');
    tr.className = 'row-new';
    var tdKode = document.createElement('td');
    var sel = document.createElement('select');
    sel.className = 'cell-input cell-select';
    sel.setAttribute('data-field', 'kode');
    var opt0 = document.createElement('option');
    opt0.value = ''; opt0.textContent = '--';
    sel.appendChild(opt0);
    (kodeOpts || []).forEach(function(o) {
        var op = document.createElement('option');
        op.value = o.kode; op.textContent = o.kode + ' - ' + o.nama;
        sel.appendChild(op);
    });
    tdKode.appendChild(sel);
    tr.appendChild(tdKode);
    sel.addEventListener('change', function() { populateDeskripsi(sel); });
    var shown = ['kode'];
    (fields || []).forEach(function(cfg) {
        var td = document.createElement('td');
        var inp;
        if (cfg.type === 'tahun') {
            inp = document.createElement('select');
            inp.className = 'cell-input cell-select';
            var o0 = document.createElement('option');
            o0.value = ''; o0.textContent = '--';
            inp.appendChild(o0);
            tahunOpts.forEach(function(t) {
                var o = document.createElement('option');
                o.value = t; o.textContent = t;
                inp.appendChild(o);
            });
        } else {
            inp = document.createElement('input');
            inp.type = 'text';
            inp.className = 'cell-input' + (cfg.type === 'number' ? ' format-number text-end' : '') + (cfg.type === 'currency' ? ' format-currency text-end' : '');
            if (cfg.ro) inp.readOnly = true;
        }
        inp.setAttribute('data-field', cfg.f);
        shown.push(cfg.f);
        td.appendChild(inp);
        tr.appendChild(td);
    });
    var tdH = document.createElement('td');
    tdH.className = 'd-none';
    ALL_FIELDS.forEach(function(fl) {
        if (shown.indexOf(fl) < 0) {
            var h = document.createElement('input');
            h.type = 'hidden';
            h.setAttribute('data-field', fl);
            tdH.appendChild(h);
        }
    });
    tr.appendChild(tdH);
    return tr;
}

function rowParams(tr) {
    var params = new URLSearchParams();
    tr.querySelectorAll('[data-field]').forEach(function(el) {
        var v = el.value || '';
        if (NUM_FIELDS.indexOf(el.getAttribute('data-field')) >= 0) v = v.replace(/\./g, '');
        params.append(el.getAttribute('data-field'), v);
    });
    return params;
}

// Tambah baris di tab kategori (kode difilter per kategori)
document.addEventListener('click', function(e) {
    var btn = e.target.closest('.btn-kat-add');
    if (!btn) return;
    var toolbar = btn.closest('.kat-toolbar');
    if (!toolbar) return;
    var katId = toolbar.getAttribute('data-kat');
    var table = document.getElementById(toolbar.getAttribute('data-table'));
    if (!table) return;
    var tbody = table.querySelector('tbody');
    var emptyRow = tbody.querySelector('.empty-row');
    if (emptyRow) emptyRow.remove();
    // Opsi kode diambil dari tombol (sudah difilter server per kategori), fallback ke masterByKat
    var kodeOpts = [];
    try { kodeOpts = JSON.parse(btn.getAttribute('data-kode-opts') || '[]'); } catch(_) { kodeOpts = []; }
    if (!kodeOpts.length) kodeOpts = masterByKat[katId] || [];
    var tr = buildEditableRow(kodeOpts, KAT_FIELDS[katId] || KAT_FIELDS[1]);
    var tdAksi = document.createElement('td');
    tdAksi.className = 'text-center text-nowrap';
    var btnHapus = document.createElement('button');
    btnHapus.type = 'button';
    btnHapus.className = 'btn btn-outline-danger btn-sm btn-remove-row';
    btnHapus.title = 'Hapus baris';
    var iconHapus = document.createElement('i');
    iconHapus.className = 'bi bi-trash3';
    btnHapus.appendChild(iconHapus);
    tdAksi.appendChild(btnHapus);
    tr.appendChild(tdAksi);
    tbody.appendChild(tr);
    katGotoPage(table, 'last');
});
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
    var inp = tr.querySelector('[data-field="deskripsi"]');
    if (inp) inp.value = nama;
    var td = inp ? inp.closest('td') : null;
    var display = td ? td.querySelector('.field-display') : null;
    if (display) display.textContent = nama || '-';
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
    if (e.target.tagName === 'SELECT' && td && td.cellIndex === 1) {
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

    // CHECKBOX
    var tdCek = makeTd();
    tdCek.className = 'text-center';
    var cb = document.createElement('input');
    cb.type = 'checkbox';
    cb.className = 'row-checkbox';
    tdCek.appendChild(cb);
    tr.appendChild(tdCek);

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

    selKode.setAttribute('data-field', 'kode');
    inpDesk.setAttribute('data-field', 'deskripsi');
    inpAkun.setAttribute('data-field', 'nomor_akun');
    inpNama.setAttribute('data-field', 'atas_nama');
    inpBank.setAttribute('data-field', 'nama_bank_institusi');
    inpLokasi.setAttribute('data-field', 'lokasi_harta');
    inpKurs.setAttribute('data-field', 'kurs');
    selTahun.setAttribute('data-field', 'tahun_perolehan');
    inpSaldoIni.setAttribute('data-field', 'saldo_saat_ini');
    inpSaldoAwal.setAttribute('data-field', 'saldo_bentuk_awal');
    inpNilaiKurs.setAttribute('data-field', 'nilai_kurs');
    (function() {
        var tdH = document.createElement('td');
        tdH.className = 'd-none';
        ['harga_perolehan','merk_tipe','nopol_sertifikat','kepemilikan','nik_npwp_pihak','nama_pihak','negara_kreditur','ukuran_tanah','ukuran_bangunan','sumber_kepemilikan','detail_info','tahun_mulai'].forEach(function(fl) {
            var h = document.createElement('input');
            h.type = 'hidden';
            h.setAttribute('data-field', fl);
            tdH.appendChild(h);
        });
        tr.insertBefore(tdH, td12);
    })();

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

// Kumpulkan baris dari sebuah tabel berdasarkan data-field (kolom boleh beda per tab)
function collectLampiranRows(table) {
    var rows = [];
    table.querySelectorAll('tbody tr.row-edit, tbody tr.row-new').forEach(function(tr) {
        function f(name) {
            var el = tr.querySelector('[data-field="' + name + '"]');
            return el ? el.value : '';
        }
        function n(name) {
            return f(name).replace(/\./g, '').replace(',', '.');
        }
        var kode = f('kode');
        if (!kode) return;
        rows.push({
            row_id: tr.getAttribute('data-row-id') || null,
            kode: kode,
            deskripsi: f('deskripsi'),
            nomor_akun: f('nomor_akun'),
            atas_nama: f('atas_nama'),
            nama_bank_institusi: f('nama_bank_institusi'),
            lokasi_harta: f('lokasi_harta'),
            kurs: f('kurs'),
            tahun_perolehan: f('tahun_perolehan'),
            saldo_saat_ini: n('saldo_saat_ini'),
            saldo_bentuk_awal: n('saldo_bentuk_awal'),
            nilai_kurs: n('nilai_kurs'),
            harga_perolehan: n('harga_perolehan'),
            merk_tipe: f('merk_tipe'),
            nopol_sertifikat: f('nopol_sertifikat'),
            kepemilikan: f('kepemilikan'),
            nik_npwp_pihak: f('nik_npwp_pihak'),
            nama_pihak: f('nama_pihak'),
            negara_kreditur: f('negara_kreditur'),
            ukuran_tanah: f('ukuran_tanah'),
            ukuran_bangunan: f('ukuran_bangunan'),
            sumber_kepemilikan: f('sumber_kepemilikan'),
            detail_info: f('detail_info'),
            tahun_mulai: f('tahun_mulai'),
        });
    });
    return rows;
}

function postLampiranRows(rows) {
    var csrf = document.querySelector('meta[name="csrf-token"]');
    var form = document.getElementById('formLampiran');
    var clientId = form.querySelector('input[name="client_id"]').value;
    var tahun = form.querySelector('input[name="tahun"]').value;
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
}

// Global Simpan via JSON (tab Semua)
document.getElementById('btnSimpan')?.addEventListener('click', function() {
    var table = document.getElementById('tableLampiran');
    if (!table) return;
    postLampiranRows(collectLampiranRows(table));
});

// Simpan per tab kategori
document.addEventListener('click', function(e) {
    var btn = e.target.closest('.btn-kat-save');
    if (!btn) return;
    var toolbar = btn.closest('.kat-toolbar');
    var table = toolbar ? document.getElementById(toolbar.getAttribute('data-table')) : null;
    if (!table) return;
    postLampiranRows(collectLampiranRows(table));
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
    var kodeSelect = tr.querySelector('[data-field="kode"]');
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
            populateDeskripsi(kodeSelect);
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
        var kodeSelect = tr.cells[1] ? tr.cells[1].querySelector('select') : null;
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

// Check all toggle
document.getElementById('checkAll')?.addEventListener('change', function() {
    document.querySelectorAll('.row-checkbox').forEach(function(cb) {
        cb.checked = this.checked;
    }, this);
    document.getElementById('btnDeleteSelected').disabled = !this.checked;
});

// Enable/disable delete selected button
document.addEventListener('change', function(e) {
    var cb = e.target.closest('.row-checkbox');
    if (cb) {
        var anyChecked = document.querySelectorAll('.row-checkbox:checked').length > 0;
        document.getElementById('btnDeleteSelected').disabled = !anyChecked;
    }
});

// Delete selected rows
document.getElementById('btnDeleteSelected')?.addEventListener('click', function() {
    var checked = document.querySelectorAll('.row-checkbox:checked');
    if (!checked.length) return;
    if (!confirm('Hapus ' + checked.length + ' data yang dipilih?')) return;
    var csrf = document.querySelector('meta[name="csrf-token"]');
    var token = csrf ? csrf.getAttribute('content') : '';
    var form = document.getElementById('formLampiran');
    var clientId = form.querySelector('input[name="client_id"]').value;
    var tahun = form.querySelector('input[name="tahun"]').value;
    var ids = [];
    checked.forEach(function(cb) { ids.push(cb.value); });
    fetch('/admin/lampiran-spt/delete-all', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-TOKEN': token },
        body: JSON.stringify({ client_id: clientId, tahun: tahun, ids: ids }),
    }).then(function(r) { return r.json(); }).then(function(res) {
        if (res.success) {
            location.reload();
        } else {
            alert('Gagal menghapus data.');
        }
    }).catch(function() { alert('Terjadi kesalahan.'); });
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

// Buka / Tutup semua section kategori
document.getElementById('btnExpandAll')?.addEventListener('click', function() {
    document.querySelectorAll('.kat-collapse').forEach(function(el) {
        bootstrap.Collapse.getOrCreateInstance(el, { toggle: false }).show();
    });
});
document.getElementById('btnCollapseAll')?.addEventListener('click', function() {
    document.querySelectorAll('.kat-collapse').forEach(function(el) {
        bootstrap.Collapse.getOrCreateInstance(el, { toggle: false }).hide();
    });
});

// Simpan semua kategori sekaligus
document.getElementById('btnSimpanSemua')?.addEventListener('click', function() {
    var allRows = [];
    document.querySelectorAll('.kat-section table.table-lampiran').forEach(function(table) {
        allRows = allRows.concat(collectLampiranRows(table));
    });
    postLampiranRows(allRows);
});

// Pagination per tabel kategori (client-side, tanpa reload) — 15 baris per halaman
var KAT_PER_PAGE = 15;

function katDataRows(table) {
    var tbody = table.querySelector('tbody');
    if (!tbody) return [];
    return Array.prototype.filter.call(
        tbody.querySelectorAll('tr.row-edit, tr.row-new'),
        function(tr) { return !tr.classList.contains('empty-row'); }
    );
}

function katPageWindow(cur, pages) {
    if (pages <= 7) {
        var all = [];
        for (var i = 1; i <= pages; i++) all.push(i);
        return all;
    }
    var set = [1, cur - 1, cur, cur + 1, pages].filter(function(p) { return p >= 1 && p <= pages; });
    set = Array.from(new Set(set)).sort(function(a, b) { return a - b; });
    var out = [];
    var prev = 0;
    set.forEach(function(p) {
        if (p - prev > 1) out.push('...');
        out.push(p);
        prev = p;
    });
    return out;
}

function katRenderPager(table) {
    var pager = document.querySelector('.kat-pagination[data-table="' + table.id + '"]');
    if (!pager) return;
    var rows = katDataRows(table);
    var total = rows.length;
    if (total <= KAT_PER_PAGE) {
        pager.innerHTML = '';
        pager.style.display = 'none';
        rows.forEach(function(tr) { tr.style.display = ''; });
        table.dataset.katPage = '1';
        return;
    }
    pager.style.display = '';
    var pages = Math.ceil(total / KAT_PER_PAGE);
    var cur = parseInt(table.dataset.katPage || '1', 10);
    if (isNaN(cur) || cur < 1) cur = 1;
    if (cur > pages) cur = pages;
    table.dataset.katPage = String(cur);

    rows.forEach(function(tr, idx) {
        var p = Math.floor(idx / KAT_PER_PAGE) + 1;
        tr.style.display = (p === cur) ? '' : 'none';
    });

    var start = (cur - 1) * KAT_PER_PAGE + 1;
    var end = Math.min(cur * KAT_PER_PAGE, total);

    var html = '<small class="text-muted">Menampilkan ' + start + '-' + end + ' dari ' + total + ' data</small>';
    html += '<div class="btn-group btn-group-sm" role="group">';
    html += '<button type="button" class="btn btn-outline-secondary kat-page-btn" data-page="' + (cur - 1) + '"' + (cur === 1 ? ' disabled' : '') + '><i class="bi bi-chevron-left"></i></button>';
    katPageWindow(cur, pages).forEach(function(p) {
        if (p === '...') html += '<button type="button" class="btn btn-outline-secondary" disabled>...</button>';
        else html += '<button type="button" class="btn kat-page-btn ' + (p === cur ? 'btn-primary' : 'btn-outline-secondary') + '" data-page="' + p + '">' + p + '</button>';
    });
    html += '<button type="button" class="btn btn-outline-secondary kat-page-btn" data-page="' + (cur + 1) + '"' + (cur === pages ? ' disabled' : '') + '><i class="bi bi-chevron-right"></i></button>';
    html += '</div>';
    pager.innerHTML = html;
}

function katGotoPage(table, page) {
    if (page === 'last') {
        page = Math.max(1, Math.ceil(katDataRows(table).length / KAT_PER_PAGE));
    }
    table.dataset.katPage = String(page);
    katRenderPager(table);
}

// Klik nomor / prev / next pager (tanpa reload)
document.addEventListener('click', function(e) {
    var btn = e.target.closest('.kat-page-btn');
    if (!btn || btn.disabled) return;
    var pager = btn.closest('.kat-pagination');
    if (!pager) return;
    var table = document.getElementById(pager.getAttribute('data-table'));
    if (!table) return;
    katGotoPage(table, parseInt(btn.getAttribute('data-page'), 10));
});

// Inisialisasi pager + pantau tambah/hapus baris agar selalu sinkron
function katInitPagination() {
    document.querySelectorAll('.kat-section table.table-lampiran').forEach(function(table) {
        if (!table.dataset.katPage) table.dataset.katPage = '1';
        katRenderPager(table);
        var tbody = table.querySelector('tbody');
        if (tbody && !tbody.dataset.katObserved) {
            tbody.dataset.katObserved = '1';
            new MutationObserver(function() { katRenderPager(table); }).observe(tbody, { childList: true });
        }
    });
}
katInitPagination();

// Persist active tab
var tabKey = localStorage.getItem('lampiranSptTab');
if (tabKey) {
    var tab = document.querySelector('#lampiranTabs button[data-bs-target="' + tabKey + '"]');
    if (tab) { var trigger = new bootstrap.Tab(tab); trigger.show(); }
    else { localStorage.removeItem('lampiranSptTab'); }
}
document.querySelectorAll('#lampiranTabs button[data-bs-toggle="tab"]').forEach(function(btn) {
    btn.addEventListener('shown.bs.tab', function(e) {
        localStorage.setItem('lampiranSptTab', btn.getAttribute('data-bs-target'));
    });
});
</script>
@endpush
