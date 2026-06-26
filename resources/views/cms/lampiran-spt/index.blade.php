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
            <form method="POST" action="{{ route('cms.lampiran-spt.store') }}">
                @csrf
                <input type="hidden" name="client_id" value="{{ $clientId }}">
                <input type="hidden" name="tahun" value="{{ $tahun }}">

                @forelse($items as $kategori => $subItems)
                <div class="card border mb-3">
                    <div class="card-header bg-light py-2">
                        <h6 class="fw-semibold mb-0">
                            {{ $kategoriLabels[$kategori] ?? $kategori }}
                        </h6>
                    </div>
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
                                        <input type="text" class="form-control form-control-sm format-currency text-end"
                                            name="nilai[{{ $item['kategori'] . '|' . $item['sub_kode'] }}]"
                                            value="{{ $item['nilai'] > 0 ? number_format($item['nilai'], 0, ',', '.') : '' }}"
                                            data-month="0">
                                    </td>
                                </tr>
                                @endforeach
                                @php
                                    $total = $subItems->sum('nilai');
                                @endphp
                                <tr class="table-secondary fw-bold">
                                    <td class="ps-4" colspan="2">Total {{ $kategoriLabels[$kategori] ?? $kategori }}</td>
                                    <td class="text-end pe-4">
                                        Rp {{ number_format($total, 0, ',', '.') }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                @empty
                <div class="text-center text-muted py-4">
                    <i class="bi bi-inbox display-4 d-block mb-2 text-secondary opacity-50"></i>
                    Belum ada master kategori. 
                    <a href="{{ route('cms.lampiran-spt.master') }}">Kelola Master</a>
                </div>
                @endforelse

                @if(count($items) > 0)
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

@push('scripts')
<script>
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
</script>
@endpush
