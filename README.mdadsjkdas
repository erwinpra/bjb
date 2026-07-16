# BJP - CMS & PPh Final Calculator

Aplikasi **CMS (Content Management System) + Tax PPh Final Calculator** berbasis Laravel 8 untuk menghitung Pajak Penghasilan Final (PP 23/2018) untuk wajib pajak di Indonesia.

---

## Fitur Utama

| Fitur | Description |
|-------|-------------|
| **Dual Authentication** | CMS Admin (email) + Client Wajib Pajak (NPWP) |
| **Role-Based Access Control** | CMS: roles/permissions, Client: multi-level roles |
| **Data Client Management** | CRUD, import XLSX, template download |
| **Tax Transaction** | Input harta + omset, kalkulasi PPh Final otomatis |
| **Client Dashboard** | Chart.js, export PDF & CSV, multi-client view |
| **CMS Module System** | Dynamic sidebar, module enable/disable |
| **Page Builder** | CMS pages with templates |
| **Menu Manager** | Nested menu items |
| **Media Manager** | File upload & management |

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Laravel 8 |
| PHP | 7.3.33 |
| Database | MySQL 8.0 (Docker) |
| PDF | barryvdh/laravel-dompdf |
| Excel | phpoffice/phpspreadsheet, shuchkin/simplexlsx |
| Markdown | erusev/parsedown |
| UI | Bootstrap 5.3.3 (CDN) |
| Charts | Chart.js 4.4.1 (CDN) |
| Auth API | Laravel Sanctum |

---

## Database Schema

### Core Tables

| Table | Key Columns | Relationships |
|-------|-------------|---------------|
| `users` | id, name, email, password | CMS admin users |
| `cms_data_client` | id, nama_client, tipe_badan, client_role_id, npwp, kpp, AR, ptkp, alamat_npwp, alamat_tagihan, no_telephone, email, password | `client_role_id -> cms_client_roles`, `tipe_badan -> cms_badan` |
| `cms_client_roles` | id, name, slug, description, permissions (JSON) | - |
| `cms_npwp_cabang` | id, data_client_id, nama_client, npwp, kpp, email, no_telephone, alamat_npwp, alamat_tagihan, AR, ptkp | Cabang/branch per client |
| `cms_transaksi` | id, client_id, tahun, tipe_badan_id, total_omset, total_harta, total_pph | `client_id -> cms_data_client (CASCADE)` |
| `cms_transaksi_harta` | id, transaksi_id, nama, nilai | `transaksi_id -> cms_transaksi (CASCADE)` |
| `cms_transaksi_omset` | id, transaksi_id, bulan, nominal | `transaksi_id -> cms_transaksi (CASCADE)` |
| `cms_lampiran_spt` | id, client_id, tahun | `client_id -> cms_data_client (CASCADE)` |
| `cms_lampiran_spt_detail` | id, client_id, tahun, kode, deskripsi, nomor_akun, atas_nama, nama_bank_institusi, lokasi_harta, kurs, tahun_perolehan, saldo_saat_ini, saldo_bentuk_awal, nilai_kurs | `client_id -> cms_data_client (CASCADE)` |
| `cms_kategori_lampiran` | id, label | Kategori grouping for lampiran SPT |
| `cms_master_lampiran_spt` | id, kategori_id, sub_kode, nama, is_active | `kategori_id -> cms_kategori_lampiran` |
| `cms_badan` | id, tipe | Entity types: Badan, Perorangan |
| `cms_master_rumus` | id, tipe_badan, max_value, potongan_persentase | Tax formula rates |
| `cms_pasal` | id, nama_pasal, is_active | Tax articles |
| `cms_roles` | id, name, slug, description | CMS roles |
| `cms_permissions` | id, role_id, module, action | `role_id -> cms_roles (CASCADE)` |
| `cms_role_user` | role_id, user_id | Pivot: roles ↔ users |

### CMS Content Tables

| Table | Key Columns |
|-------|-------------|
| `cms_menus` | id, name, slug, description |
| `cms_menu_items` | id, menu_id, parent_id, label, url, route, icon, order, status |
| `cms_pages` | id, title, slug, content, meta_title, meta_description, template, status, published_at, author_id |
| `cms_media` | id, name, file_name, mime_type, size, disk, path, alt_text, uploaded_by |
| `cms_settings` | id, key (unique), value, group, type |

---

## Client Roles

| Role | Slug | Permissions | Deskripsi |
|------|------|-------------|-----------|
| Super Admin Kantor | `super_admin` | `dashboard.view`, `dashboard.export`, `dashboard.change-password`, `client.view-all`, `client.manage-staff` | Pimpinan KKP - lihat semua client & transaksi staff |
| Staff/Operator | `staff` | `dashboard.view`, `dashboard.export`, `dashboard.change-password`, `client.view-all` | Staff admin - input/edit transaksi |
| Viewer | `viewer` | `dashboard.view` | Pemilik usaha - hanya lihat dashboard sendiri |
| Client | `client` | `dashboard.view`, `dashboard.export`, `dashboard.change-password` | Wajib Pajak - akses dashboard standar |

---

## Docker Setup

```bash
# MySQL 8.0 container
docker run --name my-mysql-container \
  -p 3301:3306 \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -d mysql:8.0

# Connect
mysql -h 127.0.0.1 -P 3301 -u root -proot123
```

