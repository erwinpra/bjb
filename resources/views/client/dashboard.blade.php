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
    <style>
    .collapse-toggle { cursor: pointer; user-select: none; }
    .collapse-toggle:hover { background-color: #e9ecef !important; }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-success shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-semibold" href="#">
                <i class="bi bi-person-badge me-2"></i>{{ $client->nama_client }}
                @if($clientRole)
                    <span class="badge bg-light text-success ms-2 small">{{ $clientRole->name }}</span>
                @endif
            </a>
            <div class="d-flex align-items-center gap-2">
                <span class="text-white-50 small d-none d-md-inline">NPWP: {{ $client->npwp ?? '-' }}</span>
                @if($client->hasClientPermission('dashboard.change-password'))
                <button type="button" class="btn btn-sm btn-outline-light" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                    <i class="bi bi-key me-1"></i>Ganti Password
                </button>
                @endif
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
            @if($allClients->isNotEmpty())
            <div class="col-md-3">
                <label class="form-label fw-semibold small text-muted">Lihat Client</label>
                <select id="viewClientFilter" class="form-select">
                    @if($client->hasClientPermission('client.view-all'))
                        <option value="{{ Auth::guard('client')->user()->id }}">-- Akun Saya --</option>
                        @foreach($allClients as $c)
                            <option value="{{ $c->id }}" {{ request('view_client_id') == $c->id ? 'selected' : '' }}>
                                {{ $c->nama_client }} ({{ $c->npwp ?? '-' }})
                            </option>
                        @endforeach
                    @endif
                </select>
            </div>
            @endif
            @if($client->hasClientPermission('dashboard.export'))
            <div class="col-md-auto d-flex gap-2">
                <a href="{{ route('client.dashboard.export-pdf', ['tahun' => $tahun]) }}" class="btn btn-sm btn-danger export-link">
                    <i class="bi bi-filetype-pdf me-1"></i> PDF
                </a>
                <a href="{{ route('client.dashboard.export-excel', ['tahun' => $tahun]) }}" class="btn btn-sm btn-success export-link">
                    <i class="bi bi-file-earmark-spreadsheet me-1"></i> Excel
                </a>
            </div>
            @endif
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
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h6 class="fw-semibold mb-0"><i class="bi bi-bar-chart-line me-2"></i>Recap</h6>
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

        {{-- Cabang Tabs --}}
        <div id="cabangSection" class="mb-4 d-none">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white py-2 d-flex align-items-center gap-2 flex-wrap">
                    <small class="fw-semibold text-muted me-2">Rincian Omset:</small>
                    <ul class="nav nav-pills" id="cabangTab" role="tablist" style="font-size:0.85rem"></ul>
                </div>
                <div class="card-body p-0">
                    <div class="tab-content" id="cabangTabContent"></div>
                </div>
            </div>
        </div>

        {{-- Charts --}}
        <div class="row g-4">
            <div class="col-md-7">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-white py-3">
                        <h6 class="fw-semibold mb-0"><i class="bi bi-bar-chart-line me-2"></i>Omset Per Bulan</h6>
                    </div>
                    <div class="card-body">
                        <canvas id="omsetChart" height="250"></canvas>
                        <div id="noData" class="text-center text-muted py-5 d-none">
                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                            Belum ada data transaksi untuk tahun ini.
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-header bg-white py-3">
                        <h6 class="fw-semibold mb-0"><i class="bi bi-pie-chart me-2"></i>Komposisi Harta</h6>
                    </div>
                    <div class="card-body d-flex align-items-center justify-content-center">
                        <canvas id="hartaChart" height="250"></canvas>
                        <div id="noHarta" class="text-center text-muted py-5 d-none">
                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                            Belum ada data harta.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    const bulanLabels = ['Jan','Feb','Mar','Apr','Mei','Jun','Jul','Agu','Sep','Okt','Nov','Des'];
    let omsetChart = null;
    let hartaChart = null;

    function formatNum(v) {
        return Number(v || 0).toLocaleString('id-ID');
    }

    function formatRp(v) {
        if (!v || v === 0) return '';
        return 'Rp ' + formatNum(v);
    }

    let _dashboardData = null;

    function loadData(tahun) {
        const viewClient = document.getElementById('viewClientFilter');
        let url = '/client/dashboard/data?tahun=' + tahun;
        if (viewClient && viewClient.value) {
            url += '&view_client_id=' + viewClient.value;
        }
        fetch(url)
            .then(res => res.json())
            .then(data => {
                _dashboardData = data;
                document.getElementById('totalHarta').textContent = formatNum(data.total_harta);
                document.getElementById('totalOmset').textContent = formatNum(data.total_omset);
                document.getElementById('totalPph').textContent = formatNum(data.total_pph);

                renderCabangTabs(data);
                // Show charts for first tab (induk) by default
                updateChartsForTab(data, 0);
            });
    }

    function updateChartsForTab(data, idx) {
        var tabs = data.tabs || [];
        if (!tabs.length) {
            renderOmsetChart(data);
            renderHartaChart(data);
            return;
        }
        var tab = tabs[idx] || tabs[0];
        var tabHarta = tab.harta || { total: 0, detail: [], by_kategori: { labels: [], values: [], colors: [] } };
        // Build per-tab data object for chart rendering
        var tabData = {
            exists: tab.detail_bulan && tab.detail_bulan.some(function(r) { return r.omset; }),
            omset_per_bulan: tab.detail_bulan ? tab.detail_bulan.map(function(r) { return parseNum(r.omset); }) : [],
            total_omset: tab.total_omset,
            total_pph: tab.total_potongan,
            total_harta: tabHarta.total,
            harta_detail: tabHarta.detail,
            harta_by_kategori: tabHarta.by_kategori,
        };
        renderOmsetChart(tabData);
        renderHartaChart(tabData);
    }

    function renderHartaModal() {
        var data = _dashboardData;
        var hartaDiv = document.getElementById('hartaDetailContent');
        var allTabs = data.tabs || [];

        // Collect all harta from all tabs
        var allHarta = [];
        allTabs.forEach(function(tab) {
            if (tab.harta && tab.harta.detail) {
                allHarta = allHarta.concat(tab.harta.detail);
            }
        });

        renderHartaDetailContent(hartaDiv, allHarta);
    }

    function renderHartaDetailContent(container, detail) {
        if (detail && detail.length) {
            var groups = {};
            detail.forEach(function(h) {
                if (!groups[h.kategori]) groups[h.kategori] = [];
                groups[h.kategori].push(h);
            });
            var html = '<div class="p-0">';
            var collapseIdx = 0;
            Object.keys(groups).forEach(function(kat) {
                var items = groups[kat];
                var katTotal = items.reduce(function(s, h) { return s + h.nilai; }, 0);
                var colId = 'hartaCollapse-' + collapseIdx;
                html += '<div class="card border-0 border-bottom rounded-0">';
                html += '<div class="card-header bg-light py-1 collapse-toggle" role="button" data-bs-toggle="collapse" data-bs-target="#' + colId + '" aria-expanded="false">';
                html += '<h6 class="fw-semibold mb-0 small d-flex justify-content-between align-items-center text-primary">' + kat + '<span class="d-flex align-items-center gap-2"><span class="text-muted fw-normal small">Rp ' + formatNum(katTotal) + '</span><i class="bi bi-chevron-right collapse-icon"></i></span></h6></div>';
                html += '<div class="collapse" id="' + colId + '"><div class="card-body p-0"><table class="table table-sm mb-0"><thead class="table-light"><tr><th class="ps-4">Item</th><th class="text-end pe-4">Nilai</th></tr></thead><tbody>';
                items.forEach(function(h) {
                    html += '<tr><td class="ps-4">' + h.nama + '</td><td class="text-end pe-4">Rp ' + formatNum(h.nilai) + '</td></tr>';
                });
                html += '<tr class="table-secondary fw-bold"><td class="ps-4">Total</td><td class="text-end pe-4">Rp ' + formatNum(katTotal) + '</td></tr>';
                html += '</tbody></table></div></div></div>';
                collapseIdx++;
            });
            html += '</div>';
            container.innerHTML = html;
            attachCollapseToggle();
        } else {
            container.innerHTML = '<div class="text-center text-muted py-5"><i class="bi bi-inbox fs-1 d-block mb-2"></i>Tidak ada data harta.</div>';
        }
    }

    function renderCabangTabs(data) {
        var tabs = data.tabs || [];
        var section = document.getElementById('cabangSection');
        var tabNav = document.getElementById('cabangTab');
        var tabContent = document.getElementById('cabangTabContent');

        tabNav.innerHTML = '';
        tabContent.innerHTML = '';

        if (!tabs.length) { section.classList.add('d-none'); return; }

        section.classList.remove('d-none');

        var cabangCount = data.cabang_count || 0;

        tabs.forEach(function(tab, idx) {
            var isActive = idx === 0;
            var tabId = 'tab-' + idx;
            var isInduk = tab.key === 'induk';

            // Nav pill — use NPWP as label
            var tabLabel = tab.npwp || tab.label || '-';
            var li = document.createElement('li');
            li.className = 'nav-item';
            var btn = document.createElement('button');
            btn.className = 'nav-link' + (isActive ? ' active' : '');
            btn.id = tabId + '-tab';
            btn.setAttribute('data-bs-toggle', 'pill');
            btn.setAttribute('data-bs-target', '#' + tabId);
            btn.setAttribute('type', 'button');
            btn.setAttribute('role', 'tab');
            btn.textContent = tabLabel;
            btn.addEventListener('click', function() {
                updateChartsForTab(_dashboardData, idx);
            });
            li.appendChild(btn);
            tabNav.appendChild(li);

            // Tab content
            var html = '<div class="tab-pane' + (isActive ? ' show active' : '') + '" id="' + tabId + '" role="tabpanel">';
            html += '<div class="p-3">';
            html += '<div class="mb-2"><small class="text-muted">' + escHtml(tab.label) + ' &middot; NPWP: ' + escHtml(tab.npwp || '-') + ' &middot; KPP: ' + escHtml(tab.kpp || '-') + '</small></div>';
            html += '<div class="table-responsive">';
            html += '<table class="table table-sm table-bordered mb-0" style="white-space:nowrap"><thead class="table-light"><tr>';
            html += '<th>Bulan</th><th class="text-end">Omset</th><th class="text-end">Total Peredaran Bruto</th>';
            if (isInduk) {
                html += '<th class="text-end">Total Peredaran Bruto Akum' + (cabangCount > 0 ? ' (' + cabangCount + ' Cabang)' : '') + '</th>';
            }
            html += '<th class="text-end">PPH Final</th><th class="text-end">PPh Final yg harus dibayar</th>';
            html += '</tr></thead><tbody>';

            var tabOmset = 0;
            var tabPotongan = 0;
            (tab.detail_bulan || []).forEach(function(row) {
                tabOmset += parseNum(row.omset);
                tabPotongan += parseNum(row.pphBayar);
                html += '<tr>';
                html += '<td>' + row.bulan + '</td>';
                html += '<td class="text-end">' + (row.omset || '-') + '</td>';
                html += '<td class="text-end">' + (row.totalBruto || '-') + '</td>';
                if (isInduk) {
                    html += '<td class="text-end">' + (row.omset ? (row.totalBrutoAkum || '-') : '-') + '</td>';
                }
                html += '<td class="text-end">' + (row.pphFinal || '-') + '</td>';
                html += '<td class="text-end">' + (row.pphBayar || '-') + '</td>';
                html += '</tr>';
            });

            html += '<tr class="table-secondary fw-bold"><td>Total</td><td class="text-end">Rp ' + formatNum(tabOmset) + '</td><td></td>';
            if (isInduk) { html += '<td></td>'; }
            html += '<td></td><td class="text-end">Rp ' + formatNum(tabPotongan) + '</td></tr>';
            html += '</tbody></table></div></div></div>';
            tabContent.innerHTML += html;
        });
    }

    function parseNum(str) {
        if (!str) return 0;
        var m = str.replace(/[^0-9]/g, '');
        return parseInt(m || '0', 10);
    }

    function escHtml(str) {
        var div = document.createElement('div');
        div.textContent = str;
        return div.innerHTML;
    }

    function attachCollapseToggle() {
        document.querySelectorAll('#hartaDetailContent .collapse-toggle').forEach(function(header) {
            var target = document.querySelector(header.getAttribute('data-bs-target'));
            if (target) {
                target.addEventListener('show.bs.collapse', function() {
                    var icon = header.querySelector('.collapse-icon');
                    if (icon) { icon.classList.remove('bi-chevron-right'); icon.classList.add('bi-chevron-up'); }
                });
                target.addEventListener('hide.bs.collapse', function() {
                    var icon = header.querySelector('.collapse-icon');
                    if (icon) { icon.classList.remove('bi-chevron-up'); icon.classList.add('bi-chevron-right'); }
                });
            }
        });
    }

    function renderHartaDetail(data) {
        const hartaDiv = document.getElementById('hartaDetailContent');
        if (data.harta_detail && data.harta_detail.length) {
            var groups = {};
            data.harta_detail.forEach(function(h) {
                if (!groups[h.kategori]) groups[h.kategori] = [];
                groups[h.kategori].push(h);
            });
            var html = '<div class="p-0">';
            var collapseIdx = 0;
            Object.keys(groups).forEach(function(kat) {
                var items = groups[kat];
                var katTotal = items.reduce(function(s, h) { return s + h.nilai; }, 0);
                var colId = 'hartaDetailCollapse-' + collapseIdx;
                html += '<div class="card border-0 border-bottom rounded-0">';
                html += '<div class="card-header bg-light py-1 collapse-toggle" role="button" data-bs-toggle="collapse" data-bs-target="#' + colId + '" aria-expanded="false">';
                html += '<h6 class="fw-semibold mb-0 small d-flex justify-content-between align-items-center text-primary">' + kat + '<span class="d-flex align-items-center gap-2"><span class="text-muted fw-normal small">Rp ' + formatNum(katTotal) + '</span><i class="bi bi-chevron-right collapse-icon"></i></span></h6></div>';
                html += '<div class="collapse" id="' + colId + '"><div class="card-body p-0"><table class="table table-sm mb-0"><thead class="table-light"><tr><th class="ps-4">Item</th><th class="text-end pe-4">Nilai</th></tr></thead><tbody>';
                items.forEach(function(h) {
                    html += '<tr><td class="ps-4">' + h.nama + '</td><td class="text-end pe-4">Rp ' + formatNum(h.nilai) + '</td></tr>';
                });
                html += '<tr class="table-secondary fw-bold"><td class="ps-4">Total</td><td class="text-end pe-4">Rp ' + formatNum(katTotal) + '</td></tr>';
                html += '</tbody></table></div></div></div>';
                collapseIdx++;
            });
            html += '</div>';
            hartaDiv.innerHTML = html;
            attachCollapseToggle();
        } else {
            hartaDiv.innerHTML = '<div class="text-center text-muted py-5"><i class="bi bi-inbox fs-1 d-block mb-2"></i>Tidak ada data harta.</div>';
        }
    }

    function renderOmsetChart(data) {
        const canvas = document.getElementById('omsetChart');
        const noData = document.getElementById('noData');

        if (!data.exists || data.omset_per_bulan.every(function(v) { return v === 0; })) {
            canvas.classList.add('d-none');
            noData.classList.remove('d-none');
            return;
        }

        canvas.classList.remove('d-none');
        noData.classList.add('d-none');

        if (omsetChart) omsetChart.destroy();

        omsetChart = new Chart(canvas, {
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
                maintainAspectRatio: false,
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
    }

    function renderHartaChart(data) {
        const canvas = document.getElementById('hartaChart');
        const noHarta = document.getElementById('noHarta');

        if (!data.harta_by_kategori || !data.harta_by_kategori.values || data.harta_by_kategori.values.every(function(v) { return v === 0; })) {
            canvas.classList.add('d-none');
            noHarta.classList.remove('d-none');
            return;
        }

        canvas.classList.remove('d-none');
        noHarta.classList.add('d-none');

        if (hartaChart) hartaChart.destroy();

        hartaChart = new Chart(canvas, {
            type: 'doughnut',
            data: {
                labels: data.harta_by_kategori.labels,
                datasets: [{
                    data: data.harta_by_kategori.values,
                    backgroundColor: data.harta_by_kategori.colors,
                    borderWidth: 2,
                    borderColor: '#fff',
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { boxWidth: 12, padding: 12, font: { size: 11 } }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(ctx) {
                                var total = ctx.dataset.data.reduce(function(a, b) { return a + b; }, 0);
                                var pct = ((ctx.parsed / total) * 100).toFixed(1);
                                return ctx.label + ': Rp ' + formatNum(ctx.parsed) + ' (' + pct + '%)';
                            }
                        }
                    }
                }
            }
        });
    }

    document.getElementById('tahunFilter').addEventListener('change', function() {
        const tahun = this.value;
        loadData(tahun);
        document.querySelectorAll('.export-link').forEach(function(a) {
            const url = new URL(a.href);
            url.searchParams.set('tahun', tahun);
            const vc = document.getElementById('viewClientFilter');
            if (vc && vc.value) url.searchParams.set('view_client_id', vc.value);
            a.href = url.toString();
        });
    });

    const viewClientFilter = document.getElementById('viewClientFilter');
    if (viewClientFilter) {
        viewClientFilter.addEventListener('change', function() {
            const tahun = document.getElementById('tahunFilter').value;
            loadData(tahun);
            document.querySelectorAll('.export-link').forEach(function(a) {
                const url = new URL(a.href);
                url.searchParams.set('tahun', tahun);
                if (this.value) url.searchParams.set('view_client_id', this.value);
                a.href = url.toString();
            });
        });
    }

    // Render harta modal with cabang tabs when opened
    document.getElementById('hartaModal').addEventListener('shown.bs.modal', function() {
        renderHartaModal();
    });

    loadData({{ $tahun }});
    </script>
</body>
</html>
