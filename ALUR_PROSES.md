# Panduan Penggunaan Aplikasi BJP

Aplikasi BJP digunakan untuk mengelola data wajib pajak dan menghitung PPh Final (Pajak Penghasilan Final) secara otomatis. Berikut panduan lengkap untuk Admin dan Client.

---

## 1. Cara Login

### Untuk Admin (Pengelola)
1. Buka halaman `/admin/login`
2. Masukkan **Email** dan **Password** yang sudah didaftarkan
3. Klik tombol **Login**
4. Setelah berhasil masuk, Anda akan melihat halaman utama (Dashboard) Admin

### Untuk Client (Wajib Pajak)
1. Buka halaman `/client/login`
2. Masukkan **NIK atau NPWP** (Nomor Pokok Wajib Pajak)
3. Masukkan **Password** (diberikan oleh Admin saat pendaftaran)
4. Klik tombol **Login**
5. Setelah berhasil masuk, Anda akan melihat Dashboard Client

---

## 2. Mengelola Data Client (untuk Admin)

### Melihat Daftar Client
- Masuk ke menu **Data Client** di sidebar kiri
- Tabel menampilkan: Nama, Tipe Badan, NPWP, Email, KPP, PTKP
- Tersedia fitur pencarian (search) berdasarkan Nama, NPWP, Email, atau KPP

### Menambah Client Baru
1. Klik tombol **Create Data Client**
2. Isi formulir:
   - **Nama Client** — Nama lengkap wajib pajak
   - **Tipe Badan** — Pilih "Badan" (PT/CV) atau "Perorangan"
   - **NPWP atau NIK** — 16 digit angka (label otomatis berubah sesuai tipe badan)
   - **KPP** — Kantor Pelayanan Pajak
   - **No. Telephone & Email** — Kontak client
   - **PTKP** — Status PTKP
   - **Alamat NPWP & Alamat Tagihan** — Alamat lengkap
3. Password akan dibuat otomatis — **catat dan bagikan ke client**
4. Klik **Create Data Client**

### Mengedit Client
1. Klik ikon pensil ✏️ pada client yang ingin diedit
2. Ubah data yang diperlukan
3. **Cabang**: Dapat menambah/mengedit cabang client beserta alamat NPWP dan alamat tagihan masing-masing
4. Jika ingin mengganti password, isi kolom Password (kosongkan jika tidak diubah)
5. Klik **Update Data Client**

### Import Data Client dari Excel
1. Klik tombol **Import Excel**
2. Pilih **Tipe Badan** (Badan atau Perorangan)
3. Upload file Excel (format .xlsx)
4. Aplikasi akan menampilkan **Preview** — data baru (hijau), data yang sudah ada (kuning), dan cabang (biru)
5. Jika ada data dengan NPWP yang sama, pilih mode **Skip** (lewati) atau **Update** (perbarui)
6. Klik **Confirm Import** untuk menyimpan
7. Password dibuat otomatis untuk setiap client baru

> **Tips**: Download template Excel terlebih dahulu dengan klik **Download Template** agar formatnya sesuai.

---

## 3. Master Data (untuk Admin)

Semua menu Master berada di group **Master** pada sidebar kiri. Setiap halaman master dilengkapi fitur pencarian dan pagination.

### Pasal
- Kelola daftar pasal pajak
- Pencarian berdasarkan nama pasal

### Badan
- Kelola tipe badan (PT, CV, Perorangan, dll.)
- Pencarian berdasarkan tipe

### Master Rumus
- Atur batas omset dan tarif potongan per tipe badan
- Pencarian berdasarkan tipe badan, max value, atau persentase

### Kategori Lampiran
- Kelola kategori untuk pengelompokan Lampiran SPT
- Pencarian berdasarkan label

### Master Lampiran SPT
- Kelola daftar kode item lampiran SPT (sub_kode, nama, kategori)
- **Filter Kategori**: Pilih satu atau lebih kategori menggunakan dropdown multiple select
- **Pencarian**: Cari berdasarkan sub_kode, nama, atau label kategori

---

## 4. Mengelola Transaksi PPh (untuk Admin)

