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

 Date: 13/07/2026 00:55:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cms_badan
-- ----------------------------
DROP TABLE IF EXISTS `cms_badan`;
CREATE TABLE `cms_badan` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_badan
-- ----------------------------
BEGIN;
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (1, 'PT', '2026-06-26 07:49:24', '2026-06-26 07:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (2, 'CV', '2026-06-26 07:49:24', '2026-06-26 07:49:24');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (3, 'Perorangan', '2026-06-26 07:49:24', '2026-06-26 08:13:15');
COMMIT;

-- ----------------------------
-- Table structure for cms_client_roles
-- ----------------------------
DROP TABLE IF EXISTS `cms_client_roles`;
CREATE TABLE `cms_client_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (1, 'Super Admin Kantor', 'super_admin', 'Pimpinan KKP - dapat melihat semua client & transaksi staff', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\", \"client.view-all\", \"client.manage-staff\"]', '2026-06-26 07:48:52', '2026-06-26 07:48:52');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (2, 'Staff/Operator', 'staff', 'Staff admin - input/edit transaksi, tidak bisa hapus client', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\", \"client.view-all\"]', '2026-06-26 07:48:52', '2026-06-26 07:48:52');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (3, 'Viewer', 'viewer', 'Pemilik usaha - hanya lihat dashboard sendiri, tidak bisa export', '[\"dashboard.view\"]', '2026-06-26 07:48:52', '2026-06-26 07:48:52');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (4, 'Client', 'client', 'Wajib Pajak - akses dashboard standar dengan export', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\"]', '2026-06-26 07:48:52', '2026-06-26 07:48:52');
COMMIT;

-- ----------------------------
-- Table structure for cms_data_client
-- ----------------------------
DROP TABLE IF EXISTS `cms_data_client`;
CREATE TABLE `cms_data_client` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_client` text COLLATE utf8mb4_unicode_ci,
  `tipe_badan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_role_id` bigint unsigned DEFAULT NULL,
  `npwp` text COLLATE utf8mb4_unicode_ci,
  `npwp_cabang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `npwp_cabang_id` bigint unsigned DEFAULT NULL,
  `kpp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ptkp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_npwp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `alamat_tagihan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `no_telephone` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_data_client_email_unique` (`email`),
  KEY `cms_data_client_client_role_id_foreign` (`client_role_id`),
  KEY `cms_data_client_npwp_cabang_id_foreign` (`npwp_cabang_id`),
  CONSTRAINT `cms_data_client_client_role_id_foreign` FOREIGN KEY (`client_role_id`) REFERENCES `cms_client_roles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cms_data_client_npwp_cabang_id_foreign` FOREIGN KEY (`npwp_cabang_id`) REFERENCES `cms_npwp_cabang` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_data_client
-- ----------------------------
BEGIN;
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (1, 'Adhi Surya Winata', '3', 4, '730559523033000', NULL, NULL, 'Tambora', 'Pratama Yudha', 'K/1', 'JL. JEMBATAN BESI 4, 15A, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '083899034184', 'adhisuryawinata@gmail.com', '$2y$10$wrn663w3n7Lw8Eg5y188w.Nsax2HhoSJTZ3zfnM16Yxi/fQ0SLT6q', '2026-06-26 12:03:04', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (2, 'Andrew Yuniarto', '3', 4, '076546605033000', NULL, NULL, 'Tambora', 'Arum Pawestri', 'K/3', 'JL.JAMBLANG INDAH I NO.9 RT.013 RW.002 DURI SELATAN, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '62216302385', 'andrewyuniarto@yahoo.com', '$2y$10$xJQAKyXL9h8md.JfLtqAA.nAyk0m1NAKWP24wqC5tuqBmIUvlMsCG', '2026-06-26 12:03:04', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (3, 'Bambang Handojo', '3', 4, '063120463033000', NULL, NULL, 'Tambora', 'Laila Nur Wahidah', 'TK/1', 'JL GG. BETET NO.63, 63, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '081517874562', 'bambanghandojo799@gmail.com', '$2y$12$iCEJaQMCjxGM/UiGJu0p.ukZ8HbBwe/X0QBDNvb836jyvzk5PQl3O', '2026-06-26 12:03:04', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (4, 'Budi Makmur', '3', 4, '076540780033000', NULL, NULL, 'Tambora', 'Fibri Kurniawan Suwu', 'K/2', 'JL PEJAGALAN RAYA, 1, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '62818805777', 'budi.makmur@gmail.com', '$2y$10$bebkqbKqmOuiXzfMYIN5uuRSXZIK7tTwbMdZkQb4FYFQs3UNf7.mq', '2026-06-26 12:03:04', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (5, 'Catherine Gosella', '3', 4, '830889564033000', NULL, NULL, 'Tambora', 'Dian Krisnasari', 'TK/0', 'JL. BETET NO 7. JEMBATAN LIMA, 7, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '628128700111', 'cathgosella@gmail.com', '$2y$10$3ohBzNzZ5gTTc3eHybHRHOcbTI/tFetkkZqPnpu572C25GHH30oEq', '2026-06-26 12:03:04', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (6, 'Erna', '3', 4, '182815811033000', NULL, NULL, 'Tambora', 'Ridwan', 'TK/0', 'JL TSS GG BARU, 20G, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '082258555347', 'ernaccss@gmail.com', '$2y$10$0BTuXiWGc7M/RKlH4bE19efOKgqtNf054e22oeybonvQM8LDj7cXC', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (7, 'Fransiscus Lie', '3', 4, '175846054033000', NULL, NULL, 'Tambora - Pusat', 'Dhani Kristanti', 'K/2', 'JL KRENDANG BARAT, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '081318187166', 'fransiscuslie428@gmail.com', '$2y$10$wEPMe40ZmWtiY.U9/7NlcutkG6Zn3.ebywF50Wp7nASmIbAyUW0ky', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (8, 'Fransiscus Lie', '3', 4, '175846054072001', NULL, NULL, 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'GEDUNG PGMTA LT.1 BLOK C/18 JL KEBON KACANG I, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '', '0216315876', 'FRANSISCUSLIE2@YAHOO.COM', '$2y$10$JtJAA3iZicPAzBiPMaTMfuB5bpEZso.QFA1cKflQKu2SfGoDLo0gq', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (9, 'Gunawan Widjaja', '3', 4, '684564404033000', NULL, NULL, 'Tambora', 'Ria Puji Anesti', 'TK/0', 'JL GG SAMARASA I, 7, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '628129186728', 'gunawanwidjajaa@gmail.com', '$2y$10$XO8TeMvf4GGkDXEFOuz6oeZz17luXRCIJXIoRzoMXmKToMTokG/0u', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (10, 'Harianto', '3', 4, '061885158033000', NULL, NULL, 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'JL KHM MANSYUR, 209, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '6281311648970', 'hariantopit@gmail.com', '$2y$10$KMsDhXWPxf8FuZ5cInNko.6J9GREBH8j2Aa.NpvLZtTNA5DX1Vvy2', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (11, 'Hengky Yuniarto', '3', 4, '067906776033000', NULL, NULL, 'Tambora', 'Arum Pawestri', 'K/0', 'JL JAMBLANG INDAH I, 9, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '08158305511', 'henkyyuniarto@gmail.com', '$2y$10$.D8x6JNGdXcMbStiLTIRgexToqFkLP6eEwPKUThZsplCSv5r0Rmt.', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (12, 'Heu Panjuwono', '3', 4, '058137670033000', NULL, NULL, 'Tambora', 'Dhani Kristanti', 'TK/0', 'JL. KRENDANG TENGAH I, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '6215445982', 'heupanjuwono@gmail.com', '$2y$10$xfrvy.zQvG4KsguAQMyiIuLFL7JtxLAm8dQB3Se1srmkd8i2ppgL.', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (13, 'Iwan Widjaja', '3', 4, '076535814033000', NULL, NULL, 'Tambora', 'Dian Setyawan', 'K/2', 'JL.SAMARASA I / 7, ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '08161891575', 'widjajaiwan16@gmail.com', '$2y$10$acnci3Y5ik3T215mb4QbjuD4TMAgoNjIOuJOD8lO/F.qKb51CR6iK', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (14, 'Kiandi Kusuma Liong', '3', 4, '061133567033000', NULL, NULL, 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'JL PERNIAGAAN, 129, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '08121116868', 'liong.siong033@gmail.com', '$2y$10$dIuf6vFJUNDnaySRFi7FEeeRYjO6LlSHetY.KisHNKAz818HbJ1pS', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (15, 'Kok Lukman Wijaya', '3', 4, '688484583033000', NULL, NULL, 'Tambora', 'Ria Puji Anesti', 'K/2', 'GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '083719663796', 'koklukman@gmail.com', '$2y$10$OkWKwUbgQqfwyaT8JNECWOKYFZYIWOrofnVvaU82HO2GIgefxsstC', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (16, 'Liauw Ka Tjaij', '3', 4, '249404070033000', NULL, NULL, 'Tambora', 'Arie Kurniawan', 'K/0', 'JL. PEJAGALAN I NO. 98 D RT. 014 RW. 005, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '0216322909', 'kcliauw@gmail.com', '$2y$10$VxCxF/Qrcf4nNcchevuP1OmbxCYk97.cqa9hKztQPqczCRxwvlXP.', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (17, 'Liu Loy Loy', '3', 4, '3173042609770009', NULL, NULL, 'Tambora', 'Adetya Candra Yuwana Putra', 'K/3', 'JL KHM MANSYUR, 172, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '0813380655933', 'liuloyloy@yahoo.com', '$2y$10$cWyBNQ1rxZx14OO8kl2fZecJAXLgozJNbsSBAvT8OuvmojZljEQHy', '2026-06-26 12:03:05', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (18, 'Phang Su Phin', '3', 4, '069133775033000', NULL, NULL, 'Tambora', 'Arum Pawestri', 'K/2', 'JL DURI SELATAN V, 65 B, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '08129946588', 'phangsun19@yahoo.com', '$2y$10$q5jXojiqXRz0iSC2GEq/NujZfjXoTOmv9wdezPsk..9oE1RCbIFGW', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (19, 'Ringo Yapari', '3', 4, '076533710033000', NULL, NULL, 'Tambora', 'Wursito Atik', 'K/2', 'JL.KHM.MANSYUR NO.218, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '081288224490', 'ringoyapari17@gmail.com', '$2y$10$YknXGx3vs6rOetzTQVV8Lugu1OEAbs7.kg7pgDl181e7Sj6fMmXO.', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (20, 'Robin Sugiarto', '3', 4, '175914100033000', NULL, NULL, 'Tambora', 'Arum Pawestri', 'K/1', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '08128000812', 'robinsugiarto997@gmail.com', '$2y$10$FaHpcBFrlnP69.ZoNpliIeow90lMcyjqq5F6jw9zPXE4IrKvuJr8K', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (21, 'Rosmawati', '3', 4, '066740093033000', NULL, NULL, 'Tambora', 'Ridwan', 'TK/1', 'JL KP DURI TSS, 51, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '62816811386', 'pajakrosmawati17@gmail.com', '$2y$10$bmgGkZeU3kLUO3WMa9WBseT.xWVGh7N93xzdinrxOd6tasSrCvpN6', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (22, 'Santoso Latif', '3', 4, '175734078033000', NULL, NULL, 'Tambora', 'Adetya Candra Yuwana Putra', 'K/0', 'JL SONGSI, 6, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '62216902735', 'santosolatif3@gmail.com', '$2y$10$j9XKShG5nc7HIJrP3Hadfugdf7UheqMI4zCeYz7DFX1NJOS89k446', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (23, 'Sastro Tjondro', '3', 4, '279076624033000', NULL, NULL, 'Tambora', 'Ria Puji Anesti', 'K/2', 'GG SAMARASA III NO.18 RT.005 RW.005 KEL ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '6281105892', 'sastrotjondro4@gmail.com', '$2y$10$OajwUMCIyjzFh7qsetg0oOYGtveljaoPrLTCLds0Pgqs/fV.Xdxii', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (24, 'Sumitro Lie', '3', 4, '189399025033000', NULL, 1, 'Tambora - Pusat', 'Dhani Kristanti', 'K/3', 'JL.KRENDANG BARAT NO.42 RT.012 RW.005 KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '622130365910', 'sumitro.lie@yahoo.com', '$2y$12$iCEJaQMCjxGM/UiGJu0p.ukZ8HbBwe/X0QBDNvb836jyvzk5PQl3O', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (25, 'Suwandi Arifin', '3', 4, '688484591033000', NULL, NULL, 'Tambora', 'Ria Puji Anesti', 'K/1', 'JL PTB ANGKE GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '6285719663796', 'suwandiarifin00@gmail.com', '$2y$10$nnLzoHfCtJmCSndDpNWgY.Bjbgeo5ekmgEFpMUhEXyt2/g/dB86L6', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (26, 'Tjan Gosto', '3', 4, '684564412033000', NULL, NULL, 'Tambora', 'Ria Puji Anesti', 'K/1', 'GG SAMARASA I, 23, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '08176902776', 'gostotjan@gmail.com', '$2y$10$iKsUQC05UmJutw3R7LrpLu5RhUSaIqFl1gcZMcdfRi.4mzzK2XVVG', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (27, 'Tjhin Su Mie', '3', 4, '969355684033000', NULL, NULL, 'Tambora', 'Putra Dwi Pamungkas', 'TK/3', 'TERATE I NO 11, No 11, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '', '081617175507', 'tjhinsumie9@gmail.com', '$2y$10$VZ93phkyqYnonTCbyjRfr.k2fY3X45BGZZoJxyNPW.6JhpoJYuv9.', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (28, 'Tjioe Seng Huat', '3', 4, '069103547033000', NULL, NULL, 'Tambora', 'Wursito Atik', 'K/1', 'JL TANAH SEREAL X, 8, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '6281315151596', 'tjiosenghuat@gmail.com', '$2y$10$REqPdMsiusMu61wm.wmX/eHpLg2qwJKE.2G4w76dP8SzN/3fceGc.', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (29, 'Tjiu Jun Shin', '3', 4, '076531904033000', NULL, 2, 'Tambora - Pusat', 'Ridwan', 'K/3', 'JL.TSS.NO.15 L, DURI UTARA, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '62811872783', 'tjiuju@gmail.com', '$2y$10$T3PFPBIp0UoBBL8zMnDjFuw.04E/qwn1y.ds9qFLRq1.ItSGzAgtG', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (30, 'Tjiu Supardi', '3', 4, '076533835033000', NULL, NULL, 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'JL LAKSA I, 85A, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '', '628128556129', 'tjiusupardi@gmail.com', '$2y$10$fqRSn4Pd9z28q6EcDRLIUe4FEz89xyIGgp.S5XHUQ6AYASK6ZbRPO', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (31, 'Vicky Famin Efendy', '3', 4, '694895046033000', NULL, NULL, 'Tambora', 'Anung Prasetyo Dwijayanto', 'K/0', 'DURI BARU NO.3, JAKARTA BARAT, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '-', 'vickyfamin@gmail.com', '$2y$10$oVetT2OTU9ErzZajV7bRBeu0vR974MScnSfQ2IcRZe79E059r4sQO', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (32, 'Erres Subiarto', '3', 4, '061844098026000', NULL, NULL, 'Sawah Besar Satu', 'Geri Gema Putra Tarigan', 'TK/0', 'JL GUNUNG SAHARI 11, GUNUNG SAHARI UTARA, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10720', '', '087885382958', 'eressubiarto@gmail.com', '$2y$10$kvU8..KDjb.NCYntChqR4OdNV6umo1IpFY/rVSYoqrgLMCodBI6s6', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (33, 'Diana Wangsa Heryanto', '3', 4, '664215126075000', NULL, NULL, 'Sawah Besar Dua', 'Chalimatus Sa\'diyah', 'TK/0', 'JL KELINCI IV NO 2 A RT 008 RW 004, PASAR BARU, 2 A, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '', '6281808867585', 'dianawangsa2@gmail.com', '$2y$10$i3uOSJUeoadx9Qh/1ByMyOQujqGEEDK0kRRwtQ3KuVQcNfeREDKgG', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (34, 'Djohan Hirawady', '3', 4, '067495846037000', NULL, NULL, 'Sawah Besar Dua', 'Dellachita Rahardhianne Winarto', 'TK/0', 'JL GG MANDOR, V, 32, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '', '081574258787', 'djohanhirawady@gmail.com', '$2y$10$E16VUCYSEsOZsZ2L.hX6jej8izCaYrjqlttKQ/60qSnJ9xyNc4CfS', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (35, 'Alex Heryanto', '3', 4, '065587503032000', NULL, NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI IX, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '6221624329', 'alexheryanto51@yahoo.co.id', '$2y$10$9.v95vIkyM9.qFSy92sYqODEgFwoGHb0g9uLS.pInEPfQxdEal2/.', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (36, 'Cynthia Kurnia', '3', 4, '659844500032000', NULL, NULL, 'Tamansari', 'Nova Novelita', 'TK/0', 'JL TAMAN SARI IX/10, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '082225843858', 'cynthiakurniaa@gmail.com', '$2y$10$A.jPw/g8hxtDm8SMMr.QeOE/KQCE7i7mR4TjjCC89kol5O8h/wE7i', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (37, 'Ferry Wangsa Saputra', '3', 4, '813350246032000', NULL, NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'JL. TAMANSARI IX/10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '08989703363', 'ferrywangsa@gmail.com', '$2y$10$4VYt6hsXduAMP3IFvSWF8.zunfG3ky/rgRSl9k3LWvkI/i1ybqVxm', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (38, 'Hendry Wijaya', '3', 4, '076453869032000', NULL, NULL, 'Tamansari', 'Nova Novelita', 'K/3', 'JL TAMANSARI IV, 22, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '628129133176', 'hendrywijayaa0@gmail.com', '$2y$10$fSL4Tyd.TfHUt/ZsDqpGvefUSaCj/5vQoYVEssDSBRSC1I4fVt1O6', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (39, 'Johan Ng', '3', 4, '068512904032000', NULL, NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI VI, 52-B, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '081808991212', 'johanng454@yahoo.com', '$2y$10$fdlq9.Bo1NYLVwLOVIzvD.ghvcooX8KImOnGiitJeDCRkKG2p1cfa', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (40, 'Mulyadi Saputra', '3', 4, '068512219032000', NULL, NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI IX, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '6285100582190', 'mulyadisaputra817@yahoo.co.id', '$2y$10$5U1hpA9R4re76HaTvURRiO.Odp5qKElTIunHD06d/1Z17tX9u.YbC', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (41, 'Willy Darmawan', '3', 4, '577673528032000', NULL, NULL, 'Tamansari', 'Raden Muhammad Riandy Irmansyah', 'K/3', 'JL TAMANSARI II, 60 B, MAPHAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11160', '', '0818169848', 'willydarmawan678@yahoo.co.id', '$2y$10$vd8SbwTb5PqL3S9XDE6VBuk4.Yq6uywJ4Qa/FhZ5p5GE3RqMEcbmO', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (42, 'Wong Sauw Lie', '3', 4, '096710199037000', NULL, NULL, 'TamanSari', 'Dite Fatmawati', 'TK/0', 'JL KEMENANGAN V GG 2, 18 A, GLODOK, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11120', '', '0216393841', 'wongsauw10981@gmail.com', '$2y$10$XRI06w8l3ZyPPDUKPYKmte03xCo686SN8KsnZGftuIfZhzMscBB2O', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (43, 'Yoanita Kristina', '3', 4, '091270769035000', NULL, NULL, 'Kebon Jeruk Satu', 'Rahmat Husein Harahap', 'TK/0', 'KOMPLEK BPK III, C, 9, KEBON JERUK, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11530', '', '081517874562', 'yoanita.kristina@yahoo.co.id', '$2y$10$4keaLS7RvH.L4QQ09Xi6buJKzM9SBi9kS9f8IPNeQlSezOEymXI3m', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (44, 'Andy Prayitno Limantoro', '3', 4, '258880335039000', NULL, NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'GREEN GARDEN BLOK A-5/12 RT. 003 RW. 003, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '628567843535', 'andyprayitno57@yahoo.co.id', '$2y$10$f09PkzA/hb.80wtJjFmixePRjsDVSZUlooF6jBM2pNr.qGIwnxF8K', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (45, 'Indra Prayitno Limantoro', '3', 4, '813778198039000', NULL, NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'K/0', 'GREEN GARDEN, A-5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '08128015571', 'indraplim@gmail.com', '$2y$10$vSyZ51XOh8NY1RyNiQjtg.Y.O8AjtxnNqx5lrYaYz8NXkALZqrr0e', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (46, 'Winston Tanazon', '3', 4, '767341183039000', NULL, NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'KOMPLEK GREEN GARDEN, M 3, 57, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '08170066290', 'TANAZONW@GMAIL.COM', '$2y$10$QOj57F5OZfB0.agwKyrnMOPu9rCNzMYpaJePts.xIheOzX/RUzA8u', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (47, 'Willy Limantoro', '3', 4, '678492109039000', NULL, NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/1', 'KOMPLEK GREEN GARDEN, A 5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '62215650104', 'limantorowilly@gmail.com', '$2y$10$1idVb6qWF6RjTlrDx.dWLeXSZi.GI7FOwxf6LrYUz2SCFCd5ogw3e', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (48, 'Albert Limanto', '3', 4, '768236788034000', NULL, NULL, 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'JL KAPUK RAYA, 8, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08568568445', 'albertlimant@gmail.com', '$2y$10$QRmFSj1eYm/cpPJ878NQC.UCvSqjfQZ8Rzt/d4X82XHDcemJzIJfu', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (49, 'Alvindo Limanto', '3', 4, '633796222034000', NULL, NULL, 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '081289020181', 'alvindolimantoo@gmail.com', '$2y$10$jZrmppWXdu5xYVmla3mobuoI4vhQhEJ0CyIYc2Va3zZrbreEQjHam', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (50, 'Chandra Limanto', '3', 4, '776577181034000', NULL, NULL, 'Cengkareng', 'Genis Anggraeni', 'K/2', 'JL KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '081889020181', 'chandralimanchan@gmail.com', '$2y$10$d5/XuUV7QK6ug.OAizI6vuVn4BbrgIK1g7rXJ4i8HX7RuLxbc068m', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (51, 'Heng Chun Khiun', '3', 4, '467420469034000', NULL, NULL, 'Cengkareng', 'Puspa Ayu Wulandari', 'K/0', 'JL KAPUK KEBON JAHE, 133, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08178811560', 'hengchun377@yahoo.co.id', '$2y$10$5TR.yN45scjHxL8rTQYgY.LcolSVOX.EWwEIDhIh67mRwxocgxZ6i', '2026-06-26 12:03:08', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (52, 'Lisa', '3', 4, '730214897034000', NULL, NULL, 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'KP UTAN NO. 3, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '08988959911', 'lisacss1@yahoo.co.id', '$2y$10$czMH9Nue8tFyKUBpfxapA.9i0rDmIz8RCxRDFY.NP2yWgjKZ08QAm', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (53, 'Pendi Susanto', '3', 4, '668749120034000', NULL, NULL, 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'JL KAMPUNG UTAN, 36, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '668749120', 'pendisusanto907@yahoo.com', '$2y$10$LE6Xv0p6sfzmbDo//FhYBOHDVBkevDTEGeCZFZFABqhIu.yrw3aSW', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (54, 'Silvia Listiani Limanto', '3', 4, '633705165034000', NULL, NULL, 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '081289020181', 'silvialistianilimanto@gmail.com', '$2y$10$ueKNrW7RPxt17mN1bES4D.PWA6LkZ0/XgOtY1sQOBrRjJeW.p1eRy', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (55, 'Sukarsanto', '3', 4, '243701620034000', NULL, NULL, 'Cengkareng', 'Ika Kusumawati', 'K/3', 'JL RAYA KAPUK GG EMPANG, 3, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '087883803880', 'sukarsanto_css@yahoo.com', '$2y$10$SpzPGHvZXpDmk6cFCdDfjOISVAW4IK1wPpcHjr722e4U4RYsOsNUa', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (56, 'Lioe Leosando', '3', 4, '278279468034000', NULL, NULL, 'Cengkareng', 'Genis Anggraeni', 'K/2', 'JL WARU III, 14, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08129966364', 'lioeleosandoo@gmail.com', '$2y$10$BNZpZ09TaKwIZMpc2bYjeOczmzv6k53JxXzZ/E3dr1QkfrJiDGjP2', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (57, 'Harya', '3', 4, '478624356085000', NULL, NULL, 'Kalideres', 'Crisanto Adi Maria Listyanto De Carvalho', 'TK/0', 'TAMAN KENCANA BLOK D KAV.9 NO.5 NO 5 RT.001 RW.14, JAKARTA BARAT, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '', '082112660987', 'harya1919@gmail.com', '$2y$10$0tCoL1govIPGhURPSqMBbuRUSpaSgNHBYlx27/osC8rD4j.WsSasq', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (58, 'Ronny Halim', '3', 4, '067232728085000', NULL, NULL, 'Kalideres', 'Tono Supriyono', 'K/1', 'PERUMAHAN CITRA 2, A 5, 12 A, PEGADUNGAN, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11830', '', '5445053', 'ronnyhalim19@gmail.com', '$2y$10$vDpgMwI7cvMFZzsbOrrGceQ3bu/aZ3nNITYdcXI7diYNO6UGZDS.y', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (59, 'Suharta Riyanto', '3', 4, '828292631085000', NULL, NULL, 'Kalideres', 'Erwanto Eko Prasteyo', 'TK/0', 'JL PRIMA UJUNG, A, 31A, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '', '08998947847', 'suhartariyanto@yahoo.com', '$2y$10$cq3dthcGU7D/PF7TzmQ0yO0XPzitoPZm0W8RPgQk5Sm42WUm6AAmu', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (60, 'Bambang Suhono Halim', '3', 4, '070437843044000', NULL, NULL, 'Pademangan', 'Ferri', 'K/0', 'JL PADEMANGAN II GG 29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '6281288518185', 'bambangsuhonohalim72@gmail.com', '$2y$10$4NEo0LePeqpG2tHVHe94Le7fNK65wfCGOSxnJxr9yTvVK6LzR0.JG', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (61, 'Daniel Halim', '3', 4, '538074576044000', NULL, NULL, 'Pademangan', 'Ferri', 'TK/0', 'JL. PADEMANGAN II  GG 29, 7, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '087879507490', 'halimmdaniel@gmail.com', '$2y$10$prf2p7EtFFg2WWkN02YEdOyuPry5lWj4CvUlW7KEBKDe8fsL644K2', '2026-06-26 12:03:09', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (62, 'Niki Halim', '3', 4, '742610801044000', NULL, NULL, 'Pademangan', 'Ferri', 'TK/0', 'JL.PADEMANGAN II GG.29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '0818756910', 'nikihalimm@yahoo.com', '$2y$10$5DzGo.jgN4AHZ0pSAsDgy.N2RaJREorazwI.RG/65j.ZJHXFcClpC', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (63, 'Ricky Halim', '3', 4, '742610470044000', NULL, NULL, 'Pademangan', 'Ferri', 'K/2', 'JL PADEMANGAN II GG.29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '085814733150', 'rickyhalimm@yahoo.com', '$2y$10$IX2pjc1BmL.YAjlkvdtAQ.xeXoJUXoMwHa/441VFQmgOAQHtkW9L6', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (64, 'Sumanto', '3', 4, '042075085044000', NULL, NULL, 'Pademangan', 'Hamonangan', 'K/0', 'JL LODAN, 143, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '081283789850', 'sumantotjioe@yahoo.com', '$2y$10$mjfpmgiFXoA8p9bGB3e8s.MSatsuNNx.CLdMNR0D81JATm2d1v02.', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (65, 'Akin Sriwongo', '3', 4, '065792780041000', NULL, NULL, 'Penjaringan', 'Hari Isnawan', 'TK/0', 'JL JEMBATAN GAMBANG I, 26, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281219128119', 'akinsriwongo17@gmail.com', '$2y$10$b8/3AkMJZEZfqJTPRtKa3ORlBDHtY/aDDdkbVN5XWT8SX2KiBOzvu', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (66, 'Alvin Wijaya Tie', '3', 4, '173572561041000', NULL, NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'JL JELAMBAR, 19, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '085216695811', 'alvintie@yahoo.com', '$2y$10$uHQZ5z2Ce7j1GCZd3a81P.rWc9hpKP4io9hNF24GF42oZGScHILKm', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (67, 'Eddy Chandra', '3', 4, '240139386041000', NULL, NULL, 'Penjaringan', 'Gani Syabani', 'K/3', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '082124656668', 'eddychan1919@gmail.com', '$2y$10$0XIvd1/pahlMcHucNGiHvefUjGpeXdDByjaS1Yx8GYT9wlONaxOOC', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (68, 'Hendra Wijaya Tie', '3', 4, '144331568041000', NULL, NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/0', 'JL JELAMBAR ALADIN, 16, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281287022829', 'hendrawijayatie@gmail.com', '$2y$10$TfQFNrWmRbZsy/barukbH.DEPOmuGK1m9N8lFvGQH3Mr2Z1sy7Ii.', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (69, 'Herman Wijaya', '3', 4, '064493224041000', NULL, NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/3', 'JL JELAMBAR ALADIN, 1K, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281291674728', 'hermanwijayapit@gmail.com', '$2y$10$5wJbXirI/KwlimL2mdTqNOQ5rIp6DSY.QojUzAUlr4zRsSBeIh3du', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (70, 'Lim Ngok Hong', '3', 4, '716689823041000', NULL, NULL, 'Penjaringan', 'Hari Isnawan', 'K/3', 'JL. KERTAJAYA IV, 20, PENJARINGAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14440', '', '0852181765255', 'limngok@yahoo.com', '$2y$10$3TBsv3PLn3bXLqQa8Woww.GcYG9CN/ADTfgwmk7WND6iGFg4tDZsK', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (71, 'Sadikin Kuswanto', '3', 4, '073268245041000', NULL, NULL, 'Penjaringan', 'Devy Elvandary', 'K/1', 'TELUK GONG JL LUNDU 48, PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '-', 'dikisadikin19@gmail.com', '$2y$10$Din3ta5.nKHCRqm0tB1HkeEo2OVaQGoDVyDnOAa49Ew1zvjh0h1mi', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (72, 'Tjhang Vivi Surianty', '3', 4, '725711873041000', NULL, NULL, 'Penjaringan', 'Gani Syabani', 'TK/0', 'JL E TELUK GONG, 174B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '622156949666', 'tjhangvivisurianty@gmail.com', '$2y$10$LgTynPj7UU.c0vFz9dzlguOYIvYQSQq4glXoEpSFk0YreWCjFRHXK', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (73, 'William Wijaya Tie', '3', 4, '144330925041000', NULL, NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'JL JELAMBAR, 1, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6287884564101', 'williamwijayatie@gmail.com', '$2y$10$okT6XtHvqKO75eQDeFXwP.pAx3G3EyGolljcVi3KBh1TPeo2zALAy', '2026-06-26 12:03:10', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (74, 'Devlin Sukarto', '3', 4, '248302911047000', NULL, NULL, 'Pluit', 'Restu Rea Erlangga', 'TK/1', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '087789101118', 'devlinsukarto1997@gmail.com', '$2y$10$PWAMZD1Qf7vrXG6kDVXEd.c.Al1ZNG26WQkvQz1wRx/gKBnojAI2q', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (75, 'Enrico Rusli', '3', 4, '962709838047000', NULL, NULL, 'Pluit', 'Ganendra Edo Satwika', 'TK/0', 'CAMAR INDAH, 7, 9, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '081296887420', 'enricoruslilie@gmail.com', '$2y$10$ZNvfC4pL5dj/bUfoCf0fmOc5GskHtVhQjf.IqIXRk9awpsc9b9fI2', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (76, 'Liong Koei Hwa', '3', 4, '071910723047000', NULL, NULL, 'Pluit', 'Restu Rea Erlangga', 'K/0', 'JL PLUIT SAKTI III, 41, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '081513136268', 'koeihwaliong@gmail.com', '$2y$10$Cw2IKQyokU3fb/FPzia6xOVz6as34JCCuuuZKSbQRnxI33K6o8tSa', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (77, 'Sammy Soetiono', '3', 4, '040862336047000', NULL, NULL, 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'JL PLUIT BARAT III, 3, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '0816885406', 'sammysoetiono@gmail.com', '$2y$10$Cf/auB8bMvZTMYWYM94nBOGnP932ck7SUM7exOPM/6Ehu51CLseQe', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (78, 'Selvia Liliana S', '3', 4, '248185076047000', NULL, NULL, 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '087789101118', 'selvialilianaas@gmail.com', '$2y$10$DLMZeOHf8qP7U/ZkN2AS0eYBMLc4YUdjBKelOgSK10kk/9TBGu6Hu', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (79, 'Setiawan Widjaja', '3', 4, '276230976047000', NULL, NULL, 'Pluit', 'Prophana Labi Dautse Gayo Katama', 'K/1', 'JL MUARA KARANG BLOK I.7.U  NO.11-A, I, 11, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '08119849992', 'setiawanwjd19@yahoo.com', '$2y$10$BsyuXT5RnahQY/9bWH/nsOgPXacq.PPAnQ9bzyKHEelCaLj0i8Mlq', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (80, 'Su Kai', '3', 4, '461844409047000', NULL, NULL, 'Pluit', 'Wisnu Febryanzah Prasetyo', 'TK/0', 'RUSUN BLOK G LANTAI II NO.13 RT. 006 RW. 009, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '081311648970', 'kaisu2311@gmail.com', '$2y$10$mFBEwIlW0DGpiQ5DA.x1Te7PRL0cYHNEIYgLLLRfOX57i9pbAkLO6', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (81, 'A Han', '3', 4, '594743379036000', NULL, NULL, 'Grogol Petamburan', 'Esther Theresia Orienta Simanjutak', 'K/2', 'JL MANGGIS I, -, 10, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '6281315815888', 'aahanhann@gmail.com', '$2y$10$oxpulR5na3FPNqIZi/jiH.iCjj3GkPIPZBKflZ0K5q5OIw.5kvl8G', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (82, 'Anggip Lesmana', '3', 4, '062672209036000', NULL, NULL, 'Grogol Petamburan', 'Arum Kusuma Sari', 'K/0', 'TAMAN DUTA AMS JALAN PANGERAN TUBAGUS ANGKE, D 2, 26, WIJAYA KUSUMA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '', '081898128', 'lesmanaanggip17@yahoo.com', '$2y$10$.6.1vfBVwHn0VPu3v.lpPu3j3JAxfh/ZCMJl1OR4fu6FgCIgstgVW', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (83, 'Fen Limantoro', '3', 4, '061119467036000', NULL, NULL, 'Grogol Petamburan', 'Rumpaka Jati', 'TK/0', 'JL TANJUNG DUREN UTARA V / 6 RT 06 RW 03, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '08158825812', 'fenlimantoro47@gmail.com', '$2y$10$kPMlzAR4x30qJYWNb5zkzeZxHK.DhX5JnAkWSTaN19JkLVxfiaQQu', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (84, 'Iwan', '3', 4, '163773260036000', NULL, NULL, 'Penjaringan', 'Gani Syabani', 'K/2', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281310551977', 'iwanaja1994@yahoo.com', '$2y$10$xgFAgcNpdJT19uzF/m9Xy.0DeBfo7rFf9eQU.AAubwn9kmNZnnqqq', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (85, 'Tjoeng Sje Ji', '3', 4, '096661558036000', NULL, NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/0', 'JL MANGGIS II, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '08161974011', 'tjongsje@yahoo.com', '$2y$10$PdDnVO5YNptpil7SdZ3Q4Ob0WIvhfpHbCOXpmtDvkr/Il9O98iCQ2', '2026-06-26 12:03:11', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (86, 'Andika Kartadinata', '3', 4, '456635721029000', NULL, NULL, 'Gambir Tiga', 'Sartika Faramelita Suherman', 'TK/0', 'JL. KH. HASYIM ASHARI NO. 54A RT. 003 RW. 001, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '08999901989', 'kartaandika35@gmail.com', '$2y$10$NTAXWEn5mj3XLTWAZy4UdOveNe5XrNk1QPalTexQt5lqah7o4Dt8y', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (87, 'Gimin Arifin', '3', 4, '069067239074000', NULL, NULL, 'Gambir Satu', 'Lisdyaningroem', 'K/2', 'GG KINGKIT IV, 18, KEBON KELAPA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10120', '', '081212129534', 'giminarifin@yahoo.com', '$2y$10$Myfg9oVZv7UDf2LKxBtMxuD/CThxvVwfvdAnfqm6z25EcmAuPKjv2', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (88, 'Janti', '3', 4, '245090493028000', NULL, NULL, 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'JL. KEBON JAHE II NO.14 RT. 006 RW. 002, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '02194507303', 'janti0019@gmail.com', '$2y$10$./khIQ5CMR1oUQYup2RHjOHJKonmHy.7rVFo.qBoruvLNFQYQ4qXe', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (89, 'Liana Hasanudin', '3', 4, '061855714029000', NULL, NULL, 'Gambir Tiga', 'Deni Dewi Anggraeni', 'TK/0', 'JL.CIDENG TIMUR NO.9, PETOJO UTARA, PETOJO UTARA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10130', '', '08159403998', 'lianahasanudi19@gmail.com', '$2y$10$kjTHHKmw9/LbtuGTiIfDx.l26/4Kbg4MDnwVyJxxJRY0/EZf6gM/i', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (90, 'Linawati Setiadi', '3', 4, '072272727028000', NULL, NULL, 'Gambir Dua', 'Tini', 'TK/0', 'JL PERSATUAN GURU, 18, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '081315133312', 'linasetiadi7@gmail.com', '$2y$10$V4EegSnkc10wSRhtor.0xe348pdErMRdzkWqcMfRIC/g8Zr716VoO', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (91, 'Nico Hartono', '3', 4, '251403846028000', NULL, NULL, 'Gambir Dua', 'Hendra Rahma Wiguna', 'K/1', 'JL. KEBON JAHE II NO.14 RT.006 RW.002, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '62215655526', 'nicohartono67@gmail.com', '$2y$10$9uIWSZGrzC67jSz4Y6MEU.IQGoP4KlOphMA1PPWnD72CB21FFiA/K', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (92, 'Rudy Soetanto', '3', 4, '041834318028000', NULL, NULL, 'Gambir Dua', 'Tini', 'K/0', 'JL PETOJO SELATAN IX, 2, CIDENG, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10150', '', '0816925412', 'rudysoetanto73@gmail.com', '$2y$10$t.MNF6r739rKkw9QQBdaFuWXZCpWQVZ03JM9F83HNhdcml60tqWNO', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (93, 'Surya Kartadinata', '3', 4, '041335480029000', NULL, NULL, 'Gambir Tiga', 'Annisa Perwitasari', 'K/0', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '628999031463', 'surya.k18@yahoo.com', '$2y$10$miKW/LAM4FApqkE3yh3JaOz0MpDSg9sFlpABLYVCoqYvY.V51JWEC', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (94, 'Efendi Narzudi', '3', 4, '277726204043000', NULL, NULL, 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'JL PELEPAH ELOK IX, GF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '0818983853', 'efendinarzudi@yahoo.com', '$2y$10$Eo357L5HaJgDSuuUSbCS8eBssM7bxGmamHxhlLfT.c27hVbjcCuBi', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (95, 'Herry Limantoro', '3', 4, '095845632043000', NULL, NULL, 'Kelapa Gading', 'Sayyidah Tahirah', 'K/1', 'PERUMAHAN BUKIT GADING MEDITERANIA, E A, 2, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '62213849217', 'herrylimantoro99@yahoo.com', '$2y$10$Xdyg9/rSACSaz3t3nxw7o.G6ivHIUmdJncqJQ59S.sF8QuB6UoH26', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (96, 'Linda Tjahyadi', '3', 4, '063481642043000', NULL, NULL, 'Kelapa Gading', 'Dodhy Candra Saputro', 'TK/1', 'JALAN GADING NIRWANA V, PF 10, 10, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '', '081586607397', 'lindatjahyadi19@yahoo.com', '$2y$10$FYF0fvso3lyqte2zS0i7peGpDAG5iewMobcYG78YOt98wFg/XIPC.', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (97, 'Ruby Narzudi', '3', 4, '581212636043000', NULL, NULL, 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'JL PELEPAH ELOK IX, QF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '0881010622198', 'rubynarzudii@gmail.com', '$2y$10$Jq8HzHv9/29UHXRZ3wUVguWfRBSE2X5kNMAeCTb.kubMxDv1IqOK.', '2026-06-26 12:03:12', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (98, 'Tjoa Hadi Lukmanto', '3', 4, '068010131043000', NULL, NULL, 'Kelapa Gading', 'Sri Rahayu', 'K/1', 'JL KELAPA NIAS VI, PB 13, 18, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '', '0816714677', 'tjoahadi@yahoo.com', '$2y$10$w44zfXBlTbhwGXAvpiVKeOifStNIGQbsfpZ877v2Qr8qLxMU4n5OO', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (99, 'Lucy Sastroamidjoyo', '3', 4, '719922064048000', NULL, NULL, 'Tanjung Priok', 'Prima Wallesa Palo', 'TK/0', 'JL.  AGUNG  TENGAH  4-I, 1, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '', '6281213998813', 'lucysastro1919@gmail.com', '$2y$10$40yLkXuJ1pAzN5W0envz1.Fz91x3y2i4ZjMjZg81LBLihxHpi2F32', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (100, 'Temmi Sandjaja', '3', 4, '253897466048000', NULL, NULL, 'Tanjung Priok', 'Toni Murdoto', 'TK/3', 'JL AGUNG UTARA XV, A13, 7, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '', '08128537899', 'temmitemsand19@gmail.com', '$2y$10$FTRoJM1YvllA7WMDwPkxKeot99pM/Gx6V/.Cd0rZwwXtbS3p1W0nC', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (101, 'Ali Chandra', '3', 4, '095327383015000', NULL, NULL, 'Tebet', 'Nurkholis Rafsanjani', 'K/2', 'JL BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '', '6287882550888', 'alichand1919@gmail.com', '$2y$10$gEF5pGDZJsdpMVQA1OeFX.TqdeMUx6TvYVgTGey9F0UcpyCbPX2s6', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (102, 'Eddy Zonder', '3', 4, '063368476015000', NULL, NULL, 'Tebet', 'Nurkholis Rafsanjani', 'K/0', 'JL MESJID BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '', '0816836500', 'eddyzonderr@yahoo.co.id', '$2y$10$JUlL4RqX0FePdmNx9O9e7.gcUV/TfjYrAgZgRQDrduTUEPaFYYx3O', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (103, 'Tjo Kim Tjai', '3', 4, '075815241015000', NULL, NULL, 'Tebet', 'Rafike Dwi Alvadita', 'TK/1', 'JL.TEBET BARAT, TEBET BARAT, TEBET BARAT, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12810', '', '081932776687', 'tjokim@yahoo.com', '$2y$10$.w3dg/7dx9K51o83fNoozuPvpHSIdQVLXUPVbkde.npKKDXCig2x6', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (104, 'Hardi Winarta', '3', 4, '065506537016000', NULL, NULL, 'Cilandak', 'Rudy Priambodo', 'K/3', 'JL.PURI MUTIARA RT.007/01, CIPETE SELATAN, CIPETE SELATAN, CILANDAK, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12410', '', '081388664303', 'hardiwinata184@yahoo.com', '$2y$10$CNmrz39iUPqvUCgKR1xkouZFA9TnTeH9hCM6QKhm6s9Qv0JBy1NWm', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (105, 'Dicky', '3', 4, '369266408008000', NULL, NULL, 'Duren Sawit', 'Linda Ella Sari Br. S. Maha', 'K/1', 'JL DELIMA RAYA, IX, 1, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '', '62216697035', 'dickyki69@yahoo.com', '$2y$10$/2AtDsXyHCe8qCigjQG/W.sPYIQLBKCfNR3fqLlw0pHIBIRxp7qVu', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (106, 'Lim Hidayat', '3', 4, '070521471008000', NULL, NULL, 'Madya Jakarta Timur', 'Heru Waskita', 'K/2', 'JL.DELIMA RAYA, 5D, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '', '62811198521', 'limhidayat47@gmail.com', '$2y$10$P54uigvhZW/ZmELTtSr0bexTRQY1rv1kSmWD5GdLk4HrKeMs4XuDm', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (107, 'Andri Janto Sudjoko', '3', 4, '076425081031000', NULL, NULL, 'Palmerah', 'Oliver Francois Tambunan', 'TK/0', 'JL. U NO. 31, SLIPI, SLIPI, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11410', '', '0218296579', 'andrijanto96@yahoo.com', '$2y$10$Ge9UJCmokHLwDXHYRp4leu.3HlEhGXTTRoV7BlcOWH94yaNmaDlJa', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (108, 'Sunardi', '3', 4, '076412204031000', NULL, NULL, 'Palmerah', 'Diah Kartika Retna Asih', 'K/3', 'JL H SALEH, 28, PALMERAH, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11480', '', '085692129168', 'sunardi2342@yahoo.com', '$2y$10$Uoi15aM2FHSJHu0vBfR7EupMb5SNVvTx83CXS/biqkEJ6x/hOaOUu', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (109, 'Tjio Suhendra', '3', 4, '076100213023000', NULL, NULL, 'Senen', 'Muchamad Fakhrudin', 'K/1', 'PLAZA ATRIUM LT.V BLOK C-64, SENEN, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '', '081285763362', 'tjio1919@yahoo.com', '$2y$10$do2t7TIqPiN8FFAo8.GLFO0HEu.D8yvGRMcnj8oWvnOChG9wv6Cje', '2026-06-26 12:03:13', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (110, 'Kasim Tukimin', '3', 4, '076100809023000', NULL, NULL, 'Senen', 'Muchamad Fakhrudin', 'K/1', 'ATRIUM PLAZA LT.V, C.77, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '', '081382777199', 'kasimtukimin199@gmail.com', '$2y$10$Hl0xkVJMeryyX2ecUKD5IOqE6oYtHaTK28dt00MqVDC7oO4UJOie6', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (111, 'Agung Sutanto', '3', 4, '091936088402000', NULL, NULL, 'Tangerang Barat', 'Gede Suarsana', 'K/0', 'JL.MERPATI RAYA D17 NO.9, GEBANG RAYA, GEBANG RAYA, PERIUK, KOTA TANGERANG, BANTEN, 15132', '', '0881010622198', 'agungsutanto929@gmail.com', '$2y$10$iuru1acMvtim/.ZNu7A9peOZLpNzoO4FfzmHVrobEMNCJvhsFXmdS', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (112, 'Foeng Fi Min', '3', 4, '076525633416000', NULL, NULL, 'Tangerang Timur', 'Arni Ardiyanti', 'K/0', 'BUDI INDAH, JL KELUD II BLOK A.1 NO. 26 RT 006 RW 07, PORISGAGA, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '', '6281218814902', 'foengfimin8@gmail.com', '$2y$10$n.MEAAmBDTaSoCef28rTUu37fX4oE0w5kh54sPtZ.YN6xcCTsiYli', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (113, 'Yulisna Kohar', '3', 4, '256064957416000', NULL, NULL, 'Tangerang Timur', 'Tri Bekti Utami', 'TK/0', 'BANJAR WIJAYA B.19B/31 RT. 004 RW. 15, PORIS PLAWAD INDAH, CIPONDOH, KOTA TANGERANG, BANTEN, 15141', '', '08121588282', 'yulisnakohar@gmail.com', '$2y$10$k013dKRrtor1ggtVsL0zE.T7hI/zBQt6xTTk5jv.k8Lw7XCj3yoQa', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (114, 'Antonius Sugiarto', '3', 4, '041528902072000', NULL, NULL, 'Tanah Abang Dua', 'Hidayat Imam Bayu', 'K/0', 'JL KEBON JATI, -, 2, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '', '628161923006', 'lijinantonius19@yahoo.com', '$2y$10$albvAFg7wc0bpBF2tYBSi.WzLmzWvNWFCVxmzxrDtNCRm1VTrujdm', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (115, 'Udji Djohan', '3', 4, '076278837026000', NULL, 4, 'Sawah Besar I', 'Handita Kusuma Dewi', 'K/2', 'JL.P.JAYAKARTA BUDI RAHAYU I NO.42 RT.005/009 MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '087788238982', 'djohanudji@gmail.com', '$2y$10$K/YYRF9WNbK0WTTo8cDBduQY/EkKz6y7nR56YsfqdK8UDLa3Iri0C', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (116, 'Koe Sevina Octricia', '3', 4, '711333575036000', NULL, NULL, 'Grogol Petamburan', 'Oryza Aprilia', 'TK/0', 'TANJUNG DUREN DALAM, VII, 14, TANJUNG DUREN SELATAN, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '081932007325', 'koesevina19@gmail.com', '$2y$10$g0V1fDhXQbBXI/xggr3EzuI4pudyXntIn14WU7jGenW9ePQ7A1PLa', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (117, 'Koe Sevina Octricia', '3', 4, '711333575032001', NULL, NULL, 'TamanSari - Cabang', 'Mauridatul Hany', 'TK/0', 'BUNI, 25, MANGGA BESAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11180', '', '6252744', 'koesevina@gmail.com', '$2y$10$RR6Nq/SLvEv8cpqM6076keF24bEhZQ52PBB2KEx5knrgXh/z5hCbW', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (118, 'Olivia Ione Rafin, JD', '3', 4, '071067938047000', NULL, NULL, 'Pluit', 'Hendri Wibisono', 'TK/0', 'KAPUK KAMAL, KAMAL MUARA, KAMAL MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14470', '', '021235700012', 'OLIVIAiONERAFIN@YAHOO.COM', '$2y$10$08jU0in2uLyu95p47F9wNec6AU0NfIbb6GznOD3j63HgPz9y3OQIS', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (119, 'Olivia Ione Rafin, JD', '3', 4, '071067938072001', NULL, NULL, 'Tanah Abang Dua - Cabang', 'Wihandoko Wihandono', 'TK/0', 'PASAR REG.TANAH ABANG BLOK A LT.LG LOS C NO.066-067, KAMPUNG BALI, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '', '235700012', 'OLIVIAIONERAFIN2@YAHOO.COM', '$2y$10$UxjhcKGtndyNKK2LOYi2XOajhQkJ3LAgyAPSld4uOcVZ2BJCEtapS', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (120, 'Safina', '3', 4, '070469572048000', NULL, NULL, 'Tanjung Priok', 'Japlis Windiyono', 'K/0', 'JL SUNTER GARDEN, BLOK D.8, 2 E, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '', '0816775569', 'finasafina1922@gmail.com', '$2y$10$JIMTEUxKWrYTw8rEyx.aOeOFX3Yt5sQ0GfxiATdCaoUTbbAmHbXiu', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (121, '-', '3', 4, '070469572044001', NULL, NULL, 'Pademangan - Cabang', 'Benedetta Krisna Wicaksana', 'K/0', 'PUSAT GROSIR PASAR PAGI MANGGA DUA LT. 4 BLOK BA NO. 113A, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '081380137369', 'safinafin@yahoo.com', '$2y$10$36/uBIr8UehQPlt4EBSXc.m0FBzfUH1xhnoqQiSB6PmB8NHWd9mwK', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (122, 'Sindjaja Jonany', '3', 4, '066512245047000', NULL, 6, 'Pluit', 'Ganendra Edo Satwika', 'K/3', 'JL WALET INDAH I, 21, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '628158007621', 'sindjajajonany8223@yahoo.com', '$2y$10$EATeat4to/fMMsRxTebYKO5mFV4Ad/nNSbmW/Zh1B0Vor3KBfsHx2', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (123, 'Teng Kim Sui', '3', 4, '063628226026000', NULL, 7, 'Sawah Besar Satu', 'Narita Ismi Amalia', 'K/0', 'JL PANGERAN JAYAKARTA NO 46, D, 15, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '081295439081', 'tengkimsui@yahoo.com', '$2y$10$Et87nvGDxK1JnAAov53NbuJTu/YwQWW97SLQcLxVAjq12aaVD9le6', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (124, 'Tjong Kian Tjoeng', '3', 4, '068139740075000', NULL, 8, 'Sawah Besar Dua', 'Lince Ani Fransiska', 'K/0', 'JL KARTINI IV DALAM, 179, KARTINI, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10750', '', '08161827632', 'tjongkian7@gmail.com', '$2y$10$CvVOjVd4xC6O1D/UJHHPxOWk1A9fTJcLCW2cahRpgpcc4YVC.foQy', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (125, 'Christine Yuliani', '3', 4, '738759299952000', NULL, NULL, 'Jayapura', 'Tan Christian Nathanel Budiman', 'TK/0', 'JL. PERIKANAN, 26, HAMADI, JAYAPURA SELATAN, KOTA JAYAPURA, PAPUA, 99126', '', '082399944445', 'dr.christineyuliani@gmail.com', '$2y$10$ipSsUPDvt.ukgRkNRjiIBeE6QAvdT2WVGwhffQJDpXzUcTcsHGHdy', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (126, 'Dely', '3', 4, '594551871033000', NULL, NULL, 'Tambora', 'Rizki Ilham Akbar', 'K/2', 'JL KRENDANG TENGAH I, 86, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '0216296149', 'dely191919@gmail.com', '$2y$10$LvwkCUfM/yzyXtyGvSmeFeP1stkP8p2hHPhnYvXz2kwXQ.OaVNdXG', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (127, 'Devi', '3', 4, '790794184033000', NULL, NULL, 'Tambora', 'Anung Prasetyo Dwijayanto', 'TK/2', 'JL.JEMBATAN BESI II NO.20 NO 20 RT.008 RW.003, JAKARTA BARAT, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '628111988583', 'devimargalou@gmail.com', '$2y$10$r4nxYlzsEuLsBJF/eeZXX.Ilry03v2l7uSUeYcuLxxInYvNEFZ3HC', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (128, 'Dicky Wirayadi Hadipurnama', '3', 4, '064691512033000', '', 9, 'Tambora', 'Riska Septiana Estutik', 'K/0', 'JL GG. TOGE NO.7, 7, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', NULL, '30/03/2023', 'dickdicky1920@gmail.com', '$2y$10$ps2IqDi2RU8fHcxIqh7Kl.KR21R5HxklphGd2KHiVPIaC7.MZNsLa', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (129, 'Eric Saibun Yolinta', '3', 4, '066255183036000', NULL, NULL, 'Grogol Petamburan', 'Zulmy Agung Pambudi', 'K/0', 'JL JELAMBAR ILIR, 22, JELAMBAR BARU, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '', '62818981218', 'ericsaibunyolinta@gmail.com', '$2y$10$JW2QbkmZ/RaJK.ajHKO4/euUX2P0baiYOClyp1H4.2z7e0I0Bi2Zi', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (130, 'Fariak Sugianto Ng', '3', 4, '064354178033000', NULL, NULL, 'Tambora', 'Wursito Atik', 'K/1', 'KP.KRENDANG BARAT RT.006/04, KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '', 'fariaksugianto@gmail.com', '$2y$10$UwXGaJvBc/Sn0dZlKxfgaesyD6Wf8vpEDB5pUvT9B.5IuuHvWA/Vu', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (131, 'Feliciana Kartadinata', '3', 4, '601410541029000', NULL, NULL, 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '081286688869', 'felicianakartadinataa@gmail.com', '$2y$10$hhy9p62DoQNmdabyhd8SZOVwAeIiGHjYbMavCq520VHfcYR1v2VCu', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (132, 'Gouw Keng Hoa', '3', 4, '609298583033000', NULL, NULL, 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'KP KRENDANG, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '081296988658', 'gouwkenghoaa@gmail.com', '$2y$10$lNgZlSVstNfrSOYIkBpD3O0nU5wMelrH0C05WsgRdZ/8q4xe/qKSy', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (133, 'Gunawan Widjaja', '3', 4, '769809096026000', NULL, NULL, 'Sawah Besar Satu', 'Muhammad Ismail Marzuqi', 'TK/0', 'JL MANGGA DUA ABDAD C, 50, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '085881389934', 'widjajagunawan0@gmail.com', '$2y$10$zcxULz7uw2XCrvTxAQhyzOz0pyALD09XW54BOKCssvNpwE07LJbEi', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (134, 'Handy Tjahyadi', '3', 4, '065196412043000', NULL, NULL, 'Kelapa Gading', 'Lesty Phytaloka', 'K/1', 'JL GADING KUSUMA, GK 8, 2, KELAPA GADING TIMUR, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '62813065196412', 'handytjah19@yahoo.com', '$2y$10$x.ifIXV7BepsUqvxv8pLTuWhM92GGI/QxPHwEB2/H7nxK5AWCiQ8K', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (135, 'Haryono Kuswanto', '3', 4, '064493083041000', NULL, NULL, 'Penjaringan', 'Gani Syabani', 'K/3', 'JL TELUK GONG BLOK N3/48, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '628161162915', 'haryonokuswanto99@yahoo.com', '$2y$10$jdeTzMGy.BcQe0q8Nulmkusijue4kcTi7qKkWm1ysO1nA0Iels8Zm', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (136, 'Hauw Bok Soei', '3', 4, '594790560033000', NULL, NULL, 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'JL SONGSI RAYA, 22, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '6281215882824', 'hauwbokk@gmail.com', '$2y$10$6ZiPBtaGVcw9WtmW3p9Jz.NabJJ.EIZi.Iy6/5OyVsXgZ2LyaPnmu', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (137, 'Hendra Koesnandar', '3', 4, '594688335033000', NULL, NULL, 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'JL KHM MANSYUR NO 30B, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '62216909747', 'KOESNANDARHENDRA@YAHOO.COM', '$2y$10$gNd32mnfekqqrGeQr8yEQOx5aYxEUNZt60o2Zn5dRn1VMSUY.4NSq', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (138, 'Hendrik Koesnandar', '3', 4, '594688319033000', NULL, NULL, 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'JL KHM MANSYUR, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '08161891575', 'henrikoesnandar@gmail.com', '$2y$10$3yHy/znaeOc5KYWbMpeX/e5lOdspy.CZGgrB86hpWJla.I706024G', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (139, 'Hongdoras Limantoro', '3', 4, '065882946039000', NULL, NULL, 'Kebon Jeruk Dua', 'Bondan Himawan', 'K/0', 'KOMPLEK GREEN GARDEN BLOK, A5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '08128015571', 'hongdoraslimantoro@gmail.com', '$2y$10$bbxI7oXrL5Jl.hjPXW27Te7tlJXqlWRK40PvOicmCdeujsBEVPwr6', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (140, 'Iman Sumar', '3', 4, '096856315071000', NULL, NULL, 'Menteng Dua', 'Rinawati', 'K/1', 'JL SURABAYA NO.19 PAV, MENTENG, MENTENG, MENTENG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10310', '', '08129899116', 'drg.imansumar@gmail.com', '$2y$10$zV8uBTzOecDXgHh45IWgkOWpEzLH3m9OzV.oLlKi.Wb5baR9Fn1/u', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (141, 'Indra Gunawan', '3', 4, '800629834033000', NULL, NULL, 'Tambora', 'Dian Setyawan', 'K/1', 'JL. ANGKE JAYA VI, 1, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '628999904718', 'Test.slave888@gmail.com', '$2y$10$PjCrNFhencHvYQtPga1dpOX455NumIcWaUflItGRvfgOWKP3iqN.u', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (142, 'Indriany', '3', 4, '768517708029000', NULL, NULL, 'Gambir Tiga', 'Suci Lestari', 'TK/0', 'JL DURI A II, 1, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '08159064396', 'indrianyny@gmail.com', '$2y$10$RU8K7Obe/Rqn/NXNP.4iBuwPp1vBYE.9CT2Cbmewm6f5mYHerV4F6', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (143, 'Jimmy Tirta', '3', 4, '768341000047000', NULL, NULL, 'Pluit', 'Endang Suwarni', 'K/0', 'TAMAN GRISENDA, B1, 75, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '6285379009099', 'jimmytirt@gmail.com', '$2y$10$WsSDUo6Mk6q2A7E13psaZO.kJjevWsy0OwEF/29HfS9fAjXAyadea', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (144, 'Johny Tjahyadi', '3', 4, NULL, NULL, NULL, 'Senen', 'Rachma Hidayanti', 'TK/0', 'JL.KALIBARU TIMUR V, 54L, BUNGUR, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10460', '', '081932807313', 'johnydeep1919@gmail.com', '$2y$10$olwzjLZNULRLCa3.Pg/jNerM0.c4mWF.t.NkE2TAm95/.fvK5peZW', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (145, 'Jong Khim Wong', '3', 4, '076523497033000', NULL, NULL, 'Tambora', 'Dian Setyawan', 'TK/0', 'JL.SAMARASA III NO.20, ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '6281806886366', 'jongkhimwong@gmail.com', '$2y$10$U49geYU3jJqt7mG5P3z9ve1jU.ZakOhm6QpdWtSrXmYUw/YSNQi7W', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (146, 'Jong Pin Njuk', '3', 4, '182805630033000', NULL, NULL, 'Tambora', 'Arum Pawestri', 'TK/0', 'KP DURI DALAM, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '0216342728', 'jongpin171@gmail.com', '$2y$10$Auub0JYKAjlsIGqug3Q2buvWM3B74ytxKif3aOywusSscOj1z9qIG', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (147, 'Kelvin Yohannes', '3', 4, '423242254416000', NULL, NULL, 'Tangerang Timur', 'Arni Ardiyanti', 'TK/0', 'KELUD 2, A1, 26, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '', '081290326683', 'kelvinnyo94@gmail.com', '$2y$10$aGT9FZjI1Ioaj.7LJgBWkOMUxQS4aYxp6aj5uEN.aaECNRhV4o3PO', '2026-06-26 12:03:17', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (148, 'Kok Siu Jin', '3', 4, '062674288033000', NULL, NULL, 'Tambora', 'Dian Krisnasari', 'TK/0', 'JL. KHM. MANSYUR NO.30-B, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '081283789850', 'koksiujin@gmail.com', '$2y$10$TKvj2H1eut5QzZxuWSKup.93USAPAOIm/JGb/7A05Yh2.acewNnAK', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (149, 'Lanny Halim', '3', 4, '768859340037000', NULL, NULL, 'Tamansari', 'Yudo Wahyu Asmoro', 'TK/0', 'JL.KERAJINAN, 24, KEAGUNGAN, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11130', '', '62081281981513', 'lannyhalim19@yahoo.com', '$2y$10$3pcLfeTpA1Ld94RKrwy0DuDAIa6qbuzDpHL3h4hvKkTM.wPnkGixW', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (150, 'Lee Hak Man', '3', 4, '259861037413000', NULL, NULL, 'Cikarang Selatan', 'Isrofah Wijayanti', 'K/2', 'L. MH. THAMRIN B-16 LIPPO CIKARANG RT. 000 RW. 000, CIBATU, CIKARANG SELATAN, KAB. BEKASI, JAWA BARAT, 17855', '', '622189920692', 'aditsgusti@gmail.com', '$2y$10$IllHkIBsZ04a.uieyHntkujb4tNgiHZDVAbZ96MmcdhpP9HHBQ1MC', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (151, 'Lenny Diana', '3', 4, '612036046036000', NULL, NULL, 'Grogol Petamburan', '', '', '', '', '0816775569', NULL, '$2y$10$lW2nfKwbo.9Hv0Ip0yY6G.3UhatiUru3sXn8RDUSdchJSz.LpyUaa', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (152, 'Lim Tiong Kie', '3', 4, '061882171033000', NULL, NULL, 'Tambora', 'Rizki Ilham Akbar', 'K/0', 'JL KP KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '0816470907', 'tiongkiel@gmail.com', '$2y$10$pjDwoWAbqi5zf6lJDjqmyOFQac1HrL2SGSXiW7xE08Nj2ajM9ssMi', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (153, 'Liswati Widjajakusuma', '3', 4, '594947954086000', NULL, NULL, 'Kembangan', 'Nurhadi Eko Waluyo', 'TK/1', 'KOMPLEK TAMAN ALFA INDAH, B3, 12A, JOGLO, KEMBANGAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11640', '', '6281808003646', 'Liswatiwk67@gmail.com', '$2y$10$qW4v4iGOlt8fnFmw6pOm7OFul77VCC4w67JPC7xOYdoMC1GYe1TM6', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (154, 'Martin Raditya Sugiarto', '3', 4, '585219488033000', NULL, NULL, 'Tambora', 'Arum Pawestri', 'K/0', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '6282117706296', 'martinpajak0811@gmail.com', '$2y$10$31DzN.d1FdeOquzLu9PJSeyjo0Z4QeRkDsFQ19IGQtRWE/9RWS7PO', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (155, 'Melly Kurniawan', '3', 4, '095839684043000', NULL, NULL, 'Kelapa Gading', 'Gibran Kurniawan N', 'TK/0', 'APT CITY HOME, TOWER MIAMI BAY LT 1 NO. 11 RT 007 RW 019 KELAPA GADING BARAT, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '02168710485', 'melykurni99@gmail.com', '$2y$10$rTtAT0.jjqT4M4YWgf0Kn.ahOghzzQaQLIdGRSgp2.msZoh6c.cb2', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (156, 'Michael', '3', 4, '809973936036000', NULL, NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'JL. ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '6287808780871', 'bonifasiusmichael92@gmail.com', '$2y$10$PYQM/VoceQLd1iszXGQWkOuVsfNpCAE3NoJ/DDS0fCWCtbqpSxmc.', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (157, 'Mustar Abidin', '3', 4, '041331570036000', NULL, NULL, 'Grogol Petamburan', '', '', '', '', '', NULL, '$2y$10$RvzC.wyeiB.x6IeBCpfW8.XJrsOEPP1lNBwrx0/ALrKqLqRUQ7kCe', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (158, 'Oei Suriaty', '3', 4, '095270856015000', NULL, NULL, 'Tebet', 'Andri', 'TK/0', 'JL. TEBET BARAT NO. 67 RT.016 RW 001, TEBET BARAT, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12810', '', '6289692753614', 'oeisuriaty.tax@gmail.com', '$2y$10$y/1FRQ0ofXf/2x45s65VYu/50JgqsZIij0UOwEamoA1zrrzICGjNy', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (159, 'Puspa Dewi', '3', 4, '584261549033000', NULL, NULL, 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'JL ARABIKA NO.15, JAKARTA BARAT, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '0216922616', 'ohdewipuspa@yahoo.com', '$2y$10$fXSJdXZwGH3gatDAdpGBT.G9prQXE3iFuh6pr0JwK.dVYM4se.58m', '2026-06-26 12:03:18', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (160, 'Rahman Halim', '3', 4, '076439231031000', NULL, NULL, 'Palmerah', '', '', '', '', '', 'rahmanhalimm21@gmail.com', '$2y$10$Iednie2YI6N5bnRocihkiuRC06mTjALpv/xEs10aBRg/RxVeS815G', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (161, 'Rio Gunawan Sejati', '3', 4, '493304083028000', NULL, NULL, 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'JL KEBON JAHE II NO.14 NO 14 RT.006 RW.02, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '087886687898', 'rigunse@gmail.com', '$2y$10$Sp2usb7X1gVD4VnBOKcHaOR7V.srjm3hBeJDt0QO8VzGUzj7eUA8m', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (162, 'Rita Koesnandar', '3', 4, '594688343033000', NULL, NULL, 'Tambora', 'Dian Krisnasari', 'TK/0', 'KHM MANSYUR NO.30B RT.001 RW.002, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '0811145152', 'ritakoeskoes19@yahoo.com', '$2y$10$V4DrnSxyqy/C602K6Ar5WunHtyI68Ie61pO7CN9V4WdUfx/J1mbNO', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (163, 'Rizal Kartadinata', '3', 4, '659705925029000', NULL, NULL, 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '6289636360091', 'rizalkartadinataaa@gmail.com', '$2y$10$8KFFJcEiwDTcnaRMCU9R/.k8ZlFxrNaDuvXM3sb1foNobGJTdcuKS', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (164, 'Ronald Russel', '3', 4, '550725881036000', NULL, NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'JL. ALPUKAT VII NO.4 RT.008 RW.002, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '081229922080', 'vincentsius.russell@gmail.com', '$2y$10$Ar0jd/oO4DZpNs8aCtr12unT5xkPx.hDZTnqfPOswrwgVpBdxuduK', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (165, 'Rudy Susanto', '3', 4, '814779757033000', NULL, NULL, 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'JL PETAK SERANI III, 48, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '085311690052', 'rudysusaantooo@gmail.com', '$2y$10$Gr2PGwfxQl5igCEzwgAvd.AvonthK.fG95RSjj7.XeXajpuAobO6S', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (166, 'Sarianto Jony', '3', 4, '076524867033000', NULL, NULL, 'Tambora', 'Satriyo Dwi Yulisetyawan', 'TK/0', 'JL PENGUKIRAN RAYA NO.40 A, PEKOJAN, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '081385561767', 'sariantojony8@gmail.com', '$2y$10$yZXx1h1xgutEZlIPtPKoNu7Mu5u0IXwbH6VnpTy7YFFEm3tlE0gF.', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (167, 'Sri Mulyani', '3', 4, '390396901085000', NULL, NULL, 'Kalideres', '', '', 'PERUM PARK RESIDEN, C, 38, PEGADUNGAN, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11830', '', '0881010622198', 'SRIMLYNI1980@GMAIL.COM', '$2y$10$lSoE5/dj6qvgJQwl6aFMnO9UKxgTUa/rGUyrQ.7BOfKPHPmarSQr2', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (168, 'Suhendra Tirtaputra', '3', 4, '144329570041000', NULL, NULL, 'Penjaringan', 'Imam Taj\'ri', 'TK/0', 'JL JEMBATAN II GG PETASAN / 114 RT 004/002 PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '622166695306', 'suhendratirtaputra5@gmail.com', '$2y$10$VHgbdIMqeRfuI7H2McneheVT7J2Afln.9gAUyYHP1skkYu0zTr22y', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (169, 'Sukim Hartono', '3', 4, '175850601033000', NULL, NULL, 'Tambora', 'Dhani Kristanti', 'K/2', 'JL KHM MANSYUR 217 RT.004 RW.002, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '', '08121931806', 'SUKIMHARTONO19@gmail.COM', '$2y$10$CfjaP/1SS.SukhRcRdRbWecf5/bA5Jmi2//zUUWIn0pz93v98Qaxm', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (170, 'Sung Njit Bui', '3', 4, '071338727034000', NULL, NULL, 'Cengkareng', 'Ikhwanussidiq Suhartono', 'K/0', 'TAMAN PALEM LESTARI B.I/A.9, CENGKARENG BARAT, CENGKARENG BARAT, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '081213174077', 'sungnjitbuiii@gmail.com', '$2y$10$7WKcrYDBVeMFVrG7cbSLd.RS5ErFDyIuQQNCASdxAMxZxHO0/y5Ga', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (171, 'Supriyono', '3', 4, '811965540034000', NULL, NULL, 'Cengkareng', 'Martua Halomon Sihombing', 'K/2', 'JL. PEDONGKELAN, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '085894279208', 'supriyonosuprii121@gmail.com', '$2y$10$ABjnCJRPkCJ2U.fXiaMQDuaty8hfmShYgF8Rt51S9XtVMTrjjXoAm', '2026-06-26 12:03:19', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (172, 'Tony Esrianto', '3', 4, '066258906036000', NULL, NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/1', 'JL ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '62811170029', 'tony_esriantotio@yahoo.com', '$2y$10$lci5GmtDru4XxEtjZaFYD.zyde9iFw5GsCLtw1xUv2w43qPfoqKIO', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (173, 'Wong Song Moy', '3', 4, '584261556033000', NULL, NULL, 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'JL ARABIKA, 15, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '0216904724', 'wongsongmoy@yahoo.com', '$2y$10$M8Mc7Njjiwl6KMHOml4J/uBVyWW2wBhTGp860NV/WKn7JnV9hYX0G', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (174, 'Yessica', '3', 4, '421122813416000', NULL, NULL, 'Tangerang Timur', 'Moh Ikhsan Iskandar', 'TK/0', 'PERMATA RAYA, C2, 37, CIPONDOH MAKMUR, CIPONDOH, KOTA TANGERANG, BANTEN, 15148', '', '', 'yessica.chenyiping@gmail.com', '$2y$10$Reh9TS/eVHVmg8FuaoUCIu9C.OgaET7zVM6xkuAQ2wicrzYKJEEJC', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (175, 'Tania Theresa Halim', '3', 4, '081777157903100', NULL, NULL, 'Palmerah', '', '', '', '', '', 'taniatheresahalim@gmail.com', '$2y$10$m6bVkbksTTnhmhC1H.Xp1OGgxS8qakNnIPA/qsPNVRWl8.OsWzVr6', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (176, 'Joshua Jeremy Halim', '3', 4, '081777157903100', NULL, NULL, 'Palmerah', '', '', '', '', '', NULL, '$2y$10$ThYUYFdt9rSQ35sgDWCQaeqEf6IZYweZ/2O2OAl.Rq4ke7ipPPZN2', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (177, 'Liem Lies Rohana', '3', 4, '4280430200033000', NULL, NULL, 'Tambora', '', '', '', '', '', NULL, '$2y$10$DdqQlxUh9KIY4fQ6rl2fiuqeeyxoML6D0MczUwkNPEWJY47B/EJm6', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (178, 'Sung Oi Jan', '3', 4, '3173045010740010', NULL, NULL, 'Tambora', '', '', '', '', '081213818778', 'oijan776@gmail.com', '$2y$10$gC/FAOaSda6fMEgry5QdDO4eYdroWLt7Xy/nasvi/upZEBNL4IqcK', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (179, 'Felix Salm', '3', 4, '3173021802870004', NULL, NULL, NULL, '', '', '', '', '081213818778', NULL, '$2y$10$yhPxkkfwtvJMvUhz2Xd5aeVYicQ1m2s7WszJSoRT1.2qRFGGLyg5y', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (180, 'CV. Anugerah Lestari Maju', '3', 4, '828123679047000', NULL, NULL, 'Pluit', 'Wisnu Febryanzah Prasetyo', 'NON PKP', 'JL.RAYA KAPUK MUARA, 9, KAMAL MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14470', '', '02155956827', 'cvalestari19@gmail.com', '$2y$10$VIC8nFEWwgxu/Y8u4yxRYulbZkowQl.T9/X8wQBEKKV/NXoOwzXNa', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (181, 'CV. Beta Musik', '3', 4, '025667411032000', NULL, NULL, 'Tamansari', 'Ilham Syaiful Alam', 'NON PKP', 'PERTOKOAN RUKO GLODOK PLAZA BLOK F NO. 103, MANGGA BESAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11180', '', '082258555347', 'betamusikk@gmail.com', '$2y$10$TJWx0ac2sHEw3uhgriRMOOT47M42wE7GdXNhyuVBQwP9ab6kkti1.', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (182, 'CV. Bundaran', '3', 4, '914634241033000', NULL, NULL, 'Tambora', 'Ridwan', 'NON PKP', 'JL KH MOCH MANSYUR, 129, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '081315619996', 'bundarancv@gmail.com', '$2y$10$eak1DyvegtQj1jyzVlVpGO6VTRoMGN1BwYMTNw8eHyDINJ3QZhiuy', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (183, 'PT. Cakra Lintas Nusa', '3', 4, '611296351034000', NULL, NULL, 'Cengkareng', 'Fia Aulia Nurbina', 'NON PKP', 'KOMPLEK RUKO CITYPARK BISNIS DISTRIK BLOK C2-12 TAMAN PALM MUTIARA, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '082124656668', 'cakralintasnusaa@gmail.com', '$2y$10$qvtYUhmMEWKn1ZyP7C.yduU1uU9TfOwkwgT9fz6n79x34djicEj9W', '2026-06-26 12:03:20', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (184, 'PT. Citra Inti Pilar', '3', 4, '740877394085000', NULL, NULL, 'Kalideres', 'Adhitya Primadha Andi', 'PKP', 'RUKO KALIDERES MEGAH JL PETA SELATAN, A, 1, KALIDERES, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11840', '', '6221713689', 'CIP191220@GMAIL.COM', '$2y$10$N646yyHJVApQ1bVB7M2PdevuLCj7aCBeaUvlhSQMLMTXSzCRlpwK6', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (185, 'PT. HBI Incomindo Nusantara', '3', 4, '935185256036000', NULL, NULL, 'Grogol Petamburan', 'Fenti Eka Septina', 'NON PKP', 'JL TANJUNG DUREN TIMUR 6 BLOK I NO 431E, TANJUNG DUREN SELATAN, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '02156949333', 'HBIINCOMINDO@GMAIL.COM', '$2y$10$BoBAEeR95/s6J8TngJnEcOLUgCmqdebdcNFJjeca28AY85Hj8JKhu', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (186, 'PT. Jaya Kreasi Tas', '3', 4, '828839860044000', NULL, NULL, 'Pademangan', 'Benedetta Krisna Wicaksana', 'NON PKP', 'JL PUSAT GROSIR PASAR PAGI MANGGA DUA LT 1 BLOK KA NO. 1 A, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '081212151471', 'jayakreasitas@gmail.com', '$2y$10$uNEu0HEr2IvhfWlJA1a6y.EhAkTLEH4Xzl8QjUjBtRxnmBP3UCmdG', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (187, 'PT. Kharisma Indo Multi', '3', 4, '432822740039000', NULL, NULL, 'Kebon Jeruk Dua', 'Arumtyas Nugraheni', 'PKP', 'RUKO GREEN GARDEN, A14, 36, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '082260889909', 'deri.tjong@gmail.com', '$2y$10$Iuqb5fNGha5/0Q2NY.d9t.kor5upnJ0F6CX3bSqFw2N47LKVJADCi', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (188, 'PT. Lestari Giat Jaya', '3', 4, '017211509034000', NULL, NULL, 'Cengkareng', 'Puspa Ayu Wulandari', 'NON PKP', 'JL. PEDONGKELAN, 1, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08158007131', 'lestarigj00@gmail.com', '$2y$10$bymeNjkPpHFoaxzG8FWXCOm7oyf5KZWFxw/zHyNxEpcGWa0A3ebHC', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (189, 'PT. MG Dua Jaya', '3', 4, '027473420047000', NULL, NULL, 'Pluit', 'Ganendra Edo Satwika', 'NON PKP', 'JL PANTAI INDAH SELATAN I ST/D-A 12 PIK, KAPUK MUARA, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '0215882816', 'mgdua70@gmail.com', '$2y$10$gxI.oibCWSsvVqJ4HSaRc.zsrPQm5IJMh1oNPZIPc9GhvrOJiYJQ.', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (190, 'PT. Tirta Agung Nusantara', '3', 4, '031652100026000', NULL, NULL, 'Sawah Besar Satu', 'Yuan Robi Arta', 'NON PKP', 'JL MANGGA DUA RAYA GEDUNG MALL MANGGA DUA LT 2, 25 B1, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '628128618000', 'tirtagungnusantara@gmail.com', '$2y$10$JdztCpXvkOkK13k/avzMJ.0E/k7IWd1aNWrIxDnaST8oA6XNpNigu', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (191, 'Wihara Tilakkhana', '3', 4, '022936223033000', NULL, NULL, 'Tambora', 'Fibri Kurniawan Sunu', 'NON PKP', 'JL.ARABIKA NO.15, PEKOJAN, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '6922616', 'wiharatillakhana@yahoo.com', '$2y$10$RB3bzeH.iCuQEYCBPTv6FuEAszQwMJPft8Q.f/TYs2A1CzWmjN3iO', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (192, 'Yayasan Kusuma Bangsa G. Baroe', '3', 4, '015818248032000', NULL, NULL, 'Tamansari', 'Senisa Selni Selena', 'NON PKP', 'JL.MANGGA BESAR IX NO.14 RT 13/01, TANGKI, TANGKI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11160', '', '626912460', 'ykbangsa19@gmail.com', '$2y$10$LKmUPn44cWryhxq5g.IbXuOD3tkHqL2jU8ek.08HAU3SpzAMTNYGy', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (193, 'PT. Dunia Selera Indo', '3', 4, '211123799413000', NULL, NULL, 'Serpong', 'Nugroho Kristianto', 'NON PKP', 'JL ALAM SUTERA BOULEVARD KAV.21, LIVING WORLD ALAM SUTERA, G-81, PAKULONAN, SERPONG UTARA, KOTA TANGERANG SELATAN, BANTEN, 15334', '', '081317704800', 'ajenfoodvill209@gmail.com', '$2y$10$HhSqofjvJ9vPszkfcj0dD.ej3vOYqe6hygDOnsGC7joQBMPAmrC.e', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (194, 'PT. Ajen Food Vill', '3', 4, '848041026452000', NULL, NULL, 'Tigaraksa', 'Santi Susilarini', 'NON PKP', 'SUPERMALL KARAWACI, UNIT LG, 39 A-B, BENCONGAN, KELAPA DUA, KAB. TANGERANG, BANTEN, 15832', '', '0215466666', 'dseleraindo@gmail.com', '$2y$10$ZC/EXsfL/QbFF12rzQPaMebomawNKY.btYZlWu3ZGokvID9sKBiNu', '2026-06-26 12:03:21', '2026-07-12 16:30:07');
COMMIT;

-- ----------------------------
-- Table structure for cms_kategori_lampiran
-- ----------------------------
DROP TABLE IF EXISTS `cms_kategori_lampiran`;
CREATE TABLE `cms_kategori_lampiran` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_kategori_lampiran
-- ----------------------------
BEGIN;
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (1, 'KAS', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (2, 'PIUTANG', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (3, 'INVESTASI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (4, 'HARTA BERGERAK', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (5, 'HARTA TIDAK BERGERAK', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (6, 'HARTA LAINNYA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (7, 'TOTAL HUTANG', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
COMMIT;

-- ----------------------------
-- Table structure for cms_lampiran_spt
-- ----------------------------
DROP TABLE IF EXISTS `cms_lampiran_spt`;
CREATE TABLE `cms_lampiran_spt` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned DEFAULT NULL,
  `npwp_cabang_id` bigint unsigned DEFAULT NULL,
  `tahun` int DEFAULT NULL,
  `lampiran_spt_id` bigint unsigned DEFAULT NULL,
  `nilai` decimal(18,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_lampiran_spt_client_id_foreign` (`client_id`),
  KEY `cms_lampiran_spt_lampiran_spt_id_foreign` (`lampiran_spt_id`),
  KEY `cms_lampiran_spt_npwp_cabang_id_foreign` (`npwp_cabang_id`),
  CONSTRAINT `cms_lampiran_spt_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_lampiran_spt_lampiran_spt_id_foreign` FOREIGN KEY (`lampiran_spt_id`) REFERENCES `cms_master_lampiran_spt` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_lampiran_spt_npwp_cabang_id_foreign` FOREIGN KEY (`npwp_cabang_id`) REFERENCES `cms_npwp_cabang` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_lampiran_spt
-- ----------------------------
BEGIN;
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (1, 24, NULL, 2026, 1, 1000000.00, '2026-06-27 12:22:53', '2026-06-27 12:22:53');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (2, 24, NULL, 2026, 13, 10000.00, '2026-06-27 12:22:53', '2026-06-27 12:22:53');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (3, 24, NULL, 2026, 15, 20000.00, '2026-06-27 12:22:53', '2026-06-27 12:22:53');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (4, 24, NULL, 2026, 51, 2000000.00, '2026-06-27 12:22:53', '2026-06-27 12:22:53');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (5, 24, 1, 2026, 2, 3000000.00, '2026-06-27 12:22:54', '2026-06-27 12:22:54');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (6, 4, NULL, 2026, 1, 30000.00, '2026-06-27 12:24:41', '2026-06-27 12:24:41');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (7, 4, NULL, 2026, 4, 30000.00, '2026-06-27 12:24:41', '2026-06-27 12:24:41');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (8, 115, NULL, 2026, 1, 4000000.00, '2026-06-27 12:25:23', '2026-06-27 12:25:23');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (9, 128, NULL, 2026, 1, 100000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (10, 128, NULL, 2026, 9, 200000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (11, 128, NULL, 2026, 12, 1000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (12, 128, NULL, 2026, 15, 10000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (13, 128, NULL, 2026, 40, 10000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (14, 128, NULL, 2026, 45, 1000000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (15, 128, NULL, 2026, 65, 10000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `npwp_cabang_id`, `tahun`, `lampiran_spt_id`, `nilai`, `created_at`, `updated_at`) VALUES (16, 128, NULL, 2026, 68, 10000000.00, '2026-07-11 16:53:21', '2026-07-11 16:53:21');
COMMIT;

-- ----------------------------
-- Table structure for cms_lampiran_spt_detail
-- ----------------------------
DROP TABLE IF EXISTS `cms_lampiran_spt_detail`;
CREATE TABLE `cms_lampiran_spt_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint unsigned NOT NULL,
  `tahun` int NOT NULL,
  `kode` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_akun` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `atas_nama` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_bank_institusi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lokasi_harta` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kurs` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tahun_perolehan` int DEFAULT NULL,
  `saldo_saat_ini` decimal(20,2) NOT NULL DEFAULT '0.00',
  `saldo_bentuk_awal` decimal(20,2) NOT NULL DEFAULT '0.00',
  `nilai_kurs` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_lampiran_spt_detail_client_id_foreign` (`client_id`),
  CONSTRAINT `cms_lampiran_spt_detail_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_lampiran_spt_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for cms_master_lampiran_spt
-- ----------------------------
DROP TABLE IF EXISTS `cms_master_lampiran_spt`;
CREATE TABLE `cms_master_lampiran_spt` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `kategori_id` bigint unsigned NOT NULL,
  `sub_kode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_master_lampiran_spt_kategori_id_foreign` (`kategori_id`),
  CONSTRAINT `cms_master_lampiran_spt_kategori_id_foreign` FOREIGN KEY (`kategori_id`) REFERENCES `cms_kategori_lampiran` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_master_lampiran_spt
-- ----------------------------
BEGIN;
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (1, 1, '0101', 'UANG TUNAI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (2, 1, '0102', 'TABUNGAN', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (3, 1, '0103', 'GIRO', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (4, 1, '0104', 'DEPOSITO', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (5, 1, '0105', 'UANG ELEKTRONIK', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (6, 1, '0106', 'CEK', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (7, 1, '0107', 'WESSEL', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (8, 1, '0108', 'KERTAS KOMERSIAL', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (9, 1, '0109', 'SETARA KAS', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (10, 1, '0110', 'UANG TUNAI/BANK NOTE/KOIN', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (11, 1, '0111', 'SETARA KAS LAINNYA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (12, 2, '0201', 'PIUTANG USAHA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (13, 2, '0202', 'PIUTANG AFILIASI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (14, 2, '0209', 'PIUTANG LAINNYA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (15, 3, '0310', 'ASURANSI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (16, 3, '0311', 'REKSA DANA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (17, 3, '0312', 'OBLIGASI PEMERINTAH/PENGURUSAN PEMERINTAH', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (18, 3, '0313', 'OBLIGASI SW', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (19, 3, '0314', 'SAHAM', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (20, 3, '0315', 'OBLIGASI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (21, 3, '0316', 'REKSA SAHAM', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (22, 3, '0317', 'REKSA CAMPURAN', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (23, 3, '0318', 'REKSA OBLIGASI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (24, 3, '0319', 'REKSA PENDAPATAN TETAP', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (25, 3, '0320', 'REKSA TERPROTEKSI', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (26, 3, '0321', 'PENYERTAAN MODAL PADA BADAN USAHA YANG DIVIDENDENDENDENYA DIKENAKAN PEMOTONGAN PAJAK', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (27, 3, '0322', 'KAS PENJUALAN/PEMBELIAN REKSA DANA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (28, 3, '0323', 'PERSEKUTUAN/FIRMA/CV', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (29, 3, '0324', 'INVESTASI LAINNYA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (30, 4, '0401', 'SEPEDA', '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (31, 4, '0402', 'SEPEDA MOTOR', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (32, 4, '0403', 'MOBIL PENUMPANG', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (33, 4, '0404', 'BUS', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (34, 4, '0405', 'KENDARAAN ANGKUTAN JALAN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (35, 4, '0406', 'KENDARAAN TUJUAN KHUSUS', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (36, 4, '0407', 'KERETA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (37, 4, '0408', 'PESAWAT TERBANG', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (38, 4, '0409', 'KAPAL', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (39, 4, '0410', 'MESIN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (40, 4, '0411', 'GEROBAK', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (41, 4, '0412', 'KAPAL PESIAR', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (42, 4, '0499', 'HARTA BERGERAK LAINNYA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (43, 5, '0501', 'TANAH KOSONG', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (44, 5, '0502', 'TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (45, 5, '0503', 'APARTEMEN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (46, 5, '0504', 'VESSEL', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (47, 5, '0505', 'TANAH ATAU LAHAN UNTUK USAHA (LAHAN PERTANIAN, PERKEBUNAN, DSB)', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (48, 5, '0506', 'TANAH DAN/ATAU BANGUNAN UNTUK USAHA (TOKO, PABRIK, DSB)', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (49, 5, '0507', 'TANAH DAN/ATAU BANGUNAN YANG DISEWAKAN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (50, 5, '0509', 'HARTA TIDAK BERGERAK LAINNYA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (51, 6, '0601', 'PATEN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (52, 6, '0602', 'ROYALTI', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (53, 6, '0603', 'MEREK DAGANG', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (54, 6, '0699', 'HARTA TIDAK BERWUJUD LAINNYA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (55, 6, '0701', 'EMAS BATANGAN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (56, 6, '0702', 'EMAS PERHIASAN', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (57, 6, '0703', 'BATANGAN NON EMAS', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (58, 6, '0704', 'PERHIASAN NON EMAS', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (59, 6, '0705', 'PERMATA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (60, 6, '0706', 'BARANG-BARANG SENI DAN ANTIK', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (61, 6, '0707', 'PERALATAN OLAH RAGA KHUSUS', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (62, 6, '0708', 'PERALATAN ELEKTRONIK', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (63, 6, '0709', 'PERABOT RUMAH TANGGA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (64, 6, '0710', 'PERALATAN KANTOR', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (65, 6, '0711', 'JET SKI', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (66, 6, '0712', 'PERSEDIAAN USAHA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (67, 7, '101', 'UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (68, 7, '102', 'KARTU KREDIT', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (69, 7, '103', 'UTANG AFILIASI', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `created_at`, `updated_at`) VALUES (70, 7, '109', 'UTANG LAINNYA', '2026-06-27 10:17:25', '2026-06-27 10:17:25');
COMMIT;

-- ----------------------------
-- Table structure for cms_master_rumus
-- ----------------------------
DROP TABLE IF EXISTS `cms_master_rumus`;
CREATE TABLE `cms_master_rumus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tipe_badan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_value` decimal(18,2) NOT NULL DEFAULT '0.00',
  `potongan_persentase` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_master_rumus
-- ----------------------------
BEGIN;
INSERT INTO `cms_master_rumus` (`id`, `tipe_badan`, `max_value`, `potongan_persentase`, `created_at`, `updated_at`) VALUES (1, '3', 500000000.00, 0.50, '2026-06-26 10:26:52', '2026-06-27 09:22:00');
COMMIT;

-- ----------------------------
-- Table structure for cms_media
-- ----------------------------
DROP TABLE IF EXISTS `cms_media`;
CREATE TABLE `cms_media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` bigint unsigned NOT NULL,
  `disk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'public',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alt_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
-- Table structure for cms_npwp_cabang
-- ----------------------------
DROP TABLE IF EXISTS `cms_npwp_cabang`;
CREATE TABLE `cms_npwp_cabang` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_client_id` bigint unsigned DEFAULT NULL,
  `nama_client` text COLLATE utf8mb4_unicode_ci,
  `tipe_badan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_role_id` bigint unsigned DEFAULT NULL,
  `npwp` text COLLATE utf8mb4_unicode_ci,
  `kpp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ptkp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_npwp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `alamat_tagihan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `no_telephone` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_npwp_cabang_data_client_id_foreign` (`data_client_id`),
  CONSTRAINT `cms_npwp_cabang_data_client_id_foreign` FOREIGN KEY (`data_client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_npwp_cabang
-- ----------------------------
BEGIN;
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (1, 24, 'Sumitro Lie', '3', 4, '189399025072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'PUSAT GROSIR METRO TANAH ABANG LT. 2 BLOK B NO. 1, KEBON KACANG, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '', '62213036591', 'sumitrolie69@yahoo.com', '$2y$10$dzafk0/A0XtZRpzo.gpSdu6QQRhsoSlSpXhMmJiWSiBEJYN71Lae6', '2026-06-26 12:03:06', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (2, 29, 'Tjiu Jun Shin', '3', 4, '076531904072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'PUSAT GROSIR METRO TANAH ABANG, PGMTA LANTAI III LOS B NO 19 KELURAHAN KEBON KACANG, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '', '02162216303403', 'tjiuju2@yahoo.com', '$2y$10$P7LYZO1T4Mq9mwwTot4v2OggCYZ0rhsSZdnUmLsGc/Y8CyHU5q1Qi', '2026-06-26 12:03:07', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (3, 115, 'Udji Djohan', '3', 4, '076278837043001', 'Kelapa Gading - Cabang', 'Abdul Hakim Amin', 'K/2', 'JL. ARTA GADING SELATAN, B6 LT. 1, 22, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '087788238982', 'Djohanudji@gmail.com', '$2y$10$mLglGtbbsuAdyfXF.gUuYOBLHYOpJTEmHddt/L/kGE0yrOq2Sf6Ta', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (4, 115, 'Udji Djohan', '3', 4, '076278837044001', 'Pademangan - Cabang', 'Dhimas Fery Agung Prabowo', 'K/2', 'ITC MANGGA DUA LANTAI 3, BLOK A, No. 96, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '087788238982', 'udjidjohann@gmail.com', '$2y$10$IjTOAYYU4yhZx6bDZ0LGXujoinW9hufdc5DYjqB8mwNRq24a8mjMC', '2026-06-26 12:03:14', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (5, 122, 'Sindjaja Jonany', '3', 4, '066512245044001', 'Pademangan - Cabang', 'Benedetta Krisna Wicaksana', 'K/3', 'PS. PAGI LT. SEMIBASEMENT BLOK, ANCOL, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '0817881156', 'sindjajapspagi@yahoo.com', '$2y$10$kZ/eBZtUlZM4rw65gxNiKO15Qa4DQOp8PvBBMWF3tCtxA4CfqcBXG', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (6, 122, 'Sindjaja Jonany', '3', 4, '066512245044002', 'Pademangan - Cabang', 'Dhimas Fery Agung Prabowo', 'K/3', 'TC MG.DUA LT.3 BLOK A NO.3, ANCOL, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '6281580007621', 'sindjajaitc@yahoo.com', '$2y$10$C3yTwRwKQO5ljZxN.kw/x.7dOqBHBSxBV0RCquNmY.bsl0.cGS25u', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (7, 123, 'Teng Kim Sui', '3', 4, '063628226023002', 'Senen - Cabang', 'Muchamad Fakhrudin', 'K/0', 'PLAZA ATRIUM SENEN LT 5 NO C 72, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '', '0216287864', 'tengkimsui2@yahoo.com', '$2y$10$5o7h7NlUJ/G5O1qKZ6BQBusIAWUws6haj.e/NLS8kFBakr/WxIEXu', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (8, 124, 'Tjong Kian Tjoeng', '3', 4, '068139740026001', 'Sawah Besar Satu - Cabang', 'Yuan Robi Arta', 'K/0', 'MANGGA DUA MALL LT.I NO.4A, MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '62216127972', 'tjongkian2@yahoo.com', '$2y$10$zUa0k3UwsUpuw3zJy7wNMezB/tHIgcvKGngEeKRcuJpHASKqu7Mu.', '2026-06-26 12:03:15', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (9, 128, 'Dicky Wirayadi Hadipurnama', '3', 4, '064691512037001', 'Tamansari', 'C. Wahyu Triwibowo Arikadi Putra', NULL, 'PASAR PAGI ASEMKA LT. BASEMENT, B174/175, PINANGSIA, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11110', '', '087882550888', 'dickywiryadihadipurnama@gmail.com', '$2y$10$qRp.muGQKrmrH.peDOq5IuvWe8dGIANxb9nywPLhv.PUKatCg3Hgu', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
INSERT INTO `cms_npwp_cabang` (`id`, `data_client_id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (10, 128, 'Dicky Wirayadi Hadipurnama', '3', 4, '064691512037002', 'Tamansari', NULL, NULL, '', '', NULL, NULL, '$2y$10$B1OIbd/4VwiqxDxNr2Su3OHGgASR8eN3uTB0DtSqJZxmZ281GiGci', '2026-06-26 12:03:16', '2026-07-12 16:30:07');
COMMIT;

-- ----------------------------
-- Table structure for cms_pages
-- ----------------------------
DROP TABLE IF EXISTS `cms_pages`;
CREATE TABLE `cms_pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
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
  `nama_pasal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_pasal
-- ----------------------------
BEGIN;
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (1, 'Pasal 1 - Ketentuan Umum', 1, '2026-06-26 07:49:24', '2026-06-26 07:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (2, 'Pasal 2 - Hak dan Kewajiban', 1, '2026-06-26 07:49:24', '2026-06-26 07:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (3, 'Pasal 3 - Tata Cara Pendaftaran', 1, '2026-06-26 07:49:24', '2026-06-26 07:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (4, 'Pasal 4 - Sanksi Pelanggaran', 1, '2026-06-26 07:49:24', '2026-06-26 07:49:24');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (5, 'Pasal 5 - Ketentuan Penutup', 1, '2026-06-26 07:49:24', '2026-06-26 07:49:24');
COMMIT;

-- ----------------------------
-- Table structure for cms_permissions
-- ----------------------------
DROP TABLE IF EXISTS `cms_permissions`;
CREATE TABLE `cms_permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_roles
-- ----------------------------
BEGIN;
INSERT INTO `cms_roles` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES (1, 'Administrator', 'administrator', 'Full CMS access', '2026-06-26 07:49:18', '2026-06-26 07:49:18');
COMMIT;

-- ----------------------------
-- Table structure for cms_settings
-- ----------------------------
DROP TABLE IF EXISTS `cms_settings`;
CREATE TABLE `cms_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
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
  `npwp_cabang_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaksi_client_cabang_tahun_unique` (`client_id`,`npwp_cabang_id`,`tahun`),
  KEY `cms_transaksi_client_id_foreign` (`client_id`),
  KEY `cms_transaksi_npwp_cabang_id_foreign` (`npwp_cabang_id`),
  CONSTRAINT `cms_transaksi_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cms_transaksi_npwp_cabang_id_foreign` FOREIGN KEY (`npwp_cabang_id`) REFERENCES `cms_npwp_cabang` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi
-- ----------------------------
BEGIN;
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (1, 1, 2026, 3, 700000000.00, 0.00, 0.00, '2026-06-27 10:41:11', '2026-06-27 10:41:11', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (2, 3, 2026, 3, 40000000.00, 0.00, 0.00, '2026-06-27 10:48:32', '2026-06-27 10:48:32', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (14, 4, 2026, 3, 40000000.00, 0.00, 0.00, '2026-06-27 12:24:41', '2026-06-27 12:24:41', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (15, 115, 2026, 3, 40000000.00, 0.00, 0.00, '2026-06-27 12:25:24', '2026-06-27 12:25:24', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (16, 115, 2026, 3, 0.00, 0.00, 0.00, '2026-06-27 12:25:24', '2026-06-27 12:25:24', 3);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (17, 115, 2026, 3, 0.00, 0.00, 0.00, '2026-06-27 12:25:24', '2026-06-27 12:25:24', 4);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (18, 24, 2026, 3, 900000000.00, 0.00, 0.00, '2026-06-27 12:26:15', '2026-06-27 12:26:15', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (19, 24, 2026, 3, 35000000.00, 0.00, 0.00, '2026-06-27 12:26:15', '2026-06-27 12:26:15', 1);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (20, 128, 2026, 3, 1539000000.00, 0.00, 0.00, '2026-07-11 16:48:00', '2026-07-11 16:48:00', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (21, 128, 2026, 3, 1070000000.00, 0.00, 0.00, '2026-07-11 16:48:00', '2026-07-11 16:48:00', 9);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (22, 128, 2026, 3, 100000000.00, 0.00, 0.00, '2026-07-11 16:48:00', '2026-07-11 16:48:00', 10);
COMMIT;

-- ----------------------------
-- Table structure for cms_transaksi_harta
-- ----------------------------
DROP TABLE IF EXISTS `cms_transaksi_harta`;
CREATE TABLE `cms_transaksi_harta` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `transaksi_id` bigint unsigned NOT NULL,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi_omset
-- ----------------------------
BEGIN;
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (1, 1, 1, 400000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (2, 1, 2, 300000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (3, 2, 1, 40000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (31, 14, 1, 40000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (32, 15, 1, 40000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (33, 18, 1, 400000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (34, 18, 2, 400000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (35, 18, 7, 100000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (36, 19, 1, 15000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (37, 19, 2, 20000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (38, 20, 1, 50000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (39, 20, 2, 50000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (40, 20, 3, 150000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (41, 20, 4, 200000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (42, 20, 5, 40000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (43, 20, 6, 400000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (44, 20, 7, 100000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (45, 20, 8, 120000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (46, 20, 9, 110000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (47, 20, 10, 109000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (48, 20, 11, 90000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (49, 20, 12, 120000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (50, 21, 2, 100000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (51, 21, 3, 70000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (52, 21, 4, 90000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (53, 21, 5, 120000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (54, 21, 6, 100000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (55, 21, 7, 80000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (56, 21, 8, 60000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (57, 21, 9, 130000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (58, 21, 10, 110000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (59, 21, 11, 120000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (60, 21, 12, 90000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (61, 22, 1, 50000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (62, 22, 2, 50000000.00);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (17, '2026_06_26_154237_add_alamat_tagihan_to_cms_data_client', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (18, '2026_06_26_154555_rename_alamat_to_alamat_npwp_in_cms_data_client', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (19, '2026_06_26_163230_add_npwp_cabang_to_cms_data_client', 4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (20, '2026_06_26_173204_create_cms_npwp_cabang_table', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (21, '2026_06_26_173302_add_npwp_cabang_id_to_cms_data_client', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (22, '2026_06_26_183451_add_npwp_cabang_id_to_cms_transaksi', 6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (23, '2026_06_28_000001_create_cms_kategori_lampiran_table', 7);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (24, '2026_06_28_000002_create_cms_master_lampiran_spt_table', 7);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (25, '2026_06_28_000003_update_cms_lampiran_spt_table', 8);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (26, '2026_06_27_185721_add_npwp_cabang_id_to_cms_lampiran_spt', 9);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (33, '2026_07_12_000001_create_cms_lampiran_spt_detail_table', 10);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (34, '2026_07_13_000001_add_two_factor_columns_to_users_table', 11);
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `two_factor_code`, `two_factor_expires_at`, `created_at`, `updated_at`) VALUES (1, 'Admin', 'erwin.admedika@gmail.com', NULL, '$2y$10$2Y01tuoYjc3HJ5escHzVgO8m0jNnnnKrlz5CFwZg/1x7AX3/GlpNy', NULL, NULL, NULL, '2026-06-26 07:49:18', '2026-07-12 17:38:48');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
