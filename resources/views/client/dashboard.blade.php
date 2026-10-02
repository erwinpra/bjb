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
    .modal-85 { max-width: 85vw; }
    @media (max-width: 576px) { .modal-85 { max-width: 95vw; } }
    .harta-scroll { overflow-x: auto; }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-success shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-semibold" href="#">
                <i class="bi bi-person-badge me-2"></i>{{ $client->nama_client }}
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
            <div class="col-md-2">
                <label class="form-label fw-semibold small text-muted">Tahun</label>
                <select id="tahunFilter" class="form-select">
                    @for($y = 2025; $y <= now()->year; $y++)
                        <option value="{{ $y }}" {{ $y == $tahun ? 'selected' : '' }}>{{ $y }}</option>
                    @endfor
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label fw-semibold small text-muted">Bandingkan Tahun <span class="text-muted fw-normal">(opsional)</span></label>
                <select id="vsTahunFilter" class="form-select">
                    <option value="">-- Tidak ada --</option>
                    @for($y = 2025; $y <= now()->year; $y++)
                        <option value="{{ $y }}">{{ $y }}</option>
                    @endfor
                </select>
            </div>

            @if($allClients->isNotEmpty())
            <div class="col-md-3">
                <label class="form-label fw-semibold small text-muted">Lihat</label>
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
                <a href="{{ route('client.dashboard.export-pdf', ['tahun' => $tahun] + (request('view_client_id') ? ['view_client_id' => request('view_client_id')] : [])) }}" class="btn btn-sm btn-danger export-link">
                    <i class="bi bi-filetype-pdf me-1"></i> PDF
                </a>
                <a href="{{ route('client.dashboard.export-excel', ['tahun' => $tahun] + (request('view_client_id') ? ['view_client_id' => request('view_client_id')] : [])) }}" class="btn btn-sm btn-success export-link">
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
            <div class="modal-dialog modal-85 modal-dialog-centered modal-dialog-scrollable">
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

        {{-- Harta Item Detail Modal --}}
        <div class="modal fade" id="hartaItemModal" tabindex="-1">
            <div class="modal-dialog modal-85 modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-white">
                        <h6 class="fw-semibold mb-0"><i class="bi bi-list-ul me-2"></i>Detail Harta</h6>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-0" id="hartaItemBody"></div>
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
    let _bandingData = null;

    function loadData(tahun) {
        const viewClient = document.getElementById('viewClientFilter');
        const vsTahun = document.getElementById('vsTahunFilter').value;
        let url = '/client/dashboard/data?tahun=' + tahun;
        if (vsTahun) {
            url += '&tahun_banding=' + vsTahun;
        }
        if (viewClient && viewClient.value) {
            url += '&view_client_id=' + viewClient.value;
        }
        fetch(url)
            .then(res => res.json())
            .then(data => {
                _dashboardData = data;
                _bandingData = data.banding || null;

                var banding = _bandingData;
                document.getElementById('totalHarta').textContent = formatNum(data.total_harta);
                document.getElementById('totalOmset').textContent = formatNum(data.total_omset);
                document.getElementById('totalPph').textContent = formatNum(data.total_pph);

                var hartaCard = document.getElementById('totalHarta').closest('.card-body');
                var omsetCard = document.getElementById('totalOmset').closest('.card-body');
                var pphCard = document.getElementById('totalPph').closest('.card-body');
                [hartaCard, omsetCard, pphCard].forEach(function(c) {
                    var old = c.querySelector('.vs-label');
                    if (old) old.remove();
                });
                if (banding) {
                    var vsTahunLabel = document.getElementById('vsTahunFilter').value;
                    var addVs = function(id, val) {
                        var el = document.getElementById(id);
                        var card = el.closest('.card-body');
                        var div = document.createElement('div');
                        div.className = 'vs-label small text-muted mt-1';
                        div.innerHTML = '<span class="fw-semibold">Thn ' + vsTahunLabel + ':</span> Rp ' + formatNum(val || 0);
                        card.appendChild(div);
                    };
                    addVs('totalHarta', banding.total_harta);
                    addVs('totalOmset', banding.total_omset);
                    addVs('totalPph', banding.total_pph);
                }

                renderCabangTabs(data);
                updateChartsForTab(data, 0);
            });
    }

    function updateChartsForTab(data, idx) {
        var tabs = data.tabs || [];
        var banding = _bandingData;
        var bandingTabs = banding ? (banding.tabs || []) : [];
        var vsTahun = document.getElementById('vsTahunFilter').value;

        if (!tabs.length) {
            renderOmsetChart(data, banding ? (banding.omset_per_bulan || null) : null, vsTahun);
            renderHartaChart(data);
            return;
        }
        var tab = tabs[idx] || tabs[0];
        var tabHarta = tab.harta || { total: 0, detail: [], by_kategori: { labels: [], values: [], colors: [] } };
        var tabData = {
            exists: tab.detail_bulan && tab.detail_bulan.some(function(r) { return r.omset; }),
            omset_per_bulan: tab.detail_bulan ? tab.detail_bulan.map(function(r) { return parseNum(r.omset); }) : [],
            total_omset: tab.total_omset,
            total_pph: tab.total_potongan,
            total_harta: tabHarta.total,
            harta_detail: tabHarta.detail,
            harta_by_kategori: tabHarta.by_kategori,
        };
        var bandingOmset = null;
        if (banding && bandingTabs[idx]) {
            var bt = bandingTabs[idx];
            bandingOmset = bt.detail_bulan ? bt.detail_bulan.map(function(r) { return parseNum(r.omset); }) : [];
        }
        renderOmsetChart(tabData, bandingOmset, vsTahun);
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
            var grandTotalPerolehan = 0;
            var hutangTotal = 0;
            Object.keys(groups).forEach(function(kat) {
                var items = groups[kat];
                var katTotal = items.reduce(function(s, h) { return s + h.nilai; }, 0);
                if (items[0] && items[0].kategori_id === 7) {
                    hutangTotal = katTotal;
                } else {
                    grandTotalPerolehan += katTotal;
                }
                var colId = 'hartaCollapse-' + collapseIdx;
                html += '<div class="card border-0 border-bottom rounded-0">';
                html += '<div class="card-header bg-light py-1 collapse-toggle" role="button" data-bs-toggle="collapse" data-bs-target="#' + colId + '" aria-expanded="false">';
                html += '<h6 class="fw-semibold mb-0 small d-flex justify-content-between align-items-center text-primary">' + kat + '<span class="d-flex align-items-center gap-2"><span class="text-muted fw-normal small">Rp ' + formatNum(katTotal) + '</span><i class="bi bi-chevron-right collapse-icon"></i></span></h6></div>';
                html += '<div class="collapse" id="' + colId + '"><div class="card-body p-0"><table class="table table-sm mb-0"><thead class="table-light"><tr><th class="ps-4">Item</th><th class="text-end pe-4">Nilai</th></tr></thead><tbody>';
                items.forEach(function(h) {
                    var rec = JSON.stringify(h.records || []).replace(/'/g, '&#39;');
                    html += '<tr class="harta-item-row" style="cursor:pointer" data-kat="' + (h.kategori_id || '') + '" data-records=\'' + rec + '\'><td class="ps-4">' + h.nama + '</td><td class="text-end pe-4">Rp ' + formatNum(h.nilai) + ' <i class="bi bi-chevron-right small text-muted ms-1"></i></td></tr>';
                });
                html += '<tr class="table-secondary fw-bold"><td class="ps-4">Total</td><td class="text-end pe-4">Rp ' + formatNum(katTotal) + '</td></tr>';
                html += '</tbody></table></div></div></div>';
                collapseIdx++;
            });
            var net = grandTotalPerolehan - hutangTotal;
            html += '<div class="p-3 border-top bg-light">';
            html += '<div class="d-flex justify-content-between small"><span class="fw-semibold">TOTAL PEROLEHAN</span><span>Rp ' + formatNum(grandTotalPerolehan) + '</span></div>';
            html += '<div class="d-flex justify-content-between small mt-1"><span class="fw-semibold">TOTAL HUTANG</span><span class="text-danger">Rp ' + formatNum(hutangTotal) + '</span></div>';
            html += '<hr class="my-1">';
            html += '<div class="d-flex justify-content-between fw-bold"><span>NET</span><span class="' + (net < 0 ? 'text-danger' : 'text-success') + '">Rp ' + formatNum(net) + '</span></div>';
            html += '</div>';
            html += '</div>';
            container.innerHTML = html;
            attachCollapseToggle();
        } else {
            container.innerHTML = '<div class="text-center text-muted py-5"><i class="bi bi-inbox fs-1 d-block mb-2"></i>Tidak ada data harta.</div>';
        }
    }

    function renderCabangTabs(data) {
        var tabs = data.tabs || [];
        var banding = _bandingData;
        var bandingTabs = banding ? (banding.tabs || []) : [];
        var section = document.getElementById('cabangSection');
        var tabNav = document.getElementById('cabangTab');
        var tabContent = document.getElementById('cabangTabContent');
        var vsTahun = document.getElementById('vsTahunFilter').value;

        tabNav.innerHTML = '';
        tabContent.innerHTML = '';

        if (!tabs.length) { section.classList.add('d-none'); return; }

        section.classList.remove('d-none');

        var cabangCount = data.cabang_count || 0;

        tabs.forEach(function(tab, idx) {
            var isActive = idx === 0;
            var tabId = 'tab-' + idx;
            var isInduk = tab.key === 'induk';
            var bandingTab = bandingTabs[idx] || null;

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

            var html = '<div class="tab-pane' + (isActive ? ' show active' : '') + '" id="' + tabId + '" role="tabpanel">';
            html += '<div class="p-3">';
            html += '<div class="mb-2"><small class="text-muted">' + escHtml(tab.label) + ' &middot; NPWP: ' + escHtml(tab.npwp || '-') + ' &middot; KPP: ' + escHtml(tab.kpp || '-') + '</small></div>';
            html += '<div class="table-responsive">';
            html += '<table class="table table-sm table-bordered mb-0" style="white-space:nowrap"><thead class="table-light">';
            if (bandingTab) {
                var tahunIni = document.getElementById('tahunFilter').value;
                html += '<tr><th rowspan="2">Bulan</th><th colspan="2" class="text-center">Omset</th><th colspan="2" class="text-center">PPH Final</th></tr>';
                html += '<tr><th class="text-end fw-normal"><strong>' + tahunIni + '</strong></th><th class="text-end fw-normal"><strong>' + vsTahun + '</strong></th><th class="text-end fw-normal"><strong>' + tahunIni + '</strong></th><th class="text-end fw-normal"><strong>' + vsTahun + '</strong></th></tr>';
            } else {
                html += '<tr><th>Bulan</th><th class="text-end">Omset</th><th class="text-end">Total Peredaran Bruto</th>';
                if (isInduk) {
                    html += '<th class="text-end">Total Peredaran Bruto Akum' + (cabangCount > 0 ? ' (' + cabangCount + ' Cabang)' : '') + '</th>';
                }
                html += '<th class="text-end">PPH Final</th><th class="text-end">PPh Final yg harus dibayar</th></tr>';
            }
            html += '</thead><tbody>';

            var tabOmset = 0, tabPphFinal = 0, tabPotongan = 0;
            var bandOmset = 0, bandPphFinal = 0, bandPotongan = 0;
            (tab.detail_bulan || []).forEach(function(row, ri) {
                var bRow = bandingTab ? (bandingTab.detail_bulan || [])[ri] : null;
                tabOmset += parseNum(row.omset);
                tabPphFinal += parseNum(row.pphFinal);
                tabPotongan += parseNum(row.pphBayar);
                if (bRow) { bandOmset += parseNum(bRow.omset); bandPphFinal += parseNum(bRow.pphFinal); bandPotongan += parseNum(bRow.pphBayar); }
                html += '<tr>';
                html += '<td>' + row.bulan + '</td>';
                html += '<td class="text-end">' + (row.omset || '-') + '</td>';
                if (bandingTab) { html += '<td class="text-end">' + (bRow && bRow.omset ? bRow.omset : '-') + '</td>'; }
                if (!bandingTab) {
                    html += '<td class="text-end">' + (row.totalBruto || '-') + '</td>';
                    if (isInduk) {
                        html += '<td class="text-end">' + (row.omset ? (row.totalBrutoAkum || '-') : '-') + '</td>';
                    }
                }
                html += '<td class="text-end">' + (row.pphFinal || '-') + '</td>';
                if (bandingTab) { html += '<td class="text-end">' + (bRow && bRow.pphFinal ? bRow.pphFinal : '-') + '</td>'; }
                if (!bandingTab) {
                    html += '<td class="text-end">' + (row.pphBayar || '-') + '</td>';
                }
                html += '</tr>';
            });

            html += '<tr class="table-secondary fw-bold"><td>Total</td>';
            html += '<td class="text-end">Rp ' + formatNum(tabOmset) + '</td>';
            if (bandingTab) { html += '<td class="text-end">Rp ' + formatNum(bandOmset) + '</td>'; }
            if (!bandingTab) {
                html += '<td></td>';
                if (isInduk) { html += '<td></td>'; }
                html += '<td class="text-end">Rp ' + formatNum(tabPotongan) + '</td>';
            }
            html += '<td class="text-end">Rp ' + formatNum(tabPphFinal) + '</td>';
            if (bandingTab) { html += '<td class="text-end">Rp ' + formatNum(bandPphFinal) + '</td>'; }
            html += '</tr>';
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
            var grandTotalPerolehan = 0;
            var hutangTotal = 0;
            Object.keys(groups).forEach(function(kat) {
                var items = groups[kat];
                var katTotal = items.reduce(function(s, h) { return s + h.nilai; }, 0);
                if (items[0] && items[0].kategori_id === 7) {
                    hutangTotal = katTotal;
                } else {
                    grandTotalPerolehan += katTotal;
                }
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
            var net = grandTotalPerolehan - hutangTotal;
            html += '<div class="p-3 border-top bg-light">';
            html += '<div class="d-flex justify-content-between small"><span class="fw-semibold">TOTAL PEROLEHAN</span><span>Rp ' + formatNum(grandTotalPerolehan) + '</span></div>';
            html += '<div class="d-flex justify-content-between small mt-1"><span class="fw-semibold">TOTAL HUTANG</span><span class="text-danger">Rp ' + formatNum(hutangTotal) + '</span></div>';
            html += '<hr class="my-1">';
            html += '<div class="d-flex justify-content-between fw-bold"><span>NET</span><span class="' + (net < 0 ? 'text-danger' : 'text-success') + '">Rp ' + formatNum(net) + '</span></div>';
            html += '</div>';
            html += '</div>';
            hartaDiv.innerHTML = html;
            attachCollapseToggle();
        } else {
            hartaDiv.innerHTML = '<div class="text-center text-muted py-5"><i class="bi bi-inbox fs-1 d-block mb-2"></i>Tidak ada data harta.</div>';
        }
    }

    function renderOmsetChart(data, bandingOmset, vsTahun) {
        const canvas = document.getElementById('omsetChart');
        const noData = document.getElementById('noData');

        var noDataAll = (data.omset_per_bulan || []).every(function(v) { return v === 0; });
        if (bandingOmset) {
            noDataAll = noDataAll && bandingOmset.every(function(v) { return v === 0; });
        }
        if (noDataAll) {
            canvas.classList.add('d-none');
            noData.classList.remove('d-none');
            return;
        }

        canvas.classList.remove('d-none');
        noData.classList.add('d-none');

        if (omsetChart) omsetChart.destroy();

        var datasets = [{
            label: 'Omset (Rp)',
            data: data.omset_per_bulan,
            borderColor: '#198754',
            backgroundColor: 'rgba(25, 135, 84, 0.1)',
            fill: true,
            tension: 0.3,
            pointBackgroundColor: '#198754',
            pointRadius: 4,
            borderWidth: 2,
        }];

        if (bandingOmset) {
            datasets.push({
                label: 'Omset ' + (vsTahun || '') + ' (Rp)',
                data: bandingOmset,
                borderColor: '#0d6efd',
                backgroundColor: 'rgba(13, 110, 253, 0.1)',
                fill: true,
                tension: 0.3,
                pointBackgroundColor: '#0d6efd',
                pointRadius: 4,
                borderWidth: 2,
                borderDash: [5, 3],
            });
        }

        omsetChart = new Chart(canvas, {
            type: 'line',
            data: { labels: bulanLabels, datasets: datasets },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: !!bandingOmset,
                        position: 'top',
                        labels: { boxWidth: 12, padding: 12, font: { size: 11 } }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(ctx) {
                                return ctx.dataset.label + ': Rp ' + formatNum(ctx.parsed.y);
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

    // Render harta modal when opened
    document.getElementById('hartaModal').addEventListener('shown.bs.modal', function() {
        renderHartaModal();
    });

    // Kolom popup detail harta per kategori (ikut header tabel admin per sheet).
    // Saldo Bentuk Awal ditambahkan otomatis jika ada datanya.
    function hartaColumns(katId) {
        function T(v) { return (v === null || v === undefined || v === '') ? '-' : v; }
        function R(v) { return 'Rp ' + formatNum(v); }
        var cols;
        switch (Number(katId)) {
            case 2: cols = [ // PIUTANG
                {h:'Deskripsi', f:function(r){ return T(r.deskripsi); }},
                {h:'Lokasi Penerima', f:function(r){ return T(r.lokasi_harta); }},
                {h:'NIK/NPWP', f:function(r){ return T(r.nik_npwp_pihak); }},
                {h:'Nama Penerima', f:function(r){ return T(r.nama_pihak || r.atas_nama); }},
                {h:'Thn Mulai', f:function(r){ return T(r.tahun_mulai || r.tahun_perolehan); }},
                {h:'Nilai Saat Ini', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
            ]; break;
            case 3: cols = [ // INVESTASI
                {h:'Deskripsi', f:function(r){ return T(r.deskripsi); }},
                {h:'Lokasi', f:function(r){ return T(r.lokasi_harta); }},
                {h:'NPWP', f:function(r){ return T(r.nik_npwp_pihak); }},
                {h:'Nama Institusi', f:function(r){ return T(r.nama_pihak || r.merk_tipe); }},
                {h:'Nomor Akun', f:function(r){ return T(r.nomor_akun || r.nopol_sertifikat); }},
                {h:'Thn Perolehan', f:function(r){ return T(r.tahun_perolehan); }},
                {h:'Harga Perolehan', f:function(r){ return R(r.harga_perolehan || r.saldo_bentuk_awal); }},
                {h:'Nilai Saat Ini', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
            ]; break;
            case 4: cols = [ // HARTA BERGERAK
                {h:'Merk/Tipe', f:function(r){ return T(r.merk_tipe || r.deskripsi); }},
                {h:'Nopol/Registrasi', f:function(r){ return T(r.nopol_sertifikat || r.nomor_akun); }},
                {h:'Kepemilikan', f:function(r){ return T(r.kepemilikan); }},
                {h:'NIK/NPWP', f:function(r){ return T(r.nik_npwp_pihak); }},
                {h:'Nama', f:function(r){ return T(r.nama_pihak || r.atas_nama); }},
                {h:'Tahun', f:function(r){ return T(r.tahun_perolehan); }},
                {h:'Harga', f:function(r){ return R(r.harga_perolehan || r.saldo_bentuk_awal); }},
                {h:'Nilai Saat Ini', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
            ]; break;
            case 5: cols = [ // HARTA TIDAK BERGERAK
                {h:'Deskripsi', f:function(r){ return T(r.deskripsi); }},
                {h:'Lokasi', f:function(r){ return T(r.lokasi_harta); }},
                {h:'Detail', f:function(r){ return T(r.detail_info); }},
                {h:'Tanah', f:function(r){ return T(r.ukuran_tanah); }},
                {h:'Bangunan', f:function(r){ return T(r.ukuran_bangunan); }},
                {h:'Sumber', f:function(r){ return T(r.sumber_kepemilikan); }},
                {h:'Sertifikat', f:function(r){ return T(r.nopol_sertifikat || r.nomor_akun); }},
                {h:'Tahun', f:function(r){ return T(r.tahun_perolehan); }},
                {h:'Harga', f:function(r){ return R(r.harga_perolehan || r.saldo_bentuk_awal); }},
                {h:'Nilai Saat Ini', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
            ]; break;
            case 6: cols = [ // HARTA LAINNYA
                {h:'Deskripsi', f:function(r){ return T(r.deskripsi); }},
                {h:'Tahun', f:function(r){ return T(r.tahun_perolehan); }},
                {h:'Bukti/No Akun', f:function(r){ return T(r.nopol_sertifikat || r.nomor_akun); }},
                {h:'Info Tambahan', f:function(r){ return T(r.detail_info); }},
                {h:'Harga', f:function(r){ return R(r.harga_perolehan || r.saldo_bentuk_awal); }},
                {h:'Nilai Saat Ini', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
            ]; break;
            case 7: cols = [ // HUTANG
                {h:'Deskripsi', f:function(r){ return T(r.deskripsi); }},
                {h:'NIK/NPWP', f:function(r){ return T(r.nik_npwp_pihak); }},
                {h:'Nama', f:function(r){ return T(r.nama_pihak || r.atas_nama); }},
                {h:'Negara', f:function(r){ return T(r.negara_kreditur || r.lokasi_harta); }},
                {h:'Thn Pinjam', f:function(r){ return T(r.tahun_mulai || r.tahun_perolehan); }},
                {h:'Nilai', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
                {h:'Keterangan', f:function(r){ return T(r.detail_info); }},
            ]; break;
            default: cols = [ // 1 KAS
                {h:'Deskripsi', f:function(r){ return T(r.deskripsi); }},
                {h:'Nomor Akun', f:function(r){ return T(r.nomor_akun); }},
                {h:'Atas Nama', f:function(r){ return T(r.atas_nama); }},
                {h:'Bank/Institusi', f:function(r){ return T(r.nama_bank_institusi); }},
                {h:'Lokasi', f:function(r){ return T(r.lokasi_harta); }},
                {h:'Thn', f:function(r){ return T(r.tahun_perolehan); }},
                {h:'Nilai Saat Ini', f:function(r){ return R(r.saldo_saat_ini); }, main:1},
            ];
        }
        return cols;
    }

    // Click on harta item row → show detail modal
    document.getElementById('hartaDetailContent').addEventListener('click', function(e) {
        var row = e.target.closest('.harta-item-row');
        if (!row) return;
        var raw = row.getAttribute('data-records');
        if (!raw) return;
        var records;
        try { records = JSON.parse(raw); } catch(_) { return; }
        if (!records || !records.length) return;

        var cols = hartaColumns(row.getAttribute('data-kat') || '');
        var hasAwal = records.some(function(r){ return Number(r.saldo_bentuk_awal) > 0; });
        if (hasAwal) {
            var awalCol = {h:'Saldo Bentuk Awal', f:function(r){ return 'Rp ' + formatNum(r.saldo_bentuk_awal); }};
            var idx = -1;
            for (var k = 0; k < cols.length; k++) { if (cols[k].main) idx = k; }
            cols.splice(idx < 0 ? cols.length : idx + 1, 0, awalCol);
        }

        var body = document.getElementById('hartaItemBody');
        var html = '<div class="table-responsive harta-scroll"><table class="table table-sm table-bordered mb-0 text-nowrap"><thead class="table-light"><tr><th>#</th>';
        cols.forEach(function(c, i) {
            html += '<th' + (i === cols.length - 1 ? ' class="text-end"' : '') + '>' + c.h + '</th>';
        });
        html += '</tr></thead><tbody>';
        records.forEach(function(r, i) {
            html += '<tr><td>' + (i + 1) + '</td>';
            cols.forEach(function(c, j) {
                html += '<td' + (j === cols.length - 1 ? ' class="text-end"' : '') + '>' + c.f(r) + '</td>';
            });
            html += '</tr>';
        });
        html += '</tbody></table></div>';
        body.innerHTML = html;

        var itemModal = new bootstrap.Modal(document.getElementById('hartaItemModal'));
        itemModal.show();
        // make item modal backdrop invisible so hartaModal behind stays visible
        var backs = document.querySelectorAll('.modal-backdrop');
        if (backs.length > 1) backs[backs.length - 1].style.opacity = '0';
    });

    document.getElementById('vsTahunFilter').addEventListener('change', function() {
        loadData(document.getElementById('tahunFilter').value);
    });

    loadData({{ $tahun }});
    </script>
</body>
</html>
