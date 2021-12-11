-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2021-12-11 10:09:35
-- 服务器版本： 5.7.26
-- PHP 版本： 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `vtst`
--
CREATE DATABASE IF NOT EXISTS `vtst` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `vtst`;

-- --------------------------------------------------------

--
-- 表的结构 `vtst_aritcle`
--

CREATE TABLE `vtst_aritcle` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `status` tinyint(1) DEFAULT '0' COMMENT '状态',
  `sort` int(11) DEFAULT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='文章列表';

--
-- 转存表中的数据 `vtst_aritcle`
--

INSERT INTO `vtst_aritcle` (`id`, `title`, `content`, `status`, `sort`, `create_time`, `update_time`) VALUES
(1, 'aaaa', 'aaaa222111', 1, 1, 1639185247, 1639200383),
(2, 'bbbb', 'bbbbbaaa', 2, 2, 1639185247, 1639185247),
(6, '收拾收拾', '大叔大婶都', 1, 3, 1639190295, 1639195372),
(5, '测试', '测试111', 0, 22, 1639190190, 1639195351),
(7, 'sss', 'sss', 1, 1, 1639191682, 1639191682),
(8, 'aa222', '2222', 1, 1, 1639192053, 1639192053),
(9, '8888', '46789', 1, 1, 1639192121, 1639192121),
(10, 'ces', 'cesss', 1, 1, 1639192199, 1639192199);

-- --------------------------------------------------------

--
-- 表的结构 `vtst_auth_group`
--

CREATE TABLE `vtst_auth_group` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(80) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `vtst_auth_group_access`
--

CREATE TABLE `vtst_auth_group_access` (
  `uid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `vtst_auth_rule`
--

CREATE TABLE `vtst_auth_rule` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `vtst_user`
--

CREATE TABLE `vtst_user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `last_login_time` int(11) DEFAULT NULL,
  `status` int(1) DEFAULT '0' COMMENT '状态',
  `groupid` int(11) DEFAULT '1' COMMENT '用户角色id'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `vtst_user`
--

INSERT INTO `vtst_user` (`id`, `username`, `password`, `create_time`, `last_login_time`, `status`, `groupid`) VALUES
(1, 'aaaa', '123456', 1639185247, 1639185247, 1, 1),
(2, 'www', '123456', 1639202349, 1639202349, 1, 1),
(3, 'admin', '$2y$10$SHsDU..L9laa2MAxgRN8Fuw5zZyyWqOLuWPSeHHL.Iav5bgA.s8/2', 1639209553, NULL, 1, 1),
(4, 'ces', '$2y$10$xAkhqj4kqTSxJvjTBHnJ3eigkn91ij7ttXvA1h.3BZokTOhz.tWx6', 1639209830, NULL, 1, 2);

--
-- 转储表的索引
--

--
-- 表的索引 `vtst_aritcle`
--
ALTER TABLE `vtst_aritcle`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `vtst_auth_group`
--
ALTER TABLE `vtst_auth_group`
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `vtst_auth_group_access`
--
ALTER TABLE `vtst_auth_group_access`
  ADD UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  ADD KEY `uid` (`uid`),
  ADD KEY `group_id` (`group_id`);

--
-- 表的索引 `vtst_auth_rule`
--
ALTER TABLE `vtst_auth_rule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- 表的索引 `vtst_user`
--
ALTER TABLE `vtst_user`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `vtst_aritcle`
--
ALTER TABLE `vtst_aritcle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用表AUTO_INCREMENT `vtst_auth_group`
--
ALTER TABLE `vtst_auth_group`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `vtst_auth_rule`
--
ALTER TABLE `vtst_auth_rule`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- 使用表AUTO_INCREMENT `vtst_user`
--
ALTER TABLE `vtst_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
