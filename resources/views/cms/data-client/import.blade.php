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
                <div class="col-md-3">
                    <div class="card bg-success bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-success">{{ $newCount }}</div>
                        <small class="text-muted">Data Baru</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-warning bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-warning">{{ $updateCount }}</div>
                        <small class="text-muted">Sudah Ada (NPWP sama)</small>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card bg-secondary bg-opacity-10 border-0 text-center py-3">
                        <div class="fs-2 fw-bold text-secondary">{{ $totalRows - $newCount - $updateCount }}</div>
                        <small class="text-muted">Tanpa NPWP</small>
                    </div>
                </div>
            </div>

            {{-- Pilih Mode Import --}}
            @if($updateCount > 0)
            <div class="alert alert-warning py-3 mb-4">
                <h6 class="fw-semibold mb-2"><i class="bi bi-exclamation-triangle me-1"></i>Pilihan Mode Import</h6>
                <p class="mb-2 small">Ditemukan <strong>{{ $updateCount }}</strong> data dengan NPWP yang sudah terdaftar. Pilih tindakan:</p>
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
            <div class="table-responsive" style="max-height:400px">
                <table class="table table-sm table-hover mb-0">
                    <thead class="table-light sticky-top">
                        <tr>
                            <th>#</th>
                            <th>KPP</th>
                            <th>Nama</th>
                            <th>NPWP</th>
                            <th>Email</th>
                            <th>HP</th>
                            <th>Alamat NPWP</th>
                            <th>AR</th>
                            <th>PTKP</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($preview as $i => $item)
                        <tr class="{{ $item['exists'] ? 'table-warning' : '' }}">
                            <td>{{ $i + 1 }}</td>
                            <td>{{ $item['kpp'] ?: '-' }}</td>
                            <td>{{ $item['nama'] }}</td>
                            <td><code>{{ $item['npwp'] ?: '-' }}</code></td>
                            <td><small>{{ $item['email'] ?: '-' }}</small></td>
                            <td>{{ $item['hp'] ?: '-' }}</td>
                            <td><small class="text-muted">{{ Str::limit($item['alamat'], 40) ?: '-' }}</small></td>
                            <td>{{ $item['ar'] ?: '-' }}</td>
                            <td>{{ $item['ptkp'] ?: '-' }}</td>
                            <td>
                                @if($item['exists'])
                                    <span class="badge bg-warning text-dark">Akan Diupdate</span>
                                @else
                                    <span class="badge bg-success">Baru</span>
                                @endif
                            </td>
                        </tr>
                        @empty
                        <tr><td colspan="10" class="text-center text-muted py-4">Tidak ada data.</td></tr>
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
                        <i class="bi bi-check-lg me-1"></i> Import {{ $newCount }} Data Baru
                    </button>
                </form>
            </div>
            @push('scripts')
            <script>
            document.querySelectorAll('input[name="import_mode"]').forEach(function(el) {
                el.addEventListener('change', function() {
                    document.getElementById('importModeInput').value = this.value;
                    var btn = document.getElementById('confirmBtn');
                    if (this.value === 'update') {
                        btn.innerHTML = '<i class="bi bi-check-lg me-1"></i> Import & Update {{ $updateCount }} Data';
                    } else {
                        btn.innerHTML = '<i class="bi bi-check-lg me-1"></i> Import {{ $newCount }} Data Baru';
                    }
                });
            });
            document.getElementById('confirmForm').addEventListener('submit', function(e) {
                var mode = document.getElementById('importModeInput').value;
                if (mode === 'update' && !confirm('Data dengan NPWP yang sama akan diperbarui. Lanjutkan?')) {
                    e.preventDefault();
                } else if (mode === 'skip' && !confirm('Import {{ $newCount }} data baru? Data yang sudah ada akan dilewati.')) {
                    e.preventDefault();
                }
            });
            </script>
            @endpush
        @endif
    </div>
</div>
@endsection