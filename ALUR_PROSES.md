# Panduan Penggunaan Aplikasi BJB

Aplikasi BJB digunakan untuk mengelola data wajib pajak dan menghitung PPh Final (Pajak Penghasilan Final) secara otomatis. Berikut panduan lengkap untuk Admin dan Client.

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
- Tabel menampilkan: Nama, Tipe Badan, Client Role, NPWP, Email, KPP

### Menambah Client Baru
1. Klik tombol **Create Data Client**
2. Isi formulir:
   - **Nama Client** — Nama lengkap wajib pajak
   - **Tipe Badan** — Pilih "Badan" (PT/CV) atau "Perorangan"
   - **Client Role** — Pilih level akses (Client / Viewer / Staff / Super Admin)
   - **NPWP atau NIK** — 16 digit angka
   - **KPP** — Kantor Pelayanan Pajak
   - **No. Telephone & Email** — Kontak client
   - **Alamat** — Alamat lengkap
3. Password akan dibuat otomatis — **catat dan bagikan ke client**
4. Klik **Create Data Client**

### Mengedit Client
1. Klik ikon pensil ✏️ pada client yang ingin diedit
2. Ubah data yang diperlukan
3. Jika ingin mengganti password, isi kolom Password (kosongkan jika tidak diubah)
4. Klik **Update Data Client**

### Import Data Client dari Excel
1. Klik tombol **Import Excel**
2. Pilih **Tipe Badan** (Badan atau Perorangan)
3. Upload file Excel (format .xlsx)
4. Aplikasi akan menampilkan **Preview** — data baru (hijau) dan data yang sudah ada (merah)
5. Klik **Confirm Import** untuk menyimpan data baru
6. Password dibuat otomatis untuk setiap client baru

> **Tips**: Download template Excel terlebih dahulu dengan klik **Import Template** agar formatnya sesuai.

---

## 3. Mengelola Transaksi PPh (untuk Admin)

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

## 4. Dashboard Client (untuk Client)

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

## 5. Level Akses Client

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

## 6. Cara Ganti Password

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

## 7. Tips & Troubleshooting

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
- **NPWP/NIK**: 16 digit angka, tanpa spasi atau tanda hubung
- **Nomor Telepon**: Bisa pakai format 08xx-xxxx-xxxx
- **Nilai Uang**: Cukup masukkan angka saja (contoh: 50000000)

---

## 8. Istilah Penting

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
