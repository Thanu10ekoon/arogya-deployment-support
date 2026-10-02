-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 08, 2026 at 03:00 PM
-- Server version: 8.0.46-0ubuntu0.24.04.3
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clinic_service_db`
--
CREATE DATABASE IF NOT EXISTS `clinic_service_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `clinic_service_db`;

-- --------------------------------------------------------

--
-- Table structure for table `clinics`
--

CREATE TABLE `clinics` (
  `clinic_id` bigint NOT NULL,
  `clinic_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'e.g., Southern, Western, Central',
  `district` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'e.g., Galle District, Matara District',
  `location` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Specific location description',
  `scheduled_date` date NOT NULL,
  `scheduled_time` time NOT NULL,
  `status` enum('SCHEDULED','IN_PROGRESS','COMPLETED','CANCELLED') COLLATE utf8mb4_unicode_ci DEFAULT 'SCHEDULED',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clinics`
--

INSERT INTO `clinics` (`clinic_id`, `clinic_name`, `province`, `district`, `location`, `scheduled_date`, `scheduled_time`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Galle Mobile Clinic', 'Southern', 'Galle District', 'Galle Town Center', '2026-06-12', '09:30:00', 'SCHEDULED', '2025-11-25 17:07:06', '2026-05-01 20:33:37'),
(8, 'Hambantota Mobile Clinic', 'Southern', 'Hambantota District', 'Hambantota Town', '2026-05-09', '08:30:00', 'CANCELLED', '2025-11-28 17:09:55', '2026-04-30 17:56:04'),
(12, 'Kandy Mobile Clinic', 'Central', 'Kandy District', 'Kandy town', '2026-01-25', '10:00:00', 'SCHEDULED', '2025-11-29 11:09:14', '2025-11-29 11:11:21'),
(17, 'Matale Mobile Clinic', 'Central', 'Matale District', 'Matale town', '2026-02-25', '10:00:00', 'SCHEDULED', '2025-11-30 15:14:30', '2025-11-30 15:16:39'),
(26, 'Jaffna Mobile Clinic', 'Northern', 'Jaffna District', 'Hindu College Jaffana', '2026-05-01', '07:30:00', 'SCHEDULED', '2025-12-01 11:01:18', '2026-04-30 17:58:43'),
(27, 'Gampaha Mobile Clinic', 'Western', 'Gampaha District', 'Gampaha Townhall', '2026-05-08', '08:30:00', 'SCHEDULED', '2025-12-01 14:52:46', '2026-05-02 15:34:22'),
(37, 'Kalutara Mobile Clinic', 'Western', 'Kalutara District', 'Kalutara town', '2026-06-07', '10:00:00', 'SCHEDULED', '2025-12-02 15:53:57', '2026-03-29 10:59:25'),
(38, 'Hambantota Mobile Clinic', 'Southern', 'Hambantota District', 'National School Walasmulla', '2026-01-10', '07:30:00', 'SCHEDULED', '2025-12-03 06:33:46', '2025-12-03 06:33:46'),
(39, 'Karapitya Mobile Clinic', 'Southern', 'Galle District', 'General Hospital Galle', '2026-01-31', '07:30:00', 'SCHEDULED', '2026-01-21 08:21:10', '2026-01-21 08:21:10'),
(40, 'Jaffna Mobile Clinic', 'Northern', 'Jaffna District', 'Hindu College Jaffana', '2026-03-29', '08:30:00', 'COMPLETED', '2026-02-20 06:15:00', '2026-03-29 11:09:46'),
(41, 'Imaduwa Mobile Clinic', 'Southern', 'Galle District', 'Batemulla National School', '2026-07-07', '19:30:00', 'SCHEDULED', '2026-03-29 11:07:10', '2026-03-29 11:07:10'),
(42, 'Polgahawela Mobile clinic', 'Central', 'Matale District', 'National School', '2026-05-30', '08:00:00', 'SCHEDULED', '2026-05-03 05:15:41', '2026-05-03 05:15:41');

-- --------------------------------------------------------

--
-- Table structure for table `clinic_doctors`
--

CREATE TABLE `clinic_doctors` (
  `id` bigint NOT NULL,
  `clinic_id` bigint NOT NULL,
  `doctor_ref_id` bigint NOT NULL COMMENT 'Reference to Doctor Service - NOT a FK',
  `doctor_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `specialization` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `synced_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sync_status` enum('SUCCESS','FAILED','PENDING') COLLATE utf8mb4_unicode_ci DEFAULT 'SUCCESS',
  `sync_error_message` text COLLATE utf8mb4_unicode_ci COMMENT 'Error details if sync failed',
  `last_sync_attempt` timestamp NULL DEFAULT NULL COMMENT 'Last time we tried to fetch from User Service',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clinic_doctors`
--

INSERT INTO `clinic_doctors` (`id`, `clinic_id`, `doctor_ref_id`, `doctor_name`, `specialization`, `is_active`, `synced_at`, `sync_status`, `sync_error_message`, `last_sync_attempt`, `created_at`) VALUES
(55, 12, 2, 'Ruwan', 'VP', 1, '2025-11-29 11:11:20', 'SUCCESS', NULL, NULL, '2025-11-29 11:11:20'),
(56, 12, 3, 'Tharindi', 'Dermatology', 1, '2025-11-29 11:11:20', 'SUCCESS', NULL, NULL, '2025-11-29 11:11:20'),
(57, 12, 4, 'Chathuri', 'Dermatology', 1, '2025-11-29 11:11:21', 'SUCCESS', NULL, NULL, '2025-11-29 11:11:21'),
(78, 17, 2, 'Ruwan', 'VP', 1, '2025-11-30 15:16:37', 'SUCCESS', NULL, NULL, '2025-11-30 15:16:37'),
(79, 17, 3, 'Tharindi', 'Dermatology', 1, '2025-11-30 15:16:38', 'SUCCESS', NULL, NULL, '2025-11-30 15:16:38'),
(80, 17, 5, 'kumara', 'Oncology', 1, '2025-11-30 15:16:38', 'SUCCESS', NULL, NULL, '2025-11-30 15:16:38'),
(121, 38, 1, 'Gayan', 'ENT Surgeon', 1, '2025-12-03 06:33:49', 'SUCCESS', NULL, NULL, '2025-12-03 06:33:49'),
(122, 38, 2, 'Ruwan', 'VP', 1, '2025-12-03 06:33:50', 'SUCCESS', NULL, NULL, '2025-12-03 06:33:50'),
(123, 38, 5, 'kumara', 'Oncology', 1, '2025-12-03 06:33:50', 'SUCCESS', NULL, NULL, '2025-12-03 06:33:50'),
(124, 38, 7, 'Saman', 'VP', 1, '2025-12-03 06:33:50', 'SUCCESS', NULL, NULL, '2025-12-03 06:33:50'),
(141, 39, 1, 'Gayan', 'ENT Surgeon', 1, '2026-01-26 06:10:16', 'SUCCESS', NULL, NULL, '2026-01-26 06:10:16'),
(142, 39, 3, 'Tharindi', 'Dermatology', 1, '2026-01-26 06:10:16', 'SUCCESS', NULL, NULL, '2026-01-26 06:10:16'),
(143, 39, 4, 'Chathuri', 'Dermatology', 1, '2026-01-26 06:10:17', 'SUCCESS', NULL, NULL, '2026-01-26 06:10:17'),
(144, 39, 5, 'kumara', 'Oncology', 1, '2026-01-26 06:10:18', 'SUCCESS', NULL, NULL, '2026-01-26 06:10:18'),
(145, 39, 8, 'lll', 'Surgery', 1, '2026-01-26 06:10:18', 'SUCCESS', NULL, NULL, '2026-01-26 06:10:18'),
(155, 37, 4, 'Chathuri', 'Dermatology', 1, '2026-03-29 10:59:25', 'SUCCESS', NULL, NULL, '2026-03-29 10:59:25'),
(156, 37, 5, 'kumara', 'Oncology', 1, '2026-03-29 10:59:25', 'SUCCESS', NULL, NULL, '2026-03-29 10:59:25'),
(157, 41, 1, 'Gayan', 'ENT Surgeon', 1, '2026-03-29 11:07:14', 'SUCCESS', NULL, NULL, '2026-03-29 11:07:14'),
(158, 41, 4, 'Chathuri', 'Dermatology', 1, '2026-03-29 11:07:14', 'SUCCESS', NULL, NULL, '2026-03-29 11:07:14'),
(159, 41, 5, 'kumara', 'Oncology', 1, '2026-03-29 11:07:15', 'SUCCESS', NULL, NULL, '2026-03-29 11:07:15'),
(160, 41, 9, 'Doc . Pathum', 'Gastroenterology', 1, '2026-03-29 11:07:15', 'SUCCESS', NULL, NULL, '2026-03-29 11:07:15'),
(161, 40, 1, 'Gayan', 'ENT Surgeon', 1, '2026-03-29 11:09:45', 'SUCCESS', NULL, NULL, '2026-03-29 11:09:45'),
(162, 40, 5, 'kumara', 'Oncology', 1, '2026-03-29 11:09:45', 'SUCCESS', NULL, NULL, '2026-03-29 11:09:45'),
(163, 8, 2, 'Ruwan', 'VP', 1, '2026-04-30 17:56:02', 'SUCCESS', NULL, NULL, '2026-04-30 17:56:02'),
(164, 8, 3, 'Tharindi', 'Dermatology', 1, '2026-04-30 17:56:02', 'SUCCESS', NULL, NULL, '2026-04-30 17:56:02'),
(165, 8, 5, 'kumara', 'Oncology', 1, '2026-04-30 17:56:03', 'SUCCESS', NULL, NULL, '2026-04-30 17:56:03'),
(166, 8, 7, 'Saman', 'VP', 1, '2026-04-30 17:56:03', 'SUCCESS', NULL, NULL, '2026-04-30 17:56:03'),
(167, 8, 9, 'Doc . Pathum', 'Gastroenterology', 1, '2026-04-30 17:56:03', 'SUCCESS', NULL, NULL, '2026-04-30 17:56:03'),
(168, 26, 1, 'Gayan', 'ENT Surgeon', 1, '2026-04-30 17:58:42', 'SUCCESS', NULL, NULL, '2026-04-30 17:58:42'),
(169, 26, 4, 'Chathuri', 'Dermatology', 1, '2026-04-30 17:58:42', 'SUCCESS', NULL, NULL, '2026-04-30 17:58:42'),
(170, 26, 5, 'kumara', 'Oncology', 1, '2026-04-30 17:58:42', 'SUCCESS', NULL, NULL, '2026-04-30 17:58:42'),
(171, 26, 9, 'Doc . Pathum', 'Gastroenterology', 1, '2026-04-30 17:58:43', 'SUCCESS', NULL, NULL, '2026-04-30 17:58:43'),
(178, 27, 1, 'Gayan', 'ENT Surgeon', 1, '2026-05-02 15:34:21', 'SUCCESS', NULL, NULL, '2026-05-02 15:34:21'),
(179, 27, 4, 'Chathuri', 'Dermatology', 1, '2026-05-02 15:34:21', 'SUCCESS', NULL, NULL, '2026-05-02 15:34:21'),
(180, 27, 5, 'kumara', 'Oncology', 1, '2026-05-02 15:34:21', 'SUCCESS', NULL, NULL, '2026-05-02 15:34:21'),
(181, 27, 7, 'Saman', 'VP', 1, '2026-05-02 15:34:22', 'SUCCESS', NULL, NULL, '2026-05-02 15:34:22'),
(182, 1, 1, 'Gayan', 'ENT Surgeon', 1, '2026-05-03 05:14:29', 'SUCCESS', NULL, NULL, '2026-05-03 05:14:29'),
(183, 1, 3, 'Tharindi', 'Dermatology', 1, '2026-05-03 05:14:29', 'SUCCESS', NULL, NULL, '2026-05-03 05:14:29'),
(184, 1, 4, 'Chathuri', 'Dermatology', 1, '2026-05-03 05:14:29', 'SUCCESS', NULL, NULL, '2026-05-03 05:14:29'),
(185, 1, 5, 'kumara', 'Oncology', 1, '2026-05-03 05:14:30', 'SUCCESS', NULL, NULL, '2026-05-03 05:14:30'),
(186, 42, 3, 'Tharindi', 'Dermatology', 1, '2026-05-03 05:15:44', 'SUCCESS', NULL, NULL, '2026-05-03 05:15:44'),
(187, 42, 5, 'kumara', 'Oncology', 1, '2026-05-03 05:15:45', 'SUCCESS', NULL, NULL, '2026-05-03 05:15:45');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_available_doctors`
-- (See below for the actual view)
--
CREATE TABLE `v_available_doctors` (
`dummy` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_clinic_dashboard`
-- (See below for the actual view)
--
CREATE TABLE `v_clinic_dashboard` (
`dummy` int
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_doctors_need_sync`
-- (See below for the actual view)
--
CREATE TABLE `v_doctors_need_sync` (
`clinic_id` bigint
,`doctor_name` varchar(255)
,`doctor_ref_id` bigint
,`hours_since_sync` bigint
,`id` bigint
,`last_sync_attempt` timestamp
,`sync_error_message` text
,`sync_status` enum('SUCCESS','FAILED','PENDING')
);

-- --------------------------------------------------------
-- Indexes for dumped tables
--

--
-- Indexes for table `clinics`
--
ALTER TABLE `clinics`
  ADD PRIMARY KEY (`clinic_id`),
  ADD KEY `idx_province` (`province`),
  ADD KEY `idx_district` (`district`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_scheduled_date` (`scheduled_date`),
  ADD KEY `idx_clinic_name` (`clinic_name`),
  ADD KEY `idx_clinic_status_date` (`status`,`scheduled_date`);

--
-- Indexes for table `clinic_doctors`
--
ALTER TABLE `clinic_doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_clinic_doctor_unique` (`clinic_id`,`doctor_ref_id`),
  ADD KEY `idx_clinic_id` (`clinic_id`),
  ADD KEY `idx_doctor_ref_id` (`doctor_ref_id`),
  ADD KEY `idx_sync_status` (`sync_status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clinics`
--
ALTER TABLE `clinics`
  MODIFY `clinic_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `clinic_doctors`
--
ALTER TABLE `clinic_doctors`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `clinic_doctors`
--
ALTER TABLE `clinic_doctors`
  ADD CONSTRAINT `clinic_doctors_ibfk_1` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`clinic_id`) ON DELETE CASCADE;
--
-- Database: `consultation_service_db`
--
CREATE DATABASE IF NOT EXISTS `consultation_service_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `consultation_service_db`;

-- --------------------------------------------------------

--
-- Table structure for table `consultations`
--

CREATE TABLE `consultations` (
  `id` bigint NOT NULL,
  `patient_id` bigint NOT NULL,
  `doctor_id` bigint NOT NULL,
  `clinic_id` bigint NOT NULL,
  `queue_token_id` bigint DEFAULT NULL,
  `status` enum('SCHEDULED','IN_PROGRESS','COMPLETED','CANCELLED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SCHEDULED',
  `chief_complaint` text COLLATE utf8mb4_unicode_ci,
  `past_medical_history` text COLLATE utf8mb4_unicode_ci,
  `present_illness` text COLLATE utf8mb4_unicode_ci,
  `recommendations` text COLLATE utf8mb4_unicode_ci,
  `session_number` int NOT NULL DEFAULT '1',
  `booked_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consultations`
--

INSERT INTO `consultations` (`id`, `patient_id`, `doctor_id`, `clinic_id`, `queue_token_id`, `status`, `chief_complaint`, `past_medical_history`, `present_illness`, `recommendations`, `session_number`, `booked_at`, `completed_at`, `updated_at`) VALUES
(3, 5, 27, 1, 1, 'SCHEDULED', 'The patient reports persistent fatigue for the past two weeks.', 'History of high cholesterol levels, diagnosed two years ago. No known history of diabetes or hypertension.', 'Kamal complains of constant tiredness, reduced energy levels, and difficulty concentrating during daily activities. Symptoms are more noticeable in the evening. No fever, chest pain, or shortness of breath reported. Sleep duration is irregular due to work-related stress.', 'Advise routine blood tests, including lipid profile and complete blood count\nEncourage regular sleep patterns and stress management\nRecommend a balanced diet low in saturated fats\nSuggest moderate physical activity such as daily walking\nSchedule a follow-up consultation after two weeks', 1, '2026-01-26 06:06:14', NULL, '2026-01-26 11:36:15'),
(35, 5, 39, 1, 1, 'SCHEDULED', 'Persistent fever, dry cough, and fatigue for the past 4 days', 'Type 2 Diabetes Mellitus (diagnosed 5 years ago),Hypertension', 'Patient reports low-grade fever (up to 100.8Â°F), dry cough, body aches, and generalized weakness for 4 days.\nNo chest pain or shortness of breath.\nAppetite slightly reduced.\nBlood sugar levels have been slightly elevated over the past few days.', 'Continue regular diabetic and hypertension medications\nParacetamol 500mg every 6â€“8 hours as needed for fever\nAdequate hydration and rest\nMonitor blood glucose levels closely\nFollow-up in 5 days or earlier if symptoms worsen\nSeek immediate care if breathing difficulty develops', 1, '2026-02-26 17:02:56', NULL, '2026-02-26 22:32:56'),
(36, 38, 39, 37, 16, 'SCHEDULED', 'Persistent fever, dry cough, and fatigue for the past 4 days', 'Type 2 Diabetes Mellitus (diagnosed 5 years ago)\nHypertension\nNo known drug allergies\nNon-smoker', 'Patient reports low-grade fever (up to 100.8Â°F), dry cough, body aches, and generalized weakness for 4 days.\nNo chest pain or shortness of breath.\nAppetite slightly reduced.\nBlood sugar levels have been slightly elevated over the past few days.', 'continue regular diabetic and hypertension medications\nParacetamol 500mg every 6â€“8 hours as needed for fever\nAdequate hydration and rest\nMonitor blood glucose levels closely\nFollow-up in 5 days or earlier if symptoms worsen\nSeek immediate care if breathing difficulty develops', 1, '2026-02-26 17:12:44', NULL, '2026-02-26 22:42:44'),
(37, 20, 39, 37, 12, 'SCHEDULED', 'test01', '', '', 'test01', 1, '2026-02-27 03:39:35', NULL, '2026-02-27 09:09:36'),
(38, 5, 39, 1, 1, 'SCHEDULED', 'test02', '', '', 'test02', 1, '2026-02-27 03:48:22', NULL, '2026-02-27 09:18:23'),
(39, 20, 50, 37, 12, 'SCHEDULED', 'Frequent Headeaches', 'Arthreschloris', 'Having frequent headeaches, mostly in top of head', 'Migraine tablets', 1, '2026-03-01 11:17:44', NULL, '2026-03-01 16:47:44'),
(40, 5, 39, 1, 1, 'COMPLETED', 'pain', 'No', 'sick', 'test', 1, '2026-05-01 11:18:05', '2026-05-01 11:18:14', '2026-05-01 11:18:14'),
(41, 37, 50, 12, 2, 'SCHEDULED', 'Back Pain', 'Carpel Tunnel Syndrome', 'Ostio Arthertis', 'Physio Therapy and Yoga', 1, '2026-05-02 04:51:32', NULL, '2026-05-02 10:21:33'),
(42, 38, 39, 39, 31, 'COMPLETED', 'test4t', 'test4', 'test3', 'temulator', 1, '2026-05-03 10:29:25', '2026-05-03 10:29:34', '2026-05-03 10:29:34');

-- --------------------------------------------------------

--
-- Table structure for table `lab_tests`
--

CREATE TABLE `lab_tests` (
  `id` bigint NOT NULL,
  `consultation_id` bigint NOT NULL,
  `test_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `test_description` text COLLATE utf8mb4_unicode_ci,
  `test_instructions` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `assigned_technician_id` bigint DEFAULT NULL,
  `test_results` text COLLATE utf8mb4_unicode_ci,
  `technician_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lab_tests`
--

INSERT INTO `lab_tests` (`id`, `consultation_id`, `test_name`, `test_description`, `test_instructions`, `status`, `assigned_technician_id`, `test_results`, `technician_notes`, `created_at`, `updated_at`, `completed_at`) VALUES
(14, 35, 'Complete Blood Count (CBC)', 'Complete Blood Count (CBC)', 'check this and report that', 'PENDING', NULL, NULL, NULL, '2026-02-26 22:32:58', '2026-02-26 22:32:58', NULL),
(15, 35, 'C-Reactive Protein (CRP)', 'C-Reactive Protein (CRP)', 'check this and submit the report', 'PENDING', NULL, NULL, NULL, '2026-02-26 22:32:58', '2026-02-26 22:32:58', NULL),
(16, 36, 'Fasting Blood Sugar (FBS)', 'Fasting Blood Sugar (FBS)', 'test this', 'PENDING', NULL, NULL, NULL, '2026-02-26 22:42:46', '2026-02-26 22:42:46', NULL),
(17, 37, 'test01', NULL, NULL, 'COMPLETED', NULL, NULL, NULL, '2026-02-27 09:09:38', '2026-02-27 09:10:55', '2026-02-27 09:10:55'),
(18, 38, 'test02', NULL, NULL, 'COMPLETED', NULL, NULL, NULL, '2026-02-27 09:18:25', '2026-02-27 09:20:42', '2026-02-27 09:20:42'),
(19, 39, 'LP', 'Lumbar Puncture', 'Patient might have meningitis. So be careful', 'PENDING', NULL, NULL, NULL, '2026-03-01 16:47:46', '2026-03-01 16:47:46', NULL),
(20, 39, 'Head CT', 'CT scan focusing on pituitary', 'Get 3 angles', 'PENDING', NULL, NULL, NULL, '2026-03-01 16:47:47', '2026-03-01 16:47:47', NULL),
(21, 40, 'test', 'test', 'test', 'PENDING', NULL, NULL, NULL, '2026-05-01 11:18:11', '2026-05-01 11:18:11', NULL),
(22, 42, 'test', 'test', 'test', 'PENDING', NULL, NULL, NULL, '2026-05-03 10:29:31', '2026-05-03 10:29:31', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `consultations`
--
ALTER TABLE `consultations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_patient_id` (`patient_id`),
  ADD KEY `idx_doctor_id` (`doctor_id`),
  ADD KEY `idx_clinic_id` (`clinic_id`),
  ADD KEY `idx_queue_token_id` (`queue_token_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_booked_at` (`booked_at`),
  ADD KEY `idx_patient_doctor` (`patient_id`,`doctor_id`);

--
-- Indexes for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_consultation_id` (`consultation_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `lab_tests`
--
ALTER TABLE `lab_tests`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lab_tests`
--
ALTER TABLE `lab_tests`
  ADD CONSTRAINT `fk_lab_tests_consultation` FOREIGN KEY (`consultation_id`) REFERENCES `consultations` (`id`) ON DELETE CASCADE;
--
-- Database: `medical_record_service_db`
--
CREATE DATABASE IF NOT EXISTS `medical_record_service_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `medical_record_service_db`;

-- --------------------------------------------------------

--
-- Table structure for table `test_results`
--

CREATE TABLE `test_results` (
  `id` bigint NOT NULL,
  `lab_test_id` bigint NOT NULL COMMENT 'Reference to lab_tests.id in consultation_service_db',
  `patient_id` bigint NOT NULL COMMENT 'Reference to patient from user_service_db',
  `technician_id` bigint NOT NULL COMMENT 'Technician who performed the test',
  `test_result_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `technician_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PDF, DOC, DOCX, JPG, PNG',
  `file_size` bigint DEFAULT NULL COMMENT 'File size in bytes',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `test_results`
--

INSERT INTO `test_results` (`id`, `lab_test_id`, `patient_id`, `technician_id`, `test_result_description`, `technician_notes`, `file_path`, `file_name`, `file_type`, `file_size`, `created_at`, `updated_at`) VALUES
(7, 3, 5, 17, 'X-Ray results attached. No abnormalities detected.', 'Clear imaging obtained', '47dcfa00-873c-43a6-b6af-40f7b40a3940.png', 'System Architecture.png', 'image/png', 178433, '2026-02-10 20:35:52', '2026-02-10 20:35:52'),
(18, 14, 5, 5, 'Hemoglobin: 13.2 g/dL (Normal)\r\nTotal WBC Count: 11,800 /ÂµL (Slightly Elevated)\r\nNeutrophils: 72% (Elevated)\r\nLymphocytes: 20% (Normal)\r\nPlatelets: 250,000 /ÂµL (Normal', 'Sample collected under sterile conditions.\r\nPatient was fasting for 10 hours before blood sample collection.\r\nResults verified and cross-checked before release.\r\nMild inflammatory response noted. Recommend physician review.', NULL, NULL, NULL, NULL, '2026-02-26 22:37:45', '2026-02-26 22:37:45'),
(19, 15, 5, 5, 'Hemoglobin: 13.2 g/dL (Normal)\r\n\r\nTotal WBC Count: 11,800 /ÂµL (Slightly Elevated)\r\n\r\nNeutrophils: 72% (Elevated)\r\n\r\nLymphocytes: 20% (Normal)\r\n\r\nPlatelets: 250,000 /ÂµL (Normal', 'Sample collected under sterile conditions.\r\n\r\nPatient was fasting for 10 hours before blood sample collection.\r\n\r\nResults verified and cross-checked before release.\r\n\r\nMild inflammatory response noted. Recommend physician review.', 'd70d183c-d931-426e-99b9-a57b3e2d47bf.jpg', 'ai-image-generator (1).jpg', 'image/jpeg', 119584, '2026-02-26 22:39:06', '2026-02-26 22:39:06'),
(20, 16, 38, 5, 'Hemoglobin: 13.2 g/dL (Normal)\r\nTotal WBC Count: 11,800 /ÂµL (Slightly Elevated)\r\nNeutrophils: 72% (Elevated)\r\nLymphocytes: 20% (Normal)\r\nPlatelets: 250,000 /ÂµL (Normal', 'Sample collected under sterile conditions.\r\nPatient was fasting for 10 hours before blood sample collection.\r\nResults verified and cross-checked before release.\r\nMild inflammatory response noted. Recommend physician review', 'e3ebdd16-80c2-4927-ae63-c5384d19131d.jpg', 'ai-image-generator (1).jpg', 'image/jpeg', 119584, '2026-02-26 22:44:07', '2026-02-26 22:44:07'),
(21, 17, 20, 5, 'test done', NULL, '79a0b75f-4cd4-4aeb-99e3-7fc29171e72b.jpg', 'ai-image-generator (1).jpg', 'image/jpeg', 119584, '2026-02-27 09:10:42', '2026-02-27 09:10:42'),
(22, 18, 5, 5, 'test02', NULL, '2c910665-1105-425a-8cd1-b7ff23bb0f75.jpg', 'ai-image-generator (1).jpg', 'image/jpeg', 119584, '2026-02-27 09:20:26', '2026-02-27 09:20:26');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `test_results`
--
ALTER TABLE `test_results`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_lab_test_id` (`lab_test_id`),
  ADD KEY `idx_patient_id` (`patient_id`),
  ADD KEY `idx_technician_id` (`technician_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `test_results`
--
ALTER TABLE `test_results`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int UNSIGNED NOT NULL,
  `dbase` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `query` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_length` text COLLATE utf8mb3_bin,
  `col_collation` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8mb3_bin DEFAULT '',
  `col_default` text COLLATE utf8mb3_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `settings_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8mb3_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `template_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tables` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `page_nr` int UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tables` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('admin', '[{\"db\":\"smartfines\",\"table\":\"users\"},{\"db\":\"smartfines\",\"table\":\"traffic_fines\"},{\"db\":\"smartfines\",\"table\":\"payments\"},{\"db\":\"smartfines\",\"table\":\"regions\"},{\"db\":\"smartfines\",\"table\":\"payment_receipts\"},{\"db\":\"smartfines\",\"table\":\"user_roles\"},{\"db\":\"smartfines\",\"table\":\"driver_star_history\"},{\"db\":\"smartfines\",\"table\":\"roles\"},{\"db\":\"smartfines\",\"table\":\"vehicle_categories\"},{\"db\":\"smartfines\",\"table\":\"officer_profiles\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `pdf_page_number` int NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8mb3_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `prefs` text COLLATE utf8mb3_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Tables'' UI preferences';

--
-- Dumping data for table `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('admin', 'clinic_service_db', 'clinics', '{\"sorted_col\":\"`clinic_id` ASC\"}', '2026-02-27 03:25:17');

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `version` int UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8mb3_bin NOT NULL,
  `schema_sql` text COLLATE utf8mb3_bin,
  `data_sql` longtext COLLATE utf8mb3_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8mb3_bin DEFAULT NULL,
  `tracking_active` int UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('admin', '2026-07-08 15:00:34', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8mb3_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `queue_service_db`
--
CREATE DATABASE IF NOT EXISTS `queue_service_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `queue_service_db`;

-- --------------------------------------------------------

--
-- Table structure for table `queue_tokens`
--

CREATE TABLE `queue_tokens` (
  `id` bigint NOT NULL,
  `token_number` int NOT NULL,
  `clinic_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patient_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `consultation_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PENDING','SERVING','COMPLETED','CANCELLED') COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL,
  `issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `queue_tokens`
--

INSERT INTO `queue_tokens` (`id`, `token_number`, `clinic_id`, `patient_id`, `consultation_id`, `status`, `position`, `issued_at`, `updated_at`) VALUES
(1, 1, '1', '5', '123', 'COMPLETED', 1, '2026-01-17 22:06:43', '2026-05-01 05:48:16'),
(2, 1, '12', '37', '12', 'PENDING', 1, '2026-01-18 06:24:34', '2026-01-18 06:24:34'),
(3, 2, '12', '37', '12', 'PENDING', 2, '2026-01-18 06:34:10', '2026-01-18 06:34:10'),
(4, 1, '16', '37', '16', 'PENDING', 1, '2026-01-18 06:45:04', '2026-01-18 06:45:04'),
(5, 2, '16', '5', '16', 'PENDING', 2, '2026-01-18 07:24:32', '2026-01-18 07:24:32'),
(6, 1, '17', '5', '17', 'PENDING', 1, '2026-01-20 18:05:08', '2026-01-20 18:05:08'),
(7, 3, '12', '6', '12', 'PENDING', 3, '2026-01-20 23:40:33', '2026-01-20 23:40:33'),
(8, 4, '12', '40', '12', 'PENDING', 4, '2026-01-21 00:12:21', '2026-01-21 00:12:21'),
(9, 5, '12', '3', '12', 'PENDING', 5, '2026-01-21 08:00:46', '2026-01-21 08:00:46'),
(10, 6, '12', '5', '12', 'PENDING', 6, '2026-01-21 02:54:53', '2026-01-21 02:54:53'),
(11, 1, '39', '3', '39', 'PENDING', 1, '2026-01-21 13:56:53', '2026-01-21 13:56:53'),
(12, 1, '37', '20', '37', 'PENDING', 1, '2026-01-21 14:13:22', '2026-01-21 14:13:22'),
(13, 7, '12', '20', '12', 'PENDING', 7, '2026-01-21 09:21:16', '2026-01-21 09:21:16'),
(14, 3, '16', '20', '16', 'PENDING', 3, '2026-01-21 11:11:51', '2026-01-21 11:11:51'),
(15, 2, '17', '38', '17', 'PENDING', 2, '2026-02-09 17:09:26', '2026-02-09 17:09:26'),
(16, 2, '37', '38', '37', 'PENDING', 2, '2026-02-09 17:12:03', '2026-02-09 17:12:03'),
(17, 3, '17', '51', '17', 'PENDING', 3, '2026-02-11 23:22:30', '2026-02-11 23:22:30'),
(18, 1, '40', '38', '40', 'PENDING', 1, '2026-02-23 13:57:06', '2026-02-23 13:57:06'),
(19, 4, '17', '38', '17', 'PENDING', 4, '2026-02-23 13:57:25', '2026-02-23 13:57:25'),
(20, 3, '37', '20', '37', 'PENDING', 3, '2026-02-26 18:24:41', '2026-02-26 18:24:41'),
(21, 2, '40', '20', '40', 'PENDING', 2, '2026-02-26 18:25:18', '2026-02-26 18:25:18'),
(22, 4, '37', '51', '37', 'PENDING', 4, '2026-02-26 23:39:22', '2026-02-26 23:39:22'),
(23, 2, '1', '38', NULL, 'CANCELLED', 1, '2026-05-01 06:05:43', '2026-05-01 06:11:48'),
(24, 3, '1', '38', NULL, 'PENDING', 2, '2026-05-01 06:05:55', '2026-05-01 06:05:55'),
(25, 8, '12', '38', NULL, 'CANCELLED', 8, '2026-05-01 06:06:54', '2026-05-02 04:05:17'),
(26, 9, '12', '38', NULL, 'PENDING', 9, '2026-05-01 06:07:15', '2026-05-01 06:07:15'),
(27, 4, '1', '38', NULL, 'PENDING', 2, '2026-05-01 06:11:55', '2026-05-01 06:11:55'),
(28, 1, '38', '38', NULL, 'CANCELLED', 1, '2026-05-01 06:12:22', '2026-05-02 04:05:29'),
(29, 1, '27', '38', NULL, 'PENDING', 1, '2026-05-02 04:02:04', '2026-05-02 04:02:04'),
(30, 1, '26', '38', NULL, 'PENDING', 1, '2026-05-02 04:02:30', '2026-05-02 04:02:30'),
(31, 2, '39', '38', NULL, 'COMPLETED', 2, '2026-05-03 04:57:19', '2026-05-03 04:59:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `queue_tokens`
--
ALTER TABLE `queue_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_clinic_token` (`clinic_id`,`token_number`),
  ADD KEY `idx_clinic_status_position` (`clinic_id`,`status`,`position`),
  ADD KEY `idx_patient` (`patient_id`),
  ADD KEY `idx_consultation` (`consultation_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `queue_tokens`
--
ALTER TABLE `queue_tokens`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- Database: `smartfines`
--
CREATE DATABASE IF NOT EXISTS `smartfines` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `smartfines`;

-- --------------------------------------------------------

--
-- Table structure for table `driver_star_history`
--

CREATE TABLE `driver_star_history` (
  `id` bigint NOT NULL,
  `driver_user_id` bigint NOT NULL,
  `fine_id` bigint DEFAULT NULL,
  `stars_before` int NOT NULL,
  `stars_after` int NOT NULL,
  `change_reason` varchar(255) NOT NULL,
  `changed_by_user_id` bigint NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `driver_star_history`
--

INSERT INTO `driver_star_history` (`id`, `driver_user_id`, `fine_id`, `stars_before`, `stars_after`, `change_reason`, `changed_by_user_id`, `changed_at`) VALUES
(1, 5, 1, 5, 4, 'fine issued', 3, '2026-05-11 15:51:31'),
(2, 4, 2, 5, 4, 'fine issued', 3, '2026-05-11 16:50:15'),
(3, 4, 3, 4, 3, 'fine issued', 3, '2026-06-07 07:15:21'),
(4, 4, 4, 3, 2, 'fine issued', 3, '2026-06-07 07:31:16'),
(5, 4, 5, 2, 1, 'fine issued', 3, '2026-06-07 16:40:42'),
(6, 4, 6, 1, 0, 'fine issued', 3, '2026-06-07 16:53:10'),
(7, 9, 7, 5, 4, 'fine issued', 3, '2026-06-10 21:10:26'),
(8, 4, 8, 0, 0, 'fine issued', 3, '2026-06-11 05:28:08'),
(9, 4, 9, 0, 0, 'fine issued', 3, '2026-06-11 05:30:32'),
(10, 4, 10, 0, 0, 'fine issued', 3, '2026-06-11 08:57:11'),
(11, 4, 11, 0, 0, 'fine issued', 3, '2026-06-11 12:41:10'),
(12, 4, 12, 0, 0, 'fine issued', 3, '2026-06-11 15:13:38'),
(13, 9, 13, 4, 3, 'fine issued', 3, '2026-06-11 16:12:59'),
(14, 9, 14, 3, 2, 'fine issued', 3, '2026-06-11 19:36:19'),
(15, 4, 15, 0, 0, 'fine issued', 3, '2026-06-12 04:27:40'),
(16, 4, 16, 0, 0, 'fine issued', 3, '2026-06-12 15:16:55');

-- --------------------------------------------------------

--
-- Table structure for table `fine_status_history`
--

CREATE TABLE `fine_status_history` (
  `id` bigint NOT NULL,
  `fine_id` bigint NOT NULL,
  `previous_status` enum('CANCELLED','DISPUTED','ISSUED','PAID','VOID') DEFAULT NULL,
  `new_status` enum('CANCELLED','DISPUTED','ISSUED','PAID','VOID') NOT NULL,
  `changed_by_user_id` bigint NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `fine_status_history`
--

INSERT INTO `fine_status_history` (`id`, `fine_id`, `previous_status`, `new_status`, `changed_by_user_id`, `changed_at`, `comment`) VALUES
(1, 1, NULL, 'ISSUED', 3, '2026-05-11 15:51:31', 'Fine issued'),
(2, 2, NULL, 'ISSUED', 3, '2026-05-11 16:50:15', 'Fine issued'),
(3, 2, 'ISSUED', 'PAID', 1, '2026-05-11 18:02:46', 'Payment completed'),
(4, 3, NULL, 'ISSUED', 3, '2026-06-07 07:15:20', 'Fine issued'),
(5, 3, 'ISSUED', 'PAID', 4, '2026-06-07 07:16:32', 'Payment completed'),
(6, 4, NULL, 'ISSUED', 3, '2026-06-07 07:31:15', 'Fine issued'),
(7, 4, 'ISSUED', 'PAID', 1, '2026-06-07 16:08:30', 'Payment completed'),
(8, 5, NULL, 'ISSUED', 3, '2026-06-07 16:40:42', 'Fine issued'),
(9, 5, 'ISSUED', 'PAID', 4, '2026-06-07 16:43:13', 'Payment completed'),
(10, 6, NULL, 'ISSUED', 3, '2026-06-07 16:53:10', 'Fine issued'),
(11, 6, 'ISSUED', 'PAID', 4, '2026-06-07 17:13:34', 'Payment completed'),
(12, 7, NULL, 'ISSUED', 3, '2026-06-10 21:10:25', 'Fine issued'),
(13, 8, NULL, 'ISSUED', 3, '2026-06-11 05:28:08', 'Fine issued'),
(14, 9, NULL, 'ISSUED', 3, '2026-06-11 05:30:31', 'Fine issued'),
(15, 8, 'ISSUED', 'PAID', 4, '2026-06-11 05:35:10', 'Payment completed'),
(17, 10, NULL, 'ISSUED', 3, '2026-06-11 08:57:11', 'Fine issued'),
(19, 9, 'ISSUED', 'PAID', 4, '2026-06-11 09:07:04', 'Payment completed'),
(20, 10, 'ISSUED', 'PAID', 4, '2026-06-11 09:09:03', 'Payment completed'),
(22, 11, NULL, 'ISSUED', 3, '2026-06-11 12:41:09', 'Fine issued'),
(23, 11, 'ISSUED', 'PAID', 4, '2026-06-11 13:04:30', 'Payment completed'),
(24, 12, NULL, 'ISSUED', 3, '2026-06-11 15:13:37', 'Fine issued'),
(25, 12, 'ISSUED', 'PAID', 4, '2026-06-11 15:15:33', 'Payment completed'),
(26, 13, NULL, 'ISSUED', 3, '2026-06-11 16:12:58', 'Fine issued'),
(27, 13, 'ISSUED', 'PAID', 9, '2026-06-11 16:15:17', 'Payment completed'),
(29, 14, NULL, 'ISSUED', 3, '2026-06-11 19:36:19', 'Fine issued'),
(30, 14, 'ISSUED', 'PAID', 9, '2026-06-11 19:39:10', 'Payment completed'),
(32, 15, NULL, 'ISSUED', 3, '2026-06-12 04:27:40', 'Fine issued'),
(33, 16, NULL, 'ISSUED', 3, '2026-06-12 15:16:55', 'Fine issued');

-- --------------------------------------------------------

--
-- Table structure for table `license_details`
--

CREATE TABLE `license_details` (
  `user_id` bigint NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `address` text,
  `region_id` bigint DEFAULT NULL,
  `stars` int NOT NULL DEFAULT '5',
  `license_status` enum('ACTIVE','CANCELLED','SUSPENDED') NOT NULL,
  `license_cancelled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `license_details`
--

INSERT INTO `license_details` (`user_id`, `license_number`, `date_of_birth`, `address`, `region_id`, `stars`, `license_status`, `license_cancelled_at`, `created_at`, `updated_at`) VALUES
(4, 'B1234567', '1995-06-15', '123 Main St', 1, 0, 'CANCELLED', '2026-06-12 15:16:55', '2026-05-11 15:42:18', '2026-06-12 15:16:56'),
(5, 'SP BAF-9087', '2026-05-12', '', 7, 4, 'ACTIVE', NULL, '2026-05-11 15:50:03', '2026-05-11 15:51:32'),
(7, 'BAS-1234', '2000-05-27', 'Temple road, Galle', 7, 5, 'ACTIVE', NULL, '2026-05-12 12:22:37', '2026-05-12 12:22:37'),
(9, '5545454', '1993-03-10', 'No 21, Templers Road, Dehiwala', 25, 2, 'ACTIVE', NULL, '2026-06-09 08:26:13', '2026-06-11 19:36:19'),
(10, '000123', '1999-12-31', '', 7, 5, 'ACTIVE', NULL, '2026-06-11 11:55:42', '2026-06-11 11:55:42');

-- --------------------------------------------------------

--
-- Table structure for table `license_detail_categories`
--

CREATE TABLE `license_detail_categories` (
  `license_detail_user_id` bigint NOT NULL,
  `vehicle_category_id` bigint NOT NULL,
  `granted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `license_recollections`
--

CREATE TABLE `license_recollections` (
  `id` bigint NOT NULL,
  `fine_id` bigint NOT NULL,
  `driver_user_id` bigint NOT NULL,
  `status` enum('CONFIRMED','MARKED_BY_DRIVER','PENDING') NOT NULL,
  `marked_recollected_at` timestamp NULL DEFAULT NULL,
  `confirmed_by_user_id` bigint DEFAULT NULL,
  `confirmed_at` timestamp NULL DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint NOT NULL,
  `recipient_user_id` bigint NOT NULL,
  `actor_user_id` bigint DEFAULT NULL,
  `type` varchar(80) NOT NULL,
  `title` varchar(150) NOT NULL,
  `message` text NOT NULL,
  `related_fine_id` bigint DEFAULT NULL,
  `related_payment_id` bigint DEFAULT NULL,
  `action_url` text,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `recipient_user_id`, `actor_user_id`, `type`, `title`, `message`, `related_fine_id`, `related_payment_id`, `action_url`, `is_read`, `read_at`, `created_at`) VALUES
(1, 3, 4, 'receipt_uploaded', 'Receipt uploaded', 'Receipt uploaded for fine FN-1778518214130-E05A9D', 2, 1, NULL, 1, '2026-06-12 06:13:27', '2026-05-11 17:50:02'),
(2, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1778518214130-E05A9D', 2, 1, NULL, 1, '2026-06-12 06:13:27', '2026-05-11 18:02:46'),
(3, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1780816519550-C9EEBC', 3, 2, NULL, 1, '2026-06-12 06:13:27', '2026-06-07 07:16:33'),
(4, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1780817474590-F14BE3', 4, 3, NULL, 1, '2026-06-12 06:13:27', '2026-06-07 16:08:31'),
(5, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1780850441243-8320A9', 5, 4, NULL, 1, '2026-06-12 06:13:27', '2026-06-07 16:43:14'),
(6, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1780851189172-8DB5A1', 6, 5, NULL, 1, '2026-06-12 06:13:27', '2026-06-07 17:13:35'),
(7, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1781155686921-010BEC', 8, 6, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 05:35:10'),
(10, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1781155830916-9BCD19', 9, 9, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 09:07:04'),
(11, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1781168229921-3B4EAD', 10, 10, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 09:09:03'),
(13, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1781181668455-D45FA4', 11, 15, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 13:04:30'),
(14, 3, 4, 'payment_received', 'Payment received', 'Payment received for fine FN-1781190816737-1CA132', 12, 16, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 15:15:33'),
(15, 3, 9, 'payment_received', 'Payment received', 'Payment received for fine FN-1781194377423-1AFF4D', 13, 17, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 16:15:18'),
(17, 3, 9, 'payment_received', 'Payment received', 'Payment received for fine FN-1781206578001-F5ED1C', 14, 18, NULL, 1, '2026-06-12 06:13:27', '2026-06-11 19:39:10');

-- --------------------------------------------------------

--
-- Table structure for table `notification_deliveries`
--

CREATE TABLE `notification_deliveries` (
  `id` bigint NOT NULL,
  `notification_id` bigint NOT NULL,
  `channel` enum('EMAIL','IN_APP','SMS') NOT NULL,
  `delivery_status` enum('FAILED','QUEUED','SENT') NOT NULL,
  `delivered_to` varchar(255) DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `error_message` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notification_deliveries`
--

INSERT INTO `notification_deliveries` (`id`, `notification_id`, `channel`, `delivery_status`, `delivered_to`, `sent_at`, `error_message`, `created_at`) VALUES
(1, 1, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-05-11 17:50:02'),
(2, 1, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-05-11 17:50:02'),
(3, 2, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-05-11 18:02:47'),
(4, 2, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-05-11 18:02:47'),
(5, 3, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-07 07:16:34'),
(6, 3, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-07 07:16:34'),
(7, 4, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-07 16:08:31'),
(8, 4, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-07 16:08:32'),
(9, 5, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-07 16:43:14'),
(10, 5, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-07 16:43:15'),
(11, 6, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-07 17:13:35'),
(12, 6, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-07 17:13:36'),
(13, 7, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 05:35:11'),
(14, 7, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 05:35:11'),
(17, 10, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 09:07:05'),
(19, 10, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 09:07:05'),
(21, 11, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 09:09:04'),
(23, 11, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 09:09:04'),
(25, 13, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 13:04:31'),
(26, 13, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 13:04:31'),
(27, 14, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 15:15:34'),
(28, 14, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 15:15:34'),
(29, 15, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 16:15:18'),
(31, 15, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 16:15:18'),
(33, 17, 'IN_APP', 'QUEUED', NULL, NULL, NULL, '2026-06-11 19:39:11'),
(35, 17, 'EMAIL', 'QUEUED', 'kpathum616@gmail.com', NULL, NULL, '2026-06-11 19:39:11');

-- --------------------------------------------------------

--
-- Table structure for table `officer_profiles`
--

CREATE TABLE `officer_profiles` (
  `user_id` bigint NOT NULL,
  `officer_code` varchar(50) NOT NULL,
  `badge_number` varchar(50) DEFAULT NULL,
  `station_name` varchar(150) DEFAULT NULL,
  `region_id` bigint DEFAULT NULL,
  `created_by_user_id` bigint DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `officer_profiles`
--

INSERT INTO `officer_profiles` (`user_id`, `officer_code`, `badge_number`, `station_name`, `region_id`, `created_by_user_id`, `created_at`, `updated_at`) VALUES
(3, 'OFF-COL-001', 'SLP45872', 'Colombo Traffic Police', 1, 1, '2026-05-11 15:38:42', '2026-05-11 15:38:42'),
(12, 'OFF-COL-002', 'SLP45873', 'Negombo Traffic Police', 9, NULL, '2026-06-12 05:43:30', '2026-06-12 05:43:30');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint NOT NULL,
  `fine_id` bigint NOT NULL,
  `driver_user_id` bigint NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('ONLINE','RECEIPT_UPLOAD') NOT NULL,
  `payment_status` enum('FAILED','PAID','PENDING','REVERSED') NOT NULL,
  `transaction_reference` varchar(100) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `fine_id`, `driver_user_id`, `amount`, `payment_method`, `payment_status`, `transaction_reference`, `paid_at`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 2500.00, 'RECEIPT_UPLOAD', 'PAID', '5343434343', '2026-05-11 18:02:45', '2026-05-11 17:49:57', '2026-05-11 18:02:47'),
(2, 3, 4, 3000.00, 'ONLINE', 'PAID', NULL, '2026-06-07 07:16:32', '2026-06-07 07:16:33', '2026-06-07 07:16:33'),
(3, 4, 4, 4500.00, 'RECEIPT_UPLOAD', 'PAID', 'test', '2026-06-07 16:08:30', '2026-06-07 07:32:19', '2026-06-07 16:08:32'),
(4, 5, 4, 3000.00, 'ONLINE', 'PAID', 'ONLINE-1780850590275', '2026-06-07 16:43:13', '2026-06-07 16:43:13', '2026-06-07 16:43:13'),
(5, 6, 4, 3000.00, 'ONLINE', 'PAID', 'cs_test_a1ny6v6sgCQiErOhR4m7YmdkGA9s70VRfjYnMAyrdtP8ZiaUTSw18DPod3', '2026-06-07 17:13:34', '2026-06-07 17:11:21', '2026-06-07 17:13:36'),
(6, 8, 4, 2000.00, 'ONLINE', 'PAID', 'cs_test_a1sDkh2iyfmbKWfLTihQ4RvbVpBW1J1LxnIZfVEtx3JgmUaoTTGRmROxPT', '2026-06-11 05:35:10', '2026-06-11 05:32:33', '2026-06-11 05:35:12'),
(9, 9, 4, 2000.00, 'ONLINE', 'PAID', 'cs_test_a1g8p2lNGe7PuDx2fzVt2iozqu6X6uIK1rE21gCPQEfcrLl8F06ci2r2q3', '2026-06-11 09:07:04', '2026-06-11 09:03:22', '2026-06-11 09:07:06'),
(10, 10, 4, 3000.00, 'ONLINE', 'PAID', 'cs_test_a1uWEMi7NTkl8jF7ADqjRlr0rRx7IsSk3IxT4QjHuU8x2tAFnggyIQP3G4', '2026-06-11 09:09:03', '2026-06-11 09:08:16', '2026-06-11 09:09:05'),
(12, 7, 9, 3000.00, 'ONLINE', 'PENDING', 'cs_test_a1cqTSGb2Jf9hSQ0hnCyQ63AhihjcFxkDqNJdBnZvI7vvDxjUI9Xx3UgvG', NULL, '2026-06-11 09:36:53', '2026-06-11 09:36:55'),
(15, 11, 4, 5000.00, 'ONLINE', 'PAID', 'cs_test_a1E5jVBN8UXgUGMjrYG1Soc0UipSYH7XRXQTX6vTfw3dVKJVtqXsF1viCY', '2026-06-11 13:04:29', '2026-06-11 13:03:47', '2026-06-11 13:04:32'),
(16, 12, 4, 2000.00, 'ONLINE', 'PAID', 'cs_test_a1HoYN7YE3yobx3gwMEdcYo4mGxW6vR5AcVtY18QcIEyUOLnoD3f2QBWVk', '2026-06-11 15:15:33', '2026-06-11 15:14:36', '2026-06-11 15:15:35'),
(17, 13, 9, 2000.00, 'ONLINE', 'PAID', 'cs_test_a1KPJ35upwBnY96QPuVAVV49YVI6vftCKQHws6zv2V7UFMs8hKFNtkiKX4', '2026-06-11 16:15:17', '2026-06-11 16:14:06', '2026-06-11 16:15:19'),
(18, 14, 9, 2500.00, 'ONLINE', 'PAID', 'cs_test_a1b5gnA1a26O2v5h2JmxQK3TYDtpGQLPxcRTFire0LyzthDrliIPTWIm8j', '2026-06-11 19:39:09', '2026-06-11 19:38:07', '2026-06-11 19:39:12'),
(19, 15, 4, 2500.00, 'ONLINE', 'PENDING', 'cs_test_a1fPTWUeAsR6e0utSYdBIgMZhqIoQ5K1yyKtkIc0jvVDKSHynvm4ynwf7f', NULL, '2026-06-12 15:17:44', '2026-06-12 15:17:46'),
(20, 16, 4, 3000.00, 'ONLINE', 'PENDING', 'cs_test_a1C9M1Nd2rO2vIKoCYdT7jaOETJ4tVz3ebgFsTaBKGEaBBv72hpCQisHeJ', NULL, '2026-06-14 06:19:09', '2026-06-14 06:19:10');

-- --------------------------------------------------------

--
-- Table structure for table `payment_receipts`
--

CREATE TABLE `payment_receipts` (
  `id` bigint NOT NULL,
  `payment_id` bigint NOT NULL,
  `receipt_number` varchar(80) NOT NULL,
  `source` enum('DRIVER_UPLOADED','WEB_GENERATED') NOT NULL,
  `file_url` text NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `file_size_bytes` bigint DEFAULT NULL,
  `uploaded_by_user_id` bigint DEFAULT NULL,
  `generated_at` timestamp NULL DEFAULT NULL,
  `verified_by_user_id` bigint DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment_receipts`
--

INSERT INTO `payment_receipts` (`id`, `payment_id`, `receipt_number`, `source`, `file_url`, `file_name`, `mime_type`, `file_size_bytes`, `uploaded_by_user_id`, `generated_at`, `verified_by_user_id`, `verified_at`, `notes`, `created_at`) VALUES
(1, 1, 'RC-1778521800999-804834', 'DRIVER_UPLOADED', 'H:\\EC6208_Software_Architecure\\EC6208_Software_Architecure\\SmartFines\\backend\\storage\\receipts\\f382df8f-f007-4913-b5bb-f082aed37e79_Group_Project_-_Ruhuna_2026.pdf', 'Group_Project_-_Ruhuna_2026.pdf', 'application/pdf', 71105, 4, '2026-05-11 17:50:01', 1, '2026-05-11 18:02:45', NULL, '2026-05-11 17:50:01');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `code`, `description`, `created_at`) VALUES
(1, 'MANAGE_USERS', 'Manage system users', '2026-05-11 15:35:18'),
(2, 'MANAGE_ROLES', 'Manage roles and permissions', '2026-05-11 15:35:18'),
(3, 'ISSUE_FINE', 'Issue traffic fines', '2026-05-11 15:35:18'),
(4, 'VIEW_FINE', 'View traffic fines', '2026-05-11 15:35:18'),
(5, 'PAY_FINE', 'Pay traffic fines', '2026-05-11 15:35:18'),
(6, 'VERIFY_PAYMENT', 'Verify payment receipts', '2026-05-11 15:35:18'),
(7, 'MANAGE_LICENSE', 'Manage driver licenses', '2026-05-11 15:35:18'),
(8, 'VIEW_REPORTS', 'View system reports', '2026-05-11 15:35:18');

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` bigint NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `district` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `code`, `name`, `district`, `province`, `created_at`, `updated_at`) VALUES
(1, 'COL', 'Colombo', 'Colombo', 'Western', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(2, 'GAM', 'Gampaha', 'Gampaha', 'Western', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(3, 'KAL', 'Kalutara', 'Kalutara', 'Western', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(4, 'KAN', 'Kandy', 'Kandy', 'Central', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(5, 'MAT', 'Matale', 'Matale', 'Central', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(6, 'NUW', 'Nuwara Eliya', 'Nuwara Eliya', 'Central', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(7, 'GAL', 'Galle', 'Galle', 'Southern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(8, 'HAM', 'Hambantota', 'Hambantota', 'Southern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(9, 'MTR', 'Matara', 'Matara', 'Southern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(10, 'JAF', 'Jaffna', 'Jaffna', 'Northern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(11, 'KIL', 'Kilinochchi', 'Kilinochchi', 'Northern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(12, 'MAN', 'Mannar', 'Mannar', 'Northern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(13, 'MUL', 'Mullaitivu', 'Mullaitivu', 'Northern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(14, 'VAV', 'Vavuniya', 'Vavuniya', 'Northern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(15, 'BAT', 'Batticaloa', 'Batticaloa', 'Eastern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(16, 'AMP', 'Ampara', 'Ampara', 'Eastern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(17, 'TRI', 'Trincomalee', 'Trincomalee', 'Eastern', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(18, 'KUR', 'Kurunegala', 'Kurunegala', 'North Western', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(19, 'PUT', 'Puttalam', 'Puttalam', 'North Western', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(20, 'ANU', 'Anuradhapura', 'Anuradhapura', 'North Central', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(21, 'POL', 'Polonnaruwa', 'Polonnaruwa', 'North Central', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(22, 'BAD', 'Badulla', 'Badulla', 'Uva', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(23, 'MON', 'Monaragala', 'Monaragala', 'Uva', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(24, 'RAT', 'Ratnapura', 'Ratnapura', 'Sabaragamuwa', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(25, 'KEG', 'Kegalle', 'Kegalle', 'Sabaragamuwa', '2026-05-11 15:26:52', '2026-05-11 15:26:52'),
(26, 'MATS', 'Matara', 'Matara', 'Southern', '2026-05-11 15:35:18', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'admin', 'System role: admin', '2026-05-11 14:56:00'),
(2, 'traffic_officer', 'System role: traffic_officer', '2026-05-11 14:56:00'),
(3, 'driver', 'System role: driver', '2026-05-11 14:56:00');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `granted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `permission_id`, `granted_at`) VALUES
(1, 1, '2026-05-11 15:35:18'),
(1, 2, '2026-05-11 15:35:18'),
(1, 3, '2026-05-11 15:35:18'),
(1, 4, '2026-05-11 15:35:18'),
(1, 5, '2026-05-11 15:35:18'),
(1, 6, '2026-05-11 15:35:18'),
(1, 7, '2026-05-11 15:35:18'),
(1, 8, '2026-05-11 15:35:18'),
(2, 3, '2026-05-11 15:35:18'),
(2, 4, '2026-05-11 15:35:18'),
(2, 6, '2026-05-11 15:35:18'),
(2, 7, '2026-05-11 15:35:18'),
(3, 4, '2026-05-11 15:35:18'),
(3, 5, '2026-05-11 15:35:18');

-- --------------------------------------------------------

--
-- Table structure for table `traffic_fines`
--

CREATE TABLE `traffic_fines` (
  `id` bigint NOT NULL,
  `fine_reference_number` varchar(80) NOT NULL,
  `driver_user_id` bigint NOT NULL,
  `officer_user_id` bigint NOT NULL,
  `region_id` bigint NOT NULL,
  `vehicle_number` varchar(30) NOT NULL,
  `driver_license_number_snapshot` varchar(50) NOT NULL,
  `violation_date` date NOT NULL,
  `violation_details` text NOT NULL,
  `violation_place` varchar(255) NOT NULL,
  `fine_amount` decimal(10,2) NOT NULL,
  `license_collection_location` varchar(255) NOT NULL,
  `status` enum('CANCELLED','DISPUTED','ISSUED','PAID','VOID') NOT NULL,
  `issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paid_at` timestamp NULL DEFAULT NULL,
  `due_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `traffic_fines`
--

INSERT INTO `traffic_fines` (`id`, `fine_reference_number`, `driver_user_id`, `officer_user_id`, `region_id`, `vehicle_number`, `driver_license_number_snapshot`, `violation_date`, `violation_details`, `violation_place`, `fine_amount`, `license_collection_location`, `status`, `issued_at`, `paid_at`, `due_at`, `created_at`, `updated_at`) VALUES
(1, 'FN-1778514690566-04259E', 5, 3, 7, 'SP BAF-9087', 'SP BAF-9087', '2026-05-11', 'Driving without seat bel', 'Galle Highway Entrance', 7500.00, 'Galle Traffic Police Station', 'ISSUED', '2026-05-11 15:51:31', NULL, '2026-05-14 15:51:00', '2026-05-11 15:51:31', '2026-05-11 15:51:31'),
(2, 'FN-1778518214130-E05A9D', 4, 3, 7, 'SP BAF-9086', 'B1234567', '2026-05-11', 'Driving without seat belt', 'Galle Highway Entrance', 2500.00, 'Galle Traffic Police Station', 'PAID', '2026-05-11 16:50:15', '2026-05-11 18:02:46', '2026-05-13 16:48:00', '2026-05-11 16:50:15', '2026-05-11 18:02:48'),
(3, 'FN-1780816519550-C9EEBC', 4, 3, 3, 'SP BAF-9086', 'B1234567', '2026-06-07', 'Paking at wrong place', 'Galle', 3000.00, 'near the twon', 'PAID', '2026-06-07 07:15:20', '2026-06-07 07:16:32', '2026-06-13 07:15:00', '2026-06-07 07:15:20', '2026-06-07 07:16:35'),
(4, 'FN-1780817474590-F14BE3', 4, 3, 3, 'SP BAF-9086', 'B1234567', '2026-06-07', 'paking violetion', 'Galle', 4500.00, 'Galle', 'PAID', '2026-06-07 07:31:15', '2026-06-07 16:08:30', '2026-06-11 07:31:00', '2026-06-07 07:31:15', '2026-06-07 16:08:32'),
(5, 'FN-1780850441243-8320A9', 4, 3, 3, 'SP BAF-9086', 'B1234567', '2026-06-05', 'parking violetion', 'Galle', 3000.00, ' Galle bustand', 'PAID', '2026-06-07 16:40:42', '2026-06-07 16:43:13', '2026-06-07 16:40:00', '2026-06-07 16:40:42', '2026-06-07 16:43:15'),
(6, 'FN-1780851189172-8DB5A1', 4, 3, 3, 'SP BAF-9086', 'B1234567', '2026-06-03', 'Parking illegle', 'galle', 3000.00, 'bustand', 'PAID', '2026-06-07 16:53:10', '2026-06-07 17:13:34', '2026-06-08 16:53:00', '2026-06-07 16:53:10', '2026-06-07 17:13:37'),
(7, 'FN-1781125824502-0A6CE0', 9, 3, 25, '5545454', '5545454', '2026-06-10', 'Driving Without a Valid License', 'Galle', 3000.00, 'Galle', 'ISSUED', '2026-06-10 21:10:25', NULL, '2026-06-16 21:09:00', '2026-06-10 21:10:25', '2026-06-10 21:10:25'),
(8, 'FN-1781155686921-010BEC', 4, 3, 7, 'SP BAF-9087', 'B1234567', '2026-06-11', 'Driving without seat belt', 'Galle', 2000.00, 'Galle', 'PAID', '2026-06-11 05:28:07', '2026-06-11 05:35:10', '2026-06-25 05:27:00', '2026-06-11 05:28:07', '2026-06-11 05:35:13'),
(9, 'FN-1781155830916-9BCD19', 4, 3, 7, 'SP BAF-9087', 'B1234567', '2026-06-11', 'Driving without seat belt', 'Galle', 2000.00, 'Galle', 'PAID', '2026-06-11 05:30:31', '2026-06-11 09:07:04', '2026-06-18 05:28:00', '2026-06-11 05:30:31', '2026-06-11 09:07:06'),
(10, 'FN-1781168229921-3B4EAD', 4, 3, 3, 'SP BAF-9087', 'B1234567', '2026-06-11', 'paking', 'Galle', 3000.00, 'staand', 'PAID', '2026-06-11 08:57:10', '2026-06-11 09:09:03', '2026-06-12 08:57:00', '2026-06-11 08:57:10', '2026-06-11 09:09:05'),
(11, 'FN-1781181668455-D45FA4', 4, 3, 7, 'SP BAF-9087', 'B1234567', '2026-06-11', 'Driving without seat belt', 'Galle', 5000.00, 'Galle', 'PAID', '2026-06-11 12:41:09', '2026-06-11 13:04:30', '2026-06-24 12:40:00', '2026-06-11 12:41:09', '2026-06-11 13:04:32'),
(12, 'FN-1781190816737-1CA132', 4, 3, 7, 'SP BAF-9088', 'B1234567', '2026-06-11', 'Driving without seat belt', 'Galle', 2000.00, 'Galle', 'PAID', '2026-06-11 15:13:37', '2026-06-11 15:15:33', '2026-06-18 15:13:00', '2026-06-11 15:13:37', '2026-06-11 15:15:35'),
(13, 'FN-1781194377423-1AFF4D', 9, 3, 25, '5545454', '5545454', '2026-06-02', 'Reckless Driving', 'Colombo', 2000.00, 'Colombo', 'PAID', '2026-06-11 16:12:58', '2026-06-11 16:15:17', NULL, '2026-06-11 16:12:58', '2026-06-11 16:15:20'),
(14, 'FN-1781206578001-F5ED1C', 9, 3, 25, '5545454', '5545454', '2026-06-05', 'Parking at the wrong place', 'Galle', 2500.00, 'Galle', 'PAID', '2026-06-11 19:36:18', '2026-06-11 19:39:10', NULL, '2026-06-11 19:36:18', '2026-06-11 19:39:13'),
(15, 'FN-1781238459004-08102B', 4, 3, 7, 'ABC-1234', 'B1234567', '2026-06-12', 'Driving above the permitted speed limit', 'Galle Road', 2500.00, 'Galle Police Station', 'ISSUED', '2026-06-12 04:27:39', NULL, '2026-06-20 18:29:00', '2026-06-12 04:27:39', '2026-06-12 04:27:39'),
(16, 'FN-1781277414108-C9B694', 4, 3, 3, 'SP BAF-9087', 'B1234567', '2026-06-12', 'cutting double lline', 'Bus Stand', 3000.00, 'Galle', 'ISSUED', '2026-06-12 15:16:54', NULL, '2026-06-12 15:16:00', '2026-06-12 15:16:54', '2026-06-12 15:16:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `nic` varchar(30) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `status` enum('ACTIVE','DELETED','SUSPENDED') NOT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `username`, `email`, `phone`, `nic`, `password_hash`, `status`, `last_login_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin One', 'admin1', 'admin1@smartfines.local', '0770000000', NULL, '$2b$10$tYEXTWGzA1uxRxXAM.kTT.rTOdi48eBKw7ZHtIu18sltQ8YqMfW8e', 'ACTIVE', NULL, '2026-05-11 14:56:00', NULL, NULL),
(3, 'pathum', NULL, 'kpathum616@gmail.com', '3433535353', '3535353253253', '$2a$10$6L7WGGZ1MNWy3/E7.dU1qu.eOdW8HDZlBfaji93nElUsShh4Vs0Pm', 'ACTIVE', NULL, '2026-05-11 15:38:39', '2026-05-11 15:38:39', NULL),
(4, 'John Driver', NULL, 'john.driver@example.com', '0771234567', '123456789V', '$2a$10$6OKVDDKR192eswaD2Y2MZOY8aENm/pjmrOHmYy3/rCcTUq51lE9zW', 'ACTIVE', NULL, '2026-05-11 15:42:17', '2026-05-11 15:42:17', NULL),
(5, 'officer', NULL, 'pathum616@gmail.com', '075898930', '198765432109', '$2a$10$pFoTzMGcwcwmy0//N.2.Fuf11khbS.UVs14cxORWodmIKPuw3oHHK', 'ACTIVE', NULL, '2026-05-11 15:50:02', '2026-05-11 15:50:02', NULL),
(7, 'Sandun', NULL, 'sandun@gmail.com', '0712345678', '200216500600', '$2a$10$wS9.hVbdPyfDXQ54Gn4Fvex5X5AXzd.W5pURi2gAtN/D5VGBYxz9i', 'ACTIVE', NULL, '2026-05-12 12:22:36', '2026-05-12 12:22:36', NULL),
(9, 'Kamal Silva', NULL, 'kamal@gmail.com', '0712345671', '199567234581', '$2a$10$.NqHjbxdL3zAdxeaCO/VaeMsLSX9KoDhaBsyBotvmYSRFL5IjHWdO', 'ACTIVE', NULL, '2026-06-09 08:26:11', '2026-06-09 08:26:11', NULL),
(10, 'Test User', NULL, 'test@example.com', '0711234564', '1234567890', '$2a$10$wRHxdk4QRDq6iehBP//A..X4dSj9pPjjYqAc75CGq95UHtZ33ChfK', 'ACTIVE', NULL, '2026-06-11 11:55:40', '2026-06-11 11:55:40', NULL),
(12, 'Emasha Medakanda', NULL, 'emasha.officer02@gmail.com', '0771234599', '200112345678', '$2a$10$yJznUmNdHpzdAs8ZOS2Vie0NLoCnJ1egVih0E2GTD4d/Iw9kBQpMe', 'ACTIVE', NULL, '2026-06-12 05:43:28', '2026-06-12 05:43:28', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `assigned_by_user_id` bigint DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`, `assigned_by_user_id`, `assigned_at`) VALUES
(1, 1, NULL, '2026-05-11 14:56:00'),
(3, 2, 1, '2026-05-11 15:38:42'),
(4, 3, NULL, '2026-05-11 15:42:18'),
(5, 3, NULL, '2026-05-11 15:50:03'),
(7, 3, NULL, '2026-05-12 12:22:38'),
(9, 3, NULL, '2026-06-09 08:26:13'),
(10, 3, NULL, '2026-06-11 11:55:42'),
(12, 2, NULL, '2026-06-12 05:43:30');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `id` bigint NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'A', 'Motorcycle', 'Motorcycles and scooters', '2026-05-11 15:35:18', NULL),
(2, 'B', 'Three Wheeler', 'Three wheel vehicles', '2026-05-11 15:35:18', NULL),
(3, 'C', 'Car', 'Private motor cars', '2026-05-11 15:35:18', NULL),
(4, 'D', 'Van', 'Passenger vans', '2026-05-11 15:35:18', NULL),
(5, 'E', 'Bus', 'Public transport buses', '2026-05-11 15:35:18', NULL),
(6, 'F', 'Lorry', 'Heavy goods vehicles', '2026-05-11 15:35:18', NULL),
(7, 'G', 'Dual Purpose', 'SUV and dual purpose vehicles', '2026-05-11 15:35:18', NULL),
(8, 'H', 'Tractor', 'Agricultural tractors', '2026-05-11 15:35:18', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `driver_star_history`
--
ALTER TABLE `driver_star_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_driver_star_history_driver` (`driver_user_id`),
  ADD KEY `fk_driver_star_history_fine` (`fine_id`),
  ADD KEY `fk_driver_star_history_user` (`changed_by_user_id`);

--
-- Indexes for table `fine_status_history`
--
ALTER TABLE `fine_status_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fine_status_history_fine` (`fine_id`),
  ADD KEY `fk_fine_status_history_user` (`changed_by_user_id`);

--
-- Indexes for table `license_details`
--
ALTER TABLE `license_details`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `license_number` (`license_number`),
  ADD KEY `fk_license_details_region` (`region_id`);

--
-- Indexes for table `license_detail_categories`
--
ALTER TABLE `license_detail_categories`
  ADD PRIMARY KEY (`license_detail_user_id`,`vehicle_category_id`),
  ADD KEY `fk_license_detail_categories_category` (`vehicle_category_id`);

--
-- Indexes for table `license_recollections`
--
ALTER TABLE `license_recollections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fine_id` (`fine_id`),
  ADD KEY `fk_license_recollections_driver` (`driver_user_id`),
  ADD KEY `fk_license_recollections_confirmed_by` (`confirmed_by_user_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notifications_recipient` (`recipient_user_id`),
  ADD KEY `fk_notifications_actor` (`actor_user_id`),
  ADD KEY `fk_notifications_fine` (`related_fine_id`),
  ADD KEY `fk_notifications_payment` (`related_payment_id`);

--
-- Indexes for table `notification_deliveries`
--
ALTER TABLE `notification_deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_notification_deliveries_notification` (`notification_id`);

--
-- Indexes for table `officer_profiles`
--
ALTER TABLE `officer_profiles`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `officer_code` (`officer_code`),
  ADD UNIQUE KEY `badge_number` (`badge_number`),
  ADD KEY `fk_officer_profiles_region` (`region_id`),
  ADD KEY `fk_officer_profiles_created_by` (`created_by_user_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_reference` (`transaction_reference`),
  ADD KEY `fk_payments_fine` (`fine_id`),
  ADD KEY `fk_payments_driver` (`driver_user_id`);

--
-- Indexes for table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_id` (`payment_id`),
  ADD UNIQUE KEY `receipt_number` (`receipt_number`),
  ADD KEY `fk_payment_receipts_uploaded_by` (`uploaded_by_user_id`),
  ADD KEY `fk_payment_receipts_verified_by` (`verified_by_user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `fk_role_permissions_permission` (`permission_id`);

--
-- Indexes for table `traffic_fines`
--
ALTER TABLE `traffic_fines`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fine_reference_number` (`fine_reference_number`),
  ADD KEY `fk_traffic_fines_driver` (`driver_user_id`),
  ADD KEY `fk_traffic_fines_officer` (`officer_user_id`),
  ADD KEY `fk_traffic_fines_region` (`region_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `nic` (`nic`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `fk_user_roles_role` (`role_id`),
  ADD KEY `fk_user_roles_assigned_by` (`assigned_by_user_id`);

--
-- Indexes for table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `driver_star_history`
--
ALTER TABLE `driver_star_history`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `fine_status_history`
--
ALTER TABLE `fine_status_history`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `license_recollections`
--
ALTER TABLE `license_recollections`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `notification_deliveries`
--
ALTER TABLE `notification_deliveries`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `traffic_fines`
--
ALTER TABLE `traffic_fines`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `driver_star_history`
--
ALTER TABLE `driver_star_history`
  ADD CONSTRAINT `fk_driver_star_history_driver` FOREIGN KEY (`driver_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_driver_star_history_fine` FOREIGN KEY (`fine_id`) REFERENCES `traffic_fines` (`id`),
  ADD CONSTRAINT `fk_driver_star_history_user` FOREIGN KEY (`changed_by_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `fine_status_history`
--
ALTER TABLE `fine_status_history`
  ADD CONSTRAINT `fk_fine_status_history_fine` FOREIGN KEY (`fine_id`) REFERENCES `traffic_fines` (`id`),
  ADD CONSTRAINT `fk_fine_status_history_user` FOREIGN KEY (`changed_by_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `license_details`
--
ALTER TABLE `license_details`
  ADD CONSTRAINT `fk_license_details_region` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`),
  ADD CONSTRAINT `fk_license_details_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `license_detail_categories`
--
ALTER TABLE `license_detail_categories`
  ADD CONSTRAINT `fk_license_detail_categories_category` FOREIGN KEY (`vehicle_category_id`) REFERENCES `vehicle_categories` (`id`),
  ADD CONSTRAINT `fk_license_detail_categories_license` FOREIGN KEY (`license_detail_user_id`) REFERENCES `license_details` (`user_id`);

--
-- Constraints for table `license_recollections`
--
ALTER TABLE `license_recollections`
  ADD CONSTRAINT `fk_license_recollections_confirmed_by` FOREIGN KEY (`confirmed_by_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_license_recollections_driver` FOREIGN KEY (`driver_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_license_recollections_fine` FOREIGN KEY (`fine_id`) REFERENCES `traffic_fines` (`id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_actor` FOREIGN KEY (`actor_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_notifications_fine` FOREIGN KEY (`related_fine_id`) REFERENCES `traffic_fines` (`id`),
  ADD CONSTRAINT `fk_notifications_payment` FOREIGN KEY (`related_payment_id`) REFERENCES `payments` (`id`),
  ADD CONSTRAINT `fk_notifications_recipient` FOREIGN KEY (`recipient_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `notification_deliveries`
--
ALTER TABLE `notification_deliveries`
  ADD CONSTRAINT `fk_notification_deliveries_notification` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`);

--
-- Constraints for table `officer_profiles`
--
ALTER TABLE `officer_profiles`
  ADD CONSTRAINT `fk_officer_profiles_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_officer_profiles_region` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`),
  ADD CONSTRAINT `fk_officer_profiles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_driver` FOREIGN KEY (`driver_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payments_fine` FOREIGN KEY (`fine_id`) REFERENCES `traffic_fines` (`id`);

--
-- Constraints for table `payment_receipts`
--
ALTER TABLE `payment_receipts`
  ADD CONSTRAINT `fk_payment_receipts_payment` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`),
  ADD CONSTRAINT `fk_payment_receipts_uploaded_by` FOREIGN KEY (`uploaded_by_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_payment_receipts_verified_by` FOREIGN KEY (`verified_by_user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `traffic_fines`
--
ALTER TABLE `traffic_fines`
  ADD CONSTRAINT `fk_traffic_fines_driver` FOREIGN KEY (`driver_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_traffic_fines_officer` FOREIGN KEY (`officer_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_traffic_fines_region` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_assigned_by` FOREIGN KEY (`assigned_by_user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
--
-- Database: `user_service_db`
--
CREATE DATABASE IF NOT EXISTS `user_service_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `user_service_db`;

-- --------------------------------------------------------

--
-- Table structure for table `admin_profile`
--

CREATE TABLE `admin_profile` (
  `admin_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `nic_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin_profile`
--

INSERT INTO `admin_profile` (`admin_id`, `user_id`, `first_name`, `last_name`, `date_of_birth`, `phone_number`, `nic_number`) VALUES
(1, 5, 'Kamal', 'Perera', '1995-07-12', '0912345783', '199545678321'),
(2, 12, 'Kasun', 'Chamara', '1997-03-15', '0715643936', '199734781025'),
(3, 23, 'sss', 'sss', '2025-11-05', '0774526391', '199234502981'),
(4, 16, 'Lakshan', 'Imantha', '2002-10-02', '0702294900', '200227603224'),
(5, 33, 'Yasiru', 'Chandupa', '2002-05-27', '0756167773', '200214123456'),
(6, 53, 'test', 'test', '2002-05-27', '123444', '33333');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_profile`
--

CREATE TABLE `doctor_profile` (
  `doctor_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `nic_number` varchar(255) DEFAULT NULL,
  `license_number` varchar(255) DEFAULT NULL,
  `specialization` varchar(255) DEFAULT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `experience_years` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `doctor_profile`
--

INSERT INTO `doctor_profile` (`doctor_id`, `user_id`, `first_name`, `last_name`, `date_of_birth`, `phone_number`, `nic_number`, `license_number`, `specialization`, `qualification`, `experience_years`) VALUES
(1, 3, 'Gayan', 'Perera', '1990-10-12', '0762345674', '199023451756', 'DC-6778', 'ENT Surgeon', 'MD', 12),
(2, 7, 'Ruwan', 'Silva', '1993-12-11', '0762578231', '199321347849', 'DC-3450', 'VP', 'MBBS', 8),
(3, 19, 'Tharindi', 'Perera', '2025-11-06', '0718892214', '200015603742', 'SLMC-51672', 'Dermatology', 'MBBS, MD (Dermatology)', 8),
(4, 27, 'Chathuri', 'Karunathilaka', '2025-11-19', '+94771234567', '198912301234', 'SLMC 24587', 'Dermatology', 'MBBS (University of Colombo), MD Dermatology (PGIM)', 7),
(5, 30, 'kumara', 'Vimukthi', '2025-11-14', '0729876543', '200114800857', 'SLMC-52672', 'Oncology', 'uor - medicine', 8),
(7, 11, 'Saman', 'Gamage', '1990-12-11', '0775432189', '199034567812', 'DC-2475', 'VP', 'MBBS', 10),
(8, 25, 'lll', 'lll', '2026-01-24', '0756167773', '200214800857', '111111', 'Surgery', 'ssssss', 3),
(9, 39, 'Doc . Pathum', 'Vimukthi', '2002-10-16', '740516990', '3432432434', '3434343', 'Gastroenterology', '434f', 4);

-- --------------------------------------------------------

--
-- Table structure for table `patient_profile`
--

CREATE TABLE `patient_profile` (
  `patient_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `nic_number` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `blood_group` varchar(255) DEFAULT NULL,
  `allergies` varchar(255) DEFAULT NULL,
  `chronic_diseases` varchar(255) DEFAULT NULL,
  `emergency_contact` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `patient_profile`
--

INSERT INTO `patient_profile` (`patient_id`, `user_id`, `first_name`, `last_name`, `date_of_birth`, `phone_number`, `nic_number`, `address`, `gender`, `blood_group`, `allergies`, `chronic_diseases`, `emergency_contact`) VALUES
(1, 2, 'Nimal', 'Silva', '1987-03-18', '0772134987', '198734567812', 'No 12, Dickson Road, Galle', 'Male', 'O+', NULL, NULL, 'Father: 0763458320'),
(2, 6, 'Nuwan1', 'Gamage', '1990-03-20', '0775645123', '199034786712', 'No 24, Ward Place, Colombo', 'Male', 'O+', 'Penicillin', NULL, 'Brother: 0912345782'),
(3, 20, 'Yasiru', 'Pandigama', '2002-05-27', '0756167773', '200214800857', 'Galle, Sri Lanka', 'Male', 'O+', '', '', '0712345678'),
(4, 15, 'Steve', 'Alice', '1992-05-27', '0763452187', '199234789023', 'No 20, Havelock Road, Colombo', 'Male', 'O+', NULL, NULL, 'Mother: 0783456128'),
(5, 38, 'Pathum', 'Vimukthi', '2026-02-18', '234324234324', '434324324343', '', 'Male', 'O+', '', '', ''),
(6, 40, 'Thanujaya', 'Tennekoon', '2002-04-18', '0763253332', '200211800381', 'No.70,Jayasundara Gardens,Kurunegala Road.Polgahawela', 'Male', 'B+', 'Aloewera', 'Asthma', '0714471564'),
(7, 51, 'Thanujaya', 'Tennekoon', '2026-02-05', '0763253332', '1234567891', 'No.70,Jayasundara Gardens,Kurunegala Road.Polgahawela', 'Male', 'O+', 'Aloewera', 'Asthma', '0714471564'),
(8, 52, 'pathum', 'vimukthi', '2026-04-08', '+94740521333', '4214434243443', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` bigint NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  `secret_key` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `role_description`, `secret_key`, `created_at`) VALUES
(1, 'Doctor', 'Registered Medical Doctor', 'DOC-7xK!3mP4rT@89', '2025-11-04 15:58:58'),
(2, 'Patient', 'General Patient', NULL, '2025-11-04 16:10:33'),
(4, 'Admin', 'System Administrator', 'ADM-9fY72#QpLx@21', '2025-11-04 16:20:40'),
(5, 'Technician', 'Medical Technician', 'TECH-4vR#81Lm@2Qw', '2025-11-19 20:54:00');

-- --------------------------------------------------------

--
-- Table structure for table `technician_profile`
--

CREATE TABLE `technician_profile` (
  `technician_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `nic_number` varchar(255) DEFAULT NULL,
  `technician_field` varchar(255) DEFAULT NULL,
  `license_number` varchar(255) DEFAULT NULL,
  `certification` varchar(255) DEFAULT NULL,
  `assigned_equipment` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `technician_profile`
--

INSERT INTO `technician_profile` (`technician_id`, `user_id`, `first_name`, `last_name`, `date_of_birth`, `phone_number`, `nic_number`, `technician_field`, `license_number`, `certification`, `assigned_equipment`) VALUES
(1, 17, 'John', 'Smith', '1984-05-27', '0768945672', '198456782310', 'Radiology', 'RT-2024-8891', 'Radiology Technician NVQ Level 5', 'Portable X-Ray Unit'),
(2, 14, 'Sarath', 'Silva', '1985-08-30', '0772345672', '198523456701', 'ECG', 'ECG-2024-1253', 'ECG Technician NVQ Level 5', 'ECG Unit'),
(4, 22, 'Technitian', '1', '2026-02-08', '+94771234567', '195512345678', 'Cardiovascular', 'SLMC 24587', 'Blood Analyzer', 'Microscope'),
(5, 48, 'pathum', 'vimukthi', '2026-02-24', '33535354', '535435454', 'Cardiovascular', '5545454', '554544', '45454');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role_id`, `created_at`, `updated_at`) VALUES
(2, 'nimal', 'nimal123@gmail.com', '932d7ba32f69871d3d84004d980eb23c58127a153a952e94ec38284ccd083fe2', 2, '2025-11-05 14:37:47', '2025-11-05 15:31:02'),
(3, 'perera', 'perera567@gmail.com', '7d2e242f315d9d09b2ce82557da6d192d112f3d82e2b5eeab74262be7fdea9a4', 1, '2025-11-05 15:48:36', '2025-11-05 15:48:36'),
(5, 'kamal', 'kamal325@gmail.com', '869a07af6ed4b4ebd250164d60ca65ada5bd28258fa44d80a24f83b77086109c', 4, '2025-11-05 15:57:45', '2025-11-05 18:11:56'),
(6, 'Nuwan', 'nuwan234@gmail.com', 'd83aad9df0f60e8ff4e5f516c92adcebc4106269393dfff2520a265497fe28cf', 2, '2025-11-15 21:59:23', '2025-11-15 21:59:23'),
(7, 'Ruwan', 'ruwan135@gmail.com', 'eb31080d15fa4318e2fcb05e74b3533f7e76e3ed7e81a08688c3aab13c22440c', 1, '2025-11-20 01:38:56', '2025-11-20 01:38:56'),
(11, 'Saman', 'saman12@gmail.com', '1de663b08b342ae3ef31af8984489c4bfb738be670e0db1657fa20d420650f95', 1, '2025-11-20 02:03:11', '2025-11-20 02:03:11'),
(12, 'Kasun', 'kasun672@gmail.com', 'ae3ef84455fe01688209336d3a2e2ca68bbcf55a914e96183943f204b5c92cb0', 4, '2025-11-20 02:07:09', '2025-11-28 16:28:52'),
(14, 'sarath', 'sarath78@gmail.com', 'f394bbf1ee9929adf389eef8ac1a5ed8649da15c55c63e4d9621e2dea101459d', 5, '2025-11-20 10:06:38', '2025-11-20 10:06:38'),
(15, 'steve', 'steve990@gmail.com', 'ef2e0b10861cfe6d0ac6d8bb89a5b831c5912fdb4d67fe89372526553b6529b7', 2, '2025-11-20 10:13:32', '2025-11-20 10:13:32'),
(16, 'lakshan', 'lakshan02@gmail.com', '500191dd43ce4656822237bea1e01add1b22f38278d9e2a4d68e96d0b6b992b9', 4, '2025-11-20 11:54:23', '2025-11-20 11:54:23'),
(17, 'john', 'john235@gmail.com', '92e78ebe74149f62c3540cd8b20c95d96dd1664a6dc325919d02387770b65914', 5, '2025-11-22 12:35:18', '2025-11-22 12:35:18'),
(18, 'dr_sajith92', 'sajith.karunathilaka@example.com', '052af8ac8cde3988051bd291a13024945aacbb18105da8f118858b18980b9a13', 1, '2025-11-23 06:42:05', '2025-11-23 06:42:05'),
(19, 'dr_tharindi', 'tharindi.perera@example.com', '19514c2e914d5734101baed9d0acd0966f409f3f6b12500a7d6174c035c19d49', 1, '2025-11-23 07:05:43', '2025-11-23 07:05:43'),
(20, 'yrcd27', 'yasirucp2002@gmail.com', '2fa491b11f3d2f488a3a4241148dc30811087a656a17325029fa2a1a552706fb', 2, '2025-11-23 07:24:19', '2025-11-23 07:24:19'),
(21, 'yyyy', 'yyyy@gmail.com', 'a9d7c5dd768dab87e473b84f6a5b251a1de83328dd3055a42cd267a3813305bf', 1, '2025-11-23 07:29:34', '2025-11-23 07:29:34'),
(22, 'Technitian_1', 'aaa@gmail.com', 'f64561e04c3be9cea6271afcd2b324f4b8654ed1b011f4f15ff4436e0100d5a0', 5, '2025-11-23 07:31:57', '2026-02-25 12:59:08'),
(23, 'sss', 'sss@gmail.com', '2ce2278a88b5c6fa79ccb632e064b85c2ca9915dd58fa293c813af9c426df5c6', 4, '2025-11-23 07:33:49', '2025-11-23 07:33:49'),
(24, 'pathum', 'pathum@gmail.com', '049f84fd6c2fc4c77c6a27f93e0cbc9dd7b06a1f69d2cbb44e7c9d369ba4cf4f', 1, '2025-11-23 11:12:58', '2025-11-23 11:12:58'),
(25, 'thanu', 'thanujaya@gmail.com', 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', 4, '2025-11-23 11:18:49', '2026-03-28 17:30:11'),
(26, 'vimukthis', 'vimukthi@gmail.com', 'c039716f6beef76b61c6e18ece81e3141012e69327dd46c9711fa18fab2c9732', 5, '2025-11-23 11:28:46', '2025-11-23 11:28:46'),
(27, 'dr_chathuri', 'chathuri.k@health.gov.lk', 'df6f508796d4a2be3c2aeda1363aa4a67a28cbc7246171f6955dfc2d2b699217', 1, '2025-11-23 15:59:01', '2025-11-23 15:59:01'),
(28, 'nimal ', 'nimal@gmail.com', '884894fa487be4870fe7238f874ee6ee9892625d72843a7b89d5749a33f6b85d', 2, '2025-11-23 16:05:31', '2025-11-23 16:05:31'),
(30, 'Kumara', 'kumara@health.gov.lk', '1b8b7e7724a647576d3b9a769bcd54f78d55e5cef2442dfba65757bbc1f7e516', 1, '2025-11-24 05:08:28', '2025-11-24 05:08:28'),
(31, 'Mike', 'mike278@gmail.com', 'a65e6348bf7207a154d69162710d8745c7798901ab0203f18e79877c35c24455', 5, '2025-11-25 08:58:54', '2025-11-25 08:58:54'),
(32, 'pathumvimukthi', 'pathumvimukthi@gmail.com', '202105d6988bdc3f6a11ac0e43c4480ae79f4db9d5638a35c1386fbf1a8d5de0', 4, '2025-11-25 18:49:20', '2025-11-25 18:49:20'),
(33, 'Yrcd', 'yasiru@gmail.com', '6d7c21c87a9bfb76b679bb48afe6a72208e845087942ba5d519872d5cdf775cc', 4, '2025-12-01 13:29:22', '2025-12-01 13:29:22'),
(37, 'PathumVimukthi11', 'pathum33@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, '2026-01-17 13:57:06', '2026-01-17 13:57:06'),
(38, 'test1', 'test1@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, '2026-01-18 06:46:04', '2026-01-18 06:46:04'),
(39, 'doctortest', 'doctortest@gmail.com', 'e90caf6c9cea6bf46fffec29577368c8b9bc3d69472cc8d0a5b35b79d69d04f0', 1, '2026-01-18 07:20:50', '2026-01-18 07:20:50'),
(40, 'ThanuPatient', 'thanupatient@arogya.lk', 'f6a9f86bba7ca3f7284e35ef2347298459bd0d94d7c66389bbaef9995ae6f1c7', 2, '2026-01-20 16:59:45', '2026-01-20 16:59:45'),
(41, 'ThanuDoc', 'thanudoc@arogya.lk', 'f6a9f86bba7ca3f7284e35ef2347298459bd0d94d7c66389bbaef9995ae6f1c7', 1, '2026-01-20 17:16:48', '2026-01-20 17:16:48'),
(42, 'ThanuAdmin', 'thanuadmin@arogya.lk', 'f6a9f86bba7ca3f7284e35ef2347298459bd0d94d7c66389bbaef9995ae6f1c7', 4, '2026-01-20 17:56:13', '2026-01-20 17:56:13'),
(44, 'ssss', 'ssss@gmail.com', '2ce2278a88b5c6fa79ccb632e064b85c2ca9915dd58fa293c813af9c426df5c6', 1, '2026-01-21 08:15:36', '2026-01-21 08:15:36'),
(46, 'Laskhan', 'lakshan.imantha02@gmail.com', '46529430652b97071aca63bc06588b7df2035e3cc4838cfde4c3075b61b976e9', 1, '2026-01-21 09:14:20', '2026-01-21 09:14:20'),
(47, 'lll', 'lll@gmail.com', 'ab8754ad07935b41a329bcb79d93d44fdbfcd6379a6e6310f4eec0e2f23febce', 1, '2026-01-21 09:16:28', '2026-01-21 09:16:28'),
(48, 'testtechnician', 'testtechnician@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 5, '2026-02-10 10:53:29', '2026-02-10 10:53:29'),
(49, 'Dev01Adm01', 'Dev01Adm01@dev.com', 'f6a9f86bba7ca3f7284e35ef2347298459bd0d94d7c66389bbaef9995ae6f1c7', 4, '2026-02-11 16:40:38', '2026-02-11 16:40:38'),
(50, 'Dev01Doc01', 'Dev01Doc01@dev.com', 'f6a9f86bba7ca3f7284e35ef2347298459bd0d94d7c66389bbaef9995ae6f1c7', 1, '2026-02-11 16:49:32', '2026-02-11 16:49:32'),
(51, 'Dev01Pat01', 'Dev01Pat01@dev.com', 'f6a9f86bba7ca3f7284e35ef2347298459bd0d94d7c66389bbaef9995ae6f1c7', 2, '2026-02-11 17:51:31', '2026-02-11 17:51:31'),
(52, 'pathum_vimukthi03', 'pathumvimukthi03@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 2, '2026-03-09 16:30:46', '2026-03-09 16:30:46'),
(53, 'test admin', 'testadmin@example.com', '6b5856cdc03e4b4fd67c58053b50b0c5f01cac7d3f796f8c2d38aa23c9c601ea', 4, '2026-03-28 17:46:39', '2026-03-28 17:46:39'),
(55, 'Pathum_02', 'pathum616@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 4, '2026-04-30 17:54:20', '2026-04-30 17:54:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_profile`
--
ALTER TABLE `admin_profile`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `doctor_profile`
--
ALTER TABLE `doctor_profile`
  ADD PRIMARY KEY (`doctor_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `patient_profile`
--
ALTER TABLE `patient_profile`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `technician_profile`
--
ALTER TABLE `technician_profile`
  ADD PRIMARY KEY (`technician_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `FK_users_roles` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_profile`
--
ALTER TABLE `admin_profile`
  MODIFY `admin_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `doctor_profile`
--
ALTER TABLE `doctor_profile`
  MODIFY `doctor_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `patient_profile`
--
ALTER TABLE `patient_profile`
  MODIFY `patient_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `technician_profile`
--
ALTER TABLE `technician_profile`
  MODIFY `technician_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_profile`
--
ALTER TABLE `admin_profile`
  ADD CONSTRAINT `admin_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `doctor_profile`
--
ALTER TABLE `doctor_profile`
  ADD CONSTRAINT `doctor_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient_profile`
--
ALTER TABLE `patient_profile`
  ADD CONSTRAINT `patient_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `technician_profile`
--
ALTER TABLE `technician_profile`
  ADD CONSTRAINT `technician_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_users_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

--
USE clinic_service_db;
-- Structure for view `v_available_doctors`
--
DROP TABLE IF EXISTS `v_available_doctors`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%` SQL SECURITY DEFINER VIEW `v_available_doctors`  AS SELECT `doctor_cache`.`doctor_id` AS `doctor_id`, `doctor_cache`.`doctor_name` AS `doctor_name`, `doctor_cache`.`specialization` AS `specialization`, `doctor_cache`.`email` AS `email`, `doctor_cache`.`phone` AS `phone`, `doctor_cache`.`license_number` AS `license_number`, `doctor_cache`.`is_active` AS `is_active` FROM `doctor_cache` WHERE (`doctor_cache`.`is_active` = true) ORDER BY `doctor_cache`.`doctor_name` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `v_clinic_dashboard`
--
DROP TABLE IF EXISTS `v_clinic_dashboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%` SQL SECURITY DEFINER VIEW `v_clinic_dashboard`  AS SELECT `c`.`clinic_id` AS `clinic_id`, `c`.`clinic_name` AS `clinic_name`, `c`.`province` AS `province`, `c`.`district` AS `district`, `c`.`location` AS `location`, `c`.`scheduled_date` AS `date`, `c`.`scheduled_time` AS `time`, `c`.`status` AS `status`, `c`.`total_capacity` AS `capacity`, `c`.`current_bookings` AS `current_bookings`, concat(`c`.`current_bookings`,'/',`c`.`total_capacity`) AS `capacity_text`, `c`.`capacity_percentage` AS `capacity_percentage`, group_concat(`cd`.`doctor_name` separator ', ') AS `doctors_assigned`, group_concat(`cd`.`specialization` separator ', ') AS `specializations`, count(`cd`.`id`) AS `doctor_count` FROM (`clinics` `c` left join `clinic_doctors` `cd` on(((`c`.`clinic_id` = `cd`.`clinic_id`) and (`cd`.`is_active` = true)))) GROUP BY `c`.`clinic_id` ORDER BY `c`.`scheduled_date` DESC, `c`.`scheduled_time` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `v_doctors_need_sync`
--
DROP TABLE IF EXISTS `v_doctors_need_sync`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`%` SQL SECURITY DEFINER VIEW `v_doctors_need_sync`  AS SELECT `cd`.`id` AS `id`, `cd`.`clinic_id` AS `clinic_id`, `cd`.`doctor_ref_id` AS `doctor_ref_id`, `cd`.`doctor_name` AS `doctor_name`, `cd`.`sync_status` AS `sync_status`, `cd`.`last_sync_attempt` AS `last_sync_attempt`, `cd`.`sync_error_message` AS `sync_error_message`, timestampdiff(HOUR,`cd`.`synced_at`,now()) AS `hours_since_sync` FROM `clinic_doctors` AS `cd` WHERE ((`cd`.`sync_status` = 'FAILED') OR (timestampdiff(HOUR,`cd`.`synced_at`,now()) > 24)) ;

--
