@extends('cms::layouts.app')

@section('title', 'Preview Import Lampiran SPT')

@push('breadcrumb')
    <li class="breadcrumb-item"><a href="{{ route('cms.lampiran-spt.index') }}" class="text-decoration-none">Lampiran SPT</a></li>
    <li class="breadcrumb-item active" aria-current="page">Preview Import</li>
@endpush

@section('content')
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 border-bottom">
        <h6 class="fw-semibold mb-0"><i class="bi bi-file-earmark-spreadsheet me-2"></i>Preview Import Lampiran SPT (multi-sheet)</h6>
    </div>
    <div class="card-body p-4">
        <div class="d-flex flex-wrap gap-2 justify-content-between align-items-center mb-3">
            <div>
                <span class="badge bg-info fs-6 me-2">
                    <i class="bi bi-person me-1"></i>{{ $client->nama_client ?? 'Unknown' }}
                    <span class="ms-1 text-white-50">({{ $client->npwp ?? 'N/A' }})</span>
                </span>
                <span class="badge bg-primary fs-6 me-2">
                    <i class="bi bi-calendar me-1"></i>Tahun {{ $tahun }}
                </span>
                <span class="badge bg-success fs-6 me-2">{{ $validCount }} data valid</span>
                <span class="badge bg-secondary fs-6">{{ $totalRows }} total baris</span>
                @if(!empty($totalSkipped))
                <span class="badge bg-warning text-dark fs-6">{{ $totalSkipped }} diabaikan (kode tidak sesuai sheet)</span>
                @endif
            </div>
        </div>

        @if(!empty($skippedSheets))
        <div class="alert alert-warning py-2">
            <i class="bi bi-exclamation-triangle me-1"></i>
            {{ count($skippedSheets) }} sheet di-skip:
            @foreach($skippedSheets as $s)
                <span class="badge bg-secondary ms-1">{{ $s['title'] }} — {{ $s['reason'] }}</span>
            @endforeach
        </div>
        @endif

        @if($totalRows > 0)
        <ul class="nav nav-tabs mb-3" role="tablist">
            @foreach($grouped as $sheetCode => $g)
            <li class="nav-item" role="presentation">
                <button class="nav-link {{ $loop->first ? 'active' : '' }}" data-bs-toggle="tab"
                    data-bs-target="#sheet-{{ $sheetCode }}" type="button" role="tab">
                    {{ $kategoris[$g['kategori_id']]->label ?? ('Sheet ' . $sheetCode) }}
                    <span class="badge bg-secondary ms-1">{{ count($g['rows']) }}</span>
                    @if($g['skipped_mismatch'] > 0)
                    <span class="badge bg-warning text-dark ms-1">-{{ $g['skipped_mismatch'] }}</span>
                    @endif
                    <small class="text-muted d-block" style="font-size:0.65rem">sheet: {{ $g['title'] }}</small>
                </button>
            </li>
            @endforeach
        </ul>

        <div class="tab-content">
            @foreach($grouped as $sheetCode => $g)
            <div class="tab-pane fade {{ $loop->first ? 'show active' : '' }}" id="sheet-{{ $sheetCode }}" role="tabpanel">
                <div class="small text-muted mb-2">
                    Kategori: <strong>{{ $kategoris[$g['kategori_id']]->label ?? $g['kategori_id'] }}</strong>
                    | Sheet asli: <code>{{ $g['title'] }}</code>
                    | Header terdeteksi otomatis, kode divalidasi prefix sheet (yang tidak cocok diabaikan).
                    @if(!empty($g['error']))
                    <span class="badge bg-danger ms-2">{{ $g['error'] }}</span>
                    @endif
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle" style="font-size:0.82rem">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>KODE</th>
                                <th>DESKRIPSI</th>
                                <th>AKUN / NOPOL / SERTIFIKAT</th>
                                <th>ATAS NAMA / PIHAK</th>
                                <th>BANK / MERK / INSTITUSI</th>
                                <th>LOKASI</th>
                                <th>THN</th>
                                <th class="text-end">SALDO SAAT INI</th>
                                <th class="text-end">HARGA PEROLEHAN</th>
                                <th>INFO LAIN</th>
                                <th>KURS</th>
                                <th class="text-end">NILAI KURS</th>
                                <th class="text-end">SALDO BENTUK AWAL</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($g['rows'] as $idx => $item)
                            <tr>
                                <td>{{ $idx + 1 }}</td>
                                <td><code>{{ $item['kode'] }}</code> <span class="badge bg-light text-dark">{{ $sheetCode }}</span></td>
                                <td>{{ $item['deskripsi'] ?? '' }}</td>
                                <td>{{ $item['nomor_akun'] ?? $item['nopol_sertifikat'] ?? '' }}</td>
                                <td>{{ $item['atas_nama'] ?? $item['nama_pihak'] ?? '' }}</td>
                                <td>{{ $item['nama_bank_institusi'] ?? $item['merk_tipe'] ?? '' }}</td>
                                <td>{{ $item['lokasi_harta'] ?? '' }}</td>
                                <td>{{ $item['tahun_perolehan'] ?? $item['tahun_mulai'] ?? '' }}</td>
                                <td class="text-end">{{ number_format($item['saldo_saat_ini'] ?? 0, 0, ',', '.') }}</td>
                                <td class="text-end">{{ number_format($item['harga_perolehan'] ?? ($item['saldo_bentuk_awal'] ?? 0), 0, ',', '.') }}</td>
                                <td class="small text-muted">{{ $item['detail_info'] ?? '' }} {{ $item['ukuran_tanah'] ?? '' }} {{ $item['ukuran_bangunan'] ?? '' }}</td>
                                <td>{{ !empty($item['kurs']) ? $item['kurs'] : '-' }}</td>
                                <td class="text-end">{{ ($item['nilai_kurs'] ?? 0) > 0 ? number_format($item['nilai_kurs'], 2, ',', '.') : '-' }}</td>
                                <td class="text-end">{{ number_format($item['saldo_bentuk_awal'] ?? 0, 2, ',', '.') }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
            @endforeach
        </div>

        <form method="POST" action="{{ route('cms.lampiran-spt.import.confirm') }}" class="d-flex justify-content-between mt-3">
            @csrf
            <input type="hidden" name="temp_path" value="{{ $tempPath }}">
            <input type="hidden" name="client_id" value="{{ $clientId }}">
            <input type="hidden" name="tahun" value="{{ $tahun }}">
            <a href="{{ route('cms.lampiran-spt.index') }}" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left me-1"></i> Kembali
            </a>
            @if($validCount > 0)
            <button type="submit" class="btn btn-success px-4">
                <i class="bi bi-check-lg me-1"></i> Konfirmasi Import (replace total)
            </button>
            @endif
        </form>
        @else
        <div class="text-center text-muted py-5">
            <i class="bi bi-inbox display-4 d-block mb-2 text-secondary opacity-50"></i>
            Tidak ada data yang ditemukan.
        </div>
        @endif
    </div>
</div>
@endsection
