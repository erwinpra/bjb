/*
 Navicat Premium Data Transfer

 Source Server         : localdocker
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3306
 Source Schema         : bjp

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 26/06/2026 22:06:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cms_badan
-- ----------------------------
DROP TABLE IF EXISTS `cms_badan`;
CREATE TABLE `cms_badan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_badan
-- ----------------------------
BEGIN;
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (1, 'PT', '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (2, 'CV', '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (3, 'UD', '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (4, 'Koperasi', '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (5, 'Yayasan', '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (6, 'Firma', '2026-06-26 14:49:24', '2026-06-26 14:49:24');
COMMIT;

-- ----------------------------
-- Table structure for cms_client_roles
-- ----------------------------
DROP TABLE IF EXISTS `cms_client_roles`;
CREATE TABLE `cms_client_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `permissions` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_client_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_client_roles
-- ----------------------------
BEGIN;
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (1, 'Super Admin Kantor', 'super_admin', 'Pimpinan KKP - dapat melihat semua client & transaksi staff', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\", \"client.view-all\", \"client.manage-staff\"]', '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (2, 'Staff/Operator', 'staff', 'Staff admin - input/edit transaksi, tidak bisa hapus client', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\", \"client.view-all\"]', '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (3, 'Viewer', 'viewer', 'Pemilik usaha - hanya lihat dashboard sendiri, tidak bisa export', '[\"dashboard.view\"]', '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (4, 'Client', 'client', 'Wajib Pajak - akses dashboard standar dengan export', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\"]', '2026-06-26 14:48:52', '2026-06-26 14:48:52');
COMMIT;

-- ----------------------------
-- Table structure for cms_data_client
-- ----------------------------
DROP TABLE IF EXISTS `cms_data_client`;
CREATE TABLE `cms_data_client` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_client` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe_badan` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_role_id` bigint unsigned DEFAULT NULL,
  `npwp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kpp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ptkp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `no_telephone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_data_client_email_unique` (`email`),
  KEY `cms_data_client_client_role_id_foreign` (`client_role_id`),
  CONSTRAINT `cms_data_client_client_role_id_foreign` FOREIGN KEY (`client_role_id`) REFERENCES `cms_client_roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_data_client
-- ----------------------------
BEGIN;
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (1, 'PT. Maju Bersama', NULL, NULL, '01.234.567.8-901.000', 'KPP Madya Jakarta', NULL, NULL, 'Jl. Sudirman No. 123, Jakarta', '021-12345678', NULL, NULL, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (2, 'CV. Sejahtera Abadi', NULL, NULL, '02.345.678.9-012.000', 'KPP Pratama Bandung', NULL, NULL, 'Jl. Asia Afrika No. 45, Bandung', '022-87654321', NULL, NULL, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (3, 'UD. Sinar Jaya', NULL, NULL, '03.456.789.0-123.000', 'KPP Pratama Surabaya', NULL, NULL, 'Jl. Tunjungan No. 78, Surabaya', '031-5555555', NULL, NULL, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (4, 'PT. Karya Mandiri', NULL, NULL, NULL, 'KPP Madya Semarang', NULL, NULL, 'Jl. Pandanaran No. 56, Semarang', '024-3334444', NULL, NULL, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (5, 'CV. Agro Niaga', NULL, NULL, '04.567.890.1-234.000', 'KPP Pratama Medan', NULL, NULL, 'Jl. Balai Kota No. 12, Medan', '061-7778888', NULL, NULL, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
COMMIT;

-- ----------------------------
-- Table structure for cms_lampiran_spt
-- ----------------------------
DROP TABLE IF EXISTS `cms_lampiran_spt`;
CREATE TABLE `cms_lampiran_spt` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned DEFAULT NULL,
  `tahun` int DEFAULT NULL,
  `kategori` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_kode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai` decimal(18,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_lampiran_spt_client_id_foreign` (`client_id`),
  CONSTRAINT `cms_lampiran_spt_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_lampiran_spt
-- ----------------------------
BEGIN;
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (1, NULL, NULL, 'KAS', '0101', 'UANG TUNAI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (2, NULL, NULL, 'KAS', '0102', 'TABUNGAN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (3, NULL, NULL, 'KAS', '0103', 'GIRO', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (4, NULL, NULL, 'KAS', '0104', 'DEPOSITO', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (5, NULL, NULL, 'KAS', '0105', 'UANG ELEKTRONIK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (6, NULL, NULL, 'KAS', '0106', 'CEK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (7, NULL, NULL, 'KAS', '0107', 'WESSEL', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (8, NULL, NULL, 'KAS', '0108', 'KERTAS KOMERSIAL', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (9, NULL, NULL, 'KAS', '0109', 'SETARA KAS', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (10, NULL, NULL, 'KAS', '0110', 'UANG TUNAI/BANK NOTE/KOIN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (11, NULL, NULL, 'KAS', '0111', 'SETARA KAS LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (12, NULL, NULL, 'PIUTANG', '0201', 'PIUTANG USAHA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (13, NULL, NULL, 'PIUTANG', '0202', 'PIUTANG AFILIASI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (14, NULL, NULL, 'PIUTANG', '0209', 'PIUTANG LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (15, NULL, NULL, 'INVESTASI', '0310', 'ASURANSI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (16, NULL, NULL, 'INVESTASI', '0311', 'REKSA DANA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (17, NULL, NULL, 'INVESTASI', '0312', 'OBLIGASI PEMERINTAH/PENGURUSAN PEMERINTAH', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (18, NULL, NULL, 'INVESTASI', '0313', 'OBLIGASI SW', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (19, NULL, NULL, 'INVESTASI', '0314', 'SAHAM', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (20, NULL, NULL, 'INVESTASI', '0315', 'OBLIGASI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (21, NULL, NULL, 'INVESTASI', '0316', 'REKSA SAHAM', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (22, NULL, NULL, 'INVESTASI', '0317', 'REKSA CAMPURAN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (23, NULL, NULL, 'INVESTASI', '0318', 'REKSA OBLIGASI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (24, NULL, NULL, 'INVESTASI', '0319', 'REKSA PENDAPATAN TETAP', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (25, NULL, NULL, 'INVESTASI', '0320', 'REKSA TERPROTEKSI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (26, NULL, NULL, 'INVESTASI', '0321', 'PENYERTAAN MODAL PADA BADAN USAHA YANG DIVIDENDENDENDENYA DIKENAKAN PEMOTONGAN PAJAK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (27, NULL, NULL, 'INVESTASI', '0322', 'KAS PENJUALAN/PEMBELIAN REKSA DANA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (28, NULL, NULL, 'INVESTASI', '0323', 'PERSEKUTUAN/FIRMA/CV', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (29, NULL, NULL, 'INVESTASI', '0324', 'INVESTASI LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (30, NULL, NULL, 'HARTA_BERGERAK', '0401', 'SEPEDA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (31, NULL, NULL, 'HARTA_BERGERAK', '0402', 'SEPEDA MOTOR', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (32, NULL, NULL, 'HARTA_BERGERAK', '0403', 'MOBIL PENUMPANG', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (33, NULL, NULL, 'HARTA_BERGERAK', '0404', 'BUS', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (34, NULL, NULL, 'HARTA_BERGERAK', '0405', 'KENDARAAN ANGKUTAN JALAN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (35, NULL, NULL, 'HARTA_BERGERAK', '0406', 'KENDARAAN TUJUAN KHUSUS', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (36, NULL, NULL, 'HARTA_BERGERAK', '0407', 'KERETA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (37, NULL, NULL, 'HARTA_BERGERAK', '0408', 'PESAWAT TERBANG', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (38, NULL, NULL, 'HARTA_BERGERAK', '0409', 'KAPAL', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (39, NULL, NULL, 'HARTA_BERGERAK', '0410', 'MESIN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (40, NULL, NULL, 'HARTA_BERGERAK', '0411', 'GEROBAK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (41, NULL, NULL, 'HARTA_BERGERAK', '0412', 'KAPAL PESIAR', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (42, NULL, NULL, 'HARTA_BERGERAK', '0499', 'HARTA BERGERAK LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (43, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0501', 'TANAH KOSONG', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (44, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0502', 'TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (45, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0503', 'APARTEMEN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (46, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0504', 'VESSEL', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (47, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0505', 'TANAH ATAU LAHAN UNTUK USAHA (LAHAN PERTANIAN, PERKEBUNAN, DSB)', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (48, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0506', 'TANAH DAN/ATAU BANGUNAN UNTUK USAHA (TOKO, PABRIK, DSB)', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (49, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0507', 'TANAH DAN/ATAU BANGUNAN YANG DISEWAKAN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (50, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0509', 'HARTA TIDAK BERGERAK LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (51, NULL, NULL, 'HARTA_LAINNYA', '0601', 'PATEN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (52, NULL, NULL, 'HARTA_LAINNYA', '0602', 'ROYALTI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (53, NULL, NULL, 'HARTA_LAINNYA', '0603', 'MEREK DAGANG', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (54, NULL, NULL, 'HARTA_LAINNYA', '0699', 'HARTA TIDAK BERWUJUD LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (55, NULL, NULL, 'HARTA_LAINNYA', '0701', 'EMAS BATANGAN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (56, NULL, NULL, 'HARTA_LAINNYA', '0702', 'EMAS PERHIASAN', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (57, NULL, NULL, 'HARTA_LAINNYA', '0703', 'BATANGAN NON EMAS', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (58, NULL, NULL, 'HARTA_LAINNYA', '0704', 'PERHIASAN NON EMAS', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (59, NULL, NULL, 'HARTA_LAINNYA', '0705', 'PERMATA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (60, NULL, NULL, 'HARTA_LAINNYA', '0706', 'BARANG-BARANG SENI DAN ANTIK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (61, NULL, NULL, 'HARTA_LAINNYA', '0707', 'PERALATAN OLAH RAGA KHUSUS', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (62, NULL, NULL, 'HARTA_LAINNYA', '0708', 'PERALATAN ELEKTRONIK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (63, NULL, NULL, 'HARTA_LAINNYA', '0709', 'PERABOT RUMAH TANGGA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (64, NULL, NULL, 'HARTA_LAINNYA', '0710', 'PERALATAN KANTOR', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (65, NULL, NULL, 'HARTA_LAINNYA', '0711', 'JET SKI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (66, NULL, NULL, 'HARTA_LAINNYA', '0712', 'PERSEDIAAN USAHA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (67, NULL, NULL, 'TOTAL_HUTANG', '101', 'UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (68, NULL, NULL, 'TOTAL_HUTANG', '102', 'KARTU KREDIT', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (69, NULL, NULL, 'TOTAL_HUTANG', '103', 'UTANG AFILIASI', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (70, NULL, NULL, 'TOTAL_HUTANG', '109', 'UTANG LAINNYA', 0.00, '2026-06-26 14:48:52', '2026-06-26 14:48:52');
COMMIT;

-- ----------------------------
-- Table structure for cms_master_rumus
-- ----------------------------
DROP TABLE IF EXISTS `cms_master_rumus`;
CREATE TABLE `cms_master_rumus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipe_badan` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_value` decimal(18,2) NOT NULL DEFAULT '0.00',
  `potongan_persentase` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_master_rumus
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_media
-- ----------------------------
DROP TABLE IF EXISTS `cms_media`;
CREATE TABLE `cms_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint unsigned NOT NULL,
  `disk` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uploaded_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_media_uploaded_by_foreign` (`uploaded_by`),
  CONSTRAINT `cms_media_uploaded_by_foreign` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_media
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_menu_items
-- ----------------------------
DROP TABLE IF EXISTS `cms_menu_items`;
CREATE TABLE `cms_menu_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_menu_items_menu_id_foreign` (`menu_id`),
  KEY `cms_menu_items_parent_id_foreign` (`parent_id`),
  CONSTRAINT `cms_menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `cms_menus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_menu_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `cms_menu_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_menu_items
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_menus
-- ----------------------------
DROP TABLE IF EXISTS `cms_menus`;
CREATE TABLE `cms_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_menus_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_menus
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_pages
-- ----------------------------
DROP TABLE IF EXISTS `cms_pages`;
CREATE TABLE `cms_pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `template` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `published_at` timestamp NULL DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_pages_slug_unique` (`slug`),
  KEY `cms_pages_author_id_foreign` (`author_id`),
  CONSTRAINT `cms_pages_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_pages
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_pasal
-- ----------------------------
DROP TABLE IF EXISTS `cms_pasal`;
CREATE TABLE `cms_pasal` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_pasal` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_pasal
-- ----------------------------
BEGIN;
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (1, 'Pasal 1 - Ketentuan Umum', 1, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (2, 'Pasal 2 - Hak dan Kewajiban', 1, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (3, 'Pasal 3 - Tata Cara Pendaftaran', 1, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (4, 'Pasal 4 - Sanksi Pelanggaran', 1, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (5, 'Pasal 5 - Ketentuan Penutup', 1, '2026-06-26 14:49:24', '2026-06-26 14:49:24');
COMMIT;

-- ----------------------------
-- Table structure for cms_permissions
-- ----------------------------
DROP TABLE IF EXISTS `cms_permissions`;
CREATE TABLE `cms_permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_permissions_role_id_module_action_unique` (`role_id`,`module`,`action`),
  CONSTRAINT `cms_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `cms_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_permissions
-- ----------------------------
BEGIN;
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (6, 1, 'media', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (8, 1, 'media', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (7, 1, 'media', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (5, 1, 'media', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (10, 1, 'menu', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (12, 1, 'menu', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (11, 1, 'menu', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (9, 1, 'menu', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (2, 1, 'page', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (4, 1, 'page', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (3, 1, 'page', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (1, 1, 'page', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (18, 1, 'role', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (20, 1, 'role', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (19, 1, 'role', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (17, 1, 'role', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (14, 1, 'setting', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (16, 1, 'setting', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (15, 1, 'setting', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (13, 1, 'setting', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (22, 1, 'user', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (24, 1, 'user', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (23, 1, 'user', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (21, 1, 'user', 'view');
COMMIT;

-- ----------------------------
-- Table structure for cms_role_user
-- ----------------------------
DROP TABLE IF EXISTS `cms_role_user`;
CREATE TABLE `cms_role_user` (
  `role_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `cms_role_user_user_id_foreign` (`user_id`),
  CONSTRAINT `cms_role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `cms_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_role_user
-- ----------------------------
BEGIN;
INSERT INTO `cms_role_user` (`role_id`, `user_id`) VALUES (1, 1);
COMMIT;

-- ----------------------------
-- Table structure for cms_roles
-- ----------------------------
DROP TABLE IF EXISTS `cms_roles`;
CREATE TABLE `cms_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_roles
-- ----------------------------
BEGIN;
INSERT INTO `cms_roles` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES (1, 'Administrator', 'administrator', 'Full CMS access', '2026-06-26 14:49:18', '2026-06-26 14:49:18');
COMMIT;

-- ----------------------------
-- Table structure for cms_settings
-- ----------------------------
DROP TABLE IF EXISTS `cms_settings`;
CREATE TABLE `cms_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_settings
-- ----------------------------
BEGIN;
INSERT INTO `cms_settings` (`id`, `key`, `value`, `group`, `type`) VALUES (1, 'site_name', 'My Website', 'general', 'text');
INSERT INTO `cms_settings` (`id`, `key`, `value`, `group`, `type`) VALUES (2, 'site_description', 'Powered by Laravel CMS', 'general', 'textarea');
INSERT INTO `cms_settings` (`id`, `key`, `value`, `group`, `type`) VALUES (3, 'contact_email', 'admin@example.com', 'contact', 'text');
COMMIT;

-- ----------------------------
-- Table structure for cms_transaksi
-- ----------------------------
DROP TABLE IF EXISTS `cms_transaksi`;
CREATE TABLE `cms_transaksi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `tahun` int NOT NULL,
  `tipe_badan_id` bigint unsigned DEFAULT NULL,
  `total_omset` decimal(18,2) NOT NULL DEFAULT '0.00',
  `total_harta` decimal(18,2) NOT NULL DEFAULT '0.00',
  `total_pph` decimal(18,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_transaksi_client_id_foreign` (`client_id`),
  CONSTRAINT `cms_transaksi_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_transaksi_harta
-- ----------------------------
DROP TABLE IF EXISTS `cms_transaksi_harta`;
CREATE TABLE `cms_transaksi_harta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaksi_id` bigint unsigned NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai` decimal(18,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `cms_transaksi_harta_transaksi_id_foreign` (`transaksi_id`),
  CONSTRAINT `cms_transaksi_harta_transaksi_id_foreign` FOREIGN KEY (`transaksi_id`) REFERENCES `cms_transaksi` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi_harta
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_transaksi_omset
-- ----------------------------
DROP TABLE IF EXISTS `cms_transaksi_omset`;
CREATE TABLE `cms_transaksi_omset` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaksi_id` bigint unsigned NOT NULL,
  `bulan` tinyint unsigned NOT NULL,
  `nominal` decimal(18,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `cms_transaksi_omset_transaksi_id_foreign` (`transaksi_id`),
  CONSTRAINT `cms_transaksi_omset_transaksi_id_foreign` FOREIGN KEY (`transaksi_id`) REFERENCES `cms_transaksi` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi_omset
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (4, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (5, '2024_01_01_000001_create_cms_tables', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (6, '2024_01_02_000001_create_pasal_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (7, '2024_01_03_000001_create_data_client_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8, '2024_01_04_000001_create_badan_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9, '2024_01_05_000001_add_tipe_badan_to_data_client', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10, '2024_01_06_000001_create_master_rumus_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11, '2026_06_16_065211_update_tipe_badan_in_cms_data_client', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12, '2026_06_16_084717_create_cms_transaksi_tables', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13, '2026_06_16_090000_add_email_password_to_cms_data_client', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14, '2026_06_16_104228_add_ar_and_ptkp_to_cms_data_client', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (15, '2026_06_21_000001_create_cms_client_roles_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16, '2026_06_21_000002_create_cms_lampiran_spt_table', 1);
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES (1, 'Admin', 'admin@example.com', NULL, '$2y$10$2Y01tuoYjc3HJ5escHzVgO8m0jNnnnKrlz5CFwZg/1x7AX3/GlpNy', NULL, '2026-06-26 14:49:18', '2026-06-26 14:49:18');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
