/*
 Navicat Premium Data Transfer

 Source Server         : localdocker
 Source Server Type    : MySQL
 Source Server Version : 80046 (8.0.46)
 Source Host           : localhost:3301
 Source Schema         : ajb

 Target Server Type    : MySQL
 Target Server Version : 80046 (8.0.46)
 File Encoding         : 65001

 Date: 21/06/2026 15:03:00
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_badan
-- ----------------------------
BEGIN;
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (1, 'Badan', '2026-06-14 01:10:06', '2026-06-15 23:43:16');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (7, 'Perorangan', '2026-06-14 01:12:33', '2026-06-14 01:12:33');
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
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (1, 'Super Admin Kantor', 'super_admin', 'Pimpinan KKP - dapat melihat semua client & transaksi staff', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\", \"client.view-all\", \"client.manage-staff\"]', '2026-06-21 07:02:07', '2026-06-21 07:02:07');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (2, 'Staff/Operator', 'staff', 'Staff admin - input/edit transaksi, tidak bisa hapus client', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\", \"client.view-all\"]', '2026-06-21 07:02:07', '2026-06-21 07:02:07');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (3, 'Viewer', 'viewer', 'Pemilik usaha - hanya lihat dashboard sendiri, tidak bisa export', '[\"dashboard.view\"]', '2026-06-21 07:02:07', '2026-06-21 07:02:07');
INSERT INTO `cms_client_roles` (`id`, `name`, `slug`, `description`, `permissions`, `created_at`, `updated_at`) VALUES (4, 'Client', 'client', 'Wajib Pajak - akses dashboard standar dengan export', '[\"dashboard.view\", \"dashboard.export\", \"dashboard.change-password\"]', '2026-06-21 07:02:07', '2026-06-21 07:02:07');
COMMIT;

-- ----------------------------
-- Table structure for cms_data_client
-- ----------------------------
DROP TABLE IF EXISTS `cms_data_client`;
CREATE TABLE `cms_data_client` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_client` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe_badan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_role_id` bigint unsigned DEFAULT NULL,
  `npwp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kpp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AR` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ptkp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `no_telephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_data_client_email_unique` (`email`),
  KEY `cms_data_client_client_role_id_foreign` (`client_role_id`),
  CONSTRAINT `cms_data_client_client_role_id_foreign` FOREIGN KEY (`client_role_id`) REFERENCES `cms_client_roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_data_client
-- ----------------------------
BEGIN;
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (1, 'Adhi Surya Winata', '7', 4, '3173042710930005', 'Tambora', 'Pratama Yudha', 'K/1', 'JL. JEMBATAN BESI 4, 15A, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '083899034184', 'adhisuryawinata@gmail.com', '$2y$10$J99PhGt3rseV56ZQ8RxxoekSFBUCSx8ojE6etme8bdqOlg8/l2BbC', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (2, 'Andrew Yuniarto', '7', 4, '3173042404870016', 'Tambora', 'Arum Pawestri', 'K/3', 'JL.JAMBLANG INDAH I NO.9 RT.013 RW.002 DURI SELATAN, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '62216302385', 'andrewyuniarto@yahoo.com', '$2y$10$vbzBYTLyFFa2n/NE4FdsjufHRwkBFnvWVv2k2KSxFvnxhP.mRKdDO', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (3, 'Bambang Handojo', '7', 4, '3173040606460004', 'Tambora', 'Laila Nur Wahidah', 'TK/1', 'JL GG. BETET NO.63, 63, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '081517874562', 'bambanghandojo799@gmail.com', '$2y$10$pvbPqxQ4.P/04m8ovlqez.jgHEzwfqm2VFG4Nxp.pqtf41hL7WtQ.', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (4, 'Erna', '7', 4, '3173045210750005', 'Tambora', 'Ridwan', 'TK/0', 'JL TSS GG BARU, 20G, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '082258555347', 'ernaccss@gmail.com', '$2y$10$UUM5WHdDrtzX9MKsTm8nzOgYLnowA/L32Sr7k6aUZ6t0YdJHVu7XC', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (5, 'Fransiscus Lie', '7', 4, '3173041309760003', 'Tambora - Pusat', 'Dhani Kristanti', 'K/2', 'JL KRENDANG BARAT, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '081318187166', 'fransiscuslie428@gmail.com', '$2y$10$l1TywOGXP4sZhJzdyglMtuXlC34RZ09c6EsULe/WSqPI6VueLGCYm', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (6, '-', '7', 4, '175846054072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'GEDUNG PGMTA LT.1 BLOK C/18 JL KEBON KACANG I, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '0216315876', 'FRANSISCUSLIE2@YAHOO.COM', '$2y$10$jcpMCLsuzmw6CbPg1SDBP.vSHh0E/n4jHaUKcHyWz9SiExIWRdhvK', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (7, 'Gunawan Widjaja', '7', 4, '3173040411710004', 'Tambora', 'Ria Puji Anesti', 'TK/0', 'JL GG SAMARASA I, 7, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '628129186728', 'gunawanwidjajaa@gmail.com', '$2y$10$Jv2DpTzIJH2BTIkK2bWtr.tGTR7Y9rXqMkwkQ8yRj7Hjw3cgDzB9u', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (8, 'Harianto', '7', 4, '3173040409320001', 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'JL KHM MANSYUR, 209, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '6281311648970', 'hariantopit@gmail.com', '$2y$10$dpURbGTh37s76.d3OKMJRuaHszBplo2B08kd3xnvnkjUNpfbh0cr6', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (9, 'Hengky Yuniarto', '7', 4, '3173041606620005', 'Tambora', 'Arum Pawestri', 'K/0', 'JL JAMBLANG INDAH I, 9, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08158305511', 'henkyyuniarto@gmail.com', '$2y$10$cbNkNWYBDarlQd6snInPzO2wHK0E/O1iPEt4Uq8g8MwrEhmMLLAPS', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (10, 'Heu Panjuwono', '7', 4, '3173040705650013', 'Tambora', 'Dhani Kristanti', 'TK/0', 'JL. KRENDANG TENGAH I, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '6215445982', 'heupanjuwono@gmail.com', '$2y$10$b.VEDexni50Pee.ihDV8EuQ5lMxaXlFWqsQfl0secFgFqhcUQrjrW', '2026-06-16 04:04:25', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (11, 'Kiandi Kusuma Liong', '7', 4, '3173040103550003', 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'JL PERNIAGAAN, 129, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '08121116868', 'liong.siong033@gmail.com', '$2y$10$pNSAZBpx9ZQSWzaXBAxbge5CBZD2JgcXANTbSkQpXhswpzU/5BJTa', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (12, 'Kok Lukman Wijaya', '7', 4, '3173040311620007', 'Tambora', 'Ria Puji Anesti', 'K/2', 'GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '083719663796', 'koklukman@gmail.com', '$2y$10$ifAgpONoDSTGT1hm2pEdwOXSr3pKoe5No469iQVxTAWLoS9hnGMmO', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (13, 'Liauw Ka Tjaij', '7', 4, '3173040303520001', 'Tambora', 'Arie Kurniawan', 'K/0', 'JL. PEJAGALAN I NO. 98 D RT. 014 RW. 005, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '0216322909', 'kcliauw@gmail.com', '$2y$10$xRN5tQRw8wJ7MHQfTaj/fejsDtrkoJCgK1wi8VDdlnG1XNZ195UVC', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (14, 'Liu Loy Loy', '7', 4, '3173042609770009', 'Tambora', 'Adetya Candra Yuwana Putra', 'K/3', 'JL KHM MANSYUR, 172, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '0813380655933', 'liuloyloy@yahoo.com', '$2y$10$6d/xrFaB.GPxOp74SiOuIOsODOqDYrGrkcNiGvUIO9iWKXJ2ie612', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (15, 'Phang Su Phin', '7', 4, '3173042603710002', 'Tambora', 'Arum Pawestri', 'K/2', 'JL DURI SELATAN V, 65 B, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08129946588', 'phangsun19@yahoo.com', '$2y$10$vJdzq1ZE2PsZA5w.AcfYSO/46E.hSQDF5v4JOf8Jz.5.LCavuWwfe', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (16, 'Ringo Yapari', '7', 4, '3173041604760004', 'Tambora', 'Wursito Atik', 'K/2', 'JL.KHM.MANSYUR NO.218, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '081288224490', 'ringoyapari17@gmail.com', '$2y$10$2kB29r3sLYbOvvO854RK0eD/2fth5badrtFWHbV4lWrHHkT2YLmYi', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (17, 'Robin Sugiarto', '7', 4, '3173042106550003', 'Tambora', 'Arum Pawestri', 'K/1', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08128000812', 'robinsugiarto997@gmail.com', '$2y$10$pNY14Lx0H8J52Sn0qkM/j.ht259Rzc1ioGCxku02jfbPc/Mxxo25G', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (18, 'Rosmawati', '7', 4, '3173045506680004', 'Tambora', 'Ridwan', 'TK/1', 'JL KP DURI TSS, 51, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '62816811386', 'pajakrosmawati17@gmail.com', '$2y$10$dWpuRTcMj0D23/TV5Bb/POLPUjOvdb0.xWMDmuYGhp6BMpVsb.WBi', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (19, 'Santoso Latif', '7', 4, '3173040112520003', 'Tambora', 'Adetya Candra Yuwana Putra', 'K/0', 'JL SONGSI, 6, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '62216902735', 'santosolatif3@gmail.com', '$2y$10$pL6ewd2tKBMnRXOXlEgMUulYchLK1GHKvtDNaGU1Af9/h2RtCBrA.', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (20, 'Sastro Tjondro', '7', 4, '3173042511640006', 'Tambora', 'Ria Puji Anesti', 'K/2', 'GG SAMARASA III NO.18 RT.005 RW.005 KEL ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '6281105892', 'sastrotjondro4@gmail.com', '$2y$10$LF0/C7Jl3PkUkSaJx2f8KuyCYCep1uMDei.VG.4oWiKhL3DXHvqxu', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (21, 'Sumitro Lie', '7', 4, '3173040508790006', 'Tambora - Pusat', 'Dhani Kristanti', 'K/3', 'JL.KRENDANG BARAT NO.42 RT.012 RW.005 KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '622130365910', 'sumitro.lie@yahoo.com', '$2y$10$JNY3Wt05LQKPtTtl2JgWA.7.Nzj516HdHPTQNBYtldtkZm5Ujd5.m', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (22, '-', '7', 4, '189399025072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'PUSAT GROSIR METRO TANAH ABANG LT. 2 BLOK B NO. 1, KEBON KACANG, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '62213036591', 'sumitrolie69@yahoo.com', '$2y$10$KFl2XuNKdy/3i5aIPvoeAezI/zz.jN6FO30ryNrAqH1UbBLUNnpBy', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (23, 'Suwandi Arifin', '7', 4, '3173042712690011', 'Tambora', 'Ria Puji Anesti', 'K/1', 'JL PTB ANGKE GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '6285719663796', 'suwandiarifin00@gmail.com', '$2y$10$XK5VXZlwVUuWe3HVwevFXeHabrV7KyAStZ5sU53kjePBi9Ota0k/2', '2026-06-16 04:04:26', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (24, 'Tjan Gosto', '7', 4, '3173040708690006', 'Tambora', 'Ria Puji Anesti', 'K/1', 'GG SAMARASA I, 23, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '08176902776', 'gostotjan@gmail.com', '$2y$10$sUA/k.JTgzPIFdUDoShZ3OSLHUG9qG7MLb5.kqMiaHd648EEATEc6', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (25, 'Tjhin Su Mie', '7', 4, '3173044405760009', 'Tambora', 'Putra Dwi Pamungkas', 'TK/3', 'TERATE I NO 11, No 11, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '081617175507', 'tjhinsumie9@gmail.com', '$2y$10$nfhn3BJbGO1n2.pGIbcJVu674jSmRbY8EE6DMn4ODLoxZs0SmmqNm', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (26, 'Tjioe Seng Huat', '7', 4, '3173040310550006', 'Tambora', 'Wursito Atik', 'K/1', 'JL TANAH SEREAL X, 8, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '6281315151596', 'tjiosenghuat@gmail.com', '$2y$10$drAHt8gX06ibgMpJrYmTbO0gJhtZkj1mBKvlvzknT57qp0l71ss2K', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (27, 'Tjiu Jun Shin', '7', 4, '3173041511690001', 'Tambora - Pusat', 'Ridwan', 'K/3', 'JL.TSS.NO.15 L, DURI UTARA, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '62811872783', 'tjiuju@gmail.com', '$2y$10$e3R.KpaanYw1DZ.V5dBev.BehWmVw/bypaRQ.GaSoDsuZEuxmFWVq', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (28, '-', '7', 4, '076531904072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'PUSAT GROSIR METRO TANAH ABANG, PGMTA LANTAI III LOS B NO 19 KELURAHAN KEBON KACANG, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '02162216303403', 'tjiuju2@yahoo.com', '$2y$10$2NMlv9DZ7qX2.BeviC8piuAZ2g/qgaJVLxuvr72FErIZRcAXLY73O', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (29, 'Tjiu Supardi', '7', 4, '3173040112510001', 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'JL LAKSA I, 85A, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '628128556129', 'tjiusupardi@gmail.com', '$2y$10$foJcrONjY2e7AmE0pEMGJu3Yb.I6X7QQTZPJo/eUSRzA0Orzie8HO', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (30, 'Vicky Famin Efendy', '7', 4, '3173043010660006', 'Tambora', 'Anung Prasetyo Dwijayanto', 'K/0', 'DURI BARU NO.3, JAKARTA BARAT, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '-', 'vickyfamin@gmail.com', '$2y$10$LmeMkjvMOqSDuUnAMoMo6uPzDJ7KfAbhFaBvUZ3J1rzBBY1Ou/gbG', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (31, 'Yunita Sugiarto', '7', 4, '3173044802740006', 'Tambora', '', '', 'JL.JAMBLANG RAYA I / 61, DURI SELATAN RT 000 RW 000, DURI SELATAN, TAMBORA,KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08128800167', 'yunitasugiarto08@gmail.com', '$2y$10$eS3Z9P2paU6eIHtV53TKy.X36fhczTfDdgzRWUInspgrVMfm6vhpy', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (32, 'Budi Makmur', '7', 4, '3173042610790004', 'Tambora', '', '', '', '', NULL, '$2y$10$EC1wDxjZ1U4AWwXzJVye2u2Nenz6y7QINIWkCR8DcoUWg2Q8GsaBG', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (33, 'Tjioe Enrico', '7', 4, '3173040303940002', 'Tambora', '', '', '', '', NULL, '$2y$10$B/Ct20tCFx2mfjjnJzwhaOsN0X0T9I1ddfJkh.w6kpHrwv/NKGp0i', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (34, 'Erres Subiarto', '7', 4, '3171022302390002', 'Sawah Besar Satu', 'Geri Gema Putra Tarigan', 'TK/0', 'JL GUNUNG SAHARI 11, GUNUNG SAHARI UTARA, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10720', '087885382958', 'eressubiarto@gmail.com', '$2y$10$smPWa9tEwkaJVeHDDrLNZOTFQAPPRmIttQQh3.CxH.WrdptTM/cm.', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (35, 'Giovan Valentine', '7', 4, '3171022007910002', 'Sawah Besar Satu', '', 'K/0', 'JL. KARTINI RAYA NO.55 fRT 001 RW 003, KARTINI, SAWAH BESAR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA,10750', '081213030368', 'giovan.valentineacc@gmail.com', '$2y$10$VPiQauYiFIEB8AQeD/A8pOwyq1MAJLBZUNYZ/U2MKe7hqs79QDaaC', '2026-06-16 04:04:27', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (36, 'Lie Ka Djin', '7', 4, '3171024906560003', 'Sawah Besar Satu', '', '', 'P. JAYAKARTA NO.15 RT 009 RW 007, MANGGA DUA SELATAN, SAWAH BESAR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '081295439081', 'TENGKIMSUI@YAHOO.COM', '$2y$10$E0Dkm8NDjtoJjtsPMvtMLuxzLCU3ImddKArRsU80i58MW5CxiC9DK', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (37, 'Lie Juliana Margaret', '7', 4, '3171024303800002', 'Sawah Besar Satu', '', '', 'PANGERAN JAYAKARTA D-15 NO.46 RT 009 RW 007, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA', '0881010622198', 'LIEJULIANAMARGARET@GMAIL.COM', '$2y$10$YxuA2MOgPdo1taXnOe7EDORkB3mAUp3ZvPIxy8M20w8vuYMMrfB.m', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (38, 'Diana Wangsa Heryanto', '7', 4, '3171024408910004', 'Sawah Besar Dua', 'Chalimatus Sa\'diyah', 'TK/0', 'JL KELINCI IV NO 2 A RT 008 RW 004, PASAR BARU, 2 A, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '6281808867585', 'dianawangsa2@gmail.com', '$2y$10$AWfKxk2y5n78Y6Ag3E4hUuUcAiTNhIS7fTs9hN40js3xTmf40H8aK', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (39, 'Djohan Hirawady', '7', 4, '3173010907610005', 'Sawah Besar Dua', 'Dellachita Rahardhianne Winarto', 'TK/0', 'JL GG MANDOR, V, 32, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '081574258787', 'djohanhirawady@gmail.com', '$2y$10$hwQAnWjvJ4bpba97CsJZgu/di6qLiixNGYvUfmlsw0vmktt12S4ku', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (40, 'Alex Heryanto', '7', 4, '3173031709570004', 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI IX, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '6221624329', 'alexheryanto51@yahoo.co.id', '$2y$10$JCsIsRb.8G4PCzMVPjPdMudWfCt0vtbee8m1kC3KRROBxicpW.H8.', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (41, 'Cynthia Kurnia', '7', 4, '3173036802910004', 'Tamansari', 'Nova Novelita', 'TK/0', 'JL TAMAN SARI IX/10, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '082225843858', 'cynthiakurniaa@gmail.com', '$2y$10$wNBV8CTlfjEJt8jTXqJ2x.175NHLxOFz3.zLo/AOMsJYDZ31e9UDa', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (42, 'Ely Widjaya', '7', 4, '3173035606700001', 'Tamansari', 'Nova Novelita', 'TK/0', 'JL TAMAN SARI IX/10, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '0881010622198', 'MULYADISAPUTRA817@YAHOO.CO.ID', '$2y$10$W.zqahF/.z8bGAH0h15MI.8zP3QXp0GGNvHPelEKcBRdOS6MH/dqi', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (43, 'Ferry Wangsa Saputra', '7', 4, '3173030704950006', 'Tamansari', 'Nova Novelita', 'K/0', 'JL. TAMANSARI IX/10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '08989703363', 'ferrywangsa@gmail.com', '$2y$10$tUG3ht5k0zzBBOALHE1UiesE0aeE3Du0BOUXROeKlKOkVUJwVsVYy', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (44, 'Hendry Wijaya', '7', 4, '3173030308670005', 'Tamansari', 'Nova Novelita', 'K/3', 'JL TAMANSARI IV, 22, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '628129133176', 'hendrywijayaa0@gmail.com', '$2y$10$TJjmI7g7QKb3tsrRQuJ.6O3at6GdkpMEak6j4XM99Ekt.ZQs7xjAO', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (45, 'Johan Ng', '7', 4, '3173031204490001', 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI VI, 52-B, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '081808991212', 'johanng454@yahoo.com', '$2y$10$6oJoFsNGPXsBxBHHGMFCFON/18XIIvT9gm5PaDKi5YnfIOugyDkKa', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (46, 'Willy Darmawan', '7', 4, '3173032301690002', 'Tamansari', 'Raden Muhammad Riandy Irmansyah', 'K/3', 'JL TAMANSARI II, 60 B, MAPHAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11160', '0818169848', 'willydarmawan678@yahoo.co.id', '$2y$10$W.sh4ozNSrl6T2wd/dVhFedY7D4tS.fkLIeqEbiZ/IAl42LjR4ldi', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (47, 'Wong Sauw Lie', '7', 4, '3173036710480005', 'TamanSari', 'Dite Fatmawati', 'TK/0', 'JL KEMENANGAN V GG 2, 18 A, GLODOK, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11120', '0216393841', 'wongsauw10981@gmail.com', '$2y$10$/iOOXAHnYTuFn3VEwlpRE.cAYkKd.iyL0vFWTrFZiYvfGWtMyWDxi', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (48, 'Yoanita Kristina', '7', 4, '3173054906810009', 'Kebon Jeruk Satu', 'Rahmat Husein Harahap', 'TK/0', 'KOMPLEK BPK III, C, 9, KEBON JERUK, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11530', '081517874562', 'yoanita.kristina@yahoo.co.id', '$2y$10$iCanIH8mtxG7MVWHHgmFneQdjpNg0no1z8O.IWVG/25aX6AzdWZLS', '2026-06-16 04:04:28', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (49, 'Andy Prayitno Limantoro', '7', 4, '3173051309840007', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'GREEN GARDEN BLOK A-5/12 RT. 003 RW. 003, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '628567843535', 'andyprayitno57@yahoo.co.id', '$2y$10$PProZZdzpK2xIj1bQbo5MewCTr6QIC9px4TnTdqE1DKvqp5KOeVR2', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (50, 'Indra Prayitno Limantoro', '7', 4, '3173052005890008', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'K/0', 'GREEN GARDEN, A-5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '08128015571', 'indraplim@gmail.com', '$2y$10$xEvdx9sU5ApJnIKFjFhSAuKDPWUfk.2cvGUH7jf0ovKKIK6xN5uiq', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (51, 'Winston Tanazon', '7', 4, '3173042904910003', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'KOMPLEK GREEN GARDEN, M 3, 57, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '08170066290', 'TANAZONW@GMAIL.COM', '$2y$10$Dy9bXYMfy.Eeh19L8dolHOy9P43U1E5j2oKx2kG1o2n1rGSQYJyl.', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (52, 'Willy Limantoro', '7', 4, '3173051904830008', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/1', 'KOMPLEK GREEN GARDEN, A 5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '62215650104', 'limantorowilly@gmail.com', '$2y$10$qwfy64Lpit19Xi98GEhJfOhpYhw0neadeCJ28c2iFZMKiIOq.JZ5e', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (53, 'Albert Limanto', '7', 4, '3173012209850005', 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'JL KAPUK RAYA, 8, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '08568568445', 'albertlimant@gmail.com', '$2y$10$/Hd9S3zCKF/U486ZU//rq.pFmabSot.s2OuzFGPoxKTU2zItBnBVO', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (54, 'Alvindo Limanto', '7', 4, '3173012210930003', 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '081289020181', 'alvindolimantoo@gmail.com', '$2y$10$MMYRf5N2ckIDVHu4h2Jn0OnIyDQm/vHte6nbFWqEItTT7EY9spMDm', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (55, 'Chandra Limanto', '7', 4, '3173011207570001', 'Cengkareng', 'Genis Anggraeni', 'K/2', 'JL KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '081889020181', 'chandralimanchan@gmail.com', '$2y$10$nS.Lv6oYAIpJ23OxM1XKLeObr9fb2kJJmvTnRlfxA0MFTahfXHQVu', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (56, 'Heng Chun Khiun', '7', 4, '3173015604740020', 'Cengkareng', 'Puspa Ayu Wulandari', 'K/0', 'JL KAPUK KEBON JAHE, 133, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '08178811560', 'hengchun377@yahoo.co.id', '$2y$10$euJAgwSZFZ4Wl9gXHXk5p.KP838Rbw6KwBXgHHFcyKZZQJxYmfmiy', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (57, 'Lisa', '7', 4, '3173017101920008', 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'KP UTAN NO. 3, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '08988959911', 'lisacss1@yahoo.co.id', '$2y$10$PnwDuAvzy9UxQmems3ovHugasleEsZ5Wriqb08QgErMICtZvVxhAe', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (58, 'Pendi Susanto', '7', 4, '3173012005810019', 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'JL KAMPUNG UTAN, 36, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '668749120', 'pendisusanto907@yahoo.com', '$2y$10$VQ6./eFVl4PpCwHjgnItEu7gWKk3WBYTrYvsWkvGc4UCAADGl4h1q', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (59, 'Silvia Listiani Limanto', '7', 4, '3173015410840005', 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '081289020181', 'silvialistianilimanto@gmail.com', '$2y$10$QaiSjhAm2MscA59PtL0qpuN0CODUqt00LSNTCiu5cInZgKNxyEtH2', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (60, 'Sukarsanto', '7', 4, '3173012206760020', 'Cengkareng', 'Ika Kusumawati', 'K/3', 'JL RAYA KAPUK GG EMPANG, 3, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '087883803880', 'sukarsanto37@gmail.com', '$2y$10$Avr5zeqPzfsml153zdDNh.kLzEx/CyfQaAKDtrrN6whyr2n2gybrC', '2026-06-16 04:04:29', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (61, 'Lioe Leosando', '7', 4, '3173012504730005', 'Cengkareng', 'Genis Anggraeni', 'K/2', 'JL WARU III, 14, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '08129966364', 'lioeleosandoo@gmail.com', '$2y$10$dpw1HlkN10kiCwPN8E9ZjOAe9xTMnjZIrL5oQfHD3hNVQiig33CyO', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (62, 'Brian', '7', 4, '3173040903011001', 'Kalideres', '', 'TK/0', 'JL TAMAN KINTAMANI TIMUR BLOK LL NO 16 RT. 001 RW. 017, KALIDERES, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA', '087788669910', 'brianzzz0909@gmail.com', '$2y$10$bYIhxC8YEN3jj36xcJyxK.YJAT9yHywBlR8xczLQrnKSz2KDbwHW6', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (63, 'Harya', '7', 4, '3173062010720016', 'Kalideres', 'Crisanto Adi Maria Listyanto De Carvalho', 'TK/0', 'TAMAN KENCANA BLOK D KAV.9 NO.5 NO 5 RT.001 RW.14, JAKARTA BARAT, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '082112660987', 'harya1919@gmail.com', '$2y$10$yo9hANDN/XaRRXGKSOsaYudFBYUBHq3iWpXuji8DzcrAq.kkh07Yy', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (64, 'Ronny Halim', '7', 4, '3173062606650004', 'Kalideres', 'Tono Supriyono', 'K/1', 'PERUMAHAN CITRA 2, A 5, 12 A, PEGADUNGAN, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11830', '5445053', 'ronnyhal65@gmail.com', '$2y$10$z/P0W07W2RIYrQzkTMmP0ujVv3ITNRX3TxjwMbg1ssXuamsthmsfu', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (65, 'Suharta Riyanto', '7', 4, '3173010904940012', 'Kalideres', 'Erwanto Eko Prasteyo', 'TK/0', 'JL PRIMA UJUNG, A, 31A, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '08998947847', 'suhartariyanto@yahoo.com', '$2y$10$zg/8LEjGDTpUs6T0z/yaYuz.1QooZ8OXJ0.eE7yKgx2llLWCA.O56', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (66, 'Bambang Suhono Halim', '7', 4, '3172050802650002', 'Pademangan', 'Ferri', 'K/0', 'JL PADEMANGAN II GG 29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '6281288518185', 'bambangsuhonohalim72@gmail.com', '$2y$10$uk.tXfXh7McihGPiHMELH.efBIyShF2c56OtYNkyGqzmz4h1.2VAe', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (67, 'Daniel Halim', '7', 4, '3172051310990005', 'Pademangan', 'Ferri', 'TK/0', 'JL. PADEMANGAN II  GG 29, 7, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '087879507490', 'halimmdaniel@gmail.com', '$2y$10$7UI9odGu9memN5jxdsXmzeTOj0zl6zWVbtv3dLRdJJQXR1C3wc.ly', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (68, 'Niki Halim', '7', 4, '3172056004940001', 'Pademangan', 'Ferri', 'TK/0', 'JL.PADEMANGAN II GG.29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '0818756910', 'nikihalimm@yahoo.com', '$2y$10$ZamaFXl2U/ib9YCnsphqx.xe4fyHc8vHxZgf0WzUpYb42cJTyZKW2', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (69, 'Sumanto', '7', 4, '3173042507500006', 'Pademangan', 'Hamonangan', 'K/0', 'JL LODAN, 143, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '081283789850', 'sumantotjioe@yahoo.com', '$2y$10$92zZUAvBOYo6OWgw3LNFQuTZwkneaIAJNBNryF/hxcvQ.3coOU0BS', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (70, 'Akin Sriwongo', '7', 4, '3172010712590007', 'Penjaringan', 'Hari Isnawan', 'TK/0', 'JL JEMBATAN GAMBANG I, 26, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281219128119', 'akinsriwongo17@gmail.com', '$2y$10$YxFYtmTXM2nXkxgXY0.bN.Ba.uabSf5yAhxCskUznzd7HzQJI832q', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (71, 'Alvin Wijaya Tie', '7', 4, '3172011708670002', 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'JL JELAMBAR, 19, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '085216695811', 'alvintie@yahoo.com', '$2y$10$ZzplqwSs2etUWYIY.6pseOcUJuADrDC4mPi9qj32bxjxk84Ipkfzm', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (72, 'Eddy Chandra', '7', 4, '3172012303760019', 'Penjaringan', 'Gani Syabani', 'K/3', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '082124656668', 'eddychan1919@gmail.com', '$2y$10$yrEnvhtPzFNzw6OAdaGN2O80Fmo1EjNDMRU4nkehrHanXQfFw0d7O', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (73, 'Edi Saputra Widjaja', '7', 4, '3172011004920007', 'Penjaringan', 'Yusuf Wahyu Aristiwan', 'TK/0', 'JALAN ALADIN BARU, 25, RT 001/RW 006, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '082211238686', 'esaputrawidjaja@gmail.com', '$2y$10$TbhNQ.Q/K9arb8iE8uxYSu5V00CUxqU0SPaVCMfzkyja2Ky3jaEKG', '2026-06-16 04:04:30', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (74, 'Hendra Wijaya Tie', '7', 4, '3172010703640002', 'Penjaringan', 'Sandra Nurma Putra', 'K/0', 'JL JELAMBAR ALADIN, 16, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281287022829', 'hendrawijayatie@gmail.com', '$2y$10$B01Qth4IPFa3HKLUhhHSRON1jqmx7irjuk/kDhMzeP7oCRiZrfDo6', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (75, 'Herman Wijaya', '7', 4, '3172010109610005', 'Penjaringan', 'Sandra Nurma Putra', 'K/3', 'JL JELAMBAR ALADIN, 1K, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281291674728', 'hermanwijayapit@gmail.com', '$2y$10$Shw7OgmlhqLQAmTqS8E0e.U05J9TylowdW4CqE6boKBgT2V7X25p.', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (76, 'Lim Ngok Hong', '7', 4, '3172012705750008', 'Penjaringan', 'Hari Isnawan', 'K/3', 'JL. KERTAJAYA IV, 20, PENJARINGAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14440', '0852181765255', 'limngok@yahoo.com', '$2y$10$/4JnEZxoNHtz4Kn/BvPHcOMiY9a/bzjOGzy0aNb.eCnAWPKrCOsoq', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (77, 'Sadikin Kuswanto', '7', 4, '3172012102640004', 'Penjaringan', 'Devy Elvandary', 'K/1', 'TELUK GONG JL LUNDU 48, PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '-', 'dikisadikin19@gmail.com', '$2y$10$zcOZjYubDWg0tcaCor2Wc.RT48cbZYUnYoX26BP1mUPbSCVb5Ji.y', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (78, 'Tjhang Vivi Surianty', '7', 4, '3173045110810007', 'Penjaringan', 'Gani Syabani', 'TK/0', 'JL E TELUK GONG, 174B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '622156949666', 'tjhangvivisurianty@gmail.com', '$2y$10$BwLmzLrVjQJ8Z6/Om05SPe45BP8uVsNzaivlbTlvt3NJBl/HnXW..', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (79, 'William Wijaya Tie', '7', 4, '3172010708600007', 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'JL JELAMBAR, 1, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6287884564101', 'williamwijayatie@gmail.com', '$2y$10$gR73fpMRM0WHo9t8.zNvveXf0DlS3kDgIqyZQwSyO.02eewqXpoga', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (80, 'Devlin Sukarto', '7', 4, '3172011501770010', 'Pluit', 'Restu Rea Erlangga', 'TK/1', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '087789101118', 'devlinsukarto1997@gmail.com', '$2y$10$gfI7I3v7iL7Xt5lFbf9TpOfaG0kl0K5QHftnvBQIpdquwykL5me7u', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (81, 'Enrico Rusli', '7', 4, '3172012104920006', 'Pluit', 'Ganendra Edo Satwika', 'TK/0', 'CAMAR INDAH, 7, 9, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '081296887420', 'enricoruslilie@gmail.com', '$2y$10$K4cWHaC/suQuo//GH6on..5Uy.tijbtlN6mR4GSMpYthSXHk/2GSG', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (82, 'Liong Koei Hwa', '7', 4, '3172012512460003', 'Pluit', 'Restu Rea Erlangga', 'K/0', 'JL PLUIT SAKTI III, 41, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '081513136268', 'koeihwaliong@gmail.com', '$2y$10$i/p/keDNcDqcCpLXyibmkucXA3/fFMs25AdLNRQnLDCUegmQj.RiO', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (83, 'Sammy Soetiono', '7', 4, '3172012108411001', 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'JL PLUIT BARAT III, 3, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '0816885406', 'sammysoetiono@gmail.com', '$2y$10$p31lWgQh/cXxo4bp0poDZeCqPi6frvH7/2RVZbHzThCW3WdXTUIjy', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (84, 'Selvia Liliana S', '7', 4, '3172015504820006', 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '087789101118', 'selvialilianaas@gmail.com', '$2y$10$ZdELzGQQqC0IzY4FPpR1S.jlWuvWxAR5jiU7aAA4C.eBhprd5Rzyy', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (85, 'Setiawan Widjaja', '7', 4, '3172010712760012', 'Pluit', 'Prophana Labi Dautse Gayo Katama', 'K/1', 'JL MUARA KARANG BLOK I.7.U  NO.11-A, I, 11, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '08119849992', 'setiawanwjd19@yahoo.com', '$2y$10$5G7VASLoWt3R9ddQmZmUl.mnWILB5VYsoBGWnoq.J3yAW5JFvdbre', '2026-06-16 04:04:31', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (86, 'Su Kai', '7', 4, '3172011801801002', 'Pluit', 'Wisnu Febryanzah Prasetyo', 'TK/0', 'RUSUN BLOK G LANTAI II NO.13 RT. 006 RW. 009, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '081311648970', 'kaisu2311@gmail.com', '$2y$10$thoEHQP4f6f2fyrdNZd85uXnMCtWeCLtuxH/GQcba2YfB0TrKSQCa', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (87, 'A Han', '7', 4, '3173020110780003', 'Grogol Petamburan', 'Esther Theresia Orienta Simanjutak', 'K/2', 'JL MANGGIS I, -, 10, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '6281315815888', 'aahanhann@gmail.com', '$2y$10$d4QEM9NnMiGoV38qvvy2G.7nh6a.ppr9ah.c50cBrIiAnsXNZTWDK', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (88, 'Anggip Lesmana', '7', 4, '3173021601550001', 'Grogol Petamburan', 'Arum Kusuma Sari', 'K/0', 'TAMAN DUTA AMS JALAN PANGERAN TUBAGUS ANGKE, D 2, 26, WIJAYA KUSUMA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '081898128', 'lesmanaanggip17@yahoo.com', '$2y$10$GmN6jhgN3KB0gaHR2EqvKuS4PWqiBwkcbqFR5tx2gHuVIr6vLBGLq', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (89, 'Fen Limantoro', '7', 4, '3173022012340001', 'Grogol Petamburan', 'Rumpaka Jati', 'TK/0', 'JL TANJUNG DUREN UTARA V / 6 RT 06 RW 03, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '08158825812', 'fenlimantoro47@gmail.com', '$2y$10$h.mHC08yOyI6F/s1CCn6WeA550exfhYxsa2TlYVr/6ugy9tVvELXy', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (90, 'Iwan', '7', 4, '3172012603770004', 'Penjaringan', 'Gani Syabani', 'K/2', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281310551977', 'iwanaja1994@yahoo.com', '$2y$10$QH5XgiVlkrR92qhRf3pWWOEhPxqtQtyc5KAXMASrAxiJikJm8xBG2', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (91, 'Tjoeng Sje Ji', '7', 4, '3173020112600006', 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/0', 'JL MANGGIS II, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '08161974011', 'tjongsje@yahoo.com', '$2y$10$NsB3fhHuz9UarOANfGyrdecjTMxgE6gOg/./YWIkXpW0e15GWk9Pe', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (92, 'Andika Kartadinata', '7', 4, '3171011501890003', 'Gambir Tiga', 'Sartika Faramelita Suherman', 'TK/0', 'JL. KH. HASYIM ASHARI NO. 54A RT. 003 RW. 001, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '08999901989', 'kartaandika35@gmail.com', '$2y$10$7QZt/nLlCk21MYPoFA3Ir.uodSl1r824EY5XElHKPpY4XFLSaXrlq', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (93, 'Gimin Arifin', '7', 4, '3171011410700005', 'Gambir Satu', 'Lisdyaningroem', 'K/2', 'GG KINGKIT IV, 18, KEBON KELAPA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10120', '081212129534', 'giminarifin@yahoo.com', '$2y$10$HbAT29Fjqp1KD61mg.FOkO8YeMjDqhKNzlFeg2viC/xJVdgw/KokK', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (94, 'Johnson', '7', 4, '3171011106910002', 'Gambir Satu', '', '', 'JL BATU CEPER V NO.3 RT 011 RW 001, KEBON KELAPA, GAMBIR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA', '083870196364', 'john1161991@gmail.com', '$2y$10$GiAbQs7be/msGepehHn5V.8I.zRb.Ys5kdOZskjXmVACBrTGI08QC', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (95, 'So Kim Tju', '7', 4, '3171014106640005', 'Gambir Satu', '', '', 'JL BATU CEPER V NO.3 RT 011 RW 001, KEBON KELAPA, GAMBIR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA', '081806154247', 'sokimtju010664@gmail.com', '$2y$10$LEp1lxp168CuNIfuJse29ex1XvzVp2.qvmOSPVwmwolGe.y5O8iT2', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (96, 'Janti', '7', 4, '3171016812480003', 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'JL. KEBON JAHE II NO.14 RT. 006 RW. 002, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '02194507303', 'janti0019@gmail.com', '$2y$10$p.FPGqWfSqjIEnf9BnrRfuzo72gzleaG3J20RvViBUqXsgu7brH1u', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (97, 'Liana Hasanudin', '7', 4, '3171015811510002', 'Gambir Tiga', 'Deni Dewi Anggraeni', 'TK/0', 'JL.CIDENG TIMUR NO.9, PETOJO UTARA, PETOJO UTARA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10130', '08159403998', 'lianahasanudi19@gmail.com', '$2y$10$co.T22cFgVcx2Jw/hgd4ounUYCKXqpXVhe/PhdgWvc57lMpTDYwx.', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (98, 'Linawati Setiadi', '7', 4, '3171014209630003', 'Gambir Dua', 'Tini', 'TK/0', 'JL PERSATUAN GURU, 18, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '081315133312', 'linawaatisetiadi@gmail.com', '$2y$10$wj4H2QMOiyd/EdLiLLa7R.cpCVkfi3miOeKYUZU7tigT4AVqwwYhy', '2026-06-16 04:04:32', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (99, 'Nico Hartono', '7', 4, '3171012301770001', 'Gambir Dua', 'Hendra Rahma Wiguna', 'K/1', 'JL. KEBON JAHE II NO.14 RT.006 RW.002, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '62215655526', 'nicohartono67@gmail.com', '$2y$10$ihYbCb1ybGdKqBy3nAgT2uGKLwXkxyME22uVCDeuysQL9tzXe7Ds.', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (100, 'Rudy Soetanto', '7', 4, '3171011309490001', 'Gambir Dua', 'Tini', 'K/0', 'JL PETOJO SELATAN IX, 2, CIDENG, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10150', '0816925412', 'rudysoetanto73@gmail.com', '$2y$10$9FhZlOjU0vI1HgGDIPK/neYDVmMo/txFZQUJrIFFVdjt7OL3OBhSe', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (101, 'Surya Kartadinata', '7', 4, '3171012002590001', 'Gambir Tiga', 'Annisa Perwitasari', 'K/0', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '628999031463', 'surya.k18@yahoo.com', '$2y$10$fg.7kr45bZEenJo3KAfwGOT/ugZZfeRveypm/OWuTyH6RBXx80ToC', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (102, 'Efendi Narzudi', '7', 4, '3172061507780004', 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'JL PELEPAH ELOK IX, GF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '0818983853', 'efendinarzudi@yahoo.com', '$2y$10$gJDJTmM.Bhwi/vUO2M0ULuY991JPICeA2qD72GY06uDkem9AvVGNK', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (103, 'Herry Limantoro', '7', 4, '3173051610810014', 'Kelapa Gading', 'Sayyidah Tahirah', 'K/1', 'PERUMAHAN BUKIT GADING MEDITERANIA, E A, 2, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '62213849217', 'herrylimantoro99@yahoo.com', '$2y$10$TyGoY2/8SBM7XZQwmTHTaOUKr6dQtxVFfmBqi1J564MGY2NyEfA.O', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (104, 'Linda Tjahyadi', '7', 4, '3172064212540001', 'Kelapa Gading', 'Dodhy Candra Saputro', 'TK/1', 'JALAN GADING NIRWANA V, PF 10, 10, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '081586607397', 'lindatjahyadi19@yahoo.com', '$2y$10$QeIq.Y9Um5xtk8GQ/H3tNOu55r1WgDe/Y87sRkI5uL5rCbKZSTWVy', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (105, 'Ruby Narzudi', '7', 4, '3172060407790003', 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'JL PELEPAH ELOK IX, QF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '0881010622198', 'rubynarzudii@gmail.com', '$2y$10$vLAcQdO4YIaxjmN7JY4ekuwjMxxP7qN1bE4vcOnf/C8Mt1tUVOHwm', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (106, 'Tjoa Hadi Lukmanto', '7', 4, '3172062908580001', 'Kelapa Gading', 'Sri Rahayu', 'K/1', 'JL KELAPA NIAS VI, PB 13, 18, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '0816714677', 'tjoaahadilukmanto@gmail.com', '$2y$10$eoFtcIoAhGNmTe3ESjl5t.7Nu1/yWvfYA2EdEoHsBpE2ZFJsQsgo.', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (107, 'Lucy Sastroamidjoyo', '7', 4, '3172025312520005', 'Tanjung Priok', 'Prima Wallesa Palo', 'TK/0', 'JL.  AGUNG  TENGAH  4-I, 1, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '6281213998813', 'lucysastro1919@gmail.com', '$2y$10$gziv3cgCXXPsFfPQ5xjfcuSDrAtOsGvb29YzDeJsmh68koGN0wEmO', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (108, 'Temmi Sandjaja', '7', 4, '3172022905710015', 'Tanjung Priok', 'Toni Murdoto', 'TK/3', 'JL AGUNG UTARA XV, A13, 7, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '08128537899', 'temmitemsand19@gmail.com', '$2y$10$0IS0t3eJXaqZIwbdFB7YNOgZ8fMcEPcCsj.Ynm/fzUIFEgrhrvnu6', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (109, 'Ali Chandra', '7', 4, '3174010602820008', 'Tebet', 'Nurkholis Rafsanjani', 'K/2', 'JL BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '6287882550888', 'alichand1919@gmail.com', '$2y$10$tVPxZjllh1XzwNPJcXRfvu.V37KOcnGsdT.ebsop8ZElO1sRUandu', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (110, 'Eddy Zonder', '7', 4, '3174010501450002', 'Tebet', 'Nurkholis Rafsanjani', 'K/0', 'JL MESJID BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '0816836500', 'eddyzonderr@yahoo.co.id', '$2y$10$H52y138iDWvlP0FV3SvpWeg4IxHvh/jxgaIagaWdZWCCDSRKaY8Ba', '2026-06-16 04:04:33', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (111, 'Hardi Winarta', '7', 4, '3174061203570002', 'Cilandak', 'Rudy Priambodo', 'K/3', 'JL.PURI MUTIARA RT.007/01, CIPETE SELATAN, CIPETE SELATAN, CILANDAK, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12410', '081388664303', 'hardiwinata184@yahoo.com', '$2y$10$OFrlrSA8pnJww73W7GAsXOpvRD7b.8wAIGxbrQhBDbgTXSg2B28OW', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (112, 'Dicky', '7', 4, '3275040708870025', 'Duren Sawit', 'Linda Ella Sari Br. S. Maha', 'K/1', 'JL DELIMA RAYA, IX, 1, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '62216697035', 'dickyki69@yahoo.com', '$2y$10$THPdWwuXJZDruyFZ/GGKk.VoFFI1AJGPVu6CStgKreodor5vnEkke', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (113, 'Lim Hidayat', '7', 4, '3175070403780019', 'Madya Jakarta Timur', 'Heru Waskita', 'K/2', 'JL.DELIMA RAYA, 5D, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '62811198521', 'limhidayat47@gmail.com', '$2y$10$VdEH8AiTbwmnexl3r6VV/eEeLX.n4u6Z9KuBqIZrepnAXQqBjbxb2', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (114, 'Andri Janto Sudjoko', '7', 4, '3173071105620006', 'Palmerah', 'Oliver Francois Tambunan', 'TK/0', 'JL. U NO. 31, SLIPI, SLIPI, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11410', '0218296579', 'andrijanto96@yahoo.com', '$2y$10$iBaDgK1bxTpVC8xv2BFnEOffMACTJtuidnrppzr8ElFylAnkcHVRi', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (115, 'Sunardi', '7', 4, '3173071006760002', 'Palmerah', 'Diah Kartika Retna Asih', 'K/3', 'JL H SALEH, 28, PALMERAH, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11480', '085692129168', 'sunardipajak533@gmail.com', '$2y$10$2aKnqH96ed5ey4MRP.Bg5.QH9DHzQS6A9ZLlcQ3bYaBTvStNlxQxu', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (116, 'Tjio Suhendra', '7', 4, '3173062208600002', 'Senen', 'Muchamad Fakhrudin', 'K/1', 'PLAZA ATRIUM LT.V BLOK C-64, SENEN, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '081285763362', 'tjio1919@yahoo.com', '$2y$10$/InXCNhRLrOevLBY4tnn4O5DO6AlwEjmq0Fc9CgDU9pVtJ.dYAyGW', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (117, 'Kasim Tukimin', '7', 4, '3171022308620005', 'Senen', 'Muchamad Fakhrudin', 'K/1', 'ATRIUM PLAZA LT.V, C.77, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '081382777199', 'kasimtukimin199@gmail.com', '$2y$10$M1eVxs.gUhBL6i7lJkakSunc8qkvL0CZsIktRVPoyh28F5C71yDbe', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (118, 'Agung Sutanto', '7', 4, '3173041907561001', 'Tangerang Barat', 'Gede Suarsana', 'K/0', 'JL.MERPATI RAYA D17 NO.9, GEBANG RAYA, GEBANG RAYA, PERIUK, KOTA TANGERANG, BANTEN, 15132', '0881010622198', 'agungsutanto929@gmail.com', '$2y$10$ay7RE1q/yJGkAH8GslP1uubjFr.QOsY3WjSV6wOhYrKU2pjwqoRaO', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (119, 'Foeng Fi Min', '7', 4, '3671031210610004', 'Tangerang Timur', 'Arni Ardiyanti', 'K/0', 'BUDI INDAH, JL KELUD II BLOK A.1 NO. 26 RT 006 RW 07, PORISGAGA, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '6281218814902', 'foengfimin8@gmail.com', '$2y$10$5m.4qbEqSJwq96GoHL41DO2y7kxYsop.hJaf9yFk3azoyOP79rvdS', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (120, 'Yulisna Kohar', '7', 4, '3173015001771003', 'Tangerang Timur', 'Tri Bekti Utami', 'TK/0', 'BANJAR WIJAYA B.19B/31 RT. 004 RW. 15, PORIS PLAWAD INDAH, CIPONDOH, KOTA TANGERANG, BANTEN, 15141', '08121588282', 'yulisnakohar@gmail.com', '$2y$10$7riUU9Cp0g/qque2IVzc0ebtQELBncslJ7ba5iLM/oLNBI0paxR9S', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (121, 'Antonius Sugiarto', '7', 4, '3173050412580005', 'Tanah Abang Dua', 'Hidayat Imam Bayu', 'K/0', 'JL KEBON JATI, -, 2, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '628161923006', 'lijinantonius19@yahoo.com', '$2y$10$cyUf47PL1N0rEfvc64SLlu.4t1NsMCpIES82fQckfumwlatskdY6.', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (122, 'Udji Djohan', '7', 4, '3171020811780002', 'Sawah Besar I', 'Handita Kusuma Dewi', 'K/2', 'JL.P.JAYAKARTA BUDI RAHAYU I NO.42 RT.005/009 MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '087788238982', 'djohanudji@gmail.com', '$2y$10$pbePhP69geUrZCvWH52bSOtUQKkigbwHZeeoJIMvwPjjXdFoSZjxu', '2026-06-16 04:04:34', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (123, '-', '7', 4, '076278837043001', 'Kelapa Gading - Cabang', 'Abdul Hakim Amin', 'K/2', 'JL. ARTA GADING SELATAN, B6 LT. 1, 22, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '087788238982', NULL, '$2y$10$4WCR8YWiFvCQlIIJPDGjh.IElUqUkj1hlrAzrJaz7lctJSeP6jKiO', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (124, '-', '7', 4, '076278837044001', 'Pademangan - Cabang', 'Dhimas Fery Agung Prabowo', 'K/2', 'ITC MANGGA DUA LANTAI 3, BLOK A, No. 96, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '087788238982', 'udjidjohann@gmail.com', '$2y$10$x0xrr02FUqW.OQzEupZBlOfVJ0.VjeYoCSyABDT1AI4DHIk5bK60y', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (125, 'Koe Sevina Octricia', '7', 4, '3173024710840002', 'Grogol Petamburan', 'Oryza Aprilia', 'TK/0', 'TANJUNG DUREN DALAM, VII, 14, TANJUNG DUREN SELATAN, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '081932007325', 'koesevina19@gmail.com', '$2y$10$KkPYHNppsa1ZFuQFr8yyz.y2zO.6Fo2OIJAM3Ba4P1YILMPqBhfpm', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (126, '-', '7', 4, '711333575032001', 'TamanSari - Cabang', 'Mauridatul Hany', 'TK/0', 'BUNI, 25, MANGGA BESAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11180', '6252744', 'koesevina@gmail.com', '$2y$10$LZpzeJtrmIvFygdV79oInOFxy9DCIzAc2E5BXITEnt6CKystCsUki', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (127, 'Olivia Ione Rafin, JD', '7', 4, '3172015410500002', 'Pluit', 'Hendri Wibisono', 'TK/0', 'KAPUK KAMAL, KAMAL MUARA, KAMAL MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14470', '021235700012', 'OLIVIAiONERAFIN@YAHOO.COM', '$2y$10$26/B4Gk2YAI5.bKejFTEpOKoZz3kVMf5ovB.zoELrqWxJVzUkcpCC', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (128, '-', '7', 4, '071067938072001', 'Tanah Abang Dua - Cabang', 'Wihandoko Wihandono', 'TK/0', 'PASAR REG.TANAH ABANG BLOK A LT.LG LOS C NO.066-067, KAMPUNG BALI, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '235700012', 'OLIVIAIONERAFIN2@YAHOO.COM', '$2y$10$09mZeczExurWZovG3YvDLuK2IlukL5s0kKZy.1dLECvZ6Zvpm8wRO', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (129, 'Safina', '7', 4, '3172027103660002', 'Tanjung Priok', 'Japlis Windiyono', 'K/0', 'JL SUNTER GARDEN, BLOK D.8, 2 E, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '0816775569', 'finasafina1922@gmail.com', '$2y$10$g1WRdIqusO30tYEEWgGK7uXEZXHcMlfMb8mo4eTvlzVJ5CtSwu6vS', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (130, '-', '7', 4, '070469572044001', 'Pademangan - Cabang', 'Benedetta Krisna Wicaksana', 'K/0', 'PUSAT GROSIR PASAR PAGI MANGGA DUA LT. 4 BLOK BA NO. 113A, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '081380137369', 'safinafin@yahoo.com', '$2y$10$DHCuQpqkLA6dDLTwgfvHRePTS51w1a3nug01HsZbWm2yhwmTWr9Q.', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (131, 'Sindjaja Jonany', '7', 4, '3173042409640005', 'Pluit', 'Ganendra Edo Satwika', 'K/3', 'JL WALET INDAH I, 21, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '628158007621', 'sindjajajonany8223@yahoo.com', '$2y$10$WYItR00arOARhWIuxXq2jeZfeTwIcFgMoA5Ve5diKFfWZdyhogsTy', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (132, '-', '7', 4, '066512245044001', 'Pademangan - Cabang', 'Benedetta Krisna Wicaksana', 'K/3', 'PS. PAGI LT. SEMIBASEMENT BLOK, ANCOL, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '0817881156', 'sindjajapspagi@yahoo.com', '$2y$10$RxwdLuwciA6onHEYT8Jp1ezTNLeRumn2xhGY6yn8INvBcttjdB9G2', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (133, '-', '7', 4, '066512245044002', 'Pademangan - Cabang', 'Dhimas Fery Agung Prabowo', 'K/3', 'TC MG.DUA LT.3 BLOK A NO.3, ANCOL, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '6281580007621', 'sindjajaitc@yahoo.com', '$2y$10$4fv0KQd8uwAnujvkOT0PMOsilKcateG3VlV9jfN1y7qyBP.VXGTme', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (134, 'Tjong Kian Tjoeng', '7', 4, '3171021801540002', 'Sawah Besar Dua', 'Lince Ani Fransiska', 'K/0', 'JL KARTINI IV DALAM, 179, KARTINI, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10750', '08161827632', 'tjongkian7@gmail.com', '$2y$10$OW9bSPPm0LEBVBQBlgL92ekX7.1ZKBYaJpgAMNY096/CwdO9gkIJe', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (135, '-', '7', 4, '068139740026001', 'Sawah Besar Satu - Cabang', 'Yuan Robi Arta', 'K/0', 'MANGGA DUA MALL LT.I NO.4A, MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '62216127972', 'tjongkian2@yahoo.com', '$2y$10$mxskT0hC5/4y003aZzUnOuvWZcILuwMeXWXbyNwZnD.QisVVsOhiu', '2026-06-16 04:04:35', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (136, 'Christine Yuliani', '7', 4, '9171024407910002', 'Jayapura', 'Tan Christian Nathanel Budiman', 'TK/0', 'JL. PERIKANAN, 26, HAMADI, JAYAPURA SELATAN, KOTA JAYAPURA, PAPUA, 99126', '082399944445', 'dr.christineyuliani@gmail.com', '$2y$10$TVd8pq2ucO2wHhKaw1b5vuwEwJUPlNK4KXIZG/tD.kjaZ1gx3SFxW', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (137, 'Dely', '7', 4, '3173040109790002', 'Tambora', 'Rizki Ilham Akbar', 'K/2', 'JL KRENDANG TENGAH I, 86, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '0216296149', 'dely191919@gmail.com', '$2y$10$1caRPob8m/SWv.zNBkXpHeSpOEVS23liqTNhjQebx2IzFbZRdGI3K', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (138, 'Enggitawati Kusnadi', '7', 4, '3173045605390002', 'Tambora', '', '', 'JALAN KRENDANG TIMUR RT 003 RW 001, KRENDANG, TAMBORA,KOTA ADM. JAKARTA BARAT, DKI JAKARTA', '85710699866', 'ENGGITAWATIKUSNADI@GMAIL.COM', '$2y$10$IxF2hcWxIxxxqS.lgMugP.EA/WUn420tMAfiRBmfXR5ElvGQ9rHAu', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (139, 'Dicky Wirayadi Hadipurnama', '7', 4, '3173040507510002', 'Tambora', 'Riska Septiana Estutik', 'K/0', 'JL GG. TOGE NO.7, 7, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', 'dickdicky1920@gmail.com', '$2y$10$lWhI5//qQlzWWgSxLpuWbeFCEcaJRSP6TyMLW0MusMopyUooMIxt.', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (140, '-', '7', 4, '064691512037001', 'Tamansari', 'C. Wahyu Triwibowo Arikadi Putra', '', 'PASAR PAGI ASEMKA LT. BASEMENT, B174/175, PINANGSIA, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11110', '087882550888', 'dickywiryadihadipurnama@gmail.com', '$2y$10$FUg5NwhuEDfguGJLiXhzcu2J/cyBx0fK/ZKae5.fu5.HEs8gFnw9.', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (141, '-', '7', 4, '064691512037002', 'Tamansari', '', '', '', '', NULL, '$2y$10$1z4.vL/ZmSZRYxfKVG9FsOEV/UdfolRw3wEBiydYD83iklB5juSXm', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (142, 'Eric Saibun Yolinta', '7', 4, '3173021501510005', 'Grogol Petamburan', 'Zulmy Agung Pambudi', 'K/0', 'JL JELAMBAR ILIR, 22, JELAMBAR BARU, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '62818981218', 'ericsaibunyolinta@gmail.com', '$2y$10$Pe2Sn2pn/EaZGinVfRK3Veevr3O2dgEemG2Bq.9FVrl8yZwA/c7Y6', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (143, 'Feliciana Kartadinata', '7', 4, '3171016409850002', 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '081286688869', 'felicianakartadinataa@gmail.com', '$2y$10$jksXp8xkZhQoLjeqUeZbV..Sk39MNxcGRNqYXxhv0Q4S.u4R5bwRa', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (144, 'Gabriella', '7', 4, '3173044412971001', 'Kalideres', '', '', 'PERUMAHAN DAAN MOGOT BARU, KINTAMANI TIMUR 3 LL NO.16RT 000 RW 000, KALIDERES, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11840', '082261616109', 'gabriella.97@yahoo.com', '$2y$10$vUaqqbUHQQ8c23HGtW2Ol.DmvjzXhfaCCikuG4hNL.h7L7Nnt.V.q', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (145, 'Gouw Keng Hoa', '7', 4, '3173045912540002', 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'KP KRENDANG, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '081296988658', 'gouwkenghoaa@gmail.com', '$2y$10$Y9d62mgOXw0aDu7FeOLDIeQBLOk2qgfuA4uxIK3sglncn3OmncDO6', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (146, 'Gunawan Widjaja', '7', 4, '3171020711600002', 'Sawah Besar Satu', 'Muhammad Ismail Marzuqi', 'TK/0', 'JL MANGGA DUA ABDAD C, 50, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '085881389934', 'widjajagunawan0@gmail.com', '$2y$10$dKJWv9oAeARbVU7k3ZC6SO.uLt0aPt3HdN8Ai1fIKxE04yD/23CoC', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (147, 'Handy Tjahyadi', '7', 4, '3172062010670001', 'Kelapa Gading', 'Lesty Phytaloka', 'K/1', 'JL GADING KUSUMA, GK 8, 2, KELAPA GADING TIMUR, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '62813065196412', 'handytjah19@yahoo.com', '$2y$10$3j6oegFz3MUdqZWRh18V1eZaiKN7Zu1Qk7NhD7sa0.a0u.j3RMTYq', '2026-06-16 04:04:36', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (148, 'Haryanto Djojoe Buntoro', '7', 4, '3172011604670003', 'Kebayoran Baru Dua', '', '', 'JL LAMANDAU I NO.19RT 003 RW 007, KRAMAT PELA, KEBAYORAN BARU,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12130', '0816940397', 'harbun88@hotmail.com', '$2y$10$Bvo04fMBQBcFLPq8KCnPXuN18NCWocJo.LF6ZJF0ats.rWZfI6AiK', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (149, 'Haryono Kuswanto', '7', 4, '3172011811650003', 'Penjaringan', 'Gani Syabani', 'K/3', 'JL TELUK GONG BLOK N3/48, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '628161162915', 'haryonokuswanto00@gmail.com', '$2y$10$fLSgczdmiS8tPTOBJbUOjuUHB8coYHh/8XJc4JSoCd8gCZJEkVJqS', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (150, 'Hauw Bok Soei', '7', 4, '3173042212700009', 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'JL SONGSI RAYA, 22, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '6281215882824', 'hauwbokk@gmail.com', '$2y$10$Z8Vdv3Lw1nHVxmMC9sjWZOdJfr.k65mTyA26i9trTylMd/XGZGjEa', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (151, 'Hendra Koesnandar', '7', 4, '3173042405840015', 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'JL KHM MANSYUR NO 30B, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '62216909747', 'KOESNANDARHENDRA@YAHOO.COM', '$2y$10$9ClTYgaEEoUN2/X.pGbmy.XjWEC9w1qPM88r6RZ.M/J9kPINaRMV6', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (152, 'Hendrik Koesnandar', '7', 4, '3173042405840016', 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'JL KHM MANSYUR, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '08161891575', 'henrikoesnandar@gmail.com', '$2y$10$WeOCrR0r0VcnIyw/1PZUjuF7aJRIKorHCWA.GUBLQMOxs5A4K6Nma', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (153, 'Hongdoras Limantoro', '7', 4, '3173050212530003', 'Kebon Jeruk Dua', 'Bondan Himawan', 'K/0', 'KOMPLEK GREEN GARDEN BLOK, A5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '08128015571', 'hongdorasl@gmail.com', '$2y$10$NGZEngIt9jwUbSlpmdajYuhs6bBTNVO9O.NRQuMTjE/JNd2VWRI0u', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (154, 'Indra Gunawan', '7', 4, '3173040410910004', 'Tambora', 'Dian Setyawan', 'K/1', 'JL. ANGKE JAYA VI, 1, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '628999904718', 'Test.slave888@gmail.com', '$2y$10$dMIizJm.fKJwG667nJdBZ.WOq9Ma2Pa8bav1b.7u8zvwhzoThNgIG', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (155, 'Indriany', '7', 4, '3171015407430003', 'Gambir Tiga', 'Suci Lestari', 'TK/0', 'JL DURI A II, 1, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '08159064396', 'indrianyny@gmail.com', '$2y$10$CDNF2cVwMqXxnOguJUtqIuFEj1PeHVyiS3httz.8dIirSHI7WR9gG', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (156, 'Jimmy Tirta', '7', 4, '3172012102890003', 'Pluit', 'Endang Suwarni', 'K/0', 'TAMAN GRISENDA, B1, 75, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '6285379009099', 'jimmytirt@gmail.com', '$2y$10$Tn3XoPj55iJATho9w0NSheegwDXvd7bLNmBgTxY3kQDz6IwBYPs6W', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (157, 'Johny Tjahyadi', '7', 4, '3172061104530001', 'Senen', 'Rachma Hidayanti', 'TK/0', 'JL.KALIBARU TIMUR V, 54L, BUNGUR, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10460', '081932807313', 'johnydeep1919@gmail.com', '$2y$10$dUlr4civ0C.KIMKjYlodO.wDWBfMeXGybramn1szeLDLttbSadS6W', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (158, 'Jong Khim Wong', '7', 4, '3173040708660013', 'Tambora', 'Dian Setyawan', 'TK/0', 'JL.SAMARASA III NO.20, ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '6281806886366', 'jongkhimwong@gmail.com', '$2y$10$tPGjdHH4BgXQ1uyqcCDYN.IcoIceliKiWspSBDymeeeqLgp56JI2q', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (159, 'Kelvin Yohannes', '7', 4, '3671030405940003', 'Tangerang Timur', 'Arni Ardiyanti', 'TK/0', 'KELUD 2, A1, 26, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '081290326683', 'kelvinnyo94@gmail.com', '$2y$10$QZQffQWG49UKZCla9W5cTuR9P9EZlY1ImGKOkO8czEujf8s6L/cVm', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (160, 'Kusnadi Setiawan', '7', 4, '3671031505970004', 'Tangerang Timur', '', 'TK/0', 'BUDI INDAH JL. KELUD II BLOK AI NO.26RT 006 RW 007, PORIS GAGA, BATUCEPER,KOTA TANGERANG, BANTEN, 15122', '085697786772', 'kusnadiff5@gmail.com', '$2y$10$0TuqQ.hj3W4CtWSMc2vTCeMyrFpbLbqttwxUxLQ.5fLbmyHSdoMSS', '2026-06-16 04:04:37', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (161, 'Lee Hak Man', '7', 4, '0259861037413000', 'Cikarang Selatan', 'Isrofah Wijayanti', 'K/2', 'L. MH. THAMRIN B-16 LIPPO CIKARANG RT. 000 RW. 000, CIBATU, CIKARANG SELATAN, KAB. BEKASI, JAWA BARAT, 17855', '622189920692', 'leehakman78@gmail.com', '$2y$10$XdMMisdGP42YExh0Xwh.nOGnQ.rl1NfhC0k8PS3ypP3RzXVIFaOoq', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (162, 'Lenny Diana', '7', 4, '3173026507900003', 'Grogol Petamburan', '', '', 'JL HADIAH BLOK DIII/973 RT 008 RW 001, JELAMBAR, GROGOL PETAMBURAN,KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '0817252590', 'not.lennydiana@gmail.com', '$2y$10$.R31hgwKgFuxu2kmiE.7puoQOtTA6Oh9EOVbSkuhJqN2R6aFVoOVC', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (163, 'Lim Tiong Kie', '7', 4, '3173040701510003', 'Tambora', 'Rizki Ilham Akbar', 'K/0', 'JL KP KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '0816470907', 'tiongkiel@gmail.com', '$2y$10$Wq14HbNXoFqYNSoO0hYLU.3j1zcs0CFyWlmG/Tgm8b4NYbomZ2LnK', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (164, 'Martin Raditya Sugiarto', '7', 4, '3173040811850007', 'Tambora', 'Arum Pawestri', 'K/0', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '6282117706296', 'martinpajak0811@gmail.com', '$2y$10$b1BTeR1H6TwQvRDbTmKJg.gGJlq58l981OI2k2PAC54IEAAgzHz9m', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (165, 'Margareth Nicole', '7', 4, '3174075105970003', 'Kebayoran Baru Dua', '', '', 'JL LAMANDAU I NO.19RT 003 RW 007, KRAMAT PELA, KEBAYORAN BARU,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12130', '081388189767', 'NICOLEMARGARETH128@GMAIL.COM', '$2y$10$sERQGlcSmtRYgZtnlFvHU.gqsAh8L9O8amSuFoa6y7XtNa8CHnnLm', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (166, 'Melly Kurniawan', '7', 4, '3172064610680002', 'Kelapa Gading', 'Gibran Kurniawan N', 'TK/0', 'APT CITY HOME, TOWER MIAMI BAY LT 1 NO. 11 RT 007 RW 019 KELAPA GADING BARAT, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '02168710485', 'melykurni99@gmail.com', '$2y$10$lUZA./YhryjFZg1BH4FFGuaRsQObylbyQFFrY5Sy7hV6MyWamKyfa', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (167, 'Michael', '7', 4, '3173022010920004', 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'JL. ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '6287808780871', 'bonifasiusmichael92@gmail.com', '$2y$10$yipvChRf/p8MS1hzxLSMiuvEW5GKwf4hjtKNA5I3HYCMzpVBuHLpe', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (168, 'Puspa Dewi', '7', 4, '3173046509740004', 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'JL ARABIKA NO.15, JAKARTA BARAT, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '0216922616', 'ohdewipuspa@yahoo.com', '$2y$10$AbThE4.3VcN0WmITeFYA9ujF/LLgW2YvRc/bUJ9urzwPbEY6M.zMm', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (169, 'Rahman Halim', '7', 4, '3173070204650003', 'Palmerah', '', '', '', '', 'rahmanhalimm21@gmail.com', '$2y$10$pekDWvC7PhesmaW9AS3UTuKdGmfd2./8vAhkmSJ3v0VNYl35WPcFa', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (170, 'Rio Gunawan Sejati', '7', 4, '3171016206840003', 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'JL KEBON JAHE II NO.14 NO 14 RT.006 RW.02, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '087886687898', 'rigunse@gmail.com', '$2y$10$q92KOyLXZwzNVdL1ItYKMuSKjZWFRVINjyeYBn2K6WHe7H9Ap6s72', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (171, 'Rita Koesnandar', '7', 4, '3173045302610006', 'Tambora', 'Dian Krisnasari', 'TK/0', 'KHM MANSYUR NO.30B RT.001 RW.002, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '0811145152', 'ritakoeskoes19@yahoo.com', '$2y$10$/hdGXPNbfHetzwF3X2d/ne8lgRTM2nhUMB9hNE5vxqB8XnCq.a2IG', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (172, 'Rizal Kartadinata', '7', 4, '3171011607910001', 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '6289636360091', 'rizalkartadinataaa@gmail.com', '$2y$10$jQ79xJp/4H/MqGCFT1896OmvovaDg8MwlU1xLayi2fZt5dvUwpA8W', '2026-06-16 04:04:38', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (173, 'Ronald Russel', '7', 4, '3173022302900004', 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'JL. ALPUKAT VII NO.4 RT.008 RW.002, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '081229922080', 'vincentsius.russell@gmail.com', '$2y$10$VZVTJwNJZM2tu1eRFSgYrulgBYnBVJjbv2X7T5bS9g01Ednn.cquC', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (174, 'Rudy Susanto', '7', 4, '3173040202610004', 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'JL PETAK SERANI III, 48, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '085311690052', 'rudysusaantooo@gmail.com', '$2y$10$QT2nAV0cWJHstrtK4OC3x.F4kuhgyIICSL4Vs6AQAC9lm707a13eu', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (175, 'Sarianto Jony', '7', 4, '3173042605360001', 'Tambora', 'Satriyo Dwi Yulisetyawan', 'TK/0', 'JL PENGUKIRAN RAYA NO.40 A, PEKOJAN, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '081385561767', 'sariantojony8@gmail.com', '$2y$10$G0FwmBLdEOQ0X9q4Y/Q/h.bFsIuTPciqKSNXz4kc1F63xxoMWr53K', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (176, 'Suhendra Tirtaputra', '7', 4, '3172011205650009', 'Penjaringan', 'Imam Taj\'ri', 'TK/0', 'JL JEMBATAN II GG PETASAN / 114 RT 004/002 PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '622166695306', 'suhendratirtaputra5@gmail.com', '$2y$10$gc66eNv2lOq.ZW6C.rgKpuOXY.ZW9czNa8vvDAcIl7qHpbsWyQS3G', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (177, 'Sukim Hartono', '7', 4, '3173041405580006', 'Tambora', 'Dhani Kristanti', 'K/2', 'JL KHM MANSYUR 217 RT.004 RW.002, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '08121931806', 'SUKIMHARTONO19@gmail.COM', '$2y$10$I6iMEmXljVD2MsRHm1z9uuuvGxR5.9cWgrNy8AQHEu0De5/ySratO', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (178, 'Sung Njit Bui', '7', 4, '3173011402600005', 'Cengkareng', 'Ikhwanussidiq Suhartono', 'K/0', 'TAMAN PALEM LESTARI B.I/A.9, CENGKARENG BARAT, CENGKARENG BARAT, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '081213174077', 'sungnjitbuiii@gmail.com', '$2y$10$dZ1vWkKKyRQcWiMHrRzZf.pOMjdxEr0Wv62Yyo159PNjFgUIc8Yqa', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (179, 'Supriyono', '7', 4, '3173012303810026', 'Cengkareng', 'Martua Halomon Sihombing', 'K/2', 'JL. PEDONGKELAN, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '085894279208', 'supriyonosuprii121@gmail.com', '$2y$10$5SG9wYg6tA3J2QZs4ckDGO74gDUCXoOVxf7s81nowzezs3u9rTrhu', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (180, 'Tania Theresa Halim', '7', 4, '3173074811961001', 'Palmerah', '', '', 'JL. ANGGREK ROSLIANA VII NO.11RT 012 RW 006, KEMANGGISAN, PALMERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA 11480', '08119882121', 'taniatheresahalim@gmail.com', '$2y$10$n0R4oM4ZqixElXJogTI78eerV3PuJP9jKR.V2zGht7nHAHRb2p33e', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (181, 'Tony Esrianto', '7', 4, '3173020506600009', 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/1', 'JL ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '62811170029', 'tony_esriantotio@yahoo.com', '$2y$10$FwD/5E9W5.cqWKjfCwzLROdJCAv16H9NZto6WXW/M0yfRf9ydB01K', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (182, 'Wong Song Moy', '7', 4, '3173046906480001', 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'JL ARABIKA, 15, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '0216904724', 'wongsongmoy@yahoo.com', '$2y$10$SCW3JG2dd92joRFO4CtJ/ukpmoJmggyi2Uq3HZVjReqqWa4ny2hHm', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (183, 'Yessica', '7', 4, '3173024502920005', 'Tangerang Timur', 'Moh Ikhsan Iskandar', 'TK/0', 'PERMATA RAYA, C2, 37, CIPONDOH MAKMUR, CIPONDOH, KOTA TANGERANG, BANTEN, 15148', '081298107321', 'yessica.chenyiping@gmail.com', '$2y$10$czuxn/2UsmiD0K8D3H1Gk.m9ClVLOB.IlMpa3Tn.45s6lhELibiHu', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (184, 'Magdalena Bungawan', '7', 4, '3174064301610001', 'Cilandak', '', '', '', '', 'bungawanmagdalena@gmail.com', '$2y$10$4aoNQxN7PpDCp.fSTyh9wOCXp1Yc8G.Pa7KWMh5A7kmF.kwV8NzZ6', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (185, 'Rusmini', '7', 4, '3173045305610009', 'Tambora', '', '', '', '', 'rusminifuk@gmail.com', '$2y$10$LN3ahluwY.4lrMbLtYG0uefUwsj3mvdrK2nl/5.SwAHb9TcvH9EsK', '2026-06-16 04:04:39', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (186, 'Supraptono', '7', 4, '3276090406700005', 'Sawangan', '', '', '', '', NULL, '$2y$10$0gTXsFFHFmZsqpU.dppcGusnlXtZW6yC7u0bNuixodjMUIi//QDse', '2026-06-16 04:04:40', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (187, 'Liem Lies Rohana', '7', 4, '3173047011710001', 'Tambora', '', '', '', '', 'Enny28934@gmail.com', '$2y$10$RLgwl7NU7DWLBT55.pEiXe1/ok1iwp0Qr0PLUX/LQi..MpmELn1hC', '2026-06-16 04:04:40', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (188, 'Thomas Junior', '7', 4, '9113090705640001', 'Jayapura', '', '', '', '', 'THOMASJUNIOR_TJ@YAHOO.COM', '$2y$10$/9xmOzEf2iXn.eOfZGZyQ.4L9rh2WZ.28SZf4Xy639kicOlMDShZK', '2026-06-16 04:04:40', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (189, 'Amadeus Yerima Pribowo', '7', 4, '3174073003850009', 'Kebayoran Baru Satu', '', '', '', '082112928928', 'amadeus.pribowo@gmail.com', '$2y$10$YnYk7K1MHLBTXnO1FSVYQu7RIZ2DIoZzXt/tRVsq3p8t3qvheQjTa', '2026-06-16 04:04:40', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (190, 'Sung Oi Jan', '7', 4, '3173045010740010', 'Tambora', '', '', '', '081213818778', 'oijan776@gmail.com', '$2y$10$SqWWEO/V.CZgZhIZR8atKu4sk5HS3Bu70QVcozgYrbge0l//ZPqsC', '2026-06-16 04:04:40', '2026-06-21 07:02:20');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `kpp`, `AR`, `ptkp`, `alamat`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (191, 'Felix Salim', '7', 4, '3173021802870004', 'Grogol Petamburan', '', '', '', '', NULL, '$2y$10$3CT9xC2.3Vw8hDuFIVMW4Oll2Aoqpt.bgrlF0Mbxytim9q2QIPoau', '2026-06-16 04:04:40', '2026-06-21 07:02:20');
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
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (1, NULL, NULL, 'KAS', '0101', 'UANG TUNAI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (2, NULL, NULL, 'KAS', '0102', 'TABUNGAN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (3, NULL, NULL, 'KAS', '0103', 'GIRO', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (4, NULL, NULL, 'KAS', '0104', 'DEPOSITO', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (5, NULL, NULL, 'KAS', '0105', 'UANG ELEKTRONIK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (6, NULL, NULL, 'KAS', '0106', 'CEK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (7, NULL, NULL, 'KAS', '0107', 'WESSEL', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (8, NULL, NULL, 'KAS', '0108', 'KERTAS KOMERSIAL', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (9, NULL, NULL, 'KAS', '0109', 'SETARA KAS', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (10, NULL, NULL, 'KAS', '0110', 'UANG TUNAI/BANK NOTE/KOIN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (11, NULL, NULL, 'KAS', '0111', 'SETARA KAS LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (12, NULL, NULL, 'PIUTANG', '0201', 'PIUTANG USAHA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (13, NULL, NULL, 'PIUTANG', '0202', 'PIUTANG AFILIASI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (14, NULL, NULL, 'PIUTANG', '0209', 'PIUTANG LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (15, NULL, NULL, 'INVESTASI', '0310', 'ASURANSI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (16, NULL, NULL, 'INVESTASI', '0311', 'REKSA DANA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (17, NULL, NULL, 'INVESTASI', '0312', 'OBLIGASI PEMERINTAH/PENGURUSAN PEMERINTAH', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (18, NULL, NULL, 'INVESTASI', '0313', 'OBLIGASI SW', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (19, NULL, NULL, 'INVESTASI', '0314', 'SAHAM', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (20, NULL, NULL, 'INVESTASI', '0315', 'OBLIGASI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (21, NULL, NULL, 'INVESTASI', '0316', 'REKSA SAHAM', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (22, NULL, NULL, 'INVESTASI', '0317', 'REKSA CAMPURAN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (23, NULL, NULL, 'INVESTASI', '0318', 'REKSA OBLIGASI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (24, NULL, NULL, 'INVESTASI', '0319', 'REKSA PENDAPATAN TETAP', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (25, NULL, NULL, 'INVESTASI', '0320', 'REKSA TERPROTEKSI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (26, NULL, NULL, 'INVESTASI', '0321', 'PENYERTAAN MODAL PADA BADAN USAHA YANG DIVIDENDENDENDENYA DIKENAKAN PEMOTONGAN PAJAK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (27, NULL, NULL, 'INVESTASI', '0322', 'KAS PENJUALAN/PEMBELIAN REKSA DANA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (28, NULL, NULL, 'INVESTASI', '0323', 'PERSEKUTUAN/FIRMA/CV', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (29, NULL, NULL, 'INVESTASI', '0324', 'INVESTASI LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (30, NULL, NULL, 'HARTA_BERGERAK', '0401', 'SEPEDA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (31, NULL, NULL, 'HARTA_BERGERAK', '0402', 'SEPEDA MOTOR', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (32, NULL, NULL, 'HARTA_BERGERAK', '0403', 'MOBIL PENUMPANG', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (33, NULL, NULL, 'HARTA_BERGERAK', '0404', 'BUS', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (34, NULL, NULL, 'HARTA_BERGERAK', '0405', 'KENDARAAN ANGKUTAN JALAN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (35, NULL, NULL, 'HARTA_BERGERAK', '0406', 'KENDARAAN TUJUAN KHUSUS', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (36, NULL, NULL, 'HARTA_BERGERAK', '0407', 'KERETA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (37, NULL, NULL, 'HARTA_BERGERAK', '0408', 'PESAWAT TERBANG', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (38, NULL, NULL, 'HARTA_BERGERAK', '0409', 'KAPAL', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (39, NULL, NULL, 'HARTA_BERGERAK', '0410', 'MESIN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (40, NULL, NULL, 'HARTA_BERGERAK', '0411', 'GEROBAK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (41, NULL, NULL, 'HARTA_BERGERAK', '0412', 'KAPAL PESIAR', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (42, NULL, NULL, 'HARTA_BERGERAK', '0499', 'HARTA BERGERAK LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (43, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0501', 'TANAH KOSONG', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (44, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0502', 'TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (45, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0503', 'APARTEMEN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (46, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0504', 'VESSEL', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (47, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0505', 'TANAH ATAU LAHAN UNTUK USAHA (LAHAN PERTANIAN, PERKEBUNAN, DSB)', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (48, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0506', 'TANAH DAN/ATAU BANGUNAN UNTUK USAHA (TOKO, PABRIK, DSB)', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (49, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0507', 'TANAH DAN/ATAU BANGUNAN YANG DISEWAKAN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (50, NULL, NULL, 'HARTA_TIDAK_BERGERAK', '0509', 'HARTA TIDAK BERGERAK LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (51, NULL, NULL, 'HARTA_LAINNYA', '0601', 'PATEN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (52, NULL, NULL, 'HARTA_LAINNYA', '0602', 'ROYALTI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (53, NULL, NULL, 'HARTA_LAINNYA', '0603', 'MEREK DAGANG', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (54, NULL, NULL, 'HARTA_LAINNYA', '0699', 'HARTA TIDAK BERWUJUD LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (55, NULL, NULL, 'HARTA_LAINNYA', '0701', 'EMAS BATANGAN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (56, NULL, NULL, 'HARTA_LAINNYA', '0702', 'EMAS PERHIASAN', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (57, NULL, NULL, 'HARTA_LAINNYA', '0703', 'BATANGAN NON EMAS', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (58, NULL, NULL, 'HARTA_LAINNYA', '0704', 'PERHIASAN NON EMAS', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (59, NULL, NULL, 'HARTA_LAINNYA', '0705', 'PERMATA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (60, NULL, NULL, 'HARTA_LAINNYA', '0706', 'BARANG-BARANG SENI DAN ANTIK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (61, NULL, NULL, 'HARTA_LAINNYA', '0707', 'PERALATAN OLAH RAGA KHUSUS', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (62, NULL, NULL, 'HARTA_LAINNYA', '0708', 'PERALATAN ELEKTRONIK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (63, NULL, NULL, 'HARTA_LAINNYA', '0709', 'PERABOT RUMAH TANGGA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (64, NULL, NULL, 'HARTA_LAINNYA', '0710', 'PERALATAN KANTOR', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (65, NULL, NULL, 'HARTA_LAINNYA', '0711', 'JET SKI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (66, NULL, NULL, 'HARTA_LAINNYA', '0712', 'PERSEDIAAN USAHA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (67, NULL, NULL, 'TOTAL_HUTANG', '101', 'UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (68, NULL, NULL, 'TOTAL_HUTANG', '102', 'KARTU KREDIT', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (69, NULL, NULL, 'TOTAL_HUTANG', '103', 'UTANG AFILIASI', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
INSERT INTO `cms_lampiran_spt` (`id`, `client_id`, `tahun`, `kategori`, `sub_kode`, `sub_nama`, `nilai`, `created_at`, `updated_at`) VALUES (70, NULL, NULL, 'TOTAL_HUTANG', '109', 'UTANG LAINNYA', 0.00, '2026-06-21 07:42:55', '2026-06-21 07:42:55');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_master_rumus
-- ----------------------------
BEGIN;
INSERT INTO `cms_master_rumus` (`id`, `tipe_badan`, `max_value`, `potongan_persentase`, `created_at`, `updated_at`) VALUES (1, '1', 1000000000.00, 10.00, '2026-06-14 01:35:30', '2026-06-14 01:35:30');
INSERT INTO `cms_master_rumus` (`id`, `tipe_badan`, `max_value`, `potongan_persentase`, `created_at`, `updated_at`) VALUES (2, '7', 500000000.00, 0.50, '2026-06-14 01:35:44', '2026-06-14 01:35:44');
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
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (1, 'Pasal 1 - Ketentuan Umum', 1, '2026-06-14 00:07:21', '2026-06-14 00:07:21');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (2, 'Pasal 2 - Hak dan Kewajiban', 1, '2026-06-14 00:07:22', '2026-06-14 00:07:22');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (3, 'Pasal 3 - Tata Cara Pendaftaran', 1, '2026-06-14 00:07:22', '2026-06-14 00:07:22');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (4, 'Pasal 4 - Sanksi Pelanggaran', 1, '2026-06-14 00:07:22', '2026-06-14 00:07:22');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (5, 'Pasal 5 - Ketentuan Penutup', 1, '2026-06-14 00:07:22', '2026-06-14 00:07:22');
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_permissions
-- ----------------------------
BEGIN;
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (34, 1, 'lampiran_spt', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (36, 1, 'lampiran_spt', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (35, 1, 'lampiran_spt', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (33, 1, 'lampiran_spt', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (26, 1, 'role', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (28, 1, 'role', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (27, 1, 'role', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (25, 1, 'role', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (30, 1, 'user', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (32, 1, 'user', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (31, 1, 'user', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (29, 1, 'user', 'view');
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
INSERT INTO `cms_roles` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES (1, 'Administrator', 'administrator', 'Full CMS access', '2026-06-14 00:07:21', '2026-06-14 00:07:21');
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
  PRIMARY KEY (`id`),
  KEY `cms_transaksi_client_id_foreign` (`client_id`),
  CONSTRAINT `cms_transaksi_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `cms_data_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi
-- ----------------------------
BEGIN;
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`) VALUES (1, 3, 2025, 7, 2047347338.00, 0.00, 10236736.69, '2026-06-21 07:54:11', '2026-06-21 07:54:11');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi_omset
-- ----------------------------
BEGIN;
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (1, 1, 1, 123123123.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (2, 1, 2, 321231231.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (3, 1, 3, 192381238.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (4, 1, 4, 123987981.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (5, 1, 5, 123789789.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (6, 1, 6, 68700000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (7, 1, 7, 78687687.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (8, 1, 8, 29384234.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (9, 1, 9, 243242343.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (10, 1, 10, 546576343.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (11, 1, 11, 97897389.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (12, 1, 12, 98345980.00);
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
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (8, '2024_01_04_000001_create_badan_table', 2);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (9, '2024_01_05_000001_add_tipe_badan_to_data_client', 3);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (10, '2024_01_06_000001_create_master_rumus_table', 4);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (11, '2026_06_16_065211_update_tipe_badan_in_cms_data_client', 5);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (12, '2026_06_16_084717_create_cms_transaksi_tables', 6);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (13, '2026_06_16_090000_add_email_password_to_cms_data_client', 7);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (14, '2026_06_16_104228_add_ar_and_ptkp_to_cms_data_client', 8);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (15, '2026_06_21_000001_create_cms_client_roles_table', 9);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (16, '2026_06_21_000002_create_cms_lampiran_spt_table', 10);
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES (1, 'Admin', 'admin@example.com', NULL, '$2y$10$Pb1t64zMdRoI/v6wkfJ7X.dQNiwPRQObnKIbQpSqkpchC6pGM0wF6', NULL, '2026-06-14 00:07:21', '2026-06-14 00:07:21');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
