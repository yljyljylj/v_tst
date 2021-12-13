-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- 主机： localhost
-- 生成日期： 2021-12-13 21:29:26
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
(10, 'ces', 'cesss', 1, 1, 1639192199, 1639192199);

-- --------------------------------------------------------

--
-- 表的结构 `vtst_auth_group`
--

CREATE TABLE `vtst_auth_group` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` char(80) DEFAULT '',
  `title` varchar(100) DEFAULT NULL COMMENT '角色描述',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `vtst_auth_group`
--

INSERT INTO `vtst_auth_group` (`id`, `name`, `status`, `rules`, `title`, `create_time`, `update_time`) VALUES
(1, '测试sss', 1, '#', '是是是aaa', NULL, 1639380703),
(5, 'b', 1, '', 'b', NULL, NULL),
(6, 'aacc11', 1, '', 'aa', NULL, 1639389282),
(7, 'aaa', 0, '', 'aaaa', NULL, NULL);

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
  `title` char(20) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL COMMENT '父栏目ID',
  `css` varchar(100) NOT NULL COMMENT 'icon样式',
  `sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `path` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `vtst_auth_rule`
--

INSERT INTO `vtst_auth_rule` (`id`, `title`, `status`, `type`, `condition`, `pid`, `css`, `sort`, `path`) VALUES
(1, '用户管理', 1, 1, '', 0, 'el-icon-setting', 1, NULL),
(2, '用户列表', 1, 2, '', 1, '', 1, NULL),
(3, '权限管理', 1, 1, '', 0, '', 1, NULL),
(4, '角色列表', 1, 1, '', 3, '', 1, 'rules'),
(5, '权限列表', 1, 1, '', 3, '', 1, NULL),
(6, '文章管理', 1, 1, '', 0, '', 1, NULL),
(7, '文章列表', 1, 1, '', 6, '', 1, NULL),
(8, '系统管理', 1, 1, '', 0, '', 1, NULL),
(9, '系统列表', 1, 1, '', 8, '', 1, NULL),
(10, '添加角色', 1, 1, '', 4, '', 1, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `vtst_quanxian`
--

CREATE TABLE `vtst_quanxian` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '权限名称',
  `pid` smallint(6) UNSIGNED NOT NULL COMMENT '父id',
  `controller` varchar(32) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(32) NOT NULL DEFAULT '' COMMENT '操作方法',
  `level` enum('0','2','1') NOT NULL DEFAULT '0' COMMENT '权限等级'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';

--
-- 转存表中的数据 `vtst_quanxian`
--

INSERT INTO `vtst_quanxian` (`id`, `name`, `pid`, `controller`, `action`, `level`) VALUES
(101, '商品管理', 0, '', '', '0'),
(102, '订单管理', 0, '', 'order', '0'),
(103, '权限管理', 0, '', '', '0'),
(104, '商品列表', 101, 'Goods', 'index', '1'),
(105, '添加商品', 104, 'Goods', 'tianjia', '2'),
(107, '订单列表', 102, 'Order', 'index', '1'),
(109, '添加订单', 107, 'Order', 'tianjia', '2'),
(110, '用户列表', 125, 'Manager', 'index', '1'),
(111, '角色列表', 103, 'Role', 'index', '1'),
(112, '权限列表', 103, 'Permission', 'index', '1'),
(115, '分类参数', 101, 'Type', 'index', '1'),
(116, '商品修改', 104, 'Goods', 'upd', '2'),
(117, '商品删除', 104, 'Goods', 'del', '2'),
(121, '商品分类', 101, '', '', '1'),
(122, '添加分类', 121, '', '', '2'),
(123, '删除分类', 121, '', '', '2'),
(125, '用户管理', 0, '', '', '0'),
(129, '添加角色', 111, '', '', '2'),
(130, '删除角色', 111, '', '', '2'),
(131, '添加用户', 110, '', '', '2'),
(132, '删除用户', 110, '', '', '2'),
(133, '更新用户', 110, '', '', '2'),
(134, '角色授权', 111, '', '', '2'),
(135, '取消角色授权', 111, '', '', '2'),
(136, '获取用户详情', 110, '', '', '2'),
(137, '分配用户角色', 110, '', '', '2'),
(138, '获取角色列表', 111, '', '', '2'),
(139, '获取角色详情', 111, '', '', '2'),
(140, '更新角色信息', 111, '', '', '2'),
(141, '更新角色权限', 111, '', '', '2'),
(142, '获取参数列表', 115, '', '', '2'),
(143, '创建商品参数', 115, '', '', '2'),
(144, '删除商品参数', 115, '', '', '2'),
(145, '数据统计', 0, '', '', '0'),
(146, '数据报表', 145, '', '', '1'),
(147, '查看权限', 112, '', '', '2'),
(148, '查看数据', 146, '', '', '2'),
(149, '获取分类详情', 121, '', '', '2'),
(150, '更新商品图片', 104, '', '', '2'),
(151, '更新商品属性', 104, '', '', '2'),
(152, '更新商品状态', 104, '', '', '2'),
(153, '获取商品详情', 104, '', '', '2'),
(154, '订单更新', 107, '', '', '2'),
(155, '获取订单详情', 107, '', '', '2'),
(156, '分类参数添加', 101, '', '', '2'),
(157, '分类参数删除', 101, '', '', '2'),
(158, '分类参数详情', 101, '', '', '2'),
(159, '设置管理状态', 110, '', '', '2');

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
(8, 'test', '$2y$10$MRE.Jf3G2ebAtnVpAPwRQuWM85pHTtAe1j9uRZmtuVFh7TA7OL1ii', 1639277237, NULL, 0, 2),
(3, 'admin', '$2y$10$SHsDU..L9laa2MAxgRN8Fuw5zZyyWqOLuWPSeHHL.Iav5bgA.s8/2', 1639209553, NULL, 1, 1),
(7, 'root', '$2y$10$SKDwQUpn2SVP0pXIUufVTezhvyWV1AfF2iYDPBzmkdjdEYykMqdNW', 1639274124, NULL, 1, 1),
(10, 'aaa', '$2y$10$GmCKJML6HKpI.KBNJS.Z3ur3FGlUJ54..ki0BQZ/pYWD3sLZocfKW', 1639281858, NULL, 1, 1);

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
  ADD PRIMARY KEY (`id`);

--
-- 表的索引 `vtst_quanxian`
--
ALTER TABLE `vtst_quanxian`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- 使用表AUTO_INCREMENT `vtst_auth_rule`
--
ALTER TABLE `vtst_auth_rule`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- 使用表AUTO_INCREMENT `vtst_quanxian`
--
ALTER TABLE `vtst_quanxian`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- 使用表AUTO_INCREMENT `vtst_user`
--
ALTER TABLE `vtst_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
