-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 30, 2019 at 04:26 PM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_sps`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add list', 7, 'add_list'),
(26, 'Can change list', 7, 'change_list'),
(27, 'Can delete list', 7, 'delete_list'),
(28, 'Can view list', 7, 'view_list'),
(29, 'Can add history', 8, 'add_history'),
(30, 'Can change history', 8, 'change_history'),
(31, 'Can delete history', 8, 'delete_history'),
(32, 'Can view history', 8, 'view_history'),
(33, 'Can add booking', 9, 'add_booking'),
(34, 'Can change booking', 9, 'change_booking'),
(35, 'Can delete booking', 9, 'delete_booking'),
(36, 'Can view booking', 9, 'view_booking'),
(37, 'Can add user', 10, 'add_user'),
(38, 'Can change user', 10, 'change_user'),
(39, 'Can delete user', 10, 'delete_user'),
(40, 'Can view user', 10, 'view_user'),
(41, 'Can add history booking', 11, 'add_historybooking'),
(42, 'Can change history booking', 11, 'change_historybooking'),
(43, 'Can delete history booking', 11, 'delete_historybooking'),
(44, 'Can view history booking', 11, 'view_historybooking'),
(45, 'Can add history slot', 8, 'add_historyslot'),
(46, 'Can change history slot', 8, 'change_historyslot'),
(47, 'Can delete history slot', 8, 'delete_historyslot'),
(48, 'Can view history slot', 8, 'view_historyslot'),
(49, 'Can add history occupied', 12, 'add_historyoccupied'),
(50, 'Can change history occupied', 12, 'change_historyoccupied'),
(51, 'Can delete history occupied', 12, 'delete_historyoccupied'),
(52, 'Can view history occupied', 12, 'view_historyoccupied'),
(53, 'Can add akun', 10, 'add_akun'),
(54, 'Can change akun', 10, 'change_akun'),
(55, 'Can delete akun', 10, 'delete_akun'),
(56, 'Can view akun', 10, 'view_akun');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$120000$L05Fid1hO6bC$I/Hj0DdgawQfMsPEgNJnQOZkBsQ4DotmboGk0EBbFfY=', '2019-09-15 16:59:18.212877', 1, 'fahre', '', '', 'fahreza.maulana1@gmail.com', 1, 1, '2019-09-15 16:59:02.176159');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(10, 'parkslot_list', 'akun'),
(9, 'parkslot_list', 'booking'),
(11, 'parkslot_list', 'historybooking'),
(12, 'parkslot_list', 'historyoccupied'),
(8, 'parkslot_list', 'historyslot'),
(7, 'parkslot_list', 'list'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2019-03-18 16:46:24.324051'),
(2, 'auth', '0001_initial', '2019-03-18 16:46:25.126896'),
(3, 'admin', '0001_initial', '2019-03-18 16:46:25.322021'),
(4, 'admin', '0002_logentry_remove_auto_add', '2019-03-18 16:46:25.331018'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2019-03-18 16:46:25.338000'),
(6, 'contenttypes', '0002_remove_content_type_name', '2019-03-18 16:46:25.432121'),
(7, 'auth', '0002_alter_permission_name_max_length', '2019-03-18 16:46:25.483148'),
(8, 'auth', '0003_alter_user_email_max_length', '2019-03-18 16:46:25.540254'),
(9, 'auth', '0004_alter_user_username_opts', '2019-03-18 16:46:25.548264'),
(10, 'auth', '0005_alter_user_last_login_null', '2019-03-18 16:46:25.592390'),
(11, 'auth', '0006_require_contenttypes_0002', '2019-03-18 16:46:25.595425'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2019-03-18 16:46:25.603431'),
(13, 'auth', '0008_alter_user_username_max_length', '2019-03-18 16:46:25.676620'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2019-03-18 16:46:25.734764'),
(15, 'parkslot_list', '0001_initial', '2019-03-18 16:46:25.770738'),
(16, 'parkslot_list', '0002_auto_20190316_1943', '2019-03-18 16:46:25.843879'),
(17, 'parkslot_list', '0003_auto_20190316_2049', '2019-03-18 16:46:25.887989'),
(18, 'parkslot_list', '0004_auto_20190316_2058', '2019-03-18 16:46:25.929006'),
(19, 'parkslot_list', '0005_auto_20190316_2059', '2019-03-18 16:46:25.983014'),
(20, 'sessions', '0001_initial', '2019-03-18 16:46:26.019038'),
(21, 'parkslot_list', '0006_history', '2019-03-19 02:43:59.358015'),
(22, 'parkslot_list', '0007_auto_20190319_0945', '2019-03-19 02:45:16.158552'),
(23, 'parkslot_list', '0008_auto_20190319_1006', '2019-03-19 03:10:27.404034'),
(24, 'parkslot_list', '0009_delete_history', '2019-03-19 03:10:27.406033'),
(25, 'parkslot_list', '0010_history', '2019-03-19 03:10:58.000893'),
(26, 'parkslot_list', '0011_auto_20190320_1113', '2019-03-20 04:15:31.848937'),
(27, 'parkslot_list', '0012_auto_20190320_1531', '2019-03-20 08:31:09.831823'),
(28, 'parkslot_list', '0013_auto_20190506_1358', '2019-05-06 13:58:26.141974'),
(29, 'parkslot_list', '0014_auto_20190506_1457', '2019-05-06 14:57:16.330430'),
(30, 'parkslot_list', '0015_auto_20190506_1458', '2019-05-06 14:58:45.917256'),
(31, 'parkslot_list', '0002_booking_userid', '2019-05-07 22:53:21.479784'),
(32, 'parkslot_list', '0003_auto_20190507_2254', '2019-05-07 22:54:42.325670'),
(33, 'parkslot_list', '0004_historybooking', '2019-05-09 08:48:27.648988'),
(34, 'parkslot_list', '0005_auto_20190509_0920', '2019-05-09 09:20:34.056975'),
(35, 'parkslot_list', '0006_auto_20190509_1006', '2019-05-09 10:06:51.848416'),
(36, 'parkslot_list', '0007_historyoccupied', '2019-07-27 09:15:50.883016'),
(37, 'parkslot_list', '0008_auto_20190814_1148', '2019-08-14 11:49:01.719965'),
(38, 'parkslot_list', '0009_auto_20190816_2302', '2019-08-16 23:02:48.585272');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('al2hduftzvxbdcun5mrewgbd2zh9dlhh', 'MzVmY2QyY2UzMGM4YWFiNjM3M2E5ZGE3NzM4MmFiZmNmZGZlOTkzZDp7ImxvZ2luc3RhdHVzIjoibG9naW4ifQ==', '2019-10-14 14:31:46.865908'),
('k80rzq1ejuh4gztus4sb9su1bduio3v0', 'MzVmY2QyY2UzMGM4YWFiNjM3M2E5ZGE3NzM4MmFiZmNmZGZlOTkzZDp7ImxvZ2luc3RhdHVzIjoibG9naW4ifQ==', '2019-08-30 22:57:17.050563'),
('yexuqjzxqn7c0517kzt2yehky8kj51wb', 'MzVmY2QyY2UzMGM4YWFiNjM3M2E5ZGE3NzM4MmFiZmNmZGZlOTkzZDp7ImxvZ2luc3RhdHVzIjoibG9naW4ifQ==', '2019-09-22 00:02:38.089963');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id_history` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `slot` varchar(4) NOT NULL,
  `status` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id_history`, `tanggal`, `slot`, `status`) VALUES
(1, '2019-03-11 00:00:00', 'S001', 'yes'),
(5, '0000-00-00 00:00:00', 'S001', 'no'),
(6, '0000-00-00 00:00:00', 'S001', 'yes'),
(7, '0000-00-00 00:00:00', 'S001', 'no'),
(8, '0000-00-00 00:00:00', 'S001', 'yes'),
(9, '0000-00-00 00:00:00', 'S001', 'no'),
(10, '0000-00-00 00:00:00', 'S001', 'yes'),
(11, '0000-00-00 00:00:00', 'S001', 'no'),
(12, '2019-03-12 22:59:14', 'S001', 'yes'),
(13, '2019-03-12 23:03:26', 'S001', 'yes'),
(14, '2019-03-12 23:03:36', 'S001', 'no'),
(15, '2019-03-12 23:17:51', 'S002', 'yes'),
(16, '2019-03-12 23:19:54', 'S002', 'no'),
(17, '2019-03-12 23:21:31', 'S001', 'yes'),
(18, '2019-03-12 23:21:37', 'S002', 'yes'),
(19, '2019-03-12 23:22:02', 'S002', 'no'),
(20, '2019-03-12 23:22:11', 'S001', 'no'),
(21, '2019-03-12 23:22:26', 'S002', 'yes'),
(22, '2019-03-12 23:22:47', 'S002', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `parkir`
--

CREATE TABLE `parkir` (
  `id_slot` varchar(4) NOT NULL,
  `status_now` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parkir`
