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

 Date: 16/07/2026 14:00:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cms_activity_logs
-- ----------------------------
DROP TABLE IF EXISTS `cms_activity_logs`;
CREATE TABLE `cms_activity_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `module` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_activity_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `cms_activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_activity_logs
-- ----------------------------
BEGIN;
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (1, 1, 'logout', 'auth', NULL, 'User logged out: erwin.admedika@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-15 18:01:14', '2026-07-15 18:01:14');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (2, 1, 'login', 'auth', NULL, 'User logged in via 2FA: erwin.admedika@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-15 18:01:40', '2026-07-15 18:01:40');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (3, 1, 'logout', 'auth', NULL, 'User logged out: erwin.admedika@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-15 18:10:23', '2026-07-15 18:10:23');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (4, 1, 'login', 'auth', NULL, 'User logged in via 2FA: erwin.admedika@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-15 18:17:49', '2026-07-15 18:17:49');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (5, 1, 'update', 'data_client', '316', 'Updated data client: Sindjaja Jonany', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-15 18:41:06', '2026-07-15 18:41:06');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (6, 1, 'login', 'auth', NULL, 'User logged in: erwin.admedika@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-16 05:19:08', '2026-07-16 05:19:08');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (7, 1, 'create', 'user', '2', 'Created user: MITRAWAWPC1@GMAIL.COM', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-16 05:42:08', '2026-07-16 05:42:08');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (8, 1, 'create', 'user', '3', 'Created user: ccbbaaarsq@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-16 05:43:37', '2026-07-16 05:43:37');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (9, 1, 'create', 'user', '4', 'Created user: mitrawawpc8@gmail.com', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-16 05:46:15', '2026-07-16 05:46:15');
INSERT INTO `cms_activity_logs` (`id`, `user_id`, `action`, `module`, `target_id`, `description`, `ip_address`, `user_agent`, `created_at`, `updated_at`) VALUES (10, 1, 'create', 'lampiran_spt', NULL, 'Import Lampiran SPT client: Sindjaja Jonany tahun: 2026 — 9 rows', '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-16 06:14:43', '2026-07-16 06:14:43');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_data_client
-- ----------------------------
BEGIN;
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (195, 'Adhi Surya Winata', '3', 4, '3173042710930005', '730559523033000', NULL, 'Tambora', 'Pratama Yudha', 'K/1', 'Jl. Jembatan Besi 4, 15A, Jembatan Besi, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'JL. JEMBATAN BESI 4, 15A, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '083899034184', 'adhisuryawinata@gmail.com', '$2y$10$3mpQFkEIIQQCRXFEyeeCfei8o3S6jor4fp/JddbZol4lAn3OjF06.', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (196, 'Andrew Yuniarto', '3', 4, '3173042404870016', '076546605033000', NULL, 'Tambora', 'Arum Pawestri', 'K/3', 'Jl.Jamblang Indah I No.9 Rt.013 Rw.002 Duri Selatan, Duri Selatan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL.JAMBLANG INDAH I NO.9 RT.013 RW.002 DURI SELATAN, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '62216302385', 'andrewyuniarto@yahoo.com', '$2y$10$heopCFXXo9mlwvxAVT3Zjecuyazj3dXOdD3CaQ4WCe7kGC1rpEv/W', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (197, 'Bambang Handojo', '3', 4, '3173040606460004', '063120463033000', NULL, 'Tambora', 'Laila Nur Wahidah', 'TK/1', 'Jl Gg. Betet No.63, 63, Tambora, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11220', 'JL GG. BETET NO.63, 63, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '081517874562', 'bambanghandojo799@gmail.com', '$2y$10$Rf5yDG9C48z3fArC2tX2u.GiA.1pIMCnMZ7vGLZY2HLHMIYZktxcS', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (198, 'Erna', '3', 4, '3173045210750005', '182815811033000', NULL, 'Tambora', 'Ridwan', 'TK/0', 'Jl Tss Gg Baru, 20G, Duri Utara, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL TSS GG BARU, 20G, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '082258555347', 'ernaccss@gmail.com', '$2y$10$BW.QO8QjTBVT0ZJeTOFFUuRQsDzoIOZHkZG3/SAkB3y1e4Qa3/zHC', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (199, 'Fransiscus Lie', '3', 4, '3173041309760003', '175846054033000', NULL, 'Tambora', 'Dhani Kristanti', 'K/2', 'Jl Krendang Barat, Krendang, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11260', 'JL KRENDANG BARAT, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '081318187166', 'fransiscuslie428@gmail.com', '$2y$10$ABGOEKCzf2FBWDhRvvyjU.bPxRPLwF62tbwkGk8R7b/WmJCez.ctC', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (200, 'Gunawan Widjaja', '3', 4, '3173040411710004', '684564404033000', NULL, 'Tambora', 'Ria Puji Anesti', 'TK/0', 'Jl Gg Samarasa I, 7, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'JL GG SAMARASA I, 7, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '628129186728', 'gunawanwidjajaa@gmail.com', '$2y$10$WA.Lsow1vJpXcCFkTBXsZeFxsP0x6fO7hqRSp3y9VEpsABdsuPKpm', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (201, 'Harianto', '3', 4, '3173040409320001', '061885158033000', NULL, 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'Jl Khm Mansyur, 209, Krendang, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11260', 'JL KHM MANSYUR, 209, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '6281311648970', 'hariantopit@gmail.com', '$2y$10$WMUnf9.Y9tYnd5i2pL.fpe586b7FGWu8EAYwDp..IRVROnRU5uPxG', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (202, 'Hengky Yuniarto', '3', 4, '3173041606620005', '067906776033000', NULL, 'Tambora', 'Arum Pawestri', 'K/0', 'Jl Jamblang Indah I, 9, Duri Selatan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL JAMBLANG INDAH I, 9, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08158305511', 'henkyyuniarto@gmail.com', '$2y$10$5Z0s5TU/3184YPxRC/kCeeSAm5cBooRf/pxu1xKPIXGoHe48HVWjO', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (203, 'Heu Panjuwono', '3', 4, '3173040705650013', '058137670033000', NULL, 'Tambora', 'Dhani Kristanti', 'TK/0', 'Jl. Krendang Tengah I, Krendang, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11260', 'JL. KRENDANG TENGAH I, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '6215445982', 'heupanjuwono@gmail.com', '$2y$10$ub63JIxdkqhwNs6zPMUVdO0UVVSuEO9nhJOzyWlrkX/Ta4N8pPcge', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (204, 'Kiandi Kusuma Liong', '3', 4, '3173040103550003', '061133567033000', NULL, 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'Jl Perniagaan, 129, Tambora, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11220', 'JL PERNIAGAAN, 129, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '08121116868', 'liong.siong033@gmail.com', '$2y$10$vtcicu82Yav8yFET5rYs..4t5QbyI0ph2eVYDmrl8kljeEc8JCm7K', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (205, 'Kok Lukman Wijaya', '3', 4, '3173040311620007', '688484583033000', NULL, 'Tambora', 'Ria Puji Anesti', 'K/2', 'Gg Samarasa Iii No.18, Jakarta Barat, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '083719663796', 'koklukman@gmail.com', '$2y$10$pqXYhrBHrGxGQlaaIEj8IehoWIBBWcDCnIAqHG9su4dqEdYkb5V4m', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (206, 'Liauw Ka Tjaij', '3', 4, '3173040303520001', '249404070033000', NULL, 'Tambora', 'Arie Kurniawan', 'K/0', 'Jl. Pejagalan I No. 98 D Rt. 014 Rw. 005, Pekojan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11240', 'JL. PEJAGALAN I NO. 98 D RT. 014 RW. 005, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '0216322909', 'kcliauw@gmail.com', '$2y$10$gKcCU98pMPvLOthLzFoENuAKetWlh0quLel9b5eCF2C7soWARk6Am', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (207, 'Liu Loy Loy', '3', 4, '3173042609770009', '3173042609770009', NULL, 'Tambora', 'Adetya Candra Yuwana Putra', 'K/3', 'Jl Khm Mansyur, 172, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL KHM MANSYUR, 172, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '0813380655933', 'liuloyloy@yahoo.com', '$2y$10$4llkEoQozcgtLwtZMDSTJufSjb0eKMlQTVtix8htPNUVBbS2DdH72', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (208, 'Phang Su Phin', '3', 4, '3173042603710002', '069133775033000', NULL, 'Tambora', 'Arum Pawestri', 'K/2', 'Jl Duri Selatan V, 65 B, Duri Selatan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL DURI SELATAN V, 65 B, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08129946588', 'phangsun19@yahoo.com', '$2y$10$Blx0iaN8vabRPTMuM2JJSusQ2mAmEqEO6yfTnGFnaM/WYuq5CHHa6', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (209, 'Ringo Yapari', '3', 4, '3173041604760004', '076533710033000', NULL, 'Tambora', 'Wursito Atik', 'K/2', 'Jl.Khm.Mansyur No.218, Tanah Sereal, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL.KHM.MANSYUR NO.218, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '081288224490', 'ringoyapari17@gmail.com', '$2y$10$OBw3f2SjzuXrFbT9W79EbeNWRAIwrTZQdFE.YOp0d7f8d4dX2Qkzy', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (210, 'Robin Sugiarto', '3', 4, '3173042106550003', '175914100033000', NULL, 'Tambora', 'Arum Pawestri', 'K/1', 'Jl Jamblang I, 50, Duri Selatan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08128000812', 'robinsugiarto997@gmail.com', '$2y$10$j0AWyo9i8CORHqol33WQGuynPRn0b8l9EBHS05c3OS.3Nb38yiBl6', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (211, 'Rosmawati', '3', 4, '3173045506680004', '066740093033000', NULL, 'Tambora', 'Ridwan', 'TK/1', 'Jl Kp Duri Tss, 51, Duri Utara, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL KP DURI TSS, 51, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '62816811386', 'pajakrosmawati17@gmail.com', '$2y$10$OimrqtVECMPuDGDUeTUnA.Vw2Y1Ezu6B37zNLpEZbj8lLpHqgT.ve', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (212, 'Santoso Latif', '3', 4, '3173040112520003', '175734078033000', NULL, 'Tambora', 'Adetya Candra Yuwana Putra', 'K/0', 'Jl Songsi, 6, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL SONGSI, 6, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '62216902735', 'santosolatif3@gmail.com', '$2y$10$QG2uDVztw09enVF.nEej5uqXKI5DHIi6az/813kdFTuXKVAd/BYHK', '2026-07-15 16:33:36', '2026-07-15 16:33:36');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (213, 'Sastro Tjondro', '3', 4, '3173042511640006', '279076624033000', NULL, 'Tambora', 'Ria Puji Anesti', 'K/2', 'Gg Samarasa Iii No.18 Rt.005 Rw.005 Kel Angke, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'GG SAMARASA III NO.18 RT.005 RW.005 KEL ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '6281105892', 'sastrotjondro4@gmail.com', '$2y$10$Xk/RvAmK6Y3/Rqcl0FhIq.COSyRRoZgHvk9Uy/45CanOM7JDieDbO', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (214, 'Sumitro Lie', '3', 4, '3173040508790006', '189399025033000', NULL, 'Tambora', 'Dhani Kristanti', 'K/3', 'Jl.Krendang Barat No.42 Rt.012 Rw.005 Krendang, Krendang, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11260', 'JL.KRENDANG BARAT NO.42 RT.012 RW.005 KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '622130365910', 'sumitro.lie@yahoo.com', '$2y$10$rkAlW/ffcGIaFo0RWB4h4.hA5VqrV9xPfPXBkP09BD/grnNiSGtMG', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (215, 'Suwandi Arifin', '3', 4, '3173042712690011', '688484591033000', NULL, 'Tambora', 'Ria Puji Anesti', 'K/1', 'Jl Ptb Angke Gg Samarasa Iii No.18, Jakarta Barat, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'JL PTB ANGKE GG SAMARASA III NO.18, JAKARTA BARAT, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '6285719663796', 'suwandiarifin00@gmail.com', '$2y$10$D/5iNYNy7nPDMV/puUoN4OMO7QMb6PDYqQWiFbQ8tJdy.38F1ibQm', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (216, 'Tjan Gosto', '3', 4, '3173040708690006', '684564412033000', NULL, 'Tambora', 'Ria Puji Anesti', 'K/1', 'Gg Samarasa I, 23, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'GG SAMARASA I, 23, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '08176902776', 'gostotjan@gmail.com', '$2y$10$sHjpQHoGIZ1KqqbIbjgrkOFZMQpzaGKI7MoIxWPjqwV/xcRiFjtXu', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (217, 'Tjhin Su Mie', '3', 4, '3173044405760009', '969355684033000', NULL, 'Tambora', 'Putra Dwi Pamungkas', 'TK/3', 'Terate I No 11, No 11, Jembatan Lima, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11250', 'TERATE I NO 11, No 11, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '081617175507', 'tjhinsumie9@gmail.com', '$2y$10$ol8Zf6KdbSViQBccT9qxDumhg3OzcPE/9Y.JqTgbWdI.QSjeaT0n6', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (218, 'Tjioe Seng Huat', '3', 4, '3173040310550006', '069103547033000', NULL, 'Tambora', 'Wursito Atik', 'K/1', 'Jl Tanah Sereal X, 8, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL TANAH SEREAL X, 8, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '6281315151596', 'tjiosenghuat@gmail.com', '$2y$10$767LsTgUtUIL4C8UwlIImuArL4U4Pcc4S1VNkVU1tmk8scuB2yi5K', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (219, 'Tjiu Jun Shin', '3', 4, '3173041511690001', '076531904033000', NULL, 'Tambora', 'Ridwan', 'K/3', 'Jl.Tss.No.15 L, Duri Utara, Duri Utara, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL.TSS.NO.15 L, DURI UTARA, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '62811872783', 'tjiuju@gmail.com', '$2y$10$iwCvt58d8gXObrKyRx21Gur9SWDAd7FLluoAYikMCr9oMATBB44Ly', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (220, 'Tjiu Supardi', '3', 4, '3173040112510001', '076533835033000', NULL, 'Tambora', 'Putra Dwi Pamungkas', 'K/0', 'Jl Laksa I, 85A, Jembatan Lima, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11250', 'JL LAKSA I, 85A, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '628128556129', 'tjiusupardi@gmail.com', '$2y$10$raRsl4RX6ZI5qvDBXEoyEeqIt6VnVnoiHlNjnfsCL.sQH4DeptpAu', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (221, 'Vicky Famin Efendy', '3', 4, '3173043010660006', '694895046033000', NULL, 'Tambora', 'Anung Prasetyo Dwijayanto', 'K/0', 'Duri Baru No.3, Jakarta Barat, Jembatan Besi, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'DURI BARU NO.3, JAKARTA BARAT, JEMBATAN BESI, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '-', 'vickyfamin@gmail.com', '$2y$10$NIdGstuKN9P7G2HBfBeGae1bMdZ3DegwzBQ8lpiZmOTnZ.UjdP4/G', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (222, 'Yunita Sugiarto', '3', 4, '3173044802740006', '#N/A', NULL, 'Tambora', '', '', 'Jl.Jamblang Raya I / 61, Duri Selatan Rt 000 Rw 000, Duri Selatan, Tambora,Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL.JAMBLANG RAYA I / 61, DURI SELATAN RT 000 RW 000, DURI SELATAN, TAMBORA,KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '08128800167', 'yunitasugiarto08@gmail.com', '$2y$10$O095/7zw95u3KMgykzpMLeiHtriCVROQJg.dPhUPcuQCA.WApKuqm', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (223, 'Harianto Soeparjono', '3', 4, '3173042202740007', '#N/A', NULL, 'Tambora', '', '', 'Jl.Hanura I No.21, Jakarta Barat Rt 000 Rw 000, Tanah Sereal, Tambora,Kota Adm. Jakarta Barat,', 'JL.HANURA I NO.21, JAKARTA BARAT RT 000 RW 000, TANAH SEREAL, TAMBORA,KOTA ADM. JAKARTA BARAT,', '08161113410', 'hariantosoeparjono@yahoo.com', '$2y$10$J0UIdwpM0v3Hwy.X4KCKWeU48e2agew1Zlvi10SqmbdHdDz198aBq', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (224, 'Erres Subiarto', '3', 4, '3171022302390002', '061844098026000', NULL, 'Sawah Besar Satu', 'Geri Gema Putra Tarigan', 'TK/0', 'Jl Gunung Sahari 11, Gunung Sahari Utara, Sawah Besar, Kota Adm. Jakarta Pusat, Dki Jakarta, 10720', 'JL GUNUNG SAHARI 11, GUNUNG SAHARI UTARA, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10720', '087885382958', 'eressubiarto@gmail.com', '$2y$10$1rIQC96iXat3kArTQrveG.IYYasAlFlkETCNzL1KCz.qZ4PgkiABe', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (225, 'Giovan Valentine', '3', 4, '3171022007910002', '#N/A', NULL, 'Sawah Besar Satu', '', 'K/0', 'Jl. Kartini Raya No.55 Frt 001 Rw 003, Kartini, Sawah Besar,Kota Adm. Jakarta Pusat, Dki Jakarta,10750', 'JL. KARTINI RAYA NO.55 fRT 001 RW 003, KARTINI, SAWAH BESAR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA,10750', '081213030368', 'giovan.valentineacc@gmail.com', '$2y$10$LcrSiaMx.d5sxN3FYwgVFejv7tllttakWMuAl6Dxwq79UeHH4j0FG', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (226, 'Lie Ka Djin', '3', 4, '3171024906560003', '#N/A', NULL, 'Sawah Besar Satu', '', '', '', 'P. JAYAKARTA NO.15 RT 009 RW 007, MANGGA DUA SELATAN, SAWAH BESAR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '081295439081', 'TENGKIMSUI@YAHOO.COM', '$2y$10$4jlrqguOUssUBvMPCUYdbOYSvYssIcrbvR3WCjlr5ALS2X1vli642', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (227, 'Lie Juliana Margaret', '3', 4, '3171024303800002', '#N/A', NULL, 'Sawah Besar Satu', '', '', '', 'PANGERAN JAYAKARTA D-15 NO.46 RT 009 RW 007, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA', '0881010622198', 'LIEJULIANAMARGARET@GMAIL.COM', '$2y$10$8IWR/FdSoRVeyEd7rLmsEeYg7K7tgQZvjleVMA/4sNKstL7jO8m96', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (228, 'Diana Wangsa Heryanto', '3', 4, '3171024408910004', '664215126075000', NULL, 'Sawah Besar Dua', 'Chalimatus Sa\'diyah', 'TK/0', 'Jl Kelinci Iv No 2 A Rt 008 Rw 004, Pasar Baru, 2 A, Pasar Baru, Sawah Besar, Kota Adm. Jakarta Pusat, Dki Jakarta, 10710', 'JL KELINCI IV NO 2 A RT 008 RW 004, PASAR BARU, 2 A, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '6281808867585', 'dianawangsa2@gmail.com', '$2y$10$7jVdKkdAtzTIMTX6wkD/KeUB72pOytEywJpjfRAoYxSK8ItcO5VcS', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (229, 'Djohan Hirawady', '3', 4, '3173010907610005', '067495846037000', NULL, 'Sawah Besar Dua', 'Dellachita Rahardhianne Winarto', 'TK/0', 'Jl Gg Mandor, V, 32, Pasar Baru, Sawah Besar, Kota Adm. Jakarta Pusat, Dki Jakarta, 10710', 'JL GG MANDOR, V, 32, PASAR BARU, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10710', '081574258787', 'djohanhirawady@gmail.com', '$2y$10$332viALecucx2BJGJGkFjely3NLfOLGDs0kwjG1wAq4.fWNifISai', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (230, 'Alex Heryanto', '3', 4, '3173031709570004', '065587503032000', NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'Jl Tamansari Ix, 10, Taman Sari, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11150', 'JL TAMANSARI IX, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '6221624329', 'alexheryanto51@yahoo.co.id', '$2y$10$lNxeJi5zK8hgakdrhWh6UuoGgCf.pkfbwBF4T4vGzI8RKK9aBE3oq', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (231, 'Cynthia Kurnia', '3', 4, '3173036802910004', '659844500032000', NULL, 'Tamansari', 'Nova Novelita', 'TK/0', 'Jl Taman Sari Ix/10, 10, Taman Sari, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11150', 'JL TAMAN SARI IX/10, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '082225843858', 'cynthiakurniaa@gmail.com', '$2y$10$LLQ3AdOIuaMV6Q7B5zKTQ.hn7ATLdCe4gJDL4i3XwH7QWG5yIsvXG', '2026-07-15 16:33:37', '2026-07-15 16:33:37');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (232, 'Ely Widjaya', '3', 4, '3173035606700001', '#N/A', NULL, 'Tamansari', 'Nova Novelita', 'TK/0', 'Jl Taman Sari Ix/10, 10, Taman Sari, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11150', 'JL TAMAN SARI IX/10, 10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '0881010622198', 'MULYADISAPUTRA817@YAHOO.CO.ID', '$2y$10$OB9f64TF3G78RUPLa1qmpeJmyQaKjksc7EXnoNa61NxXMOfFYEL7K', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (233, 'Ferry Wangsa Saputra', '3', 4, '3173030704950006', '813350246032000', NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'Jl. Tamansari Ix/10, Taman Sari, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11150', 'JL. TAMANSARI IX/10, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '08989703363', 'ferrywangsa@gmail.com', '$2y$10$F1O5MhwGjVnKCONm4DTqsubEwdFSWkfkz5PCWsPNoj2ACsSf4raDC', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (234, 'Hendry Wijaya', '3', 4, '3173030308670005', '076453869032000', NULL, 'Tamansari', 'Nova Novelita', 'K/3', 'Jl Tamansari Iv, 22, Taman Sari, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11150', 'JL TAMANSARI IV, 22, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '628129133176', 'hendrywijayaa0@gmail.com', '$2y$10$XI.EPIs/oxj3WVM9k04txurNpmQ1DJkDfHjM/TPEN9LPaSfOA.8IW', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (235, 'Johan Ng', '3', 4, '3173031204490001', '068512904032000', NULL, 'Tamansari', 'Nova Novelita', 'K/0', 'Jl Tamansari Vi, 52-B, Taman Sari, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11150', 'JL TAMANSARI VI, 52-B, TAMAN SARI, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11150', '081808991212', 'johanng454@yahoo.com', '$2y$10$8KR52eyJEWym7uwE8AcA4Oy/W5AAaky0eVES.vz3laoJ.ivzK32Vy', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (236, 'Willy Darmawan', '3', 4, '3173032301690002', '577673528032000', NULL, 'Tamansari', 'Raden Muhammad Riandy Irmansyah', 'K/3', 'Jl Tamansari Ii, 60 B, Maphar, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11160', 'JL TAMANSARI II, 60 B, MAPHAR, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11160', '0818169848', 'willydarmawan678@yahoo.co.id', '$2y$10$Aq2QvZmwVgBfgNjRAXnTI.CrqTieTuI0n5B5Fyoer/s/5duuBiaqq', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (237, 'Wong Sauw Lie', '3', 4, '3173036710480005', '096710199037000', NULL, 'TamanSari', 'Dite Fatmawati', 'TK/0', 'Jl Kemenangan V Gg 2, 18 A, Glodok, Taman Sari, Kota Adm. Jakarta Barat, Dki Jakarta, 11120', 'JL KEMENANGAN V GG 2, 18 A, GLODOK, TAMAN SARI, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11120', '0216393841', 'wongsauw10981@gmail.com', '$2y$10$j8L2K/i35CzNoj0lFV.2SusRMc32d657tFVU4Uq1q0IrKHFlUOKM2', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (238, 'Yoanita Kristina', '3', 4, '3173054906810009', '091270769035000', NULL, 'Kebon Jeruk Satu', 'Rahmat Husein Harahap', 'TK/0', 'Komplek Bpk Iii, C, 9, Kebon Jeruk, Kebon Jeruk, Kota Adm. Jakarta Barat, Dki Jakarta, 11530', 'KOMPLEK BPK III, C, 9, KEBON JERUK, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11530', '081517874562', 'yoanita.kristina@yahoo.co.id', '$2y$10$twm0YWIkJuuXmgWDzDtz/.Z/G6xohjiDaMvbb6zHD7h4Qehnvpkvi', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (239, 'Andy Prayitno Limantoro', '3', 4, '3173051309840007', '258880335039000', NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'Green Garden Blok A-5/12 Rt. 003 Rw. 003, Kedoya Utara, Kebon Jeruk, Kota Adm. Jakarta Barat, Dki Jakarta, 11520', 'GREEN GARDEN BLOK A-5/12 RT. 003 RW. 003, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '628567843535', 'andyprayitno57@yahoo.co.id', '$2y$10$QylwNT1E6NGh1MizbXYxVOuWoEq69ADg6IuTyBabYsaqef.K60xMq', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (240, 'Indra Prayitno Limantoro', '3', 4, '3173052005890008', '813778198039000', NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'K/0', 'Green Garden, A-5, 12, Kedoya Utara, Kebon Jeruk, Kota Adm. Jakarta Barat, Dki Jakarta, 11520', 'GREEN GARDEN, A-5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '08128015571', 'indraplim@gmail.com', '$2y$10$sHpRJZt7LysQnIDXhedEpO37txYcF/y3WP15SH.adqTnbVEZDYxK.', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (241, 'Winston Tanazon', '3', 4, '3173042904910003', '767341183039000', NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/0', 'Komplek Green Garden, M 3, 57, Kedoya Utara, Kebon Jeruk, Kota Adm. Jakarta Barat, Dki Jakarta, 11520', 'KOMPLEK GREEN GARDEN, M 3, 57, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '08170066290', 'TANAZONW@GMAIL.COM', '$2y$10$32W34LqWXqYKdI9F0iflcOcwJGGu3I5sANkjLjlYps0hNYwe74Imu', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (242, 'Willy Limantoro', '3', 4, '3173051904830008', '678492109039000', NULL, 'Kebon Jeruk Dua', 'Harbowo Suharyo Djomi', 'TK/1', 'Komplek Green Garden, A 5, 12, Kedoya Utara, Kebon Jeruk, Kota Adm. Jakarta Barat, Dki Jakarta, 11520', 'KOMPLEK GREEN GARDEN, A 5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '62215650104', 'limantorowilly@gmail.com', '$2y$10$W9qCf7SmWdeywixIq5csEeUlEtWCNkeVffcQ8EMF8flxTCg.C4jri', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (243, 'Albert Limanto', '3', 4, '3173012209850005', '768236788034000', NULL, 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'Jl Kapuk Raya, 8, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'JL KAPUK RAYA, 8, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '08568568445', 'albertlimant@gmail.com', '$2y$10$V/hlSpASMlK1gZTN4n0eeO2Ylg.9Xb2N9AgAJaqj5cgbcZHPMkSpK', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (244, 'Alvindo Limanto', '3', 4, '3173012210930003', '633796222034000', NULL, 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'Kapuk Raya, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '081289020181', 'alvindolimantoo@gmail.com', '$2y$10$9SrYzhZJlu04E6vOdrsOM.LsEPVsHN9hRBOMAJ3M1hRAYIFlFQlPa', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (245, 'Chandra Limanto', '3', 4, '3173011207570001', '776577181034000', NULL, 'Cengkareng', 'Genis Anggraeni', 'K/2', 'Jl Kapuk Raya, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'JL KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '081889020181', 'chandralimanchan@gmail.com', '$2y$10$2.1WWr1UPwLsCWojUbyt5.w2F.qH7qzaeUwyoc3iOaZg2bySh3u9O', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (246, 'Heng Chun Khiun', '3', 4, '3173015604740020', '467420469034000', NULL, 'Cengkareng', 'Puspa Ayu Wulandari', 'K/0', 'Jl Kapuk Kebon Jahe, 133, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'JL KAPUK KEBON JAHE, 133, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '08178811560', 'hengchun377@yahoo.co.id', '$2y$10$7Bv5xYm8NwiA/s/3KPo0oe6z6jwPvi7Ozvt0AtUKsEZUanLB9fHOu', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (247, 'Lisa', '3', 4, '3173017101920008', '730214897034000', NULL, 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'Kp Utan No. 3, Cengkareng Timur, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11730', 'KP UTAN NO. 3, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '08988959911', 'lisacss1@yahoo.co.id', '$2y$10$IhqcvkRb.pLg0b/ia6RGleGzTHRjrkS.ijtZff9iarfCHj9/mWl0i', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (248, 'Pendi Susanto', '3', 4, '3173012005810019', '668749120034000', NULL, 'Cengkareng', 'Firka Rahmayanti', 'TK/0', 'Jl Kampung Utan, 36, Cengkareng Timur, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11730', 'JL KAMPUNG UTAN, 36, CENGKARENG TIMUR, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '668749120', 'pendisusanto907@yahoo.com', '$2y$10$pKy.1thp02PEEpopIUJHqeINA1xlt7dHBgQ.yhVDwR4rFPVHwiPrW', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (249, 'Silvia Listiani Limanto', '3', 4, '3173015410840005', '633705165034000', NULL, 'Cengkareng', 'Genis Anggraeni', 'TK/0', 'Kapuk Raya, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'KAPUK RAYA, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '081289020181', 'silvialistianilimanto@gmail.com', '$2y$10$jObQsjT13GnQmJ.wTbcVsuHk1M04EH.TaZzW9BrScQUCpy2tq/23m', '2026-07-15 16:33:38', '2026-07-15 16:33:38');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (250, 'Sukarsanto', '3', 4, '3173012206760020', '243701620034000', NULL, 'Cengkareng', 'Ika Kusumawati', 'K/3', 'Jl Raya Kapuk Gg Empang, 3, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'JL RAYA KAPUK GG EMPANG, 3, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '087883803880', 'sukarsanto37@gmail.com', '$2y$10$QzMWqEHpPmh9cT2iUJ92SOJdJvbxa93mkG/DlLZWSGSA.yzU48ee6', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (251, 'Lioe Leosando', '3', 4, '3173012504730005', '278279468034000', NULL, 'Cengkareng', 'Genis Anggraeni', 'K/2', 'Jl Waru Iii, 14, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'JL WARU III, 14, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '08129966364', 'lioeleosandoo@gmail.com', '$2y$10$Y1.am/SiN3IO2oFHASFZ1erCCrtNFDBQtMEvZviaFx.jiljR4VSty', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (252, 'Brian', '3', 4, '3173040903011001', '#N/A', NULL, 'Kalideres', '', 'TK/0', 'Jl Taman Kintamani Timur Blok Ll No 16 Rt. 001 Rw. 017, Kalideres, Kalideres, Kota Adm. Jakarta Barat, Dki Jakarta', 'JL TAMAN KINTAMANI TIMUR BLOK LL NO 16 RT. 001 RW. 017, KALIDERES, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA', '087788669910', 'brianzzz0909@gmail.com', '$2y$10$tF/0pXKpr7Ab7gZa/Om7quyBO8rRt4.D4t7CM9HcnQ0.yudmKkAYC', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (253, 'Harya', '3', 4, '3173062010720016', '478624356085000', NULL, 'Kalideres', 'Crisanto Adi Maria Listyanto De Carvalho', 'TK/0', 'Taman Kencana Blok D Kav.9 No.5 No 5 Rt.001 Rw.14, Jakarta Barat, Tegal Alur, Kalideres, Kota Adm. Jakarta Barat, Dki Jakarta, 11820', 'TAMAN KENCANA BLOK D KAV.9 NO.5 NO 5 RT.001 RW.14, JAKARTA BARAT, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '082112660987', 'harya1919@gmail.com', '$2y$10$l5IPKXnDk4AzJHTIoAnYue3dkDELLxrLJvB3qFCNA3OiyU89X/STe', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (254, 'Ronny Halim', '3', 4, '3173062606650004', '067232728085000', NULL, 'Kalideres', 'Tono Supriyono', 'K/1', 'Perumahan Citra 2, A 5, 12 A, Pegadungan, Kalideres, Kota Adm. Jakarta Barat, Dki Jakarta, 11830', 'PERUMAHAN CITRA 2, A 5, 12 A, PEGADUNGAN, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11830', '5445053', 'ronnyhalim19@gmail.com', '$2y$10$amsQCWSURreIo1prbYtEpO6v35DIM3sx.omtD2lYKeopimwZw3EZy', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (255, 'Suharta Riyanto', '3', 4, '3173010904940012', '828292631085000', NULL, 'Kalideres', 'Erwanto Eko Prasteyo', 'TK/0', 'Jl Prima Ujung, A, 31A, Tegal Alur, Kalideres, Kota Adm. Jakarta Barat, Dki Jakarta, 11820', 'JL PRIMA UJUNG, A, 31A, TEGAL ALUR, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11820', '08998947847', 'suhartariyanto@yahoo.com', '$2y$10$N8DUXucJXGg8oDMHreYhou9oHOUG2TEMQsvAoHn842nMXngbu8RL.', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (256, 'Bambang Suhono Halim', '3', 4, '3172050802650002', '070437843044000', NULL, 'Pademangan', 'Ferri', 'K/0', 'Jl Pademangan Ii Gg 29, 07, Pademangan Timur, Pademangan, Kota Adm. Jakarta Utara, Dki Jakarta, 14410', 'JL PADEMANGAN II GG 29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '6281288518185', 'bambangsuhonohalim72@gmail.com', '$2y$10$aUehJsbG9e4YG.OyRem7jO8am2zQVmjoYh.AR0g.lotEGFBTYJN6e', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (257, 'Daniel Halim', '3', 4, '3172051310990005', '538074576044000', NULL, 'Pademangan', 'Ferri', 'TK/0', 'Jl. Pademangan Ii  Gg 29, 7, Pademangan Timur, Pademangan, Kota Adm. Jakarta Utara, Dki Jakarta, 14410', 'JL. PADEMANGAN II  GG 29, 7, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '087879507490', 'halimmdaniel@gmail.com', '$2y$10$jctkfaJkUYgHWvSaIkc8qOyBhDB56jwinzJbptY/hJZ4MyvsaAWnW', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (258, 'Niki Halim', '3', 4, '3172056004940001', '742610801044000', NULL, 'Pademangan', 'Ferri', 'TK/0', 'Jl.Pademangan Ii Gg.29, 07, Pademangan Timur, Pademangan, Kota Adm. Jakarta Utara, Dki Jakarta, 14410', 'JL.PADEMANGAN II GG.29, 07, PADEMANGAN TIMUR, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14410', '0818756910', 'nikihalimm@yahoo.com', '$2y$10$JQB9Gq7UWAGy1cfsgNCIaeTJ1mghSACWNbptN/b3BioSRme5XMRoO', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (259, 'Sumanto', '3', 4, '3173042507500006', '042075085044000', NULL, 'Pademangan', 'Hamonangan', 'K/0', 'Jl Lodan, 143, Ancol, Pademangan, Kota Adm. Jakarta Utara, Dki Jakarta, 14430', 'JL LODAN, 143, ANCOL, PADEMANGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14430', '081283789850', 'sumantotjioe@yahoo.com', '$2y$10$.v1ryJfXVMAy2XMO1sL7fuwSkYU8qA5pdr1XYSGgbzTuQFIT/sE2O', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (260, 'Akin Sriwongo', '3', 4, '3172010712590007', '065792780041000', NULL, 'Penjaringan', 'Hari Isnawan', 'TK/0', 'Jl Jembatan Gambang I, 26, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL JEMBATAN GAMBANG I, 26, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281219128119', 'akinsriwongo17@gmail.com', '$2y$10$mJOEPaz6bHxkTejIv6DZju4lF9ozyIH9bBo5NutGq.R6Md.RGelcS', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (261, 'Alvin Wijaya Tie', '3', 4, '3172011708670002', '173572561041000', NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'Jl Jelambar, 19, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL JELAMBAR, 19, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '085216695811', 'alvintie@yahoo.com', '$2y$10$2s6cavbX5no3TJJn6JW1ueb.DkxsTQgfkT51PuUwGdfynfmeNW03i', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (262, 'Eddy Chandra', '3', 4, '3172012303760019', '240139386041000', NULL, 'Penjaringan', 'Gani Syabani', 'K/3', 'Jl E Teluk Gong, 174 B, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '082124656668', 'eddychan1919@gmail.com', '$2y$10$L4r/gS2.r7IHVIAGeKtTo.m0ymbVywFPl7c9kBgx3l3testtWCINm', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (263, 'Edi Saputra Widjaja', '3', 4, '3172011004920007', '#N/A', NULL, 'Penjaringan', 'Yusuf Wahyu Aristiwan', 'TK/0', 'Jalan Aladin Baru, 25, Rt 001/Rw 006, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JALAN ALADIN BARU, 25, RT 001/RW 006, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '082211238686', 'esaputrawidjaja@gmail.com', '$2y$10$0CfQzv/9Dk9mzh1QASfsdOattOSC7t9cgXpSPeF4alCpBjjtjA06a', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (264, 'Hendra Wijaya Tie', '3', 4, '3172010703640002', '144331568041000', NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/0', 'Jl Jelambar Aladin, 16, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL JELAMBAR ALADIN, 16, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281287022829', 'hendrawijayatie@gmail.com', '$2y$10$kjON7wySC8X58OqCSILAsOjXghC2NibU0MO4ZpnJeSJbIL36Olvb2', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (265, 'Herman Wijaya', '3', 4, '3172010109610005', '064493224041000', NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/3', 'Jl Jelambar Aladin, 1K, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL JELAMBAR ALADIN, 1K, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281291674728', 'hermanwijayapit@gmail.com', '$2y$10$PZNnB9jgfKhZpMwWDQf1wus5U.0XpBkxW.UCxmO3cYziOuo.pqCGG', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (266, 'Lim Ngok Hong', '3', 4, '3172012705750008', '716689823041000', NULL, 'Penjaringan', 'Hari Isnawan', 'K/3', 'Jl. Kertajaya Iv, 20, Penjaringan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14440', 'JL. KERTAJAYA IV, 20, PENJARINGAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14440', '0852181765255', 'limngok@yahoo.com', '$2y$10$UZHp.4iAUzxTMdDkMf.rRO6tmRpdUjnVWXHJOKlplOeUKcP47t6Pi', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (267, 'Sadikin Kuswanto', '3', 4, '3172012102640004', '073268245041000', NULL, 'Penjaringan', 'Devy Elvandary', 'K/1', 'Teluk Gong Jl Lundu 48, Pejagalan, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'TELUK GONG JL LUNDU 48, PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '-', 'dikisadikin19@gmail.com', '$2y$10$oaSZqSFkBGynsk28M38zfeNXUVhDqm7D/.IpJyjwrwTUdFhFSo49i', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (268, 'Tjhang Vivi Surianty', '3', 4, '3173045110810007', '725711873041000', NULL, 'Penjaringan', 'Gani Syabani', 'TK/0', 'Jl E Teluk Gong, 174B, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL E TELUK GONG, 174B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '622156949666', 'tjhangvivisurianty@gmail.com', '$2y$10$agd820/vutFVKSUhNa.o6OwY.hlXgcsA7NwBkDRNZTO7c5bpchZ3m', '2026-07-15 16:33:39', '2026-07-15 16:33:39');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (269, 'William Wijaya Tie', '3', 4, '3172010708600007', '144330925041000', NULL, 'Penjaringan', 'Sandra Nurma Putra', 'K/1', 'Jl Jelambar, 1, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL JELAMBAR, 1, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6287884564101', 'williamwijayatie@gmail.com', '$2y$10$bd7rMln9VZfmGcI5qnQt5u79XeMBOClVAqzNi5P41H4R0ydMHUwiG', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (270, 'Devlin Sukarto', '3', 4, '3172011501770010', '248302911047000', NULL, 'Pluit', 'Restu Rea Erlangga', 'TK/1', 'Pluit Sakti Iii No.41 Rt. 006 Rw. 007, Pluit, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '087789101118', 'devlinsukarto1997@gmail.com', '$2y$10$2P17HVccpbZ/YhM9jc8ja.RQ3nzfeU/EFulGqAXY3492e58nKTNy2', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (271, 'Enrico Rusli', '3', 4, '3172012104920006', '962709838047000', NULL, 'Pluit', 'Ganendra Edo Satwika', 'TK/0', 'Camar Indah, 7, 9, Kapuk Muara, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14460', 'CAMAR INDAH, 7, 9, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '081296887420', 'enricoruslilie@gmail.com', '$2y$10$9E10dJkxqv99qAITJnu6ueXR.uXNXbJBebEGCkLmP.ns67Z2AO1rO', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (272, 'Liong Koei Hwa', '3', 4, '3172012512460003', '071910723047000', NULL, 'Pluit', 'Restu Rea Erlangga', 'K/0', 'Jl Pluit Sakti Iii, 41, Pluit, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL PLUIT SAKTI III, 41, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '081513136268', 'koeihwaliong@gmail.com', '$2y$10$NSEFBV5WVcTYZxgnHSH5je8vEq3gEsaL96GLhPauJymfM0ArjeoX.', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (273, 'Sammy Soetiono', '3', 4, '3172012108411001', '040862336047000', NULL, 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'Jl Pluit Barat Iii, 3, Pluit, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL PLUIT BARAT III, 3, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '0816885406', 'sammysoetiono@gmail.com', '$2y$10$mxj9rsaAIq1RCDtEbXleJOLb9oSuppFcpWD9vIPahj.u/4KFkfeE.', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (274, 'Selvia Liliana S', '3', 4, '3172015504820006', '248185076047000', NULL, 'Pluit', 'Restu Rea Erlangga', 'TK/0', 'Pluit Sakti Iii No.41 Rt. 006 Rw. 007, Pluit, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'PLUIT SAKTI III NO.41 RT. 006 RW. 007, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '087789101118', 'selvialilianaas@gmail.com', '$2y$10$4mjAcX72oBKs79WTmmZiDOM5V73bXUQ8tQXZwKbnb3NRIf3hD1ho6', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (275, 'Setiawan Widjaja', '3', 4, '3172010712760012', '276230976047000', NULL, 'Pluit', 'Prophana Labi Dautse Gayo Katama', 'K/1', 'Jl Muara Karang Blok I.7.U  No.11-A, I, 11, Pluit, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL MUARA KARANG BLOK I.7.U  NO.11-A, I, 11, PLUIT, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '08119849992', 'setiawanwjd19@yahoo.com', '$2y$10$9jrdei9L.cDw7Hl/p97JUOgwX4q2XOOEiITT6T1OLBMpvWFmzeEJm', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (276, 'Su Kai', '3', 4, '3172011801801002', '461844409047000', NULL, 'Pluit', 'Wisnu Febryanzah Prasetyo', 'TK/0', 'Rusun Blok G Lantai Ii No.13 Rt. 006 Rw. 009, Kapuk Muara, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14460', 'RUSUN BLOK G LANTAI II NO.13 RT. 006 RW. 009, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '081311648970', 'kaisu2311@gmail.com', '$2y$10$eSSPj09BjSr5SwGLBpr3i..atSN8Aahbd57HAuEoRrSN9wP4F4JVK', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (277, 'A Han', '3', 4, '3173020110780003', '594743379036000', NULL, 'Grogol Petamburan', 'Esther Theresia Orienta Simanjutak', 'K/2', 'Jl Manggis I, -, 10, Tanjung Duren Utara, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'JL MANGGIS I, -, 10, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '6281315815888', 'aahanhann@gmail.com', '$2y$10$07sIRstfbuoxyFOhtSbjv.qlkzR7/3DnuKrUyFufOTfUMI1kzteFq', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (278, 'Anggip Lesmana', '3', 4, '3173021601550001', '062672209036000', NULL, 'Grogol Petamburan', 'Arum Kusuma Sari', 'K/0', 'Taman Duta Ams Jalan Pangeran Tubagus Angke, D 2, 26, Wijaya Kusuma, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11460', 'TAMAN DUTA AMS JALAN PANGERAN TUBAGUS ANGKE, D 2, 26, WIJAYA KUSUMA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '081898128', 'lesmanaanggip17@yahoo.com', '$2y$10$YYMZWXVaX2Y45A0nYuhB2O15YH3yLfCbuyn6XoZZZ8jhwhM0TK1ai', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (279, 'Fen Limantoro', '3', 4, '3173022012340001', '061119467036000', NULL, 'Grogol Petamburan', 'Rumpaka Jati', 'TK/0', 'Jl Tanjung Duren Utara V / 6 Rt 06 Rw 03, Tanjung Duren Utara, Tanjung Duren Utara, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'JL TANJUNG DUREN UTARA V / 6 RT 06 RW 03, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '08158825812', 'fenlimantoro47@gmail.com', '$2y$10$GpBaRd6RJiOKRyIah562yerR6b1IZDvpWohXzWqfOoXltjDh1J4n2', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (280, 'Iwan', '3', 4, '3172012603770004', '163773260036000', NULL, 'Penjaringan', 'Gani Syabani', 'K/2', 'Jl E Teluk Gong, 174 B, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL E TELUK GONG, 174 B, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '6281310551977', 'iwanaja1994@yahoo.com', '$2y$10$bk2qxJrjGug75lDP1WOfke/SGzp8tewLLZbOvaMA7tMhbCICVWWgq', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (281, 'Tjoeng Sje Ji', '3', 4, '3173020112600006', '096661558036000', NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/0', 'Jl Manggis Ii, 4, Tanjung Duren Utara, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'JL MANGGIS II, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '08161974011', 'tjongsje@yahoo.com', '$2y$10$CljjcJxU2QmvXcLWLWXO.uu4PQh8mk9wzhXK5MFJ29tPTstow4UC2', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (282, 'Andika Kartadinata', '3', 4, '3171011501890003', '456635721029000', NULL, 'Gambir Tiga', 'Sartika Faramelita Suherman', 'TK/0', 'Jl. Kh. Hasyim Ashari No. 54A Rt. 003 Rw. 001, Duri Pulo, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10140', 'JL. KH. HASYIM ASHARI NO. 54A RT. 003 RW. 001, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '08999901989', 'kartaandika35@gmail.com', '$2y$10$0Bz/DgLIaZ9VDxQW689qYekI0wP1PDmhp0xvQ8sdyfVmIL1a6Yfc.', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (283, 'Gimin Arifin', '3', 4, '3171011410700005', '069067239074000', NULL, 'Gambir Satu', 'Lisdyaningroem', 'K/2', 'Gg Kingkit Iv, 18, Kebon Kelapa, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10120', 'GG KINGKIT IV, 18, KEBON KELAPA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10120', '081212129534', 'giminarifin@yahoo.com', '$2y$10$mIKbmZPcBcOSmMU5ee.t/uApeB5Ys.WBRS3ty67a4ConLvFTwMvIe', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (284, 'Johnson', '3', 4, '3171011106910002', '#N/A', NULL, 'Gambir Satu', '', '', '', 'JL BATU CEPER V NO.3 RT 011 RW 001, KEBON KELAPA, GAMBIR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA', '083870196364', 'john1161991@gmail.com', '$2y$10$r7tT/K4FSQ3AHNiqctNlveD.4Iv1glndZgB3QMYwv4e.SkG5nrTAC', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (285, 'So Kim Tju', '3', 4, '3171014106640005', '#N/A', NULL, 'Gambir Satu', '', '', '', 'JL BATU CEPER V NO.3 RT 011 RW 001, KEBON KELAPA, GAMBIR,KOTA ADM. JAKARTA PUSAT, DKI JAKARTA', '081806154247', 'sokimtju010664@gmail.com', '$2y$10$sqw1v1UaHNJE5KgBYKpViuZ3CVMPLl.jgdjgbAbNJoSNq9g.Jmt.S', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (286, 'Janti', '3', 4, '3171016812480003', '245090493028000', NULL, 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'Jl. Kebon Jahe Ii No.14 Rt. 006 Rw. 002, Petojo Selatan, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10160', 'JL. KEBON JAHE II NO.14 RT. 006 RW. 002, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '02194507303', 'janti0019@gmail.com', '$2y$10$Y1PBZMk2XXG08R8lLQIzje.B1.HaInIk32yBz0xfwX8rniqglqHcq', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (287, 'Liana Hasanudin', '3', 4, '3171015811510002', '061855714029000', NULL, 'Gambir Tiga', 'Deni Dewi Anggraeni', 'TK/0', 'Jl.Cideng Timur No.9, Petojo Utara, Petojo Utara, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10130', 'JL.CIDENG TIMUR NO.9, PETOJO UTARA, PETOJO UTARA, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10130', '08159403998', 'lianahasanudi19@gmail.com', '$2y$10$Oki4FKa5H53vZD6v2TzPC.tKaZz1vh5Zg4P5JptnVt.B4Teq65uey', '2026-07-15 16:33:40', '2026-07-15 16:33:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (288, 'Linawati Setiadi', '3', 4, '3171014209630003', '072272727028000', NULL, 'Gambir Dua', 'Tini', 'TK/0', 'Jl Persatuan Guru, 18, Petojo Selatan, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10160', 'JL PERSATUAN GURU, 18, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '081315133312', 'linawaatisetiadi@gmail.com', '$2y$10$p4sqAy/IhPSXd.iyaTVt2.ZKIeuzmGPNQoWK7rS8L7s7txt3Zyx.u', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (289, 'Nico Hartono', '3', 4, '3171012301770001', '251403846028000', NULL, 'Gambir Dua', 'Hendra Rahma Wiguna', 'K/1', 'Jl. Kebon Jahe Ii No.14 Rt.006 Rw.002, Petojo Selatan, Petojo Selatan, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10160', 'JL. KEBON JAHE II NO.14 RT.006 RW.002, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '62215655526', 'nicohartono67@gmail.com', '$2y$10$xuFRKzMAF87f0WiWKen1EuF31IXuMTIwdz5/buLtkYKDXjuwEPZBO', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (290, 'Rudy Soetanto', '3', 4, '3171011309490001', '041834318028000', NULL, 'Gambir Dua', 'Tini', 'K/0', 'Jl Petojo Selatan Ix, 2, Cideng, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10150', 'JL PETOJO SELATAN IX, 2, CIDENG, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10150', '0816925412', 'rudysoetanto73@gmail.com', '$2y$10$1oHQyFaG5O90thSVyNm5P.8.B6BhZTEpiAPwKs30KiEGnObBuXo/a', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (291, 'Surya Kartadinata', '3', 4, '3171012002590001', '041335480029000', NULL, 'Gambir Tiga', 'Annisa Perwitasari', 'K/0', 'Jl Kh Hasyim Ashari, 54-A, Duri Pulo, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10140', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '628999031463', 'surya.k18@yahoo.com', '$2y$10$OH9J7ziuxLlcqSiXYC8NLOOLbDrkwSLIDvaoPw04bLnJsCMDEDCha', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (292, 'Efendi Narzudi', '3', 4, '3172061507780004', '277726204043000', NULL, 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'Jl Pelepah Elok Ix, Gf 2, 4, Kelapa Gading Barat, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14240', 'JL PELEPAH ELOK IX, GF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '0818983853', 'efendinarzudi@yahoo.com', '$2y$10$x7Z.DOPDsMkLyQCyS/Px6eKBfNfI3I96HZmE3UwtaKNRbcLnbwkny', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (293, 'Herry Limantoro', '3', 4, '3173051610810014', '095845632043000', NULL, 'Kelapa Gading', 'Sayyidah Tahirah', 'K/1', 'Perumahan Bukit Gading Mediterania, E A, 2, Kelapa Gading Barat, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14240', 'PERUMAHAN BUKIT GADING MEDITERANIA, E A, 2, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '62213849217', 'herrylimantoro99@yahoo.com', '$2y$10$fAS82ebBJowymhFJYSUtR.MQRQW7OzznqB2zu4vrun341.ejJPFWq', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (294, 'Linda Tjahyadi', '3', 4, '3172064212540001', '063481642043000', NULL, 'Kelapa Gading', 'Dodhy Candra Saputro', 'TK/1', 'Jalan Gading Nirwana V, Pf 10, 10, Pegangsaan Dua, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14250', 'JALAN GADING NIRWANA V, PF 10, 10, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '081586607397', 'lindatjahyadi19@yahoo.com', '$2y$10$CQ4Yrs7bbPYq1IBdJXcWwu.If8cB5Y5E/NMxQ0DNqo4sg4QYFRn9O', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (295, 'Ruby Narzudi', '3', 4, '3172060407790003', '581212636043000', NULL, 'Kelapa Gading', 'Daniel Purnomo', 'K/1', 'Jl Pelepah Elok Ix, Qf 2, 4, Kelapa Gading Barat, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14240', 'JL PELEPAH ELOK IX, QF 2, 4, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '0881010622198', 'rubynarzudii@gmail.com', '$2y$10$FLPRhu7zIDevefOQVt/mnuqW5YP29.WIprkkpK5yoBu.0LyneoS0a', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (296, 'Tjoa Hadi Lukmanto', '3', 4, '3172062908580001', '068010131043000', NULL, 'Kelapa Gading', 'Sri Rahayu', 'K/1', 'Jl Kelapa Nias Vi, Pb 13, 18, Pegangsaan Dua, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14250', 'JL KELAPA NIAS VI, PB 13, 18, PEGANGSAAN DUA, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14250', '0816714677', 'tjoahadi@yahoo.com', '$2y$10$A50FZM47RD.RI5o4I9aJ.er9E/H6dXCbnFfSahIhwzkFN1/5dIe6S', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (297, 'Lucy Sastroamidjoyo', '3', 4, '3172025312520005', '719922064048000', NULL, 'Tanjung Priok', 'Prima Wallesa Palo', 'TK/0', 'Jl.  Agung  Tengah  4-I, 1, Sunter Agung, Tanjung Priok, Kota Adm. Jakarta Utara, Dki Jakarta, 14350', 'JL.  AGUNG  TENGAH  4-I, 1, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '6281213998813', 'lucysastro1919@gmail.com', '$2y$10$8eNFLG8YJGuOg4n9Fkb48edYhXh4zUqxhrFD3EkE.rx1AvqhHpPQi', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (298, 'Temmi Sandjaja', '3', 4, '3172022905710015', '253897466048000', NULL, 'Tanjung Priok', 'Toni Murdoto', 'TK/3', 'Jl Agung Utara Xv, A13, 7, Sunter Agung, Tanjung Priok, Kota Adm. Jakarta Utara, Dki Jakarta, 14350', 'JL AGUNG UTARA XV, A13, 7, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '08128537899', 'temmitemsand19@gmail.com', '$2y$10$POWE8VG40K9J0caKTgaeWeE8mJ8kjUaq6ljGsjr2qrBbM.WxJihfe', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (299, 'Ali Chandra', '3', 4, '3174010602820008', '095327383015000', NULL, 'Tebet', 'Nurkholis Rafsanjani', 'K/2', 'Jl Barkah, 27, Manggarai Selatan, Tebet, Kota Adm. Jakarta Selatan, Dki Jakarta, 12860', 'JL BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '6287882550888', 'alichand1919@gmail.com', '$2y$10$BQ/9YBjGCme0qeRHAE8jh.Nly6oLXfbiX7/dK52YirFJEJIMTxC/G', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (300, 'Eddy Zonder', '3', 4, '3174010501450002', '063368476015000', NULL, 'Tebet', 'Nurkholis Rafsanjani', 'K/0', 'Jl Mesjid Barkah, 27, Manggarai Selatan, Tebet, Kota Adm. Jakarta Selatan, Dki Jakarta, 12860', 'JL MESJID BARKAH, 27, MANGGARAI SELATAN, TEBET, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12860', '0816836500', 'eddyzonderr@yahoo.co.id', '$2y$10$ESqsSuxf0YLy.JAGCNgD4OkSXHxWr8rNXB1tmRQxEoPlUlHV2SewG', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (301, 'Hardi Winarta', '3', 4, '3174061203570002', '065506537016000', NULL, 'Cilandak', 'Rudy Priambodo', 'K/3', 'Jl.Puri Mutiara Rt.007/01, Cipete Selatan, Cipete Selatan, Cilandak, Kota Adm. Jakarta Selatan, Dki Jakarta, 12410', 'JL.PURI MUTIARA RT.007/01, CIPETE SELATAN, CIPETE SELATAN, CILANDAK, KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12410', '081388664303', 'hardiwinata184@yahoo.com', '$2y$10$zx3JBVIy/IAVXjd8a6uOAumDBwnfXEqXrZPx11kcBJTh3qJsb0sie', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (302, 'Dicky', '3', 4, '3275040708870025', '369266408008000', NULL, 'Duren Sawit', 'Linda Ella Sari Br. S. Maha', 'K/1', 'Jl Delima Raya, Ix, 1, Malaka Sari, Duren Sawit, Kota Adm. Jakarta Timur, Dki Jakarta, 13460', 'JL DELIMA RAYA, IX, 1, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '62216697035', 'dickyki69@yahoo.com', '$2y$10$CR46BtV6xvvL4F40YlPlV.sG1QRzoKRMAf8EH8L6dbIiszr2uyoRW', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (303, 'Lim Hidayat', '3', 4, '3175070403780019', '070521471008000', NULL, 'Duren Sawit', 'Heru Waskita', 'K/2', 'Jl.Delima Raya, 5D, Malaka Sari, Duren Sawit, Kota Adm. Jakarta Timur, Dki Jakarta, 13460', 'JL.DELIMA RAYA, 5D, MALAKA SARI, DUREN SAWIT, KOTA ADM. JAKARTA TIMUR, DKI JAKARTA, 13460', '62811198521', 'limhidayat47@gmail.com', '$2y$10$T5zECxLIbnYzWQB4wZ6fj.tJGGZeL8cBYTmKPOm4zcMRYqvk0/zJy', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (304, 'Andri Janto Sudjoko', '3', 4, '3173071105620006', '076425081031000', NULL, 'Palmerah', 'Oliver Francois Tambunan', 'TK/0', 'Jl. U No. 31, Slipi, Slipi, Pal Merah, Kota Adm. Jakarta Barat, Dki Jakarta, 11410', 'JL. U NO. 31, SLIPI, SLIPI, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11410', '0218296579', 'andrijanto96@yahoo.com', '$2y$10$L9.xGQL.Ik/YsMj0aFbD5O.7iHgu6Z2XcQ6nyo.1cR.LdgryB1I6K', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (305, 'Sunardi', '3', 4, '3173071006760002', '076412204031000', NULL, 'Palmerah', 'Diah Kartika Retna Asih', 'K/3', 'Jl H Saleh, 28, Palmerah, Pal Merah, Kota Adm. Jakarta Barat, Dki Jakarta, 11480', 'JL H SALEH, 28, PALMERAH, PAL MERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11480', '085692129168', 'sunardipajak533@gmail.com', '$2y$10$uIizQZoj3HlnEg4WF7mNieVMoXYvwzQQG47NH17ovoVXFPY4M.rku', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (306, 'Tjio Suhendra', '3', 4, '3173062208600002', '076100213023000', NULL, 'Senen', 'Muchamad Fakhrudin', 'K/1', 'Plaza Atrium Lt.V Blok C-64, Senen, Senen, Senen, Kota Adm. Jakarta Pusat, Dki Jakarta, 10410', 'PLAZA ATRIUM LT.V BLOK C-64, SENEN, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '081285763362', 'tjio1919@yahoo.com', '$2y$10$5ZuibcfpbwpcSez.ejS8J.ECBTffpABRk5d.u/xf7MuePWFM.5OZq', '2026-07-15 16:33:41', '2026-07-15 16:33:41');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (307, 'Kasim Tukimin', '3', 4, '3171022308620005', '076100809023000', NULL, 'Senen', 'Muchamad Fakhrudin', 'K/1', 'Atrium Plaza Lt.V, C.77, Senen, Senen, Kota Adm. Jakarta Pusat, Dki Jakarta, 10410', 'ATRIUM PLAZA LT.V, C.77, SENEN, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10410', '081382777199', 'kasimtukimin199@gmail.com', '$2y$10$wehz5WZ9Omr9D20VOyYmpe4pmsr5nh649bdZEZ73.07L/dWSlScxO', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (308, 'Agung Sutanto', '3', 4, '3173041907561001', '091936088402000', NULL, 'Tangerang Barat', 'Gede Suarsana', 'K/0', 'Jl.Merpati Raya D17 No.9, Gebang Raya, Gebang Raya, Periuk, Kota Tangerang, Banten, 15132', 'JL.MERPATI RAYA D17 NO.9, GEBANG RAYA, GEBANG RAYA, PERIUK, KOTA TANGERANG, BANTEN, 15132', '0881010622198', 'agungsutanto929@gmail.com', '$2y$10$xuiqIcBdaAXeM09PDESmiuttDCmdkPC1T84GehxnQoKUPcGzWxT.O', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (309, 'Foeng Fi Min', '3', 4, '3671031210610004', '076525633416000', NULL, 'Tangerang Timur', 'Arni Ardiyanti', 'K/0', 'Budi Indah, Jl Kelud Ii Blok A.1 No. 26 Rt 006 Rw 07, Porisgaga, Poris Gaga, Batuceper, Kota Tangerang, Banten, 15122', 'BUDI INDAH, JL KELUD II BLOK A.1 NO. 26 RT 006 RW 07, PORISGAGA, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '6281218814902', 'foengfimin8@gmail.com', '$2y$10$CFPANprVo1OEwDhmmyL/7eATmMK2iD306uQqC4LqZipWmRqenteHS', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (310, 'Yulisna Kohar', '3', 4, '3173015001771003', '256064957416000', NULL, 'Tangerang Timur', 'Tri Bekti Utami', 'TK/0', 'Banjar Wijaya B.19B/31 Rt. 004 Rw. 15, Poris Plawad Indah, Cipondoh, Kota Tangerang, Banten, 15141', 'BANJAR WIJAYA B.19B/31 RT. 004 RW. 15, PORIS PLAWAD INDAH, CIPONDOH, KOTA TANGERANG, BANTEN, 15141', '08121588282', 'yulisnakohar@gmail.com', '$2y$10$F6VaeHz/cLFMCRcdH/JnQ.Nd.xvMrXkOmLmCpcnc5jBlz/zp1qhj.', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (311, 'Antonius Sugiarto', '3', 4, '3173050412580005', '041528902072000', NULL, 'Tanah Abang Dua', 'Hidayat Imam Bayu', 'K/0', 'Jl Kebon Jati, -, 2, Kampung Bali, Tanah Abang, Kota Adm. Jakarta Pusat, Dki Jakarta, 10250', 'JL KEBON JATI, -, 2, KAMPUNG BALI, TANAH ABANG, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10250', '628161923006', 'lijinantonius19@yahoo.com', '$2y$10$tamRj8It4mpnXueIALfpD.9zPUZWYC/v2cZREzw0p0RkJgPlijHOm', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (312, 'Udji Djohan', '3', 4, '3171020811780002', '076278837026000', NULL, 'Sawah Besar Satu', 'Handita Kusuma Dewi', 'K/2', 'Jl.P.Jayakarta Budi Rahayu I No.42 Rt.005/009 Mangga Dua Selatan, Mangga Dua Selatan, Sawah Besar, Kota Adm. Jakarta Pusat, Dki Jakarta, 10730', 'JL.P.JAYAKARTA BUDI RAHAYU I NO.42 RT.005/009 MANGGA DUA SELATAN, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '087788238982', 'djohanudji@gmail.com', '$2y$10$UgN1aqnMaPKcJH5kGxbcQukIUR.9PlHR9y3w2ObsfX9Dw.Eg8dyqO', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (313, 'Koe Sevina Octricia', '3', 4, '3173024710840002', '711333575036000', NULL, 'Grogol Petamburan', 'Oryza Aprilia', 'TK/0', 'Tanjung Duren Dalam, Vii, 14, Tanjung Duren Selatan, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'TANJUNG DUREN DALAM, VII, 14, TANJUNG DUREN SELATAN, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '081932007325', 'koesevina19@gmail.com', '$2y$10$pM2L8RHn3YJnHnYiyqBZM.b62wS.XgP4Y7xkdKS1UI2Cn2LHUrTbW', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (314, 'Olivia Ione Rafin, JD', '3', 4, '3172015410500002', '071067938047000', NULL, 'Pluit', 'Hendri Wibisono', 'TK/0', 'Kapuk Kamal, Kamal Muara, Kamal Muara, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14470', 'KAPUK KAMAL, KAMAL MUARA, KAMAL MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14470', '021235700012', 'OLIVIAiONERAFIN@YAHOO.COM', '$2y$10$ujhOhO7f5Vo5uP7Icv.bzOg1onM0GGz47/ruK7vt3IHvY1a7xtk1e', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (315, 'Safina', '3', 4, '3172027103660002', '070469572048000', NULL, 'Tanjung Priok', 'Japlis Windiyono', 'K/0', 'Jl Sunter Garden, Blok D.8, 2 E, Sunter Agung, Tanjung Priok, Kota Adm. Jakarta Utara, Dki Jakarta, 14350', 'JL SUNTER GARDEN, BLOK D.8, 2 E, SUNTER AGUNG, TANJUNG PRIOK, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14350', '0816775569', 'finasafina1922@gmail.com', '$2y$10$zklLXQ03BJKtcv2RCZDi5edLReuAfdWcsC5SQak1dX5D5XuPj8vMC', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (316, 'Sindjaja Jonany', '3', 4, '3173042409640005', '', NULL, 'Pluit', 'Ganendra Edo Satwika', 'K/3', 'Jl Walet Indah I, 21, Kapuk Muara, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14460', 'JL WALET INDAH I, 21, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '628158007621', 'sindjajajonany8223@yahoo.com', '$2y$10$06JuvdocEZoLg1vqgnxR4OtvhUIxvpjdOERKtyWJyZOqDQSPOsPj2', '2026-07-15 16:33:42', '2026-07-15 18:41:06');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (317, 'Tjong Kian Tjoeng', '3', 4, '3171021801540002', '068139740075000', NULL, 'Sawah Besar Dua', 'Lince Ani Fransiska', 'K/0', 'Jl Kartini Iv Dalam, 179, Kartini, Sawah Besar, Kota Adm. Jakarta Pusat, Dki Jakarta, 10750', 'JL KARTINI IV DALAM, 179, KARTINI, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10750', '08161827632', 'tjongkian7@gmail.com', '$2y$10$Zm4Cr/8GVMnD3oCOWyo2meOAHGbrUt0lsUwWyjO/cFOIgZpzDsNHq', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (318, 'Amadeus Yeremia Pribowo', '3', 4, '3174073003850009', '#N/A', NULL, 'Kebayoran Baru Satu', '', '', 'Jl Ciomas V No.6Rt 007 Rw 001, Rawa Barat, Kebayoran Baru,Kota Adm. Jakarta Selatan, Dki Jakarta, 12180', 'JL CIOMAS V NO.6RT 007 RW 001, RAWA BARAT, KEBAYORAN BARU,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12180', '6282112928928', 'amadeus.pribowo@gmail.com', '$2y$10$uEOK9PKV1gOwBqTE9oTMnepETwjbPHTvcbo6EAyLfc51rjQJEFl5O', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (319, 'Christine Yuliani', '3', 4, '9171024407910002', '738759299952000', NULL, 'Jayapura', 'Tan Christian Nathanel Budiman', 'TK/0', 'Jl. Perikanan, 26, Hamadi, Jayapura Selatan, Kota Jayapura, Papua, 99126', 'JL. PERIKANAN, 26, HAMADI, JAYAPURA SELATAN, KOTA JAYAPURA, PAPUA, 99126', '082399944445', 'dr.christineyuliani@gmail.com', '$2y$10$yv.xETpmW7dB4f/6btnikeeztERjmhGHt1qhye1zFvjNZ7Wu4p3FC', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (320, 'Dely', '3', 4, '3173040109790002', '594551871033000', NULL, 'Tambora', 'Rizki Ilham Akbar', 'K/2', 'Jl Krendang Tengah I, 86, Krendang, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11260', 'JL KRENDANG TENGAH I, 86, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '0216296149', 'dely191919@gmail.com', '$2y$10$fR2WRTwmvQPrNO6Z7GXnVO3pQSjxCski6lJ9k0G/twpcHoQpcyauq', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (321, 'Enggitawati Kusnadi', '3', 4, '3173045605390002', '#N/A', NULL, 'Tambora', '', '', 'Jalan Krendang Timur Rt 003 Rw 001, Krendang, Tambora,Kota Adm. Jakarta Barat, Dki Jakarta', 'JALAN KRENDANG TIMUR RT 003 RW 001, KRENDANG, TAMBORA,KOTA ADM. JAKARTA BARAT, DKI JAKARTA', '85710699866', 'ENGGITAWATIKUSNADI@GMAIL.COM', '$2y$10$g2vLhOwu7Li7bRdLTI57oeMRa4DoRB/y3vVt7QZaW6pFZpBF3miHm', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (322, 'Dra. Ny Francisca Winardi', '3', 4, '3174035206410001', '#N/A', NULL, 'Mampang Prapatan', '', '', 'Jl Canadianti No.1-Art 001 Rw 008, Pela Mampang, Mampang Prapatan,Kota Adm. Jakarta Selatan, Dki Jakarta, 12720', 'JL CANADIANTI NO.1-ART 001 RW 008, PELA MAMPANG, MAMPANG PRAPATAN,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12720', '081284224317', 'winardifracisca@gmail.com', '$2y$10$rJwQPNjrP.HbHVYLRdIc8.J3h8kevMp2hKeTocG5ozvWDIIenGNe2', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (323, 'Dicky Wirayadi Hadipurnama', '3', 4, '3173040507510002', '064691512033000', NULL, 'Tambora', 'Riska Septiana Estutik', 'K/0', 'Jl Gg. Toge No.7, 7, Tambora, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11220', 'JL GG. TOGE NO.7, 7, TAMBORA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11220', '', 'dickdicky1920@gmail.com', '$2y$10$3CgC9KMIV8lvsNGHgGc82eZEFmruye840wzGejiGDExbTwIQiQ8F.', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (324, 'Eric Saibun Yolinta', '3', 4, '3173021501510005', '066255183036000', NULL, 'Grogol Petamburan', 'Zulmy Agung Pambudi', 'K/0', 'Jl Jelambar Ilir, 22, Jelambar Baru, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11460', 'JL JELAMBAR ILIR, 22, JELAMBAR BARU, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '62818981218', 'ericsaibunyolinta@gmail.com', '$2y$10$lMSgwdToXjVcm5y20QiU7.lssjgcBhUjyCgNqR/l3pnAATFEjHLE.', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (325, 'Feliciana Kartadinata', '3', 4, '3171016409850002', '601410541029000', NULL, 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'Jl Kh Hasyim Ashari, 54-A, Duri Pulo, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10140', 'JL KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '081286688869', 'felicianakartadinataa@gmail.com', '$2y$10$JfLScRzvxRMFA.zBEvsvfOHPW4Z29tkKn2fChyjkuhCw2jPZfzV.u', '2026-07-15 16:33:42', '2026-07-15 16:33:42');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (326, 'Felix Salim', '3', 4, '3173021802870004', '#N/A', NULL, 'Grogol Petamburan', '', '', '', 'JL HADIAH BLOK DIII/973 RT 008 RW 001, JELAMBAR, GROGOL PETAMBURAN,KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '08179836861', 'felix.lim@live.com', '$2y$10$t/ZMRZHhGlwbuV016la9J.f9mVb.oZgiS.Ib/HQ97IXrMxA/CJpbK', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (327, 'F.X Supriyadi H.S', '3', 4, '3174070812520006', '#N/A', NULL, 'Kebayoran Baru Satu', '', '', 'Jl Ciomas V No.6Rt 007 Rw 001, Rawa Barat, Kebayoran Baru,Kota Adm. Jakarta Selatan, Dki Jakarta, 12180', 'JL CIOMAS V NO.6RT 007 RW 001, RAWA BARAT, KEBAYORAN BARU,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12180', '0816746745', 'fxsupriyadi812@gmail.com', '$2y$10$mdjO6Y509kYMMfHWMmr3guP4jWt4MWEV3o/Pf1ryKj3LeWNWB0jwm', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (328, 'Gabriella', '3', 4, '3173044412971001', '#N/A', NULL, 'Kalideres', '', '', 'Perumahan Daan Mogot Baru, Kintamani Timur 3 Ll No.16Rt 000 Rw 000, Kalideres, Kalideres, Kota Adm. Jakarta Barat, Dki Jakarta, 11840', 'PERUMAHAN DAAN MOGOT BARU, KINTAMANI TIMUR 3 LL NO.16RT 000 RW 000, KALIDERES, KALIDERES, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11840', '082261616109', 'gabriella.97@yahoo.com', '$2y$10$x/F8NWvSarI0GUWYSQmh7ub1ETaYzJB4XYN8dDe.n4j.JTfvF0WhK', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (329, 'Gouw Keng Hoa', '3', 4, '3173045912540002', '609298583033000', NULL, 'Tambora', 'Laila Nur Wahidah', 'TK/0', 'Kp Krendang, Duri Utara, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'KP KRENDANG, DURI UTARA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '081296988658', 'gouwkenghoaa@gmail.com', '$2y$10$NY8q4GAg2Px5TH7qgZZAJe0eR1ZobViYr.5svQq7QFwOz9OXoeZYe', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (330, 'Gunawan Widjaja', '3', 4, '3171020711600002', '684564404033000', NULL, 'Sawah Besar Satu', 'Muhammad Ismail Marzuqi', 'TK/0', 'Jl Mangga Dua Abdad C, 50, Mangga Dua Selatan, Sawah Besar, Kota Adm. Jakarta Pusat, Dki Jakarta, 10730', 'JL MANGGA DUA ABDAD C, 50, MANGGA DUA SELATAN, SAWAH BESAR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10730', '085881389934', 'widjajagunawan0@gmail.com', '$2y$10$FntAE3F/FscdFdN/pO9I7uIapVgRQWmuj0JEZfmyE/Ei6wtq2tDjy', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (331, 'Handy Tjahyadi', '3', 4, '3172062010670001', '065196412043000', NULL, 'Kelapa Gading', 'Lesty Phytaloka', 'K/1', 'Jl Gading Kusuma, Gk 8, 2, Kelapa Gading Timur, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14240', 'JL GADING KUSUMA, GK 8, 2, KELAPA GADING TIMUR, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '62813065196412', 'handytjah19@yahoo.com', '$2y$10$83qV5JkQVIc8vJCDvv7ABuU2RPYVnBXouQQqPqiB8aAoY.WRv2iGq', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (332, 'Hardy Susilo', '3', 4, '3173042609640003', '#N/A', NULL, 'Tambora', '', '', 'Jl Terate No.31 Rt.009 Rw.003, Jembatan Lima Rt 000 Rw 000, Jembatan Lima, Tambora,Kota Adm. Jakarta Barat, Dki Jakarta, 11250', 'JL TERATE NO.31 RT.009 RW.003, JEMBATAN LIMA RT 000 RW 000, JEMBATAN LIMA, TAMBORA,KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '08161121522', 'hardysosilo26@gmail.com', '$2y$10$ZO9GpxoWo0Zjq/nopHTkk.cV7xjbyAJAs1zMmGfJ/Mrz5sc6nBRKa', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (333, 'Haryanto Djojoe Buntoro', '3', 4, '3172011604670003', '#N/A', NULL, 'Kebayoran Baru Dua', '', '', 'Jl Lamandau I No.19Rt 003 Rw 007, Kramat Pela, Kebayoran Baru,Kota Adm. Jakarta Selatan, Dki Jakarta, 12130', 'JL LAMANDAU I NO.19RT 003 RW 007, KRAMAT PELA, KEBAYORAN BARU,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12130', '0816940397', 'harbun88@hotmail.com', '$2y$10$Me412K0yvy/7F/wYPls2FOGTb2upFy35.AUIUn5o9chJJmFFXtly.', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (334, 'Haryono Kuswanto', '3', 4, '3172011811650003', '064493083041000', NULL, 'Penjaringan', 'Gani Syabani', 'K/3', 'Jl Teluk Gong Blok N3/48, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL TELUK GONG BLOK N3/48, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '628161162915', 'haryonokuswanto99@yahoo.com', '$2y$10$iQm5PG1T4M4KUF56SByk0O.qX7tOTYwKrwNpjemXg9Uo0hpGf2cR.', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (335, 'Hauw Bok Soei', '3', 4, '3173042212700009', '594790560033000', NULL, 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'Jl Songsi Raya, 22, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL SONGSI RAYA, 22, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '6281215882824', 'hauwbokk@gmail.com', '$2y$10$zSfgCf9S8fBCNhAGMYDVeuzjosPdTwg5unifgTK1JVqWI2A9PdKUK', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (336, 'Hendra Koesnandar', '3', 4, '3173042405840015', '594688335033000', NULL, 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'Jl Khm Mansyur No 30B, 30B, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL KHM MANSYUR NO 30B, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '62216909747', 'KOESNANDARHENDRA@YAHOO.COM', '$2y$10$O7.baRuaTf.2g8reuyCDdOuGl9PyiIzd5lXZSyGHZhDwOStJi1cEK', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (337, 'Hendrik Koesnandar', '3', 4, '3173042405840016', '594688319033000', NULL, 'Tambora', 'Machrizal Perdana Putra', 'TK/0', 'Jl Khm Mansyur, 30B, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL KHM MANSYUR, 30B, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '08161891575', 'henrikoesnandar@gmail.com', '$2y$10$aCTtTMEyMuFJg40D8owm8u8it.clUCv.ouMZ2eRWkKsBJ5OAgSbii', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (338, 'Hongdoras Limantoro', '3', 4, '3173050212530003', '065882946039000', NULL, 'Kebon Jeruk Dua', 'Bondan Himawan', 'K/0', 'Komplek Green Garden Blok, A5, 12, Kedoya Utara, Kebon Jeruk, Kota Adm. Jakarta Barat, Dki Jakarta, 11520', 'KOMPLEK GREEN GARDEN BLOK, A5, 12, KEDOYA UTARA, KEBON JERUK, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11520', '08128015571', 'hongdorasl@gmail.com', '$2y$10$c1ouasakNdgkrrcW0ghiKOys0W1wgMJDJrJwQtaPQgQD6eKJVNT6C', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (339, 'Indra Gunawan', '3', 4, '3173040410910004', '800629834033000', NULL, 'Tambora', 'Dian Setyawan', 'K/1', 'Jl. Angke Jaya Vi, 1, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'JL. ANGKE JAYA VI, 1, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '628999904718', 'Test.slave888@gmail.com', '$2y$10$7XtF9.ZTfB83zgJppv47c.XGyJxAxJazvWBBdYhLGboqeytZ.NiB6', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (340, 'Indriany', '3', 4, '3171015407430003', '768517708029000', NULL, 'Gambir Tiga', 'Suci Lestari', 'TK/0', 'Jl Duri A Ii, 1, Duri Pulo, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10140', 'JL DURI A II, 1, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '08159064396', 'indrianyny@gmail.com', '$2y$10$Gr0yjapLraZHYBK65QKl6u0.5w.1sjZMjGMD8K83CDcESu0mikFde', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (341, 'Jimmy Tirta', '3', 4, '3172012102890003', '768341000047000', NULL, 'Pluit', 'Endang Suwarni', 'K/0', 'Taman Grisenda, B1, 75, Kapuk Muara, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14460', 'TAMAN GRISENDA, B1, 75, KAPUK MUARA, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14460', '6285379009099', 'jimmytirt@gmail.com', '$2y$10$HOb9jCAUWO4eFXzJrgLU/OXIq/uPQMGj34GYI1bStBlrmejQjW1R2', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (342, 'Johny Tjahyadi', '3', 4, '3172061104530001', NULL, NULL, 'Senen', 'Rachma Hidayanti', 'TK/0', 'Jl.Kalibaru Timur V, 54L, Bungur, Senen, Kota Adm. Jakarta Pusat, Dki Jakarta, 10460', 'JL.KALIBARU TIMUR V, 54L, BUNGUR, SENEN, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10460', '081932807313', 'johnydeep1919@gmail.com', '$2y$10$GNoxNTPEFEAg3IURnmMycevZghTn14dx4AVFyg7y9CpJgskR3WyLm', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (343, 'Jong Khim Wong', '3', 4, '3173040708660013', '076523497033000', NULL, 'Tambora', 'Dian Setyawan', 'TK/0', 'Jl.Samarasa Iii No.20, Angke, Angke, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11290', 'JL.SAMARASA III NO.20, ANGKE, ANGKE, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11290', '6281806886366', 'jongkhimwong@gmail.com', '$2y$10$w8B27ii0X9AJhOWKmF3.r.qzOO0KqB5GVWLMZjPG/u6PTCfca/Lu.', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (344, 'Kelvin Yohannes', '3', 4, '3671030405940003', '423242254416000', NULL, 'Tangerang Timur', 'Arni Ardiyanti', 'TK/0', 'Kelud 2, A1, 26, Poris Gaga, Batuceper, Kota Tangerang, Banten, 15122', 'KELUD 2, A1, 26, PORIS GAGA, BATUCEPER, KOTA TANGERANG, BANTEN, 15122', '081290326683', 'kelvinnyo94@gmail.com', '$2y$10$cIjHpkhZuzBCGV4W6dkQ0erpOM8rzJ5aYvi3ROY1runqVwKNCm.xy', '2026-07-15 16:33:43', '2026-07-15 16:33:43');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (345, 'Kusnadi Setiawan', '3', 4, '3671031505970004', '#N/A', NULL, 'Tangerang Timur', '', 'TK/0', 'Budi Indah Jl. Kelud Ii Blok Ai No.26Rt 006 Rw 007, Poris Gaga, Batuceper,Kota Tangerang, Banten, 15122', 'BUDI INDAH JL. KELUD II BLOK AI NO.26RT 006 RW 007, PORIS GAGA, BATUCEPER,KOTA TANGERANG, BANTEN, 15122', '085697786772', 'kusnadiff5@gmail.com', '$2y$10$iQmLGF6JKsxYoDPCeMceNOenuXmSZKM3M5/hV7rjYsY47her6UiSm', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (346, 'Lee Hak Man', '3', 4, '0259861037413000', '259861037413000', NULL, 'Cikarang Selatan', 'Isrofah Wijayanti', 'K/2', 'L. Mh. Thamrin B-16 Lippo Cikarang Rt. 000 Rw. 000, Cibatu, Cikarang Selatan, Kab. Bekasi, Jawa Barat, 17855', 'L. MH. THAMRIN B-16 LIPPO CIKARANG RT. 000 RW. 000, CIBATU, CIKARANG SELATAN, KAB. BEKASI, JAWA BARAT, 17855', '622189920692', 'leehakman78@gmail.com', '$2y$10$JAK1i7Qr4ZmDaGLR01lbC.Uq.81X0ZN4.iqImdLxj/eac7nCfD1DK', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (347, 'Lenny Diana', '3', 4, '3173026507900003', '612036046036000', NULL, 'Grogol Petamburan', '', '', 'Jl Hadiah Blok Diii/973 Rt 008 Rw 001, Jelambar, Grogol Petamburan,Kota Adm. Jakarta Barat, Dki Jakarta, 11460', 'JL HADIAH BLOK DIII/973 RT 008 RW 001, JELAMBAR, GROGOL PETAMBURAN,KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11460', '0817252590', 'not.lennydiana@gmail.com', '$2y$10$tPTw80BaBAKhabxSaD5hS.7vNwfHlzCgHlSmTqBl2x6JQQH5osJRW', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (348, 'Lim Tiong Kie', '3', 4, '3173040701510003', '061882171033000', NULL, 'Tambora', 'Rizki Ilham Akbar', 'K/0', 'Jl Kp Krendang, Krendang, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11260', 'JL KP KRENDANG, KRENDANG, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11260', '0816470907', 'tiongkiel@gmail.com', '$2y$10$gMQKofBFT1DKLuu74j0rtO4U/Z5NRA/CYi3gS8/gSruF7LIsRvN6W', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (349, 'Martin Raditya Sugiarto', '3', 4, '3173040811850007', '585219488033000', NULL, 'Tambora', 'Arum Pawestri', 'K/0', 'Jl Jamblang I, 50, Duri Selatan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11270', 'JL JAMBLANG I, 50, DURI SELATAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11270', '6282117706296', 'martinpajak0811@gmail.com', '$2y$10$N8jiua.Z8WTxm5N3nF8PL.OP78A3P6Ck6DKrAZRh2VmUSJbUFnb/C', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (350, 'Margareth Nicole', '3', 4, '3174075105970003', '#N/A', NULL, 'Kebayoran Baru Dua', '', '', '', 'JL LAMANDAU I NO.19RT 003 RW 007, KRAMAT PELA, KEBAYORAN BARU,KOTA ADM. JAKARTA SELATAN, DKI JAKARTA, 12130', '081388189767', 'NICOLEMARGARETH128@GMAIL.COM', '$2y$10$zcP2WLnJuBioGjxbRFq13.8tNqbwHZRShGMy5Ok2q/pbAxyAjaOli', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (351, 'Melly Kurniawan', '3', 4, '3172064610680002', '095839684043000', NULL, 'Kelapa Gading', 'Gibran Kurniawan N', 'TK/0', 'Apt City Home, Tower Miami Bay Lt 1 No. 11 Rt 007 Rw 019 Kelapa Gading Barat, Kelapa Gading Barat, Kelapa Gading, Kota Adm. Jakarta Utara, Dki Jakarta, 14240', 'APT CITY HOME, TOWER MIAMI BAY LT 1 NO. 11 RT 007 RW 019 KELAPA GADING BARAT, KELAPA GADING BARAT, KELAPA GADING, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14240', '02168710485', 'melykurni99@gmail.com', '$2y$10$PBEGhPM08W.KoZC15LR9gOFX.fC8/I7f8.qCPiXDIPtdbT/FY28oy', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (352, 'Michael', '3', 4, '3173022010920004', '809973936036000', NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'Jl. Alpukat Vii, 4, Tanjung Duren Utara, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'JL. ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '6287808780871', 'bonifasiusmichael92@gmail.com', '$2y$10$2eAC2b6h6YmFBWw1ppXGeO7YxMuMoSnsmx5SXS4iwkN.6EVlBQ1c.', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (353, 'Puspa Dewi', '3', 4, '3173046509740004', '584261549033000', NULL, 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'Jl Arabika No.15, Jakarta Barat, Pekojan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11240', 'JL ARABIKA NO.15, JAKARTA BARAT, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '0216922616', 'ohdewipuspa@yahoo.com', '$2y$10$r5iM032Aou/4NHQL9n/YPuwRk7WXwSQwwPJFuizgs4AvBSL/AYqKW', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (354, 'Rahman Halim', '3', 4, '3173070204650003', '076439231031000', NULL, 'Palmerah', '', '', '', '', '', 'rahmanhalimm21@gmail.com', '$2y$10$QKRza3f2rNgCFHMRHf4.nekhHUEo8Mu0cHm4cGoW7LDOqhzCh7vjm', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (355, 'Rio Gunawan Sejati', '3', 4, '3171016206840003', '493304083028000', NULL, 'Gambir Dua', 'Hendra Rahma Wiguna', 'TK/0', 'Jl Kebon Jahe Ii No.14 No 14 Rt.006 Rw.02, Petojo Selatan, Petojo Selatan, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10160', 'JL KEBON JAHE II NO.14 NO 14 RT.006 RW.02, PETOJO SELATAN, PETOJO SELATAN, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10160', '087886687898', 'rigunse@gmail.com', '$2y$10$.//3fWqSrJ47AK/2XT3nReRoyn/fPm/ZSNSXFCAe2tg0XFWpcJLqa', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (356, 'Rita Koesnandar', '3', 4, '3173045302610006', '594688343033000', NULL, 'Tambora', 'Dian Krisnasari', 'TK/0', 'Khm Mansyur No.30B Rt.001 Rw.002, Tanah Sereal, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'KHM MANSYUR NO.30B RT.001 RW.002, TANAH SEREAL, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '0811145152', 'ritakoeskoes19@yahoo.com', '$2y$10$ywfi1TA8FWZLKCJGUMbaOuSgZ0obV04Vj2UBo/GB2Fg2N8uno7ZJu', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (357, 'Rizal Kartadinata', '3', 4, '3171011607910001', '659705925029000', NULL, 'Gambir Tiga', 'Annisa Perwitasari', 'TK/0', 'Kh Hasyim Ashari, 54-A, Duri Pulo, Gambir, Kota Adm. Jakarta Pusat, Dki Jakarta, 10140', 'KH HASYIM ASHARI, 54-A, DURI PULO, GAMBIR, KOTA ADM. JAKARTA PUSAT, DKI JAKARTA, 10140', '6289636360091', 'rizalkartadinataaa@gmail.com', '$2y$10$bCvlq4nylBnJTmFLPSNgbe/kmz.sJSxBESsxmSqiwUf05nGLDz4jO', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (358, 'Ronald Russel', '3', 4, '3173022302900004', '550725881036000', NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'TK/0', 'Jl. Alpukat Vii No.4 Rt.008 Rw.002, Tanjung Duren Utara, Tanjung Duren Utara, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'JL. ALPUKAT VII NO.4 RT.008 RW.002, TANJUNG DUREN UTARA, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '081229922080', 'vincentsius.russell@gmail.com', '$2y$10$pMdAKuONGQAg/tyiIt7bF.FKB37sVMb5/fRALX6vtbKMuEW2yoDca', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (359, 'Rudy Susanto', '3', 4, '3173040202610004', '814779757033000', NULL, 'Tambora', 'Machrizal Perdana Putra', 'K/1', 'Jl Petak Serani Iii, 48, Tanah Sereal, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11210', 'JL PETAK SERANI III, 48, TANAH SEREAL, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11210', '085311690052', 'rudysusaantooo@gmail.com', '$2y$10$IZH7YPXA4k3gDuO30Ao/AOrOL4g2PsSbV6MrpWkaa.OAkZehWUA6O', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (360, 'Sarianto Jony', '3', 4, '3173042605360001', '076524867033000', NULL, 'Tambora', 'Satriyo Dwi Yulisetyawan', 'TK/0', 'Jl Pengukiran Raya No.40 A, Pekojan, Pekojan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11240', 'JL PENGUKIRAN RAYA NO.40 A, PEKOJAN, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '081385561767', 'sariantojony8@gmail.com', '$2y$10$Y47a5OfmEZ5028A4sT.53OffWkfvR3bzCKS4iBaMRdChS1Zx.WmNm', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (361, 'Suhendra Tirtaputra', '3', 4, '3172011205650009', '144329570041000', NULL, 'Penjaringan', 'Imam Taj\'ri', 'TK/0', 'Jl Jembatan Ii Gg Petasan / 114 Rt 004/002 Pejagalan, Pejagalan, Penjaringan, Kota Adm. Jakarta Utara, Dki Jakarta, 14450', 'JL JEMBATAN II GG PETASAN / 114 RT 004/002 PEJAGALAN, PEJAGALAN, PENJARINGAN, KOTA ADM. JAKARTA UTARA, DKI JAKARTA, 14450', '622166695306', 'suhendratirtaputra5@gmail.com', '$2y$10$288U6oOzXlrW9yJuYF7sUOsbFRvTGQu1vHBl0hbdx4NSd6lvNBHZy', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (362, 'Sukim Hartono', '3', 4, '3173041405580006', '175850601033000', NULL, 'Tambora', 'Dhani Kristanti', 'K/2', 'Jl Khm Mansyur 217 Rt.004 Rw.002, Jembatan Lima, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11250', 'JL KHM MANSYUR 217 RT.004 RW.002, JEMBATAN LIMA, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11250', '08121931806', 'SUKIMHARTONO19@gmail.COM', '$2y$10$dqegmxqLT4lyi504A1uQwOvH9CHXtGpFtCyY7uvvHxtpCy2gmXsAK', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (363, 'Sung Njit Bui', '3', 4, '3173011402600005', '071338727034000', NULL, 'Cengkareng', 'Ikhwanussidiq Suhartono', 'K/0', 'Taman Palem Lestari B.I/A.9, Cengkareng Barat, Cengkareng Barat, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11730', 'TAMAN PALEM LESTARI B.I/A.9, CENGKARENG BARAT, CENGKARENG BARAT, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11730', '081213174077', 'sungnjitbuiii@gmail.com', '$2y$10$j5MDKmprhHZIQa09ZvF.qOJkoiKwNGdwuEUgQ0BVRd1foNIbTqV4O', '2026-07-15 16:33:44', '2026-07-15 16:33:44');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (364, 'Supriyono', '3', 4, '3173012303810026', '811965540034000', NULL, 'Cengkareng', 'Martua Halomon Sihombing', 'K/2', 'Jl. Pedongkelan, Kapuk, Cengkareng, Kota Adm. Jakarta Barat, Dki Jakarta, 11720', 'JL. PEDONGKELAN, KAPUK, CENGKARENG, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11720', '085894279208', 'supriyonosuprii121@gmail.com', '$2y$10$nup7hOl365/ry2rW7AncL.j7ln2VRbiJn/s394KoUU0fCHI25n1lC', '2026-07-15 16:33:45', '2026-07-15 16:33:45');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (365, 'Tania Theresa Halim', '3', 4, '3173074811961001', '81777157903100', NULL, 'Palmerah', '', '', 'Jl. Anggrek Rosliana Vii No.11Rt 012 Rw 006, Kemanggisan, Palmerah, Kota Adm. Jakarta Barat, Dki Jakarta 11480', 'JL. ANGGREK ROSLIANA VII NO.11RT 012 RW 006, KEMANGGISAN, PALMERAH, KOTA ADM. JAKARTA BARAT, DKI JAKARTA 11480', '08119882121', 'taniatheresahalim@gmail.com', '$2y$10$Nz0HAiASK5cKlmasdMMhCOAUPsBXvGb34jotiXNK.3BCsmYkxj1ni', '2026-07-15 16:33:45', '2026-07-15 16:33:45');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (366, 'Tony Esrianto', '3', 4, '3173020506600009', '066258906036000', NULL, 'Grogol Petamburan', 'Kristyanu Widyanto', 'K/1', 'Jl Alpukat Vii, 4, Tanjung Duren Utara, Grogol Petamburan, Kota Adm. Jakarta Barat, Dki Jakarta, 11470', 'JL ALPUKAT VII, 4, TANJUNG DUREN UTARA, GROGOL PETAMBURAN, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11470', '62811170029', 'tony_esriantotio@yahoo.com', '$2y$10$FezvtjZp52FFt.W9HIhoSONKHILD7fnb2OmZbHYY4O2FAgxh/94qu', '2026-07-15 16:33:45', '2026-07-15 16:33:45');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (367, 'Wong Song Moy', '3', 4, '3173046906480001', '584261556033000', NULL, 'Tambora', 'Fibri Kurniawan Sunu', 'TK/0', 'Jl Arabika, 15, Pekojan, Tambora, Kota Adm. Jakarta Barat, Dki Jakarta, 11240', 'JL ARABIKA, 15, PEKOJAN, TAMBORA, KOTA ADM. JAKARTA BARAT, DKI JAKARTA, 11240', '0216904724', 'wongsongmoy@yahoo.com', '$2y$10$.KawxgVENS4zSglz9HGTxukbubPAxWY2MsSYRc.MBiQ1ujAP9mLwa', '2026-07-15 16:33:45', '2026-07-15 16:33:45');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `client_role_id`, `npwp`, `npwp_cabang`, `npwp_cabang_id`, `kpp`, `AR`, `ptkp`, `alamat_npwp`, `alamat_tagihan`, `no_telephone`, `email`, `password`, `created_at`, `updated_at`) VALUES (368, 'Yessica', '3', 4, '3173024502920005', '421122813416000', NULL, 'Tangerang Timur', 'Moh Ikhsan Iskandar', 'TK/0', 'Permata Raya, C2, 37, Cipondoh Makmur, Cipondoh, Kota Tangerang, Banten, 15148', 'PERMATA RAYA, C2, 37, CIPONDOH MAKMUR, CIPONDOH, KOTA TANGERANG, BANTEN, 15148', '081298107321', 'yessica.chenyiping@gmail.com', '$2y$10$SW81/uzwbaUmd6YKgOCvBelK9VRRRNyq.dwb1QIbhNJv0hwAYhBAS', '2026-07-15 16:33:45', '2026-07-15 16:33:45');
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
INSERT INTO `cms_kategori_lampiran` (`id`, `label`, `created_at`, `updated_at`) VALUES (1, 'KAS', '2026-06-27 10:17:24', '2026-07-13 16:34:09');
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
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_lampiran_spt_detail
-- ----------------------------
BEGIN;
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (89, 316, 2025, '0102', 'TABUNGAN', '30610081702', 'SINDJAJA JONANY', 'STANDARD CHARTERED BANK', 'Indonesia', 'IDR', 2025, 395266344.00, 395266344.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (90, 316, 2025, '0102', 'TABUNGAN', '30607686992', 'SINDJAJA JONANY', 'STANDARD CHARTERED BANK', 'Indonesia', 'IDR', 2025, 76528563.00, 76528563.03, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (91, 316, 2025, '0102', 'TABUNGAN', '306812112560', 'ROSALINA CHANDRA', 'STANDARD CHARTERED BANK', 'Indonesia', 'USD', 2025, 7314772.00, 436.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (92, 316, 2025, '0102', 'TABUNGAN', '010210020072665', 'SINDJAJA JONANY', 'BANK MEGA', 'Indonesia', 'IDR', 2025, 129148067.00, 129148067.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (93, 316, 2025, '0102', 'TABUNGAN', '010210020079229', 'ROSALINA CHANDRA', 'BANK MEGA', 'Indonesia', 'IDR', 2025, 121185719.00, 121185719.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (94, 316, 2025, '0102', 'TABUNGAN', '010212029003270', 'SINDJAJA JONANY', 'BANK MEGA', 'Indonesia', 'USD', 2025, 38368999.00, 2287.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (95, 316, 2025, '0102', 'TABUNGAN', '010210036010740', 'SINDJAJA JONANY', 'BANK MEGA', 'Indonesia', 'IDR', 2025, 2114766133.00, 2114766133.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (96, 316, 2025, '0104', 'DEPOSITO', '0102100200360006730', 'ROSALINA CHANDRA', 'BANK MEGA', 'Indonesia', 'IDR', 2025, 1576324773.00, 1576324773.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (97, 316, 2025, '0104', 'DEPOSITO', '010210036007967', 'ROSALINA CHANDRA', 'BANK MEGA', 'Indonesia', 'IDR', 2025, 500000000.00, 500000000.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (98, 316, 2025, '0102', 'TABUNGAN', '5910502699', 'SINDJAJA JONANY', 'BANK CENTRAL ASIA', 'Indonesia', 'IDR', 2025, 623690638.00, 623690638.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (99, 316, 2025, '0102', 'TABUNGAN', '8740285689', 'SINDJAJA JONANY', 'BANK CENTRAL ASIA', 'Indonesia', 'IDR', 2025, 298564906.00, 298564906.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (100, 316, 2025, '0102', 'TABUNGAN', '8740530683', 'SINDJAJA JONANY', 'BANK CENTRAL ASIA', 'Indonesia', 'USD', 2025, 279018287.00, 16631.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (101, 316, 2025, '0102', 'TABUNGAN', '8740185668', 'ROSALINA CHANDRA', 'BANK CENTRAL ASIA', 'Indonesia', 'IDR', 2025, 158216505.00, 158216505.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (102, 316, 2025, '0102', 'TABUNGAN', '8740351711', 'ROSALINA CHANDRA', 'BANK CENTRAL ASIA', 'Indonesia', 'IDR', 2025, 769467459.00, 769467459.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (103, 316, 2025, '0102', 'TABUNGAN', '5910700598', 'ROSALINA CHANDRA', 'BANK CENTRAL ASIA', 'Indonesia', 'USD', 2025, 169179268.00, 10084.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (104, 316, 2025, '0102', 'TABUNGAN', '0702102299', 'SINDJAJA JONANY', 'BANK PAN INDONESIA', 'Indonesia', 'IDR', 2025, 117449710.00, 117449710.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (105, 316, 2025, '0102', 'TABUNGAN', '0704400221', 'SINDJAJA JONANY', 'BANK PAN INDONESIA', 'Indonesia', 'USD', 2025, 280679210.00, 16730.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (106, 316, 2025, '0102', 'TABUNGAN', '0702013221', 'ROSALINA CHANDRA', 'BANK PAN INDONESIA', 'Indonesia', 'IDR', 2025, 122172254.00, 122172254.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (107, 316, 2025, '0102', 'TABUNGAN', '702531238600', 'SINDJAJA JONANY', 'BANK CIMB NIAGA', 'Indonesia', 'IDR', 2025, 629283803.00, 629283803.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (108, 316, 2025, '0102', 'TABUNGAN', '700884870600', 'SINDJAJA JONANY', 'BANK CIMB NIAGA', 'Indonesia', 'IDR', 2025, 53819698.00, 53819698.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (109, 316, 2025, '0102', 'TABUNGAN', '701031763000', 'ROSALINA CHANDRA', 'BANK CIMB NIAGA', 'Indonesia', 'IDR', 2025, 19949834.00, 19949834.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (110, 316, 2025, '0102', 'TABUNGAN', '27810193121', 'ROSALINA CHANDRA', 'BANK OCBC NISP', 'Indonesia', 'IDR', 2025, 282662537.00, 282662537.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (111, 316, 2025, '0102', 'TABUNGAN', '1680011168885', 'ROSALINA CHANDRA', 'BANK MANDIRI', 'Indonesia', 'IDR', 2025, 69884414.00, 69884414.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (112, 316, 2025, '0102', 'TABUNGAN', '016077380800', 'SINDJAJA JONANY OR ROSALINA CHANDRA', 'BANK HSBC INDONESIA', 'Indonesia', 'USD', 2025, 76737998.00, 4574.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (113, 316, 2025, '0102', 'TABUNGAN', '016075723808', 'SINDJAJA JONANY', 'BANK HSBC INDONESIA', 'Indonesia', 'IDR', 2025, 1031955.00, 1031955.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (114, 316, 2025, '0102', 'TABUNGAN', '016060519835', 'ROSALINA CHANDRA', 'BANK HSBC INDONESIA', 'Indonesia', 'IDR', 2025, 5105020.00, 5105020.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (115, 316, 2025, '0102', 'TABUNGAN', '016075723800', 'SINDJAJA JONANY', 'BANK HSBC INDONESIA', 'Indonesia', 'USD', 2025, 234878.00, 14.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (116, 316, 2025, '0102', 'TABUNGAN', '016060519808', 'ROSALINA CHANDRA', 'BANK HSBC INDONESIA', 'Indonesia', 'IDR', 2025, 144021615.00, 144021615.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (117, 316, 2025, '0102', 'TABUNGAN', '1080101218', 'SINDJAJA JONANY', 'BANK MAYBANK INDONESIA', 'Indonesia', 'IDR', 2025, 189680120.00, 189680120.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (118, 316, 2025, '0102', 'TABUNGAN', '1080109987', 'ROSALINA CHANDRA', 'BANK MAYBANK INDONESIA', 'Indonesia', 'IDR', 2025, 99440095.00, 99440095.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (119, 316, 2025, '0102', 'TABUNGAN', '1120093790', 'SINDJAJA JONANY', 'BANK DBS INDONESIA', 'Indonesia', 'IDR', 2025, 6958452.00, 6958452.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (120, 316, 2025, '0102', 'TABUNGAN', '1120616713', 'ROSALINA CHANDRA', 'BANK DBS INDONESIA', 'Indonesia', 'IDR', 2025, 79419949.00, 79419949.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (121, 316, 2025, '0102', 'TABUNGAN', '1120239370', 'SINDJAJA JONANY', 'BANK DBS INDONESIA', 'Indonesia', 'USD', 2025, 1224721.00, 73.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (122, 316, 2025, '0102', 'TABUNGAN', '1121191105', 'ROSALINA CHANDRA', 'BANK DBS INDONESIA', 'Indonesia', 'USD', 2025, 9378343.00, 559.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (123, 316, 2025, '0102', 'TABUNGAN', '6309001432', 'ROSALINA CHANDRA', 'BANK UOB INDONESIA', 'Indonesia', 'USD', 2025, 257208187.00, 15331.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (124, 316, 2025, '0102', 'TABUNGAN', '6303009415', 'ROSALINA CHANDRA', 'BANK UOB INDONESIA', 'Indonesia', 'IDR', 2025, 48408235.00, 48408235.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (125, 316, 2025, '0102', 'TABUNGAN', '6419000709', 'SINDJAJA JONANY', 'BANK UOB INDONESIA', 'Indonesia', 'USD', 2025, 15401286.00, 918.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (126, 316, 2025, '0102', 'TABUNGAN', '6309003261', 'SINDJAJA JONANY', 'BANK UOB INDONESIA', 'Indonesia', 'IDR', 2025, 563263882.00, 563263882.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (127, 316, 2025, '0102', 'TABUNGAN', '6419000059', 'SINDJAJA JONANY', 'BANK UOB INDONESIA', 'Indonesia', 'USD', 2025, 73382598.00, 4374.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (128, 316, 2025, '0102', 'TABUNGAN', '6309003831', 'ROSALINA CHANDRA', 'BANK UOB INDONESIA', 'Indonesia', 'IDR', 2025, 88959334.00, 88959334.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (129, 316, 2025, '0102', 'TABUNGAN', '6309001742', 'ROSALINA CHANDRA', 'BANK UOB INDONESIA', 'Indonesia', 'USD', 2025, 83029373.00, 4949.00, 16777.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (130, 316, 2025, '0109', 'SETARA KAS', '-', 'SINDJAJA JONANY', '-', 'Indonesia', 'IDR', 2025, 600000000.00, 600000000.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (131, 316, 2025, '0101', 'UANG TUNAI', '-', 'SINDJAJA JONANY', 'VALAS US DOLAR (sebagian diinvestasikan)', 'Indonesia', 'IDR', 2021, 50000000.00, 50000000.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (132, 316, 2025, '0101', 'UANG TUNAI', '-', 'SINDJAJA JONANY', '-', 'Indonesia', 'IDR', 2025, 250000000.00, 250000000.00, 1.00, '2026-07-15 16:51:18', '2026-07-15 16:51:18');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (133, 316, 2026, '0102', 'TABUNGAN', '30610081702', 'SINDJAJA JONANY', 'STANDARD CHARTERED BANK', 'Indonesia', 'IDR', 2026, 395266344.00, 395266344.00, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (134, 316, 2026, '0102', 'TABUNGAN', '30607686992', 'SINDJAJA JONANY', 'STANDARD CHARTERED BANK', 'Indonesia', 'IDR', 2026, 76528563.00, 76528563.03, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (135, 316, 2026, '0102', 'TABUNGAN', '306812112560', 'ROSALINA CHANDRA', 'STANDARD CHARTERED BANK', 'Indonesia', 'USD', 2026, 7314772.00, 436.00, 16777.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (136, 316, 2026, '0102', 'TABUNGAN', '010210020072665', 'SINDJAJA JONANY', 'BANK MEGA', 'Indonesia', 'IDR', 2026, 129148067.00, 129148067.00, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (137, 316, 2026, '0102', 'TABUNGAN', '010210020079229', 'ROSALINA CHANDRA', 'BANK MEGA', 'Indonesia', 'IDR', 2026, 121185719.00, 121185719.00, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (138, 316, 2026, '0102', 'TABUNGAN', '010212029003270', 'SINDJAJA JONANY', 'BANK MEGA', 'Indonesia', 'USD', 2026, 38368999.00, 2287.00, 16777.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (139, 316, 2026, '0102', 'TABUNGAN', '010210036010740', 'SINDJAJA JONANY', 'BANK MEGA', 'Indonesia', 'IDR', 2026, 2114766133.00, 2114766133.00, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (140, 316, 2026, '0104', 'DEPOSITO', '0102100200360006730', 'ROSALINA CHANDRA', 'BANK MEGA', 'Indonesia', 'IDR', 2026, 1576324773.00, 1576324773.00, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
INSERT INTO `cms_lampiran_spt_detail` (`id`, `client_id`, `tahun`, `kode`, `deskripsi`, `nomor_akun`, `atas_nama`, `nama_bank_institusi`, `lokasi_harta`, `kurs`, `tahun_perolehan`, `saldo_saat_ini`, `saldo_bentuk_awal`, `nilai_kurs`, `created_at`, `updated_at`) VALUES (141, 316, 2026, '0104', 'DEPOSITO', '010210036007967', 'ROSALINA CHANDRA', 'BANK MEGA', 'Indonesia', 'IDR', 2026, 500000000.00, 500000000.00, 1.00, '2026-07-16 06:14:43', '2026-07-16 06:14:43');
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
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
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
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (1, 1, '0101', 'UANG TUNAI', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (2, 1, '0102', 'TABUNGAN', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (3, 1, '0103', 'GIRO', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (4, 1, '0104', 'DEPOSITO', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (5, 1, '0105', 'UANG ELEKTRONIK', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (6, 1, '0106', 'CEK', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (7, 1, '0107', 'WESSEL', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (8, 1, '0108', 'KERTAS KOMERSIAL', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (9, 1, '0109', 'SETARA KAS', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (10, 1, '0110', 'UANG TUNAI/BANK NOTE/KOIN', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (11, 1, '0111', 'SETARA KAS LAINNYA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (12, 2, '0201', 'PIUTANG USAHA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (13, 2, '0202', 'PIUTANG AFILIASI', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (14, 2, '0209', 'PIUTANG LAINNYA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (15, 3, '0310', 'ASURANSI', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (16, 3, '0311', 'REKSA DANA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (17, 3, '0312', 'OBLIGASI PEMERINTAH/PENGURUSAN PEMERINTAH', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (18, 3, '0313', 'OBLIGASI SW', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (19, 3, '0314', 'SAHAM', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (20, 3, '0315', 'OBLIGASI', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (21, 3, '0316', 'REKSA SAHAM', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (22, 3, '0317', 'REKSA CAMPURAN', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (23, 3, '0318', 'REKSA OBLIGASI', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (24, 3, '0319', 'REKSA PENDAPATAN TETAP', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (25, 3, '0320', 'REKSA TERPROTEKSI', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (26, 3, '0321', 'PENYERTAAN MODAL PADA BADAN USAHA YANG DIVIDENDENDENDENYA DIKENAKAN PEMOTONGAN PAJAK', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (27, 3, '0322', 'KAS PENJUALAN/PEMBELIAN REKSA DANA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (28, 3, '0323', 'PERSEKUTUAN/FIRMA/CV', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (29, 3, '0324', 'INVESTASI LAINNYA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (30, 4, '0401', 'SEPEDA', 1, '2026-06-27 10:17:24', '2026-06-27 10:17:24');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (31, 4, '0402', 'SEPEDA MOTOR', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (32, 4, '0403', 'MOBIL PENUMPANG', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (33, 4, '0404', 'BUS', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (34, 4, '0405', 'KENDARAAN ANGKUTAN JALAN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (35, 4, '0406', 'KENDARAAN TUJUAN KHUSUS', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (36, 4, '0407', 'KERETA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (37, 4, '0408', 'PESAWAT TERBANG', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (38, 4, '0409', 'KAPAL', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (39, 4, '0410', 'MESIN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (40, 4, '0411', 'GEROBAK', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (41, 4, '0412', 'KAPAL PESIAR', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (42, 4, '0499', 'HARTA BERGERAK LAINNYA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (43, 5, '0501', 'TANAH KOSONG', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (44, 5, '0502', 'TANAH DAN/ATAU BANGUNAN UNTUK TEMPAT TINGGAL', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (45, 5, '0503', 'APARTEMEN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (46, 5, '0504', 'VESSEL', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (47, 5, '0505', 'TANAH ATAU LAHAN UNTUK USAHA (LAHAN PERTANIAN, PERKEBUNAN, DSB)', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (48, 5, '0506', 'TANAH DAN/ATAU BANGUNAN UNTUK USAHA (TOKO, PABRIK, DSB)', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (49, 5, '0507', 'TANAH DAN/ATAU BANGUNAN YANG DISEWAKAN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (50, 5, '0509', 'HARTA TIDAK BERGERAK LAINNYA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (51, 6, '0601', 'PATEN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (52, 6, '0602', 'ROYALTI', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (53, 6, '0603', 'MEREK DAGANG', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (54, 6, '0699', 'HARTA TIDAK BERWUJUD LAINNYA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (55, 6, '0701', 'EMAS BATANGAN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (56, 6, '0702', 'EMAS PERHIASAN', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (57, 6, '0703', 'BATANGAN NON EMAS', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (58, 6, '0704', 'PERHIASAN NON EMAS', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (59, 6, '0705', 'PERMATA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (60, 6, '0706', 'BARANG-BARANG SENI DAN ANTIK', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (61, 6, '0707', 'PERALATAN OLAH RAGA KHUSUS', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (62, 6, '0708', 'PERALATAN ELEKTRONIK', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (63, 6, '0709', 'PERABOT RUMAH TANGGA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (64, 6, '0710', 'PERALATAN KANTOR', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (65, 6, '0711', 'JET SKI', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (66, 6, '0712', 'PERSEDIAAN USAHA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (67, 7, '101', 'UTANG BANK/LEMBAGA KEUANGAN BUKAN BANK', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (68, 7, '102', 'KARTU KREDIT', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (69, 7, '103', 'UTANG AFILIASI', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
INSERT INTO `cms_master_lampiran_spt` (`id`, `kategori_id`, `sub_kode`, `nama`, `is_active`, `created_at`, `updated_at`) VALUES (70, 7, '109', 'UTANG LAINNYA', 1, '2026-06-27 10:17:25', '2026-06-27 10:17:25');
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
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_permissions
-- ----------------------------
BEGIN;
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (152, 1, 'activity_log', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (151, 1, 'activity_log', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (124, 1, 'badan', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (126, 1, 'badan', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (125, 1, 'badan', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (123, 1, 'badan', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (128, 1, 'data_client', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (130, 1, 'data_client', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (129, 1, 'data_client', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (127, 1, 'data_client', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (144, 1, 'kategori_lampiran', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (146, 1, 'kategori_lampiran', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (145, 1, 'kategori_lampiran', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (143, 1, 'kategori_lampiran', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (140, 1, 'lampiran_spt', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (142, 1, 'lampiran_spt', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (141, 1, 'lampiran_spt', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (139, 1, 'lampiran_spt', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (148, 1, 'master_lampiran_spt', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (150, 1, 'master_lampiran_spt', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (149, 1, 'master_lampiran_spt', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (147, 1, 'master_lampiran_spt', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (136, 1, 'master_rumus', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (138, 1, 'master_rumus', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (137, 1, 'master_rumus', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (135, 1, 'master_rumus', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (120, 1, 'pasal', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (122, 1, 'pasal', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (121, 1, 'pasal', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (119, 1, 'pasal', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (112, 1, 'role', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (114, 1, 'role', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (113, 1, 'role', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (111, 1, 'role', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (132, 1, 'transaksi', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (134, 1, 'transaksi', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (133, 1, 'transaksi', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (131, 1, 'transaksi', 'view');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (116, 1, 'user', 'create');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (118, 1, 'user', 'delete');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (117, 1, 'user', 'edit');
INSERT INTO `cms_permissions` (`id`, `role_id`, `module`, `action`) VALUES (115, 1, 'user', 'view');
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
INSERT INTO `cms_role_user` (`role_id`, `user_id`) VALUES (1, 2);
INSERT INTO `cms_role_user` (`role_id`, `user_id`) VALUES (1, 3);
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi
-- ----------------------------
BEGIN;
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (23, 316, 2025, 3, 552998123.00, 0.00, 0.00, '2026-07-16 06:15:24', '2026-07-16 06:15:24', NULL);
INSERT INTO `cms_transaksi` (`id`, `client_id`, `tahun`, `tipe_badan_id`, `total_omset`, `total_harta`, `total_pph`, `created_at`, `updated_at`, `npwp_cabang_id`) VALUES (24, 316, 2026, 3, 746498864.00, 0.00, 0.00, '2026-07-16 06:15:54', '2026-07-16 06:15:54', NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_transaksi_omset
-- ----------------------------
BEGIN;
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (63, 23, 1, 123908123.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (64, 23, 2, 120000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (65, 23, 3, 309090000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (66, 24, 1, 302000000.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (67, 24, 2, 123099987.00);
INSERT INTO `cms_transaksi_omset` (`id`, `transaksi_id`, `bulan`, `nominal`) VALUES (68, 24, 3, 321398877.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (35, '2026_07_15_000001_add_is_active_to_cms_master_lampiran_spt_table', 12);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES (36, '2026_07_15_000002_create_cms_activity_logs_table', 13);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `two_factor_code`, `two_factor_expires_at`, `created_at`, `updated_at`) VALUES (1, 'Admin', 'erwin.admedika@gmail.com', NULL, '$2y$10$2Y01tuoYjc3HJ5escHzVgO8m0jNnnnKrlz5CFwZg/1x7AX3/GlpNy', NULL, NULL, NULL, '2026-06-26 07:49:18', '2026-07-15 18:17:49');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `two_factor_code`, `two_factor_expires_at`, `created_at`, `updated_at`) VALUES (2, 'JOJON', 'MITRAWAWPC1@GMAIL.COM', NULL, '$2y$10$kVU4RRvCfU6AZg5XmRxsheupBV7fWipK/ClDfocZgduEEZ6.Q/bVu', NULL, NULL, NULL, '2026-07-16 05:42:03', '2026-07-16 05:42:03');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `two_factor_code`, `two_factor_expires_at`, `created_at`, `updated_at`) VALUES (3, 'FDSGSD', 'ccbbaaarsq@gmail.com', NULL, '$2y$10$FjtK0T29yeNF/Mcp5fgB0eGYwSB/j69nTj1TA2hSZ423a6l49wLO6', NULL, NULL, NULL, '2026-07-16 05:43:31', '2026-07-16 05:43:31');
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `two_factor_code`, `two_factor_expires_at`, `created_at`, `updated_at`) VALUES (4, 'tes2', 'mitrawawpc8@gmail.com', NULL, '$2y$10$hnUo5o2jDyhBuCL1.ujNvOBb9iy2Kp8zsoctv5IYX/JcUNSsKL1.2', NULL, NULL, NULL, '2026-07-16 05:46:10', '2026-07-16 05:46:10');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
