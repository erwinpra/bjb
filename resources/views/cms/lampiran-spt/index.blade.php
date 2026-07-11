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
                <a href="{{ route('cms.lampiran-spt.master') }}" class="btn btn-outline-secondary ms-2">
                    <i class="bi bi-gear me-1"></i> Kelola Master
                </a>
            </div>
        </form>

        @if($clientId)
            <form method="POST" action="{{ route('cms.lampiran-spt.store') }}" id="formLampiran">
                @csrf
                <input type="hidden" name="client_id" value="{{ $clientId }}">
                <input type="hidden" name="tahun" value="{{ $tahun }}">
                <input type="hidden" name="active_tab" id="activeTab" value="{{ $activeTab }}">

                @if($tabs->count() > 1)
                {{-- Cabang Tabs --}}
                <ul class="nav nav-tabs mb-3" id="lampiranTabs" role="tablist">
                    @foreach($tabs as $key => $tab)
                    <li class="nav-item" role="presentation">
                        <button class="nav-link {{ $key === $activeTab ? 'active' : '' }}"
                            id="tab-{{ $key }}" data-bs-toggle="tab"
                            data-bs-target="#tabContent-{{ $key }}"
                            type="button" role="tab"
                            data-prefix="{{ $key }}">
                            <i class="bi {{ $key === 'induk' ? 'bi-building' : 'bi-diagram-2' }} me-1"></i>
                            {{ $tab['npwp'] }}
                        </button>
                    </li>
                    @endforeach
                </ul>
                @endif

                <div class="tab-content" id="lampiranTabContent">
                    @foreach($tabs as $key => $tab)
                    @php $prefix = $key === 'induk' ? 'induk' : $key; @endphp
                    <div class="tab-pane fade {{ $key === $activeTab ? 'show active' : '' }}"
                        id="tabContent-{{ $key }}" role="tabpanel">
                        <div class="mb-2">
                            <small class="text-muted">{{ $tab['label'] }} &middot; NPWP: {{ $tab['npwp'] }}</small>
                        </div>

                        <input type="hidden" name="{{ $prefix }}[npwp_cabang_id]"
                            value="{{ $tab['npwp_cabang_id'] ?? '' }}">

                        @forelse($tab['items'] as $kategori => $subItems)
                        @php $collapseId = 'collapse-' . $key . '-' . $kategori; @endphp
                        <div class="card border mb-3">
                            <div class="card-header bg-light py-2 collapse-toggle"
                                role="button" data-bs-toggle="collapse"
                                data-bs-target="#{{ $collapseId }}" aria-expanded="false">
                                <h6 class="fw-semibold mb-0 d-flex justify-content-between align-items-center">
                                    {{ $kategoriLabels[$kategori] ?? $kategori }}
                                    <i class="bi bi-chevron-right collapse-icon"></i>
                                </h6>
                            </div>
                            <div class="collapse" id="{{ $collapseId }}">
                                <div class="card-body p-0">
                                    <table class="table table-sm mb-0">
                                        <thead class="table-light">
                                            <tr>
                                                <th class="ps-4" style="width:100px">Kode</th>
                                                <th>Nama</th>
                                                <th class="text-end pe-4" style="width:250px">Nilai (Rp)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach($subItems as $item)
                                            <tr>
                                                <td class="ps-4"><code>{{ $item['sub_kode'] }}</code></td>
                                                <td>{{ $item['sub_nama'] }}</td>
                                                <td class="pe-4">
                                                    <input type="text"
                                                        class="form-control form-control-sm format-currency text-end"
                                                        name="{{ $prefix }}[nilai][{{ $item['id'] }}]"
                                                        value="{{ $item['nilai'] > 0 ? number_format($item['nilai'], 0, ',', '.') : '' }}">
                                                </td>
                                            </tr>
                                            @endforeach
                                            @php
                                                $totalNilai = $subItems->sum('nilai');
                                            @endphp
                                            <tr class="table-secondary fw-bold">
                                                <td class="ps-4" colspan="2">Total {{ $kategoriLabels[$kategori] ?? $kategori }}</td>
                                                <td class="text-end pe-4">
                                                    Rp {{ number_format($totalNilai, 0, ',', '.') }}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        @empty
                        <div class="text-center text-muted py-4">
                            <i class="bi bi-inbox display-4 d-block mb-2 text-secondary opacity-50"></i>
                            Belum ada master kategori.
                            <a href="{{ route('cms.lampiran-spt.master') }}">Kelola Master</a>
                        </div>
                        @endforelse
                    </div>
                    @endforeach
                </div>

                @if($tabs->isNotEmpty())
                <div class="d-flex justify-content-end mt-3">
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-save me-1"></i> Simpan Nilai SPT
                    </button>
                </div>
                @endif
            </form>
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
.collapse-toggle {
    cursor: pointer;
    user-select: none;
}
.collapse-toggle:hover {
    background-color: #e9ecef;
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

document.querySelectorAll('.format-currency').forEach(function(el) {
    el.addEventListener('input', function(e) {
        var val = this.value.replace(/[^0-9]/g, '');
        if (val) {
            this.value = new Intl.NumberFormat('id-ID').format(parseInt(val, 10));
        }
    });
    el.addEventListener('blur', function() {
        if (!this.value) this.value = '';
    });
});

// Track active tab for redirect after save
document.querySelectorAll('#lampiranTabs button[data-bs-toggle="tab"]').forEach(function(btn) {
    btn.addEventListener('shown.bs.tab', function(e) {
        document.getElementById('activeTab').value = btn.getAttribute('data-prefix');
    });
});

// Collapse toggle icons
document.querySelectorAll('.collapse-toggle').forEach(function(header) {
    var target = document.querySelector(header.getAttribute('data-bs-target'));
    if (target) {
        target.addEventListener('show.bs.collapse', function() {
            var icon = header.querySelector('.collapse-icon');
            if (icon) {
                icon.classList.remove('bi-chevron-right');
                icon.classList.add('bi-chevron-up');
            }
        });
        target.addEventListener('hide.bs.collapse', function() {
            var icon = header.querySelector('.collapse-icon');
            if (icon) {
                icon.classList.remove('bi-chevron-up');
                icon.classList.add('bi-chevron-right');
            }
        });
    }
});
</script>
@endpush
