<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard - {{ config('app.name') }}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-dark bg-success shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-semibold" href="#">
                <i class="bi bi-person-badge me-2"></i>{{ $client->nama_client }}
            </a>
            <div class="d-flex align-items-center gap-2">
                <span class="text-white-50 small d-none d-md-inline">NPWP: {{ $client->npwp ?? '-' }}</span>
                <button type="button" class="btn btn-sm btn-outline-light" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                    <i class="bi bi-key me-1"></i>Ganti Password
                </button>
                <a href="{{ route('client.logout') }}" class="btn btn-sm btn-outline-light"
                   onclick="event.preventDefault(); document.getElementById('logoutForm').submit();">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </a>
                <form id="logoutForm" action="{{ route('client.logout') }}" method="POST" class="d-none">
                    @csrf
                </form>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        {{-- Filter --}}
        <div class="row mb-4 align-items-end">
            <div class="col-md-3">
                <label class="form-label fw-semibold small text-muted">Tahun</label>
                <select id="tahunFilter" class="form-select">
                    @for($y = now()->year; $y >= now()->year - 10; $y--)
                        <option value="{{ $y }}" {{ $y == $tahun ? 'selected' : '' }}>{{ $y }}</option>
                    @endfor
                </select>
            </div>
            <div class="col-md-auto d-flex gap-2">
                <a href="{{ route('client.dashboard.export-pdf', ['tahun' => $tahun]) }}" class="btn btn-sm btn-danger export-link">
                    <i class="bi bi-filetype-pdf me-1"></i> PDF
                </a>
                <a href="{{ route('client.dashboard.export-excel', ['tahun' => $tahun]) }}" class="btn btn-sm btn-success export-link">
                    <i class="bi bi-file-earmark-spreadsheet me-1"></i> Excel
                </a>
            </div>
        </div>

        {{-- Summary Cards --}}
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="card border-0 shadow-sm bg-primary bg-opacity-10" style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#hartaModal">
                    <div class="card-body text-center py-4">
                        <i class="bi bi-building fs-1 text-primary"></i>
                        <h5 class="fw-bold mt-2 mb-0">Rp <span id="totalHarta">0</span></h5>
                        <small class="text-muted">Total Harta <i class="bi bi-chevron-right small ms-1"></i></small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm bg-warning bg-opacity-10">
                    <div class="card-body text-center py-4">
                        <i class="bi bi-graph-up-arrow fs-1 text-warning"></i>
                        <h5 class="fw-bold mt-2 mb-0">Rp <span id="totalOmset">0</span></h5>
                        <small class="text-muted">Total Omset</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 shadow-sm bg-danger bg-opacity-10">
                    <div class="card-body text-center py-4">
                        <i class="bi bi-receipt fs-1 text-danger"></i>
                        <h5 class="fw-bold mt-2 mb-0">Rp <span id="totalPph">0</span></h5>
                        <small class="text-muted">Total PPh Final</small>
                    </div>
                </div>
            </div>
        </div>

        {{-- Harta Detail Modal --}}
        <div class="modal fade" id="hartaModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h6 class="fw-semibold mb-0"><i class="bi bi-building me-2"></i>Detail Harta</h6>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-0">
                        <div id="hartaDetailContent" class="text-center text-muted py-5">
                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                            Tidak ada data harta.
                        </div>
                    </div>
                    <div class="modal-footer border-top">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        {{-- Change Password Modal --}}
        <div class="modal fade" id="changePasswordModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <form method="POST" action="{{ route('client.change-password') }}">
                        @csrf
                        <div class="modal-header bg-success text-white">
                            <h6 class="fw-semibold mb-0"><i class="bi bi-key me-2"></i>Ganti Password</h6>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            @if(session('success'))
                                <div class="alert alert-success py-2 small">{{ session('success') }}</div>
                            @endif
                            @if($errors->any())
                                <div class="alert alert-danger py-2 small">{{ $errors->first() }}</div>
                            @endif
                            <div class="mb-3">
                                <label class="form-label small fw-semibold">Password Saat Ini</label>
                                <input type="password" name="current_password" required class="form-control" placeholder="Masukkan password saat ini">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-semibold">Password Baru</label>
                                <input type="password" name="new_password" required class="form-control" placeholder="Minimal 6 karakter" minlength="6">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-semibold">Konfirmasi Password Baru</label>
                                <input type="password" name="confirm_password" required class="form-control" placeholder="Ulangi password baru">
                            </div>
                        </div>
                        <div class="modal-footer border-top">
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Batal</button>
                            <button type="submit" class="btn btn-success px-4"><i class="bi bi-check-lg me-1"></i>Simpan</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        {{-- Chart --}}
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-white py-3">
                <h6 class="fw-semibold mb-0"><i class="bi bi-bar-chart-line me-2"></i>Omset Per Bulan</h6>
            </div>
            <div class="card-body">
                <canvas id="omsetChart" height="300"></canvas>
                <div id="noData" class="text-center text-muted py-5 d-none">
                    <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                    Belum ada data transaksi untuk tahun ini.
                </div>
            </div>
        </div>
    </div>

    <script>
    const bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    let chart = null;

    function formatNum(v) {
        return Number(v || 0).toLocaleString('id-ID');
    }

    function loadData(tahun) {
        fetch('/client/dashboard/data?tahun=' + tahun)
            .then(res => res.json())
            .then(data => {
                document.getElementById('totalHarta').textContent = formatNum(data.total_harta);
                document.getElementById('totalOmset').textContent = formatNum(data.total_omset);
                document.getElementById('totalPph').textContent = formatNum(data.total_pph);

                // Harta detail
                const hartaDiv = document.getElementById('hartaDetailContent');
                if (data.harta_detail && data.harta_detail.length) {
                    let table = `<table class="table table-sm table-hover mb-0"><thead class="table-light"><tr><th class="ps-4">Nama</th><th class="text-end pe-4">Nilai</th></tr></thead><tbody>`;
                    data.harta_detail.forEach(h => {
                        table += `<tr><td class="ps-4">${h.nama}</td><td class="text-end pe-4">Rp ${formatNum(h.nilai)}</td></tr>`;
                    });
                    table += `</tbody></table>`;
                    hartaDiv.innerHTML = table;
                } else {
                    hartaDiv.innerHTML = `<div class="text-center text-muted py-5"><i class="bi bi-inbox fs-1 d-block mb-2"></i>Tidak ada data harta.</div>`;
                }

                const canvas = document.getElementById('omsetChart');
                const noData = document.getElementById('noData');

                if (!data.exists || data.omset_per_bulan.every(v => v === 0)) {
                    canvas.classList.add('d-none');
                    noData.classList.remove('d-none');
                    return;
                }

                canvas.classList.remove('d-none');
                noData.classList.add('d-none');

                if (chart) chart.destroy();

                chart = new Chart(canvas, {
                    type: 'line',
                    data: {
                        labels: bulanLabels,
                        datasets: [{
                            label: 'Omset (Rp)',
                            data: data.omset_per_bulan,
                            borderColor: '#198754',
                            backgroundColor: 'rgba(25, 135, 84, 0.1)',
                            fill: true,
                            tension: 0.3,
                            pointBackgroundColor: '#198754',
                            pointRadius: 4,
                            borderWidth: 2,
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: function(ctx) {
                                        return 'Rp ' + formatNum(ctx.parsed.y);
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(v) { return 'Rp' + formatNum(v); }
                                }
                            }
                        }
                    }
                });
            });
    }

    document.getElementById('tahunFilter').addEventListener('change', function() {
        const tahun = this.value;
        loadData(tahun);
        document.querySelectorAll('.export-link').forEach(a => {
            const url = new URL(a.href);
            url.searchParams.set('tahun', tahun);
            a.href = url.toString();
        });
    });

    loadData({{ $tahun }});
    </script>
</body>
</html>
