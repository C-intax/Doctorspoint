-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2019 at 01:59 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 5.6.39

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doctorspoint`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `doctors_id` int(11) DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `chamber_id` int(11) DEFAULT NULL,
  `comment` longtext,
  `medicine_list` longtext COMMENT 'semicolon separated medicine',
  `pharmachy_list` longtext COMMENT 'semicolon separated pharmachy ids',
  `patient_status` int(11) DEFAULT NULL,
  `appointment_status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `appointment_status`
--

CREATE TABLE `appointment_status` (
  `id` int(11) NOT NULL,
  `name` tinytext,
  `color` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `diagnostic_details`
--

CREATE TABLE `diagnostic_details` (
  `user_id` int(11) NOT NULL COMMENT 'user_id',
  `email` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `location` varchar(1000) DEFAULT NULL,
  `user_type` int(11) DEFAULT '2' COMMENT '1->Doctor,2->Patient,3->Pharmachy,4->Diagnostic. 5->Default',
  `is_login` int(5) DEFAULT '0',
  `Is_activated` int(5) DEFAULT '0',
  `password_change_date` datetime DEFAULT NULL,
  `previous_password` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `diagnostic_tests`
--

CREATE TABLE `diagnostic_tests` (
  `id` int(11) NOT NULL,
  `appointment_id` int(11) DEFAULT NULL,
  `test_id` text,
  `diagnostic_center_id` int(11) DEFAULT NULL,
  `test_status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `doctors_assistant`
--

CREATE TABLE `doctors_assistant` (
  `id` int(11) NOT NULL,
  `doctors_email` text,
  `doctors_id` int(11) DEFAULT NULL,
  `password` varchar(150) DEFAULT NULL,
  `doctor_chamber_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `doctors_chamber`
--

CREATE TABLE `doctors_chamber` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `name` text,
  `location` text,
  `contact_number` text,
  `start_time` varchar(50) DEFAULT NULL,
  `end_time` varchar(50) DEFAULT NULL,
  `per_patient_interval` int(5) DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctors_chamber`
--

INSERT INTO `doctors_chamber` (`id`, `doctor_id`, `name`, `location`, `contact_number`, `start_time`, `end_time`, `per_patient_interval`) VALUES
(1, 1, 'Lab Aid Diagnostic', '12/4B Dhanmondi, Dhaka', '+8801824819966', '6:30 PM', '9:30 PM', 10),
(2, 1, 'Ibna Sina Lab', '15/6 Kakrail Dhaka', '+8801716237654', '4:30 PM', '6:30 PM', 10),
(3, 1, 'Khan Medical Centre', 'Old Jatrabari, Khetpara, Dhaka', '+01813764534', '9:30 AM', '11:30 AM', 10),
(4, 2, 'Apollo Diagnostic Centre', 'Block A, Bashundhora R/A, Dhaka', '+8801823432678', '10:30 AM', '12:30 PM', 10),
(5, 2, 'Cresent Lab Ltd.', 'Sector 13, Uttara, Dhaka', '+88017346373928\r\n', '4:30 PM', '8:30 PM', 10);

-- --------------------------------------------------------

--
-- Table structure for table `doctors_degree`
--

CREATE TABLE `doctors_degree` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `institute` text,
  `degree_name` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctors_degree`
--

INSERT INTO `doctors_degree` (`id`, `doctor_id`, `institute`, `degree_name`) VALUES
(1, 1, 'Dhaka Medical College', 'Bachelor of Medicine MBBS'),
(2, 1, 'Sher e Bangla Medical College', 'FCPS'),
(3, 2, 'Bangabondhu Sheukh Mujib Medical College', 'MBBS'),
(4, 2, 'Sir Solimullah Medical College', 'FCPS');

-- --------------------------------------------------------

--
-- Table structure for table `doctors_details`
--

CREATE TABLE `doctors_details` (
  `user_id` int(11) NOT NULL COMMENT 'user_id',
  `email` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `user_type` int(11) DEFAULT '1' COMMENT '1->Doctor,2->Patient,3->Pharmachy,4->Diagnostic. 5->Default',
  `is_login` int(5) DEFAULT '0',
  `Is_activated` int(5) DEFAULT '0',
  `isVerified` int(5) DEFAULT NULL,
  `password_change_date` datetime DEFAULT NULL,
  `previous_password` varchar(300) DEFAULT NULL,
  `doctors_domain_id` varchar(100) DEFAULT NULL COMMENT 'semicolon separated domain id',
  `doctors_reg_no` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctors_details`
--

INSERT INTO `doctors_details` (`user_id`, `email`, `password`, `name`, `user_type`, `is_login`, `Is_activated`, `isVerified`, `password_change_date`, `previous_password`, `doctors_domain_id`, `doctors_reg_no`) VALUES
(1, 'dummy_doctor_1@doctorspoint.com', 'dummydoctor_1', 'Dr. Faisal Hasan', 1, 0, 1, 1, NULL, NULL, '1', 'REG001'),
(2, 'dummy_dotor_2@doctorspoint.com', 'dummydoctor_2', 'Dr. Ferdous Hasan', 1, 0, 1, 1, NULL, NULL, '2', 'REG002');

-- --------------------------------------------------------

--
-- Table structure for table `doctors_domain`
--

CREATE TABLE `doctors_domain` (
  `id` int(11) NOT NULL,
  `domain_name` varchar(150) DEFAULT NULL,
  `description` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctors_domain`
--

INSERT INTO `doctors_domain` (`id`, `domain_name`, `description`) VALUES
(1, 'Neuro Sergeon', 'Dummy 1 Domain'),
(2, 'Medicine', 'Dummy 2 Domain'),
(3, 'Darmatologyst', 'Dummy 3 Domain');

-- --------------------------------------------------------

--
-- Table structure for table `patient_details`
--

CREATE TABLE `patient_details` (
  `user_id` int(11) NOT NULL COMMENT 'user_id',
  `email` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `user_type` int(11) DEFAULT '2' COMMENT '1->Doctor,2->Patient,3->Pharmachy,4->Diagnostic. 5->Default',
  `is_login` int(5) DEFAULT '0',
  `Is_activated` int(5) DEFAULT '0',
  `password_change_date` datetime DEFAULT NULL,
  `previous_password` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `patient_status`
--

CREATE TABLE `patient_status` (
  `id` int(11) NOT NULL,
  `name` text,
  `color` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy_details`
--

CREATE TABLE `pharmacy_details` (
  `user_id` int(11) NOT NULL COMMENT 'user_id',
  `email` varchar(300) DEFAULT NULL,
  `password` varchar(300) DEFAULT NULL,
  `name` varchar(300) DEFAULT NULL,
  `location` varchar(1000) DEFAULT NULL,
  `user_type` int(11) DEFAULT '2' COMMENT '1->Doctor,2->Patient,3->Pharmachy,4->Diagnostic. 5->Default',
  `is_login` int(5) DEFAULT '0',
  `Is_activated` int(5) DEFAULT '0',
  `password_change_date` datetime DEFAULT NULL,
  `previous_password` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `test_list`
--

CREATE TABLE `test_list` (
  `id` int(11) NOT NULL,
  `name` text,
  `category` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `test_status`
--

CREATE TABLE `test_status` (
  `id` int(11) NOT NULL,
  `name` tinytext,
  `color` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `appointment_status`
--
ALTER TABLE `appointment_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `diagnostic_details`
--
ALTER TABLE `diagnostic_details`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `diagnostic_tests`
--
ALTER TABLE `diagnostic_tests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctors_assistant`
--
ALTER TABLE `doctors_assistant`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctors_chamber`
--
ALTER TABLE `doctors_chamber`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctors_degree`
--
ALTER TABLE `doctors_degree`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctors_details`
--
ALTER TABLE `doctors_details`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `doctors_domain`
--
ALTER TABLE `doctors_domain`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient_details`
--
ALTER TABLE `patient_details`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `patient_status`
--
ALTER TABLE `patient_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pharmacy_details`
--
ALTER TABLE `pharmacy_details`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `test_list`
--
ALTER TABLE `test_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_status`
--
ALTER TABLE `test_status`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `appointment_status`
--
ALTER TABLE `appointment_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diagnostic_details`
--
ALTER TABLE `diagnostic_details`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user_id';

--
-- AUTO_INCREMENT for table `diagnostic_tests`
--
ALTER TABLE `diagnostic_tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors_assistant`
--
ALTER TABLE `doctors_assistant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors_chamber`
--
ALTER TABLE `doctors_chamber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `doctors_degree`
--
ALTER TABLE `doctors_degree`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `doctors_details`
--
ALTER TABLE `doctors_details`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user_id', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctors_domain`
--
ALTER TABLE `doctors_domain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patient_details`
--
ALTER TABLE `patient_details`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user_id';

--
-- AUTO_INCREMENT for table `patient_status`
--
ALTER TABLE `patient_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pharmacy_details`
--
ALTER TABLE `pharmacy_details`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'user_id';

--
-- AUTO_INCREMENT for table `test_list`
--
ALTER TABLE `test_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `test_status`
--
ALTER TABLE `test_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