### Membuat Transaksi Baru
1. Masuk ke menu **Transaksi** di sidebar kiri
2. Pilih **Client** dari daftar dropdown
3. Masukkan **Tahun** pajak yang akan dihitung
4. **Input Harta** (aset):
   - Klik **Tambah** untuk menambah baris harta
   - Masukkan Nama dan Nilai harta
   - Untuk Badan (PT): harta disebut **Inventaris**
   - Untuk Perorangan: harta disebut **Harta**
5. **Input Omset** (penghasilan):
   - **Badan (PT)**: Masukkan total omset tahunan (1 kolom)
   - **Perorangan**: Masukkan omset per bulan (12 kolom)
   - Perhitungan PPh akan muncul secara otomatis
6. Klik **Preview** untuk melihat ringkasan
7. Klik **Simpan** untuk menyimpan transaksi

### Cara Hitung PPh Final (Otomatis oleh Sistem)

> Setiap bulan, sistem akan menghitung:
> - **Jika total omset masih di bawah batas** → PPh = Gratis (Free) ✅
> - **Jika total omset sudah melebihi batas** → PPh = omset × tarif pajak 💰
> - **Jika melewati batas di bulan ini** → PPh dihitung hanya dari kelebihan saja

**Tarif Pajak:**
| Tipe Badan | Batas Omset | Tarif Pajak |
|------------|-------------|-------------|
| Badan (PT) | Rp 1 Miliar | 10% |
| Perorangan | Rp 500 Juta | 0,5% |

### Export Laporan
- **Export PDF** — Download laporan dalam format PDF
- **Export Excel** — Download laporan dalam format CSV (bisa dibuka di Excel)
- Laporan berisi: daftar harta, omset per bulan, dan perhitungan PPh

---

## 5. Mengelola Lampiran SPT (untuk Admin)

### Input Lampiran SPT
1. Masuk ke menu **Lampiran SPT** di sidebar kiri
2. Pilih **Client** dan **Tahun** pajak
3. Klik **Tampilkan**
4. Data akan ditampilkan dalam dua tab:
   - **Lampiran SPT** — Tabel input data lampiran (edit inline, tambah baris, hapus)
   - **Recap** — Ringkasan per kategori

### Fitur di Tab Lampiran SPT
- **Tambah Baris** — Klik tombol "Tambah Baris" untuk menambah data baru
- **Edit Inline** — Klik ikon pensil pada baris untuk mengedit, klik centang untuk menyimpan
- **Hapus** — Klik ikon trash untuk menghapus baris
- **Simpan** — Klik "Simpan" untuk menyimpan semua perubahan
- **Per Page** — Atur jumlah baris per halaman: 10, 20, atau 50
- **Pagination** — Navigasi halaman data

### Import Lampiran SPT dari Excel
1. Di halaman Lampiran SPT, klik **Import Excel**
2. Upload file Excel (format .xlsx/.xls/.csv)
3. Aplikasi akan menampilkan **Preview** data yang akan diimpor
4. Jika ada NIK/NPWP tidak sesuai, import tidak bisa dilanjutkan
5. Klik **Konfirmasi Import**

### Master Kategori (Read-only)
- Masuk ke **Lampiran SPT → Kelola Master** (tombol gear)
- Menampilkan daftar kategori dan sub-item master lampiran SPT

---

## 6. Dashboard Client (untuk Client)

### Setelah Login
Setelah client login, akan muncul halaman Dashboard yang menampilkan:

1. **Nama Client** — Tampil di pojok kiri atas
2. **Role Badge** — Menunjukkan level akses (Client / Viewer / Staff / Super Admin)
3. **NPWP** — Nomor Pokok Wajib Pajak

### Filter Tahun
- Gunakan dropdown **Tahun** untuk memilih tahun pajak
- Data akan otomatis berubah sesuai tahun yang dipilih

### Ringkasan Keuangan (3 Kartu)
| Kartu | Warna | Keterangan |
|-------|-------|------------|
| **Total Harta** | Biru | Klik untuk melihat daftar detail harta |
| **Total Omset** | Kuning | Total penghasilan setahun |
| **Total PPh Final** | Merah | Total pajak yang harus dibayar |

### Grafik Omset
Grafik garis menunjukkan omset setiap bulan, sehingga mudah melihat tren penghasilan.

