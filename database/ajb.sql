/*
 Navicat Premium Data Transfer

 Source Server         : localdocker
 Source Server Type    : MySQL
 Source Server Version : 80409 (8.4.9)
 Source Host           : localhost:3301
 Source Schema         : ajb

 Target Server Type    : MySQL
 Target Server Version : 80409 (8.4.9)
 File Encoding         : 65001

 Date: 15/06/2026 12:26:38
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_badan
-- ----------------------------
BEGIN;
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (1, 'PT', '2026-06-14 08:10:06', '2026-06-14 08:10:06');
INSERT INTO `cms_badan` (`id`, `tipe`, `created_at`, `updated_at`) VALUES (7, 'Perorangan', '2026-06-14 08:12:33', '2026-06-14 08:12:33');
COMMIT;

-- ----------------------------
-- Table structure for cms_data_client
-- ----------------------------
DROP TABLE IF EXISTS `cms_data_client`;
CREATE TABLE `cms_data_client` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_client` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipe_badan` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `npwp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kpp` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci,
  `no_telephone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_data_client
-- ----------------------------
BEGIN;
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `npwp`, `kpp`, `alamat`, `no_telephone`, `created_at`, `updated_at`) VALUES (1, 'PT. Maju Bersama', 'PT', '01.234.567.8-901.000', 'KPP Madya Jakarta', 'Jl. Sudirman No. 123, Jakarta', '021-12345678', '2026-06-14 07:07:22', '2026-06-14 08:21:40');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `npwp`, `kpp`, `alamat`, `no_telephone`, `created_at`, `updated_at`) VALUES (2, 'CV. Sejahtera Abadi', 'PT', '02.345.678.9-012.000', 'KPP Pratama Bandung', 'Jl. Asia Afrika No. 45, Bandung', '022-87654321', '2026-06-14 07:07:22', '2026-06-14 08:21:48');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `npwp`, `kpp`, `alamat`, `no_telephone`, `created_at`, `updated_at`) VALUES (3, 'UD. Sinar Jaya', 'PT', '03.456.789.0-123.000', 'KPP Pratama Surabaya', 'Jl. Tunjungan No. 78, Surabaya', '031-5555555', '2026-06-14 07:07:22', '2026-06-14 08:21:53');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `npwp`, `kpp`, `alamat`, `no_telephone`, `created_at`, `updated_at`) VALUES (4, 'PT. Karya Mandiri', 'Perorangan', '3123123123123123', 'KPP Madya Semarang', 'Jl. Pandanaran No. 56, Semarang', '024-3334444', '2026-06-14 07:07:22', '2026-06-14 08:22:25');
INSERT INTO `cms_data_client` (`id`, `nama_client`, `tipe_badan`, `npwp`, `kpp`, `alamat`, `no_telephone`, `created_at`, `updated_at`) VALUES (5, 'CV. Agro Niaga', 'PT', '04.567.890.1-234.000', 'KPP Pratama Medan', 'Jl. Balai Kota No. 12, Medan', '061-7778888', '2026-06-14 07:07:22', '2026-06-14 08:22:30');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cms_master_rumus
-- ----------------------------
BEGIN;
INSERT INTO `cms_master_rumus` (`id`, `tipe_badan`, `max_value`, `potongan_persentase`, `created_at`, `updated_at`) VALUES (1, 'PT', 1000000000.00, 10.00, '2026-06-14 08:35:30', '2026-06-14 08:35:30');
INSERT INTO `cms_master_rumus` (`id`, `tipe_badan`, `max_value`, `potongan_persentase`, `created_at`, `updated_at`) VALUES (2, 'Perorangan', 500000000.00, 0.50, '2026-06-14 08:35:44', '2026-06-14 08:35:44');
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
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (1, 'Pasal 1 - Ketentuan Umum', 1, '2026-06-14 07:07:21', '2026-06-14 07:07:21');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (2, 'Pasal 2 - Hak dan Kewajiban', 1, '2026-06-14 07:07:22', '2026-06-14 07:07:22');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (3, 'Pasal 3 - Tata Cara Pendaftaran', 1, '2026-06-14 07:07:22', '2026-06-14 07:07:22');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (4, 'Pasal 4 - Sanksi Pelanggaran', 1, '2026-06-14 07:07:22', '2026-06-14 07:07:22');
INSERT INTO `cms_pasal` (`id`, `nama_pasal`, `is_active`, `created_at`, `updated_at`) VALUES (5, 'Pasal 5 - Ketentuan Penutup', 1, '2026-06-14 07:07:22', '2026-06-14 07:07:22');
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
INSERT INTO `cms_roles` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES (1, 'Administrator', 'administrator', 'Full CMS access', '2026-06-14 07:07:21', '2026-06-14 07:07:21');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES (1, 'Admin', 'admin@example.com', NULL, '$2y$10$.3gZxGHzkf4e9Pia35am/.gC4v2y6oGKa0v1a8OIXEVT8B8IcC0Pq', NULL, '2026-06-14 07:07:21', '2026-06-14 07:07:21');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
