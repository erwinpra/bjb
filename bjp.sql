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

 Date: 27/06/2026 00:03:27
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
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (3, 'Perorangan', '2026-06-26 14:49:24', '2026-06-26 15:13:15');
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
  `npwp_cabang` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kpp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `AR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ptkp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat_npwp` text COLLATE utf8mb4_unicode_ci,
  `alamat_tagihan` text COLLATE utf8mb4_unicode_ci,
  `no_telephone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_data_client_email_unique` (`email`),
  KEY `cms_data_client_client_role_id_foreign` (`client_role_id`),
  CONSTRAINT `cms_data_client_client_role_id_foreign` FOREIGN KEY (`client_role_id`) REFERENCES `cms_client_roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_data_client
-- ----------------------------
BEGIN;
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (6, 'Adhi Surya Winata', '2', 4, '730559523033000', '', 'Tambora', 'Pratama Yudha', 'K/1', 'JL. JEMBATAN BESI 4, 15A, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '083899034184', 'adhisuryawinata@gmail.com', '$2y$10$cPfrPjPj9HJ6S7CWOVi3KOfqwf3NdQtpdLClMMCVSBmmkGRE9r92u', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (7, 'Andrew Yuniarto', '2', 4, '076546605033000', '', 'Tambora', 'Arum Pawestri', 'K/3', 'JL.JAMBLANG INDAH I NO.9 RT.013 RW.002 DURI SELATAN, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '62216302385', 'andrewyuniarto@yahoo.com', '$2y$10$KzyyxHQVP7VFeXavr7YPJOAbA620AMf5JGbWJmVR7Ze9r1/qJogzG', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (8, 'Bambang Handojo', '2', 4, '063120463033000', '', 'Tambora', 'Laila Nur Wahidah', 'TK/1', 'JL GG. BETET NO.63, 63, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '081517874562', 'bambanghandojo799@gmail.com', '$2y$10$DLw0f2ftznJcRv4iqIgFQ./C5RlKGjAY78wa3WwWPgvA.mI6NNUbO', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (9, 'Budi Makmur', '2', 4, '076540780033000', '', 'Tambora', 'Fibri Kurniawan Suwu', 'K/2', 'JL PEJAGALAN RAYA, 1, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '62818805777', 'budi.makmur@gmail.com', '$2y$10$ygPW2tJggnMIPqcgY.13Q.gBEFAcwKDQSsbp/k3h6lI.rRxuYI/wC', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (10, 'Catherine Gosella', '2', 4, '830889564033000', '', 'Tambora', 'Dian Krisnasari', 'TK/0', 'JL. BETET NO 7. JEMBATAN LIMA, 7, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '628128700111', 'cathgosella@gmail.com', '$2y$10$7w0HVEJoLMFcCGUbhCD.x.jJhCbNP.TYE7doobB4O6tC.rpSBX1L.', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (11, 'Erna', '2', 4, '182815811033000', '', 'Tambora', 'Ridwan', 'TK/0', 'JL TSS GG BARU, 20G, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '082258555347', 'ernaccss@gmail.com', '$2y$10$1JZbOV7FOW2MbUzaZDZhhOFx45RZRCUMvcDC4KU.bZy4gZoXXipxO', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (12, 'Fransiscus Lie', '2', 4, '175846054033000', '', 'Tambora - Pusat', 'Dhani Kristanti', 'K/2', 'JL KRENDANG BARAT, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '081318187166', 'fransiscuslie428@gmail.com', '$2y$10$2whtwKsCTE4FXyEc5YJSj.mU2pyoab58o6jkeapymnhrQ2NFv.z6W', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (13, 'Fransiscus Lie', '2', 4, '175846054072001', '', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'GEDUNG PGMTA LT.1 BLOK C/18 JL KEBON KACANG I, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '', '0216315876', 'FRANSISCUSLIE2@YAHOO.COM', '$2y$10$J7kzL8hK0Z/5KZwrh4kuF.2hydAu9JF/7txbYRpLv13cBPL6DyOY2', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (14, 'Gunawan Widjaja', '2', 4, '684564404033000', '', 'Tambora', 'Ria Puji Anesti', 'TK/0', 'JL GG SAMARASA I, 7, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '628129186728', 'gunawanwidjajaa@gmail.com', '$2y$10$nLjTJiIes9ZK/rHRSOSKmuzLwQptgyjTngjxsUgaqUKLsVLxVOFna', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (15, 'Harianto', '2', 4, '061885158033000', '', 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'JL KHM MANSYUR, 209, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '6281311648970', 'hariantopit@gmail.com', '$2y$10$Co.k69xn/E6MnR05CKvRaOVZ6jMzNR5KoItmEh8lqAqFWc5LPs7Fe', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (16, 'Hengky Yuniarto', '2', 4, '067906776033000', '', 'Tambora', 'Arum Pawestri', 'K/0', 'JL JAMBLANG INDAH I, 9, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '08158305511', 'henkyyuniarto@gmail.com', '$2y$10$Zlo6AVlu.VredT6mcXNOxueKBWLZ2Cs/8VTa9KVrqjqqzasf5omlS', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (17, 'Heu Panjuwono', '2', 4, '058137670033000', '', 'Tambora', 'Dhani Kristanti', 'TK/0', 'JL. KRENDANG TENGAH I, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '6215445982', 'heupanjuwono@gmail.com', '$2y$10$VniSfUr8MiEdUH/bQFk2IeVsa75VKZlrOkxHXDPwxk7feo9WUk4Qe', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (18, 'Iwan Widjaja', '2', 4, '076535814033000', '', 'Tambora', 'Dian Setyawan', 'K/2', 'JL.SAMARASA I / 7, ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '08161891575', 'widjajaiwan16@gmail.com', '$2y$10$RbEIwlXzB.izV8fIARyNQODf5lHFOK1JfwPgLb7/Rm26p0ejkG8me', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (19, 'Kiandi Kusuma Liong', '2', 4, '061133567033000', '', 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'JL PERNIAGAAN, 129, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '08121116868', 'liong.siong033@gmail.com', '$2y$10$sOk9aNhGH8EmBNW/lOQRxOr5AEDxrPI69mAxxuhVtm71OFXB9iSFO', '2026-06-26 16:56:08', '2026-06-26 16:56:08');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (20, 'Kok Lukman Wijaya', '2', 4, '688484583033000', '', 'Tambora', 'Ria Puji Anesti', 'K/2', 'GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '083719663796', 'koklukman@gmail.com', '$2y$10$0OVI0KE0U/oCIHNTV/SYje1mvMjeSRxBKdcKPAuH28TGZYtlEGGja', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (21, 'Liauw Ka Tjaij', '2', 4, '249404070033000', '', 'Tambora', 'Arie Kurniawan', 'K/0', 'JL. PEJAGALAN I NO. 98 D RT. 014 RW. 005, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '0216322909', 'kcliauw@gmail.com', '$2y$10$yLYFE38uISoQcX1.CtBR3eSzwH5d62TfvsFBpZ2nQV2HntmG2pPV2', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (22, 'Liu Loy Loy', '2', 4, '3173042609770009', '', 'Tambora', 'Adetya Candra Yuwana Putra', 'K/3', 'JL KHM MANSYUR, 172, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '0813380655933', 'liuloyloy@yahoo.com', '$2y$10$fV9RRSdbDdcnax/t134G.OuC0keeGpMouEt7.1vJTLtztebx9oLgi', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (23, 'Phang Su Phin', '2', 4, '069133775033000', '', 'Tambora', 'Arum Pawestri', 'K/2', 'JL DURI SELATAN V, 65 B, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '08129946588', 'phangsun19@yahoo.com', '$2y$10$I7HhYOCc8lV4N2Td3Z41JODb6m7A.GKA1IL7fT77AKxltceJdPFvW', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (24, 'Ringo Yapari', '2', 4, '076533710033000', '', 'Tambora', 'Wursito Atik', 'K/2', 'JL.KHM.MANSYUR NO.218, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '081288224490', 'ringoyapari17@gmail.com', '$2y$10$DDO9zeJR1ToMAmaTHIcBC.HUkXuKRin5gWVkP9sPfQX1KK.Z7VbjS', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (25, 'Robin Sugiarto', '2', 4, '175914100033000', '', 'Tambora', 'Arum Pawestri', 'K/1', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '08128000812', 'robinsugiarto997@gmail.com', '$2y$10$N9MvC0kPf3o.hAqYwPDyNuU.CA6jRhCLl1WwYmq7UoqF4Mkr.AKIq', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (26, 'Rosmawati', '2', 4, '066740093033000', '', 'Tambora', 'Ridwan', 'TK/1', 'JL KP DURI TSS, 51, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '62816811386', 'pajakrosmawati17@gmail.com', '$2y$10$EWJWX1kC6XXfTDCqVEjZY.FY2V7n9OzPTkAre3/slRXYAaN6mQgLO', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (27, 'Santoso Latif', '2', 4, '175734078033000', '', 'Tambora', 'Adetya Candra Yuwana Putra', 'K/0', 'JL SONGSI, 6, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '62216902735', 'santosolatif3@gmail.com', '$2y$10$AUV6wPtOzQz81NTJTaVEo.8VcHmxoog5TxecAsq9gw.UvN3hCKf/.', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (28, 'Sastro Tjondro', '2', 4, '279076624033000', '', 'Tambora', 'Ria Puji Anesti', 'K/2', 'GG SAMARASA III NO.18 RT.005 RW.005 KEL ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '6281105892', 'sastrotjondro4@gmail.com', '$2y$10$UhPb9Si8x8qS7LxZlbzK4.Qzg2mGDAsm2omYIYx3lf082vmckxIhS', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (29, 'Sumitro Lie', '2', 4, '189399025033000', '189399025033000', 'Tambora - Pusat', 'Dhani Kristanti', 'K/3', 'JL.KRENDANG BARAT NO.42 RT.012 RW.005 KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '622130365910', 'sumitro.lie@yahoo.com', '$2y$10$WnW1Dqjkz7/tC6/7PZ6.GuSZsJTCBtDUnluwuO4HRu8p2Q7gaFwSa', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (30, 'Sumitro Lie', '2', 4, '189399025072001', '189399025033000-189399025072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'PUSAT GROSIR METRO TANAH ABANG LT. 2 BLOK B NO. 1, KEBON KACANG, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '', '62213036591', 'sumitrolie69@yahoo.com', '$2y$10$G5EYCDIdBzyAKUjJU/HJhus1RCh2hSiqRF3G2XokbdWDA6ZW.8yBS', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (31, 'Suwandi Arifin', '2', 4, '688484591033000', '', 'Tambora', 'Ria Puji Anesti', 'K/1', 'JL PTB ANGKE GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '6285719663796', 'suwandiarifin00@gmail.com', '$2y$10$HYIcc5WychdoyZ.TJRw9S.hge7dIAlJU/A9KfWga2kr7Pwl0GJ.pq', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (32, 'Tjan Gosto', '2', 4, '684564412033000', '', 'Tambora', 'Ria Puji Anesti', 'K/1', 'GG SAMARASA I, 23, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '08176902776', 'gostotjan@gmail.com', '$2y$10$RnkuMP5wFvQSD7kYNJQgWeMQ9BuJAhCghkDIpUWcNBv22j1rijM3G', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (33, 'Tjhin Su Mie', '2', 4, '969355684033000', '', 'Tambora', 'Putra Dwi Pamungkas', 'TK/3', 'TERATE I NO 11, No 11, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '', '081617175507', 'tjhinsumie9@gmail.com', '$2y$10$5N6ZY/j/BIkc2Gu6R3xct.E59pVsFrDMk3cSuuXa2wo8j4IZx2qYS', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (34, 'Tjioe Seng Huat', '2', 4, '069103547033000', '', 'Tambora', 'Wursito Atik', 'K/1', 'JL TANAH SEREAL X, 8, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '6281315151596', 'tjiosenghuat@gmail.com', '$2y$10$HncgPTTqgiao5tSYEHOMROxWX7ZazVYdaKCfrNZUTip7fwXkJY36O', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (35, 'Tjiu Jun Shin', '2', 4, '076531904033000', '076531904033000', 'Tambora - Pusat', 'Ridwan', 'K/3', 'JL.TSS.NO.15 L, DURI UTARA, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '62811872783', 'tjiuju@gmail.com', '$2y$10$x9CBf1enzMOR5beC1c9X8uR26nwu6tQoJqoQWA4qkRtLKKkvU.jz.', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (36, 'Tjiu Jun Shin', '2', 4, '076531904072001', '076531904033000-076531904072001', 'Tanah Abang Dua - Cabang', 'Hendy Primantoro', '-', 'PUSAT GROSIR METRO TANAH ABANG, PGMTA LANTAI III LOS B NO 19 KELURAHAN KEBON KACANG, KEBON KACANG, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10240', '', '02162216303403', 'tjiuju2@yahoo.com', '$2y$10$Pcfozcr6bSIm9RLLyDG/Te5b2e52xOFbwmJORQcxcV5rInp9xBB8m', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (37, 'Tjiu Supardi', '2', 4, '076533835033000', '', 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'JL LAKSA I, 85A, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '', '628128556129', 'tjiusupardi@gmail.com', '$2y$10$16777YrHZjHUO8qY0JX/zeiUTbYaeBWEYDyzbQuaII31lCe3/9Qzi', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (38, 'Vicky Famin Efendy', '2', 4, '694895046033000', '', 'Tambora', 'Anung Prasetyo Dwijayanto', 'K/0', 'DURI BARU NO.3, JAKARTA BARAT, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '-', 'vickyfamin@gmail.com', '$2y$10$w8RzZbDKwJkK6uRSAXsLB.zVlOCbKsgvF92foy2jzyaP3hTk5iAXK', '2026-06-26 16:56:09', '2026-06-26 16:56:09');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (39, 'Erres Subiarto', '2', 4, '061844098026000', '', 'Sawah Besar Satu', 'Geri Gema Putra Tarigan', 'TK/0', 'JL GUNUNG SAHARI 11, GUNUNG SAHARI UTARA, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10720', '', '087885382958', 'eressubiarto@gmail.com', '$2y$10$ucm/yJ/3Y2iAWulT77VK1O3T5wyWfW10KqBTyCccYhK.XbviUnFjO', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (40, 'Diana Wangsa Heryanto', '2', 4, '664215126075000', '', 'Sawah Besar Dua', 'Chalimatus Sa\'diyah', 'TK/0', 'JL KELINCI IV NO 2 A RT 008 RW 004, PASAR BARU, 2 A, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '', '6281808867585', 'dianawangsa2@gmail.com', '$2y$10$T6xwqpI3cFT.JxpysptRsuRlSlh5C0oupxrf6qEHILPFwLr69/Q2O', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (41, 'Djohan Hirawady', '2', 4, '067495846037000', '', 'Sawah Besar Dua', 'Dellachita Rahardhianne Winarto', 'TK/0', 'JL GG MANDOR, V, 32, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '', '081574258787', 'djohanhirawady@gmail.com', '$2y$10$psA66LG10sSU33UHjksD9O071z/irr7TY9XF5sCIOk4apLwijV6QW', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (42, 'Alex Heryanto', '2', 4, '065587503032000', '', 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI IX, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '6221624329', 'alexheryanto51@yahoo.co.id', '$2y$10$KV6Y4pFvwkwogaFdyPBtpemX0YqCyig0vlL7HV7ZfHCn5OgAD3P5K', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (43, 'Cynthia Kurnia', '2', 4, '659844500032000', '', 'Tamansari', 'Nova Novelita', 'TK/0', 'JL TAMAN SARI IX/10, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '082225843858', 'cynthiakurniaa@gmail.com', '$2y$10$O1wYgkk7JDrDmUmDebSikONYL.lWyz8VBj2CpZMFaWOD1X.YFIbBy', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (44, 'Ferry Wangsa Saputra', '2', 4, '813350246032000', '', 'Tamansari', 'Nova Novelita', 'K/0', 'JL. TAMANSARI IX/10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '08989703363', 'ferrywangsa@gmail.com', '$2y$10$Jb1o71bIwQP4hEkmR.YDiOk.Rib0cUziaplsxUI0vHCsdjp91QqoS', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (45, 'Hendry Wijaya', '2', 4, '076453869032000', '', 'Tamansari', 'Nova Novelita', 'K/3', 'JL TAMANSARI IV, 22, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '628129133176', 'hendrywijayaa0@gmail.com', '$2y$10$4mZ6p6ZxQvhi1eb27dfiZekEXzxUS46iQiYeksXvGloBJQbQSCZfq', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (46, 'Johan Ng', '2', 4, '068512904032000', '', 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI VI, 52-B, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '081808991212', 'johanng454@yahoo.com', '$2y$10$urIvn/E/Z2d8dF2nJEQnv.0ZZ9FHI3je8yyRzW0NAsLJV.tIZWBHi', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (47, 'Mulyadi Saputra', '2', 4, '068512219032000', '', 'Tamansari', 'Nova Novelita', 'K/0', 'JL TAMANSARI IX, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '', '6285100582190', 'mulyadisaputra817@yahoo.co.id', '$2y$10$L7xBpzV3Tlit7jCUtlsoMuhAA4zsqr84b/OojdY6bYpKhAefj.NP.', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (48, 'Willy Darmawan', '2', 4, '577673528032000', '', 'Tamansari', 'Raden Muhammad Riandy Irmansyah', 'K/3', 'JL TAMANSARI II, 60 B, MAPHAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11160', '', '0818169848', 'willydarmawan678@yahoo.co.id', '$2y$10$QCKyGHJyaG7/uisWFrDtFuRfar99GeFo2sGLklawfqBQFwcboaJbu', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (49, 'Wong Sauw Lie', '2', 4, '096710199037000', '', 'TamanSari', 'Dite Fatmawati', 'TK/0', 'JL KEMENANGAN V GG 2, 18 A, GLODOK, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11120', '', '0216393841', 'wongsauw10981@gmail.com', '$2y$10$PK9kUVMGKaEh4eT3PttPc.CeMEaVIrhiUYmMtuSMd.YK2DzpJCpnm', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (50, 'Yoanita Kristina', '2', 4, '091270769035000', '', 'Kebon Jeruk Satu', 'Rahmat Husein Harahap', 'TK/0', 'KOMPLEK BPK III, C, 9, KEBON JERUK, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11530', '', '081517874562', 'yoanita.kristina@yahoo.co.id', '$2y$10$GrmncNIWx/83LJ383c5/r.o36lI1G8ZZod1mRFkCXjMl6kVyktkmG', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (51, 'Andy Prayitno Limantoro', '2', 4, '258880335039000', '', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'GREEN GARDEN BLOK A-5/12 RT. 003 RW. 003, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '628567843535', 'andyprayitno57@yahoo.co.id', '$2y$10$vQOlx56Ymd4oxbNGa9ul6eytqJ8TcI1tlVhj3CMMkRgeGd7nTOq46', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (52, 'Indra Prayitno Limantoro', '2', 4, '813778198039000', '', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'K/0', 'GREEN GARDEN, A-5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '08128015571', 'indraplim@gmail.com', '$2y$10$kzWdwpWXXG5JsXz7Zx6.MuJZDvYpUETXszhcojuY9bT72Q8oD69dW', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (53, 'Winston Tanazon', '2', 4, '767341183039000', '', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'KOMPLEK GREEN GARDEN, M 3, 57, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '08170066290', 'TANAZONW@GMAIL.COM', '$2y$10$H2NtddWjGJIpX5qsmXZl5uQMqb1nqlk3Nape72L4XjYDdvCJJdBle', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (54, 'Willy Limantoro', '2', 4, '678492109039000', '', 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/1', 'KOMPLEK GREEN GARDEN, A 5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '62215650104', 'limantorowilly@gmail.com', '$2y$10$5mmg/.wUb1Dcidox8mxVre3qKgwVAUgzxBty.1xyCeJNh.ZkZEKWK', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (55, 'Albert Limanto', '2', 4, '768236788034000', '', 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'JL KAPUK RAYA, 8, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08568568445', 'albertlimant@gmail.com', '$2y$10$Vqm/okPNGzfd0GQpRrj/HehtIm4jOzN8nIWkPc8pBfFNYpckX3UZy', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (56, 'Alvindo Limanto', '2', 4, '633796222034000', '', 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '081289020181', 'alvindolimantoo@gmail.com', '$2y$10$iGACPxbVP0sARdBjicWOs.9Kfm8TKkigR3.mfHGH9MkSD8wwkWO6W', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (57, 'Chandra Limanto', '2', 4, '776577181034000', '', 'Cengkareng', 'Genis Anggraeni', 'K/2', 'JL KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '081889020181', 'chandralimanchan@gmail.com', '$2y$10$893g.o30RCVMJDk5EAgxv.ZgiBY334xGNLNxUVryFHz9/tkbNDZ4q', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (58, 'Heng Chun Khiun', '2', 4, '467420469034000', '', 'Cengkareng', 'Puspa Ayu Wulandari', 'K/0', 'JL KAPUK KEBON JAHE, 133, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08178811560', 'hengchun377@yahoo.co.id', '$2y$10$h3qr6Ex2a0Zpk9k1B7UT9O09wN3xZQrKT7OpLlBziDABjP6su.Ic2', '2026-06-26 16:56:10', '2026-06-26 16:56:10');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (59, 'Lisa', '2', 4, '730214897034000', '', 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'KP UTAN NO. 3, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '08988959911', 'lisacss1@yahoo.co.id', '$2y$10$FH/3.Zmo.7rVD2tSJaD0EOiqEgSnACmdhbmWQcZ.cGxX3Mg.cAkyq', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (60, 'Pendi Susanto', '2', 4, '668749120034000', '', 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'JL KAMPUNG UTAN, 36, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '668749120', 'pendisusanto907@yahoo.com', '$2y$10$U5ofMsT98WfIiaxpFU74Ie2IcG1YtyygWd0hrz.26BQzp.uWWUM.C', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (61, 'Silvia Listiani Limanto', '2', 4, '633705165034000', '', 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '081289020181', 'silvialistianilimanto@gmail.com', '$2y$10$ZfINTlII8n1cxtpdLi.3XukOUqLmso10h4iuh.8gmu.uIhXGpv/gq', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (62, 'Sukarsanto', '2', 4, '243701620034000', '', 'Cengkareng', 'Ika Kusumawati', 'K/3', 'JL RAYA KAPUK GG EMPANG, 3, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '087883803880', 'sukarsanto_css@yahoo.com', '$2y$10$BuNpaLjt8rPYTBLQKjI62.Sov2vqUbV07kXj5fpfBnABkYhL3bUIm', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (63, 'Lioe Leosando', '2', 4, '278279468034000', '', 'Cengkareng', 'Genis Anggraeni', 'K/2', 'JL WARU III, 14, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08129966364', 'lioeleosandoo@gmail.com', '$2y$10$GlMHjPjFE0FNRkTWlNGdF.9koynVD92Ow8Jkss2XEXXBCS10D/RrC', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (64, 'Harya', '2', 4, '478624356085000', '', 'Kalideres', 'Crisanto Adi Maria Listyanto De Carvalho', 'TK/0', 'TAMAN KENCANA BLOK D KAV.9 NO.5 NO 5 RT.001 RW.14, JAKARTA BARAT, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '', '082112660987', 'harya1919@gmail.com', '$2y$10$2i2BIOwa5kEZhvCSWwoWZu.Q09EZP3bm2llorNRHhLRNuViriWVOe', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (65, 'Ronny Halim', '2', 4, '067232728085000', '', 'Kalideres', 'Tono Supriyono', 'K/1', 'PERUMAHAN CITRA 2, A 5, 12 A, PEGADUNGAN, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11830', '', '5445053', 'ronnyhalim19@gmail.com', '$2y$10$VIKEPqV1OM.otM/rNW8ATe3Qfep3eOk0TnXnC/rN0/QlUE9kPVZam', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (66, 'Suharta Riyanto', '2', 4, '828292631085000', '', 'Kalideres', 'Erwanto Eko Prasteyo', 'TK/0', 'JL PRIMA UJUNG, A, 31A, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '', '08998947847', 'suhartariyanto@yahoo.com', '$2y$10$xs9CMoxzlhEodSBIdXRdqeYNezdmzfp97ARz8z.6AnxQsPq0dBMAO', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (67, 'Bambang Suhono Halim', '2', 4, '070437843044000', '', 'Pademangan', 'Ferri', 'K/0', 'JL PADEMANGAN II GG 29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '6281288518185', 'bambangsuhonohalim72@gmail.com', '$2y$10$uXQgEh5ME.6aM/ldCGFCWOyadJ0cPT2Ca0iFasw7z4HJBulL5j0iu', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (68, 'Daniel Halim', '2', 4, '538074576044000', '', 'Pademangan', 'Ferri', 'TK/0', 'JL. PADEMANGAN II  GG 29, 7, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '087879507490', 'halimmdaniel@gmail.com', '$2y$10$F8adQ3tNjnrgb6WJgpzjaOCrNil1q9D4LySeEIaJB/PJF84H.cmCG', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (69, 'Niki Halim', '2', 4, '742610801044000', '', 'Pademangan', 'Ferri', 'TK/0', 'JL.PADEMANGAN II GG.29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '0818756910', 'nikihalimm@yahoo.com', '$2y$10$3ifM/e7yt6H4lGBkHfccDO.ebHns1Qz1.tjJ5EARa/vwzXbwF1Sr6', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (70, 'Ricky Halim', '2', 4, '742610470044000', '', 'Pademangan', 'Ferri', 'K/2', 'JL PADEMANGAN II GG.29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '', '085814733150', 'rickyhalimm@yahoo.com', '$2y$10$q9QfgNJPIbiTJ.rm7TYISeGdhkmZOx1ptwOXzOuEP9O7pIDqKi93C', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (71, 'Sumanto', '2', 4, '042075085044000', '', 'Pademangan', 'Hamonangan', 'K/0', 'JL LODAN, 143, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '081283789850', 'sumantotjioe@yahoo.com', '$2y$10$BLc.M5sLVICj6.3clRz.6.KoAhWJb7zXKfDNW3O53nKKunGm4FxNS', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (72, 'Akin Sriwongo', '2', 4, '065792780041000', '', 'Penjaringan', 'Hari Isnawan', 'TK/0', 'JL JEMBATAN GAMBANG I, 26, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281219128119', 'akinsriwongo17@gmail.com', '$2y$10$xB7KrhpRAMvCkQHVsgZlOe2cHxBOdZUDF84d2lwooqhfnUxefr6pO', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (73, 'Alvin Wijaya Tie', '2', 4, '173572561041000', '', 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'JL JELAMBAR, 19, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '085216695811', 'alvintie@yahoo.com', '$2y$10$WcRuFMQq0PBcck0K57DLuuN1cbDwbYJogtHsH628bmocwMou/JoQ2', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (74, 'Eddy Chandra', '2', 4, '240139386041000', '', 'Penjaringan', 'Gani Syabani', 'K/3', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '082124656668', 'eddychan1919@gmail.com', '$2y$10$WZcwbUEnIIOCFDRj/y4MQ.rTapHPINH/ryTcBg11V7VToH09dXiq.', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (75, 'Hendra Wijaya Tie', '2', 4, '144331568041000', '', 'Penjaringan', 'Sandra Nurma Putra', 'K/0', 'JL JELAMBAR ALADIN, 16, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281287022829', 'hendrawijayatie@gmail.com', '$2y$10$okF4i.VlBZPNeWmVveM9K.yvTX6uds5AvX03gm2rXnxuv8Wy9rQ8.', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (76, 'Herman Wijaya', '2', 4, '064493224041000', '', 'Penjaringan', 'Sandra Nurma Putra', 'K/3', 'JL JELAMBAR ALADIN, 1K, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281291674728', 'hermanwijayapit@gmail.com', '$2y$10$JxhqmBBrtkDQmepQ0mFGr.4v7Ts6PObzp0/bWlxXu/nOT.huc4EGW', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (77, 'Lim Ngok Hong', '2', 4, '716689823041000', '', 'Penjaringan', 'Hari Isnawan', 'K/3', 'JL. KERTAJAYA IV, 20, PENJARINGAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14440', '', '0852181765255', 'limngok@yahoo.com', '$2y$10$O9VYcZmcp36mxbK3zOa/QeYjMXAwwpLTKDZSX9GnFDuMjcdk.cpgK', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (78, 'Sadikin Kuswanto', '2', 4, '073268245041000', '', 'Penjaringan', 'Devy Elvandary', 'K/1', 'TELUK GONG JL LUNDU 48, PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '-', 'dikisadikin19@gmail.com', '$2y$10$apQDS7xhhBU7zn31QS5WH.ExtdAYz03TqfFcps.B72bq1ZFcMgMX6', '2026-06-26 16:56:11', '2026-06-26 16:56:11');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (79, 'Tjhang Vivi Surianty', '2', 4, '725711873041000', '', 'Penjaringan', 'Gani Syabani', 'TK/0', 'JL E TELUK GONG, 174B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '622156949666', 'tjhangvivisurianty@gmail.com', '$2y$10$9uAdkEsakC.6TJNLkJ4iIO57TD.NewrT42Nb9lYPzsC9Wg9GRRYSK', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (80, 'William Wijaya Tie', '2', 4, '144330925041000', '', 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'JL JELAMBAR, 1, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6287884564101', 'williamwijayatie@gmail.com', '$2y$10$D658gk7HzdnBcrVWdyDE2eX6AKv8Jyo8NZYRkXbUYXbVC1x8J9DHm', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (81, 'Devlin Sukarto', '2', 4, '248302911047000', '', 'Pluit', 'Restu Rea Erlangga', 'TK/1', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '087789101118', 'devlinsukarto1997@gmail.com', '$2y$10$Lt0hn3dw3f92oTIu8GqSHedRjYzgZYij.c8OWocnX/2uWJOY/CBMO', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (82, 'Enrico Rusli', '2', 4, '962709838047000', '', 'Pluit', 'Ganendra Edo Satwika', 'TK/0', 'CAMAR INDAH, 7, 9, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '081296887420', 'enricoruslilie@gmail.com', '$2y$10$h/AZbig6e4nsaRCxCrrGxOgi/w/q3jDJm0vg5btXUGHZztqGpdMPa', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (83, 'Liong Koei Hwa', '2', 4, '071910723047000', '', 'Pluit', 'Restu Rea Erlangga', 'K/0', 'JL PLUIT SAKTI III, 41, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '081513136268', 'koeihwaliong@gmail.com', '$2y$10$soXL/SYGiWHd06Q6P07BjehM7A4byILssSIKf/3p1KmOd720OEh4K', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (84, 'Sammy Soetiono', '2', 4, '040862336047000', '', 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'JL PLUIT BARAT III, 3, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '0816885406', 'sammysoetiono@gmail.com', '$2y$10$.k4FGdvDF1Txr5ktLjnQluLHsGYThq293//t9MVDmKcEie0VMj6dS', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (85, 'Selvia Liliana S', '2', 4, '248185076047000', '', 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '087789101118', 'selvialilianaas@gmail.com', '$2y$10$7OMRUgQXWBukHPisLqBCP.kaiUvVdjIDRUByw/34sqkxAKAjhwPUy', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (86, 'Setiawan Widjaja', '2', 4, '276230976047000', '', 'Pluit', 'Prophana Labi Dautse Gayo Katama', 'K/1', 'JL MUARA KARANG BLOK I.7.U  NO.11-A, I, 11, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '08119849992', 'setiawanwjd19@yahoo.com', '$2y$10$/ndAFWZ0BRbqIlMzzlxZtuqvQjpuSQvi0YKMfQr9kmH3O248zro8G', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (87, 'Su Kai', '2', 4, '461844409047000', '', 'Pluit', 'Wisnu Febryanzah Prasetyo', 'TK/0', 'RUSUN BLOK G LANTAI II NO.13 RT. 006 RW. 009, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '081311648970', 'kaisu2311@gmail.com', '$2y$10$C3LRCBQLz4BXk6qeG6nCZecjPIBOJ4ChZnbnC1cUiPMSWJCgTq9qm', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (88, 'A Han', '2', 4, '594743379036000', '', 'Grogol Petamburan', 'Esther Theresia Orienta Simanjutak', 'K/2', 'JL MANGGIS I, -, 10, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '6281315815888', 'aahanhann@gmail.com', '$2y$10$mKU0nHEx9Dfzyj.SW3LdN.OI6V2Cl.7pwiZbWbWHFWHxJFe/tq97S', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (89, 'Anggip Lesmana', '2', 4, '062672209036000', '', 'Grogol Petamburan', 'Arum Kusuma Sari', 'K/0', 'TAMAN DUTA AMS JALAN PANGERAN TUBAGUS ANGKE, D 2, 26, WIJAYA KUSUMA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '', '081898128', 'lesmanaanggip17@yahoo.com', '$2y$10$k2do10TZBMguP8BsfwlIJOXcBRBdu3mU7csjg2H.H.tQgY.Rcsy92', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (90, 'Fen Limantoro', '2', 4, '061119467036000', '', 'Grogol Petamburan', 'Rumpaka Jati', 'TK/0', 'JL TANJUNG DUREN UTARA V / 6 RT 06 RW 03, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '08158825812', 'fenlimantoro47@gmail.com', '$2y$10$Fl6y/iNCRiLq7uS6ASHuOu7wnms69/XdMFUKt5RI6xqKQcCNAiexy', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (91, 'Iwan', '2', 4, '163773260036000', '', 'Penjaringan', 'Gani Syabani', 'K/2', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '6281310551977', 'iwanaja1994@yahoo.com', '$2y$10$FY/ZR5xma0facwImwVVqUODgZeU64WNgUW31t7FMewAoSLVoE75dG', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (92, 'Tjoeng Sje Ji', '2', 4, '096661558036000', '', 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/0', 'JL MANGGIS II, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '08161974011', 'tjongsje@yahoo.com', '$2y$10$Jy9H5cyc7elpw1V/.leu2.HT.eQWdmJzhN8vnrZa1lvsUNYS8xTN.', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (93, 'Andika Kartadinata', '2', 4, '456635721029000', '', 'Gambir Tiga', 'Sartika Faramelita Suherman', 'TK/0', 'JL. KH. HASYIM ASHARI NO. 54A RT. 003 RW. 001, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '08999901989', 'kartaandika35@gmail.com', '$2y$10$AHoupE95nqW17k20QBjFje933x0gBXp60lYQStK9IoA5AYjRhh6/y', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (94, 'Gimin Arifin', '2', 4, '069067239074000', '', 'Gambir Satu', 'Lisdyaningroem', 'K/2', 'GG KINGKIT IV, 18, KEBON KELAPA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10120', '', '081212129534', 'giminarifin@yahoo.com', '$2y$10$AbwKmVMeGgvPy0AT2CI/FeMpChyd/sIfK6F2PgnHNKFAjJbwPRmvK', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (95, 'Janti', '2', 4, '245090493028000', '', 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'JL. KEBON JAHE II NO.14 RT. 006 RW. 002, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '02194507303', 'janti0019@gmail.com', '$2y$10$kijW4U28oDFjYaLXMP4XJeGDWAvvswyOVfXvxeRj0Ljy5z3KUlPU.', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (96, 'Liana Hasanudin', '2', 4, '061855714029000', '', 'Gambir Tiga', 'Deni Dewi Anggraeni', 'TK/0', 'JL.CIDENG TIMUR NO.9, PETOJO UTARA, PETOJO UTARA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10130', '', '08159403998', 'lianahasanudi19@gmail.com', '$2y$10$38a1SAR9FRz7u/Wozo.Cve9ACi5JBMGdkDOXaoJZsHjd5hp6eALCe', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (97, 'Linawati Setiadi', '2', 4, '072272727028000', '', 'Gambir Dua', 'Tini', 'TK/0', 'JL PERSATUAN GURU, 18, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '081315133312', 'linasetiadi7@gmail.com', '$2y$10$n6wnM8uG6TSXuU6aa2mPIujLwkyw9GRZ9S9HdrGbz9LwJ6K0NdiN2', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (98, 'Nico Hartono', '2', 4, '251403846028000', '', 'Gambir Dua', 'Hendra Rahma Wiguna', 'K/1', 'JL. KEBON JAHE II NO.14 RT.006 RW.002, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '62215655526', 'nicohartono67@gmail.com', '$2y$10$1vZHTVZIlXyeXyPjsVX0ae1onJb5.G16GfPuTPOzi9PDg38y4w3ue', '2026-06-26 16:56:12', '2026-06-26 16:56:12');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (99, 'Rudy Soetanto', '2', 4, '041834318028000', '', 'Gambir Dua', 'Tini', 'K/0', 'JL PETOJO SELATAN IX, 2, CIDENG, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10150', '', '0816925412', 'rudysoetanto73@gmail.com', '$2y$10$9B/eW7EN1RheQ8nBu1DIsegCK2R2niOHTTjulqLmLfXaMTh3FsBJq', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (100, 'Surya Kartadinata', '2', 4, '041335480029000', '', 'Gambir Tiga', 'Annisa Perwitasari', 'K/0', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '628999031463', 'surya.k18@yahoo.com', '$2y$10$EQCZY/78NzAj77U2HeFNDu0W2nb5uEWrUhJEDQRRSBr94Na57xamG', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (101, 'Efendi Narzudi', '2', 4, '277726204043000', '', 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'JL PELEPAH ELOK IX, GF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '0818983853', 'efendinarzudi@yahoo.com', '$2y$10$pi3Tr/gXmeaAxoNk2VoyKu6G0VgaIsIMm7kDuFlXQxhscOhXjVm9.', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (102, 'Herry Limantoro', '2', 4, '095845632043000', '', 'Kelapa Gading', 'Sayyidah Tahirah', 'K/1', 'PERUMAHAN BUKIT GADING MEDITERANIA, E A, 2, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '62213849217', 'herrylimantoro99@yahoo.com', '$2y$10$UxkS.ox3EZlz7mGJMnrbpOj0PDlFhoCkwMe12yE/uDyJo/gT6IACO', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (103, 'Linda Tjahyadi', '2', 4, '063481642043000', '', 'Kelapa Gading', 'Dodhy Candra Saputro', 'TK/1', 'JALAN GADING NIRWANA V, PF 10, 10, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '', '081586607397', 'lindatjahyadi19@yahoo.com', '$2y$10$olSvKIXDIr3LK9S38UwizuLj7c7ovIvZqzIDdxEORyXZBYkJXfjJa', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (104, 'Ruby Narzudi', '2', 4, '581212636043000', '', 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'JL PELEPAH ELOK IX, QF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '0881010622198', 'rubynarzudii@gmail.com', '$2y$10$z8WYiTJXIfSYCI4BGIJDceM85IoT0EvJszca8dvXKvzrnJS/OeHFO', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (105, 'Tjoa Hadi Lukmanto', '2', 4, '068010131043000', '', 'Kelapa Gading', 'Sri Rahayu', 'K/1', 'JL KELAPA NIAS VI, PB 13, 18, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '', '0816714677', 'tjoahadi@yahoo.com', '$2y$10$z1PM080JlwVjOlFCohvuWOZiWhrhXBmlHEZXyJeUB7VUqZ2Ukeh16', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (106, 'Lucy Sastroamidjoyo', '2', 4, '719922064048000', '', 'Tanjung Priok', 'Prima Wallesa Palo', 'TK/0', 'JL.  AGUNG  TENGAH  4-I, 1, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '', '6281213998813', 'lucysastro1919@gmail.com', '$2y$10$.rcu9iTKyY8j9F6Ao4MWluTBvn5zfUFd5OYRVqGRRYR3MaHGIJ2GC', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (107, 'Temmi Sandjaja', '2', 4, '253897466048000', '', 'Tanjung Priok', 'Toni Murdoto', 'TK/3', 'JL AGUNG UTARA XV, A13, 7, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '', '08128537899', 'temmitemsand19@gmail.com', '$2y$10$vbiVE5F5cnnyvmnjH4hQw.aN/HPANaqDCSig.Vf.D9ySaP0MJho8G', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (108, 'Ali Chandra', '2', 4, '095327383015000', '', 'Tebet', 'Nurkholis Rafsanjani', 'K/2', 'JL BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '', '6287882550888', 'alichand1919@gmail.com', '$2y$10$LLjhfXiB44REFlIx3bPxbuK/VantzltnyPysHASAJzfJtAwPGecT2', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (109, 'Eddy Zonder', '2', 4, '063368476015000', '', 'Tebet', 'Nurkholis Rafsanjani', 'K/0', 'JL MESJID BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '', '0816836500', 'eddyzonderr@yahoo.co.id', '$2y$10$5VmCdHRSA0pblM/Bij.wS.o5GKRkuiUou51DIHGZNOJN4m2BnOqfi', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (110, 'Tjo Kim Tjai', '2', 4, '075815241015000', '', 'Tebet', 'Rafike Dwi Alvadita', 'TK/1', 'JL.TEBET BARAT, TEBET BARAT, TEBET BARAT, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12810', '', '081932776687', 'tjokim@yahoo.com', '$2y$10$z00.SDCfHWQ7AyMi0EO7luwLEg2Qwy2j./Wyz1TkfzHH/QSdUnEyS', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (111, 'Hardi Winarta', '2', 4, '065506537016000', '', 'Cilandak', 'Rudy Priambodo', 'K/3', 'JL.PURI MUTIARA RT.007/01, CIPETE SELATAN, CIPETE SELATAN, CILANDAK, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12410', '', '081388664303', 'hardiwinata184@yahoo.com', '$2y$10$ESlBeUVf6/7orVgXtHV0uuyWhJ6A59EgzdDE86I3XJGjqRZxZ8iqe', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (112, 'Dicky', '2', 4, '369266408008000', '', 'Duren Sawit', 'Linda Ella Sari Br. S. Maha', 'K/1', 'JL DELIMA RAYA, IX, 1, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '', '62216697035', 'dickyki69@yahoo.com', '$2y$10$c05cLijeDXHOQIvBblw.O.gHKJXgIJHp4rP3xS4y2QJC7YxySesJW', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (113, 'Lim Hidayat', '2', 4, '070521471008000', '', 'Madya Jakarta Timur', 'Heru Waskita', 'K/2', 'JL.DELIMA RAYA, 5D, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '', '62811198521', 'limhidayat47@gmail.com', '$2y$10$aqc7t5H9KhMs.C//RW.nTe40kcno9bmOsRqUqjDmFspLNaMbEdu7m', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (114, 'Andri Janto Sudjoko', '2', 4, '076425081031000', '', 'Palmerah', 'Oliver Francois Tambunan', 'TK/0', 'JL. U NO. 31, SLIPI, SLIPI, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11410', '', '0218296579', 'andrijanto96@yahoo.com', '$2y$10$KsRpq8NQZzsilH8/PmkdBOB9M402XzZrwyq6HIjDSftlPeQ06P0mO', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (115, 'Sunardi', '2', 4, '076412204031000', '', 'Palmerah', 'Diah Kartika Retna Asih', 'K/3', 'JL H SALEH, 28, PALMERAH, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11480', '', '085692129168', 'sunardi2342@yahoo.com', '$2y$10$gO0BwYcvn4F5IyC2BDE0SOMHtHlz1UhXd2gCaiuairYZkBz383H6G', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (116, 'Tjio Suhendra', '2', 4, '076100213023000', '', 'Senen', 'Muchamad Fakhrudin', 'K/1', 'PLAZA ATRIUM LT.V BLOK C-64, SENEN, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '', '081285763362', 'tjio1919@yahoo.com', '$2y$10$GFqilgNx3PDfeC6IHDbuw.kLrzklgRup4cbDpZQJr1LM1Mba2J9oC', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (117, 'Kasim Tukimin', '2', 4, '076100809023000', '', 'Senen', 'Muchamad Fakhrudin', 'K/1', 'ATRIUM PLAZA LT.V, C.77, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '', '081382777199', 'kasimtukimin199@gmail.com', '$2y$10$ofH4ZCna1oHkMi0l3GDkTON7nPgsVhAOPCEWnPX5E7kvHrO9wzn/i', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (118, 'Agung Sutanto', '2', 4, '091936088402000', '', 'Tangerang Barat', 'Gede Suarsana', 'K/0', 'JL.MERPATI RAYA D17 NO.9, GEBANG RAYA, GEBANG RAYA, PERIUK, KOTA TANGERANG, BANTEN, 15132', '', '0881010622198', 'agungsutanto929@gmail.com', '$2y$10$l4f00EfI.egVRWKFCJt0mOqQrMd616iK371YQaNiEq6tMdjj15Boy', '2026-06-26 16:56:13', '2026-06-26 16:56:13');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (119, 'Foeng Fi Min', '2', 4, '076525633416000', '', 'Tangerang Timur', 'Arni Ardiyanti', 'K/0', 'BUDI INDAH, JL KELUD II BLOK A.1 NO. 26 RT 006 RW 07, PORISGAGA, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '', '6281218814902', 'foengfimin8@gmail.com', '$2y$10$RbgwVhUdQWy7yrltg81UgeEJlSQXIHMmLk0ge5V7C.In.3Qj/ea9m', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (120, 'Yulisna Kohar', '2', 4, '256064957416000', '', 'Tangerang Timur', 'Tri Bekti Utami', 'TK/0', 'BANJAR WIJAYA B.19B/31 RT. 004 RW. 15, PORIS PLAWAD INDAH, CIPONDOH, KOTA TANGERANG, BANTEN, 15141', '', '08121588282', 'yulisnakohar@gmail.com', '$2y$10$OGsE49sbjTXugI7OaRVgIuqtbuQ1JPL/a3Q.tfhnYj3xr6x50JVg2', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (121, 'Antonius Sugiarto', '2', 4, '041528902072000', '', 'Tanah Abang Dua', 'Hidayat Imam Bayu', 'K/0', 'JL KEBON JATI, -, 2, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '', '628161923006', 'lijinantonius19@yahoo.com', '$2y$10$1xcX3/rVvo2ThRVi/RyiXuohI1YebUu3RWwrazYuJzLY21zbJltsW', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (122, 'Udji Djohan', '2', 4, '076278837026000', '076278837026000', 'Sawah Besar I', 'Handita Kusuma Dewi', 'K/2', 'JL.P.JAYAKARTA BUDI RAHAYU I NO.42 RT.005/009 MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '087788238982', 'djohanudji@gmail.com', '$2y$10$esl237dKGuB/D/d2hZBCAODtmoTdTpweoYn.SnxMMVp5yR1uFkmPC', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (123, 'Udji Djohan', '2', 4, '076278837043001', '076278837026000-076278837043001', 'Kelapa Gading - Cabang', 'Abdul Hakim Amin', 'K/2', 'JL. ARTA GADING SELATAN, B6 LT. 1, 22, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '087788238982', NULL, '$2y$10$0/B1NozvnlLYIbFl9qOMkOz2amuEOoNMRz85FHRjSbiIdwylZn6Te', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (124, 'Udji Djohan', '2', 4, '076278837044001', '076278837043001-076278837044001', 'Pademangan - Cabang', 'Dhimas Fery Agung Prabowo', 'K/2', 'ITC MANGGA DUA LANTAI 3, BLOK A, No. 96, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '087788238982', 'udjidjohann@gmail.com', '$2y$10$CQnRDZGal3mw6D0rDtKkTOPQYQvmc7hbxiQ6/ma1QNjJzAG9FATrS', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (125, 'Koe Sevina Octricia', '2', 4, '711333575036000', '', 'Grogol Petamburan', 'Oryza Aprilia', 'TK/0', 'TANJUNG DUREN DALAM, VII, 14, TANJUNG DUREN SELATAN, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '081932007325', 'koesevina19@gmail.com', '$2y$10$Bbhkgfc3d8TAp4CYYAqEq.qqFZ.q7/hTHY8kpNsxhLU9Z0SxyDn6y', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (126, 'Koe Sevina Octricia', '2', 4, '711333575032001', '', 'TamanSari - Cabang', 'Mauridatul Hany', 'TK/0', 'BUNI, 25, MANGGA BESAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11180', '', '6252744', 'koesevina@gmail.com', '$2y$10$iLtW2lgOL/ZYvlPogKD8u.oOybgv.C14CWk8myEly8JAO6TtuBHua', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (127, 'Olivia Ione Rafin, JD', '2', 4, '071067938047000', '', 'Pluit', 'Hendri Wibisono', 'TK/0', 'KAPUK KAMAL, KAMAL MUARA, KAMAL MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14470', '', '021235700012', 'OLIVIAiONERAFIN@YAHOO.COM', '$2y$10$7Q/b4jVwApECY3Z/DFT1ceiBXdSyoO6KhlGRfiD6h08z4XTMOUjwq', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (128, 'Olivia Ione Rafin, JD', '2', 4, '071067938072001', '', 'Tanah Abang Dua - Cabang', 'Wihandoko Wihandono', 'TK/0', 'PASAR REG.TANAH ABANG BLOK A LT.LG LOS C NO.066-067, KAMPUNG BALI, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '', '235700012', 'OLIVIAIONERAFIN2@YAHOO.COM', '$2y$10$qnm/OdYjlyUzLqijMZaJUeuhnZCjLUxOkT2NcSVpWQcmiq0Sx1fo.', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (129, 'Safina', '2', 4, '070469572048000', '', 'Tanjung Priok', 'Japlis Windiyono', 'K/0', 'JL SUNTER GARDEN, BLOK D.8, 2 E, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '', '0816775569', 'finasafina1922@gmail.com', '$2y$10$Htan2s.GqcytZXDL5THkreyG1fiGZsP/jS2K4HcQW8S4eomJQHoDK', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (130, '-', '2', 4, '070469572044001', '', 'Pademangan - Cabang', 'Benedetta Krisna Wicaksana', 'K/0', 'PUSAT GROSIR PASAR PAGI MANGGA DUA LT. 4 BLOK BA NO. 113A, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '081380137369', 'safinafin@yahoo.com', '$2y$10$7/l5HlXi/PLrpG2Qqb4Ts.ApHSadp386PUdIgQByMEV9S..SII2GS', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (131, 'Sindjaja Jonany', '2', 4, '066512245047000', '066512245047000', 'Pluit', 'Ganendra Edo Satwika', 'K/3', 'JL WALET INDAH I, 21, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '628158007621', 'sindjajajonany8223@yahoo.com', '$2y$10$TiHrCHtFHPvNK/zWRT/z2.gGxTO0YnZv4.03TLcXQC9FapE048ZHG', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (132, 'Sindjaja Jonany', '2', 4, '066512245044001', '066512245047000-066512245044001', 'Pademangan - Cabang', 'Benedetta Krisna Wicaksana', 'K/3', 'PS. PAGI LT. SEMIBASEMENT BLOK, ANCOL, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '0817881156', 'sindjajapspagi@yahoo.com', '$2y$10$wIVENMcQtiWW1b98WANSM.rPgxOtLznyFXKGvZRvyDnK/LVZ55YNq', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (133, 'Sindjaja Jonany', '2', 4, '066512245044002', '066512245044001-066512245044002', 'Pademangan - Cabang', 'Dhimas Fery Agung Prabowo', 'K/3', 'TC MG.DUA LT.3 BLOK A NO.3, ANCOL, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '6281580007621', 'sindjajaitc@yahoo.com', '$2y$10$P4zliOzYLChVXFgSb/bfLegcYH2r4QlsFfnOWNBWjWcdoP5Y/zO3m', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (134, 'Teng Kim Sui', '2', 4, '063628226026000', '063628226026000', 'Sawah Besar Satu', 'Narita Ismi Amalia', 'K/0', 'JL PANGERAN JAYAKARTA NO 46, D, 15, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '081295439081', 'tengkimsui@yahoo.com', '$2y$10$jGbNH2TJDflBwWt9FYSvN.d7D6VsIC/B0Hykwkz0HuSJd/HiTSl.e', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (135, 'Teng Kim Sui', '2', 4, '063628226023002', '063628226026000-063628226023002', 'Senen - Cabang', 'Muchamad Fakhrudin', 'K/0', 'PLAZA ATRIUM SENEN LT 5 NO C 72, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '', '0216287864', 'tengkimsui2@yahoo.com', '$2y$10$6WVhjvL3Tbo37LL/DDL2qOxw3r7rPa/j31RGsC3oN/T9CS8BxnId.', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (136, 'Tjong Kian Tjoeng', '2', 4, '068139740075000', '068139740075000', 'Sawah Besar Dua', 'Lince Ani Fransiska', 'K/0', 'JL KARTINI IV DALAM, 179, KARTINI, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10750', '', '08161827632', 'tjongkian7@gmail.com', '$2y$10$mpxBwJZzZNCvVncTfIfgzeGSvl4k9ks2WLgP1oVXWEs3TN0V9Vj82', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (137, 'Tjong Kian Tjoeng', '2', 4, '068139740026001', '068139740075000-068139740026001', 'Sawah Besar Satu - Cabang', 'Yuan Robi Arta', 'K/0', 'MANGGA DUA MALL LT.I NO.4A, MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '62216127972', 'tjongkian2@yahoo.com', '$2y$10$GoB41n3YzaGgrrDrmwgfTu/5TlaMGGB7dzJlszZ5sf1dvjmLbbpEe', '2026-06-26 16:56:14', '2026-06-26 16:56:14');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (138, 'Christine Yuliani', '2', 4, '738759299952000', '', 'Jayapura', 'Tan Christian Nathanel Budiman', 'TK/0', 'JL. PERIKANAN, 26, HAMADI, JAYAPURA SELATAN, KOTA JAYAPURA, PAPUA, 99126', '', '082399944445', 'dr.christineyuliani@gmail.com', '$2y$10$1HlnDMK7j7TdSsfUniXRPe6CL9W6X60xn7mNYkf4xTU0jhC3DDdgq', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (139, 'Dely', '2', 4, '594551871033000', '', 'Tambora', 'Rizki Ilham Akbar', 'K/2', 'JL KRENDANG TENGAH I, 86, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '0216296149', 'dely191919@gmail.com', '$2y$10$WBsRUn3HpAIp7cBCj0TlL.eASjf7HCtzsPDl2/kofnvq3trep8wzW', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (140, 'Devi', '2', 4, '790794184033000', '', 'Tambora', 'Anung Prasetyo Dwijayanto', 'TK/2', 'JL.JEMBATAN BESI II NO.20 NO 20 RT.008 RW.003, JAKARTA BARAT, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '628111988583', 'devimargalou@gmail.com', '$2y$10$OL23ydd6QZYiQ5X5UgVoOe1X7zwSrNVfQxTzGwyM1t1ALNX0wGHOe', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (141, 'Dicky Wirayadi Hadipurnama', '2', 4, '064691512033000', '064691512033000', 'Tambora', 'Riska Septiana Estutik', 'K/0', 'JL GG. TOGE NO.7, 7, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', '30/03/2023', 'dickdicky1920@gmail.com', '$2y$10$o9KtIFN4H5UR3KCBruPvke1k1h.6gO4ctYKV0IY3N2l..dstAOkoi', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (142, 'Dicky Wirayadi Hadipurnama', '2', 4, '064691512037001', '064691512033000-064691512037001', 'Tamansari', 'C. Wahyu Triwibowo Arikadi Putra', '', 'PASAR PAGI ASEMKA LT. BASEMENT, B174/175, PINANGSIA, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11110', '', '087882550888', 'dickywiryadihadipurnama@gmail.com', '$2y$10$gR5LHfejw5TX/V04ErRGNu.GIaQpAEnacx3e3QJF8qYJblbY3WRkm', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (143, 'Dicky Wirayadi Hadipurnama', '2', 4, '064691512037002', '064691512037001-064691512037002', 'Tamansari', '', '', '', '', '', NULL, '$2y$10$VCK17pY9J9tJulPk3T1ogOyAdNdxP3i0kcqS1vCr4txyTgk7k9DWa', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (144, 'Eric Saibun Yolinta', '2', 4, '066255183036000', '', 'Grogol Petamburan', 'Zulmy Agung Pambudi', 'K/0', 'JL JELAMBAR ILIR, 22, JELAMBAR BARU, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '', '62818981218', 'ericsaibunyolinta@gmail.com', '$2y$10$OYkDN73o.tRvHTUFEtJ5SezX6fi4GbR0oe7QA7Keu9zZK5VSrXJm.', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (145, 'Fariak Sugianto Ng', '2', 4, '064354178033000', '', 'Tambora', 'Wursito Atik', 'K/1', 'KP.KRENDANG BARAT RT.006/04, KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '', 'fariaksugianto@gmail.com', '$2y$10$BdA5wAasCdUZqcY1v5sNP.trp6i6b37RQV6qMMZJqegHFSdrGnH6S', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (146, 'Feliciana Kartadinata', '2', 4, '601410541029000', '', 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '081286688869', 'felicianakartadinataa@gmail.com', '$2y$10$tQqtGMShDaTe5nZsuRxB7uSFrtGiOwZt/6jOKsw0BHQeFe..4PdBC', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (147, 'Gouw Keng Hoa', '2', 4, '609298583033000', '', 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'KP KRENDANG, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '081296988658', 'gouwkenghoaa@gmail.com', '$2y$10$8sDwdlfPLJ3gq1Jc41eiFuQlenOCvGz92nmODURyWkYxld7Tvow9G', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (148, 'Gunawan Widjaja', '2', 4, '769809096026000', '', 'Sawah Besar Satu', 'Muhammad Ismail Marzuqi', 'TK/0', 'JL MANGGA DUA ABDAD C, 50, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '085881389934', 'widjajagunawan0@gmail.com', '$2y$10$o2nn1bFkVjSiA6rqG2vymOhZFB6SzPzfYWfmMsLU2GKdMZ.PaLyG2', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (149, 'Handy Tjahyadi', '2', 4, '065196412043000', '', 'Kelapa Gading', 'Lesty Phytaloka', 'K/1', 'JL GADING KUSUMA, GK 8, 2, KELAPA GADING TIMUR, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '62813065196412', 'handytjah19@yahoo.com', '$2y$10$rVUTNCwHdZbaE18IbblBXec4IFf89tjiPwcCG.zx.7oate.0Nrunu', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (150, 'Haryono Kuswanto', '2', 4, '064493083041000', '', 'Penjaringan', 'Gani Syabani', 'K/3', 'JL TELUK GONG BLOK N3/48, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '628161162915', 'haryonokuswanto99@yahoo.com', '$2y$10$XZLQIMq6CG3HUcmkjFO.t.qRIcrps8LySnTXy9Qn1BhetOHB0Smay', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (151, 'Hauw Bok Soei', '2', 4, '594790560033000', '', 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'JL SONGSI RAYA, 22, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '6281215882824', 'hauwbokk@gmail.com', '$2y$10$3Yu2/fq7y3AaQ2XXpftPUOuzsUtk8g5LdHGPpUeel0hYMgwPwoHYS', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (152, 'Hendra Koesnandar', '2', 4, '594688335033000', '', 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'JL KHM MANSYUR NO 30B, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '62216909747', 'KOESNANDARHENDRA@YAHOO.COM', '$2y$10$TVK0WnpLSYdTAFWDe9vSMeLcpmwd2iKjfz.JzIVd9FSjjecRsoltC', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (153, 'Hendrik Koesnandar', '2', 4, '594688319033000', '', 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'JL KHM MANSYUR, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '08161891575', 'henrikoesnandar@gmail.com', '$2y$10$kfGknePzF55SFBdvBovmNOOdHTsxgiG80XhydHlTxC/jISkt6MduO', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (154, 'Hongdoras Limantoro', '2', 4, '065882946039000', '', 'Kebon Jeruk Dua', 'Bondan Himawan', 'K/0', 'KOMPLEK GREEN GARDEN BLOK, A5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '08128015571', 'hongdoraslimantoro@gmail.com', '$2y$10$LahjNqDupUBC8oi6qkm8p.TWXamQePg9MSUu/OTDlh3HKZhMMpg7e', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (155, 'Iman Sumar', '2', 4, '096856315071000', '', 'Menteng Dua', 'Rinawati', 'K/1', 'JL SURABAYA NO.19 PAV, MENTENG, MENTENG, MENTENG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10310', '', '08129899116', 'drg.imansumar@gmail.com', '$2y$10$/JA6GVexcfI.2xD30SCp8.Mip8bNwq27zxLBlXm7psBKj37btDvYO', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (156, 'Indra Gunawan', '2', 4, '800629834033000', '', 'Tambora', 'Dian Setyawan', 'K/1', 'JL. ANGKE JAYA VI, 1, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '628999904718', 'Test.slave888@gmail.com', '$2y$10$9aJTKn9R/Mw.f.l510bdVuoXq7ULVY9dWXBkO.pyRiTEqGusYw3Iy', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (157, 'Indriany', '2', 4, '768517708029000', '', 'Gambir Tiga', 'Suci Lestari', 'TK/0', 'JL DURI A II, 1, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '08159064396', 'indrianyny@gmail.com', '$2y$10$ikOB8lhH1iGWz5mhvQthB.Kg/COCllbu9Cdpya/nKS68g4feRp6fS', '2026-06-26 16:56:15', '2026-06-26 16:56:15');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (158, 'Jimmy Tirta', '2', 4, '768341000047000', '', 'Pluit', 'Endang Suwarni', 'K/0', 'TAMAN GRISENDA, B1, 75, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '6285379009099', 'jimmytirt@gmail.com', '$2y$10$0JTXqNKoLHg1EXpXwSBC4.95D0mCm9mv0l4cd8se8.D0T9UcDS2Q.', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (159, 'Johny Tjahyadi', '2', 4, NULL, '', 'Senen', 'Rachma Hidayanti', 'TK/0', 'JL.KALIBARU TIMUR V, 54L, BUNGUR, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10460', '', '081932807313', 'johnydeep1919@gmail.com', '$2y$10$vFTsZn60ZGUU24zVJdoueexQP.NeylyPYBqMO4cIiUFKm0N7Bt64O', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (160, 'Jong Khim Wong', '2', 4, '076523497033000', '', 'Tambora', 'Dian Setyawan', 'TK/0', 'JL.SAMARASA III NO.20, ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '', '6281806886366', 'jongkhimwong@gmail.com', '$2y$10$mEfIwW0s6X99xodXHO9JYuWnWrgcAAZ8TfJunHUVyel0B6ldEW/bW', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (161, 'Jong Pin Njuk', '2', 4, '182805630033000', '', 'Tambora', 'Arum Pawestri', 'TK/0', 'KP DURI DALAM, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '0216342728', 'jongpin171@gmail.com', '$2y$10$v4S00O0A6ZqYS9cS4SpJvOhn6fwywB4Arp9GWeaC30Ptiq/Lb07dq', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (162, 'Kelvin Yohannes', '2', 4, '423242254416000', '', 'Tangerang Timur', 'Arni Ardiyanti', 'TK/0', 'KELUD 2, A1, 26, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '', '081290326683', 'kelvinnyo94@gmail.com', '$2y$10$mdEX6KtbMVGUscXtXqo5O.EEBnUwZczrfJR81J19c6bUuIGbRUkZW', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (163, 'Kok Siu Jin', '2', 4, '062674288033000', '', 'Tambora', 'Dian Krisnasari', 'TK/0', 'JL. KHM. MANSYUR NO.30-B, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '081283789850', 'koksiujin@gmail.com', '$2y$10$40Q27j0RO3vnESMp2s9u2OUOVVMUjeJqGar1hyrOA8Y.aVJBCqZz6', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (164, 'Lanny Halim', '2', 4, '768859340037000', '', 'Tamansari', 'Yudo Wahyu Asmoro', 'TK/0', 'JL.KERAJINAN, 24, KEAGUNGAN, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11130', '', '62081281981513', 'lannyhalim19@yahoo.com', '$2y$10$bhJl.3IREnyRBo8eenvfDecBzw69yfv/lAHlIc6LKtj6hzYvEKtWu', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (165, 'Lee Hak Man', '2', 4, '259861037413000', '', 'Cikarang Selatan', 'Isrofah Wijayanti', 'K/2', 'L. MH. THAMRIN B-16 LIPPO CIKARANG RT. 000 RW. 000, CIBATU, CIKARANG SELATAN, KAB. BEKASI, JAWA BARAT, 17855', '', '622189920692', 'aditsgusti@gmail.com', '$2y$10$OPxbfDEiaIuBwJZrW68CH.DzcPCFQTFa2ntbI0Ex1Zi/JKHGRueja', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (166, 'Lenny Diana', '2', 4, '612036046036000', '', 'Grogol Petamburan', '', '', '', '', '0816775569', NULL, '$2y$10$Wgo2wf9miOfpBGjW9ZyjgOOqXSMQIOm2HI8cOOZCagZxqNkM/nko6', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (167, 'Lim Tiong Kie', '2', 4, '061882171033000', '', 'Tambora', 'Rizki Ilham Akbar', 'K/0', 'JL KP KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '', '0816470907', 'tiongkiel@gmail.com', '$2y$10$mQwfzKaLdU2mvV8AyHt87u6Ir8zEjh5uB1NU.dmne/snD7.kKW4ym', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (168, 'Liswati Widjajakusuma', '2', 4, '594947954086000', '', 'Kembangan', 'Nurhadi Eko Waluyo', 'TK/1', 'KOMPLEK TAMAN ALFA INDAH, B3, 12A, JOGLO, KEMBANGAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11640', '', '6281808003646', 'Liswatiwk67@gmail.com', '$2y$10$rTio56OmekgHzslVOLLLK.mnyHTYiJW0SeXfATM413Af68LtDSBB6', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (169, 'Martin Raditya Sugiarto', '2', 4, '585219488033000', '', 'Tambora', 'Arum Pawestri', 'K/0', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '6282117706296', 'martinpajak0811@gmail.com', '$2y$10$rr4J9JF7bsJR6H8WOBM5pe4pRDPDPB70UY9mu5.2NXXRl4zF3yu3K', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (170, 'Melly Kurniawan', '2', 4, '095839684043000', '', 'Kelapa Gading', 'Gibran Kurniawan N', 'TK/0', 'APT CITY HOME, TOWER MIAMI BAY LT 1 NO. 11 RT 007 RW 019 KELAPA GADING BARAT, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '', '02168710485', 'melykurni99@gmail.com', '$2y$10$pzaD0.MyJ2nYgBflwe9IH.Yaq1UJRIsqOyQxvh33h31XJIpTXGsCa', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (171, 'Michael', '2', 4, '809973936036000', '', 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'JL. ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '6287808780871', 'bonifasiusmichael92@gmail.com', '$2y$10$ErvqmrOvjGi4B1z8OSx90.ZC7U0ZHcg9/dcUy7qmPo/sjKA/cBC.e', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (172, 'Mustar Abidin', '2', 4, '041331570036000', '', 'Grogol Petamburan', '', '', '', '', '', NULL, '$2y$10$5qLE1jalSzijNsXzjxToBOXu7aXHvQiQVb2QXTNfoUL6UgwcoWQAy', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (173, 'Oei Suriaty', '2', 4, '095270856015000', '', 'Tebet', 'Andri', 'TK/0', 'JL. TEBET BARAT NO. 67 RT.016 RW 001, TEBET BARAT, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12810', '', '6289692753614', 'oeisuriaty.tax@gmail.com', '$2y$10$EAPQ30DE3Otk.z3NUyilrO/28RtFUku4PIu1mimwdGA1utfF3LbIe', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (174, 'Puspa Dewi', '2', 4, '584261549033000', '', 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'JL ARABIKA NO.15, JAKARTA BARAT, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '0216922616', 'ohdewipuspa@yahoo.com', '$2y$10$Nmdj5j0wRnHQyoE2Tk87sO.BdNYEB8mLs/nfOrlvmoiFdjJrGlaBS', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (175, 'Rahman Halim', '2', 4, '076439231031000', '', 'Palmerah', '', '', '', '', '', 'rahmanhalimm21@gmail.com', '$2y$10$KRynkDa7LlT5Nu08uePrU.yv7QPEW.o3p8W4FYK2qyi5DwwD0s0v.', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (176, 'Rio Gunawan Sejati', '2', 4, '493304083028000', '', 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'JL KEBON JAHE II NO.14 NO 14 RT.006 RW.02, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '', '087886687898', 'rigunse@gmail.com', '$2y$10$Lhctx32OqyPu2FbnEjgAZus0PZ6A/9T9knwGyAaTbWMcvCbqhhtom', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (177, 'Rita Koesnandar', '2', 4, '594688343033000', '', 'Tambora', 'Dian Krisnasari', 'TK/0', 'KHM MANSYUR NO.30B RT.001 RW.002, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '0811145152', 'ritakoeskoes19@yahoo.com', '$2y$10$kXErjXOpucKU1QcUc7ysKOMDZFzK6zortIpnoV1BR2O4kNzFaK1FO', '2026-06-26 16:56:16', '2026-06-26 16:56:16');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (178, 'Rizal Kartadinata', '2', 4, '659705925029000', '', 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '', '6289636360091', 'rizalkartadinataaa@gmail.com', '$2y$10$2Skw/SlOemQWqfO4IblLEOzDeLy6zjfiucKvecAKzffkcFEbHqr9O', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (179, 'Ronald Russel', '2', 4, '550725881036000', '', 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'JL. ALPUKAT VII NO.4 RT.008 RW.002, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '081229922080', 'vincentsius.russell@gmail.com', '$2y$10$f8HGnVNcSgoS3tZdrbbXjeXOj.XDE8/5JdmW7alek8xPPCW0m4bG6', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (180, 'Rudy Susanto', '2', 4, '814779757033000', '', 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'JL PETAK SERANI III, 48, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '', '085311690052', 'rudysusaantooo@gmail.com', '$2y$10$pC1mh0CL.MD9HfJBLfC4bewHk.56aeTPhfduHtKhL/.7U0fmgOcG6', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (181, 'Sarianto Jony', '2', 4, '076524867033000', '', 'Tambora', 'Satriyo Dwi Yulisetyawan', 'TK/0', 'JL PENGUKIRAN RAYA NO.40 A, PEKOJAN, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '081385561767', 'sariantojony8@gmail.com', '$2y$10$IsNNLBOx1LHa8Ns9swM3l.rncoUxTRqnl7ZYzqCa.i2wGWsgf/t2.', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (182, 'Sri Mulyani', '2', 4, '390396901085000', '', 'Kalideres', '', '', 'PERUM PARK RESIDEN, C, 38, PEGADUNGAN, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11830', '', '0881010622198', 'SRIMLYNI1980@GMAIL.COM', '$2y$10$C7Rld.BZOcwvhPRGJso1f.SWhufLShzNshlD65WFzFjgNDnVlyJ2G', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (183, 'Suhendra Tirtaputra', '2', 4, '144329570041000', '', 'Penjaringan', 'Imam Taj\'ri', 'TK/0', 'JL JEMBATAN II GG PETASAN / 114 RT 004/002 PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '', '622166695306', 'suhendratirtaputra5@gmail.com', '$2y$10$yLLrMi5kFDEzhw5uuqQL5eBr9PaDEBjem4ZkC0XfzF7E/9diSnCE6', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (184, 'Sukim Hartono', '2', 4, '175850601033000', '', 'Tambora', 'Dhani Kristanti', 'K/2', 'JL KHM MANSYUR 217 RT.004 RW.002, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '', '08121931806', 'SUKIMHARTONO19@gmail.COM', '$2y$10$mh1Q73FoSkDM3p0UxT27P.f5xyupQn89fJGyMNFQRIYVkYuE8jIxu', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (185, 'Sung Njit Bui', '2', 4, '071338727034000', '', 'Cengkareng', 'Ikhwanussidiq Suhartono', 'K/0', 'TAMAN PALEM LESTARI B.I/A.9, CENGKARENG BARAT, CENGKARENG BARAT, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '081213174077', 'sungnjitbuiii@gmail.com', '$2y$10$n2WqOtDAhDS4261HiXsONuESgG8RV6//YXnFciKJ6EVd30bUbb/OW', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (186, 'Supriyono', '2', 4, '811965540034000', '', 'Cengkareng', 'Martua Halomon Sihombing', 'K/2', 'JL. PEDONGKELAN, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '085894279208', 'supriyonosuprii121@gmail.com', '$2y$10$NvYupdkUdlLot4UhuOt19.hmcyP1MBkzLwzoA7oWcgP5knbEO68tC', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (187, 'Tony Esrianto', '2', 4, '066258906036000', '', 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/1', 'JL ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '62811170029', 'tony_esriantotio@yahoo.com', '$2y$10$skxatxA0wo1BT0plZGqANObGyN8TRUTzzG28TeC/78DbjzF4vhP7K', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (188, 'Wong Song Moy', '2', 4, '584261556033000', '', 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'JL ARABIKA, 15, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '0216904724', 'wongsongmoy@yahoo.com', '$2y$10$7jcuLU2lnh4f7v7kek4CYe.JmCUUPTjUjxKNnAwZ/00GcmXetDCpm', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (189, 'Yessica', '2', 4, '421122813416000', '', 'Tangerang Timur', 'Moh Ikhsan Iskandar', 'TK/0', 'PERMATA RAYA, C2, 37, CIPONDOH MAKMUR, CIPONDOH, KOTA TANGERANG, BANTEN, 15148', '', '', 'yessica.chenyiping@gmail.com', '$2y$10$vO2n42by6ubLMnDc40HIwOOOAep3caNkvu04cDSFTUvOxdcZv7SXC', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (190, 'Tania Theresa Halim', '2', 4, '081777157903100', '', 'Palmerah', '', '', '', '', '', 'taniatheresahalim@gmail.com', '$2y$10$VK3ssyM7ewWdME6Ku5oO6OF4u/ml3wB1RP.WMZKK8JocOVJg6JLau', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (191, 'Joshua Jeremy Halim', '2', 4, '081777157903100', '', 'Palmerah', '', '', '', '', '', NULL, '$2y$10$pnSb14q/SLs4GBHD2GqjmuYeDS5fZuIh6pgGSelkgVNlusJvmXDF6', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (192, 'Liem Lies Rohana', '2', 4, '4280430200033000', '', 'Tambora', '', '', '', '', '', NULL, '$2y$10$e4qjcWkLmaWsYgB3ho7nhekKTsJgqwla.TkMyAqH/nKsgCE.j1csq', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (193, 'Sung Oi Jan', '2', 4, '3173045010740010', '', 'Tambora', '', '', '', '', '081213818778', 'oijan776@gmail.com', '$2y$10$QJDcPPXFH5BqiNPDBHBaU..HgAPKowZb4OJkVLfsTlHsGOHTFvzda', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (194, 'Felix Salm', '2', 4, '3173021802870004', '', NULL, '', '', '', '', '081213818778', NULL, '$2y$10$XFEcXHckabofbwOgFYKLz.wszyTMZtmMSM1Aj9/JrA2zFPIgsiCAe', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (195, 'CV. Anugerah Lestari Maju', '2', 4, '828123679047000', '', 'Pluit', 'Wisnu Febryanzah Prasetyo', 'NON PKP', 'JL.RAYA KAPUK MUARA, 9, KAMAL MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14470', '', '02155956827', 'cvalestari19@gmail.com', '$2y$10$YHSjiVseg9jpMe6rJJrl5emoQkt3yyj.yLQvuJyh1DqFOfcRXBJKO', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (196, 'CV. Beta Musik', '2', 4, '025667411032000', '', 'Tamansari', 'Ilham Syaiful Alam', 'NON PKP', 'PERTOKOAN RUKO GLODOK PLAZA BLOK F NO. 103, MANGGA BESAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11180', '', '082258555347', 'betamusikk@gmail.com', '$2y$10$a5V1oPffLFmJEPJWhPFOYORUwfYZATr8hrAWKvtWwU21NncOafgq6', '2026-06-26 16:56:17', '2026-06-26 16:56:17');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (197, 'CV. Bundaran', '2', 4, '914634241033000', '', 'Tambora', 'Ridwan', 'NON PKP', 'JL KH MOCH MANSYUR, 129, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '', '081315619996', 'bundarancv@gmail.com', '$2y$10$.q5ZwIMsOloTsA6CPBSuB.gs29sNXNmyPUTW7GSr4DhR1TpE5aWhC', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (198, 'PT. Cakra Lintas Nusa', '2', 4, '611296351034000', '', 'Cengkareng', 'Fia Aulia Nurbina', 'NON PKP', 'KOMPLEK RUKO CITYPARK BISNIS DISTRIK BLOK C2-12 TAMAN PALM MUTIARA, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '', '082124656668', 'cakralintasnusaa@gmail.com', '$2y$10$UT7x.2xCYi0FVTFm4zsTe.xXjjeWQUUvzobjh9DGrFB89cPbDluDK', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (199, 'PT. Citra Inti Pilar', '2', 4, '740877394085000', '', 'Kalideres', 'Adhitya Primadha Andi', 'PKP', 'RUKO KALIDERES MEGAH JL PETA SELATAN, A, 1, KALIDERES, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11840', '', '6221713689', 'CIP191220@GMAIL.COM', '$2y$10$61ag2fDSTVBOK83d2Rh5wOFhGoBVFG85ywcOA2uzBcUa1tBiW05W.', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (200, 'PT. HBI Incomindo Nusantara', '2', 4, '935185256036000', '', 'Grogol Petamburan', 'Fenti Eka Septina', 'NON PKP', 'JL TANJUNG DUREN TIMUR 6 BLOK I NO 431E, TANJUNG DUREN SELATAN, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '', '02156949333', 'HBIINCOMINDO@GMAIL.COM', '$2y$10$R099QysPTPDcIjSsg3YrDeFsNgcsAJC4hGP8X5wlUQ3Q/plNvBSHG', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (201, 'PT. Jaya Kreasi Tas', '2', 4, '828839860044000', '', 'Pademangan', 'Benedetta Krisna Wicaksana', 'NON PKP', 'JL PUSAT GROSIR PASAR PAGI MANGGA DUA LT 1 BLOK KA NO. 1 A, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '', '081212151471', 'jayakreasitas@gmail.com', '$2y$10$jRW6pMSBEP4e7go9lBPBTuHvnWdYQpxBdZIJ7Ym/rvzwXUwoGrahS', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (202, 'PT. Kharisma Indo Multi', '2', 4, '432822740039000', '', 'Kebon Jeruk Dua', 'Arumtyas Nugraheni', 'PKP', 'RUKO GREEN GARDEN, A14, 36, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '', '082260889909', 'deri.tjong@gmail.com', '$2y$10$TaFkaSjlJh/AM3Mjrd/J0umS2GVtmHlIq6VDmqlKpJtOtPx9VdIKW', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (203, 'PT. Lestari Giat Jaya', '2', 4, '017211509034000', '', 'Cengkareng', 'Puspa Ayu Wulandari', 'NON PKP', 'JL. PEDONGKELAN, 1, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '', '08158007131', 'lestarigj00@gmail.com', '$2y$10$dLTuDV8N9MJzyyygRtF5kuqc8pL23giuyFKXOuppw9WLSpaxuv/rC', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (204, 'PT. MG Dua Jaya', '2', 4, '027473420047000', '', 'Pluit', 'Ganendra Edo Satwika', 'NON PKP', 'JL PANTAI INDAH SELATAN I ST/D-A 12 PIK, KAPUK MUARA, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '', '0215882816', 'mgdua70@gmail.com', '$2y$10$xmSSCyM7NbjRgq/7Edj0GuVd/4EyNl6M3D5TowyOJNquPyW2UzJgC', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (205, 'PT. Tirta Agung Nusantara', '2', 4, '031652100026000', '', 'Sawah Besar Satu', 'Yuan Robi Arta', 'NON PKP', 'JL MANGGA DUA RAYA GEDUNG MALL MANGGA DUA LT 2, 25 B1, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '', '628128618000', 'tirtagungnusantara@gmail.com', '$2y$10$ArspLgmww5eMnKjgbkrV2.7CNFxWOd3FQXEYc/Z5EoehVuQ1OXzA.', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (206, 'Wihara Tilakkhana', '2', 4, '022936223033000', '', 'Tambora', 'Fibri Kurniawan Sunu', 'NON PKP', 'JL.ARABIKA NO.15, PEKOJAN, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '', '6922616', 'wiharatillakhana@yahoo.com', '$2y$10$nAtI3PG9rPtdeoJRUrcA/uT2zVjg9CBd58CTdX5Y9GHbjMQRDUO3y', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (207, 'Yayasan Kusuma Bangsa G. Baroe', '2', 4, '015818248032000', '', 'Tamansari', 'Senisa Selni Selena', 'NON PKP', 'JL.MANGGA BESAR IX NO.14 RT 13/01, TANGKI, TANGKI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11160', '', '626912460', 'ykbangsa19@gmail.com', '$2y$10$FR1NUZDVwVrpgzZhEEvI1.Es1L073txA3DGr838T.HTptIoEZg3Dq', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (208, 'PT. Dunia Selera Indo', '2', 4, '211123799413000', '', 'Serpong', 'Nugroho Kristianto', 'NON PKP', 'JL ALAM SUTERA BOULEVARD KAV.21, LIVING WORLD ALAM SUTERA, G-81, PAKULONAN, SERPONG UTARA, KOTA TANGERANG SELATAN, BANTEN, 15334', '', '081317704800', 'ajenfoodvill209@gmail.com', '$2y$10$rcZszZPxYl8ZUP08uya/9eq1QylkHP1blZkYDISc0YTy1GPKGIgSC', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (209, 'PT. Ajen Food Vill', '2', 4, '848041026452000', '', 'Tigaraksa', 'Santi Susilarini', 'NON PKP', 'SUPERMALL KARAWACI, UNIT LG, 39 A-B, BENCONGAN, KELAPA DUA, KAB. TANGERANG, BANTEN, 15832', '', '0215466666', 'dseleraindo@gmail.com', '$2y$10$hfE8pPqcjCi1ywfu5CwRXuEoPdjtFMlwO4AB3X0MsDCxY2eqic7aW', '2026-06-26 16:56:18', '2026-06-26 16:56:18');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