### Export Laporan
- Klik tombol **PDF** untuk download laporan PDF
- Klik tombol **Excel** untuk download laporan CSV

> Catatan: Fitur export dan ganti password tergantung pada level akses role Anda.

---

## 7. Level Akses Client

Setiap client memiliki **Role** (peran) yang menentukan fitur apa saja yang bisa digunakan:

| Fitur | Client Biasa | Viewer | Staff | Super Admin |
|-------|:------:|:------:|:------:|:------:|
| Lihat Dashboard | ✅ | ✅ | ✅ | ✅ |
| Lihat Detail Harta | ✅ | ✅ | ✅ | ✅ |
| Grafik Omset | ✅ | ✅ | ✅ | ✅ |
| Export PDF/CSV | ✅ | ❌ | ✅ | ✅ |
| Ganti Password | ✅ | ❌ | ✅ | ✅ |
| Lihat Data Client Lain | ❌ | ❌ | ✅ | ✅ |
| Kelola Staff | ❌ | ❌ | ❌ | ✅ |

### Penjelasan Tiap Role
| Role | Untuk Siapa? | Bisa Apa? |
|------|-------------|-----------|
| **Client** 👤 | Wajib Pajak (pemilik usaha) | Lihat dashboard sendiri, export laporan, ganti password |
| **Viewer** 👁️ | Pemilik usaha (hanya lihat) | Lihat dashboard sendiri, **tidak bisa** export atau ganti password |
| **Staff** 💼 | Karyawan kantor pajak | Lihat dashboard + bisa lihat data client lain, export laporan |
| **Super Admin** ⭐ | Pimpinan kantor pajak | Semua fitur + bisa lihat semua client dan kelola staff |

### Untuk Super Admin & Staff: Melihat Data Client Lain
Jika Anda memiliki akses **Lihat Data Client Lain**, akan muncul dropdown **"Lihat Client"** di dashboard:
1. Pilih client dari dropdown
2. Dashboard akan menampilkan data client yang dipilih
3. Export laporan juga akan mengikuti client yang sedang dipilih

---

## 8. Cara Ganti Password

### Untuk Admin CMS
1. Klik **Profile** di pojok kiri bawah sidebar
2. Masukkan password lama dan password baru
3. Klik **Simpan**

### Untuk Client (Wajib Pajak)
1. Klik tombol **Ganti Password** di pojok kanan atas
2. Masukkan password saat ini, password baru, dan konfirmasi
3. Klik **Simpan**

> Jika lupa password, hubungi Admin untuk mereset password.

---

## 9. Tips & Troubleshooting

### Jika Lupa Password
- **Admin lupa password**: Hubungi super admin atau developer
- **Client lupa password**: Admin bisa mereset password melalui menu **Data Client → Edit**

### Jika Data Tidak Muncul di Dashboard
- Pastikan tahun yang dipilih sudah benar
- Pastikan Admin sudah menginput transaksi untuk tahun tersebut
- Hubungi Admin jika data masih kosong

### Jika Error "NPWP sudah terdaftar"
- NPWP bersifat unik — tidak bisa didaftarkan dua kali
- Cek daftar client, mungkin sudah terdaftar sebelumnya

### Format Nomor yang Benar
- **NIK**: 16 digit angka, tanpa spasi atau tanda hubung
- **Nomor Telepon**: Bisa pakai format 08xx-xxxx-xxxx
- **Nilai Uang**: Cukup masukkan angka saja (contoh: 50000000)

---

## 10. Istilah Penting

| Istilah | Arti |
|---------|------|
| **NPWP** | Nomor Pokok Wajib Pajak — nomor identitas pajak |
| **NIK** | Nomor Induk Kependudukan — KTP |
| **PPh Final** | Pajak Penghasilan Final — pajak langsung dikenakan dari penghasilan |
| **Omset** | Total penghasilan/penjualan sebelum dipotong biaya |
| **Harta** | Aset yang dimiliki (tanah, bangunan, kendaraan, dll) |
| **KPP** | Kantor Pelayanan Pajak — tempat daftar pajak |
| **Badan** | Badan usaha seperti PT, CV, atau koperasi |
| **Perorangan** | Wajib pajak individu/orang pribadi |