**Environment** (`.env`):
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3301
DB_DATABASE=ajb
DB_USERNAME=root
DB_PASSWORD=root123
```

---

## Routes

### Client Area (`/client/*`)

| Method | URI | Controller | Middleware |
|--------|-----|------------|-----------|
| GET/POST | `/client/login` | `Client\AuthController` | `guest:client` |
| POST | `/client/logout` | `Client\AuthController` | `auth:client` |
| POST | `/client/change-password` | `Client\AuthController` | `auth:client`, `client.permission:dashboard.change-password` |
| GET | `/client/dashboard` | `Client\DashboardController@index` | `auth:client` |
| GET | `/client/dashboard/data` | `Client\DashboardController@data` | `auth:client` |
| GET | `/client/dashboard/export-pdf` | `Client\DashboardController@exportPdf` | `auth:client`, `client.permission:dashboard.export` |
| GET | `/client/dashboard/export-excel` | `Client\DashboardController@exportExcel` | `auth:client`, `client.permission:dashboard.export` |

### CMS Admin (`/admin/*`)

| Method | URI | Controller | Middleware |
|--------|-----|------------|-----------|
| GET | `/admin` | `Cms\DashboardController@index` | `auth`, `cms.auth` |
| GET/POST | `/admin/login` | `AuthController` | `guest` |
| POST | `/admin/logout` | `AuthController` | - |
| Resource | `/admin/roles` | `Cms\RoleController` | `auth`, `cms.auth` |
| Resource | `/admin/users` | `Cms\UserController` | `auth`, `cms.auth` |
| Resource | `/admin/client-roles` | `Cms\ClientRoleController` | `auth`, `cms.auth` |
| Resource | `/admin/data-client` | `Cms\DataClientController` | `auth`, `cms.auth` |
| Resource | `/admin/pasal` | `Cms\PasalController` | `auth`, `cms.auth` |
| GET/PUT | `/admin/badan` | `Cms\BadanController` | `auth`, `cms.auth` |
| GET/PUT | `/admin/master-rumus` | `Cms\MasterRumusController` | `auth`, `cms.auth` |
| GET/POST | `/admin/transaksi` | `Cms\TransaksiController` | `auth`, `cms.auth` |
| GET/POST | `/admin/lampiran-spt` | `Cms\LampiranSptController` | `auth`, `cms.auth` |
| Resource | `/admin/kategori-lampiran` | `Cms\KategoriLampiranController` | `auth`, `cms.auth` |
| Resource | `/admin/master-lampiran-spt` | `Cms\MasterLampiranSptController` | `auth`, `cms.auth` |

---

## PPh Final Calculation Logic

**Entity Types:**
- **Badan** (PT): Annual omset, assets labeled "Inventaris", threshold Rp 1.000.000.000, rate 10%
- **Perorangan**: Monthly omset, assets labeled "Harta", threshold Rp 500.000.000, rate 0.5%

**Calculation per month:**
```
PPH Final = monthly_omset × rate_percentage

If cumulative_omset < threshold → PPh = "Free"
If cumulative_omset >= threshold → PPh = omset × rate
If crossing threshold this month → partial tax on excess
```

---

## Installation

```bash
# Clone & install dependencies
git clone <repo> bjb
cd bjb
composer install
cp .env.example .env
# edit .env with your DB config

# Start Docker MySQL
docker run --name my-mysql-container \
  -p 3301:3306 \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -d mysql:8.0

# Import database
docker exec -i my-mysql-container mysql -u root -proot123 -e "CREATE DATABASE IF NOT EXISTS ajb;"
docker exec -i my-mysql-container mysql -u root -proot123 ajb < bjp.sql

# Or use Laravel migrations
php artisan migrate
php artisan db:seed --class=ClientRolesSeeder

# Start development server
php artisan serve
```

---
<!-- 
## Estimasi Harga Jual

| Model | Paket | Harga | Target |
|-------|-------|-------|--------|
| Putus | Basic (single client) | Rp 15-30 Juta | Konsultan pajak kecil |
| Putus | Professional (multi-client) | Rp 50-100 Juta | Kantor konsultan pajak |
| Putus | Enterprise (full source + hak cipta) | Rp 150-300 Juta | Perusahaan/koperasi |
| SaaS | Per client/bulan | Rp 200-500rb | Hosting + support |
| SaaS | Per client/tahun | Rp 2-5 Juta | Diskon tahunan |
| SaaS | Unlimited client/tahun | Rp 15-30 Juta | Kantor pajak |

--- -->

## Struktur Direktori

```
app/
├── Cms/
│   ├── Acl/            # PermissionRegistry
│   ├── Modules/        # ModuleManager, BaseModule
│   └── CmsServiceProvider.php
├── Http/
│   ├── Controllers/
│   │   ├── Cms/        # Admin controllers
│   │   └── Client/     # Client controllers
│   └── Middleware/
│       ├── CmsAuth.php
│       └── ClientPermission.php
└── Models/
    └── Cms/            # All CMS models
config/
├── cms.php             # CMS module configuration
└── auth.php            # Guards: web + client
database/
├── migrations/
└── seeders/
resources/views/
├── cms/                # Admin views
├── client/             # Client views (login, dashboard)
└── dokumentasi/        # Documentation viewer
routes/
├── web.php             # Client routes
├── cms.php             # Admin CMS routes
└── api.php             # API routes
```
