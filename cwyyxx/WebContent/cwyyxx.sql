/*
Navicat MySQL Data Transfer

Source Server         : 本地连接
Source Server Version : 50717
Source Host           : 127.0.0.1:3306
Source Database       : cwyyxx

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-10-07 19:43:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_cust
-- ----------------------------
DROP TABLE IF EXISTS `t_cust`;
CREATE TABLE `t_cust` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`cust_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `t_cust_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cust
-- ----------------------------

-- ----------------------------
-- Table structure for t_doctor
-- ----------------------------
DROP TABLE IF EXISTS `t_doctor`;
CREATE TABLE `t_doctor` (
  `doctor_id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_name` varchar(100) NOT NULL,
  `office` varchar(100) NOT NULL,
  `intro` varchar(1000) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `t_doctor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_doctor
-- ----------------------------

-- ----------------------------
-- Table structure for t_hospital_worker
-- ----------------------------
DROP TABLE IF EXISTS `t_hospital_worker`;
CREATE TABLE `t_hospital_worker` (
  `worker_id` int(11) NOT NULL AUTO_INCREMENT,
  `worker_name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`worker_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `t_hospital_worker_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_hospital_worker
-- ----------------------------

-- ----------------------------
-- Table structure for t_medicine
-- ----------------------------
DROP TABLE IF EXISTS `t_medicine`;
CREATE TABLE `t_medicine` (
  `medicine_id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_name` varchar(1000) NOT NULL,
  `price` double(11,2) NOT NULL,
  `unit` varchar(11) NOT NULL,
  `expiry_date` varchar(100) NOT NULL,
  `manufacturer` varchar(1000) NOT NULL,
  `stocks_num` int(11) NOT NULL,
  `status` varchar(11) NOT NULL,
  `intro` varchar(1000) NOT NULL,
  `medicine_type_id` int(11) NOT NULL,
  PRIMARY KEY (`medicine_id`),
  KEY `medicine_type_id` (`medicine_type_id`),
  CONSTRAINT `t_medicine_ibfk_1` FOREIGN KEY (`medicine_type_id`) REFERENCES `t_medicine_type` (`medicine_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_medicine
-- ----------------------------

-- ----------------------------
-- Table structure for t_medicine_type
-- ----------------------------
DROP TABLE IF EXISTS `t_medicine_type`;
CREATE TABLE `t_medicine_type` (
  `medicine_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `medicine_type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`medicine_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_medicine_type
-- ----------------------------

-- ----------------------------
-- Table structure for t_order_base
-- ----------------------------
DROP TABLE IF EXISTS `t_order_base`;
CREATE TABLE `t_order_base` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `money_due` double(11,2) NOT NULL,
  `money_received` double(11,2) NOT NULL,
  `create_time` datetime NOT NULL,
  `status` varchar(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `case_id` (`case_id`),
  KEY `cust_id` (`cust_id`),
  KEY `worker_id` (`worker_id`),
  CONSTRAINT `t_order_base_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `t_pet_case` (`case_id`),
  CONSTRAINT `t_order_base_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `t_cust` (`cust_id`),
  CONSTRAINT `t_order_base_ibfk_3` FOREIGN KEY (`worker_id`) REFERENCES `t_hospital_worker` (`worker_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_base
-- ----------------------------

-- ----------------------------
-- Table structure for t_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_order_detail`;
CREATE TABLE `t_order_detail` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `cost_type` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `price` double(11,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `t_order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `t_order_base` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for t_pet
-- ----------------------------
DROP TABLE IF EXISTS `t_pet`;
CREATE TABLE `t_pet` (
  `pet_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` varchar(100) NOT NULL,
  `pet_name` varchar(100) NOT NULL,
  `pet_type` varchar(100) NOT NULL,
  `birthday` datetime NOT NULL,
  `sex` varchar(5) NOT NULL,
  `color` varchar(20) NOT NULL,
  `weight` varchar(20) NOT NULL,
  `habit` varchar(200) NOT NULL,
  `is_fertility` varchar(20) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `cust_id` int(11) NOT NULL,
  PRIMARY KEY (`pet_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `t_pet_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `t_cust` (`cust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_pet
-- ----------------------------

-- ----------------------------
-- Table structure for t_pet_case
-- ----------------------------
DROP TABLE IF EXISTS `t_pet_case`;
CREATE TABLE `t_pet_case` (
  `case_id` int(11) NOT NULL AUTO_INCREMENT,
  `pet_name` varchar(100) NOT NULL,
  ` symptom` varchar(1000) NOT NULL,
  `check_project` varchar(1000) NOT NULL,
  `check_result` varchar(1000) NOT NULL,
  `diagnosis_result` varchar(1000) NOT NULL,
  `remedy_project` varchar(1000) NOT NULL,
  `medicine` varchar(1000) NOT NULL,
  `remedy_time` datetime NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `cust_id` int(11) NOT NULL,
  PRIMARY KEY (`case_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `cust_id` (`cust_id`),
  CONSTRAINT `t_pet_case_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `t_doctor` (`doctor_id`),
  CONSTRAINT `t_pet_case_ibfk_2` FOREIGN KEY (`cust_id`) REFERENCES `t_cust` (`cust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_pet_case
-- ----------------------------

-- ----------------------------
-- Table structure for t_project
-- ----------------------------
DROP TABLE IF EXISTS `t_project`;
CREATE TABLE `t_project` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(1000) NOT NULL,
  `price` double(11,2) NOT NULL,
  `unit` varchar(11) NOT NULL,
  `intro` varchar(1000) NOT NULL,
  `remark` varchar(1000) NOT NULL,
  `pro_type_id` int(11) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `pro_type_id` (`pro_type_id`),
  CONSTRAINT `t_project_ibfk_1` FOREIGN KEY (`pro_type_id`) REFERENCES `t_project_type` (`pro_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_project
-- ----------------------------

-- ----------------------------
-- Table structure for t_project_type
-- ----------------------------
DROP TABLE IF EXISTS `t_project_type`;
CREATE TABLE `t_project_type` (
  `pro_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`pro_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_project_type
-- ----------------------------

-- ----------------------------
-- Table structure for t_registration
-- ----------------------------
DROP TABLE IF EXISTS `t_registration`;
CREATE TABLE `t_registration` (
  `registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `ranking` varchar(100) NOT NULL,
  `registration_time` datetime NOT NULL,
  `pet_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  PRIMARY KEY (`registration_id`),
  KEY `pet_id` (`pet_id`),
  KEY `worker_id` (`worker_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `t_registration_ibfk_1` FOREIGN KEY (`pet_id`) REFERENCES `t_pet` (`pet_id`),
  CONSTRAINT `t_registration_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `t_hospital_worker` (`worker_id`),
  CONSTRAINT `t_registration_ibfk_3` FOREIGN KEY (`doctor_id`) REFERENCES `t_doctor` (`doctor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_registration
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `pass_word` varchar(20) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_type_id` (`user_type_id`),
  CONSTRAINT `t_user_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `t_user_type` (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------

-- ----------------------------
-- Table structure for t_user_type
-- ----------------------------
DROP TABLE IF EXISTS `t_user_type`;
CREATE TABLE `t_user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_id_name` varchar(100) NOT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_type
-- ----------------------------
