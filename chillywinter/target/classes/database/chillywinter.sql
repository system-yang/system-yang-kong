/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.23-log : Database - chillywinter
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`chillywinter` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `chillywinter`;

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_ip` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `login_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `role_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `opt_content` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`client_ip`,`login_name`,`role_name`,`opt_content`,`create_time`) values (1,'127.0.0.1','admin','admin',NULL,NULL);

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `mid` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) DEFAULT NULL,
  `mname` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `menutype` char(1) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `opend_type` varchar(255) DEFAULT NULL,
  `px` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `parentid` bigint(20) DEFAULT NULL,
  `createdtime` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`mid`,`url`,`mname`,`description`,`icon`,`menutype`,`state`,`opend_type`,`px`,`status`,`parentid`,`createdtime`,`modifytime`) values (1,'#','基础数据','基础数据',NULL,NULL,'closed','ajax','1','0',0,NULL,NULL),(2,'#','运维监控','运维监控',NULL,NULL,'closed','ajax','21','0',0,NULL,NULL),(11,'/user/manage','用户管理','用户管理',NULL,'0','open','ajax','11','0',1,NULL,NULL),(12,'/role/manage','角色管理','角色管理',NULL,'0','open','ajax','12','0',1,NULL,NULL),(13,'/menu/manage','菜单管理','菜单管理',NULL,'0','open','ajax','13','0',1,NULL,NULL),(21,'/operation/log','登录查询','日志查询',NULL,'1','open','ajax','21','0',2,NULL,NULL),(22,'/swagger-ui.html','API查询','API查询',NULL,'1','open','ifream','22','0',2,NULL,NULL),(111,'/user/add','用户添加','用户添加',NULL,'1','open','ajax','111','0',11,NULL,NULL),(112,'/user/del','用户删除','用户删除',NULL,'1','open','ajax','112','0',11,NULL,NULL),(113,'/user/list','用户查询','用户查询',NULL,'1','open','ajax','113','0',11,NULL,NULL),(114,'/user/edit','用户修改','用户修改',NULL,NULL,'open','ajax','114','0',11,NULL,NULL),(121,'/role/add','角色添加','角色添加',NULL,'1','open','ajax','121','0',12,NULL,NULL),(122,'/role/del','角色删除','角色删除',NULL,'1','open','ajax','122','0',12,NULL,NULL),(123,'/role/list','角色查询','角色查询',NULL,'1','open','ajax','123','0',12,NULL,NULL),(124,'/role/edit','角色修改','角色修改',NULL,NULL,'open','ajax','124','0',12,NULL,NULL),(131,'/menu/add','菜单添加','菜单添加',NULL,'1','open','ajax','131','0',13,NULL,NULL),(132,'/menu/del','菜单删除','菜单删除',NULL,'1','open','ajax','132','0',13,NULL,NULL),(133,'/menu/list','菜单查询','菜单查询',NULL,'1','open','ajax','133','0',13,NULL,NULL),(134,'/menu/edit','菜单修改','菜单修改',NULL,NULL,'open','ajax','134','0',13,NULL,NULL);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `rid` bigint(20) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `px` varchar(255) DEFAULT NULL,
  `createdtime` datetime DEFAULT NULL,
  `modifytime` datetime DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

insert  into `sys_role`(`rid`,`rolename`,`description`,`status`,`px`,`createdtime`,`modifytime`) values (1,'admin','超级管理员','0','1',NULL,NULL);

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `rmid` bigint(20) NOT NULL AUTO_INCREMENT,
  `rid` bigint(20) DEFAULT NULL,
  `mid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`rmid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`rmid`,`rid`,`mid`) values (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `organizationid` bigint(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `createdtime` datetime DEFAULT NULL,
  `moddfytime` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`uid`,`nickname`,`username`,`password`,`salt`,`email`,`phone`,`sex`,`organizationid`,`status`,`createdtime`,`moddfytime`) values (1,'admin','admin','a66abb5684c45962d887564f08346e8d','admin','1029853656@qq.com','string','1',0,'0','2019-04-13 08:20:31','2019-04-13 08:20:31'),(2,'string1','string1',NULL,'123','1029853656@qq.com','string','1',0,'0','2019-04-13 08:33:19','2019-04-13 08:33:19'),(3,'string','string13',NULL,NULL,'1029853656@qq.com','string','1',0,'0','2019-04-13 08:34:41','2019-04-13 08:34:41'),(4,'string3','string3',NULL,NULL,'1029853656@qq.com','string','1',0,'0','2019-04-13 08:33:19','2019-04-13 08:33:19'),(5,'string4','string4',NULL,NULL,'1029853656@qq.com','string','1',0,'0','2019-04-13 08:33:19','2019-04-13 08:33:19'),(10,'string','test','c77d3c7a80a0d6cd6a330a691ecc6771','123','1029853656@qq.com','string','1',0,'0','2019-04-13 16:26:45','2019-04-13 16:26:45'),(11,'string','test2','31b8afee384157ea1c51072bff3b244a','string','1029853656@qq.com','string','1',0,'0','2019-04-13 16:30:11','2019-04-13 16:30:11');

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `urid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `rid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`urid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`urid`,`uid`,`rid`) values (1,1,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
