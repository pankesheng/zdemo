
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `realname` varchar(100) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `utime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '123456', '1', '系统管理员', '1', '2015-04-01 11:29:37', '2015-04-01 17:26:03');

DROP TABLE IF EXISTS `t_example`;
CREATE TABLE `t_example` (
  `id` bigint(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `imgs` varchar(4000) DEFAULT NULL,
  `theTime` datetime DEFAULT NULL,
  `persons` varchar(4000) DEFAULT NULL,
  `role` int(11) DEFAULT NULL,
  `valid` int(11) DEFAULT NULL,
  `descr` varchar(4000) DEFAULT NULL,
  `content` varchar(4000) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `utime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