--

INSERT INTO `parkir` (`id_slot`, `status_now`) VALUES
('S001', 'no'),
('S002', 'no'),
('S003', 'no'),
('S004', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `parkslot_list_akun`
--

CREATE TABLE `parkslot_list_akun` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(256) NOT NULL,
  `nama` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parkslot_list_akun`
--

INSERT INTO `parkslot_list_akun` (`id`, `username`, `password`, `nama`) VALUES
(9, 'suki1', '202cb962ac59075b964b07152d234b70', 'fahre2'),
(10, 'suki2', '202cb962ac59075b964b07152d234b70', 'Fahreza'),
(11, 'suki3', '202cb962ac59075b964b07152d234b70', 'fahree');

-- --------------------------------------------------------

--
-- Table structure for table `parkslot_list_booking`
--

CREATE TABLE `parkslot_list_booking` (
  `id` int(11) NOT NULL,
  `booktime` datetime(6) NOT NULL,
  `bookfrom` datetime(6) NOT NULL,
  `bookuntil` datetime(6) NOT NULL,
  `slot_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `parkslot_list_historybooking`
--

CREATE TABLE `parkslot_list_historybooking` (
  `id` int(11) NOT NULL,
  `booktime` datetime(6) NOT NULL,
  `bookfrom` datetime(6) NOT NULL,
  `bookuntil` datetime(6) NOT NULL,
  `slot` varchar(4) NOT NULL,
  `username` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parkslot_list_historybooking`
--

INSERT INTO `parkslot_list_historybooking` (`id`, `booktime`, `bookfrom`, `bookuntil`, `slot`, `username`) VALUES
(1, '2019-05-09 12:17:06.000000', '2019-05-09 12:17:00.000000', '2019-05-09 12:17:00.000000', 'S001', '9'),
(2, '2019-06-08 19:31:52.000000', '2019-06-08 19:31:00.000000', '2019-06-08 20:31:00.000000', 'S001', '9'),
(3, '2019-06-08 19:39:09.000000', '2019-06-08 19:38:00.000000', '2019-06-08 20:39:00.000000', 'S001', '9'),
(4, '2019-06-08 19:43:17.000000', '2019-06-08 19:43:00.000000', '2019-06-08 20:43:00.000000', 'S001', '9'),
(5, '2019-06-08 19:46:22.000000', '2019-06-08 19:46:00.000000', '2019-06-08 19:46:00.000000', 'S001', '9'),
(6, '2019-06-08 22:51:20.000000', '2019-06-08 22:51:00.000000', '2019-06-08 22:51:00.000000', 'S001', '9'),
(7, '2019-06-08 22:52:37.000000', '2019-06-08 22:52:00.000000', '2019-06-08 22:52:00.000000', 'S001', '9'),
(8, '2019-06-08 23:32:47.000000', '2019-06-08 23:32:00.000000', '2019-06-08 23:32:00.000000', 'S001', '9'),
(9, '2019-06-08 23:39:09.000000', '2019-06-08 23:39:00.000000', '2019-06-08 23:39:00.000000', 'S001', '9'),
(10, '2019-06-08 23:42:37.000000', '2019-06-08 23:42:00.000000', '2019-06-08 23:42:00.000000', 'S001', '9'),
(11, '2019-06-08 23:44:17.000000', '2019-06-08 23:44:00.000000', '2019-06-08 23:44:00.000000', 'S001', '9'),
(12, '2019-06-09 21:10:38.000000', '2019-06-09 21:10:00.000000', '2019-06-09 21:10:00.000000', 'S003', '9'),
(13, '2019-06-09 21:27:38.000000', '2019-06-09 21:27:00.000000', '2019-06-09 21:27:00.000000', 'S003', '9'),
(14, '2019-06-09 21:30:20.000000', '2019-06-09 21:30:00.000000', '2019-06-09 21:30:00.000000', 'S003', '9'),
(15, '2019-06-09 21:31:32.000000', '2019-06-09 21:31:00.000000', '2019-06-09 21:31:00.000000', 'S003', '9'),
(16, '2019-06-09 21:32:15.000000', '2019-06-09 21:32:00.000000', '2019-06-09 21:32:00.000000', 'S003', '9'),
(17, '2019-09-07 23:05:44.664395', '2019-09-07 23:05:34.000000', '2019-09-07 23:05:34.000000', 'S002', 'admin'),
(18, '2019-09-08 16:40:01.160450', '2019-09-08 16:39:56.000000', '2019-09-08 16:39:57.000000', 'S006', 'admin'),
(19, '2019-09-15 11:35:45.000000', '2019-09-15 11:35:00.000000', '2019-09-15 11:35:00.000000', 'S001', 'Fahreza'),
(20, '2019-09-15 16:13:14.000000', '2019-04-03 16:53:00.000000', '2019-04-03 16:54:00.000000', 'S001', 'fahre2'),
(21, '2019-09-15 17:34:53.000000', '2019-09-15 17:34:00.000000', '2019-09-15 17:34:00.000000', 'S009', 'Fahreza'),
(22, '2019-09-30 14:30:16.643057', '2019-09-30 14:30:10.000000', '2019-09-30 14:30:11.000000', 'S009', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `parkslot_list_historyoccupied`
--

CREATE TABLE `parkslot_list_historyoccupied` (
  `id` int(11) NOT NULL,
  `tanggal` datetime(6) NOT NULL,
  `slot` varchar(4) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parkslot_list_historyoccupied`
--

INSERT INTO `parkslot_list_historyoccupied` (`id`, `tanggal`, `slot`, `status`) VALUES
(2, '2019-08-16 08:13:12.000000', 'S001', 'Occupied'),
(3, '2019-08-16 13:21:14.000000', 'S001', 'Unoccupied'),
(4, '2019-09-30 21:18:53.000000', 'S009', 'Occupied'),
(5, '2019-09-30 21:19:18.000000', 'S009', 'Unoccupied');

-- --------------------------------------------------------

--
-- Table structure for table `parkslot_list_historyslot`
--

CREATE TABLE `parkslot_list_historyslot` (
  `id` int(11) NOT NULL,
  `tanggal` datetime(6) NOT NULL,
  `slot` varchar(4) NOT NULL,
  `status` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parkslot_list_historyslot`
--

INSERT INTO `parkslot_list_historyslot` (`id`, `tanggal`, `slot`, `status`) VALUES
(1, '2019-05-08 09:06:43.000000', 'S001', 'Lock'),
(2, '2019-05-08 09:07:26.000000', 'S001', 'Lock'),
(3, '2019-05-08 09:09:15.000000', 'S002', 'Lock'),
(4, '2019-05-08 12:19:48.575680', 'S002', 'Unlock'),
(5, '2019-05-08 12:20:41.000000', 'S002', 'Lock'),
(6, '2019-05-08 12:23:37.448525', 'S002', 'Unlock'),
(7, '2019-05-08 12:46:28.000000', 'S001', 'Lock'),
(8, '2019-05-08 12:49:36.000000', 'S001', 'Lock'),
(9, '2019-05-08 13:02:55.000000', 'S001', 'Lock'),
(10, '2019-05-08 22:01:10.000000', 'S001', 'Lock'),
(11, '2019-05-08 22:05:40.000000', 'S001', 'Lock'),
(12, '2019-05-08 22:06:36.000000', 'S001', 'Lock'),
(13, '2019-05-08 22:11:35.000000', 'S001', 'Lock'),
(14, '2019-05-08 22:11:53.000000', 'S001', 'Lock'),
(15, '2019-05-08 22:13:07.000000', 'S001', 'Lock'),
(16, '2019-05-08 22:15:07.000000', 'S001', 'Lock'),
(17, '2019-05-09 12:17:06.000000', 'S001', 'Lock'),
(18, '2019-06-08 19:31:52.000000', 'S001', 'Lock'),
(19, '2019-06-08 19:39:09.000000', 'S001', 'Lock'),
(20, '2019-06-08 19:43:17.000000', 'S001', 'Lock'),
(21, '2019-06-08 19:46:22.000000', 'S001', 'Lock'),
(22, '2019-06-08 22:51:20.000000', 'S001', 'Lock'),
(23, '2019-06-08 22:52:37.000000', 'S001', 'Lock'),
(24, '2019-06-08 23:32:47.000000', 'S001', 'Lock'),
(25, '2019-06-08 23:39:09.000000', 'S001', 'Lock'),
(26, '2019-06-08 23:42:37.000000', 'S001', 'Lock'),
(27, '2019-06-08 23:44:17.000000', 'S001', 'Lock'),
(28, '2019-06-09 21:10:38.000000', 'S003', 'Lock'),
(29, '2019-06-09 21:27:38.000000', 'S003', 'Lock'),
(30, '2019-06-09 21:30:20.000000', 'S003', 'Lock'),
(31, '2019-06-09 21:31:32.000000', 'S003', 'Lock'),
(32, '2019-06-09 21:32:15.000000', 'S003', 'Lock'),
(33, '2019-09-07 23:05:44.657399', 'S002', 'Lock'),
(34, '2019-09-08 14:11:22.614581', 'S001', 'Unlock'),
(35, '2019-09-08 14:15:39.103054', 'S002', 'Unlock'),
(36, '2019-09-08 16:40:01.157450', 'S006', 'Lock'),
(37, '2019-09-08 16:41:26.486266', 'S001', 'Unlock'),
(38, '2019-09-08 16:42:42.826016', 'S002', 'Unlock'),
(39, '2019-09-08 16:43:56.915946', 'S003', 'Unlock'),
(40, '2019-09-08 16:45:09.083272', 'S004', 'Unlock'),
(41, '2019-09-08 16:45:16.210934', 'S005', 'Unlock'),
(42, '2019-09-08 16:45:22.975578', 'S006', 'Unlock'),
(43, '2019-09-08 16:46:22.659423', 'S006', 'Unlock'),
(44, '2019-09-08 16:46:53.670979', 'S006', 'Unlock'),
(45, '2019-09-15 11:35:45.000000', 'S001', 'Lock'),
(46, '2019-09-15 16:13:14.000000', 'S001', 'Lock'),
(47, '2019-09-15 17:33:12.000000', 'S001', 'Unlock'),
(48, '2019-09-15 17:34:53.000000', 'S009', 'Lock'),
(49, '2019-09-30 14:17:20.699714', 'S009', 'Unlock'),
(50, '2019-09-30 14:30:16.639517', 'S009', 'Lock'),
(51, '2019-09-30 14:31:37.747982', 'S009', 'Unlock');

-- --------------------------------------------------------

--
-- Table structure for table `parkslot_list_list`
--

CREATE TABLE `parkslot_list_list` (
  `id` int(11) NOT NULL,
  `slot` varchar(4) NOT NULL,
  `status` varchar(3) NOT NULL,
  `lock` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `parkslot_list_list`
--

INSERT INTO `parkslot_list_list` (`id`, `slot`, `status`, `lock`) VALUES
(1, 'S001', 'no', 0),
(2, 'S002', 'no', 0),
(3, 'S003', 'no', 0),
(4, 'S004', 'no', 0),
(5, 'S005', 'no', 0),
(6, 'S006', 'no', 0),
(7, 'S007', 'no', 0),
(8, 'S008', 'no', 0),
(9, 'S009', 'no', 0),
(10, 'S010', 'no', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id_history`),
  ADD KEY `slot` (`slot`);

--
-- Indexes for table `parkir`
--
ALTER TABLE `parkir`
  ADD PRIMARY KEY (`id_slot`);

--
-- Indexes for table `parkslot_list_akun`
--
ALTER TABLE `parkslot_list_akun`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userid` (`username`);

--
-- Indexes for table `parkslot_list_booking`
--
ALTER TABLE `parkslot_list_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parkslot_list_booking_slot_id_8c029a0e_fk_parkslot_list_list_id` (`slot_id`),
  ADD KEY `parkslot_list_booking_user_id_26e4d230_fk_parkslot_list_akun_id` (`user_id`);

--
-- Indexes for table `parkslot_list_historybooking`
--
ALTER TABLE `parkslot_list_historybooking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parkslot_list_historyoccupied`
--
ALTER TABLE `parkslot_list_historyoccupied`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parkslot_list_historyslot`
--
ALTER TABLE `parkslot_list_historyslot`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parkslot_list_list`
--
ALTER TABLE `parkslot_list_list`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id_history` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `parkslot_list_akun`
--
ALTER TABLE `parkslot_list_akun`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `parkslot_list_booking`
--
ALTER TABLE `parkslot_list_booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parkslot_list_historybooking`
--
ALTER TABLE `parkslot_list_historybooking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `parkslot_list_historyoccupied`
--
ALTER TABLE `parkslot_list_historyoccupied`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `parkslot_list_historyslot`
--
ALTER TABLE `parkslot_list_historyslot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `parkslot_list_list`
--
ALTER TABLE `parkslot_list_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`slot`) REFERENCES `parkir` (`id_slot`);

--
-- Constraints for table `parkslot_list_booking`
--
ALTER TABLE `parkslot_list_booking`
  ADD CONSTRAINT `parkslot_list_booking_slot_id_8c029a0e_fk_parkslot_list_list_id` FOREIGN KEY (`slot_id`) REFERENCES `parkslot_list_list` (`id`),
  ADD CONSTRAINT `parkslot_list_booking_user_id_26e4d230_fk_parkslot_list_akun_id` FOREIGN KEY (`user_id`) REFERENCES `parkslot_list_akun` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
