@extends('cms::layouts.app')

@section('title', 'Import Data Client')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.data-client.index') }}" class="text-decoration-none">Data Client</a></li>
    <li class="breadcrumb-item active" aria-current="page">Import</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-upload me-2"></i>Import Data Client dari Excel</h6>
    </div>
    <div class="card-body p-4">
        @if(!isset($preview))
            <form method="POST" action="{{ route('cms.data-client.import.preview') }}" enctype="multipart/form-data">
                @csrf
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">Tipe Badan <span class="text-danger">*</span></label>
                        <select name="tipe_badan" class="form-select @error('tipe_badan') is-invalid @enderror" required>
                            <option value="">-- Pilih Tipe Badan --</option>
                            @foreach($badan as $b)
                                <option value="{{ $b->id }}" {{ old('tipe_badan') == $b->id ? 'selected' : '' }}>
                                    {{ $b->tipe }}
                                </option>
                            @endforeach
                        </select>
                        @error('tipe_badan') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold small">File Excel <span class="text-danger">*</span></label>
                        <input type="file" name="file" class="form-control @error('file') is-invalid @enderror" accept=".xlsx,.xls" required>
                        @error('file') <div class="invalid-feedback">{{ $message }}</div> @enderror
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                    <a href="{{ route('cms.data-client.import.template') }}" class="btn btn-outline-secondary btn-sm">
                        <i class="bi bi-download me-1"></i> Download Template Excel
                    </a>
                    <div class="d-flex gap-2">
                        <a href="{{ route('cms.data-client.index') }}" class="btn btn-light">Batal</a>
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-eye me-1"></i> Preview Data
                        </button>
                    </div>
                </div>
            </form>
        @else
            <div class="alert alert-info d-flex align-items-center gap-2">
                <i class="bi bi-info-circle-fill"></i>
                Tipe Badan: <strong>{{ optional(\App\Models\Cms\Badan::find($tipeBadan))->tipe ?? $tipeBadan }}</strong>
                &bull; File: <code class="ms-1">{{ basename($tempPath) }}</code>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="card bg-primary bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-primary">{{ $totalRows }}</div>
                        <small class="text-muted">Total Baris Data</small>
                    </div>
                </div>
                @if($cabangCount > 0)
                <div class="col-md-3">
                    <div class="card bg-info bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-info">{{ $cabangCount }}</div>
                        <small class="text-muted">Cabang</small>
                    </div>
                </div>
                @endif
                @if(($ecommerceCount ?? 0) > 0)
                <div class="col-md-3">
                    <div class="card bg-purple bg-opacity-10 border-0 text-center py-3" style="background-color:rgba(128,0,128,0.05)">
                        <div class="fs-2 fw-bold text-purple" style="color:purple">{{ $ecommerceCount }}</div>
                        <small class="text-muted">E-Commerce</small>
                    </div>
                </div>
                @endif
                <div class="col-md-3">
                    <div class="card bg-success bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-success">{{ $newCount }}</div>
                        <small class="text-muted">Data Baru</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-warning">{{ $updateCount }}</div>
                        <small class="text-muted">Sudah Ada (NIK sama)</small>
                    </div>
                </div>
            </div>

            {{-- Pilih Mode Import --}}
            @if($updateCount > 0)
            <div class="alert alert-warning py-3 mb-4">
                <h6 class="fw-semibold mb-2"><i class="bi bi-exclamation-triangle me-1"></i>Pilihan Mode Import</h6>
                <p class="mb-2 small">Ditemukan <strong>{{ $updateCount }}</strong> data dengan NIK yang sudah terdaftar. Pilih tindakan:</p>
                <div class="d-flex gap-4">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="import_mode" id="modeSkip" value="skip" checked>
                        <label class="form-check-label small" for="modeSkip">
                            <strong>Skip / Lewati</strong> &mdash; Data yang sudah ada tidak diubah
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="import_mode" id="modeUpdate" value="update">
                        <label class="form-check-label small" for="modeUpdate">
                            <strong>Update / Perbarui</strong> &mdash; Data yang sudah akan diperbarui dengan data dari Excel
                        </label>
                    </div>
                </div>
            </div>
            @endif

            <h6 class="fw-semibold mb-3">Preview Data</h6>
            <div class="mb-3">
                <input type="text" id="searchPreview" class="form-control form-control-sm" placeholder="Cari nama atau NIK..." style="max-width:300px">
            </div>
            <div style="overflow-x: auto; max-height:400px">
                <table class="table table-sm table-hover mb-0" id="previewTable">
                    <thead class="table-light sticky-top">
                        <tr>
                            <th>#</th>
                            <th>KPP</th>
                            <th>Nama</th>
                            <th>NIK</th>
                            <th>Cabang</th>
                            <th>Email</th>
                            <th>HP</th>
                            <th>Alamat NIK</th>
                            <th>Alamat Tagihan</th>
                            <th>AR</th>
                            <th>PTKP</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($preview as $i => $item)
                        <tr class="{{ $item['is_cabang'] ?? false ? ($item['is_ecommerce'] ?? false ? 'table-active' : 'table-info') : ($item['exists'] ? 'table-warning' : '') }}">
                            <td>{{ $i + 1 }}</td>
                            <td>{{ $item['kpp'] ?: '-' }}</td>
                            <td>{{ $item['nama'] }}</td>
                            <td><code>{{ $item['npwp'] ?: '-' }}</code></td>
                            <td>
                                @if($item['is_cabang'] ?? false)
                                    <code>{{ $item['cabang'] }}</code>
                                    <small class="text-muted ms-1">#{{ $item['cabang_no'] }}</small>
                                    @if($item['is_ecommerce'] ?? false)
                                        <span class="badge text-white" style="background:purple">E-Commerce</span>
                                    @endif
                                    @if(!$item['parent_exists'])
                                        <span class="badge bg-danger">Parent tidak ditemukan</span>
                                    @endif
                                @else
                                    -
                                @endif
                            </td>
                            <td><small>{{ $item['email'] ?: '-' }}</small></td>
                            <td>{{ $item['hp'] ?: '-' }}</td>
                            <td><small class="text-muted">{{ Str::limit($item['alamat_npwp'], 40) ?: '-' }}</small></td>
                            <td><small class="text-muted">{{ Str::limit($item['alamat_tagihan'] ?? '', 40) ?: '-' }}</small></td>
                            <td>{{ $item['ar'] ?: '-' }}</td>
                            <td>{{ $item['ptkp'] ?: '-' }}</td>
                            <td>
                                @if($item['is_cabang'] ?? false)
                                    @if($item['is_ecommerce'] ?? false)
                                        <span class="badge text-white" style="background:purple">E-Commerce</span>
                                    @elseif($item['parent_exists'])
                                        <span class="badge bg-info text-white">Cabang</span>
                                    @else
                                        <span class="badge bg-danger">Error</span>
                                    @endif
                                @elseif($item['exists'])
                                    <span class="badge bg-warning text-dark">Akan Diupdate</span>
                                @else
                                    <span class="badge bg-success">Baru</span>
                                @endif
                            </td>
                        </tr>
                        @empty
                        <tr><td colspan="11" class="text-center text-muted py-4">Tidak ada data.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                <a href="{{ route('cms.data-client.import') }}" class="btn btn-light">
                    <i class="bi bi-arrow-left me-1"></i> Upload Ulang
                </a>
                <form method="POST" action="{{ route('cms.data-client.import.confirm') }}" id="confirmForm">
                    @csrf
                    <input type="hidden" name="tipe_badan" value="{{ $tipeBadan }}">
                    <input type="hidden" name="temp_path" value="{{ $tempPath }}">
                    <input type="hidden" name="import_mode" id="importModeInput" value="skip">
                    <button type="submit" class="btn btn-primary px-4" id="confirmBtn">
                        <i class="bi bi-check-lg me-1"></i> Import {{ $newCount + $cabangCount + ($ecommerceCount ?? 0) }} Data Baru
                    </button>
                </form>
            </div>
            {{-- Loading Backdrop --}}
            <div id="loadingBackdrop" class="d-none" style="position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);z-index:9999;display:flex;align-items:center;justify-content:center;">
                <div class="text-center text-white">
                    <div class="spinner-border mb-3" role="status" style="width:3rem;height:3rem;"></div>
                    <div class="fw-semibold">Sedang memproses import...</div>
                </div>
            </div>

            @push('scripts')
            <script>
            document.getElementById('searchPreview')?.addEventListener('input', function() {
                var q = this.value.toLowerCase();
                document.querySelectorAll('#previewTable tbody tr').forEach(function(tr) {
                    var match = tr.textContent.toLowerCase().indexOf(q) > -1;
                    tr.style.display = match ? '' : 'none';
                });
            });
            document.querySelectorAll('input[name="import_mode"]').forEach(function(el) {
                el.addEventListener('change', function() {
                    document.getElementById('importModeInput').value = this.value;
                    var btn = document.getElementById('confirmBtn');
                    if (this.value === 'update') {
                        btn.innerHTML = '<i class="bi bi-check-lg me-1"></i> Import & Update {{ $updateCount }} Data';
                    } else {
                        btn.innerHTML = '<i class="bi bi-check-lg me-1"></i> Import {{ $newCount + $cabangCount + ($ecommerceCount ?? 0) }} Data Baru';
                    }
                });
            });
            @php
                $skipParts = ['Import ' . $newCount . ' data baru'];
                if ($cabangCount > 0) $skipParts[] = $cabangCount . ' cabang';
                if (($ecommerceCount ?? 0) > 0) $skipParts[] = $ecommerceCount . ' e-commerce';
                $skipMsg = implode(', ', $skipParts) . '? Data yang sudah ada akan dilewati.';
            @endphp
            document.getElementById('confirmForm').addEventListener('submit', function(e) {
                var mode = document.getElementById('importModeInput').value;
                if (mode === 'update' && !confirm('Data dengan NIK yang sama akan diperbarui. Lanjutkan?')) {
                    e.preventDefault();
                } else if (mode === 'skip' && !confirm('{{ $skipMsg }}')) {
                    e.preventDefault();
                } else {
                    document.getElementById('loadingBackdrop').classList.remove('d-none');
                }
            });
            </script>
            @endpush
        @endif
    </div>
</div>
@endsection