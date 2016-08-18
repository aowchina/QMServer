-- MySQL dump 10.13  Distrib 5.5.50, for debian-linux-gnu (x86_64)
--
-- Host: rds58089c225qyn6i1w0.mysql.rds.aliyuncs.com    Database: qmdb
-- ------------------------------------------------------
-- Server version	5.6.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bak_qm_associations`
--

DROP TABLE IF EXISTS `bak_qm_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_associations` (
  `id` varchar(50) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_associations`
--

LOCK TABLES `bak_qm_associations` WRITE;
/*!40000 ALTER TABLE `bak_qm_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_banner_clients`
--

DROP TABLE IF EXISTS `bak_qm_banner_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_banner_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contact` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `extrainfo` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metakey` text NOT NULL,
  `own_prefix` tinyint(4) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_banner_clients`
--

LOCK TABLES `bak_qm_banner_clients` WRITE;
/*!40000 ALTER TABLE `bak_qm_banner_clients` DISABLE KEYS */;
INSERT INTO `bak_qm_banner_clients` VALUES (1,'Joomla!','Administrator','email@email.com','',1,0,'0000-00-00 00:00:00','',0,'',-1,-1,-1),(2,'Shop','Example','example@example.com','',1,0,'0000-00-00 00:00:00','',0,'',-1,0,0),(3,'Bookstore','Bookstore Example','example@example.com','',1,0,'0000-00-00 00:00:00','',0,'',-1,0,0);
/*!40000 ALTER TABLE `bak_qm_banner_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_banner_tracks`
--

DROP TABLE IF EXISTS `bak_qm_banner_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_banner_tracks`
--

LOCK TABLES `bak_qm_banner_tracks` WRITE;
/*!40000 ALTER TABLE `bak_qm_banner_tracks` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_banner_tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_banners`
--

DROP TABLE IF EXISTS `bak_qm_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `imptotal` int(11) NOT NULL DEFAULT '0',
  `impmade` int(11) NOT NULL DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `clickurl` varchar(200) NOT NULL DEFAULT '',
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `custombannercode` varchar(2048) NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `params` text NOT NULL,
  `own_prefix` tinyint(1) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` char(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_banners`
--

LOCK TABLES `bak_qm_banners` WRITE;
/*!40000 ALTER TABLE `bak_qm_banners` DISABLE KEYS */;
INSERT INTO `bak_qm_banners` VALUES (2,3,0,'Shop 1','shop-1',0,90,2,'http://shop.joomla.org/amazoncom-bookstores.html',1,15,'Get books about Joomla! at the Joomla! Book Shop.','',0,1,'','{\"imageurl\":\"images\\/banners\\/white.png\",\"width\":\"\",\"height\":\"\",\"alt\":\"Joomla! Books\"}',0,'',-1,0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','2011-01-01 00:00:01','en-GB'),(3,2,0,'Shop 2','shop-2',0,140,2,'http://shop.joomla.org',1,15,'T Shirts, caps and more from the Joomla! Shop.','',0,2,'','{\"imageurl\":\"images\\/banners\\/white.png\",\"width\":\"\",\"height\":\"\",\"alt\":\"Joomla! Shop\"}',0,'',-1,0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','2011-01-01 00:00:01','en-GB'),(4,1,0,'Support Joomla!','support-joomla',0,59,1,'http://contribute.joomla.org',1,15,'Your contributions of time, talent and money make Joomla possible.','',0,3,'','{\"imageurl\":\"images\\/banners\\/white.png\",\"width\":\"\",\"height\":\"\",\"alt\":\"\"}',0,'',-1,0,0,0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00','en-GB');
/*!40000 ALTER TABLE `bak_qm_banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_categories`
--

DROP TABLE IF EXISTS `bak_qm_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `extension` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_categories`
--

LOCK TABLES `bak_qm_categories` WRITE;
/*!40000 ALTER TABLE `bak_qm_categories` DISABLE KEYS */;
INSERT INTO `bak_qm_categories` VALUES (1,0,0,0,135,0,'','system','ROOT','root','','',1,0,'0000-00-00 00:00:00',1,'{}','','','',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(9,34,1,131,132,1,'uncategorised','com_content','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'*'),(10,35,1,129,130,1,'uncategorised','com_banners','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\",\"foobar\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(11,36,1,125,126,1,'uncategorised','com_contact','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(12,37,1,61,62,1,'uncategorised','com_newsfeeds','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(13,38,1,57,58,1,'uncategorised','com_weblinks','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(14,39,1,9,56,1,'sample-data-articles','com_content','Sample Data-Articles','sample-data-articles','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(15,40,1,127,128,1,'sample-data-banners','com_banners','Sample Data-Banners','sample-data-banners','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\",\"foobar\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(16,41,1,63,124,1,'sample-data-contact','com_contact','Sample Data-Contact','sample-data-contact','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(17,42,1,59,60,1,'sample-data-newsfeeds','com_newsfeeds','Sample Data-Newsfeeds','sample-data-newsfeeds','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(18,43,1,1,8,1,'sample-data-weblinks','com_weblinks','Sample Data-Weblinks','sample-data-weblinks','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(19,44,14,10,39,2,'sample-data-articles/joomla','com_content','Joomla!','joomla','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'*'),(20,45,19,11,38,3,'sample-data-articles/joomla/extensions','com_content','Extensions','extensions','','<p>The Joomla! content management system lets you create webpages of various types using extensions. There are 5 basic types of extensions: components, modules, templates, languages, and plugins. Your website includes the extensions you need to create a basic website in English, but thousands of additional extensions of all types are available. The <a href=\"http://extensions.joomla.org\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">Joomla! Extensions Directory</a> is the largest directory of Joomla extensions.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 11:57:22',0,'*'),(21,46,20,12,13,4,'sample-data-articles/joomla/extensions/components','com_content','Components','components','','<p><img class=\"image-left\" src=\"administrator/templates/bluestork/images/header/icon-48-component.png\" border=\"0\" alt=\"Component Image\" />Components are larger extensions that produce the major content for your site. Each component has one or more \"views\" that control how content is displayed. In the Joomla administrator there are additional extensions such as Menus, Redirection, and the extension managers.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 11:58:12',0,'*'),(22,47,20,14,25,4,'sample-data-articles/joomla/extensions/modules','com_content','Modules','modules','','<p><img class=\"image-left\" src=\"administrator/templates/bluestork/images/header/icon-48-module.png\" border=\"0\" alt=\"Media Image\" />Modules are small blocks of content that can be displayed in positions on a web page. The menus on this site are displayed in modules. The core of Joomla! includes 24 separate modules ranging from login to search to random images. Each module has a name that starts mod_ but when it displays it has a title. In the descriptions in this section, the titles are the same as the names.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 11:59:44',0,'*'),(23,48,20,26,33,4,'sample-data-articles/joomla/extensions/templates','com_content','Templates','templates','','<p><img src=\"administrator/templates/bluestork/images/header/icon-48-themes.png\" border=\"0\" alt=\"Media Image\" align=\"left\" />Templates give your site its look and feel. They determine layout, colours, typefaces, graphics and other aspects of design that make your site unique. Your installation of Joomla comes prepackaged with three front end templates and two backend templates. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Template_Manager_Templates\">Help</a></p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:04:51',0,'*'),(24,49,20,34,35,4,'sample-data-articles/joomla/extensions/languages','com_content','Languages','languages','','<p><img src=\"administrator/templates/bluestork/images/header/icon-48-language.png\" border=\"0\" alt=\"Languages Image\" align=\"left\" />Joomla! installs in English, but translations of the interfaces, sample data and help screens are available in dozens of languages. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Language_Manager_Installed\">Help</a></p>\r\n<p><a href=\"http://community.joomla.org/translations.html\">Translation information</a></p>\r\n<p>If there is no language pack available for your language, instructions are available for creating your own translation, which you can also contribute to the community by starting a translation team to create an accredited translation. </p>\r\n<p>Translations of the interfaces are installed using the extensions manager in the site administrator and then managed using the language manager.</p>\r\n<p>If you have two or more languages installed you may enable the language switcher plugin and module. They should always be used together. If you create multilingual content and mark your content, menu items or modules as being in specific languages and follow <a href=\"http://docs.joomla.org/Language_Switcher_Tutorial_for_Joomla_1.6\">the complete instructions</a> your users will be able to select a specific content language using the module. By default both the plugin and module are disabled.</p>\r\n<p>Joomla 2.5 installs with a language override manager that allows you to change the specific words (such as Edit or Search) used in the Joomla application.</p>\r\n<p>There are a number of extensions that can help you manage translations of content available in the<a href=\"http://extensions.joomla.org\"> Joomla! Extensions Directory</a>.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2012-01-17 16:18:40',0,'*'),(25,50,20,36,37,4,'sample-data-articles/joomla/extensions/plugins','com_content','Plugins','plugins','','<p><img src=\"administrator/templates/bluestork/images/header/icon-48-plugin.png\" border=\"0\" alt=\"Plugin Image\" align=\"left\" />Plugins are small task oriented extensions that enhance the Joomla! framework. Some are associated with particular extensions and others, such as editors, are used across all of Joomla. Most beginning users do not need to change any of the plugins that install with Joomla. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Plugin_Manager_Edit\">Help</a></p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:11:56',0,'*'),(26,51,14,40,49,2,'sample-data-articles/park-site','com_content','Park Site','park-site','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'en-GB'),(27,52,26,41,42,3,'sample-data-articles/park-site/park-blog','com_content','Park Blog','park-blog','','<p><span style=\"font-size: 12px;\">Here is where I will blog all about the parks of Australia.</span></p>\r\n<p><em>You can make a blog on your website by creating a category to write your blog posts in (this one is called Park Blog). Each blog post will be an article in that category. If you make a category blog menu link with 1 column it will look like this page, if you display the category description then this part is displayed. </em></p>\r\n<p><em>To enhance your blog you may want to add extensions for <a href=\"http://extensions.joomla.org/extensions/contacts-and-feedback/articles-comments\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">comments</a>,<a href=\"http://extensions.joomla.org/extensions/social-web\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\"> interacting with social network sites</a>, <a href=\"http://extensions.joomla.org/extensions/content-sharing\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">tagging</a>, and <a href=\"http://extensions.joomla.org/extensions/content-sharing\" style=\"color: #1b57b1; text-decoration: none; font-weight: normal;\">keeping in contact with your readers</a>. You can also enable the syndication that is included in Joomla (in the Integration Options set Show Feed Link to Show and make sure to display the syndication module on the page).</em></p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"images\\/sampledata\\/parks\\/banner_cradle.jpg\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:15:40',0,'en-GB'),(28,53,26,43,48,3,'sample-data-articles/park-site/photo-gallery','com_content','Photo Gallery','photo-gallery','','<p><img src=\"images/sampledata/parks/banner_cradle.jpg\" border=\"0\" /></p>\r\n<p>These are my photos from parks I have visited (I didn\'t take them, they are all from <a href=\"http://commons.wikimedia.org/wiki/Main_Page\">Wikimedia Commons</a>).</p>\r\n<p><em>This shows you how to make a simple image gallery using articles in com_content. </em></p>\r\n<p><em>In each article put a thumbnail image before a \"readmore\" and the full size image after it. Set the article to Show Intro Text: Hide. </em></p>',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'en-GB'),(29,54,14,50,55,2,'sample-data-articles/fruit-shop-site','com_content','Fruit Shop Site','fruit-shop-site','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'*'),(30,55,29,51,52,3,'sample-data-articles/fruit-shop-site/growers','com_content','Growers','growers','','<p>We search the whole countryside for the best fruit growers.</p>\r\n<p><em>You can let each supplier have a page that he or she can edit. To see this in action you will need to create a user who is in the suppliers group.  </em></p>\r\n<p><em>Create one page in the growers category for that user and make that supplier the author of the page. That user will be able to edit his or her page. </em></p>\r\n<p><em>This illustrates the use of the Edit Own permission. </em></p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:17:40',0,'*'),(31,56,18,2,3,2,'sample-data-weblinks/park-links','com_weblinks','Park Links','park-links','','<p>Here are links to some of my favorite parks.</p>\r\n<p><em>The weblinks component provides an easy way to make links to external sites that are consistently formatted and categorised. You can create weblinks from the front end of your site.</em></p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"images\\/sampledata\\/parks\\/banner_cradle.jpg\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'en-GB'),(32,57,18,4,7,2,'sample-data-weblinks/joomla-specific-links','com_weblinks','Joomla! Specific Links','joomla-specific-links','','<p>A selection of links that are all related to the Joomla Project.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:32:00',0,'*'),(33,58,32,5,6,3,'sample-data-weblinks/joomla-specific-links/other-resources','com_weblinks','Other Resources','other-resources','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(34,59,16,64,65,2,'sample-data-contact/park-site','com_contact','Park Site','park-site','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'en-GB'),(35,60,16,66,123,2,'sample-data-contact/shop-site','com_contact','Shop Site','shop-site','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(36,61,35,67,68,3,'sample-data-contact/shop-site/staff','com_contact','Staff','staff','','<p>Please feel free to contact our staff at any time should you need assistance.</p>',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(37,62,35,69,122,3,'sample-data-contact/shop-site/fruit-encyclopedia','com_contact','Fruit Encyclopedia','fruit-encyclopedia','','<p> </p><p>Our directory of information about different kinds of fruit.</p><p>We love fruit and want the world to know more about all of its many varieties.</p><p>Although it is small now, we work on it whenever we have a chance.</p><p>All of the images can be found in <a href=\"http://commons.wikimedia.org/wiki/Main_Page\">Wikimedia Commons</a>.</p><p><img src=\"images/sampledata/fruitshop/apple.jpg\" border=\"0\" alt=\"Apples\" title=\"Apples\" /></p><p><em>This encyclopedia is implemented using the contact component, each fruit a separate contact and a category for each letter. A CSS style is used to create the horizontal layout of the alphabet headings. </em></p><p><em>If you wanted to, you could allow some users (such as your growers) to have access to just this category in the contact component and let them help you to create new content for the encyclopedia.</em></p><p> </p>',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(38,63,37,70,71,4,'sample-data-contact/shop-site/fruit-encyclopedia/a','com_contact','A','a','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(39,64,37,72,73,4,'sample-data-contact/shop-site/fruit-encyclopedia/b','com_contact','B','b','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(40,65,37,74,75,4,'sample-data-contact/shop-site/fruit-encyclopedia/c','com_contact','C','c','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(41,66,37,76,77,4,'sample-data-contact/shop-site/fruit-encyclopedia/d','com_contact','D','d','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(42,67,37,78,79,4,'sample-data-contact/shop-site/fruit-encyclopedia/e','com_contact','E','e','','',0,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(43,68,37,80,81,4,'sample-data-contact/shop-site/fruit-encyclopedia/f','com_contact','F','f','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(44,69,37,82,83,4,'sample-data-contact/shop-site/fruit-encyclopedia/g','com_contact','G','g','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(45,70,37,84,85,4,'sample-data-contact/shop-site/fruit-encyclopedia/h','com_contact','H','h','','',0,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(46,71,37,86,87,4,'sample-data-contact/shop-site/fruit-encyclopedia/i','com_contact','I','i','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(47,72,37,88,89,4,'sample-data-contact/shop-site/fruit-encyclopedia/j','com_contact','J','j','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(48,73,37,90,91,4,'sample-data-contact/shop-site/fruit-encyclopedia/k','com_contact','K','k','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(49,74,37,92,93,4,'sample-data-contact/shop-site/fruit-encyclopedia/l','com_contact','L','l','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(50,75,37,94,95,4,'sample-data-contact/shop-site/fruit-encyclopedia/m','com_contact','M','m','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(51,76,37,96,97,4,'sample-data-contact/shop-site/fruit-encyclopedia/n','com_contact','N','n','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(52,77,37,98,99,4,'sample-data-contact/shop-site/fruit-encyclopedia/o','com_contact','O','o','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(53,78,37,100,101,4,'sample-data-contact/shop-site/fruit-encyclopedia/p','com_contact','P','p','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(54,79,37,102,103,4,'sample-data-contact/shop-site/fruit-encyclopedia/q','com_contact','Q','q','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(55,80,37,104,105,4,'sample-data-contact/shop-site/fruit-encyclopedia/r','com_contact','R','r','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(56,81,37,106,107,4,'sample-data-contact/shop-site/fruit-encyclopedia/s','com_contact','S','s','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(57,82,37,108,109,4,'sample-data-contact/shop-site/fruit-encyclopedia/t','com_contact','T','t','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(58,83,37,110,111,4,'sample-data-contact/shop-site/fruit-encyclopedia/u','com_contact','U','u','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(59,84,37,112,113,4,'sample-data-contact/shop-site/fruit-encyclopedia/v','com_contact','V','v','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(60,85,37,114,115,4,'sample-data-contact/shop-site/fruit-encyclopedia/w','com_contact','W','w','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(61,86,37,116,117,4,'sample-data-contact/shop-site/fruit-encyclopedia/x','com_contact','X','x','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(62,87,37,118,119,4,'sample-data-contact/shop-site/fruit-encyclopedia/y','com_contact','Y','y','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(63,88,37,120,121,4,'sample-data-contact/shop-site/fruit-encyclopedia/z','com_contact','Z','z','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(64,93,22,15,16,5,'sample-data-articles/joomla/extensions/modules/articles-modules','com_content','Content Modules','articles-modules','','<p>Content modules display article and other information from the content component.</p>',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'*'),(65,94,22,17,18,5,'sample-data-articles/joomla/extensions/modules/user-modules','com_content','User Modules','user-modules','','<p>User modules interact with the user system, allowing users to login, show who is logged-in, and showing the most recently registered users.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:00:50',0,'*'),(66,95,22,19,20,5,'sample-data-articles/joomla/extensions/modules/display-modules','com_content','Display Modules','display-modules','','<p>These modules display information from components other than content and user. These include weblinks, news feeds and the media manager.</p>',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*'),(67,96,22,21,22,5,'sample-data-articles/joomla/extensions/modules/utility-modules','com_content','Utility Modules','utility-modules','','<p>Utility modules provide useful functionality such as search, syndication and statistics.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:01:34',0,'*'),(68,97,23,31,32,5,'sample-data-articles/joomla/extensions/templates/atomic','com_content','Atomic','atomic','','<p><img src=\"templates/atomic/template_thumbnail.png\" border=\"0\" alt=\"The Atomic Template\" style=\"border: 0; float: right;\" /></p>\r\n<p>Atomic is a minimal template designed to be a skeleton for making your own template and to learn about Joomla! templating.</p>\r\n<ul>\r\n<li><a href=\"index.php?Itemid=285\">Home Page</a></li>\r\n<li><a href=\"index.php?Itemid=316\">Typography</a></li>\r\n</ul>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:08:16',0,'*'),(69,98,23,27,28,5,'sample-data-articles/joomla/extensions/templates/beez-20','com_content','Beez 20','beez-20','','<p><img src=\"templates/beez_20/template_thumbnail.png\" border=\"0\" alt=\"Beez_20 thumbnail\" align=\"right\" style=\"float: right;\" /></p>\r\n<p>Beez 2.0 is a versatile, easy to customise template that works for a variety of sites. It meets major accessibility standards and demonstrates a range of css and javascript techniques. It is the default template that installs with Joomla!</p>\r\n<ul>\r\n<li><a href=\"index.php?Itemid=424\">Home Page</a></li>\r\n<li><a href=\"index.php?Itemid=423\">Typography</a></li>\r\n</ul>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'*'),(70,99,23,29,30,5,'sample-data-articles/joomla/extensions/templates/beez-5','com_content','Beez 5','beez-5','','<p><img src=\"templates/beez5/template_thumbnail.png\" border=\"0\" alt=\"Beez5 Thumbnail\" align=\"right\" style=\"float: right;\" /></p>\r\n<p>Beez 5 is an html5 implementation of a Joomla! template. It uses a number of html5 techniques to enhance the presentation of a site. It is used as the template for the Fruit Shop sample site.</p>\r\n<ul>\r\n<li><a href=\"index.php?Itemid=458\">Home Page</a></li>\r\n<li><a href=\"index.php?Itemid=457\">Typography</a></li>\r\n</ul>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:06:57',0,'*'),(72,108,28,44,45,4,'sample-data-articles/park-site/photo-gallery/animals','com_content','Animals','animals','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'en-GB'),(73,109,28,46,47,4,'sample-data-articles/park-site/photo-gallery/scenery','com_content','Scenery','scenery','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'en-GB'),(75,166,22,23,24,5,'sample-data-articles/joomla/extensions/modules/navigation-modules','com_content','Navigation Modules','navigation-modules','','<p>Navigation modules help your visitors move through your site and find what they need.</p>\r\n<p>Menus provide your site with structure and help your visitors navigate your site.  Although they are all based on the same menu module, the variety of ways menus are used in the sample data show how flexible this module is.</p>\r\n<p>A menu can range from extremely simple (for example the top menu or the menu for the Australian Parks sample site) to extremely complex (for example the About Joomla! menu with its many levels). They can also be used for other types of presentation such as the site map linked from the \"This Site\" menu.</p>\r\n<p>Breadcrumbs provide users with information about where they are in a site.</p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-01-01 00:00:01',0,'*'),(76,167,29,53,54,3,'sample-data-articles/fruit-shop-site/recipes','com_content','Recipes','recipes','','<p>Customers and suppliers can post their favorite recipes for fruit here.</p>\r\n<p>A good idea is to promote the use of metadata keywords to make finding other recipes for the same fruit easier.</p>\r\n<p><em>To see this in action, create a user assigned to the customer group and a user assigned to the suppliers group. These users will be able to create their own recipe pages and edit those pages. They will not be able to edit other users\' pages.</em><br /><br /></p>',1,0,'0000-00-00 00:00:00',1,'{\"category_layout\":\"\",\"image\":\"\"}','','','{\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',42,'2011-12-27 12:18:25',0,'*'),(77,169,1,133,134,1,'uncategorised','com_users','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',627,'2011-01-01 00:00:01',0,'2011-01-01 00:00:01',0,'*');
/*!40000 ALTER TABLE `bak_qm_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_contact_details`
--

DROP TABLE IF EXISTS `bak_qm_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_contact_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `con_position` varchar(255) DEFAULT NULL,
  `address` text,
  `suburb` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `misc` mediumtext,
  `image` varchar(255) DEFAULT NULL,
  `imagepos` varchar(20) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `default_con` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `webpage` varchar(255) NOT NULL DEFAULT '',
  `sortname1` varchar(255) NOT NULL,
  `sortname2` varchar(255) NOT NULL,
  `sortname3` varchar(255) NOT NULL,
  `language` char(7) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_contact_details`
--

LOCK TABLES `bak_qm_contact_details` WRITE;
/*!40000 ALTER TABLE `bak_qm_contact_details` DISABLE KEYS */;
INSERT INTO `bak_qm_contact_details` VALUES (1,'Contact Name Here','name','Position','Street Address','Suburb','State','Country','Zip Code','Telephone','Fax','<p>Information about or by the contact.</p>','images/powered_by.png','top','email@example.com',1,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Twitter\",\"linka\":\"http:\\/\\/twitter.com\\/joomla\",\"linkb_name\":\"YouTube\",\"linkb\":\"http:\\/\\/www.youtube.com\\/user\\/joomla\",\"linkc_name\":\"Facebook\",\"linkc\":\"http:\\/\\/www.facebook.com\\/joomla\",\"linkd_name\":\"FriendFeed\",\"linkd\":\"http:\\/\\/friendfeed.com\\/joomla\",\"linke_name\":\"Scribed\",\"linke\":\"http:\\/\\/www.scribd.com\\/people\\/view\\/504592-joomla\",\"contact_layout\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,16,1,'','','last','first','middle','en-GB','2011-01-01 00:00:01',627,'','2011-12-27 12:23:32',42,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'Webmaster','webmaster','','','','','','','','','','',NULL,'webmaster@example.com',0,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"1\",\"show_email_copy\":\"1\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,34,1,'','','','','','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'Owner','owner','','','','','','','','','<p>I\'m the owner of this store.</p>','',NULL,'',0,1,0,'0000-00-00 00:00:00',2,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,36,1,'','','','','','*','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Buyer','buyer','','','','','','','','','<p>I am in charge of buying fruit. If you sell good fruit, contact me.</p>','',NULL,'',0,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"0\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,36,1,'','','','','','*','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Bananas','bananas','Scientific Name: Musa','Image Credit: Enzik\r\nRights: Creative Commons Share Alike Unported 3.0\r\nSource: http://commons.wikimedia.org/wiki/File:Bananas_-_Morocco.jpg','','Type: Herbaceous','Large Producers: India, China, Brasil','','','','<p>Bananas are a great source of potassium.</p>\r\n<p> </p>','images/sampledata/fruitshop/bananas_2.jpg',NULL,'',0,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"show_with_link\",\"show_contact_list\":\"\",\"presentation_style\":\"plain\",\"show_name\":\"\",\"show_position\":\"1\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"1\",\"show_postcode\":\"\",\"show_country\":\"1\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Wikipedia: Banana English\",\"linka\":\"http:\\/\\/en.wikipedia.org\\/wiki\\/Banana\",\"linkb_name\":\"Wikipedia:  \\u0939\\u093f\\u0928\\u094d\\u0926\\u0940 \\u0915\\u0947\\u0932\\u093e\",\"linkb\":\"http:\\/\\/hi.wikipedia.org\\/wiki\\/%E0%A4%95%E0%A5%87%E0%A4%B2%E0%A4%BE\",\"linkc_name\":\"Wikipedia:Banana Portugu\\u00eas\",\"linkc\":\"http:\\/\\/pt.wikipedia.org\\/wiki\\/Banana\",\"linkd_name\":\"Wikipedia: \\u0411\\u0430\\u043d\\u0430\\u043d  \\u0420\\u0443\\u0441\\u0441\\u043a\\u0438\\u0439\",\"linkd\":\"http:\\/\\/ru.wikipedia.org\\/\\u0411\\u0430\\u043d\\u0430\\u043d\",\"linke_name\":\"\",\"linke\":\"\",\"contact_layout\":\"beez5:encyclopedia\"}',0,39,1,'','','','','','*','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Apples','apples','Scientific Name: Malus domestica','Image Credit: Fievet\r\nRights: Public Domain\r\nSource: http://commons.wikimedia.org/wiki/File:Pommes_vertes.JPG','','Family: Rosaceae','Large: Producers: China, United States','','','','<p>Apples are a versatile fruit, used for eating, cooking, and preserving.</p>\r\n<p>There are more that 7500 different kinds of apples grown around the world.</p>','images/sampledata/fruitshop/apple.jpg',NULL,'',0,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"plain\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Wikipedia: Apples English\",\"linka\":\"http:\\/\\/en.wikipedia.org\\/wiki\\/Apple\",\"linkb_name\":\"Wikipedia: Manzana Espa\\u00f1ol \",\"linkb\":\"http:\\/\\/es.wikipedia.org\\/wiki\\/Manzana\",\"linkc_name\":\"Wikipedia: \\u82f9\\u679c \\u4e2d\\u6587\",\"linkc\":\"http:\\/\\/zh.wikipedia.org\\/zh\\/\\u82f9\\u679c\",\"linkd_name\":\"Wikipedia: Tofaa Kiswahili\",\"linkd\":\"http:\\/\\/sw.wikipedia.org\\/wiki\\/Tofaa\",\"linke_name\":\"\",\"linke\":\"\",\"contact_layout\":\"beez5:encyclopedia\"}',0,38,1,'','','','','','*','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,'Tamarind','tamarind','Scientific Name: Tamarindus indica','Image Credit: Franz Eugen Köhler, Köhler\'s Medizinal-Pflanzen \r\nRights: Public Domain\r\nSource:http://commons.wikimedia.org/wiki/File:Koeh-134.jpg','','Family: Fabaceae','Large Producers: India, United States','','','','<p>Tamarinds are a versatile fruit used around the world. In its young form it is used in hot sauces; ripened it is the basis for many refreshing drinks.</p>\r\n<p> </p>','images/sampledata/fruitshop/tamarind.jpg',NULL,'',0,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"plain\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"1\",\"linka_name\":\"Wikipedia: Tamarind English\",\"linka\":\"http:\\/\\/en.wikipedia.org\\/wiki\\/Tamarind\",\"linkb_name\":\"Wikipedia: \\u09a4\\u09c7\\u0981\\u09a4\\u09c1\\u09b2  \\u09ac\\u09be\\u0982\\u09b2\\u09be  \",\"linkb\":\"http:\\/\\/bn.wikipedia.org\\/wiki\\/\\u09a4\\u09c7\\u0981\\u09a4\\u09c1\\u09b2 \",\"linkc_name\":\"Wikipedia: Tamarinier Fran\\u00e7ais\",\"linkc\":\"http:\\/\\/fr.wikipedia.org\\/wiki\\/Tamarinier\",\"linkd_name\":\"Wikipedia:Tamaline lea faka-Tonga\",\"linkd\":\"http:\\/\\/to.wikipedia.org\\/wiki\\/Tamaline\",\"linke_name\":\"\",\"linke\":\"\",\"contact_layout\":\"beez5:encyclopedia\"}',0,57,1,'','','','','','*','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,'Shop Address','shop-address','','','Our City','Our Province','Our Country','','555-555-5555','','<p>Here are directions for how to get to our shop.</p>','',NULL,'',0,1,0,'0000-00-00 00:00:00',1,'{\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_profile\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linka\":\"\",\"linkb_name\":\"\",\"linkb\":\"\",\"linkc_name\":\"\",\"linkc\":\"\",\"linkd_name\":\"\",\"linkd\":\"\",\"linke_name\":\"\",\"linke\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\"}',0,35,1,'','','','','','*','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"rights\":\"\"}',1,'','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `bak_qm_contact_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_content`
--

DROP TABLE IF EXISTS `bak_qm_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `title_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Deprecated in Joomla! 3.0',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `sectionid` int(10) unsigned NOT NULL DEFAULT '0',
  `mask` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `parentid` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_content`
--

LOCK TABLES `bak_qm_content` WRITE;
/*!40000 ALTER TABLE `bak_qm_content` DISABLE KEYS */;
INSERT INTO `bak_qm_content` VALUES (1,89,'Administrator Components','administrator-components','','<p>All components are also used in the administrator area of your website. In addition to the ones listed here, there are components in the administrator that do not have direct front end displays, but do help shape your site. The most important ones for most users are</p>\r\n<ul>\r\n<li>Media Manager</li>\r\n<li>Extensions Manager</li>\r\n<li>Menu Manager</li>\r\n<li>Global Configuration</li>\r\n<li>Banners</li>\r\n<li>Redirect</li>\r\n</ul>\r\n<hr title=\"Media Manager\" alt=\"Media Manager\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" />\r\n<p> </p>\r\n<h3>Media Manager</h3>\r\n<p>The media manager component lets you upload and insert images into content throughout your site. Optionally, you can enable the flash uploader which will allow you to to upload multiple images. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Content_Media_Manager\">Help</a></p>\r\n<hr title=\"Extensions Manager\" alt=\"Extensions Manager\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" />\r\n<h3>Extensions Manager</h3>\r\n<p>The extensions manager lets you install, update, uninstall and manage all of your extensions. The extensions manager has been extensively redesigned, although the core install and uninstall functionality remains the same as in Joomla! 1.5. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Extension_Manager_Install\">Help</a></p>\r\n<hr title=\"Menu Manager\" alt=\"Menu Manager\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" />\r\n<h3>Menu Manager</h3>\r\n<p>The menu manager lets you create the menus you see displayed on your site. It also allows you to assign modules and template styles to specific menu links. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Menus_Menu_Manager\">Help</a></p>\r\n<hr title=\"Global Configuration\" alt=\"Global Configuration\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" />\r\n<h3>Global Configuration</h3>\r\n<p>The global configuration is where the site administrator configures things such as whether search engine friendly urls are enabled, the site meta data (descriptive text used by search engines and indexers) and other functions. For many beginning users simply leaving the settings on default is a good way to begin, although when your site is ready for the public you will want to change the meta data to match its content. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Site_Global_Configuration\">Help</a></p>\r\n<hr title=\"Banners\" alt=\"Banners\" class=\"system-pagebreak\" style=\"color: gray; border: 1px dashed gray;\" />\r\n<h3>Banners</h3>\r\n<p>The banners component provides a simple way to display a rotating image in a module and, if you wish to have advertising, a way to track the number of times an image is viewed and clicked. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Components_Banners_Banners_Edit\">Help</a></p>\r\n<hr title=\"Redirect\" class=\"system-pagebreak\" />\r\n<h3><br />Redirect</h3>\r\n<p>The redirect component is used to manage broken links that produce Page Not Found (404) errors. If enabled it will allow you to redirect broken links to specific pages. It can also be used to manage migration related URL changes. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Components_Redirect_Manager\">Help</a></p>','',1,0,0,21,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:03:19',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',9,0,7,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(2,90,'Archive Module','archive-module','','<p>This module shows a list of the calendar months containing archived articles. After you have changed the status of an article to archived, this list will be automatically generated. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Articles_Archive\" title=\"Archive Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule articles_archive,Archived Articles}</div>','',1,0,0,64,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:18:05',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',5,0,5,'modules, content','',1,5,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(3,91,'Article Categories Module','article-categories-module','','<p>This module displays a list of categories from one parent category. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Articles_Categories\" title=\"Categories Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule articles_categories,Articles Categories}</div>\r\n<p> </p>','',1,0,0,64,'2011-01-01 00:00:01',627,'','2011-09-17 22:13:31',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',5,0,6,'modules, content','',1,6,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(4,92,'Articles Category Module','articles-category-module','','<p>This module allows you to display the articles in a specific category. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Articles_Category\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule articles_category,Articles Category}</div>','',1,0,0,64,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:18:26',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',8,0,7,'','articles,content',1,10,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(5,101,'Authentication','authentication','','<p>The authentication plugins operate when users login to your site or administrator. The Joomla! authentication plugin is in operation by default but you can enable Gmail or LDAP or install a plugin for a different system. An example is included that may be used to create a new authentication plugin.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>Joomla <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Authentication_-_GMail\">Help</a></li>\r\n</ul>\r\n<p>Default off:</p>\r\n<ul>\r\n<li>Gmail <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Authentication_-_GMail\">Help</a></li>\r\n<li>LDAP <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Authentication_-_LDAP\">Help</a></li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:04:13',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,3,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(6,102,'Australian Parks ','australian-parks','','<p><img src=\"images/sampledata/parks/banner_cradle.jpg\" border=\"0\" alt=\"Cradle Park Banner\" /></p>\r\n<p>Welcome!</p>\r\n<p>This is a basic site about the beautiful and fascinating parks of Australia.</p>\r\n<p>On this site you can read all about my travels to different parks, see photos, and find links to park websites.</p>\r\n<p><em>This sample site is an example of using the core of Joomla! to create a basic website, whether a \"brochure site,\"  a personal blog, or as a way to present information on a topic you are interested in.</em></p>\r\n<p><em> Read more about the site in the About Parks module.</em></p>\r\n<p> </p>','',1,0,0,26,'2011-01-01 00:00:01',627,'Parks Webmaster','2011-09-06 06:20:19',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',2,0,1,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(7,103,'Banner Module','banner-module','','<p>The banner module is used to display the banners that are managed by the banners component in the site administrator. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Banners\">Help</a>.</p>\r\n<div class=\"sample-module\">{loadmodule banners,Banners}</div>','',1,0,0,66,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:32:58',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,6,'','',1,4,'',0,'*',''),(8,104,'Beginners','beginners','','<p>If this is your first Joomla! site or your first web site, you have come to the right place. Joomla will help you get your website up and running quickly and easily.</p>\r\n<p>Start off using your site by logging in using the administrator account you created when you installed Joomla.</p>\r\n','\r\n<p>Explore the articles and other resources right here on your site data to learn more about how Joomla works. (When you\'re done reading, you can delete or archive all of this.) You will also probably want to visit the Beginners\' Areas of the <a href=\"http://docs.joomla.org/Beginners\">Joomla documentation</a> and <a href=\"http://forum.joomla.org\">support forums</a>.</p>\r\n<p>You\'ll also want to sign up for the Joomla Security Mailing list and the Announcements mailing list. For inspiration visit the <a href=\"http://community.joomla.org/showcase/\">Joomla! Site Showcase</a> to see an amazing array of ways people use Joomla to tell their stories on the web.</p>\r\n<p>The basic Joomla installation will let you get a great site up and running, but when you are ready for more features the power of Joomla is in the creative ways that developers have extended it to do all kinds of things. Visit the <a href=\"http://extensions.joomla.org/\">Joomla! Extensions Directory</a> to see thousands of extensions that can do almost anything you could want on a website. Can\'t find what you need? You may want to find a Joomla professional in the <a href=\"http://resources.joomla.org/\">Joomla! Resource Directory</a>.</p>\r\n<p>Want to learn more? Consider attending a <a href=\"http://community.joomla.org/events.html\">Joomla! Day</a> or other event or joining a local <a href=\"http://community.joomla.org/user-groups.html\">Joomla! Users Group</a>. Can\'t find one near you? Start one yourself.</p>',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:10:49',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,4,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),(9,105,'Contacts','contact','','<p>The contact component provides a way to provide contact forms and information for your site or to create a complex directory that can be used for many different purposes. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Components_Contacts_Contacts\">Help</a></p>','',1,0,0,21,'2011-01-01 00:00:01',627,'Joomla!','2011-01-10 04:15:37',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',2,0,2,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(10,106,'Content','content','','<p>The content component (com_content) is what you use to write articles. It is extremely flexible and has the largest number of built in views. Articles can be created and edited from the front end, making content the easiest component to use to create your site content. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Content_Article_Manager\">Help</a></p>','',1,0,0,21,'2011-01-01 00:00:01',627,'','2011-01-10 04:28:12',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',2,0,1,'','',1,5,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(11,107,'Cradle Mountain','cradle-mountain','','<p> </p>\r\n','\r\n<p> </p>',1,0,0,73,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 04:42:36',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/250px_cradle_mountain_seen_from_barn_bluff.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Cradle Mountain\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/800px_cradle_mountain_seen_from_barn_bluff.jpg\",\"float_fulltext\":\"none\",\"image_fulltext_alt\":\"Cradle Mountain\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Rainforest,bluemountainsNSW.jpg Author: Alan J.W.C. License: GNU Free Documentation License v . 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,1,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(12,110,'Custom HTML Module','custom-html-module','','<p>This module allows you to create your own HTML Module using a WYSIWYG editor. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Custom_HTML\" title=\"Custom HTML Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule custom,Custom HTML}</div>','',1,0,0,66,'2011-01-01 00:00:01',627,'','2011-12-27 11:12:46',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',13,0,1,'','',1,13,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(13,111,'Directions','directions','','<p>Here\'s how to find our shop.</p><p>By car</p><p>Drive along Main Street to the intersection with First Avenue.  Look for our sign.</p><p>By foot</p><p>From the center of town, walk north on Main Street until you see our sign.</p><p>By bus</p><p>Take the #73 Bus to the last stop. We are on the north east corner.</p>','',1,0,0,29,'2011-01-01 00:00:01',627,'Fruit Shop Webmaster','2011-01-01 00:00:01',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,2,'','',1,0,'',0,'*',''),(14,112,'Editors','editors','','<p>Editors are used thoughout Joomla! where content is created. TinyMCE is the default choice in most locations although CodeMirror is used in the template manager. No Editor provides a text box for html content.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>CodeMirror <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Editor_-_CodeMirror\">Help</a></li>\r\n<li>TinyMCE<a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Editor_-_TinyMCE\"> Help</a></li>\r\n<li>No Editor <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Editor_-_None\">Help</a></li>\r\n</ul>\r\n<p>Default off:</p>\r\n<ul>\r\n<li>None</li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-09-06 05:45:40',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',2,0,5,'','',1,0,'',0,'*',''),(15,113,'Editors-xtd','editors-xtd','','<p>These plugins are the buttons found beneath your editor. They only run when an editor plugin runs.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>Editor Button: Image<a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Button_-_Image\"> Help</a></li>\r\n<li>Editor Button: Readmore <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Button_-_Readmore\">Help</a></li>\r\n<li>Editor Button: Page Break <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Button_-_Pagebreak\">Help</a></li>\r\n<li>Editor Button: Article <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Button_-_Article\">Help</a></li>\r\n</ul>\r\n<p>Default off:</p>\r\n<ul>\r\n<li>None</li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:14:12',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,6,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(16,114,'Feed Display','feed-display','','<p>This module allows the displaying of a syndicated feed. <a href=\"http://docs.joomla.org/Help15:Screen.modulessite.edit.15#Feed_Display\" title=\"Feed Display Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule feed,Feed Display}</div>','',1,0,0,66,'2011-01-01 00:00:01',627,'','2011-09-17 22:22:08',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',3,0,2,'','',1,3,'',0,'*',''),(17,115,'First Blog Post','first-blog-post','','<p><em>Lorem Ipsum is filler text that is commonly used by designers before the content for a new site is ready.</em></p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus purus vitae diam posuere nec eleifend elit dictum. Aenean sit amet erat purus, id fermentum lorem. Integer elementum tristique lectus, non posuere quam pretium sed. Quisque scelerisque erat at urna condimentum euismod. Fusce vestibulum facilisis est, a accumsan massa aliquam in. In auctor interdum mauris a luctus. Morbi euismod tempor dapibus. Duis dapibus posuere quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. In eu est nec erat sollicitudin hendrerit. Pellentesque sed turpis nunc, sit amet laoreet velit. Praesent vulputate semper nulla nec varius. Aenean aliquam, justo at blandit sodales, mauris leo viverra orci, sed sodales mauris orci vitae magna.</p>','<p>Quisque a massa sed libero tristique suscipit. Morbi tristique molestie metus, vel vehicula nisl ultrices pretium. Sed sit amet est et sapien condimentum viverra. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus viverra tortor porta orci convallis ac cursus erat sagittis. Vivamus aliquam, purus non luctus adipiscing, orci urna imperdiet eros, sed tincidunt neque sapien et leo. Cras fermentum, dolor id tempor vestibulum, neque lectus luctus mauris, nec congue tellus arcu nec augue. Nulla quis mi arcu, in bibendum quam. Sed placerat laoreet fermentum. In varius lobortis consequat. Proin vulputate felis ac arcu lacinia adipiscing. Morbi molestie, massa id sagittis luctus, sem sapien sollicitudin quam, in vehicula quam lectus quis augue. Integer orci lectus, bibendum in fringilla sit amet, rutrum eget enim. Curabitur at libero vitae lectus gravida luctus. Nam mattis, ligula sit amet vestibulum feugiat, eros sem sodales mi, nec dignissim ante elit quis nisi. Nulla nec magna ut leo convallis sagittis ac non erat. Etiam in augue nulla, sed tristique orci. Vestibulum quis eleifend sapien.</p><p>Nam ut orci vel felis feugiat posuere ut eu lorem. In risus tellus, sodales eu eleifend sed, imperdiet id nulla. Nunc at enim lacus. Etiam dignissim, arcu quis accumsan varius, dui dui faucibus erat, in molestie mauris diam ac lacus. Sed sit amet egestas nunc. Nam sollicitudin lacinia sapien, non gravida eros convallis vitae. Integer vehicula dui a elit placerat venenatis. Nullam tincidunt ligula aliquet dui interdum feugiat. Maecenas ultricies, lacus quis facilisis vehicula, lectus diam consequat nunc, euismod eleifend metus felis eu mauris. Aliquam dapibus, ipsum a dapibus commodo, dolor arcu accumsan neque, et tempor metus arcu ut massa. Curabitur non risus vitae nisl ornare pellentesque. Pellentesque nec ipsum eu dolor sodales aliquet. Vestibulum egestas scelerisque tincidunt. Integer adipiscing ultrices erat vel rhoncus.</p><p>Integer ac lectus ligula. Nam ornare nisl id magna tincidunt ultrices. Phasellus est nisi, condimentum at sollicitudin vel, consequat eu ipsum. In venenatis ipsum in ligula tincidunt bibendum id et leo. Vivamus quis purus massa. Ut enim magna, pharetra ut condimentum malesuada, auctor ut ligula. Proin mollis, urna a aliquam rutrum, risus erat cursus odio, a convallis enim lectus ut lorem. Nullam semper egestas quam non mattis. Vestibulum venenatis aliquet arcu, consectetur pretium erat pulvinar vel. Vestibulum in aliquet arcu. Ut dolor sem, pellentesque sit amet vestibulum nec, tristique in orci. Sed lacinia metus vel purus pretium sit amet commodo neque condimentum.</p><p>Aenean laoreet aliquet ullamcorper. Nunc tincidunt luctus tellus, eu lobortis sapien tincidunt sed. Donec luctus accumsan sem, at porttitor arcu vestibulum in. Sed suscipit malesuada arcu, ac porttitor orci volutpat in. Vestibulum consectetur vulputate eros ut porttitor. Aenean dictum urna quis erat rutrum nec malesuada tellus elementum. Quisque faucibus, turpis nec consectetur vulputate, mi enim semper mi, nec porttitor libero magna ut lacus. Quisque sodales, leo ut fermentum ullamcorper, tellus augue gravida magna, eget ultricies felis dolor vitae justo. Vestibulum blandit placerat neque, imperdiet ornare ipsum malesuada sed. Quisque bibendum quam porta diam molestie luctus. Sed metus lectus, ornare eu vulputate vel, eleifend facilisis augue. Maecenas eget urna velit, ac volutpat velit. Nam id bibendum ligula. Donec pellentesque, velit eu convallis sodales, nisi dui egestas nunc, et scelerisque lectus quam ut ipsum.</p>',1,0,0,27,'2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,2,'','',1,0,'',0,'*',''),(18,116,'Second Blog Post','second-blog-post','','<p><em>Lorem Ipsum is text that is traditionally used by designers when working on a site before the content is ready.</em></p><p>Pellentesque bibendum metus ut dolor fermentum ut pulvinar tortor hendrerit. Nam vel odio vel diam tempus iaculis in non urna. Curabitur scelerisque, nunc id interdum vestibulum, felis elit luctus dui, ac dapibus tellus mauris tempus augue. Duis congue facilisis lobortis. Phasellus neque erat, tincidunt non lacinia sit amet, rutrum vitae nunc. Sed placerat lacinia fermentum. Integer justo sem, cursus id tristique eget, accumsan vel sapien. Curabitur ipsum neque, elementum vel vestibulum ut, lobortis a nisl. Fusce malesuada mollis purus consectetur auctor. Morbi tellus nunc, dapibus sit amet rutrum vel, laoreet quis mauris. Aenean nec sem nec purus bibendum venenatis. Mauris auctor commodo libero, in adipiscing dui adipiscing eu. Praesent eget orci ac nunc sodales varius.</p>','<p>Nam eget venenatis lorem. Vestibulum a interdum sapien. Suspendisse potenti. Quisque auctor purus nec sapien venenatis vehicula malesuada velit vehicula. Fusce vel diam dolor, quis facilisis tortor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque libero nisi, pellentesque quis cursus sit amet, vehicula vitae nisl. Curabitur nec nunc ac sem tincidunt auctor. Phasellus in mattis magna. Donec consequat orci eget tortor ultricies rutrum. Mauris luctus vulputate molestie. Proin tincidunt vehicula euismod. Nam congue leo non erat cursus a adipiscing ipsum congue. Nulla iaculis purus sit amet turpis aliquam sit amet dapibus odio tincidunt. Ut augue diam, congue ut commodo pellentesque, fermentum mattis leo. Sed iaculis urna id enim dignissim sodales at a ipsum. Quisque varius lobortis mollis. Nunc purus magna, pellentesque pellentesque convallis sed, varius id ipsum. Etiam commodo mi mollis erat scelerisque fringilla. Nullam bibendum massa sagittis diam ornare rutrum.</p><p>Praesent convallis metus ut elit faucibus tempus in quis dui. Donec fringilla imperdiet nibh, sit amet fringilla velit congue et. Quisque commodo luctus ligula, vitae porttitor eros venenatis in. Praesent aliquet commodo orci id varius. Nulla nulla nibh, varius id volutpat nec, sagittis nec eros. Cras et dui justo. Curabitur malesuada facilisis neque, sed tempus massa tincidunt ut. Sed suscipit odio in lacus auctor vehicula non ut lacus. In hac habitasse platea dictumst. Sed nulla nisi, lacinia in viverra at, blandit vel tellus. Nulla metus erat, ultrices non pretium vel, varius nec sem. Morbi sollicitudin mattis lacus quis pharetra. Donec tincidunt mollis pretium. Proin non libero justo, vitae mattis diam. Integer vel elit in enim varius posuere sed vitae magna. Duis blandit tempor elementum. Vestibulum molestie dui nisi.</p><p>Curabitur volutpat interdum lorem sed tempus. Sed placerat quam non ligula lacinia sodales. Cras ultrices justo at nisi luctus hendrerit. Quisque sit amet placerat justo. In id sapien eu neque varius pharetra sed in sapien. Etiam nisl nunc, suscipit sed gravida sed, scelerisque ut nisl. Mauris quis massa nisl, aliquet posuere ligula. Etiam eget tortor mauris. Sed pellentesque vestibulum commodo. Mauris vitae est a libero dapibus dictum fringilla vitae magna.</p><p>Nulla facilisi. Praesent eget elit et mauris gravida lobortis ac nec risus. Ut vulputate ullamcorper est, volutpat feugiat lacus convallis non. Maecenas quis sem odio, et aliquam libero. Integer vel tortor eget orci tincidunt pulvinar interdum at erat. Integer ullamcorper consequat eros a pellentesque. Cras sagittis interdum enim in malesuada. Etiam non nunc neque. Fusce non ligula at tellus porta venenatis. Praesent tortor orci, fermentum sed tincidunt vel, varius vel dui. Duis pulvinar luctus odio, eget porta justo vulputate ac. Nulla varius feugiat lorem sed tempor. Phasellus pulvinar dapibus magna eget egestas. In malesuada lectus at justo pellentesque vitae rhoncus nulla ultrices. Proin ut sem sem. Donec eu suscipit ipsum. Cras eu arcu porttitor massa feugiat aliquet at quis nisl.</p>',1,0,0,27,'2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',0,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,1,'','',1,0,'',0,'*',''),(19,117,'Footer Module','footer-module','','<p>This module shows the Joomla! copyright information. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Footer\" title=\"Footer Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule footer,Footer}</div>','',1,0,0,66,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:22:47',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,3,'','',1,4,'',0,'*',''),(20,118,'Fruit Shop','fruit-shop','','<h2>Welcome to the Fruit Shop</h2>\r\n<p>We sell fruits from around the world. Please use our website to learn more about our business. We hope you will come to our shop and buy some fruit.</p>\r\n<p><em>This mini site will show you how you might want to set up a site for a business, in this example one selling fruit. It shows how to use access controls to manage your site content. If you were building a real site, you might want to extend it with e-commerce, a catalog, mailing lists or other enhancements, many of which are available through the</em><a href=\"http://extensions.joomla.org\"><em> Joomla! Extensions Directory</em></a>.</p>\r\n<p><em>To understand this site you will probably want to make one user with group set to customer and one with group set to grower. By logging in with different privileges you can see how access control works.</em></p>','',1,0,0,29,'2011-01-01 00:00:01',627,'Fruit Shop Webmaster','2011-12-27 11:17:59',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(21,119,'Getting Help','getting-help','','<p><img class=\"image-left\" src=\"administrator/templates/hathor/images/header/icon-48-help_header.png\" border=\"0\" /> There are lots of places you can get help with Joomla!. In many places in your site administrator you will see the help icon. Click on this for more information about the options and functions of items on your screen. Other places to get help are:</p>\r\n<ul>\r\n<li><a href=\"http://forum.joomla.org\">Support Forums</a></li>\r\n<li><a href=\"http://docs.joomla.org\">Documentation</a></li>\r\n<li><a href=\"http://resources.joomla.org\">Professionals</a></li>\r\n<li><a href=\"http://shop.joomla.org/amazoncom-bookstores.html\">Books</a></li>\r\n</ul>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-01-10 15:32:54',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',10,0,8,'','',1,17,'',0,'*',''),(22,120,'Getting Started','getting-started','','<p>It\'s easy to get started creating your website. Knowing some of the basics will help.</p>\r\n<h3>What is a Content Management System?</h3>\r\n<p>A content management system is software that allows you to create and manage webpages easily by separating the creation of your content from the mechanics required to present it on the web.</p>\r\n<p>In this site, the content is stored in a <em>database</em>. The look and feel are created by a <em>template</em>. The Joomla! software brings together the template and the content to create web pages.</p>\r\n<h3>Site and Administrator</h3>\r\n<p>Your site actually has two separate sites. The site (also called the front end) is what visitors to your site will see. The administrator (also called the back end) is only used by people managing your site. You can access the administrator by clicking the \"Site Administrator\" link on the \"This Site\" menu or by adding /administrator to the end of you domain name.</p>\r\n<p>Log in to the administrator using the username and password created during the installation of Joomla.</p>\r\n<h3>Logging in</h3>\r\n<p>To login to the front end of your site use the login form or the login menu link on the \"This Site\" menu. Use the user name and password that were created as part of the installation process. Once logged-in you will be able to create and edit articles.</p>\r\n<p>In managing your site, you will be able to create content that only logged-in users are able to see.</p>\r\n<h3>Creating an article</h3>\r\n<p>Once you are logged-in, a new menu will be visible. To create a new article, click on the \"submit article\" link on that menu.</p>\r\n<p>The new article interface gives you a lot of options, but all you need to do is add a title and put something in the content area. To make it easy to find, set the state to published and put it in the Joomla category.</p>\r\n<div>You can edit an existing article by clicking on the edit icon (this only displays to users who have the right to edit).</div>\r\n<h3>Learn more</h3>\r\n<p>There is much more to learn about how to use Joomla! to create the web site you envision. You can learn much more at the <a href=\"http://docs.joomla.org\">Joomla! documentation site</a> and on the<a href=\"http://forum.joomla.org\"> Joomla! forums</a>.</p>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:21:44',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,9,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(23,121,'Happy Orange Orchard','happy-orange-orchard','','<p>At our orchard we grow the world\'s best oranges as well as other citrus fruit such as lemons and grapefruit. Our family has been tending this orchard for generations.</p>','',1,0,0,30,'2011-01-01 00:00:01',627,'Fruit Shop Webmaster','2011-01-01 00:00:01',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,2,'','',1,0,'',0,'*',''),(24,122,'Joomla!','joomla','','<p>Congratulations! You have a Joomla site! Joomla makes it easy to build a website just the way you want it and keep it simple to update and maintain.</p>\r\n<p>Joomla is a flexible and powerful platform, whether you are building a small site for yourself or a huge site with hundreds of thousands of visitors. Joomla is open source, which means you can make it work just the way you want it to.</p>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:22:23',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,2,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),(25,123,'Koala','koala','','<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n<p> </p>\r\n','\r\n<p> </p>',1,0,0,72,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 05:15:00',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/180px_koala_ag1.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Koala  Thumbnail\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/800px_koala_ag1.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Koala Climbing Tree\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Koala-ag1.jpg Author: Arnaud Gaillard License: Creative Commons Share Alike Attribution Generic 1.0\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',9,0,2,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(26,124,'Language Switcher','language-switcher','','<p>The language switcher module allows you to take advantage of the language tags that are available when content, modules and menu links are created.</p>\r\n<p>This module displays a list of available Content Languages for switching between them.</p>\r\n<p>When switching languages, it redirects to the Home page, or associated menu item, defined for the chosen language. Thereafter, the navigation will be the one defined for that language.</p>\r\n<p><strong>The language filter plugin must be enabled for this module to work properly.</strong></p>\r\n<p><strong></strong> <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Language_Switcher\" title=\"Language Switcher Module\">Help</a></p>\r\n<p>To view an example of the language switch moduler module, go to the site administrator and enable the language filter plugin and the language switcher module labelled \"language switcher\" and visit the fruit shop or park sample sites. Then follow<a href=\"http://docs.joomla.org/Language_Switcher_Tutorial_for_Joomla_1.6\"> the instructions in this tutorial</a>.</p>','',1,0,0,67,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:25:00',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,3,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(27,125,'Latest Articles Module','latest-articles-module','','<p>This module shows a list of the most recently published and current Articles. Some that are shown may have expired even though they are the most recent. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Latest_News\" title=\"Latest Articles\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule articles_latest,Latest News}</div>','',1,0,0,64,'2011-01-01 00:00:01',627,'','2011-12-27 11:25:41',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',9,0,1,'modules, content','',1,15,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(28,126,'Login Module','login-module','','<p>This module displays a username and password login form. It also displays a link to retrieve a forgotten password. If user registration is enabled (in the Global Configuration settings), another link will be shown to enable self-registration for users. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Login\" title=\"Login\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule login,login}</div>','',1,0,0,65,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:20:35',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,2,'','',1,5,'',0,'*',''),(29,127,'Menu Module','menu-module','','<p>This module displays a menu on the site (frontend).  Menus can be displayed in a wide variety of ways by using the menu options and css menu styles. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Menu\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule mod_menu,Menu Example}</div>','',1,0,0,75,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:18:45',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',8,0,1,'','',1,12,'',0,'*',''),(30,128,'Most Read Content','most-read-content','','<p>This module shows a list of the currently published Articles which have the highest number of page views. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Most_Read\" title=\"Most Read Content\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule articles_popular,Articles Most Read}</div>','',1,0,0,64,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:26:41',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',6,0,2,'modules, content','',1,10,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(31,129,'News Flash','news-flash','','<p>Displays a set number of articles from a category based on date or random selection. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Articles_Newsflash\" title=\"News Flash Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule articles_news,News Flash}</div>','',1,0,0,64,'2011-01-01 00:00:01',627,'','2011-09-17 22:16:46',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,3,'modules, content','',1,10,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(32,130,'Options','options','','<p>As you make your Joomla! site you will control the details of the display using <em>options</em> also referred to as <em>parameter</em><strong>s</strong>. Options control everything from whether the author\'s name is displayed to who can view what to the number of items shown on a list.</p>\r\n<p>Default options for each component are changed using the Options button on the component toolbar.</p>\r\n<p>Options can also be set on an individual item, such as an article or contact and in menu links.</p>\r\n<p>If you are happy with how your site looks, it is fine to leave all of the options set to the defaults that were created when your site was installed. As you become more experienced with Joomla you will use options more.</p>\r\n<p> </p>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2012-01-17 16:21:24',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,10,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(33,131,'Phyllopteryx','phyllopteryx','','<p> </p>\r\n','\r\n<p> </p>',1,0,0,72,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 04:57:58',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/200px_phyllopteryx_taeniolatus1.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Phyllopteryx\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/800px_phyllopteryx_taeniolatus1.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Phyllopteryx\",\"image_fulltext_caption\":\"Source: http:\\/\\/en.wikipedia.org\\/wiki\\/File:Phyllopteryx_taeniolatus1.jpg Author: Richard Ling License: GNU Free Documentation License v 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,3,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(34,132,'Pinnacles','pinnacles','','<p> </p>\r\n','\r\n<p> </p>',1,0,0,73,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 04:41:30',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/120px_pinnacles_western_australia.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Kings Canyon\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/800px_pinnacles_western_australia.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Kings Canyon\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Pinnacles_Western_Australia.jpg  Author: Martin Gloss  License: GNU Free Documentation license v 1.2 or later.\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,4,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(35,133,'Professionals','professionals','','<p>Joomla! 2.5 continues development of the Joomla Framework and CMS as a powerful and flexible way to bring your vision of the web to reality. With the administrator now fully MVC, the ability to control its look and the management of extensions is now complete.</p>\r\n','\r\n<p>Working with multiple template styles and overrides for the same views, creating the design you want is easier than it has ever been. Limiting support to PHP 5.2.4 and above makes Joomla lighter and faster than ever. Languages files can now be overridden without having your changes lost during an upgrade.  With the proper xml your users update extensions with a single click.</p>\r\n<p>Access control lists are now incorporated using a new system developed for Joomla. The ACL system is designed with developers in mind, so it is easy to incorporate into your extensions. The new nested sets libraries allow you to incorporate infinitely deep categories but also to use nested sets in a variety of other ways.</p>\r\n<p>A new forms library makes creating all kinds of user interaction simple. MooTools 1.3 provides a highly flexible javascript framework that is a major advance over MooTools 1.0.</p>\r\n<p>New events throughout the core make integration of your plugins where you want them a snap.</p>\r\n<p>The separation of the Joomla! Platform project from the Joomla! CMS project makes continuous development of new, powerful APIs  and continuous improvement of existing APIs possible while maintaining the stability of the CMS that millions of webmasters and professionals rely upon.</p>\r\n<p>Learn about:</p>\r\n<ul>\r\n<li><a href=\"http://docs.joomla.org/What\'s_new_in_Joomla_1.6\">Changes since 1.5</a></li>\r\n<li><a href=\"http://docs.joomla.org/ACL_Tutorial_for_Joomla_1.6\">Working with ACL</a></li>\r\n<li><a href=\"http://docs.joomla.org/API16:JCategories\">Working with nested categories</a></li>\r\n<li><a href=\"http://docs.joomla.org/API16:JForm\">Forms library</a></li>\r\n<li><a href=\"http://docs.joomla.org/Working_with_Mootools_1.3\">Working with Mootools 1.3</a></li>\r\n<li><a href=\"http://docs.joomla.org/Layout_Overrides_in_Joomla_1.6\">Using new features of the override system</a></li>\r\n<li><a href=\"http://api.joomla.org\">Joomla! API</a></li>\r\n<li><a href=\"http://docs.joomla.org/API16:JDatabaseQuery\">Using JDatabaseQuery</a></li>\r\n<li><a href=\"http://docs.joomla.org/What\'s_new_in_Joomla_1.6#Events\">New and updated events</a></li>\r\n<li><a href=\"http://docs.joomla.org/Xml-rpc_changes_in_Joomla!_1.6\">Xmlrpc</a></li>\r\n<li><a href=\"http://docs.joomla.org/What\'s_new_in_Joomla_1.6#Extension_management\">Installing and updating extensions</a></li>\r\n<li><a href=\"http://docs.joomla.org/Setting_up_your_workstation_for_Joomla!_development\">Setting up your development environment</a></li>\r\n<li><a href=\"github.com/joomla\">The Joomla! Platform Repository</a> </li>\r\n</ul>',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:36:13',42,0,'0000-00-00 00:00:00','2011-01-09 16:41:13','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',16,0,5,'','',1,10,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),(36,134,'Random Image Module','random-image-module','','<p>This module displays a random image from your chosen image directory. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Random_Image\" title=\"Random Image Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule random_image,Random Image}</div>','',1,0,0,66,'2011-01-01 00:00:01',627,'','2012-01-17 16:11:13',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',6,0,4,'','',1,6,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(37,135,'Related Items Module','related-items-module','','<p>This module displays other Articles that are related to the one currently being viewed. These relations are established by the Meta Keywords.  All the keywords of the current Article are searched against all the keywords of all other published articles. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Articles_Related\" title=\"Related Items Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule related_items,Articles Related Items}</div>','',1,0,0,64,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:37:34',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',5,0,4,'modules, content','',1,5,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(38,136,'Sample Sites','sample-sites','','<p>Your installation includes sample data, designed to show you some of the options you have for building your website. In addition to information about Joomla! there are two sample \"sites within a site\" designed to help you get started with building your own site.</p>\r\n<p>The first site is a simple site about <a href=\"index.php?Itemid=243\">Australian Parks</a>. It shows how you can quickly and easily build a personal site with just the building blocks that are part of Joomla. It includes a personal blog, weblinks, and a very simple image gallery.</p>\r\n<p>The second site is slightly more complex and represents what you might do if you are building a site for a small business, in this case a <a href=\"index.php/welcome.html\"></a><a href=\"index.php?Itemid=429\">Fruit Shop</a>.</p>\r\n<p>In building either style site, or something completely different, you will probably want to add <a href=\"http://extensions.joomla.org\">extensions</a> and either create or purchase your own template. Many Joomla users start by modifying the <a href=\"http://docs.joomla.org/How_do_you_modify_a_template%3F\">templates</a> that come with the core distribution so that they include special images and other design elements that relate to their site\'s focus.</p>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:39:07',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,11,'','',1,5,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(39,137,'Search','search-component','','<p>Joomla! 2.5 offers two search options.</p>\r\n<p>The Basic Search component provides basic search functionality for the information contained in your core components. Many extensions can also be searched by the search component. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Components_Search\">Help</a></p>\r\n<p>The Smart Search component offers searching similar to that found in major search engines. Smart Search is disabled by default. If you choose to enable it you will need to take several steps. First, enable the Smart Search Plugin in the plugin manager. Then, if you are using the Basic Search Module replace it with the Smart Search Module. Finally, if you have already created content, go to the Smart Search component in your site administrator and click the Index icon. Once indexing of your content is complete, Smart Search will be ready to use. Help.</p>','',1,0,0,21,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:41:48',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,3,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(40,138,'Search Module','search-module','','<p>This module will display a search box. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Search\" title=\"Search\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule search,Search}</div>','',1,0,0,67,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:35:56',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,4,'','',1,6,'',0,'*',''),(41,139,'Search ','search-plugin','','<p>The search component uses plugins to control which parts of your Joomla! site are searched. You may choose to turn off some areas to improve performance or for other reasons. Many third party Joomla! extensions have search plugins that extend where search takes place.</p>\r\n<p>Default On:</p>\r\n<ul>\r\n<li>Content <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Search_-_Content\">Help</a></li>\r\n<li>Contacts <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Search_-_Contacts\">Help</a></li>\r\n<li>Weblinks <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Search_-_Weblinks\">Help</a></li>\r\n<li>News Feeds <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Search_-_Newsfeeds\">Help</a></li>\r\n<li>Categories <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Search_-_Categories\">Help</a></li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-09-06 06:13:18',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',3,0,1,'','',1,0,'',0,'*',''),(42,140,'Site Map','site-map','','<p>{loadposition sitemapload}</p><p><em>By putting all of your content into nested categories you can give users and search engines access to everything using a menu.</em></p>','',1,0,0,14,'2011-01-01 00:00:01',627,'Joomla!','2011-01-01 00:00:01',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,1,'','',1,0,'',0,'*',''),(43,141,'Spotted Quoll','spotted-quoll','','<p> </p>\r\n<p> </p>\r\n','\r\n<p> </p>',1,0,0,72,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 05:02:58',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/220px_spottedquoll_2005_seanmcclean.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Spotted Quoll\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/789px_spottedquoll_2005_seanmcclean.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Spotted Quoll\",\"image_fulltext_caption\":\"Source: http:\\/\\/en.wikipedia.org\\/wiki\\/File:SpottedQuoll_2005_SeanMcClean.jpg Author: Sean McClean License: GNU Free Documentation License v 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(44,142,'Statistics Module','statistics','','<p>This module shows information about your server installation together with statistics on the Web site users, number of Articles in your database and the number of Web links you provide.</p>\r\n<div class=\"sample-module\">{loadmodule mod_stats,Statistics}</div>','',1,0,0,67,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:43:25',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',6,0,5,'','',1,5,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(45,143,'Syndicate Module','syndicate-module','','<p>The syndicate module will display a link that allows users to take a feed from your site. It will only display on pages for which feeds are possible. That means it will not display on single article, contact or weblinks pages, such as this one. <a href=\"http://docs.joomla.org/Help15:Screen.modulessite.edit.15#Syndicate\" title=\"Synicate Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadposition syndicate,Syndicate}</div>','',1,0,0,67,'2011-01-01 00:00:01',627,'','2011-12-27 11:44:16',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,6,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(46,144,'System','system','','<p>System plugins operate every time a page on your site loads. They control such things as your URLS, whether users can check a \"remember me\" box on the login module, and whether caching is enabled. New is the redirect plugin that together with the redirect component will assist you in managing changes in URLs.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>Remember me <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#System_-_Remember_Me\">Help</a></li>\r\n<li>SEF <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#System_-_SEF\">Help</a></li>\r\n<li>Debug <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#System_-_Debug\">Help</a></li>\r\n</ul>\r\n<p>Default off:</p>\r\n<ul>\r\n<li>Cache <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#System_-_Cache\">Help</a></li>\r\n<li>Log <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#System_-_Log\">Help</a></li>\r\n<li>Redirect <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#System_-_Redirect\">Help</a></li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:45:54',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',5,0,2,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(47,145,'The Joomla! Community','the-joomla-community','','<p>Joomla means All Together, and it is a community of people all working and having fun together that makes Joomla possible. Thousands of people each year participate in the Joomla community, and we hope you will be one of them.</p>\r\n<p>People with all kinds of skills, of all skill levels and from around the world are welcome to join in. Participate in the <a href=\"http://joomla.org\">Joomla.org</a> family of websites (the<a href=\"http://forum.joomla.org\"> forum </a>is a great place to start). Come to a <a href=\"http://community.joomla.org/events.html\">Joomla! event</a>. Join or start a <a href=\"http://community.joomla.org/user-groups.html\">Joomla! Users Group</a>. Whether you are a developer, site administrator, designer, end user or fan, there are ways for you to participate and contribute.</p>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:47:56',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,3,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(48,146,'The Joomla! Project','the-joomla-project','','<p>The Joomla Project consists of all of the people who make and support the Joomla Web Platform and Content Management System.</p>\r\n<p>Our mission is to provide a flexible platform for digital publishing and collaboration.</p>\r\n<p>The core values are:</p>\r\n<ul>\r\n<li>Freedom</li>\r\n<li>Equality</li>\r\n<li>Trust</li>\r\n<li>Community</li>\r\n<li>Collaboration</li>\r\n<li>Usability</li>\r\n</ul>\r\n<p>In our vision, we see:</p>\r\n<ul>\r\n<li>People publishing and collaborating in their communities and around the world</li>\r\n<li>Software that is free, secure, and high-quality</li>\r\n<li>A community that is enjoyable and rewarding to participate in</li>\r\n<li>People around the world using their preferred languages</li>\r\n<li>A project that acts autonomously</li>\r\n<li>A project that is socially responsible</li>\r\n<li>A project dedicated to maintaining the trust of its users</li>\r\n</ul>\r\n<p>There are millions of users around the world and thousands of people who contribute to the Joomla Project. They work in three main groups: the Production Working Group, responsible for everything that goes into software and documentation; the Community Working Group, responsible for creating a nurturing the community; and Open Source Matters, the non profit organization responsible for managing legal, financial and organizational issues.</p>\r\n<p>Joomla is a free and open source project, which uses the GNU General Public License version 2 or later.</p>','',1,0,0,19,'2011-01-01 00:00:01',627,'','2011-12-27 11:47:48',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,1,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(49,147,'Typography','typography','','<h1>H1 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h1><h2>H2 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h2><h3>H3 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h3><h4>H4 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h4><h5>H5 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h5><h6>H6 ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmonpqrstuvwzyz</h6><p>P The quick brown fox ran over the lazy dog. THE QUICK BROWN FOX RAN OVER THE LAZY DOG.</p><ul><li>Item</li><li>Item</li><li>Item<br /> <ul><li>Item</li><li>Item</li><li>Item<br /> <ul><li>Item</li><li>Item</li><li>Item</li></ul></li></ul></li></ul><ol><li>tem</li><li>Item</li><li>Item<br /> <ol><li>Item</li><li>Item</li><li>Item<br /><ol><li>Item</li><li>Item</li><li>Item</li></ol></li></ol> </li></ol>','',1,0,0,23,'2011-01-01 00:00:01',627,'Joomla!','2011-01-01 00:00:01',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,1,'','',1,0,'',0,'*',''),(50,148,'Upgraders','upgraders','','<p>If you are an experienced Joomla! 1.5 user, this Joomla site will seem very familiar. There are new templates and improved user interfaces, but most functionality is the same. The biggest changes are improved access control (ACL) and nested categories. This release of Joomla has strong continuity with Joomla! 1.7 while adding enhancements.</p>\r\n','\r\n<p>The new user manager will let you manage who has access to what in your site. You can leave access groups exactly the way you had them in Joomla 1.5 or make them as complicated as you want. You can learn more about<a href=\"http://docs.joomla.org/ACL_Tutorial_for_Joomla_1.6\"> how access control works</a> in on the <a href=\"http://docs.joomla.org\">Joomla! Documentation site</a></p>\r\n<p>In Joomla 1.5 and 1.0 content was organized into sections and categories. From 1.6 forward sections are gone, and you can create categories within categories, going as deep as you want. The sample data provides many examples of the use of nested categories.</p>\r\n<p>All layouts have been redesigned to improve accessibility and flexibility. </p>\r\n<p>Updating your site and extensions when needed is easier than ever thanks to installer improvements.</p>\r\n<p> </p>',1,0,0,19,'2011-01-01 00:00:01',627,'','2012-01-17 04:28:10',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',5,0,6,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',1,'*',''),(51,149,'User','user-plugins','','<p>Default on:</p>\r\n<ul>\r\n<li>Joomla <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#User_-_Joomla.21\">Help</a></li>\r\n</ul>\r\n<p>Default off:</p>\r\n<p>Two new plugins are available but are disabled by default.</p>\r\n<ul>\r\n<li>Contact Creator <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#User_-_Contact_Creator\">Help</a><br />Creates a new linked contact record for each new user created.</li>\r\n<li>Profile <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#User_-_Profile\">Help</a><br />This example profile plugin allows you to insert additional fields into user registration and profile display. This is intended as an example of the types of extensions to the profile you might want to create.</li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:51:25',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,4,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(52,150,'Users','users-component','','<p>The users extension lets your site visitors register, login and logout, change their passwords and other information, and recover lost passwords. In the administrator it allows you to create, block and manage users and create user groups and access levels. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Users_User_Manager\">Help</a></p>\r\n<p>Please note that some of the user views will not display if you are not logged-in to the site.</p>','',1,0,0,21,'2011-01-01 00:00:01',627,'Joomla!','2011-01-10 04:52:55',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',2,0,5,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(53,151,'Using Joomla!','using-joomla','','<p>With Joomla you can create anything from a simple personal website to a complex ecommerce or social site with millions of visitors.</p>\r\n<p>This section of the sample data provides you with a brief introduction to Joomla concepts and reference material to help you understand how Joomla works.</p>\r\n<p><em>When you no longer need the sample data, you can can simply unpublish the sample data category found within each extension in the site administrator or you may completely delete each item and all of the categories. </em></p>','',1,0,0,19,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:52:45',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,7,'','',1,9,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(54,152,'Weblinks','weblinks','','<p>Weblinks (com_weblinks) is a component that provides a structured way to organize external links and present them in a visually attractive, consistent and informative way. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Components_Weblinks_Links\">Help</a></p>','',1,0,0,21,'2011-01-01 00:00:01',627,'Joomla!','2011-01-10 04:20:10',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',2,0,6,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(55,153,'Weblinks Module','weblinks-module','','<p>This module displays the list of weblinks in a category. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Weblinks\" title=\"Weblinks Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule weblinks,Weblinks}</div>','',1,0,0,66,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:32:10',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',7,0,5,'','',1,23,'',0,'*',''),(56,154,'Who\'s Online','whos-online','','<p>The Who\'s Online Module displays the number of Anonymous Users (e.g. Guests) and Registered Users (ones logged-in) that are currently accessing the Web site. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Who_Online\" title=\"Who\'s Online\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule whosonline,Who\'s Online}</div>','',1,0,0,65,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:19:45',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,1,'','',1,5,'',0,'*',''),(57,155,'Wobbegone','wobbegone','','<p> </p>\r\n','\r\n<p> </p>',1,0,0,72,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 05:01:59',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/animals\\/180px_wobbegong.jpg\",\"float_intro\":\"\",\"image_intro_alt\":\"Wobbegon\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/animals\\/800px_wobbegong.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Wobbegon\",\"image_fulltext_caption\":\"Source: http:\\/\\/en.wikipedia.org\\/wiki\\/File:Wobbegong.jpg Author: Richard Ling Rights: GNU Free Documentation License v 1.2 or later\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(58,156,'Wonderful Watermelon','wonderful-watermelon','','<p>Watermelon is a wonderful and healthy treat. We grow the world\'s sweetest watermelon. We have the largest watermelon patch in our country.</p>','',1,0,0,30,'2011-01-01 00:00:01',627,'Fruit Shop Webmaster','2011-01-01 00:00:01',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,1,'','',1,0,'',0,'*',''),(59,157,'Wrapper Module','wrapper-module','','<p>This module shows an iFrame window to specified location. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Wrapper\" title=\"Wrapper Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule wrapper,Wrapper}</div>','',1,0,0,67,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:35:00',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',8,0,1,'','',1,15,'',0,'*',''),(60,158,'News Feeds','news-feeds','','<p>News Feeds (com_newsfeeds) provides a way to organize and present news feeds. News feeds are a way that you present information from another site on your site. For example, the joomla.org website has numerous feeds that you can incorporate on your site. You an use menus to present a single feed, a list of feeds in a category, or a list of all feed categories. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Components_Newsfeeds_Feeds\">Help</a></p>','',1,0,0,21,'2011-01-01 00:00:01',627,'Joomla!','2011-12-27 11:27:31',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',3,0,4,'','',1,2,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(61,159,'Breadcrumbs Module','breadcrumbs-module','','<p>Breadcrumbs provide a pathway for users to navigate through the site. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Breadcrumbs\" title=\"Breacrumbs Module\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule breadcrumbs,breadcrumbs}</div>','',1,0,0,75,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:10:19',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\"}',5,0,2,'','',1,9,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(62,160,'Content','content-plugins','','<p>Content plugins run when specific kinds of pages are loaded. They do things ranging from protecting email addresses from harvesters to creating page breaks.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>Email Cloaking <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Content_-_Email_Cloaking\">Help</a></li>\r\n<li>Load Module <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Content_-_Load_Modules\">Help</a></li>\r\n<li>Page Break <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Content_-_Pagebreak\">Help</a></li>\r\n<li>Page Navigation<a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Content_-_Page_Navigation\"> Help</a></li>\r\n<li>Vote <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Content_-_Vote\">Help</a></li>\r\n</ul>\r\n<p>Default off:</p>\r\n<ul>\r\n<li>Code Highlighter (GeSHi) <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit#Content_-_Code_Highlighter_.28GeSHi.29\">Help</a></li>\r\n</ul>','',1,0,0,25,'2011-01-01 00:00:01',627,'Joomla!','2011-09-06 06:11:50',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',2,0,7,'','',1,1,'',0,'*',''),(64,162,'Blue Mountain Rain Forest','blue-mountain-rain-forest','','<p> </p>\r\n','\r\n<p> </p>',1,0,0,73,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 04:36:30',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/120px_rainforest_bluemountainsnsw.jpg\",\"float_intro\":\"none\",\"image_intro_alt\":\"Rain Forest Blue Mountains\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/727px_rainforest_bluemountainsnsw.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Rain Forest Blue Mountains\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Rainforest,bluemountainsNSW.jpg Author: Adam J.W.C. License: GNU Free Documentation License\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',4,0,2,'','',1,3,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(65,163,'Ormiston Pound','ormiston-pound','','<p> </p>\r\n','\r\n<p> </p>',1,0,0,73,'2011-01-01 00:00:01',627,'Parks Webmaster','2012-01-17 04:51:33',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','{\"image_intro\":\"images\\/sampledata\\/parks\\/landscape\\/180px_ormiston_pound.jpg\",\"float_intro\":\"none\",\"image_intro_alt\":\"Ormiston Pound\",\"image_intro_caption\":\"\",\"image_fulltext\":\"images\\/sampledata\\/parks\\/landscape\\/800px_ormiston_pound.jpg\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"Ormiston Pound\",\"image_fulltext_caption\":\"Source: http:\\/\\/commons.wikimedia.org\\/wiki\\/File:Ormiston_Pound.JPG Author: License: GNU Free Public Documentation License\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',5,0,3,'','',1,1,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(66,165,'Latest Users Module','latest-users-module','','<p>This module displays the latest registered users. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;keyref=Help16:Extensions_Module_Manager_Latest_Users\">Help</a></p>\r\n<div class=\"sample-module\">{loadmodule users_latest,Users Latest}</div>','',1,0,0,65,'2011-01-01 00:00:01',627,'Joomla!','2011-09-17 22:21:05',42,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',4,0,3,'','',1,6,'',0,'*',''),(67,168,'What\'s New in 1.5?','whats-new-in-15','','<p>This article deliberately archived as an example.</p><p>As with previous releases, Joomla! provides a unified and easy-to-use framework for delivering content for Web sites of all kinds. To support the changing nature of the Internet and emerging Web technologies, Joomla! required substantial restructuring of its core functionality and we also used this effort to simplify many challenges within the current user interface. Joomla! 1.5 has many new features.</p>\r\n<p style=\"margin-bottom: 0in;\">In Joomla! 1.5, you\'\'ll notice:</p>\r\n<ul>\r\n<li>Substantially improved usability, manageability, and scalability far beyond the original Mambo foundations</li>\r\n<li>Expanded accessibility to support internationalisation, double-byte characters and right-to-left support for Arabic, Farsi, and Hebrew languages among others</li>\r\n<li>Extended integration of external applications through Web services</li>\r\n<li>Enhanced content delivery, template and presentation capabilities to support accessibility standards and content delivery to any destination</li>\r\n<li>A more sustainable and flexible framework for Component and Extension developers</li>\r\n<li>Backward compatibility with previous releases of Components, Templates, Modules, and other Extensions</li>\r\n</ul>','',2,0,0,9,'2011-01-01 00:00:01',627,'Joomla! 1.5','2011-01-01 00:00:01',0,0,'0000-00-00 00:00:00','2011-01-01 00:00:01','0000-00-00 00:00:00','','','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_readmore\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"page_title\":\"\",\"alternative_readmore\":\"\",\"layout\":\"\"}',1,0,0,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(68,170,'Captcha','captcha','','<p>The Captcha plugins are used to prevent spam submissions on your forms such as registration, contact and login. You basic installation of Joomla includes one Captcha plugin which leverages the ReCaptcha® service but you may install other plugins connecting to different Captcha systems.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>ReCaptcha <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit\">help</a></li>\r\n</ul>\r\n<p>Note: ReCaptcha is a the trademark of Google Inc. and is an independent product not associated with or endorsed by the Joomla Project. You will need to register and agree to the Terms of Service at Recaptcha.net to use this plugin. Complete instructions are available if you edit the ReCaptcha plugin in the Plugin Manager.</p>','',1,0,0,25,'2012-01-17 03:20:45',627,'Joomla!','2012-01-17 03:35:46',42,0,'0000-00-00 00:00:00','2012-01-17 03:20:45','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',2,0,1,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(69,171,'Quick Icons','quick-icons','','<p> The Quick Icon plugin group is used to provide notification that updates to Joomla! or installed extensions are available and should be applied. These notifications display on your administrator control panel, which is the page you see when you first log in to your site administrator.</p>\r\n<p>Default on:</p>\r\n<ul>\r\n<li>Quick icon - Joomla! extensions updates notification <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit\">Help</a>.</li>\r\n<li>Quick icon - Joomla! update notification <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help17:Extensions_Plugin_Manager_Edit\">Help</a></li>\r\n</ul>','',1,0,0,25,'2012-01-17 03:27:39',627,'Joomla!','0000-00-00 00:00:00',0,0,'0000-00-00 00:00:00','2012-01-17 03:27:39','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',1,0,0,'','',1,0,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*',''),(70,170,'Smart Search','smart-search','','<p>This module provides search using the Smart Search component. You should only use it if you have indexed your content and either have enabled the Smart Search content plugin or are keeping the index of your site updated manually. <a href=\"http://help.joomla.org/proxy/index.php?option=com_help&amp;amp;keyref=Help25:Extensions_Module_Manager_Smart_Search\">Help</a>.</p>\r\n<div class=\"sample-module\">{loadmodule finder,Smart Search}</div>','',1,0,0,67,'2012-01-17 03:42:36',627,'','2012-01-17 16:15:48',42,0,'0000-00-00 00:00:00','2012-01-17 03:42:36','0000-00-00 00:00:00','{\"image_intro\":\"\",\"float_intro\":\"\",\"image_intro_alt\":\"\",\"image_intro_caption\":\"\",\"image_fulltext\":\"\",\"float_fulltext\":\"\",\"image_fulltext_alt\":\"\",\"image_fulltext_caption\":\"\"}','{\"urla\":\"\",\"urlatext\":\"\",\"targeta\":\"\",\"urlb\":\"\",\"urlbtext\":\"\",\"targetb\":\"\",\"urlc\":\"\",\"urlctext\":\"\",\"targetc\":\"\"}','{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_vote\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"alternative_readmore\":\"\",\"article_layout\":\"\",\"show_publishing_options\":\"\",\"show_article_options\":\"\",\"show_urls_images_backend\":\"\",\"show_urls_images_frontend\":\"\"}',10,0,0,'','',1,13,'{\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}',0,'*','');
/*!40000 ALTER TABLE `bak_qm_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_content_frontpage`
--

DROP TABLE IF EXISTS `bak_qm_content_frontpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_content_frontpage`
--

LOCK TABLES `bak_qm_content_frontpage` WRITE;
/*!40000 ALTER TABLE `bak_qm_content_frontpage` DISABLE KEYS */;
INSERT INTO `bak_qm_content_frontpage` VALUES (8,2),(24,1),(35,4),(50,3);
/*!40000 ALTER TABLE `bak_qm_content_frontpage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_content_rating`
--

DROP TABLE IF EXISTS `bak_qm_content_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_content_rating`
--

LOCK TABLES `bak_qm_content_rating` WRITE;
/*!40000 ALTER TABLE `bak_qm_content_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_content_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_core_log_searches`
--

DROP TABLE IF EXISTS `bak_qm_core_log_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_core_log_searches` (
  `search_term` varchar(128) NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_core_log_searches`
--

LOCK TABLES `bak_qm_core_log_searches` WRITE;
/*!40000 ALTER TABLE `bak_qm_core_log_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_core_log_searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_extensions`
--

DROP TABLE IF EXISTS `bak_qm_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `element` varchar(100) NOT NULL,
  `folder` varchar(100) NOT NULL,
  `client_id` tinyint(3) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  `access` int(10) unsigned NOT NULL DEFAULT '1',
  `protected` tinyint(3) NOT NULL DEFAULT '0',
  `manifest_cache` text NOT NULL,
  `params` text NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`extension_id`),
  KEY `element_clientid` (`element`,`client_id`),
  KEY `element_folder_clientid` (`element`,`folder`,`client_id`),
  KEY `extension` (`type`,`element`,`folder`,`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=901 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_extensions`
--

LOCK TABLES `bak_qm_extensions` WRITE;
/*!40000 ALTER TABLE `bak_qm_extensions` DISABLE KEYS */;
INSERT INTO `bak_qm_extensions` VALUES (1,'com_mailto','component','com_mailto','',0,1,1,1,'{\"legacy\":false,\"name\":\"com_mailto\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MAILTO_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(2,'com_wrapper','component','com_wrapper','',0,1,1,1,'{\"legacy\":false,\"name\":\"com_wrapper\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_WRAPPER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(3,'com_admin','component','com_admin','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_admin\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_ADMIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(4,'com_banners','component','com_banners','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_banners\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_BANNERS_XML_DESCRIPTION\",\"group\":\"\"}','{\"purchase_type\":\"3\",\"track_impressions\":\"0\",\"track_clicks\":\"0\",\"metakey_prefix\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(5,'com_cache','component','com_cache','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_cache\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CACHE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(6,'com_categories','component','com_categories','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_categories\",\"type\":\"component\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(7,'com_checkin','component','com_checkin','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_checkin\",\"type\":\"component\",\"creationDate\":\"Unknown\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2008 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CHECKIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(8,'com_contact','component','com_contact','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_contact\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CONTACT_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_contact_category\":\"hide\",\"show_contact_list\":\"0\",\"presentation_style\":\"sliders\",\"show_name\":\"1\",\"show_position\":\"1\",\"show_email\":\"0\",\"show_street_address\":\"1\",\"show_suburb\":\"1\",\"show_state\":\"1\",\"show_postcode\":\"1\",\"show_country\":\"1\",\"show_telephone\":\"1\",\"show_mobile\":\"1\",\"show_fax\":\"1\",\"show_webpage\":\"1\",\"show_misc\":\"1\",\"show_image\":\"1\",\"image\":\"\",\"allow_vcard\":\"0\",\"show_articles\":\"0\",\"show_profile\":\"0\",\"show_links\":\"0\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"contact_icons\":\"0\",\"icon_address\":\"\",\"icon_email\":\"\",\"icon_telephone\":\"\",\"icon_mobile\":\"\",\"icon_fax\":\"\",\"icon_misc\":\"\",\"show_headings\":\"1\",\"show_position_headings\":\"1\",\"show_email_headings\":\"0\",\"show_telephone_headings\":\"1\",\"show_mobile_headings\":\"0\",\"show_fax_headings\":\"0\",\"allow_vcard_headings\":\"0\",\"show_suburb_headings\":\"1\",\"show_state_headings\":\"1\",\"show_country_headings\":\"1\",\"show_email_form\":\"1\",\"show_email_copy\":\"1\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"0\",\"redirect\":\"\",\"show_category_crumb\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(9,'com_cpanel','component','com_cpanel','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_cpanel\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CPANEL_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10,'com_installer','component','com_installer','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_installer\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_INSTALLER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(11,'com_languages','component','com_languages','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_languages\",\"type\":\"component\",\"creationDate\":\"2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}','{\"administrator\":\"en-GB\",\"site\":\"en-GB\"}','','',0,'0000-00-00 00:00:00',0,0),(12,'com_login','component','com_login','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_login\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(13,'com_media','component','com_media','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_media\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MEDIA_XML_DESCRIPTION\",\"group\":\"\"}','{\"upload_extensions\":\"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\",\"upload_maxsize\":\"10\",\"file_path\":\"images\",\"image_path\":\"images\",\"restrict_uploads\":\"1\",\"allowed_media_usergroup\":\"3\",\"check_mime\":\"1\",\"image_extensions\":\"bmp,gif,jpg,png\",\"ignore_extensions\":\"\",\"upload_mime\":\"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip\",\"upload_mime_illegal\":\"text\\/html\"}','','',0,'0000-00-00 00:00:00',0,0),(14,'com_menus','component','com_menus','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_menus\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MENUS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(15,'com_messages','component','com_messages','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_messages\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MESSAGES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(16,'com_modules','component','com_modules','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_modules\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MODULES_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(17,'com_newsfeeds','component','com_newsfeeds','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_newsfeeds\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_feed_image\":\"1\",\"show_feed_description\":\"1\",\"show_item_description\":\"1\",\"feed_word_count\":\"0\",\"show_headings\":\"1\",\"show_name\":\"1\",\"show_articles\":\"0\",\"show_link\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"display_num\":\"\",\"show_pagination_limit\":\"1\",\"show_pagination\":\"1\",\"show_pagination_results\":\"1\",\"show_cat_items\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(18,'com_plugins','component','com_plugins','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_plugins\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_PLUGINS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(19,'com_search','component','com_search','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_search\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_SEARCH_XML_DESCRIPTION\",\"group\":\"\"}','{\"enabled\":\"0\",\"show_date\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(20,'com_templates','component','com_templates','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_templates\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_TEMPLATES_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(21,'com_weblinks','component','com_weblinks','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_weblinks\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_comp_description\":\"1\",\"comp_description\":\"\",\"show_link_hits\":\"1\",\"show_link_description\":\"1\",\"show_other_cats\":\"0\",\"show_headings\":\"0\",\"show_numbers\":\"0\",\"show_report\":\"1\",\"count_clicks\":\"1\",\"target\":\"0\",\"link_icons\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(22,'com_content','component','com_content','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_content\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}','{\"article_layout\":\"_:default\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"1\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"1\",\"show_item_navigation\":\"1\",\"show_vote\":\"0\",\"show_readmore\":\"1\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"100\",\"show_icons\":\"1\",\"show_print_icon\":\"1\",\"show_email_icon\":\"1\",\"show_hits\":\"1\",\"show_noauth\":\"0\",\"show_publishing_options\":\"1\",\"show_article_options\":\"1\",\"show_urls_images_frontend\":\"0\",\"show_urls_images_backend\":\"1\",\"targeta\":0,\"targetb\":0,\"targetc\":0,\"float_intro\":\"left\",\"float_fulltext\":\"left\",\"category_layout\":\"_:blog\",\"show_category_title\":\"0\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"maxLevel\":\"1\",\"show_empty_categories\":\"0\",\"show_no_articles\":\"1\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"0\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"1\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"0\",\"show_subcategory_content\":\"0\",\"show_pagination_limit\":\"1\",\"filter_field\":\"hide\",\"show_headings\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"1\",\"list_show_author\":\"1\",\"orderby_pri\":\"order\",\"orderby_sec\":\"rdate\",\"order_date\":\"published\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_feed_link\":\"1\",\"feed_summary\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(23,'com_config','component','com_config','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_config\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CONFIG_XML_DESCRIPTION\",\"group\":\"\"}','{\"filters\":{\"1\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"6\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"7\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"2\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"3\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"4\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"5\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"10\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"12\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"8\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"}}}','','',0,'0000-00-00 00:00:00',0,0),(24,'com_redirect','component','com_redirect','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_redirect\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(25,'com_users','component','com_users','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_users\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_USERS_XML_DESCRIPTION\",\"group\":\"\"}','{\"allowUserRegistration\":\"1\",\"new_usertype\":\"2\",\"guest_usergroup\":\"1\",\"sendpassword\":\"1\",\"useractivation\":\"2\",\"mail_to_admin\":\"1\",\"captcha\":\"\",\"frontend_userparams\":\"1\",\"site_language\":\"0\",\"change_login_name\":\"0\",\"reset_count\":\"10\",\"reset_time\":\"1\",\"mailSubjectPrefix\":\"\",\"mailBodySuffix\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(27,'com_finder','component','com_finder','',1,1,0,0,'{\"legacy\":false,\"name\":\"com_finder\",\"type\":\"component\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_FINDER_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_description\":\"1\",\"description_length\":255,\"allow_empty_query\":\"0\",\"show_url\":\"1\",\"show_advanced\":\"1\",\"expand_advanced\":\"0\",\"show_date_filters\":\"0\",\"highlight_terms\":\"1\",\"opensearch_name\":\"\",\"opensearch_description\":\"\",\"batch_size\":\"50\",\"memory_table_limit\":30000,\"title_multiplier\":\"1.7\",\"text_multiplier\":\"0.7\",\"meta_multiplier\":\"1.2\",\"path_multiplier\":\"2.0\",\"misc_multiplier\":\"0.3\",\"stemmer\":\"snowball\"}','','',0,'0000-00-00 00:00:00',0,0),(28,'com_joomlaupdate','component','com_joomlaupdate','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_joomlaupdate\",\"type\":\"component\",\"creationDate\":\"February 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(100,'PHPMailer','library','phpmailer','',0,1,1,1,'{\"legacy\":false,\"name\":\"PHPMailer\",\"type\":\"library\",\"creationDate\":\"2001\",\"author\":\"PHPMailer\",\"copyright\":\"(c) 2001-2003, Brent R. Matzelle, (c) 2004-2009, Andy Prevost. All Rights Reserved., (c) 2010-2011, Jim Jagielski. All Rights Reserved.\",\"authorEmail\":\"jimjag@gmail.com\",\"authorUrl\":\"https:\\/\\/code.google.com\\/a\\/apache-extras.org\\/p\\/phpmailer\\/\",\"version\":\"5.2\",\"description\":\"LIB_PHPMAILER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(101,'SimplePie','library','simplepie','',0,1,1,1,'{\"legacy\":false,\"name\":\"SimplePie\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"SimplePie\",\"copyright\":\"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/simplepie.org\\/\",\"version\":\"1.2\",\"description\":\"LIB_SIMPLEPIE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(102,'phputf8','library','phputf8','',0,1,1,1,'{\"legacy\":false,\"name\":\"phputf8\",\"type\":\"library\",\"creationDate\":\"2006\",\"author\":\"Harry Fuecks\",\"copyright\":\"Copyright various authors\",\"authorEmail\":\"hfuecks@gmail.com\",\"authorUrl\":\"http:\\/\\/sourceforge.net\\/projects\\/phputf8\",\"version\":\"0.5\",\"description\":\"LIB_PHPUTF8_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(103,'Joomla! Platform','library','joomla','',0,1,1,1,'{\"legacy\":false,\"name\":\"Joomla! Platform\",\"type\":\"library\",\"creationDate\":\"2008\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"http:\\/\\/www.joomla.org\",\"version\":\"11.4\",\"description\":\"LIB_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(200,'mod_articles_archive','module','mod_articles_archive','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_archive\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters.\\n\\t\\tAll rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(201,'mod_articles_latest','module','mod_articles_latest','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LATEST_NEWS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(202,'mod_articles_popular','module','mod_articles_popular','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_articles_popular\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(203,'mod_banners','module','mod_banners','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_banners\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_BANNERS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(204,'mod_breadcrumbs','module','mod_breadcrumbs','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_breadcrumbs\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_BREADCRUMBS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(205,'mod_custom','module','mod_custom','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(206,'mod_feed','module','mod_feed','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(207,'mod_footer','module','mod_footer','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_footer\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FOOTER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(208,'mod_login','module','mod_login','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(209,'mod_menu','module','mod_menu','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(210,'mod_articles_news','module','mod_articles_news','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_articles_news\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_NEWS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(211,'mod_random_image','module','mod_random_image','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_random_image\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_RANDOM_IMAGE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(212,'mod_related_items','module','mod_related_items','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_related_items\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_RELATED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(213,'mod_search','module','mod_search','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_search\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_SEARCH_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(214,'mod_stats','module','mod_stats','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_stats\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(215,'mod_syndicate','module','mod_syndicate','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_syndicate\",\"type\":\"module\",\"creationDate\":\"May 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_SYNDICATE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(216,'mod_users_latest','module','mod_users_latest','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_users_latest\",\"type\":\"module\",\"creationDate\":\"December 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_USERS_LATEST_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(217,'mod_weblinks','module','mod_weblinks','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_weblinks\",\"type\":\"module\",\"creationDate\":\"July 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(218,'mod_whosonline','module','mod_whosonline','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_whosonline\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_WHOSONLINE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(219,'mod_wrapper','module','mod_wrapper','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_wrapper\",\"type\":\"module\",\"creationDate\":\"October 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_WRAPPER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(220,'mod_articles_category','module','mod_articles_category','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_category\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(221,'mod_articles_categories','module','mod_articles_categories','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_categories\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(222,'mod_languages','module','mod_languages','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_languages\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(223,'mod_finder','module','mod_finder','',0,1,0,0,'{\"legacy\":false,\"name\":\"mod_finder\",\"type\":\"module\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FINDER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(300,'mod_custom','module','mod_custom','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(301,'mod_feed','module','mod_feed','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(302,'mod_latest','module','mod_latest','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LATEST_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(303,'mod_logged','module','mod_logged','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_logged\",\"type\":\"module\",\"creationDate\":\"January 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LOGGED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(304,'mod_login','module','mod_login','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"March 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(305,'mod_menu','module','mod_menu','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(307,'mod_popular','module','mod_popular','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_popular\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(308,'mod_quickicon','module','mod_quickicon','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_quickicon\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_QUICKICON_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(309,'mod_status','module','mod_status','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_status\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_STATUS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(310,'mod_submenu','module','mod_submenu','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_submenu\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_SUBMENU_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(311,'mod_title','module','mod_title','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_title\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_TITLE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(312,'mod_toolbar','module','mod_toolbar','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_toolbar\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_TOOLBAR_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(313,'mod_multilangstatus','module','mod_multilangstatus','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_multilangstatus\",\"type\":\"module\",\"creationDate\":\"September 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_MULTILANGSTATUS_XML_DESCRIPTION\",\"group\":\"\"}','{\"cache\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(314,'mod_version','module','mod_version','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_version\",\"type\":\"module\",\"creationDate\":\"January 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_VERSION_XML_DESCRIPTION\",\"group\":\"\"}','{\"format\":\"short\",\"product\":\"1\",\"cache\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(400,'plg_authentication_gmail','plugin','gmail','authentication',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_authentication_gmail\",\"type\":\"plugin\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_GMAIL_XML_DESCRIPTION\",\"group\":\"\"}','{\"applysuffix\":\"0\",\"suffix\":\"\",\"verifypeer\":\"1\",\"user_blacklist\":\"\"}','','',0,'0000-00-00 00:00:00',1,0),(401,'plg_authentication_joomla','plugin','joomla','authentication',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_authentication_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_AUTH_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(402,'plg_authentication_ldap','plugin','ldap','authentication',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_authentication_ldap\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_LDAP_XML_DESCRIPTION\",\"group\":\"\"}','{\"host\":\"\",\"port\":\"389\",\"use_ldapV3\":\"0\",\"negotiate_tls\":\"0\",\"no_referrals\":\"0\",\"auth_method\":\"bind\",\"base_dn\":\"\",\"search_string\":\"\",\"users_dn\":\"\",\"username\":\"admin\",\"password\":\"bobby7\",\"ldap_fullname\":\"fullName\",\"ldap_email\":\"mail\",\"ldap_uid\":\"uid\"}','','',0,'0000-00-00 00:00:00',3,0),(404,'plg_content_emailcloak','plugin','emailcloak','content',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_content_emailcloak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION\",\"group\":\"\"}','{\"mode\":\"1\"}','','',0,'0000-00-00 00:00:00',1,0),(405,'plg_content_geshi','plugin','geshi','content',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_content_geshi\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"qbnz.com\\/highlighter\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_GESHI_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(406,'plg_content_loadmodule','plugin','loadmodule','content',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_content_loadmodule\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_LOADMODULE_XML_DESCRIPTION\",\"group\":\"\"}','{\"style\":\"xhtml\"}','','',0,'2011-09-18 15:22:50',0,0),(407,'plg_content_pagebreak','plugin','pagebreak','content',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_content_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\"}','{\"title\":\"1\",\"multipage_toc\":\"1\",\"showall\":\"1\"}','','',0,'0000-00-00 00:00:00',4,0),(408,'plg_content_pagenavigation','plugin','pagenavigation','content',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_content_pagenavigation\",\"type\":\"plugin\",\"creationDate\":\"January 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_PAGENAVIGATION_XML_DESCRIPTION\",\"group\":\"\"}','{\"position\":\"1\"}','','',0,'0000-00-00 00:00:00',5,0),(409,'plg_content_vote','plugin','vote','content',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_content_vote\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_VOTE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',6,0),(410,'plg_editors_codemirror','plugin','codemirror','editors',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors_codemirror\",\"type\":\"plugin\",\"creationDate\":\"28 March 2011\",\"author\":\"Marijn Haverbeke\",\"copyright\":\"\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"PLG_CODEMIRROR_XML_DESCRIPTION\",\"group\":\"\"}','{\"linenumbers\":\"0\",\"tabmode\":\"indent\"}','','',0,'0000-00-00 00:00:00',1,0),(411,'plg_editors_none','plugin','none','editors',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors_none\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Unknown\",\"copyright\":\"\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"\",\"version\":\"2.5.0\",\"description\":\"PLG_NONE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(412,'plg_editors_tinymce','plugin','tinymce','editors',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors_tinymce\",\"type\":\"plugin\",\"creationDate\":\"2005-2014\",\"author\":\"Moxiecode Systems AB\",\"copyright\":\"Moxiecode Systems AB\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"tinymce.moxiecode.com\\/\",\"version\":\"3.5.11\",\"description\":\"PLG_TINY_XML_DESCRIPTION\",\"group\":\"\"}','{\"mode\":\"1\",\"skin\":\"0\",\"entity_encoding\":\"raw\",\"lang_mode\":\"0\",\"lang_code\":\"en\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"extended_elements\":\"\",\"toolbar\":\"top\",\"toolbar_align\":\"left\",\"html_height\":\"550\",\"html_width\":\"750\",\"resizing\":\"true\",\"resize_horizontal\":\"false\",\"element_path\":\"1\",\"fonts\":\"1\",\"paste\":\"1\",\"searchreplace\":\"1\",\"insertdate\":\"1\",\"format_date\":\"%Y-%m-%d\",\"inserttime\":\"1\",\"format_time\":\"%H:%M:%S\",\"colors\":\"1\",\"table\":\"1\",\"smilies\":\"1\",\"media\":\"1\",\"hr\":\"1\",\"directionality\":\"1\",\"fullscreen\":\"1\",\"style\":\"1\",\"layer\":\"1\",\"xhtmlxtras\":\"1\",\"visualchars\":\"1\",\"nonbreaking\":\"1\",\"template\":\"1\",\"blockquote\":\"1\",\"wordcount\":\"1\",\"advimage\":\"1\",\"advlink\":\"1\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"inlinepopups\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"}','','',0,'0000-00-00 00:00:00',3,0),(413,'plg_editors-xtd_article','plugin','article','editors-xtd',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors-xtd_article\",\"type\":\"plugin\",\"creationDate\":\"October 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_ARTICLE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(414,'plg_editors-xtd_image','plugin','image','editors-xtd',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_editors-xtd_image\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_IMAGE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(415,'plg_editors-xtd_pagebreak','plugin','pagebreak','editors-xtd',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_editors-xtd_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',3,0),(416,'plg_editors-xtd_readmore','plugin','readmore','editors-xtd',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_editors-xtd_readmore\",\"type\":\"plugin\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_READMORE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',4,0),(417,'plg_search_categories','plugin','categories','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_categories\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(418,'plg_search_contacts','plugin','contacts','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_contacts\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_CONTACTS_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(419,'plg_search_content','plugin','content','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_content\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(420,'plg_search_newsfeeds','plugin','newsfeeds','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(421,'plg_search_weblinks','plugin','weblinks','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_weblinks\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(422,'plg_system_languagefilter','plugin','languagefilter','system',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_system_languagefilter\",\"type\":\"plugin\",\"creationDate\":\"July 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(423,'plg_system_p3p','plugin','p3p','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_p3p\",\"type\":\"plugin\",\"creationDate\":\"September 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_P3P_XML_DESCRIPTION\",\"group\":\"\"}','{\"headers\":\"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM\"}','','',0,'0000-00-00 00:00:00',2,0),(424,'plg_system_cache','plugin','cache','system',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_system_cache\",\"type\":\"plugin\",\"creationDate\":\"February 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CACHE_XML_DESCRIPTION\",\"group\":\"\"}','{\"browsercache\":\"0\",\"cachetime\":\"15\"}','','',0,'0000-00-00 00:00:00',9,0),(425,'plg_system_debug','plugin','debug','system',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_system_debug\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_DEBUG_XML_DESCRIPTION\",\"group\":\"\"}','{\"profile\":\"1\",\"queries\":\"1\",\"memory\":\"1\",\"language_files\":\"1\",\"language_strings\":\"1\",\"strip-first\":\"1\",\"strip-prefix\":\"\",\"strip-suffix\":\"\"}','','',0,'0000-00-00 00:00:00',4,0),(426,'plg_system_log','plugin','log','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_log\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_LOG_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',5,0),(427,'plg_system_redirect','plugin','redirect','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_redirect\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',6,0),(428,'plg_system_remember','plugin','remember','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_remember\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_REMEMBER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',7,0),(429,'plg_system_sef','plugin','sef','system',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_system_sef\",\"type\":\"plugin\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEF_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',8,0),(430,'plg_system_logout','plugin','logout','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_logout\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',3,0),(431,'plg_user_contactcreator','plugin','contactcreator','user',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_user_contactcreator\",\"type\":\"plugin\",\"creationDate\":\"August 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTACTCREATOR_XML_DESCRIPTION\",\"group\":\"\"}','{\"autowebpage\":\"\",\"category\":\"34\",\"autopublish\":\"0\"}','','',0,'0000-00-00 00:00:00',1,0),(432,'plg_user_joomla','plugin','joomla','user',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_user_joomla\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2009 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_USER_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{\"autoregister\":\"1\"}','','',0,'0000-00-00 00:00:00',2,0),(433,'plg_user_profile','plugin','profile','user',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_user_profile\",\"type\":\"plugin\",\"creationDate\":\"January 2008\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_USER_PROFILE_XML_DESCRIPTION\",\"group\":\"\"}','{\"register-require_address1\":\"1\",\"register-require_address2\":\"1\",\"register-require_city\":\"1\",\"register-require_region\":\"1\",\"register-require_country\":\"1\",\"register-require_postal_code\":\"1\",\"register-require_phone\":\"1\",\"register-require_website\":\"1\",\"register-require_favoritebook\":\"1\",\"register-require_aboutme\":\"1\",\"register-require_tos\":\"1\",\"register-require_dob\":\"1\",\"profile-require_address1\":\"1\",\"profile-require_address2\":\"1\",\"profile-require_city\":\"1\",\"profile-require_region\":\"1\",\"profile-require_country\":\"1\",\"profile-require_postal_code\":\"1\",\"profile-require_phone\":\"1\",\"profile-require_website\":\"1\",\"profile-require_favoritebook\":\"1\",\"profile-require_aboutme\":\"1\",\"profile-require_tos\":\"1\",\"profile-require_dob\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(434,'plg_extension_joomla','plugin','joomla','extension',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_extension_joomla\",\"type\":\"plugin\",\"creationDate\":\"May 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(435,'plg_content_joomla','plugin','joomla','content',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_content_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(436,'plg_system_languagecode','plugin','languagecode','system',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_system_languagecode\",\"type\":\"plugin\",\"creationDate\":\"November 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',10,0),(437,'plg_quickicon_joomlaupdate','plugin','joomlaupdate','quickicon',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_quickicon_joomlaupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(438,'plg_quickicon_extensionupdate','plugin','extensionupdate','quickicon',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_quickicon_extensionupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(439,'plg_captcha_recaptcha','plugin','recaptcha','captcha',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_captcha_recaptcha\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION\",\"group\":\"\"}','{\"public_key\":\"\",\"private_key\":\"\",\"theme\":\"clean\"}','','',0,'0000-00-00 00:00:00',0,0),(440,'plg_system_highlight','plugin','highlight','system',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_system_highlight\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',7,0),(441,'plg_content_finder','plugin','finder','content',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_content_finder\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_FINDER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(442,'plg_finder_categories','plugin','categories','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_categories\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(443,'plg_finder_contacts','plugin','contacts','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_contacts\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_CONTACTS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(444,'plg_finder_content','plugin','content','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_content\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',3,0),(445,'plg_finder_newsfeeds','plugin','newsfeeds','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',4,0),(446,'plg_finder_weblinks','plugin','weblinks','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_weblinks\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',5,0),(500,'atomic','template','atomic','',0,1,1,0,'{\"legacy\":false,\"name\":\"atomic\",\"type\":\"template\",\"creationDate\":\"10\\/10\\/09\",\"author\":\"Ron Severdia\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"contact@kontentdesign.com\",\"authorUrl\":\"http:\\/\\/www.kontentdesign.com\",\"version\":\"2.5.0\",\"description\":\"TPL_ATOMIC_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(502,'bluestork','template','bluestork','',1,1,1,0,'{\"legacy\":false,\"name\":\"bluestork\",\"type\":\"template\",\"creationDate\":\"07\\/02\\/09\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"TPL_BLUESTORK_XML_DESCRIPTION\",\"group\":\"\"}','{\"useRoundedCorners\":\"1\",\"showSiteName\":\"0\",\"textBig\":\"0\",\"highContrast\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(503,'beez_20','template','beez_20','',0,1,1,0,'{\"legacy\":false,\"name\":\"beez_20\",\"type\":\"template\",\"creationDate\":\"25 November 2009\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"2.5.0\",\"description\":\"TPL_BEEZ2_XML_DESCRIPTION\",\"group\":\"\"}','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"templatecolor\":\"nature\"}','','',0,'0000-00-00 00:00:00',0,0),(504,'hathor','template','hathor','',1,1,1,0,'{\"legacy\":false,\"name\":\"hathor\",\"type\":\"template\",\"creationDate\":\"May 2010\",\"author\":\"Andrea Tarr\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"hathor@tarrconsulting.com\",\"authorUrl\":\"http:\\/\\/www.tarrconsulting.com\",\"version\":\"2.5.0\",\"description\":\"TPL_HATHOR_XML_DESCRIPTION\",\"group\":\"\"}','{\"showSiteName\":\"0\",\"colourChoice\":\"0\",\"boldText\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(505,'beez5','template','beez5','',0,1,1,0,'{\"legacy\":false,\"name\":\"beez5\",\"type\":\"template\",\"creationDate\":\"21 May 2010\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"2.5.0\",\"description\":\"TPL_BEEZ5_XML_DESCRIPTION\",\"group\":\"\"}','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"html5\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(600,'English (United Kingdom)','language','en-GB','',0,1,1,1,'{\"legacy\":false,\"name\":\"English (United Kingdom)\",\"type\":\"language\",\"creationDate\":\"2008-03-15\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.28\",\"description\":\"en-GB site language\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(601,'English (United Kingdom)','language','en-GB','',1,1,1,1,'{\"legacy\":false,\"name\":\"English (United Kingdom)\",\"type\":\"language\",\"creationDate\":\"2008-03-15\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.28\",\"description\":\"en-GB administrator language\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(700,'files_joomla','file','joomla','',0,1,1,1,'{\"legacy\":false,\"name\":\"files_joomla\",\"type\":\"file\",\"creationDate\":\"December 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.28\",\"description\":\"FILES_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(800,'PKG_JOOMLA','package','pkg_joomla','',0,1,1,1,'{\"legacy\":false,\"name\":\"PKG_JOOMLA\",\"type\":\"package\",\"creationDate\":\"2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"http:\\/\\/www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PKG_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(900,'PLG_EOSNOTIFY','plugin','eosnotify','quickicon',0,1,1,1,'{\"legacy\":false,\"name\":\"PLG_EOSNOTIFY\",\"type\":\"plugin\",\"creationDate\":\"October 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"End of Support Notifier\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0);
/*!40000 ALTER TABLE `bak_qm_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_filters`
--

DROP TABLE IF EXISTS `bak_qm_finder_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_filters` (
  `filter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL,
  `created_by_alias` varchar(255) NOT NULL,
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `map_count` int(10) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_filters`
--

LOCK TABLES `bak_qm_finder_filters` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links`
--

DROP TABLE IF EXISTS `bak_qm_finder_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `indexdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `state` int(5) DEFAULT '1',
  `access` int(5) DEFAULT '0',
  `language` varchar(8) NOT NULL,
  `publish_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `list_price` double unsigned NOT NULL DEFAULT '0',
  `sale_price` double unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `object` mediumblob NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links`
--

LOCK TABLES `bak_qm_finder_links` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms0`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms0`
--

LOCK TABLES `bak_qm_finder_links_terms0` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms0` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms1`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms1`
--

LOCK TABLES `bak_qm_finder_links_terms1` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms1` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms2`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms2`
--

LOCK TABLES `bak_qm_finder_links_terms2` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms2` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms3`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms3`
--

LOCK TABLES `bak_qm_finder_links_terms3` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms3` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms4`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms4`
--

LOCK TABLES `bak_qm_finder_links_terms4` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms4` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms5`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms5`
--

LOCK TABLES `bak_qm_finder_links_terms5` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms5` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms6`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms6`
--

LOCK TABLES `bak_qm_finder_links_terms6` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms6` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms7`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms7`
--

LOCK TABLES `bak_qm_finder_links_terms7` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms7` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms8`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms8`
--

LOCK TABLES `bak_qm_finder_links_terms8` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms8` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_terms9`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_terms9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_terms9`
--

LOCK TABLES `bak_qm_finder_links_terms9` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms9` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_terms9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_termsa`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_termsa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_termsa`
--

LOCK TABLES `bak_qm_finder_links_termsa` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsa` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_termsb`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_termsb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_termsb`
--

LOCK TABLES `bak_qm_finder_links_termsb` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsb` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_termsc`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_termsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_termsc`
--

LOCK TABLES `bak_qm_finder_links_termsc` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_termsd`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_termsd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_termsd`
--

LOCK TABLES `bak_qm_finder_links_termsd` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsd` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_termse`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_termse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_termse`
--

LOCK TABLES `bak_qm_finder_links_termse` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_termse` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_termse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_links_termsf`
--

DROP TABLE IF EXISTS `bak_qm_finder_links_termsf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_links_termsf`
--

LOCK TABLES `bak_qm_finder_links_termsf` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsf` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_links_termsf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_taxonomy`
--

DROP TABLE IF EXISTS `bak_qm_finder_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_taxonomy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `access` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `state` (`state`),
  KEY `ordering` (`ordering`),
  KEY `access` (`access`),
  KEY `idx_parent_published` (`parent_id`,`state`,`access`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_taxonomy`
--

LOCK TABLES `bak_qm_finder_taxonomy` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_taxonomy` DISABLE KEYS */;
INSERT INTO `bak_qm_finder_taxonomy` VALUES (1,0,'ROOT',0,0,0);
/*!40000 ALTER TABLE `bak_qm_finder_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_taxonomy_map`
--

DROP TABLE IF EXISTS `bak_qm_finder_taxonomy_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_taxonomy_map`
--

LOCK TABLES `bak_qm_finder_taxonomy_map` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_taxonomy_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_taxonomy_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_terms`
--

DROP TABLE IF EXISTS `bak_qm_finder_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '0',
  `soundex` varchar(75) NOT NULL,
  `links` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term` (`term`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_terms`
--

LOCK TABLES `bak_qm_finder_terms` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_terms_common`
--

DROP TABLE IF EXISTS `bak_qm_finder_terms_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_terms_common`
--

LOCK TABLES `bak_qm_finder_terms_common` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_terms_common` DISABLE KEYS */;
INSERT INTO `bak_qm_finder_terms_common` VALUES ('a','en'),('about','en'),('after','en'),('ago','en'),('all','en'),('am','en'),('an','en'),('and','en'),('ani','en'),('any','en'),('are','en'),('aren\'t','en'),('as','en'),('at','en'),('be','en'),('but','en'),('by','en'),('for','en'),('from','en'),('get','en'),('go','en'),('how','en'),('if','en'),('in','en'),('into','en'),('is','en'),('isn\'t','en'),('it','en'),('its','en'),('me','en'),('more','en'),('most','en'),('must','en'),('my','en'),('new','en'),('no','en'),('none','en'),('not','en'),('noth','en'),('nothing','en'),('of','en'),('off','en'),('often','en'),('old','en'),('on','en'),('onc','en'),('once','en'),('onli','en'),('only','en'),('or','en'),('other','en'),('our','en'),('ours','en'),('out','en'),('over','en'),('page','en'),('she','en'),('should','en'),('small','en'),('so','en'),('some','en'),('than','en'),('thank','en'),('that','en'),('the','en'),('their','en'),('theirs','en'),('them','en'),('then','en'),('there','en'),('these','en'),('they','en'),('this','en'),('those','en'),('thus','en'),('time','en'),('times','en'),('to','en'),('too','en'),('true','en'),('under','en'),('until','en'),('up','en'),('upon','en'),('use','en'),('user','en'),('users','en'),('veri','en'),('version','en'),('very','en'),('via','en'),('want','en'),('was','en'),('way','en'),('were','en'),('what','en'),('when','en'),('where','en'),('whi','en'),('which','en'),('who','en'),('whom','en'),('whose','en'),('why','en'),('wide','en'),('will','en'),('with','en'),('within','en'),('without','en'),('would','en'),('yes','en'),('yet','en'),('you','en'),('your','en'),('yours','en');
/*!40000 ALTER TABLE `bak_qm_finder_terms_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_tokens`
--

DROP TABLE IF EXISTS `bak_qm_finder_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_tokens` (
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '1',
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  KEY `idx_word` (`term`),
  KEY `idx_context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_tokens`
--

LOCK TABLES `bak_qm_finder_tokens` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_tokens_aggregate`
--

DROP TABLE IF EXISTS `bak_qm_finder_tokens_aggregate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_tokens_aggregate` (
  `term_id` int(10) unsigned NOT NULL,
  `map_suffix` char(1) NOT NULL,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `term_weight` float unsigned NOT NULL,
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `context_weight` float unsigned NOT NULL,
  `total_weight` float unsigned NOT NULL,
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_tokens_aggregate`
--

LOCK TABLES `bak_qm_finder_tokens_aggregate` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_tokens_aggregate` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_tokens_aggregate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_finder_types`
--

DROP TABLE IF EXISTS `bak_qm_finder_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_finder_types`
--

LOCK TABLES `bak_qm_finder_types` WRITE;
/*!40000 ALTER TABLE `bak_qm_finder_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_finder_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_languages`
--

DROP TABLE IF EXISTS `bak_qm_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_languages` (
  `lang_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `sef` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `sitename` varchar(1024) NOT NULL DEFAULT '',
  `published` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  UNIQUE KEY `idx_sef` (`sef`),
  UNIQUE KEY `idx_image` (`image`),
  UNIQUE KEY `idx_langcode` (`lang_code`),
  KEY `idx_access` (`access`),
  KEY `idx_ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_languages`
--

LOCK TABLES `bak_qm_languages` WRITE;
/*!40000 ALTER TABLE `bak_qm_languages` DISABLE KEYS */;
INSERT INTO `bak_qm_languages` VALUES (1,'en-GB','English (UK)','English (UK)','en','en','','','','',1,1,1);
/*!40000 ALTER TABLE `bak_qm_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_menu`
--

DROP TABLE IF EXISTS `bak_qm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `ordering` int(11) NOT NULL DEFAULT '0' COMMENT 'The relative ordering of the menu item in the tree.',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`,`language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(255)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=468 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_menu`
--

LOCK TABLES `bak_qm_menu` WRITE;
/*!40000 ALTER TABLE `bak_qm_menu` DISABLE KEYS */;
INSERT INTO `bak_qm_menu` VALUES (1,'','Menu_Item_Root','root','','','','',1,0,0,0,0,0,'0000-00-00 00:00:00',0,0,'',0,'',0,283,0,'*',0),(2,'menu','com_banners','Banners','','Banners','index.php?option=com_banners','component',0,1,1,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners',0,'',13,22,0,'*',1),(3,'menu','com_banners','Banners','','Banners/Banners','index.php?option=com_banners','component',0,2,2,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners',0,'',14,15,0,'*',1),(4,'menu','com_banners_categories','Categories','','Banners/Categories','index.php?option=com_categories&extension=com_banners','component',0,2,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:banners-cat',0,'',16,17,0,'*',1),(5,'menu','com_banners_clients','Clients','','Banners/Clients','index.php?option=com_banners&view=clients','component',0,2,2,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners-clients',0,'',18,19,0,'*',1),(6,'menu','com_banners_tracks','Tracks','','Banners/Tracks','index.php?option=com_banners&view=tracks','component',0,2,2,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners-tracks',0,'',20,21,0,'*',1),(7,'menu','com_contact','Contacts','','Contacts','index.php?option=com_contact','component',0,1,1,8,0,0,'0000-00-00 00:00:00',0,0,'class:contact',0,'',23,28,0,'*',1),(8,'menu','com_contact','Contacts','','Contacts/Contacts','index.php?option=com_contact','component',0,7,2,8,0,0,'0000-00-00 00:00:00',0,0,'class:contact',0,'',24,25,0,'*',1),(9,'menu','com_contact_categories','Categories','','Contacts/Categories','index.php?option=com_categories&extension=com_contact','component',0,7,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:contact-cat',0,'',26,27,0,'*',1),(10,'menu','com_messages','Messaging','','Messaging','index.php?option=com_messages','component',0,1,1,15,0,0,'0000-00-00 00:00:00',0,0,'class:messages',0,'',29,34,0,'*',1),(11,'menu','com_messages_add','New Private Message','','Messaging/New Private Message','index.php?option=com_messages&task=message.add','component',0,10,2,15,0,0,'0000-00-00 00:00:00',0,0,'class:messages-add',0,'',30,31,0,'*',1),(12,'menu','com_messages_read','Read Private Message','','Messaging/Read Private Message','index.php?option=com_messages','component',0,10,2,15,0,0,'0000-00-00 00:00:00',0,0,'class:messages-read',0,'',32,33,0,'*',1),(13,'menu','com_newsfeeds','News Feeds','','News Feeds','index.php?option=com_newsfeeds','component',0,1,1,17,0,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds',0,'',35,40,0,'*',1),(14,'menu','com_newsfeeds_feeds','Feeds','','News Feeds/Feeds','index.php?option=com_newsfeeds','component',0,13,2,17,0,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds',0,'',36,37,0,'*',1),(15,'menu','com_newsfeeds_categories','Categories','','News Feeds/Categories','index.php?option=com_categories&extension=com_newsfeeds','component',0,13,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds-cat',0,'',38,39,0,'*',1),(16,'menu','com_redirect','Redirect','','Redirect','index.php?option=com_redirect','component',0,1,1,24,0,0,'0000-00-00 00:00:00',0,0,'class:redirect',0,'',53,54,0,'*',1),(17,'menu','com_search','Basic Search','','Basic Search','index.php?option=com_search','component',0,1,1,19,0,0,'0000-00-00 00:00:00',0,0,'class:search',0,'',43,44,0,'*',1),(18,'menu','com_weblinks','Weblinks','','Weblinks','index.php?option=com_weblinks','component',0,1,1,21,0,0,'0000-00-00 00:00:00',0,0,'class:weblinks',0,'',47,52,0,'*',1),(19,'menu','com_weblinks_links','Links','','Weblinks/Links','index.php?option=com_weblinks','component',0,18,2,21,0,0,'0000-00-00 00:00:00',0,0,'class:weblinks',0,'',48,49,0,'*',1),(20,'menu','com_weblinks_categories','Categories','','Weblinks/Categories','index.php?option=com_categories&extension=com_weblinks','component',0,18,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:weblinks-cat',0,'',50,51,0,'*',1),(21,'menu','com_finder','Smart Search','','Smart Search','index.php?option=com_finder','component',0,1,1,27,0,0,'0000-00-00 00:00:00',0,0,'class:finder',0,'',41,42,0,'*',1),(22,'menu','com_joomlaupdate','Joomla! Update','','Joomla! Update','index.php?option=com_joomlaupdate','component',0,1,1,28,0,0,'0000-00-00 00:00:00',0,0,'class:joomlaupdate',0,'',41,42,0,'*',1),(201,'usermenu','Your Profile','your-profile','','your-profile','index.php?option=com_users&view=profile','component',1,1,1,25,0,0,'0000-00-00 00:00:00',0,2,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',237,238,0,'*',0),(207,'top','Joomla.org','joomlaorg','','joomlaorg','http://joomla.org','url',1,1,1,0,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',235,236,0,'*',0),(227,'aboutjoomla','Weblinks Categories','weblinks-categories','','using-joomla/extensions/components/weblinks-component/weblinks-categories','index.php?option=com_weblinks&view=categories&id=18','component',1,265,5,21,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_base_description\":\"\",\"categories_description\":\"\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"\",\"show_subcat_desc_cat\":\"\",\"show_cat_num_links_cat\":\"\",\"show_category_title\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_links\":\"\",\"show_pagination_limit\":\"\",\"show_headings\":\"\",\"show_link_description\":\"\",\"show_link_hits\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',89,90,0,'*',0),(229,'aboutjoomla','Single Contact','single-contact','','using-joomla/extensions/components/contact-component/single-contact','index.php?option=com_contact&view=contact&id=1','component',1,270,5,8,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_category_crumb\":\"\",\"presentation_style\":\"\",\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',79,80,0,'*',0),(233,'mainmenu','Login','login','','login','index.php?option=com_users&view=login','component',1,1,1,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',11,12,0,'*',0),(234,'parks','Park Blog','park-blog','','park-blog','index.php?option=com_content&view=category&layout=blog&id=27','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',114,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"1\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',241,242,0,'en-GB',0),(238,'mainmenu','Sample Sites','sample-sites','','sample-sites','index.php?option=com_content&view=article&id=38','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',265,270,0,'*',0),(242,'parks','Write a Blog Post','write-a-blog-post','','write-a-blog-post','index.php?option=com_content&view=form&layout=edit','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,3,'',114,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',243,244,0,'en-GB',0),(243,'parks','Parks Home','parks-home','','parks-home','index.php?option=com_content&view=article&id=6','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',114,'{\"show_noauth\":\"\",\"show_title\":\"0\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',239,240,0,'en-GB',0),(244,'parks','Image Gallery','image-gallery','','image-gallery','index.php?option=com_content&view=categories&id=28','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',114,'{\"show_base_description\":\"1\",\"categories_description\":\"\",\"maxLevelcat\":\"\",\"show_empty_categories_cat\":\"\",\"show_subcat_desc_cat\":\"\",\"show_cat_num_articles_cat\":\"\",\"drill_down_layout\":\"1\",\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',245,250,0,'en-GB',0),(249,'aboutjoomla','Submit a Weblink','submit-a-weblink','','using-joomla/extensions/components/weblinks-component/submit-a-weblink','index.php?option=com_weblinks&view=form&layout=edit','component',1,265,5,21,0,0,'0000-00-00 00:00:00',0,3,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',85,86,0,'*',0),(251,'aboutjoomla','Contact Categories','contact-categories','','using-joomla/extensions/components/contact-component/contact-categories','index.php?option=com_contact&view=categories&id=16','component',1,270,5,8,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_base_description\":\"\",\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"sliders\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',75,76,0,'*',0),(252,'aboutjoomla','News Feed Categories','new-feed-categories','','using-joomla/extensions/components/news-feeds-component/new-feed-categories','index.php?option=com_newsfeeds&view=categories&id=0','component',1,267,5,17,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_base_description\":\"1\",\"categories_description\":\"Because this links to the root category the \"uncategorised\" category is displayed. \",\"maxLevel\":\"-1\",\"show_empty_categories\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"1\",\"display_num\":\"\",\"show_headings\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',93,94,0,'*',0),(253,'aboutjoomla','News Feed Category','news-feed-category','','using-joomla/extensions/components/news-feeds-component/news-feed-category','index.php?option=com_newsfeeds&view=category&id=17','component',1,267,5,17,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',97,98,0,'*',0),(254,'aboutjoomla','Single News Feed','single-news-feed','','using-joomla/extensions/components/news-feeds-component/single-news-feed','index.php?option=com_newsfeeds&view=newsfeed&id=4','component',1,267,5,17,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',95,96,0,'*',0),(255,'aboutjoomla','Search','search','','using-joomla/extensions/components/search-component/search','index.php?option=com_search&view=search','component',1,276,5,19,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"search_areas\":\"1\",\"show_date\":\"1\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',115,116,0,'*',0),(256,'aboutjoomla','Archived Articles','archived-articles','','using-joomla/extensions/components/content-component/archived-articles','index.php?option=com_content&view=archive','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"orderby_sec\":\"\",\"order_date\":\"\",\"display_num\":\"\",\"filter_field\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_hits\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',69,70,0,'*',0),(257,'aboutjoomla','Single Article','single-article','','using-joomla/extensions/components/content-component/single-article','index.php?option=com_content&view=article&id=6','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',59,60,0,'*',0),(259,'aboutjoomla','Article Category Blog','article-category-blog','','using-joomla/extensions/components/content-component/article-category-blog','index.php?option=com_content&view=category&layout=blog&id=27','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',63,64,0,'*',0),(260,'aboutjoomla','Article Category List','article-category-list','','using-joomla/extensions/components/content-component/article-category-list','index.php?option=com_content&view=category&id=19','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_no_articles\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"alpha\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"display_num\":\"10\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',65,66,0,'*',0),(262,'aboutjoomla','Featured Articles','featured-articles','','using-joomla/extensions/components/content-component/featured-articles','index.php?option=com_content&view=featured','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',67,68,0,'*',0),(263,'aboutjoomla','Submit Article','submit-article','','using-joomla/extensions/components/content-component/submit-article','index.php?option=com_content&view=form&layout=edit','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,3,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',71,72,0,'*',0),(265,'aboutjoomla','Weblinks Component','weblinks-component','','using-joomla/extensions/components/weblinks-component','index.php?option=com_content&view=article&id=54','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',84,91,0,'*',0),(266,'aboutjoomla','Content Component','content-component','','using-joomla/extensions/components/content-component','index.php?option=com_content&view=article&id=10','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',58,73,0,'*',0),(267,'aboutjoomla','News Feeds Component','news-feeds-component','','using-joomla/extensions/components/news-feeds-component','index.php?option=com_content&view=article&id=60','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"Newsfeeds Categories View \",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',92,99,0,'*',0),(268,'aboutjoomla','Components','components','','using-joomla/extensions/components','index.php?option=com_content&view=category&layout=blog&id=21','component',1,277,3,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"num_leading_articles\":\"0\",\"num_intro_articles\":\"7\",\"num_columns\":\"1\",\"num_links\":\"0\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"0\",\"show_pagination_results\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_readmore\":\"\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',57,122,0,'*',0),(270,'aboutjoomla','Contact Component','contact-component','','using-joomla/extensions/components/contact-component','index.php?option=com_content&view=article&id=9','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',74,83,0,'*',0),(271,'aboutjoomla','Users Component','users-component','','using-joomla/extensions/components/users-component','index.php?option=com_content&view=article&id=52','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',100,113,0,'*',0),(272,'aboutjoomla','Article Categories','article-categories','','using-joomla/extensions/components/content-component/article-categories','index.php?option=com_content&view=categories&id=14','component',1,266,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_base_description\":\"\",\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"category_layout\":\"\",\"show_headings\":\"\",\"show_date\":\"\",\"date_format\":\"\",\"filter_field\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',61,62,0,'*',0),(273,'aboutjoomla','Administrator Components','administrator-components','','using-joomla/extensions/components/administrator-components','index.php?option=com_content&view=article&id=1','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',120,121,0,'*',0),(274,'aboutjoomla','Weblinks Single Category','weblinks-single-category','','using-joomla/extensions/components/weblinks-component/weblinks-single-category','index.php?option=com_weblinks&view=category&id=32','component',1,265,5,21,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"orderby_pri\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',87,88,0,'*',0),(275,'aboutjoomla','Contact Single Category','contact-single-category','','using-joomla/extensions/components/contact-component/contact-single-category','index.php?option=com_contact&view=category&catid=26&id=36','component',1,270,5,8,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"20\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"sliders\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',77,78,0,'*',0),(276,'aboutjoomla','Search Components','search-component','','using-joomla/extensions/components/search-component','index.php?option=com_content&view=article&id=39','component',1,268,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',114,119,0,'*',0),(277,'aboutjoomla','Using Extensions','extensions','','using-joomla/extensions','index.php?option=com_content&view=categories&id=20','component',1,280,2,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_base_description\":\"1\",\"categories_description\":\"\",\"maxLevelcat\":\"1\",\"show_empty_categories_cat\":\"1\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"0\",\"drill_down_layout\":\"0\",\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"1\",\"show_empty_categories\":\"1\",\"show_subcat_desc\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',56,221,0,'*',0),(278,'aboutjoomla','The Joomla! Project','the-joomla-project','','the-joomla-project','index.php?option=com_content&view=article&id=48','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"1\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',229,230,0,'*',0),(279,'aboutjoomla','The Joomla! Community','the-joomla-community','','the-joomla-community','index.php?option=com_content&view=article&id=47','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"0\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',231,232,0,'*',0),(280,'aboutjoomla','Using Joomla!','using-joomla','','using-joomla','index.php?option=com_content&view=article&id=53','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_title\":\"1\",\"link_titles\":\"0\",\"show_intro\":\"1\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"show_noauth\":\"0\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',55,226,0,'*',0),(281,'aboutjoomla','Modules','modules','','using-joomla/extensions/modules','index.php?option=com_content&view=category&id=22','component',1,277,3,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"1\",\"show_empty_categories\":\"1\",\"show_no_articles\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"show_pagination_limit\":\"\",\"filter_field\":\"\",\"show_headings\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_vote\":\"\",\"show_readmore\":\"0\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',123,182,0,'*',0),(282,'aboutjoomla','Templates','templates','','using-joomla/extensions/templates','index.php?option=com_content&view=category&id=23','component',1,277,3,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"maxLevel\":\"2\",\"show_empty_categories\":\"1\",\"show_no_articles\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"\",\"page_subheading\":\"\",\"show_pagination_limit\":\"0\",\"filter_field\":\"hide\",\"show_headings\":\"0\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"show_pagination\":\"0\",\"show_pagination_results\":\"\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"Templates\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',183,202,0,'*',0),(283,'aboutjoomla','Languages','languages','','using-joomla/extensions/languages','index.php?option=com_content&view=category&layout=blog&id=24','component',1,277,3,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_category_title\":\"1\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',203,204,0,'*',0),(284,'aboutjoomla','Plugins','plugins','','using-joomla/extensions/plugins','index.php?option=com_content&view=category&layout=blog&id=25','component',1,277,3,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_category_title\":\"1\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"0\",\"num_intro_articles\":\"7\",\"num_columns\":\"1\",\"num_links\":\"0\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',205,220,0,'*',0),(285,'aboutjoomla','Typography Atomic','typography-atomic','','using-joomla/extensions/templates/atomic/typography-atomic','index.php?option=com_content&view=article&id=49','component',1,422,5,22,0,0,'0000-00-00 00:00:00',0,1,'',3,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',197,198,0,'*',0),(290,'mainmenu','Articles','articles','','site-map/articles','index.php?option=com_content&view=categories&id=0','component',1,294,2,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"category_layout\":\"\",\"show_headings\":\"\",\"show_date\":\"\",\"date_format\":\"\",\"filter_field\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',4,5,0,'*',0),(294,'mainmenu','Site Map','site-map','','site-map','index.php?option=com_content&view=article&id=42','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',3,10,0,'*',0),(296,'parks','Park Links','park-links','','park-links','index.php?option=com_weblinks&view=category&id=31','component',1,1,1,21,0,0,'0000-00-00 00:00:00',0,1,'',114,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"0\",\"orderby_pri\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',251,252,0,'en-GB',0),(300,'aboutjoomla','Latest Users','latest-users','','using-joomla/extensions/modules/user-modules/latest-users','index.php?option=com_content&view=article&id=66','component',1,412,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',147,148,0,'*',0),(301,'aboutjoomla','Who\'s Online','whos-online','','using-joomla/extensions/modules/user-modules/whos-online','index.php?option=com_content&view=article&id=56','component',1,412,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',149,150,0,'*',0),(302,'aboutjoomla','Most Read','most-read','','using-joomla/extensions/modules/content-modules/most-read','index.php?option=com_content&view=article&id=30','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',131,132,0,'*',0),(303,'aboutjoomla','Menu','menu','','using-joomla/extensions/modules/navigation-modules/menu','index.php?option=com_content&view=article&id=29','component',1,415,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',125,126,0,'*',0),(304,'aboutjoomla','Statistics','statistics','','using-joomla/extensions/modules/utility-modules/statistics','index.php?option=com_content&view=article&id=44','component',1,414,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',171,172,0,'*',0),(305,'aboutjoomla','Banner','banner','','using-joomla/extensions/modules/display-modules/banner','index.php?option=com_content&view=article&id=7','component',1,413,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',157,158,0,'*',0),(306,'aboutjoomla','Search','search','','using-joomla/extensions/modules/utility-modules/search','index.php?option=com_content&view=article&id=40','component',1,414,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',173,174,0,'*',0),(307,'aboutjoomla','Random Image','random-image','','using-joomla/extensions/modules/display-modules/random-image','index.php?option=com_content&view=article&id=36','component',1,413,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',155,156,0,'*',0),(309,'aboutjoomla','News Flash','news-flash','','using-joomla/extensions/modules/content-modules/news-flash','index.php?option=com_content&view=article&id=31','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',133,134,0,'*',0),(310,'aboutjoomla','Latest Articles','latest-articles','','using-joomla/extensions/modules/content-modules/latest-articles','index.php?option=com_content&view=article&id=27','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',135,136,0,'*',0),(311,'aboutjoomla','Syndicate','syndicate','','using-joomla/extensions/modules/utility-modules/syndicate','index.php?option=com_content&view=article&id=45','component',1,414,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',169,170,0,'*',0),(312,'aboutjoomla','Login','login','','using-joomla/extensions/modules/user-modules/login','index.php?option=com_content&view=article&id=28','component',1,412,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',151,152,0,'*',0),(313,'aboutjoomla','Wrapper','wrapper','','using-joomla/extensions/modules/utility-modules/wrapper','index.php?option=com_content&view=article&id=59','component',1,414,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',177,178,0,'*',0),(316,'aboutjoomla','Home Page Atomic','home-page-atomic','','using-joomla/extensions/templates/atomic/home-page-atomic','index.php?option=com_content&view=featured','component',1,422,5,22,0,0,'0000-00-00 00:00:00',0,1,'',3,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',199,200,0,'*',0),(317,'aboutjoomla','System','system','','using-joomla/extensions/plugins/system','index.php?option=com_content&view=article&id=46','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',218,219,0,'*',0),(318,'aboutjoomla','Authentication','authentication','','using-joomla/extensions/plugins/authentication','index.php?option=com_content&view=article&id=5','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',206,207,0,'*',0),(319,'aboutjoomla','Content','content','','using-joomla/extensions/plugins/content','index.php?option=com_content&view=article&id=62','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',208,209,0,'*',0),(320,'aboutjoomla','Editors','editors','','using-joomla/extensions/plugins/editors','index.php?option=com_content&view=article&id=14','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',210,211,0,'*',0),(321,'aboutjoomla','Editors Extended','editors-extended','','using-joomla/extensions/plugins/editors-extended','index.php?option=com_content&view=article&id=15','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',212,213,0,'*',0),(322,'aboutjoomla','Search','search','','using-joomla/extensions/plugins/search','index.php?option=com_content&view=article&id=41','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',214,215,0,'*',0),(323,'aboutjoomla','User','user','','using-joomla/extensions/plugins/user','index.php?option=com_content&view=article&id=51','component',1,284,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',216,217,0,'*',0),(324,'aboutjoomla','Footer','footer','','using-joomla/extensions/modules/display-modules/footer','index.php?option=com_content&view=article&id=19','component',1,413,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',161,162,0,'*',0),(325,'aboutjoomla','Archive','archive','','using-joomla/extensions/modules/content-modules/archive','index.php?option=com_content&view=article&id=2','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',137,138,0,'*',0),(326,'aboutjoomla','Related Items','related-items','','using-joomla/extensions/modules/content-modules/related-items','index.php?option=com_content&view=article&id=37','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',139,140,0,'*',0),(399,'parks','Animals','animals','','image-gallery/animals','index.php?option=com_content&view=category&layout=blog&id=72','component',1,244,2,22,0,0,'0000-00-00 00:00:00',0,1,'',114,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"0\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"0\",\"num_intro_articles\":\"6\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"0\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"1\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',246,247,0,'en-GB',0),(400,'parks','Scenery','scenery','','image-gallery/scenery','index.php?option=com_content&view=category&layout=blog&id=73','component',1,244,2,22,0,0,'0000-00-00 00:00:00',0,1,'',114,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"0\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"0\",\"show_category\":\"1\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"1\",\"show_readmore\":\"1\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',248,249,0,'en-GB',0),(402,'aboutjoomla','Login Form','login-form','','using-joomla/extensions/components/users-component/login-form','index.php?option=com_users&view=login','component',1,271,5,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"login_redirect_url\":\"\",\"logindescription_show\":\"1\",\"login_description\":\"\",\"login_image\":\"\",\"logout_redirect_url\":\"\",\"logoutdescription_show\":\"1\",\"logout_description\":\"\",\"logout_image\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',101,102,0,'*',0),(403,'aboutjoomla','User Profile','user-profile','','using-joomla/extensions/components/users-component/user-profile','index.php?option=com_users&view=profile','component',1,271,5,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',103,104,0,'*',0),(404,'aboutjoomla','Edit User Profile','edit-user-profile','','using-joomla/extensions/components/users-component/edit-user-profile','index.php?option=com_users&view=profile&layout=edit','component',1,271,5,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',105,106,0,'*',0),(405,'aboutjoomla','Registration Form','registration-form','','using-joomla/extensions/components/users-component/registration-form','index.php?option=com_users&view=registration','component',1,271,5,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',107,108,0,'*',0),(406,'aboutjoomla','Username Reminder Request','username-reminder','','using-joomla/extensions/components/users-component/username-reminder','index.php?option=com_users&view=remind','component',1,271,5,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',109,110,0,'*',0),(409,'aboutjoomla','Password Reset','password-reset','','using-joomla/extensions/components/users-component/password-reset','index.php?option=com_users&view=reset','component',1,271,5,25,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',111,112,0,'*',0),(410,'aboutjoomla','Feed Display','feed-display','','using-joomla/extensions/modules/display-modules/feed-display','index.php?option=com_content&view=article&id=16','component',1,413,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',159,160,0,'*',0),(411,'aboutjoomla','Content Modules','content-modules','','using-joomla/extensions/modules/content-modules','index.php?option=com_content&view=category&id=64','component',1,281,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"hide\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',130,145,0,'*',0),(412,'aboutjoomla','User Modules','user-modules','','using-joomla/extensions/modules/user-modules','index.php?option=com_content&view=category&id=65','component',1,281,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"1\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"hide\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',146,153,0,'*',0),(413,'aboutjoomla','Display Modules','display-modules','','using-joomla/extensions/modules/display-modules','index.php?option=com_content&view=category&id=66','component',1,281,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"1\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"hide\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',154,167,0,'*',0),(414,'aboutjoomla','Utility Modules','utility-modules','','using-joomla/extensions/modules/utility-modules','index.php?option=com_content&view=category&id=67','component',1,281,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"show_cat_num_articles\":\"\",\"display_num\":\"0\",\"show_headings\":\"0\",\"list_show_title\":\"0\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"0\",\"list_show_author\":\"0\",\"filter_field\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"order\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"0\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',168,181,0,'*',0),(415,'aboutjoomla','Navigation Modules','navigation-modules','','using-joomla/extensions/modules/navigation-modules','index.php?option=com_content&view=category&id=75','component',1,281,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_category_title\":\"\",\"page_subheading\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"list_show_title\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"filter_field\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',124,129,0,'*',0),(416,'aboutjoomla','Breadcrumbs','breadcrumbs','','using-joomla/extensions/modules/navigation-modules/breadcrumbs','index.php?option=com_content&view=article&id=61','component',1,415,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',127,128,0,'*',0),(417,'aboutjoomla','Weblinks','weblinks','','using-joomla/extensions/modules/display-modules/weblinks','index.php?option=com_content&view=article&id=55','component',1,413,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',163,164,0,'*',0),(418,'aboutjoomla','Custom HTML','custom-html','','using-joomla/extensions/modules/display-modules/custom-html','index.php?option=com_content&view=article&id=12','component',1,413,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',165,166,0,'*',0),(419,'aboutjoomla','Beez 2','beez-2','','using-joomla/extensions/templates/beez-2','index.php?option=com_content&view=category&layout=blog&id=69','component',1,282,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',184,189,0,'*',0),(422,'aboutjoomla','Atomic','atomic','','using-joomla/extensions/templates/atomic','index.php?option=com_content&view=category&layout=blog&id=68','component',1,282,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"2\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',196,201,0,'*',0),(423,'aboutjoomla','Typography Beez 2','typography-beez-2','','using-joomla/extensions/templates/beez-2/typography-beez-2','index.php?option=com_content&view=article&id=49','component',1,419,5,22,0,0,'0000-00-00 00:00:00',0,1,'',4,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',185,186,0,'*',0),(424,'aboutjoomla','Home Page Beez 2','home-page-beez-2','','using-joomla/extensions/templates/beez-2/home-page-beez-2','index.php?option=com_content&view=featured','component',1,419,5,22,0,0,'0000-00-00 00:00:00',0,1,'',4,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',187,188,0,'*',0),(427,'fruitshop','Fruit Encyclopedia','fruit-encyclopedia','','fruit-encyclopedia','index.php?option=com_contact&view=categories&id=37','component',1,1,1,8,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"show_base_description\":\"1\",\"categories_description\":\"\",\"maxLevelcat\":\"\",\"show_empty_categories_cat\":\"\",\"show_subcat_desc_cat\":\"\",\"show_cat_items_cat\":\"\",\"show_category_title\":\"\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"1\",\"show_subcat_desc\":\"\",\"show_cat_items\":\"\",\"show_pagination_limit\":\"\",\"show_headings\":\"0\",\"show_position_headings\":\"\",\"show_email_headings\":\"0\",\"show_telephone_headings\":\"0\",\"show_mobile_headings\":\"0\",\"show_fax_headings\":\"0\",\"show_suburb_headings\":\"0\",\"show_state_headings\":\"\",\"show_country_headings\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"presentation_style\":\"\",\"show_contact_category\":\"\",\"show_contact_list\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\" categories-listalphabet\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',255,256,0,'*',0),(429,'fruitshop','Welcome','welcome','Fruit store front page','welcome','index.php?option=com_content&view=article&id=20','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"show_noauth\":\"\",\"show_title\":\"0\",\"link_titles\":\"0\",\"show_intro\":\"1\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',253,254,0,'*',0),(430,'fruitshop','Contact Us','contact-us','','contact-us','index.php?option=com_contact&view=category&catid=47&id=36','component',1,1,1,8,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"20\",\"show_headings\":\"0\",\"filter_field\":\"hide\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',259,260,0,'*',0),(431,'fruitshop','Growers','growers','','growers','index.php?option=com_content&view=category&layout=blog&id=30','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"maxLevel\":\"0\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_category_title\":\"1\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"5\",\"num_intro_articles\":\"0\",\"num_columns\":\"1\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"alpha\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',257,258,0,'*',0),(432,'fruitshop','Login ','shop-login','','shop-login','index.php?option=com_users&view=login','component',1,1,1,25,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"login_redirect_url\":\"\",\"logindescription_show\":\"1\",\"login_description\":\"\",\"login_image\":\"\",\"logout_redirect_url\":\"\",\"logoutdescription_show\":\"1\",\"logout_description\":\"\",\"logout_image\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',261,262,0,'*',0),(433,'fruitshop','Directions','directions','','directions','index.php?option=com_content&view=article&id=13','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',263,264,0,'*',0),(435,'mainmenu','Home','homepage','','homepage','index.php?option=com_content&view=featured','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"featured_categories\":[\"\"],\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_pagination_results\":\"\",\"show_title\":\"1\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"0\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"0\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_vote\":\"\",\"show_readmore\":\"1\",\"show_readmore_title\":\"\",\"show_icons\":\"0\",\"show_print_icon\":\"0\",\"show_email_icon\":\"0\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',1,2,1,'*',0),(436,'aboutjoomla','Getting Help','getting-help','','using-joomla/getting-help','index.php?option=com_content&view=article&id=21','component',1,280,2,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',224,225,0,'*',0),(437,'aboutjoomla','Getting Started','getting-started','','getting-started','index.php?option=com_content&view=article&id=22','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_title\":\"1\",\"link_titles\":\"0\",\"show_intro\":\"\",\"show_category\":\"0\",\"link_category\":\"\",\"show_parent_category\":\"0\",\"link_parent_category\":\"\",\"show_author\":\"0\",\"link_author\":\"\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"0\",\"show_item_navigation\":\"0\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"0\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',45,46,0,'*',0),(438,'mainmenu','Weblinks','weblinks','','site-map/weblinks','index.php?option=com_weblinks&view=categories&id=0','component',1,294,2,21,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"orderby_pri\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',6,7,0,'*',0),(439,'mainmenu','Contacts','contacts','','site-map/contacts','index.php?option=com_contact&view=categories&id=0','component',1,294,2,8,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"categories_description\":\"\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',8,9,0,'*',0),(443,'aboutjoomla','Article Categories','article-categories-view','','using-joomla/extensions/modules/content-modules/article-categories-view','index.php?option=com_content&view=article&id=3','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',141,142,0,'*',0),(444,'top','Sample Sites','sample-sites-2','','sample-sites-2','index.php?Itemid=','alias',1,1,1,0,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"aliasoptions\":\"238\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',233,234,0,'*',0),(445,'mainmenu','Parks','parks','','sample-sites/parks','index.php?Itemid=','alias',1,238,2,0,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"aliasoptions\":\"243\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',266,267,0,'*',0),(446,'mainmenu','Shop','shop','','sample-sites/shop','index.php?Itemid=','alias',1,238,2,0,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"aliasoptions\":\"429\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',268,269,0,'*',0),(447,'aboutjoomla','Language Switcher','language-switcher','','using-joomla/extensions/modules/utility-modules/language-switcher','index.php?option=com_content&view=article&id=26','component',1,414,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',175,176,0,'*',0),(448,'mainmenu','Site Administrator','site-administrator','','site-administrator','administrator','url',1,1,1,0,0,0,'0000-00-00 00:00:00',1,1,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',271,272,0,'*',0),(449,'usermenu','Submit an Article','submit-an-article','','submit-an-article','index.php?option=com_content&view=form&layout=edit','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,3,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',273,274,0,'*',0),(450,'usermenu','Submit a Web Link','submit-a-web-link','','submit-a-web-link','index.php?option=com_weblinks&view=form&layout=edit','component',1,1,1,21,0,0,'0000-00-00 00:00:00',0,3,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',275,276,0,'*',0),(452,'aboutjoomla','Featured Contacts','featured-contacts','','using-joomla/extensions/components/contact-component/featured-contacts','index.php?option=com_contact&view=featured&id=16','component',1,270,5,8,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"-1\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"filter_field\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"presentation_style\":\"sliders\",\"show_name\":\"\",\"show_position\":\"\",\"show_email\":\"\",\"show_street_address\":\"\",\"show_suburb\":\"\",\"show_state\":\"\",\"show_postcode\":\"\",\"show_country\":\"\",\"show_telephone\":\"\",\"show_mobile\":\"\",\"show_fax\":\"\",\"show_webpage\":\"\",\"show_misc\":\"\",\"show_image\":\"\",\"allow_vcard\":\"\",\"show_articles\":\"\",\"show_links\":\"1\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"show_email_form\":\"\",\"show_email_copy\":\"\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"\",\"custom_reply\":\"\",\"redirect\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',81,82,0,'*',0),(453,'aboutjoomla','Parameters','parameters','','using-joomla/parameters','index.php?option=com_content&view=article&id=32','component',1,280,2,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"1\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"1\",\"link_parent_category\":\"1\",\"show_author\":\"1\",\"link_author\":\"1\",\"show_create_date\":\"1\",\"show_modify_date\":\"1\",\"show_publish_date\":\"1\",\"show_item_navigation\":\"1\",\"show_icons\":\"1\",\"show_print_icon\":\"1\",\"show_email_icon\":\"1\",\"show_hits\":\"1\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',222,223,0,'*',0),(455,'mainmenu','Example Pages','example-pages','','example-pages','index.php?Itemid=','alias',1,1,1,0,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"aliasoptions\":\"268\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',277,278,0,'*',0),(456,'aboutjoomla','Beez5','beez5','','using-joomla/extensions/templates/beez5','index.php?option=com_content&view=category&layout=blog&id=70','component',1,282,4,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_category_title\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',190,195,0,'*',0),(457,'aboutjoomla','Typography Beez5','typography-beez-5','','using-joomla/extensions/templates/beez5/typography-beez-5','index.php?option=com_content&view=article&id=49','component',1,456,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',191,192,0,'*',0),(458,'aboutjoomla','Home Page Beez5','home-page-beez5','','using-joomla/extensions/templates/beez5/home-page-beez5','index.php?option=com_content&view=featured','component',1,456,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"maxLevel\":\"\",\"show_empty_categories\":\"\",\"show_description\":\"\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',193,194,0,'*',0),(459,'aboutjoomla','Article Category','article-category','','using-joomla/extensions/modules/content-modules/article-category','index.php?option=com_content&view=article&id=4','component',1,411,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"robots\":\"\",\"rights\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"secure\":0}',143,144,0,'*',0),(462,'fruitshop','Add a recipe','add-a-recipe','','add-a-recipe','index.php?option=com_content&view=form&layout=edit','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,4,'',0,'{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',279,280,0,'*',0),(463,'fruitshop','Recipes','recipes','','recipes','index.php?option=com_content&view=category&id=76','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',6,'{\"maxLevel\":\"0\",\"show_category_title\":\"1\",\"page_subheading\":\"\",\"show_empty_categories\":\"0\",\"show_description\":\"1\",\"show_description_image\":\"\",\"show_cat_num_articles\":\"\",\"display_num\":\"\",\"show_headings\":\"\",\"list_show_title\":\"\",\"list_show_date\":\"\",\"date_format\":\"\",\"list_show_hits\":\"\",\"list_show_author\":\"\",\"filter_field\":\"\",\"orderby_pri\":\"\",\"orderby_sec\":\"\",\"order_date\":\"\",\"show_pagination\":\"\",\"show_pagination_limit\":\"\",\"show_noauth\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_feed_link\":\"\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":0,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',281,282,0,'*',0),(464,'top','Home','home','','home','index.php?Itemid=','alias',1,1,1,0,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"aliasoptions\":\"435\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\"}',227,228,0,'*',0),(466,'aboutjoomla','Smart Search','smart-search','','using-joomla/extensions/components/search-component/smart-search','index.php?option=com_finder&view=search&q=&f=','component',1,276,5,27,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_date_filters\":\"\",\"show_advanced\":\"\",\"expand_advanced\":\"\",\"show_description\":\"\",\"description_length\":255,\"show_url\":\"\",\"show_pagination_limit\":\"\",\"show_pagination\":\"\",\"show_pagination_results\":\"\",\"allow_empty_query\":\"0\",\"search_order\":\"\",\"show_feed\":\"0\",\"show_feed_text\":\"0\",\"show_feed_link\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',117,118,0,'*',0),(467,'aboutjoomla','Smart Search','smart-search','','using-joomla/extensions/modules/utility-modules/smart-search','index.php?option=com_content&view=article&id=70','component',1,414,5,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',179,180,0,'*',0);
/*!40000 ALTER TABLE `bak_qm_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_menu_types`
--

DROP TABLE IF EXISTS `bak_qm_menu_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_menu_types`
--

LOCK TABLES `bak_qm_menu_types` WRITE;
/*!40000 ALTER TABLE `bak_qm_menu_types` DISABLE KEYS */;
INSERT INTO `bak_qm_menu_types` VALUES (2,'usermenu','User Menu','A Menu for logged-in Users'),(3,'top','Top','Links for major types of users'),(4,'aboutjoomla','About Joomla','All about Joomla!'),(5,'parks','Australian Parks','Main menu for a site about Australian  parks'),(6,'mainmenu','Main Menu','Simple Home Menu'),(7,'fruitshop','Fruit Shop','Menu for the sample shop site.');
/*!40000 ALTER TABLE `bak_qm_menu_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_messages`
--

DROP TABLE IF EXISTS `bak_qm_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id_to` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_messages`
--

LOCK TABLES `bak_qm_messages` WRITE;
/*!40000 ALTER TABLE `bak_qm_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_messages_cfg`
--

DROP TABLE IF EXISTS `bak_qm_messages_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_messages_cfg`
--

LOCK TABLES `bak_qm_messages_cfg` WRITE;
/*!40000 ALTER TABLE `bak_qm_messages_cfg` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_messages_cfg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_modules`
--

DROP TABLE IF EXISTS `bak_qm_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_modules`
--

LOCK TABLES `bak_qm_modules` WRITE;
/*!40000 ALTER TABLE `bak_qm_modules` DISABLE KEYS */;
INSERT INTO `bak_qm_modules` VALUES (1,'Main Menu','','',1,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"0\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(2,'Login','','',1,'login',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'',1,'*'),(3,'Popular Articles','','',3,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_popular',3,1,'{\"count\":\"5\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}',1,'*'),(4,'Recently Added Articles','','',4,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_latest',3,1,'{\"count\":\"5\",\"ordering\":\"c_dsc\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}',1,'*'),(8,'Toolbar','','',1,'toolbar',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_toolbar',3,1,'',1,'*'),(9,'Quick Icons','','',1,'icon',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_quickicon',3,1,'',1,'*'),(10,'Logged-in Users','','',2,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_logged',3,1,'{\"count\":\"5\",\"name\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}',1,'*'),(12,'Admin Menu','','',1,'menu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',3,1,'{\"layout\":\"\",\"moduleclass_sfx\":\"\",\"shownew\":\"1\",\"showhelp\":\"1\",\"cache\":\"0\"}',1,'*'),(13,'Admin Submenu','','',1,'submenu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_submenu',3,1,'',1,'*'),(14,'User Status','','',2,'status',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_status',3,1,'',1,'*'),(15,'Title','','',1,'title',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_title',3,1,'',1,'*'),(16,'Login Form','','',7,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'{\"greeting\":\"1\",\"name\":\"0\"}',0,'*'),(17,'Breadcrumbs','','',1,'position-2',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_breadcrumbs',1,1,'{\"moduleclass_sfx\":\"\",\"showHome\":\"1\",\"homeText\":\"Home\",\"showComponent\":\"1\",\"separator\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(18,'Book Store','','',1,'position-10',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_banners',1,0,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"3\",\"catid\":[\"\"],\"tag_search\":\"0\",\"ordering\":\"0\",\"header_text\":\"\",\"footer_text\":\"Books!\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(19,'User Menu','','',3,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',2,1,'{\"menutype\":\"usermenu\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(20,'Top','','',1,'position-1',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"top\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),(22,'Australian Parks ','','',2,'position-5',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"parks\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'en-GB'),(23,'About Joomla!','','',4,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"aboutjoomla\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(25,'Site Map','','',1,'sitemapload',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,0,'{\"menutype\":\"mainmenu\",\"startLevel\":\"2\",\"endLevel\":\"3\",\"showAllChildren\":\"1\",\"tag_id\":\"\",\"class_sfx\":\"sitemap\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(26,'This Site','','',5,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"1\",\"endLevel\":\"1\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(27,'Archived Articles','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_archive',1,1,'{\"count\":\"10\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(28,'Latest News','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_latest',1,1,'{\"catid\":[\"19\"],\"count\":\"5\",\"show_featured\":\"\",\"ordering\":\"c_dsc\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(29,'Articles Most Read','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_popular',1,1,'{\"catid\":[\"26\",\"29\"],\"count\":\"5\",\"show_front\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(30,'Feed Display','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_feed',1,1,'{\"rssurl\":\"http:\\/\\/community.joomla.org\\/blogs\\/community.feed?type=rss\",\"rssrtl\":\"0\",\"rsstitle\":\"1\",\"rssdesc\":\"1\",\"rssimage\":\"1\",\"rssitems\":\"3\",\"rssitemdesc\":\"1\",\"word_count\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(31,'News Flash','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_news',1,1,'{\"catid\":[\"19\"],\"image\":\"0\",\"item_title\":\"0\",\"link_titles\":\"\",\"item_heading\":\"h4\",\"showLastSeparator\":\"1\",\"readmore\":\"1\",\"count\":\"1\",\"ordering\":\"a.publish_up\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(33,'Random Image','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_random_image',1,1,'{\"type\":\"jpg\",\"folder\":\"images\\/sampledata\\/parks\\/animals\",\"link\":\"\",\"width\":\"180\",\"height\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),(34,'Articles Related Items','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_related_items',1,1,'{\"showDate\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"owncache\":\"1\"}',0,'*'),(35,'Search','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_search',1,1,'{\"label\":\"\",\"width\":\"20\",\"text\":\"\",\"button\":\"\",\"button_pos\":\"right\",\"imagebutton\":\"\",\"button_text\":\"\",\"opensearch\":\"1\",\"opensearch_title\":\"\",\"set_itemid\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(36,'Statistics','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_stats',1,1,'{\"serverinfo\":\"1\",\"siteinfo\":\"1\",\"counter\":\"1\",\"increase\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(37,'Syndicate Feeds','','',1,'syndicateload',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_syndicate',1,1,'{\"text\":\"Feed Entries\",\"format\":\"rss\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),(38,'Users Latest','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_users_latest',1,1,'{\"shownumber\":\"5\",\"linknames\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(39,'Who\'s Online','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_whosonline',1,1,'{\"showmode\":\"2\",\"linknames\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),(40,'Wrapper','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_wrapper',1,1,'{\"url\":\"http:\\/\\/www.youtube.com\\/embed\\/vb2eObvmvdI\",\"add\":\"1\",\"scrolling\":\"auto\",\"width\":\"640\",\"height\":\"390\",\"height_auto\":\"1\",\"target\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(41,'Footer','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_footer',1,1,'{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(44,'Login','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'{\"pretext\":\"\",\"posttext\":\"\",\"login\":\"280\",\"logout\":\"280\",\"greeting\":\"1\",\"name\":\"0\",\"usesecure\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),(45,'Menu Example','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(47,'Latest Park Blogs','','',6,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_latest',1,1,'{\"count\":\"5\",\"ordering\":\"c_dsc\",\"user_id\":\"0\",\"show_front\":\"1\",\"catid\":\"35\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'en-GB'),(48,'Custom HTML','','<p>This is a custom html module. That means you can enter whatever content you want.</p>',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"backgroundimage\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(49,'Weblinks','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_weblinks',1,1,'{\"catid\":\"32\",\"count\":\"5\",\"ordering\":\"title\",\"direction\":\"asc\",\"target\":\"3\",\"description\":\"0\",\"hits\":\"0\",\"count_clicks\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(52,'Breadcrumbs','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_breadcrumbs',1,1,'{\"showHere\":\"1\",\"showHome\":\"1\",\"homeText\":\"Home\",\"showLast\":\"1\",\"separator\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(56,'Banners','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_banners',1,1,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"1\",\"catid\":[\"15\"],\"tag_search\":\"0\",\"ordering\":\"random\",\"header_text\":\"\",\"footer_text\":\"\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(57,'Fruit Shop','','',3,'position-5',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"fruitshop\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(58,'Special!','','<h1>This week we have a special, half price on delicious oranges!</h1><div>Only for our special customers!</div><div>Use the code: Joomla! when ordering</div><p><em>This module can only be seen by people in the customers group or higher.</em></p>',1,'position-12',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',4,1,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(61,'Articles Categories','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_categories',1,1,'{\"parent\":\"29\",\"show_description\":\"0\",\"show_children\":\"0\",\"count\":\"0\",\"maxlevel\":\"0\",\"layout\":\"_:default\",\"item_heading\":\"4\",\"moduleclass_sfx\":\"\",\"owncache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(62,'Language Switcher','','',3,'position-4',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'mod_languages',1,1,'{\"header_text\":\"\",\"footer_text\":\"\",\"image\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(63,'Search','','',1,'position-0',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_search',1,1,'{\"width\":\"20\",\"text\":\"\",\"button\":\"\",\"button_pos\":\"right\",\"imagebutton\":\"1\",\"button_text\":\"\",\"set_itemid\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(64,'Language Switcher','','',1,'languageswitcherload',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'mod_languages',1,1,'{\"header_text\":\"\",\"footer_text\":\"\",\"image\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(65,'About Fruit Shop','','<p>The Fruit Shop site shows a number of Joomla! features.</p><p>The template uses classes in cascading style sheets to change the layout of items, such as creating the horizontal alphabetical list in the Fruit Encyclopedia.</p><p> </p>',1,'position-4',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(67,'Extensions','','',2,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'mod_menu',1,1,'{\"menutype\":\"aboutjoomla\",\"startLevel\":\"1\",\"endLevel\":\"6\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"-menu\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(68,'About Parks','','<p>The Parks sample site is designed as a simple site that can be routinely updated from the front end of Joomla!.</p><p>As a site, it is largely focused on a blog which can be updated using the front end article submission.</p><p>New weblinks can also be added through the front end.</p><p>A simple image gallery uses com_content with thumbnails displayed in a blog layout and full size images shown in article layout.</p><p>The Parks site features the language switch module. All of the content and modules are tagged as English (en-GB). If a second language pack is added with sample data this can be filtered using the language switch.</p><p>Parks uses HTML5 which is a major web standard (along with XHTML which is used in other areas of sample data).</p>',2,'position-4',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,1,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(69,'Articles Category','','',1,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_articles_category',1,1,'{\"mode\":\"normal\",\"show_on_article_page\":\"1\",\"show_front\":\"show\",\"count\":\"0\",\"category_filtering_type\":\"1\",\"catid\":[\"72\"],\"show_child_category_articles\":\"0\",\"levels\":\"1\",\"author_filtering_type\":\"1\",\"created_by\":[\"\"],\"author_alias_filtering_type\":\"1\",\"created_by_alias\":[\"\"],\"excluded_articles\":\"\",\"date_filtering\":\"off\",\"date_field\":\"a.created\",\"start_date_range\":\"\",\"end_date_range\":\"\",\"relative_date\":\"30\",\"article_ordering\":\"a.title\",\"article_ordering_direction\":\"ASC\",\"article_grouping\":\"none\",\"article_grouping_direction\":\"ksort\",\"month_year_format\":\"F Y\",\"item_heading\":\"4\",\"link_titles\":\"1\",\"show_date\":\"0\",\"show_date_field\":\"created\",\"show_date_format\":\"Y-m-d H:i:s\",\"show_category\":\"0\",\"show_hits\":\"0\",\"show_author\":\"0\",\"show_introtext\":\"0\",\"introtext_limit\":\"100\",\"show_readmore\":\"0\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"15\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"owncache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(70,'Search (Atomic Template)','','',1,'atomic-search',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_search',1,0,'{\"width\":\"20\",\"text\":\"\",\"button\":\"\",\"button_pos\":\"right\",\"imagebutton\":\"\",\"button_text\":\"\",\"set_itemid\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(71,'Top Menu (Atomic Template)','','',1,'atomic-topmenu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,0,'{\"menutype\":\"aboutjoomla\",\"startLevel\":\"1\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(72,'Top Quote (Atomic Template)','','<hr />\r\n<h2 class=\"alt\">Powerful Content Management and a Simple Extensible Framework.</h2>\r\n<hr />',1,'atomic-topquote',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,0,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(73,'Bottom Left Column (Atomic Template)','','<h6>This is a nested column</h6>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>',1,'atomic-bottomleft',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,0,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(74,'Bottom Middle Column (Atomic Template)','','<h6>This is another nested column</h6>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>',1,'atomic-bottommiddle',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,0,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(75,'Sidebar (Atomic Template)','','<h3>A <span class=\"alt\">Simple</span> Sidebar</h3>\r\n<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ornare mattis nunc. Mauris venenatis, pede sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue.</p>\r\n<p class=\"quiet\">Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ornare mattis nunc. Mauris venenatis, pede sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue.</p>\r\n<h5>Incremental leading</h5>\r\n<p class=\"incr\">Vestibulum ante ipsum primis in faucibus orci luctus vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ornare mattis nunc. Mauris venenatis, pede sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue. sed aliquet vehicula, lectus tellus.</p>\r\n<p class=\"incr\">Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ornare mattis nunc. Mauris venenatis, pede sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue. sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue. ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Cras ornare mattis nunc. Mauris venenatis, pede sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue. sed aliquet vehicula, lectus tellus pulvinar neque, non cursus sem nisi vel augue.</p>',1,'atomic-sidebar',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_custom',1,0,'{\"prepare_content\":\"1\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}',0,'*'),(76,'Login (Atomic Template)','','',2,'atomic-sidebar',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,0,'{\"pretext\":\"\",\"posttext\":\"\",\"login\":\"\",\"logout\":\"\",\"greeting\":\"1\",\"name\":\"0\",\"usesecure\":\"0\",\"layout\":\"\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',0,'*'),(77,'Shop','','',1,'position-11',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_banners',1,0,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"2\",\"catid\":[\"15\"],\"tag_search\":\"0\",\"ordering\":\"0\",\"header_text\":\"\",\"footer_text\":\"Shop!\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(78,'Contribute','','',1,'position-9',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_banners',1,0,'{\"target\":\"1\",\"count\":\"1\",\"cid\":\"1\",\"catid\":[\"15\"],\"tag_search\":\"0\",\"ordering\":\"0\",\"header_text\":\"\",\"footer_text\":\"Contribute! \",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"1\",\"cache_time\":\"900\"}',0,'*'),(79,'Multilanguage status','','',1,'status',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'mod_multilangstatus',3,1,'{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(84,'Smart Search Module','','',2,'',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_finder',1,1,'{\"searchfilter\":\"\",\"show_autosuggest\":\"1\",\"show_advanced\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"field_size\":20,\"alt_label\":\"\",\"show_label\":\"0\",\"label_pos\":\"top\",\"show_button\":\"0\",\"button_pos\":\"right\",\"opensearch\":\"1\",\"opensearch_title\":\"\"}',0,'*'),(86,'Joomla Version','','',1,'footer',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_version',3,1,'{\"format\":\"short\",\"product\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*');
/*!40000 ALTER TABLE `bak_qm_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_modules_menu`
--

DROP TABLE IF EXISTS `bak_qm_modules_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_modules_menu`
--

LOCK TABLES `bak_qm_modules_menu` WRITE;
/*!40000 ALTER TABLE `bak_qm_modules_menu` DISABLE KEYS */;
INSERT INTO `bak_qm_modules_menu` VALUES (1,101),(2,0),(3,0),(4,0),(6,0),(7,0),(8,0),(9,0),(10,0),(12,0),(13,0),(14,0),(15,0),(16,205),(16,435),(17,0),(18,0),(19,-463),(19,-462),(19,-433),(19,-432),(19,-431),(19,-430),(19,-429),(19,-427),(19,-400),(19,-399),(19,-296),(19,-244),(19,-243),(19,-242),(19,-234),(20,0),(22,231),(22,234),(22,238),(22,242),(22,243),(22,244),(22,296),(22,399),(22,400),(23,-463),(23,-462),(23,-433),(23,-432),(23,-431),(23,-430),(23,-429),(23,-427),(23,-400),(23,-399),(23,-296),(23,-244),(23,-243),(23,-242),(23,-238),(23,-234),(25,294),(26,-463),(26,-462),(26,-433),(26,-432),(26,-431),(26,-430),(26,-429),(26,-427),(26,-400),(26,-399),(26,-296),(26,-244),(26,-243),(26,-242),(26,-238),(26,-234),(27,325),(28,310),(29,302),(30,410),(31,309),(32,309),(33,307),(34,326),(35,306),(36,304),(37,311),(38,300),(39,301),(40,313),(41,324),(44,312),(45,303),(47,231),(47,234),(47,242),(47,243),(47,244),(47,296),(47,399),(47,400),(48,418),(49,417),(52,416),(56,305),(57,238),(57,427),(57,429),(57,430),(57,431),(57,432),(57,433),(57,462),(57,463),(58,427),(58,429),(58,430),(58,431),(58,432),(58,433),(58,462),(58,463),(61,443),(62,231),(62,234),(62,242),(62,243),(62,244),(62,296),(62,399),(62,400),(63,0),(64,447),(65,427),(65,429),(65,430),(65,431),(65,432),(65,433),(65,462),(65,463),(68,243),(69,459),(70,285),(70,316),(71,285),(71,316),(72,285),(72,316),(73,285),(73,316),(74,285),(74,316),(75,285),(75,316),(76,285),(76,316),(77,0),(78,0),(79,0),(84,467),(86,0);
/*!40000 ALTER TABLE `bak_qm_modules_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_newsfeeds`
--

DROP TABLE IF EXISTS `bak_qm_newsfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_newsfeeds` (
  `catid` int(11) NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `link` varchar(200) NOT NULL DEFAULT '',
  `filename` varchar(200) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `numarticles` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '3600',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_newsfeeds`
--

LOCK TABLES `bak_qm_newsfeeds` WRITE;
/*!40000 ALTER TABLE `bak_qm_newsfeeds` DISABLE KEYS */;
INSERT INTO `bak_qm_newsfeeds` VALUES (17,1,'Joomla! Announcements','joomla-announcements','http://www.joomla.org/announcements.feed?type=rss',NULL,1,5,3600,0,'0000-00-00 00:00:00',1,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',627,'','2011-12-27 12:25:05',42,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,2,'New Joomla! Extensions','new-joomla-extensions','http://feeds.joomla.org/JoomlaExtensions',NULL,1,5,3600,0,'0000-00-00 00:00:00',4,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',627,'','2011-12-27 12:25:36',42,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,3,'Joomla! Security News','joomla-security-news','http://feeds.joomla.org/JoomlaSecurityNews',NULL,1,5,3600,0,'0000-00-00 00:00:00',2,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',627,'','2011-12-27 12:24:55',42,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00 00:00:00','0000-00-00 00:00:00'),(17,4,'Joomla! Connect','joomla-connect','http://feeds.joomla.org/JoomlaConnect',NULL,1,5,3600,0,'0000-00-00 00:00:00',3,1,1,'en-GB','{\"show_feed_image\":\"\",\"show_feed_description\":\"\",\"show_item_description\":\"\",\"feed_character_count\":\"0\",\"newsfeed_layout\":\"\",\"feed_display_order\":\"\"}','2011-01-01 00:00:01',627,'','2011-12-27 12:25:10',42,'','','{\"robots\":\"\",\"rights\":\"\"}','','0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `bak_qm_newsfeeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_overrider`
--

DROP TABLE IF EXISTS `bak_qm_overrider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_overrider`
--

LOCK TABLES `bak_qm_overrider` WRITE;
/*!40000 ALTER TABLE `bak_qm_overrider` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_overrider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_redirect_links`
--

DROP TABLE IF EXISTS `bak_qm_redirect_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) NOT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_redirect_links`
--

LOCK TABLES `bak_qm_redirect_links` WRITE;
/*!40000 ALTER TABLE `bak_qm_redirect_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_redirect_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_schemas`
--

DROP TABLE IF EXISTS `bak_qm_schemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_schemas`
--

LOCK TABLES `bak_qm_schemas` WRITE;
/*!40000 ALTER TABLE `bak_qm_schemas` DISABLE KEYS */;
INSERT INTO `bak_qm_schemas` VALUES (700,'2.5.28');
/*!40000 ALTER TABLE `bak_qm_schemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_session`
--

DROP TABLE IF EXISTS `bak_qm_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_session` (
  `session_id` varchar(200) NOT NULL DEFAULT '',
  `client_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `guest` tinyint(4) unsigned DEFAULT '1',
  `time` varchar(14) DEFAULT '',
  `data` mediumtext,
  `userid` int(11) DEFAULT '0',
  `username` varchar(150) DEFAULT '',
  `usertype` varchar(50) DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_session`
--

LOCK TABLES `bak_qm_session` WRITE;
/*!40000 ALTER TABLE `bak_qm_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_template_styles`
--

DROP TABLE IF EXISTS `bak_qm_template_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_template_styles`
--

LOCK TABLES `bak_qm_template_styles` WRITE;
/*!40000 ALTER TABLE `bak_qm_template_styles` DISABLE KEYS */;
INSERT INTO `bak_qm_template_styles` VALUES (2,'bluestork',1,'1','Bluestork - Default','{\"useRoundedCorners\":\"1\",\"showSiteName\":\"0\"}'),(3,'atomic',0,'0','Atomic - Default','{}'),(4,'beez_20',0,'1','Beez2 - Default','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"images\\/joomla_black.gif\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"templatecolor\":\"personal\",\"html5\":\"0\"}'),(5,'hathor',1,'0','Hathor - Default','{\"showSiteName\":\"0\",\"colourChoice\":\"\",\"boldText\":\"0\"}'),(6,'beez5',0,'0','Beez5 - Default','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"images\\/sampledata\\/fruitshop\\/fruits.gif\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"html5\":\"0\"}'),(114,'beez_20',0,'0','Beez2 - Parks Site','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"\",\"sitetitle\":\"Australian Parks\",\"sitedescription\":\"Parks Sample Site\",\"navposition\":\"center\",\"templatecolor\":\"nature\"}');
/*!40000 ALTER TABLE `bak_qm_template_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_update_categories`
--

DROP TABLE IF EXISTS `bak_qm_update_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_update_categories` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT '',
  `description` text NOT NULL,
  `parent` int(11) DEFAULT '0',
  `updatesite` int(11) DEFAULT '0',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Update Categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_update_categories`
--

LOCK TABLES `bak_qm_update_categories` WRITE;
/*!40000 ALTER TABLE `bak_qm_update_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_update_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_update_sites`
--

DROP TABLE IF EXISTS `bak_qm_update_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `location` text NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Update Sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_update_sites`
--

LOCK TABLES `bak_qm_update_sites` WRITE;
/*!40000 ALTER TABLE `bak_qm_update_sites` DISABLE KEYS */;
INSERT INTO `bak_qm_update_sites` VALUES (1,'Joomla Core','collection','http://update.joomla.org/core/list.xml',1,0),(2,'Joomla Extension Directory','collection','http://update.joomla.org/jed/list.xml',1,0),(3,'Accredited Joomla! Translations','collection','http://update.joomla.org/language/translationlist.xml',1,0);
/*!40000 ALTER TABLE `bak_qm_update_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_update_sites_extensions`
--

DROP TABLE IF EXISTS `bak_qm_update_sites_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links extensions to update sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_update_sites_extensions`
--

LOCK TABLES `bak_qm_update_sites_extensions` WRITE;
/*!40000 ALTER TABLE `bak_qm_update_sites_extensions` DISABLE KEYS */;
INSERT INTO `bak_qm_update_sites_extensions` VALUES (1,700),(2,700),(3,600);
/*!40000 ALTER TABLE `bak_qm_update_sites_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_updates`
--

DROP TABLE IF EXISTS `bak_qm_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_updates` (
  `update_id` int(11) NOT NULL AUTO_INCREMENT,
  `update_site_id` int(11) DEFAULT '0',
  `extension_id` int(11) DEFAULT '0',
  `categoryid` int(11) DEFAULT '0',
  `name` varchar(100) DEFAULT '',
  `description` text NOT NULL,
  `element` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `folder` varchar(20) DEFAULT '',
  `client_id` tinyint(3) DEFAULT '0',
  `version` varchar(10) DEFAULT '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  `infourl` text NOT NULL,
  PRIMARY KEY (`update_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Available Updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_updates`
--

LOCK TABLES `bak_qm_updates` WRITE;
/*!40000 ALTER TABLE `bak_qm_updates` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_user_notes`
--

DROP TABLE IF EXISTS `bak_qm_user_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_user_notes`
--

LOCK TABLES `bak_qm_user_notes` WRITE;
/*!40000 ALTER TABLE `bak_qm_user_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_user_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_user_profiles`
--

DROP TABLE IF EXISTS `bak_qm_user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_user_profiles`
--

LOCK TABLES `bak_qm_user_profiles` WRITE;
/*!40000 ALTER TABLE `bak_qm_user_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `bak_qm_user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_user_usergroup_map`
--

DROP TABLE IF EXISTS `bak_qm_user_usergroup_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_user_usergroup_map`
--

LOCK TABLES `bak_qm_user_usergroup_map` WRITE;
/*!40000 ALTER TABLE `bak_qm_user_usergroup_map` DISABLE KEYS */;
INSERT INTO `bak_qm_user_usergroup_map` VALUES (627,8);
/*!40000 ALTER TABLE `bak_qm_user_usergroup_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_usergroups`
--

DROP TABLE IF EXISTS `bak_qm_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_usergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Adjacency List Reference Id',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` (`lft`,`rgt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_usergroups`
--

LOCK TABLES `bak_qm_usergroups` WRITE;
/*!40000 ALTER TABLE `bak_qm_usergroups` DISABLE KEYS */;
INSERT INTO `bak_qm_usergroups` VALUES (1,0,1,20,'Public'),(2,1,6,17,'Registered'),(3,2,7,14,'Author'),(4,3,8,11,'Editor'),(5,4,9,10,'Publisher'),(6,1,2,5,'Manager'),(7,6,3,4,'Administrator'),(8,1,18,19,'Super Users'),(10,3,12,13,'Shop Suppliers (Example)'),(12,2,15,16,'Customer Group (Example)');
/*!40000 ALTER TABLE `bak_qm_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_users`
--

DROP TABLE IF EXISTS `bak_qm_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(150) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `usertype` varchar(25) NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  PRIMARY KEY (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=628 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_users`
--

LOCK TABLES `bak_qm_users` WRITE;
/*!40000 ALTER TABLE `bak_qm_users` DISABLE KEYS */;
INSERT INTO `bak_qm_users` VALUES (627,'Super User','admin','183107471@qq.com','$P$D5lX8FPb6RfBh//UW93sO6076SOu420','deprecated',0,1,'2015-08-24 00:39:37','0000-00-00 00:00:00','0','','0000-00-00 00:00:00',0);
/*!40000 ALTER TABLE `bak_qm_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_viewlevels`
--

DROP TABLE IF EXISTS `bak_qm_viewlevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_viewlevels`
--

LOCK TABLES `bak_qm_viewlevels` WRITE;
/*!40000 ALTER TABLE `bak_qm_viewlevels` DISABLE KEYS */;
INSERT INTO `bak_qm_viewlevels` VALUES (1,'Public',0,'[1]'),(2,'Registered',1,'[6,2,8]'),(3,'Special',2,'[6,3,8]'),(4,'Customer Access Level (Example)',3,'[6,3,12]');
/*!40000 ALTER TABLE `bak_qm_viewlevels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bak_qm_weblinks`
--

DROP TABLE IF EXISTS `bak_qm_weblinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bak_qm_weblinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(250) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(250) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `access` int(11) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `language` char(7) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if link is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bak_qm_weblinks`
--

LOCK TABLES `bak_qm_weblinks` WRITE;
/*!40000 ALTER TABLE `bak_qm_weblinks` DISABLE KEYS */;
INSERT INTO `bak_qm_weblinks` VALUES (1,32,0,'Joomla!','joomla','http://www.joomla.org','<p>Home of Joomla!</p>','0000-00-00 00:00:00',3,1,0,'0000-00-00 00:00:00',1,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,33,0,'php.net','php','http://www.php.net','<p>The language that Joomla! is developed in</p>','0000-00-00 00:00:00',6,1,0,'0000-00-00 00:00:00',1,0,1,1,'{\"target\":\"\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,33,0,'MySQL','mysql','http://www.mysql.com','<p>The most commonly used database for Joomla!.</p>','0000-00-00 00:00:00',1,1,0,'0000-00-00 00:00:00',2,0,1,1,'{\"target\":\"\",\"width\":\"\",\"height\":\"\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2012-01-17 16:19:43',42,'','','{\"robots\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,32,0,'OpenSourceMatters','opensourcematters','http://www.opensourcematters.org','<p>Home of OSM</p>','0000-00-00 00:00:00',11,1,0,'0000-00-00 00:00:00',3,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,32,0,'Joomla! - Forums','joomla-forums','http://forum.joomla.org','<p>Joomla! Forums</p>','0000-00-00 00:00:00',4,1,0,'0000-00-00 00:00:00',2,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,33,0,'Ohloh Tracking of Joomla!','ohloh-tracking-of-joomla','http://www.ohloh.net/projects/20','<p>Objective reports from Ohloh about Joomla\'s development activity. Joomla! has some star developers with serious kudos.</p>','0000-00-00 00:00:00',1,1,0,'0000-00-00 00:00:00',3,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,31,0,'Baw Baw National Park','baw-baw-national-park','http://www.parkweb.vic.gov.au/1park_display.cfm?park=44','<p>Park of the Austalian Alps National Parks system, Baw Baw  features sub alpine vegetation, beautiful views, and opportunities for hiking, skiing and other outdoor activities.</p>','0000-00-00 00:00:00',0,1,0,'0000-00-00 00:00:00',1,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,31,0,'Kakadu','kakadu','http://www.environment.gov.au/parks/kakadu/index.html','<p>Kakadu is known for both its cultural heritage and its natural features. It is one of a small number of places listed as World Heritage Places for both reasons. Extensive rock art is found there.</p>','0000-00-00 00:00:00',0,1,0,'0000-00-00 00:00:00',2,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,31,0,'Pulu Keeling','pulu-keeling','http://www.environment.gov.au/parks/cocos/index.html','<p>Located on an atoll 2000 kilometers north of Perth, Pulu Keeling is Australia\'s smallest national park.</p>','0000-00-00 00:00:00',0,1,0,'0000-00-00 00:00:00',3,0,1,1,'{\"target\":\"0\",\"count_clicks\":\"\"}','en-GB','2011-01-01 00:00:01',627,'','2011-01-01 00:00:01',42,'','','{\"robots\":\"\",\"author\":\"\",\"rights\":\"\"}',0,'','2010-07-10 23:44:03','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `bak_qm_weblinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_act`
--

DROP TABLE IF EXISTS `qm_act`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_act` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `fname` varchar(255) NOT NULL,
  `simg` varchar(255) NOT NULL,
  `bimg` varchar(255) NOT NULL,
  `hid` int(10) unsigned NOT NULL DEFAULT '0',
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ö÷Ìâ»î¶¯';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_act`
--

LOCK TABLES `qm_act` WRITE;
/*!40000 ALTER TABLE `qm_act` DISABLE KEYS */;
INSERT INTO `qm_act` VALUES (1,'健康风险评估','预防疾病必备检测项目','images/act/kangshuai618.jpg','images/act/kangshuai6182.jpg',0,4,1466223174),(2,'楷恩国际，品质生活100岁','正楷做人，感恩做事','images/act/tongyanshu.jpg','images/act/kane5.jpg',15,0,1466562872),(3,'胸部整形','让你挺胸做女人','images/act/fengxiong6201.jpg','images/act/fengxiong622.jpg',0,27,1466562612),(4,'综合隆鼻','因为合适的，才是完美的','images/act/bizi6201.jpg','images/act/longbi6211.jpg',0,19,1466477938),(6,'Botox瘦脸针','我就要明星V脸','images/act/shoulian6201.jpg','images/act/shoulian6202.jpg',0,48,1466562864),(7,'玻尿酸全面特价','补水保湿塑形一网打尽','images/act/shuguangzhen111.jpg','images/act/boniaosuan6201.jpg',0,47,1466562824),(8,'减肥瘦身','今日不减肥，明日徒伤悲','images/shoushen62511.png','images/act/xizhi6252.png',0,25,1466824149),(9,'牙齿美白','美丽牙齿，自信笑容','images/act/ya6271.jpg','images/act/yachi627.jpg',0,44,1466996416);
/*!40000 ALTER TABLE `qm_act` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_assets`
--

DROP TABLE IF EXISTS `qm_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_assets`
--

LOCK TABLES `qm_assets` WRITE;
/*!40000 ALTER TABLE `qm_assets` DISABLE KEYS */;
INSERT INTO `qm_assets` VALUES (1,0,1,71,0,'root.1','Root Asset','{\"core.login.site\":{\"6\":1,\"2\":1},\"core.login.admin\":{\"6\":1},\"core.login.offline\":{\"6\":1},\"core.admin\":{\"8\":1},\"core.manage\":{\"7\":1},\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1},\"core.edit.own\":{\"6\":1,\"3\":1}}'),(2,1,1,2,1,'com_admin','com_admin','{}'),(3,1,3,6,1,'com_banners','com_banners','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(4,1,7,8,1,'com_cache','com_cache','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),(5,1,9,10,1,'com_checkin','com_checkin','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),(6,1,11,12,1,'com_config','com_config','{}'),(7,1,13,16,1,'com_contact','com_contact','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),(8,1,17,20,1,'com_content','com_content','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":[],\"core.edit\":{\"4\":1},\"core.edit.state\":{\"5\":1},\"core.edit.own\":[]}'),(9,1,21,22,1,'com_cpanel','com_cpanel','{}'),(10,1,23,24,1,'com_installer','com_installer','{\"core.admin\":[],\"core.manage\":{\"7\":0},\"core.delete\":{\"7\":0},\"core.edit.state\":{\"7\":0}}'),(11,1,25,26,1,'com_languages','com_languages','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(12,1,27,28,1,'com_login','com_login','{}'),(13,1,29,30,1,'com_mailto','com_mailto','{}'),(14,1,31,32,1,'com_massmail','com_massmail','{}'),(15,1,33,34,1,'com_media','com_media','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":{\"5\":1}}'),(16,1,35,36,1,'com_menus','com_menus','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(17,1,37,38,1,'com_messages','com_messages','{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}'),(18,1,39,40,1,'com_modules','com_modules','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(19,1,41,44,1,'com_newsfeeds','com_newsfeeds','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),(20,1,45,46,1,'com_plugins','com_plugins','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(21,1,47,48,1,'com_redirect','com_redirect','{\"core.admin\":{\"7\":1},\"core.manage\":[]}'),(22,1,49,50,1,'com_search','com_search','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(23,1,51,52,1,'com_templates','com_templates','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(24,1,53,56,1,'com_users','com_users','{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(25,1,57,60,1,'com_weblinks','com_weblinks','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":[],\"core.edit\":{\"4\":1},\"core.edit.state\":{\"5\":1},\"core.edit.own\":[]}'),(26,1,61,62,1,'com_wrapper','com_wrapper','{}'),(27,8,18,19,2,'com_content.category.2','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),(28,3,4,5,2,'com_banners.category.3','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(29,7,14,15,2,'com_contact.category.4','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),(30,19,42,43,2,'com_newsfeeds.category.5','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),(31,25,58,59,2,'com_weblinks.category.6','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}'),(32,24,54,55,1,'com_users.category.7','Uncategorised','{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}'),(33,1,63,64,1,'com_finder','com_finder','{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}'),(34,1,65,66,1,'com_joomlaupdate','com_joomlaupdate','{\"core.admin\":[],\"core.manage\":[],\"core.delete\":[],\"core.edit.state\":[]}'),(35,1,67,68,1,'com_project','com_project','{}'),(36,1,69,70,1,'com_group','com_group','{\"core.admin\":{\"8\":1},\"core.manage\":{\"7\":1},\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"1\":0,\"6\":1},\"core.edit\":{\"6\":1,\"4\":1}}');
/*!40000 ALTER TABLE `qm_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_associations`
--

DROP TABLE IF EXISTS `qm_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_associations` (
  `id` varchar(50) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_associations`
--

LOCK TABLES `qm_associations` WRITE;
/*!40000 ALTER TABLE `qm_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_banner_clients`
--

DROP TABLE IF EXISTS `qm_banner_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_banner_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contact` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `extrainfo` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metakey` text NOT NULL,
  `own_prefix` tinyint(4) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_banner_clients`
--

LOCK TABLES `qm_banner_clients` WRITE;
/*!40000 ALTER TABLE `qm_banner_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_banner_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_banner_tracks`
--

DROP TABLE IF EXISTS `qm_banner_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_banner_tracks`
--

LOCK TABLES `qm_banner_tracks` WRITE;
/*!40000 ALTER TABLE `qm_banner_tracks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_banner_tracks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_banners`
--

DROP TABLE IF EXISTS `qm_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `imptotal` int(11) NOT NULL DEFAULT '0',
  `impmade` int(11) NOT NULL DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `clickurl` varchar(200) NOT NULL DEFAULT '',
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `custombannercode` varchar(2048) NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `params` text NOT NULL,
  `own_prefix` tinyint(1) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` char(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_banners`
--

LOCK TABLES `qm_banners` WRITE;
/*!40000 ALTER TABLE `qm_banners` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_banners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_baoxian`
--

DROP TABLE IF EXISTS `qm_baoxian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_baoxian` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `intro` text NOT NULL,
  `img` varchar(255) NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ä¿é™©ä»‹ç»è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_baoxian`
--

LOCK TABLES `qm_baoxian` WRITE;
/*!40000 ALTER TABLE `qm_baoxian` DISABLE KEYS */;
INSERT INTO `qm_baoxian` VALUES (1,'全美APP','　　我们的价值观：\r\n　　内外兼修的美\r\n　　由内而外的富足\r\n\r\n　　我们的平台：\r\n　　北京全美百年科技有限公司旗下全美APP提供同城最好的医美机构、最权威的医美专家，绝对的原装正品药物，专属管家式服务让你安全地提高颜值；\r\n　　全美APP还提供国内外一流培训课程、专业的资深导师，提升你的内在修养，让你的内心更加自信、强大。\r\n\r\n　　我们的愿景：\r\n　　让2亿爱美人士安全地由内而外地变美；让她们享受到我们真诚的、贴心的专属管家式服务，打造中国首家内外兼修的O2O第一品牌。\r\n\r\n　　我们的战略：\r\n　　以北京和武汉为中心，逐步向全国所有城市复制，并同时向海外的韩国、日本等国延伸，全面为2亿人提供内外兼修的全美平台。','images/act/quanmei6242.jpg',1466742610);
/*!40000 ALTER TABLE `qm_baoxian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_categories`
--

DROP TABLE IF EXISTS `qm_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `extension` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_categories`
--

LOCK TABLES `qm_categories` WRITE;
/*!40000 ALTER TABLE `qm_categories` DISABLE KEYS */;
INSERT INTO `qm_categories` VALUES (1,0,0,0,13,0,'','system','ROOT','root','','',1,0,'0000-00-00 00:00:00',1,'{}','','','',0,'2009-10-18 16:07:09',0,'0000-00-00 00:00:00',0,'*'),(2,27,1,1,2,1,'uncategorised','com_content','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',42,'2010-06-28 13:26:37',0,'0000-00-00 00:00:00',0,'*'),(3,28,1,3,4,1,'uncategorised','com_banners','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\",\"foobar\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',42,'2010-06-28 13:27:35',0,'0000-00-00 00:00:00',0,'*'),(4,29,1,5,6,1,'uncategorised','com_contact','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',42,'2010-06-28 13:27:57',0,'0000-00-00 00:00:00',0,'*'),(5,30,1,7,8,1,'uncategorised','com_newsfeeds','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',42,'2010-06-28 13:28:15',0,'0000-00-00 00:00:00',0,'*'),(6,31,1,9,10,1,'uncategorised','com_weblinks','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',42,'2010-06-28 13:28:33',0,'0000-00-00 00:00:00',0,'*'),(7,32,1,11,12,1,'uncategorised','com_users','Uncategorised','uncategorised','','',1,0,'0000-00-00 00:00:00',1,'{\"target\":\"\",\"image\":\"\"}','','','{\"page_title\":\"\",\"author\":\"\",\"robots\":\"\"}',42,'2010-06-28 13:28:33',0,'0000-00-00 00:00:00',0,'*');
/*!40000 ALTER TABLE `qm_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_city`
--

DROP TABLE IF EXISTS `qm_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_city` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `pid` int(10) unsigned NOT NULL,
  `zipcode` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='城市表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_city`
--

LOCK TABLES `qm_city` WRITE;
/*!40000 ALTER TABLE `qm_city` DISABLE KEYS */;
INSERT INTO `qm_city` VALUES (1,'北京市',1,'100000'),(2,'天津市',2,'100000'),(3,'石家庄市',3,'050000'),(4,'唐山市',3,'063000'),(5,'秦皇岛市',3,'066000'),(6,'邯郸市',3,'056000'),(7,'邢台市',3,'054000'),(8,'保定市',3,'071000'),(9,'张家口市',3,'075000'),(10,'承德市',3,'067000'),(11,'沧州市',3,'061000'),(12,'廊坊市',3,'065000'),(13,'衡水市',3,'053000'),(14,'太原市',4,'030000'),(15,'大同市',4,'037000'),(16,'阳泉市',4,'045000'),(17,'长治市',4,'046000'),(18,'晋城市',4,'048000'),(19,'朔州市',4,'036000'),(20,'晋中市',4,'030600'),(21,'运城市',4,'044000'),(22,'忻州市',4,'034000'),(23,'临汾市',4,'041000'),(24,'吕梁市',4,'030500'),(25,'呼和浩特市',5,'010000'),(26,'包头市',5,'014000'),(27,'乌海市',5,'016000'),(28,'赤峰市',5,'024000'),(29,'通辽市',5,'028000'),(30,'鄂尔多斯市',5,'010300'),(31,'呼伦贝尔市',5,'021000'),(32,'巴彦淖尔市',5,'014400'),(33,'乌兰察布市',5,'011800'),(34,'兴安盟',5,'137500'),(35,'锡林郭勒盟',5,'011100'),(36,'阿拉善盟',5,'016000'),(37,'沈阳市',6,'110000'),(38,'大连市',6,'116000'),(39,'鞍山市',6,'114000'),(40,'抚顺市',6,'113000'),(41,'本溪市',6,'117000'),(42,'丹东市',6,'118000'),(43,'锦州市',6,'121000'),(44,'营口市',6,'115000'),(45,'阜新市',6,'123000'),(46,'辽阳市',6,'111000'),(47,'盘锦市',6,'124000'),(48,'铁岭市',6,'112000'),(49,'朝阳市',6,'122000'),(50,'葫芦岛市',6,'125000'),(51,'长春市',7,'130000'),(52,'吉林市',7,'132000'),(53,'四平市',7,'136000'),(54,'辽源市',7,'136200'),(55,'通化市',7,'134000'),(56,'白山市',7,'134300'),(57,'松原市',7,'131100'),(58,'白城市',7,'137000'),(59,'延边朝鲜族自治州',7,'133000'),(60,'哈尔滨市',8,'150000'),(61,'齐齐哈尔市',8,'161000'),(62,'鸡西市',8,'158100'),(63,'鹤岗市',8,'154100'),(64,'双鸭山市',8,'155100'),(65,'大庆市',8,'163000'),(66,'伊春市',8,'152300'),(67,'佳木斯市',8,'154000'),(68,'七台河市',8,'154600'),(69,'牡丹江市',8,'157000'),(70,'黑河市',8,'164300'),(71,'绥化市',8,'152000'),(72,'大兴安岭地区',8,'165000'),(73,'上海市',9,'200000'),(74,'南京市',10,'210000'),(75,'无锡市',10,'214000'),(76,'徐州市',10,'221000'),(77,'常州市',10,'213000'),(78,'苏州市',10,'215000'),(79,'南通市',10,'226000'),(80,'连云港市',10,'222000'),(81,'淮安市',10,'223200'),(82,'盐城市',10,'224000'),(83,'扬州市',10,'225000'),(84,'镇江市',10,'212000'),(85,'泰州市',10,'225300'),(86,'宿迁市',10,'223800'),(87,'杭州市',11,'310000'),(88,'宁波市',11,'315000'),(89,'温州市',11,'325000'),(90,'嘉兴市',11,'314000'),(91,'湖州市',11,'313000'),(92,'绍兴市',11,'312000'),(93,'金华市',11,'321000'),(94,'衢州市',11,'324000'),(95,'舟山市',11,'316000'),(96,'台州市',11,'318000'),(97,'丽水市',11,'323000'),(98,'合肥市',12,'230000'),(99,'芜湖市',12,'241000'),(100,'蚌埠市',12,'233000'),(101,'淮南市',12,'232000'),(102,'马鞍山市',12,'243000'),(103,'淮北市',12,'235000'),(104,'铜陵市',12,'244000'),(105,'安庆市',12,'246000'),(106,'黄山市',12,'242700'),(107,'滁州市',12,'239000'),(108,'阜阳市',12,'236100'),(109,'宿州市',12,'234100'),(110,'巢湖市',12,'238000'),(111,'六安市',12,'237000'),(112,'亳州市',12,'236800'),(113,'池州市',12,'247100'),(114,'宣城市',12,'366000'),(115,'福州市',13,'350000'),(116,'厦门市',13,'361000'),(117,'莆田市',13,'351100'),(118,'三明市',13,'365000'),(119,'泉州市',13,'362000'),(120,'漳州市',13,'363000'),(121,'南平市',13,'353000'),(122,'龙岩市',13,'364000'),(123,'宁德市',13,'352100'),(124,'南昌市',14,'330000'),(125,'景德镇市',14,'333000'),(126,'萍乡市',14,'337000'),(127,'九江市',14,'332000'),(128,'新余市',14,'338000'),(129,'鹰潭市',14,'335000'),(130,'赣州市',14,'341000'),(131,'吉安市',14,'343000'),(132,'宜春市',14,'336000'),(133,'抚州市',14,'332900'),(134,'上饶市',14,'334000'),(135,'济南市',15,'250000'),(136,'青岛市',15,'266000'),(137,'淄博市',15,'255000'),(138,'枣庄市',15,'277100'),(139,'东营市',15,'257000'),(140,'烟台市',15,'264000'),(141,'潍坊市',15,'261000'),(142,'济宁市',15,'272100'),(143,'泰安市',15,'271000'),(144,'威海市',15,'265700'),(145,'日照市',15,'276800'),(146,'莱芜市',15,'271100'),(147,'临沂市',15,'276000'),(148,'德州市',15,'253000'),(149,'聊城市',15,'252000'),(150,'滨州市',15,'256600'),(151,'荷泽市',15,'255000'),(152,'郑州市',16,'450000'),(153,'开封市',16,'475000'),(154,'洛阳市',16,'471000'),(155,'平顶山市',16,'467000'),(156,'安阳市',16,'454900'),(157,'鹤壁市',16,'456600'),(158,'新乡市',16,'453000'),(159,'焦作市',16,'454100'),(160,'濮阳市',16,'457000'),(161,'许昌市',16,'461000'),(162,'漯河市',16,'462000'),(163,'三门峡市',16,'472000'),(164,'南阳市',16,'473000'),(165,'商丘市',16,'476000'),(166,'信阳市',16,'464000'),(167,'周口市',16,'466000'),(168,'驻马店市',16,'463000'),(169,'武汉市',17,'430000'),(170,'黄石市',17,'435000'),(171,'十堰市',17,'442000'),(172,'宜昌市',17,'443000'),(173,'襄樊市',17,'441000'),(174,'鄂州市',17,'436000'),(175,'荆门市',17,'448000'),(176,'孝感市',17,'432100'),(177,'荆州市',17,'434000'),(178,'黄冈市',17,'438000'),(179,'咸宁市',17,'437000'),(180,'随州市',17,'441300'),(181,'恩施土家族苗族自治州',17,'445000'),(182,'神农架',17,'442400'),(183,'长沙市',18,'410000'),(184,'株洲市',18,'412000'),(185,'湘潭市',18,'411100'),(186,'衡阳市',18,'421000'),(187,'邵阳市',18,'422000'),(188,'岳阳市',18,'414000'),(189,'常德市',18,'415000'),(190,'张家界市',18,'427000'),(191,'益阳市',18,'413000'),(192,'郴州市',18,'423000'),(193,'永州市',18,'425000'),(194,'怀化市',18,'418000'),(195,'娄底市',18,'417000'),(196,'湘西土家族苗族自治州',18,'416000'),(197,'广州市',19,'510000'),(198,'韶关市',19,'521000'),(199,'深圳市',19,'518000'),(200,'珠海市',19,'519000'),(201,'汕头市',19,'515000'),(202,'佛山市',19,'528000'),(203,'江门市',19,'529000'),(204,'湛江市',19,'524000'),(205,'茂名市',19,'525000'),(206,'肇庆市',19,'526000'),(207,'惠州市',19,'516000'),(208,'梅州市',19,'514000'),(209,'汕尾市',19,'516600'),(210,'河源市',19,'517000'),(211,'阳江市',19,'529500'),(212,'清远市',19,'511500'),(213,'东莞市',19,'511700'),(214,'中山市',19,'528400'),(215,'潮州市',19,'515600'),(216,'揭阳市',19,'522000'),(217,'云浮市',19,'527300'),(218,'南宁市',20,'530000'),(219,'柳州市',20,'545000'),(220,'桂林市',20,'541000'),(221,'梧州市',20,'543000'),(222,'北海市',20,'536000'),(223,'防城港市',20,'538000'),(224,'钦州市',20,'535000'),(225,'贵港市',20,'537100'),(226,'玉林市',20,'537000'),(227,'百色市',20,'533000'),(228,'贺州市',20,'542800'),(229,'河池市',20,'547000'),(230,'来宾市',20,'546100'),(231,'崇左市',20,'532200'),(232,'海口市',21,'570000'),(233,'三亚市',21,'572000'),(234,'重庆市',22,'400000'),(235,'成都市',23,'610000'),(236,'自贡市',23,'643000'),(237,'攀枝花市',23,'617000'),(238,'泸州市',23,'646100'),(239,'德阳市',23,'618000'),(240,'绵阳市',23,'621000'),(241,'广元市',23,'628000'),(242,'遂宁市',23,'629000'),(243,'内江市',23,'641000'),(244,'乐山市',23,'614000'),(245,'南充市',23,'637000'),(246,'眉山市',23,'612100'),(247,'宜宾市',23,'644000'),(248,'广安市',23,'638000'),(249,'达州市',23,'635000'),(250,'雅安市',23,'625000'),(251,'巴中市',23,'635500'),(252,'资阳市',23,'641300'),(253,'阿坝藏族羌族自治州',23,'624600'),(254,'甘孜藏族自治州',23,'626000'),(255,'凉山彝族自治州',23,'615000'),(256,'贵阳市',24,'55000'),(257,'六盘水市',24,'553000'),(258,'遵义市',24,'563000'),(259,'安顺市',24,'561000'),(260,'铜仁地区',24,'554300'),(261,'黔西南布依族苗族自治州',24,'551500'),(262,'毕节地区',24,'551700'),(263,'黔东南苗族侗族自治州',24,'551500'),(264,'黔南布依族苗族自治州',24,'550100'),(265,'昆明市',25,'650000'),(266,'曲靖市',25,'655000'),(267,'玉溪市',25,'653100'),(268,'保山市',25,'678000'),(269,'昭通市',25,'657000'),(270,'丽江市',25,'674100'),(271,'思茅市',25,'665000'),(272,'临沧市',25,'677000'),(273,'楚雄彝族自治州',25,'675000'),(274,'红河哈尼族彝族自治州',25,'654400'),(275,'文山壮族苗族自治州',25,'663000'),(276,'西双版纳傣族自治州',25,'666200'),(277,'大理白族自治州',25,'671000'),(278,'德宏傣族景颇族自治州',25,'678400'),(279,'怒江傈僳族自治州',25,'671400'),(280,'迪庆藏族自治州',25,'674400'),(281,'拉萨市',26,'850000'),(282,'昌都地区',26,'854000'),(283,'山南地区',26,'856000'),(284,'日喀则地区',26,'857000'),(285,'那曲地区',26,'852000'),(286,'阿里地区',26,'859100'),(287,'林芝地区',26,'860100'),(288,'西安市',27,'710000'),(289,'铜川市',27,'727000'),(290,'宝鸡市',27,'721000'),(291,'咸阳市',27,'712000'),(292,'渭南市',27,'714000'),(293,'延安市',27,'716000'),(294,'汉中市',27,'723000'),(295,'榆林市',27,'719000'),(296,'安康市',27,'725000'),(297,'商洛市',27,'711500'),(298,'兰州市',28,'730000'),(299,'嘉峪关市',28,'735100'),(300,'金昌市',28,'737100'),(301,'白银市',28,'730900'),(302,'天水市',28,'741000'),(303,'武威市',28,'733000'),(304,'张掖市',28,'734000'),(305,'平凉市',28,'744000'),(306,'酒泉市',28,'735000'),(307,'庆阳市',28,'744500'),(308,'定西市',28,'743000'),(309,'陇南市',28,'742100'),(310,'临夏回族自治州',28,'731100'),(311,'甘南藏族自治州',28,'747000'),(312,'西宁市',29,'810000'),(313,'海东地区',29,'810600'),(314,'海北藏族自治州',29,'810300'),(315,'黄南藏族自治州',29,'811300'),(316,'海南藏族自治州',29,'813000'),(317,'果洛藏族自治州',29,'814000'),(318,'玉树藏族自治州',29,'815000'),(319,'海西蒙古族藏族自治州',29,'817000'),(320,'银川市',30,'750000'),(321,'石嘴山市',30,'753000'),(322,'吴忠市',30,'751100'),(323,'固原市',30,'756000'),(324,'中卫市',30,'751700'),(325,'乌鲁木齐市',31,'830000'),(326,'克拉玛依市',31,'834000'),(327,'吐鲁番地区',31,'838000'),(328,'哈密地区',31,'839000'),(329,'昌吉回族自治州',31,'831100'),(330,'博尔塔拉蒙古自治州',31,'833400'),(331,'巴音郭楞蒙古自治州',31,'841000'),(332,'阿克苏地区',31,'843000'),(333,'克孜勒苏柯尔克孜自治州',31,'835600'),(334,'喀什地区',31,'844000'),(335,'和田地区',31,'848000'),(336,'伊犁哈萨克自治州',31,'833200'),(337,'塔城地区',31,'834700'),(338,'阿勒泰地区',31,'836500'),(339,'石河子市',31,'832000'),(340,'阿拉尔市',31,'843300'),(341,'图木舒克市',31,'843900'),(342,'五家渠市',31,'831300'),(343,'香港特别行政区',32,'000000'),(344,'澳门特别行政区',33,'000000'),(345,'台湾省',34,'000000');
/*!40000 ALTER TABLE `qm_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_contact_details`
--

DROP TABLE IF EXISTS `qm_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_contact_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `con_position` varchar(255) DEFAULT NULL,
  `address` text,
  `suburb` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `misc` mediumtext,
  `image` varchar(255) DEFAULT NULL,
  `imagepos` varchar(20) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `default_con` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `webpage` varchar(255) NOT NULL DEFAULT '',
  `sortname1` varchar(255) NOT NULL,
  `sortname2` varchar(255) NOT NULL,
  `sortname3` varchar(255) NOT NULL,
  `language` char(7) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_contact_details`
--

LOCK TABLES `qm_contact_details` WRITE;
/*!40000 ALTER TABLE `qm_contact_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_contact_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_content`
--

DROP TABLE IF EXISTS `qm_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `title_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Deprecated in Joomla! 3.0',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `sectionid` int(10) unsigned NOT NULL DEFAULT '0',
  `mask` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `parentid` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_content`
--

LOCK TABLES `qm_content` WRITE;
/*!40000 ALTER TABLE `qm_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_content_frontpage`
--

DROP TABLE IF EXISTS `qm_content_frontpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_content_frontpage`
--

LOCK TABLES `qm_content_frontpage` WRITE;
/*!40000 ALTER TABLE `qm_content_frontpage` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_content_frontpage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_content_rating`
--

DROP TABLE IF EXISTS `qm_content_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_content_rating`
--

LOCK TABLES `qm_content_rating` WRITE;
/*!40000 ALTER TABLE `qm_content_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_content_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_core_log_searches`
--

DROP TABLE IF EXISTS `qm_core_log_searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_core_log_searches` (
  `search_term` varchar(128) NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_core_log_searches`
--

LOCK TABLES `qm_core_log_searches` WRITE;
/*!40000 ALTER TABLE `qm_core_log_searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_core_log_searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_course`
--

DROP TABLE IF EXISTS `qm_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_course` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `banner` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `img1` varchar(255) DEFAULT NULL,
  `img2` varchar(255) DEFAULT NULL,
  `img3` varchar(255) DEFAULT NULL,
  `intro` text NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='è¯¾ç¨‹è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_course`
--

LOCK TABLES `qm_course` WRITE;
/*!40000 ALTER TABLE `qm_course` DISABLE KEYS */;
INSERT INTO `qm_course` VALUES (1,'遇见最美的自己','images/yujianzuimei03.jpg',100.00,'images/course/xc1.png','','','遇见最美的自己\r\nMEET THE BEST OF ME\r\n\r\n如何激活生命内在的力量\r\n如何成为一个具有强大吸引力的磁场\r\n如何找到重建生命的转换器\r\n\r\n人生的三大悲哀是什么\r\n过往生命模式对当下的影响\r\n\r\n了解自己，提升觉知力、觉察力\r\n眼耳鼻舌身意，六大内感官的发现\r\n\r\n你不是你，你是宇宙千万种的面相\r\n每个人都是自己的一面镜子\r\n每个人内在都住着一个英雄\r\n\r\n钻石是你的身份\r\n每一个面都是角色\r\n你比你想象的更强大',1457508192),(2,'觉醒真女人','images/course/juexing_1.jpg',15000.00,'images/course/xc1.png','','','钻石女人\r\n\r\n　　成长第一步  觉醒真女人\r\n\r\n　　女人一生的必修课！\r\n\r\n参加课程你将收获：\r\n\r\n十大疗愈，全面清理女人积累在身体、心灵、情绪的负荷与垃圾学会理解男人的心。\r\n\r\n\r\n获得男人一生的宠爱！\r\n　　\r\n为孩子营造一个成就未来的生长环境！\r\n\r\n享受女人一辈子的幸福！\r\n\r\n实现家族兴旺，富贵传承！\r\n\r\n活出女人的温柔似水、风情万种、性感魔力、灵动可人、活力四射、魅力绽放……',1457503083),(3,'灵魂伴侣','images/course/linghun_1.jpg',20000.00,'images/course/xc1.png','','','钻石伴侣  \r\n\r\n　　成长第三步 灵魂伴侣\r\n\r\n　　天佑家族  从深情走向灵与肉的升华\r\n\r\n　　在经历了第二步的学习后，\r\n你将继续学习通往两性关系更加圆满的深层艺术，从而在真实面对对方及双方的家族时，智慧通达、游刃有余！\r\n\r\n\r\n参加课程你将收获：\r\n\r\n在两性关系中不再刻意表达亲密感，\r\n\r\n彼此可以分享着对方的存在；\r\n\r\n在两性关系中找到心灵深处的存在感，\r\n\r\n彼此产生价值的深度认同和信赖；\r\n\r\n在两性关系中，珍惜灵魂相遇的伴侣感，\r\n\r\n彼此感恩、尊重、学会配合协作；\r\n\r\n在两性关系中享受灵与肉的交融创造，\r\n\r\n洞见灵魂伴侣的神圣意涵，\r\n\r\n实现两个生命共同的升华。',1457508257),(4,'亲密伴侣','images/course/qinmi.jpg',20000.00,'images/course/xc1.png','','','钻石伴侣\r\n\r\n　　成长第二部  亲密伴侣\r\n\r\n　　兴旺家族 从激情走向深情的转化\r\n\r\n\r\n在经历了第一步的学习后，你需要进一步学习：\r\n\r\n　　与伴侣相处时，如何真正转识成智，转化固有的思维和情绪反应模式，从而使双方真正达成身体与心灵零距离的亲密。\r\n\r\n参加课程你将收获：\r\n\r\n解决成长过程中带来的负面潜意识思维习性；\r\n\r\n解决并清理成长过程中积压的情绪毒素；\r\n\r\n排除重大心灵创伤对身体、心灵、家族的伤害；\r\n\r\n解决在两性关系中不协调的性爱体验，\r\n\r\n享受与对方合一的强烈愿望及高品质的爱；\r\n\r\n从亲密的肢体接触中了解对方内在的深层渴求，\r\n\r\n将内在深层情绪通过高品质的交融而得到释放；\r\n\r\n深深走进对方的感受，\r\n\r\n将激活的性能量转换为爱、喜悦、合一、创造的能量；\r\n\r\n了解真正的对方，融合两个个体不同的生命，共同成长。',1457593682),(5,'甜蜜的旅程','images/course/tianmi.jpg',20000.00,'images/course/xc1.png','','','钻石伴侣\r\n\r\n　　成长第一步  甜蜜的旅程\r\n\r\n　　修复家族  从麻木走向感知\r\n\r\n\r\n参加课程你将收获：\r\n\r\n2天回到初恋般的感觉\r\n\r\n了解伴侣关系中的36个黑洞\r\n\r\n清晰伴侣关系中的5个致命伤\r\n\r\n了解伴侣关系中的2大死穴\r\n\r\n收获伴侣关系中4个实修法门技巧\r\n\r\n让你掌握伴侣关系中6条聆听与沟通的黄金定律\r\n\r\n完成伴侣关系中8个层面的解脱\r\n\r\n让你在沟通中能聆听到对方背后的话语\r\n\r\n找回贴心温暖的爱，唤醒人生中最深层的潜能\r\n\r\n享受高品质爱的流动\r\n\r\n从此细腻感受生命中与伴侣相处的美好\r\n\r\n拥抱人生中最珍贵难忘的爱的旅程',1457507741),(6,'由内而外的富足','images/course/kecheng_4191.jpg',1000.00,'images/course/xc1.png','','','实现富足的九大密码：\r\n\r\n★发现\r\n\r\n当你拥有一颗发现之心时，\r\n美，其实就在你的身边！\r\n何时何地，无时无刻，\r\n美总是存在！美总在呈现！\r\n当下的所见所闻稍作停留，\r\n去感受那份美好的感觉！\r\n逝去的能记起那定格的画面，未来的要向往那心中的愿景！\r\n心已远行，给自己的身心放个假！身已远行，试着将自己暂寄远方！\r\n你会发现，\r\n很多美好与奇迹总在发生，\r\n总在你的身边！\r\n\r\n\r\n★赞美\r\n\r\n生命之道在于滋养！\r\n在人生的某个时刻，\r\n或许你会发现，\r\n没有任何东西比让自己的心轻盈自在更为重要！\r\n那一刻你懂得好好享受自己的生命！\r\n学会欣赏\r\n欣赏是内在对他人真正的认可，\r\n欣赏是站在对方立场自我感觉的肯定，\r\n越欣赏越会欣赏！\r\n从你身边的人开始、从你当下的事开始，\r\n当您发现了并由衷地认可、欣赏时，分享就很自然了！\r\n赞美也就更贴切了！\r\n\r\n\r\n★感恩\r\n\r\n世界上一种力量叫“感恩”\r\n它被称为创造奇迹的“魔力”\r\n当放下小我，与宇宙万物融合时，\r\n宇宙的一切资源都可以为我们所用！\r\n生命是一种回声，\r\n你把最好的给予别人，就会从别人那里获得最好的！\r\n感恩是一种处世的哲学，\r\n是生活当中的大智慧，人生在世不可能是一帆风顺的，\r\n种种的失败、无奈，都需要我们勇敢地去面对，豁达地去处理。\r\n只有心怀感恩，生活才能处处富足。\r\n\r\n\r\n★感受\r\n\r\n生命的力量，\r\n从来不是从外部获得，\r\n而是内在火苗的点燃。\r\n那颗种子原本就在，\r\n只是，我们忽略了太久，埋葬了太久！\r\n于是乎，有的人一辈子都把他遗失了，\r\n而只记得疯狂的向外抓取，获得安全感。\r\n学习向内保持，感受自我的力量，一切才可充足、真实、富足。\r\n发现内在的能量，点燃火苗，\r\n无限潜能由内生发，\r\n内在的强大才是真正的生命力量！\r\n\r\n\r\n★接纳\r\n\r\n接纳到底是什么呢？\r\n又要去接纳什么呢？\r\n它的意思是它完完全全地能够面对任何事情的发生，\r\n所有人、事、物的出现，接纳一切所有的发生。\r\n在我们生命的成长过程中，以及我们未知的生命探索中，我们把它当成这样三个词语：\r\n一个是过去，一个是现在，还有一个是未来……\r\n我们用最好的心态，用最好的状态，去面对未知的精彩！\r\n\r\n\r\n★目标\r\n\r\n目标是我们的发动机，\r\n目标是我们的清醒剂，\r\n目标就是助力器，目标，是让你一定要去完成的。\r\n所以这样的一份信念，\r\n让你才会有更大的力量往前走……\r\n目标就是让我们把遗失的孩子找回来。\r\n\r\n你有目标吗？\r\n你有过目标吗？\r\n你足够的渴望吗？\r\n你有坚定的信念吗？\r\n你确定能完成吗？\r\n你确定现在的方法有效吗？\r\n这真的是你发自内心，渴望的吗？\r\n——把这些问句多与自己去对话，问问自己！试试吧！\r\n\r\n\r\n★行动\r\n\r\n只有当你付出的时候，你才会有收获。\r\n行动可以克服一切的恐惧，\r\n一个勇于行动的人，\r\n只要在路上，\r\n没有我们到不了的地方，\r\n我们就一直在路上。\r\n我们持续地去前行，持续地去精进，\r\n只要我们一直往前，\r\n目的地自然会离我们越来越近，\r\n今天你行动了吗？\r\n\r\n\r\n★勇气\r\n\r\n在行动的过程中，我们为什么会有这样的挑战：\r\n困难、压力、障碍等，是什么原因呢？\r\n它们会阻碍我们前行的道路吗？\r\n当我们去行动的时候，注入这份勇气时，\r\n我们就是一个新的开始，\r\n我们没有阻碍，我们只有目标。\r\n勇气和勇敢有什么不一样呢？\r\n一个用尽全力朝自己目标奔跑的人，\r\n他不是没有恐惧，\r\n而是他愿意带着这份恐惧前行，\r\n那这一份力量就叫勇气……\r\n\r\n\r\n★转念\r\n\r\n“一念之转”告诉我们：\r\n凡事没有对错，是更多的选择和更多的空间。\r\n“空”对于我们的一念之转起着什么样的作用呢？\r\n透过四个经典问句，让你轻松获得富足生活：\r\n第一个：那是真的吗？\r\n第二个：你敢肯定那是真的吗？\r\n第三个：当你持有这个想法的时候，你有什么反应呢？\r\n第四个：如果你没有这个想法的时候，你会是什么样的人？\r\n——所有的发生都为祝福我而来。',1461059397),(7,'健康生活真女人','images/course/8bccc968518424a1200d767fecd1e575.jpg',1000.00,NULL,NULL,NULL,'了解自己的生命方程，\r\n掌握自己的生命特质，\r\n清晰自己身体每个组织器官的健康状况，\r\n修复受损的机体，掌握不生病的智慧，\r\n维持最平衡、最活力、最健康的生命状态。',1457591441),(8,'精致女人诗意生活','images/course/b165ccb1610bac449858cf780ad1e87c.jpg',1000.00,NULL,NULL,NULL,'学会享受精致的生活：\r\n\r\n茶道中体味“云霞茶里瞬间空”的境界；\r\n\r\n花道中感受美丽生命传递的纯净能量；\r\n\r\n香道中体味“闻香识女人”的奥妙；\r\n\r\n彩道中，找到自己多样的优雅；\r\n\r\n乐道中聆听灵魂的语言，阐释宇宙奥妙……\r\n\r\n成为一个精致艺术、享受精彩人生的女人。',1457594209),(9,'财富智慧真女人','images/course/caifunvren.jpg',1000.00,NULL,NULL,NULL,'疏通财富流动的障碍，\r\n\r\n打开财富涌入的大门，\r\n\r\n消除你对财富的不安全感，\r\n\r\n与财富源头连接，\r\n\r\n打造你的财富聚宝盆！\r\n\r\n拥有高智慧的财商，\r\n\r\n成为一个兴旺家族的女人。',1457596301),(10,'让事业在梦想中成长','images/course/36020160310160658424.jpg',1000.00,NULL,NULL,NULL,'你和你的事业一样伟大，和你的梦想一样年轻\r\n年轻的梦想不应该被外界的各种条件所干扰\r\n面对社会的选择和旁人的目光，自信才能使你走的更远。\r\n记住一句话：负责任的考虑自己的路，坚持走下去，不要让别人的目光决定你的人生！',1457597508),(11,'心灵成长','images/course/eaa454e920bf173597c915c639c04d4e.jpg',1000.00,NULL,NULL,NULL,'　　追求心灵成长，就是为了活在觉察之中，为了感受和表达爱和感恩，就是为了去创造更多，去体验更多的喜悦，过一种富有意义、和谐而丰盛的生活。\r\n　　另一方面，对心灵成长的追求并不是要忽视或否定世俗生活，而是真正明白，在我们所追求的成功与名誉、权力与财富、安全与满足的背后，我们所真正渴望的是真我的实现，简言之，就是活出我们灵魂的特质——自由、真理、爱和喜悦。',1457598559),(12,'找寻内心真正的渴望','images/course/b0cf8a1a9c7a310067d962f799c44808.jpg',1000.00,NULL,NULL,NULL,'　　在《西游记》中唐僧最经典台词，是他的自我介绍：“贫僧唐三藏，从东土大唐来，到西天取经”。用现代语言解译唐僧的自我介绍，就是要表明：你是谁？你从哪里来？要到哪里去？\r\n\r\n　　这确实是我们每个人都需要搞明白的问题。',1457599796),(13,'孤独的旅程','images/ce32892744200d33851b5db0e0d018ff.jpg',1000.00,NULL,NULL,NULL,'　　人生其实就是一场独自的旅程。一个人来到这个世界，然后将所有是非对错抛下，化作一堆黄土，这是一个无中生有，万有归无的过程。\r\n\r\n　　人应该保持一定的孤独感，因为这是我们的宿命，一切笑、泪、荣、辱都只不过是一段风景而已，都会随着人生列车的前行变为过眼云烟，成为一场记忆。\r\n\r\n　　旅程中要学会去体验不同的风景。人生也是一个不断体验的过程，让自己的内容不断的丰富起来，所以我总是在不断的角色当中转换，在每个角色中都会发下自己的本性，发现自己的可能性，然后我们可能会找到一段最美的旅程，一直走下去。\r\n\r\n　　人生是一个不断了解自己，发现自己的过程。所以总是需要不断的体验不同的角色，当体验的内容足够丰富了，才能发现哪一段是自己应该一直走下去的，这是博与精的对立统一。',1457601064);
/*!40000 ALTER TABLE `qm_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_course_order`
--

DROP TABLE IF EXISTS `qm_course_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_course_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` varchar(255) NOT NULL,
  `out_num` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL DEFAULT '1',
  `intime` int(10) unsigned NOT NULL,
  `create_time` int(10) unsigned NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  `courseid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='è¯¾ç¨‹è®¢å•è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_course_order`
--

LOCK TABLES `qm_course_order` WRITE;
/*!40000 ALTER TABLE `qm_course_order` DISABLE KEYS */;
INSERT INTO `qm_course_order` VALUES (1,'quanmei_course20160124145353',NULL,0,1,1453618433,1453618433,594111915,6),(2,'quanmei_course20160124145412',NULL,0,1,1453618452,1453618452,594111915,6),(3,'quanmei_course20160124145458',NULL,0,1,1453618498,1453618498,594111915,6),(4,'quanmei_course20160124145827',NULL,0,1,1453618707,1453618707,594111915,6),(5,'quanmei_course20160124150313',NULL,0,1,1453618993,1453618993,594111915,6),(6,'quanmei_course20160124150501',NULL,0,1,1453619101,1453619101,594111915,4),(7,'quanmei_course20160124151008',NULL,0,1,1453619408,1453619408,594111915,1),(8,'quanmei_course20160124151108','2016012421001004020043679599',1,1,1453619474,1453619468,594111915,2),(9,'quanmei_course20160124163819','2016012421001004020044514906',1,1,1453624705,1453624699,594111915,4),(10,'quanmei_course20160124164327','2016012421001004020044874441',1,1,1453625014,1453625007,594111915,2),(11,'quanmei_course20160124164348',NULL,0,1,1453625028,1453625028,449039907,5),(12,'quanmei_course20160124164600',NULL,0,1,1453625160,1453625160,449039907,5),(13,'quanmei_course20160124165202',NULL,0,1,1453625522,1453625522,449039907,5),(14,'quanmei_course20160124165213',NULL,0,1,1453625533,1453625533,449039907,5),(15,'quanmei_course20160124165605',NULL,0,1,1453625765,1453625765,449039907,6),(16,'quanmei_course20160124165711',NULL,0,1,1453625831,1453625831,449039907,5),(17,'quanmei_course20160124165936',NULL,0,1,1453625976,1453625976,449039907,5),(18,'quanmei_course20160124165947',NULL,0,1,1453625987,1453625987,449039907,5),(19,'quanmei_course20160124170034',NULL,0,1,1453626034,1453626034,449039907,2),(20,'quanmei_course20160124170043',NULL,0,1,1453626043,1453626043,449039907,6),(21,'quanmei_course20160124170214','2016012421001004710002961081',1,1,1453626142,1453626134,449039907,1),(22,'quanmei_course20160124170457','2016012421001004870028397859',1,1,1453626305,1453626297,599677187,4),(23,'quanmei_course20160124170921','2016012421001004870028300087',1,1,1453626568,1453626561,599677187,4),(24,'quanmei_course20160124171605',NULL,0,1,1453626965,1453626965,746621638,3),(25,'quanmei_course20160124171605',NULL,0,1,1453626965,1453626965,746621638,3),(26,'quanmei_course20160124171605',NULL,0,1,1453626965,1453626965,746621638,3),(27,'quanmei_course20160124171605',NULL,0,1,1453626965,1453626965,746621638,3),(28,'quanmei_course20160124171605',NULL,0,1,1453626965,1453626965,746621638,3),(29,'quanmei_course20160124171606',NULL,0,1,1453626966,1453626966,746621638,3),(30,'quanmei_course20160124171606',NULL,0,1,1453626966,1453626966,746621638,3),(31,'quanmei_course20160124171606',NULL,0,1,1453626966,1453626966,746621638,3),(32,'quanmei_course20160124171606',NULL,0,1,1453626966,1453626966,746621638,3),(33,'quanmei_course20160124171844',NULL,0,1,1453627124,1453627124,746621638,6),(34,'quanmei_course20160124171923',NULL,0,1,1453627163,1453627163,746621638,5),(35,'quanmei_course20160124172328',NULL,0,1,1453627408,1453627408,746621638,3),(36,'quanmei_course20160124172352',NULL,0,1,1453627432,1453627432,746621638,3),(37,'quanmei_course20160124172352',NULL,0,1,1453627432,1453627432,746621638,3),(38,'quanmei_course20160124172353',NULL,0,1,1453627433,1453627433,746621638,3),(39,'quanmei_course20160124172544',NULL,0,1,1453627544,1453627544,746621638,6),(40,'quanmei_course20160124180359',NULL,0,1,1453629839,1453629839,594111915,5),(41,'quanmei_course20160124204221',NULL,0,1,1453639341,1453639341,436942141,4),(42,'quanmei_course20160124204425',NULL,0,1,1453639465,1453639465,436942141,6),(43,'quanmei_course20160124205551',NULL,0,1,1453640151,1453640151,436942141,1),(44,'quanmei_course20160124205731',NULL,0,1,1453640251,1453640251,746621638,1),(45,'quanmei_course20160125151032',NULL,0,1,1453705832,1453705832,594111915,6),(46,'quanmei_course20160125151033',NULL,0,1,1453705833,1453705833,594111915,6),(47,'quanmei_course20160128101136',NULL,0,1,1453947096,1453947096,594111915,3),(48,'quanmei_course20160128111745',NULL,0,1,1453951065,1453951065,594111915,2),(49,'quanmei_course20160128111751',NULL,0,1,1453951071,1453951071,594111915,2),(50,'quanmei_course20160129162043',NULL,0,1,1454055644,1454055644,594111915,2),(51,'quanmei_course20160129162758',NULL,0,1,1454056078,1454056078,594111915,5),(52,'quanmei_course20160129164521','1010040058201601292975734503',1,1,1454057137,1454057121,594111915,5),(53,'quanmei_course20160129165249','1010040058201601292975886533',1,1,1454057580,1454057569,594111915,3),(54,'quanmei_course20160129181723','1010040058201601292977710340',1,1,1454062663,1454062643,594111915,2),(55,'quanmei_course20160201175424',NULL,0,1,1454320465,1454320465,594111915,5),(56,'quanmei_course20160201175419',NULL,0,1,1454320474,1454320474,594111915,5),(57,'quanmei_course20160201175422',NULL,0,1,1454320477,1454320477,594111915,5),(58,'quanmei_course20160201180212','1010040058201602013034446160',1,1,1454320949,1454320933,594111915,2),(59,'quanmei_course20160201180256',NULL,0,1,1454320981,1454320981,594111915,1),(60,'quanmei_course20160201180258',NULL,0,1,1454320984,1454320984,594111915,1),(61,'quanmei_course20160201180253',NULL,0,1,1454320989,1454320989,594111915,1),(62,'quanmei_course20160201180321','1010040058201602013036432912',1,1,1454321016,1454321002,594111915,1),(63,'quanmei_course20160201184246',NULL,0,1,1454323371,1454323371,449039907,5),(64,'quanmei_course20160201184316',NULL,0,1,1454323402,1454323402,449039907,5),(65,'quanmei_course20160201184336',NULL,0,1,1454323422,1454323422,449039907,5),(66,'quanmei_course20160201184956',NULL,0,1,1454323801,1454323801,594111915,5),(67,'quanmei_course20160201185001','1010040058201602013036911252',1,1,1454323814,1454323804,594111915,5),(68,'quanmei_course20160201184959',NULL,0,1,1454323805,1454323805,594111915,5),(69,'quanmei_course20160201185519','2016020121001004710024778627',1,1,1454336380,1454324119,449039907,5),(70,'quanmei_course20160201185628',NULL,0,1,1454324193,1454324193,594111915,4),(71,'quanmei_course20160201185630',NULL,0,1,1454324196,1454324196,594111915,4),(72,'quanmei_course20160201185633',NULL,0,1,1454324198,1454324198,594111915,4),(73,'quanmei_course20160201185700',NULL,0,1,1454324226,1454324226,594111915,3),(74,'quanmei_course20160201185703',NULL,0,1,1454324228,1454324228,594111915,3),(75,'quanmei_course20160201185805','1010040058201602013035028645',1,1,1454324304,1454324287,594111915,1),(76,'quanmei_course20160201185803',NULL,0,1,1454324288,1454324288,594111915,1),(77,'quanmei_course20160201185903',NULL,0,1,1454324347,1454324347,594111915,1),(78,'quanmei_course20160201185905',NULL,0,1,1454324351,1454324351,594111915,1),(79,'quanmei_course20160201185920',NULL,0,1,1454324366,1454324366,594111915,1),(80,'quanmei_course20160201185923',NULL,0,1,1454324369,1454324369,594111915,1),(81,'quanmei_course20160201185943',NULL,0,1,1454324389,1454324389,594111915,1),(82,'quanmei_course20160201185946',NULL,0,1,1454324391,1454324391,594111915,1),(83,'quanmei_course20160201190009','1010040058201602013035051030',1,1,1454324428,1454324410,594111915,4),(84,'quanmei_course20160201190007',NULL,0,1,1454324412,1454324412,594111915,4),(85,'quanmei_course20160201190051','1010040058201602013037022307',1,1,1454324473,1454324451,594111915,6),(86,'quanmei_course20160201193428','1010040058201602013037370805',1,1,1454326485,1454326470,594111915,4),(87,'quanmei_course20160201193426',NULL,0,1,1454326471,1454326471,594111915,4),(88,'quanmei_course20160201193458','1010040058201602013035432817',1,1,1454326518,1454326499,594111915,4),(89,'quanmei_course20160201193454',NULL,0,1,1454326499,1454326499,594111915,4),(90,'quanmei_course20160202101048',NULL,0,1,1454379048,1454379048,594111915,6),(91,'quanmei_course20160202101515','1010040058201602023043517138',1,1,1454379326,1454379316,594111915,5),(92,'quanmei_course20160202101610',NULL,0,1,1454379372,1454379372,594111915,1),(93,'quanmei_course20160202101612','1010040058201602023043525150',1,1,1454379384,1454379375,594111915,1),(94,'quanmei_course20160202101607',NULL,0,1,1454379375,1454379375,594111915,1),(95,'quanmei_course20160202102717',NULL,0,1,1454380043,1454380043,594111915,4),(96,'quanmei_course20160202102720',NULL,0,1,1454380045,1454380045,594111915,4),(97,'quanmei_course20160202102722',NULL,0,1,1454380048,1454380048,594111915,4),(98,'quanmei_course20160202102735','1010040058201602023045532682',1,1,1454380065,1454380055,594111915,4),(99,'quanmei_course20160202102753',NULL,0,1,1454380079,1454380079,594111915,4),(100,'quanmei_course20160202102756',NULL,0,1,1454380080,1454380080,594111915,4),(101,'quanmei_course20160202102807',NULL,0,1,1454380093,1454380093,689620122,5),(102,'quanmei_course20160202102807',NULL,0,1,1454380093,1454380093,594111915,4),(103,'quanmei_course20160202102810','1010040058201602023045540103',1,1,1454380108,1454380095,594111915,4),(104,'quanmei_course20160202102837','1010040058201602023043626237',1,1,1454380133,1454380118,594111915,4),(105,'quanmei_course20160202102948',NULL,0,1,1454380193,1454380193,594111915,4),(106,'quanmei_course20160202102950',NULL,0,1,1454380196,1454380196,594111915,4),(107,'quanmei_course20160202103050',NULL,0,1,1454380255,1454380255,689620122,5),(108,'quanmei_course20160202103503','1006850058201602023045606664',1,1,1454380547,1454380507,689620122,6),(109,'quanmei_course20160202103714','1006850058201602023045614769',1,1,1454380654,1454380636,689620122,5),(110,'quanmei_course20160202103740','1006850058201602023045626267',1,1,1454380680,1454380660,689620122,5),(111,'quanmei_course20160202103744',NULL,0,1,1454380669,1454380669,594111915,4),(112,'quanmei_course20160202103749',NULL,0,1,1454380674,1454380674,594111915,4),(113,'quanmei_course20160202103805','1006850058201602023043699671',1,1,1454380705,1454380688,689620122,6),(114,'quanmei_course20160202103821',NULL,0,1,1454380706,1454380706,594111915,4),(115,'quanmei_course20160202103823',NULL,0,1,1454380709,1454380709,594111915,4),(116,'quanmei_course20160202104917',NULL,0,1,1454381362,1454381362,594111915,2),(117,'quanmei_course20160202104919',NULL,0,1,1454381365,1454381365,594111915,2),(118,'quanmei_course20160202104922',NULL,0,1,1454381367,1454381367,594111915,2),(119,'quanmei_course20160202105415','1010040058201602023043845823',1,1,1454381675,1454381661,594111915,6),(120,'quanmei_course20160202105439','1010040058201602023045776878',1,1,1454381697,1454381685,594111915,6),(121,'quanmei_course20160202105614',NULL,0,1,1454381775,1454381775,594111915,4),(122,'quanmei_course20160202110440',NULL,0,1,1454382280,1454382280,689620122,5),(123,'quanmei_course20160202110450',NULL,0,1,1454382290,1454382290,689620122,5),(124,'quanmei_course20160202111223',NULL,0,1,1454382744,1454382744,594111915,4),(125,'quanmei_course20160202111247',NULL,0,1,1454382767,1454382767,594111915,4),(126,'quanmei_course20160202111505',NULL,0,1,1454382910,1454382910,594111915,1),(127,'quanmei_course20160202111519',NULL,0,1,1454382919,1454382919,594111915,1),(128,'quanmei_course20160202111528',NULL,0,1,1454382933,1454382933,594111915,1),(129,'quanmei_course20160202111540',NULL,0,1,1454382940,1454382940,594111915,1),(130,'quanmei_course20160202111547',NULL,0,1,1454382948,1454382948,594111915,1),(131,'quanmei_course20160202111555',NULL,0,1,1454382960,1454382960,594111915,1),(132,'quanmei_course20160202111609',NULL,0,1,1454382972,1454382972,594111915,5),(133,'quanmei_course20160202112410',NULL,0,1,1454383456,1454383456,594111915,5),(134,'quanmei_course20160202112422','1010040058201602023046053744',1,1,1454383477,1454383464,594111915,5),(135,'quanmei_course20160202112617',NULL,0,3,1454383577,1454383577,594111915,5),(136,'quanmei_course20160222185407',NULL,0,10,1456138447,1456138447,594111915,5),(137,'quanmei_course20160222185418',NULL,0,11,1456138458,1456138458,594111915,2),(138,'quanmei_course20160223152212',NULL,0,1,1456212132,1456212132,594111915,5),(139,'quanmei_course20160223152323',NULL,0,1,1456212209,1456212209,594111915,2),(140,'quanmei_course20160223152326',NULL,0,1,1456212211,1456212211,594111915,2),(141,'quanmei_course20160223152328',NULL,0,1,1456212214,1456212214,594111915,2),(142,'quanmei_course20160225195334',NULL,0,1,1456401220,1456401220,436942141,6),(143,'quanmei_course20160225195337',NULL,0,1,1456401222,1456401222,436942141,6),(144,'quanmei_course20160225195339',NULL,0,1,1456401225,1456401225,436942141,6),(145,'quanmei_course20160225195344',NULL,0,1,1456401230,1456401230,436942141,6),(146,'quanmei_course20160225195347',NULL,0,1,1456401232,1456401232,436942141,6),(147,'quanmei_course20160225195347',NULL,0,1,1456401232,1456401232,436942141,6),(148,'quanmei_course20160225195352',NULL,0,1,1456401238,1456401238,436942141,6),(149,'quanmei_course20160225195355',NULL,0,1,1456401240,1456401240,436942141,6),(150,'quanmei_course20160225195429',NULL,0,1,1456401274,1456401274,436942141,1),(151,'quanmei_course20160225195431',NULL,0,1,1456401277,1456401277,436942141,1),(152,'quanmei_course20160226181921',NULL,0,1,1456481967,1456481967,436942141,6),(153,'quanmei_course20160226181924',NULL,0,1,1456481967,1456481967,436942141,6),(154,'quanmei_course20160226183204',NULL,0,1,1456482724,1456482724,436942141,6),(155,'quanmei_course20160226183228',NULL,0,1,1456482749,1456482749,436942141,6),(156,'quanmei_course20160226183225',NULL,0,1,1456482750,1456482750,436942141,6),(157,'quanmei_course20160226183312',NULL,0,1,1456482797,1456482797,436942141,6),(158,'quanmei_course20160226183309',NULL,0,1,1456482805,1456482805,436942141,6),(159,'quanmei_course20160226183319',NULL,0,1,1456482805,1456482805,436942141,6),(160,'quanmei_course20160226183317',NULL,0,1,1456482812,1456482812,436942141,6),(161,'quanmei_course20160226183326',NULL,0,1,1456482813,1456482813,436942141,6),(162,'quanmei_course20160226183324',NULL,0,1,1456482814,1456482814,436942141,6),(163,'quanmei_course20160226183404',NULL,0,1,1456482845,1456482845,436942141,6),(164,'quanmei_course20160228112056',NULL,0,1,1456629671,1456629671,594111915,5),(165,'quanmei_course20160228112058',NULL,0,1,1456629674,1456629674,594111915,5),(166,'quanmei_course20160228112101',NULL,0,1,1456629677,1456629677,594111915,5),(167,'quanmei_course20160228112400',NULL,0,1,1456629844,1456629844,594111915,5),(168,'quanmei_course20160228112402',NULL,0,1,1456629844,1456629844,594111915,5),(169,'quanmei_course20160228151923',NULL,0,1,1456643965,1456643965,436942141,2),(170,'quanmei_course20160228151920',NULL,0,1,1456643967,1456643967,436942141,2),(171,'quanmei_course20160304230213',NULL,0,1,1457103733,1457103733,746621638,6),(172,'quanmei_course20160309134831',NULL,0,1,1457502519,1457502519,436942141,6),(173,'quanmei_course20160309134829',NULL,0,1,1457502519,1457502519,436942141,6),(174,'quanmei_course20160310095231',NULL,0,1,1457574752,1457574752,436942141,6),(175,'quanmei_course20160312193302',NULL,0,1,1457782382,1457782382,887915923,6),(176,'quanmei_course20160320154643',NULL,0,1,1458460003,1458460003,746621638,6),(177,'quanmei_course20160322112939',NULL,0,1,1458617379,1458617379,746621638,10),(178,'quanmei_course20160413124429',NULL,0,1,1460522669,1460522669,594111915,10),(179,'quanmei_course20160421153007',NULL,0,1,1461223807,1461223807,594111915,6),(180,'quanmei_course20160421153114',NULL,0,1,1461223876,1461223876,594111915,6),(181,'quanmei_course20160421153116',NULL,0,1,1461223876,1461223876,594111915,6),(182,'quanmei_course20160421153347',NULL,0,3,1461224027,1461224027,449039907,6),(183,'quanmei_course20160421153402',NULL,0,1,1461224042,1461224042,449039907,6),(184,'quanmei_course20160421161943',NULL,0,5,1461226783,1461226783,594111915,6),(185,'quanmei_course20160421162035',NULL,0,2,1461226835,1461226835,594111915,6),(186,'quanmei_course20160421162149',NULL,0,1,1461226909,1461226909,594111915,10),(187,'quanmei_course20160421162553',NULL,0,1,1461227153,1461227153,594111915,5),(188,'quanmei_course20160421162743',NULL,0,30,1461227263,1461227263,449039907,5),(189,'quanmei_course20160422101019',NULL,0,9,1461291019,1461291019,990318397,2),(190,'quanmei_course20160506183158',NULL,0,1,1462530718,1462530718,449039907,5),(191,'quanmei_course20160506185413',NULL,0,1,1462532054,1462532054,449039907,7),(192,'quanmei_course20160511142955',NULL,0,1,1462948195,1462948195,449039907,2),(193,'quanmei_course20160511143415',NULL,0,12,1462948455,1462948455,449039907,5),(194,'quanmei_course20160527082200',NULL,0,1,1464308520,1464308520,931055416,6),(195,'quanmei_course20160527082206',NULL,0,1,1464308528,1464308528,931055416,6),(196,'quanmei_course20160527082227',NULL,0,1,1464308547,1464308547,931055416,6),(197,'quanmei_course20160701145758',NULL,0,1,1467356279,1467356279,594111915,6);
/*!40000 ALTER TABLE `qm_course_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_doctor`
--

DROP TABLE IF EXISTS `qm_doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_doctor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hid` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `pos` varchar(255) NOT NULL,
  `direction` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ò½Éú';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_doctor`
--

LOCK TABLES `qm_doctor` WRITE;
/*!40000 ALTER TABLE `qm_doctor` DISABLE KEYS */;
INSERT INTO `qm_doctor` VALUES (15,15,'Jack Chen','美国医学、哲学博士','生物同源性荷尔蒙治疗、细胞抗衰老治疗','images/hospital/kanejackchen06.jpg',1464400984),(16,15,'Greg Harper','澳洲著名健康管理抗衰老专家','免疫细胞抗衰老','images/hospital/kanegeliha02.jpg',1464401143),(17,15,'李三生','楷恩国际健康管理抗衰老高级专家','中医抗衰、美式针灸整脊、神经医学','images/hospital/kanelisansheng08.jpg',1464401390),(18,15,'邱小益','楷恩国际健康管理抗衰老研究院院长','健康管理与天然植物医学研发及应用','images/hospital/kaneqiuxiaoyi01.jpg',1464401556),(19,15,'任博文','美国康奈尔大学博士','基因学、基因检测','images/hospital/kanerenbowen04.jpg',1464401971),(20,15,'王希纶','楷恩国际中医抗衰老专家','美式中医自然疗法、美式针灸、美式整脊','images/hospital/kanewangxilun09.jpg',1464402176),(21,15,'武栋成','楷恩国际健康管理研究院科学家','KANE活性细胞抗衰老','images/hospital/kanewuchengdong05.jpg',1464402615),(22,15,'张宏伟','UICC防癌联盟特聘高级专家','细胞学、血液检测、运动医学','images/hospital/kanezhanghongwei07.jpg',1464402626),(23,15,'周慧君','楷恩国际健康管理研究院副院长','易感基因筛查','images/hospital/kanezhouhuijun03.jpg',1464402637),(24,15,'Alice Xu','皮肤科执业医师','医疗级皮肤管理','images/hospital/kaneAliceXu1.jpg',1464403388),(25,15,'Candy  Li','楷恩健康抗衰专家顾问','健康抗衰方案制定、人体美学方案设计','images/hospital/kaneCandyLi1.jpg',1464403409),(26,15,'陈建名','台湾新生代知名医疗美容医师','注射微整形、脸部提拉整形、面部立体精雕','images/hospital/kanechenjianming.jpg',1464403531),(27,15,'陈勇','亚洲面部精细化整形大师','面部五官综合整形、自体脂肪塑胸','images/hospital/kanechenyong05.jpg',1464403637),(28,15,'崔敏承','韩国艺术造美总统级御用大师','鼻部综合整形、眼脸整形 、面部重塑','images/hospital/kanecuimincheng.jpg',1464403886),(29,15,'崔文武','韩国水凝美肤第一人','医疗级皮肤管理','images/hospital/kanecuiwenwu07.jpg',1464404034),(30,15,'权民晟','韩国外科整形协会核心会员','恩赐纤体 无痕体雕术','images/hospital/kanequanminsheng.jpg',1464404224),(31,15,'桑莉','台湾国立中正大学医学博士','美学形象设计、健康管理指导','images/hospital/kanesangli04.jpg',1465901922),(32,15,'王祥亚','台湾明星级医美领军人物','脂肪移植、颜面整形、注射微整形','images/hospital/kanewangxiangya06.jpg',1464404482),(33,15,'吴云飞','国家一级健康指导师','美学形象设计、健康管理方案设计','images/hospital/kanewuyunfei02.jpg',1464404593),(34,15,'肖英','整形形象设计专家','疤痕修复、毛发移植，私密整形、注射微整','images/hospital/kanexiaoying01.jpg',1464404692),(35,15,'徐舰','香港中文大学修复学博士','微整形美容、中医美容、体雕塑形','images/hospital/kanexujian.jpg',1464404794),(36,15,'张敏婕','医学美容高级形象设计师','医疗美学设计、健康风险解读及方案设计','images/hospital/kanezhangmijie03.jpg',1464405692),(37,6,'雷云飞','整形外科院长','抗衰老、微整形','images/hospital/yixing_ei.jpg',1457076346),(38,6,'都志杰','整形外科院长','面部五官精雕','images/hospital/yixing_du.jpg',1457076423),(39,6,'朱胜军','微整形科院长','注射微整形','images/hospital/yixing_zhushengjun.jpg',1457076526),(40,6,'洪霞','皮肤科院长','皮肤年轻化抗衰老','images/hospital/yixing_hongxia.jpg',1457076633),(41,6,'江贤荣','皮肤专家','面部年轻化','images/hospital/yixing_jiangxianrong.jpg',1457076738),(42,6,'朱姝','皮肤科主任','皮肤美容、抗衰老','images/hospital/yixing_zhushu.jpg',1457081552),(43,5,'许辉','华美院长','乳房整形','images/huamei_xuhui.jpg',1457174887),(44,5,'王红','技术院长','光子美肤','images/hospital/huamei_wanghong.jpg',1457175230),(45,5,'叶子荣','特聘专家','面部年轻化','images/hospital/huamei_yezirong.jpg',1457229994),(46,5,'赵晓兵','整形外科主任','面部年轻化','images/hospital/huamei_zhaoxioabing.jpg',1457230147),(47,5,'杜姜','美肤专家','皮肤美容','images/hospital/huamei_dujiang.jpg',1457230389),(48,5,'范慧慧','美肤管理专家','激光美肤','images/hospital/huamei_fanhuihui.jpg',1457232527),(49,5,'刘琦','面部年轻化专家','面部年轻化','images/hospital/huamei_liuqi.jpg',1457230959),(50,5,'王忠志','微整形教授','面部精雕微整形','images/hospital/huamei_wangzhongzhi.jpg',1457231293),(51,5,'潘贰','教授、美容整形外科学博士','五官整形','images/hospital/huamei_paner.jpg',1457231448),(52,5,'沈干','华美教授','乳房整形、五官整形','images/hospital/huamei_shengan.jpg',1457231615),(53,5,'罗盛康','华美教授','乳房美学','images/hospital/huamei_luoshengkang.jpg',1457231761),(54,5,'曾高','华美教授','鼻部综合整形','images/hospital/huamei_zenggao.jpg',1457231927),(55,4,'郑举卫','主任医师','改脸型，整形修复','images/hospital/170_120516141821_1.jpg',1466592677),(56,4,'王英明','副主任医师','纯韩五官精雕大师','images/hospital/huamei_dengcheng.jpg',1466558549),(57,4,'周仙娥','主任医师','鼻部，美体塑性','images/hospital/zhou.jpg',1466130582),(58,4,'陈明亮','主任医师','抗衰老，面部精雕','images/hospital/chenmingliang.jpg',1466592660),(59,4,'季官学','主任医师','面部除皱、微整形','images/67121281515589.jpg',1466592733),(60,8,'严海','纹绣科主任','面部五官精雕、面部年轻化','images/hospital/xinzhimei_yanhai.jpg',1458289398),(61,8,'刘开山','皮肤科主任','祛斑祛疤、光子嫩肤、面部年轻化、除皱紧肤、病毒性皮肤病等','images/xinzhimei_liukaishan.jpg',1461314662),(62,8,'高波','口腔科主任','口腔正畸、无痛种植牙、牙齿美白','images/hospital/xinzhiemi_gaobo.jpg',1458372542);
/*!40000 ALTER TABLE `qm_doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_extensions`
--

DROP TABLE IF EXISTS `qm_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `element` varchar(100) NOT NULL,
  `folder` varchar(100) NOT NULL,
  `client_id` tinyint(3) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  `access` int(10) unsigned NOT NULL DEFAULT '1',
  `protected` tinyint(3) NOT NULL DEFAULT '0',
  `manifest_cache` text NOT NULL,
  `params` text NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`extension_id`),
  KEY `element_clientid` (`element`,`client_id`),
  KEY `element_folder_clientid` (`element`,`folder`,`client_id`),
  KEY `extension` (`type`,`element`,`folder`,`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10015 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_extensions`
--

LOCK TABLES `qm_extensions` WRITE;
/*!40000 ALTER TABLE `qm_extensions` DISABLE KEYS */;
INSERT INTO `qm_extensions` VALUES (1,'com_mailto','component','com_mailto','',0,1,1,1,'{\"legacy\":false,\"name\":\"com_mailto\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MAILTO_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(2,'com_wrapper','component','com_wrapper','',0,1,1,1,'{\"legacy\":false,\"name\":\"com_wrapper\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_WRAPPER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(3,'com_admin','component','com_admin','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_admin\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_ADMIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(4,'com_banners','component','com_banners','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_banners\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_BANNERS_XML_DESCRIPTION\",\"group\":\"\"}','{\"purchase_type\":\"3\",\"track_impressions\":\"0\",\"track_clicks\":\"0\",\"metakey_prefix\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(5,'com_cache','component','com_cache','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_cache\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CACHE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(6,'com_categories','component','com_categories','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_categories\",\"type\":\"component\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(7,'com_checkin','component','com_checkin','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_checkin\",\"type\":\"component\",\"creationDate\":\"Unknown\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2008 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CHECKIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(8,'com_contact','component','com_contact','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_contact\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CONTACT_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_contact_category\":\"hide\",\"show_contact_list\":\"0\",\"presentation_style\":\"sliders\",\"show_name\":\"1\",\"show_position\":\"1\",\"show_email\":\"0\",\"show_street_address\":\"1\",\"show_suburb\":\"1\",\"show_state\":\"1\",\"show_postcode\":\"1\",\"show_country\":\"1\",\"show_telephone\":\"1\",\"show_mobile\":\"1\",\"show_fax\":\"1\",\"show_webpage\":\"1\",\"show_misc\":\"1\",\"show_image\":\"1\",\"image\":\"\",\"allow_vcard\":\"0\",\"show_articles\":\"0\",\"show_profile\":\"0\",\"show_links\":\"0\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"contact_icons\":\"0\",\"icon_address\":\"\",\"icon_email\":\"\",\"icon_telephone\":\"\",\"icon_mobile\":\"\",\"icon_fax\":\"\",\"icon_misc\":\"\",\"show_headings\":\"1\",\"show_position_headings\":\"1\",\"show_email_headings\":\"0\",\"show_telephone_headings\":\"1\",\"show_mobile_headings\":\"0\",\"show_fax_headings\":\"0\",\"allow_vcard_headings\":\"0\",\"show_suburb_headings\":\"1\",\"show_state_headings\":\"1\",\"show_country_headings\":\"1\",\"show_email_form\":\"1\",\"show_email_copy\":\"1\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"0\",\"redirect\":\"\",\"show_category_crumb\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(9,'com_cpanel','component','com_cpanel','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_cpanel\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CPANEL_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10,'com_installer','component','com_installer','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_installer\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_INSTALLER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(11,'com_languages','component','com_languages','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_languages\",\"type\":\"component\",\"creationDate\":\"2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}','{\"administrator\":\"zh-CN\",\"site\":\"zh-CN\"}','','',0,'0000-00-00 00:00:00',0,0),(12,'com_login','component','com_login','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_login\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(13,'com_media','component','com_media','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_media\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MEDIA_XML_DESCRIPTION\",\"group\":\"\"}','{\"upload_extensions\":\"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\",\"upload_maxsize\":\"10\",\"file_path\":\"images\",\"image_path\":\"images\",\"restrict_uploads\":\"1\",\"allowed_media_usergroup\":\"3\",\"check_mime\":\"1\",\"image_extensions\":\"bmp,gif,jpg,png\",\"ignore_extensions\":\"\",\"upload_mime\":\"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip\",\"upload_mime_illegal\":\"text\\/html\"}','','',0,'0000-00-00 00:00:00',0,0),(14,'com_menus','component','com_menus','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_menus\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MENUS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(15,'com_messages','component','com_messages','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_messages\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MESSAGES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(16,'com_modules','component','com_modules','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_modules\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_MODULES_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(17,'com_newsfeeds','component','com_newsfeeds','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_newsfeeds\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_feed_image\":\"1\",\"show_feed_description\":\"1\",\"show_item_description\":\"1\",\"feed_word_count\":\"0\",\"show_headings\":\"1\",\"show_name\":\"1\",\"show_articles\":\"0\",\"show_link\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"display_num\":\"\",\"show_pagination_limit\":\"1\",\"show_pagination\":\"1\",\"show_pagination_results\":\"1\",\"show_cat_items\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(18,'com_plugins','component','com_plugins','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_plugins\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_PLUGINS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(19,'com_search','component','com_search','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_search\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_SEARCH_XML_DESCRIPTION\",\"group\":\"\"}','{\"enabled\":\"0\",\"show_date\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(20,'com_templates','component','com_templates','',1,1,1,1,'{\"legacy\":false,\"name\":\"com_templates\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_TEMPLATES_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(21,'com_weblinks','component','com_weblinks','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_weblinks\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_comp_description\":\"1\",\"comp_description\":\"\",\"show_link_hits\":\"1\",\"show_link_description\":\"1\",\"show_other_cats\":\"0\",\"show_headings\":\"0\",\"show_numbers\":\"0\",\"show_report\":\"1\",\"count_clicks\":\"1\",\"target\":\"0\",\"link_icons\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(22,'com_content','component','com_content','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_content\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}','{\"article_layout\":\"_:default\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"1\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"1\",\"show_item_navigation\":\"1\",\"show_vote\":\"0\",\"show_readmore\":\"1\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"100\",\"show_icons\":\"1\",\"show_print_icon\":\"1\",\"show_email_icon\":\"1\",\"show_hits\":\"1\",\"show_noauth\":\"0\",\"show_publishing_options\":\"1\",\"show_article_options\":\"1\",\"show_urls_images_frontend\":\"0\",\"show_urls_images_backend\":\"1\",\"targeta\":0,\"targetb\":0,\"targetc\":0,\"float_intro\":\"left\",\"float_fulltext\":\"left\",\"category_layout\":\"_:blog\",\"show_category_title\":\"0\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"maxLevel\":\"1\",\"show_empty_categories\":\"0\",\"show_no_articles\":\"1\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"0\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"1\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"0\",\"show_subcategory_content\":\"0\",\"show_pagination_limit\":\"1\",\"filter_field\":\"hide\",\"show_headings\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"1\",\"list_show_author\":\"1\",\"orderby_pri\":\"order\",\"orderby_sec\":\"rdate\",\"order_date\":\"published\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_feed_link\":\"1\",\"feed_summary\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(23,'com_config','component','com_config','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_config\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_CONFIG_XML_DESCRIPTION\",\"group\":\"\"}','{\"filters\":{\"1\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"6\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"7\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"2\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"3\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"4\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"5\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"10\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"12\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"8\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"}}}','','',0,'0000-00-00 00:00:00',0,0),(24,'com_redirect','component','com_redirect','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_redirect\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(25,'com_users','component','com_users','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_users\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_USERS_XML_DESCRIPTION\",\"group\":\"\"}','{\"allowUserRegistration\":\"1\",\"new_usertype\":\"2\",\"guest_usergroup\":\"1\",\"sendpassword\":\"1\",\"useractivation\":\"2\",\"mail_to_admin\":\"1\",\"captcha\":\"\",\"frontend_userparams\":\"1\",\"site_language\":\"0\",\"change_login_name\":\"0\",\"reset_count\":\"10\",\"reset_time\":\"1\",\"mailSubjectPrefix\":\"\",\"mailBodySuffix\":\"\"}','','',0,'0000-00-00 00:00:00',0,0),(27,'com_finder','component','com_finder','',1,1,0,0,'{\"legacy\":false,\"name\":\"com_finder\",\"type\":\"component\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_FINDER_XML_DESCRIPTION\",\"group\":\"\"}','{\"show_description\":\"1\",\"description_length\":255,\"allow_empty_query\":\"0\",\"show_url\":\"1\",\"show_advanced\":\"1\",\"expand_advanced\":\"0\",\"show_date_filters\":\"0\",\"highlight_terms\":\"1\",\"opensearch_name\":\"\",\"opensearch_description\":\"\",\"batch_size\":\"50\",\"memory_table_limit\":30000,\"title_multiplier\":\"1.7\",\"text_multiplier\":\"0.7\",\"meta_multiplier\":\"1.2\",\"path_multiplier\":\"2.0\",\"misc_multiplier\":\"0.3\",\"stemmer\":\"snowball\"}','','',0,'0000-00-00 00:00:00',0,0),(28,'com_joomlaupdate','component','com_joomlaupdate','',1,1,0,1,'{\"legacy\":false,\"name\":\"com_joomlaupdate\",\"type\":\"component\",\"creationDate\":\"February 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"COM_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(100,'PHPMailer','library','phpmailer','',0,1,1,1,'{\"legacy\":false,\"name\":\"PHPMailer\",\"type\":\"library\",\"creationDate\":\"2001\",\"author\":\"PHPMailer\",\"copyright\":\"(c) 2001-2003, Brent R. Matzelle, (c) 2004-2009, Andy Prevost. All Rights Reserved., (c) 2010-2011, Jim Jagielski. All Rights Reserved.\",\"authorEmail\":\"jimjag@gmail.com\",\"authorUrl\":\"https:\\/\\/code.google.com\\/a\\/apache-extras.org\\/p\\/phpmailer\\/\",\"version\":\"5.2\",\"description\":\"LIB_PHPMAILER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(101,'SimplePie','library','simplepie','',0,1,1,1,'{\"legacy\":false,\"name\":\"SimplePie\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"SimplePie\",\"copyright\":\"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/simplepie.org\\/\",\"version\":\"1.2\",\"description\":\"LIB_SIMPLEPIE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(102,'phputf8','library','phputf8','',0,1,1,1,'{\"legacy\":false,\"name\":\"phputf8\",\"type\":\"library\",\"creationDate\":\"2006\",\"author\":\"Harry Fuecks\",\"copyright\":\"Copyright various authors\",\"authorEmail\":\"hfuecks@gmail.com\",\"authorUrl\":\"http:\\/\\/sourceforge.net\\/projects\\/phputf8\",\"version\":\"0.5\",\"description\":\"LIB_PHPUTF8_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(103,'Joomla! Platform','library','joomla','',0,1,1,1,'{\"legacy\":false,\"name\":\"Joomla! Platform\",\"type\":\"library\",\"creationDate\":\"2008\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"http:\\/\\/www.joomla.org\",\"version\":\"11.4\",\"description\":\"LIB_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(200,'mod_articles_archive','module','mod_articles_archive','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_archive\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters.\\n\\t\\tAll rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(201,'mod_articles_latest','module','mod_articles_latest','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LATEST_NEWS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(202,'mod_articles_popular','module','mod_articles_popular','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_articles_popular\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(203,'mod_banners','module','mod_banners','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_banners\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_BANNERS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(204,'mod_breadcrumbs','module','mod_breadcrumbs','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_breadcrumbs\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_BREADCRUMBS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(205,'mod_custom','module','mod_custom','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(206,'mod_feed','module','mod_feed','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(207,'mod_footer','module','mod_footer','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_footer\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FOOTER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(208,'mod_login','module','mod_login','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(209,'mod_menu','module','mod_menu','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(210,'mod_articles_news','module','mod_articles_news','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_articles_news\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_NEWS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(211,'mod_random_image','module','mod_random_image','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_random_image\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_RANDOM_IMAGE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(212,'mod_related_items','module','mod_related_items','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_related_items\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_RELATED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(213,'mod_search','module','mod_search','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_search\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_SEARCH_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(214,'mod_stats','module','mod_stats','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_stats\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(215,'mod_syndicate','module','mod_syndicate','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_syndicate\",\"type\":\"module\",\"creationDate\":\"May 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_SYNDICATE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(216,'mod_users_latest','module','mod_users_latest','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_users_latest\",\"type\":\"module\",\"creationDate\":\"December 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_USERS_LATEST_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(217,'mod_weblinks','module','mod_weblinks','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_weblinks\",\"type\":\"module\",\"creationDate\":\"July 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(218,'mod_whosonline','module','mod_whosonline','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_whosonline\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_WHOSONLINE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(219,'mod_wrapper','module','mod_wrapper','',0,1,1,0,'{\"legacy\":false,\"name\":\"mod_wrapper\",\"type\":\"module\",\"creationDate\":\"October 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_WRAPPER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(220,'mod_articles_category','module','mod_articles_category','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_category\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(221,'mod_articles_categories','module','mod_articles_categories','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_articles_categories\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(222,'mod_languages','module','mod_languages','',0,1,1,1,'{\"legacy\":false,\"name\":\"mod_languages\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(223,'mod_finder','module','mod_finder','',0,1,0,0,'{\"legacy\":false,\"name\":\"mod_finder\",\"type\":\"module\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FINDER_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(300,'mod_custom','module','mod_custom','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(301,'mod_feed','module','mod_feed','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(302,'mod_latest','module','mod_latest','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LATEST_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(303,'mod_logged','module','mod_logged','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_logged\",\"type\":\"module\",\"creationDate\":\"January 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LOGGED_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(304,'mod_login','module','mod_login','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"March 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(305,'mod_menu','module','mod_menu','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(307,'mod_popular','module','mod_popular','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_popular\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(308,'mod_quickicon','module','mod_quickicon','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_quickicon\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_QUICKICON_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(309,'mod_status','module','mod_status','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_status\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_STATUS_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(310,'mod_submenu','module','mod_submenu','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_submenu\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_SUBMENU_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(311,'mod_title','module','mod_title','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_title\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_TITLE_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(312,'mod_toolbar','module','mod_toolbar','',1,1,1,1,'{\"legacy\":false,\"name\":\"mod_toolbar\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_TOOLBAR_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(313,'mod_multilangstatus','module','mod_multilangstatus','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_multilangstatus\",\"type\":\"module\",\"creationDate\":\"September 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_MULTILANGSTATUS_XML_DESCRIPTION\",\"group\":\"\"}','{\"cache\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(314,'mod_version','module','mod_version','',1,1,1,0,'{\"legacy\":false,\"name\":\"mod_version\",\"type\":\"module\",\"creationDate\":\"January 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"MOD_VERSION_XML_DESCRIPTION\",\"group\":\"\"}','{\"format\":\"short\",\"product\":\"1\",\"cache\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(400,'plg_authentication_gmail','plugin','gmail','authentication',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_authentication_gmail\",\"type\":\"plugin\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_GMAIL_XML_DESCRIPTION\",\"group\":\"\"}','{\"applysuffix\":\"0\",\"suffix\":\"\",\"verifypeer\":\"1\",\"user_blacklist\":\"\"}','','',0,'0000-00-00 00:00:00',1,0),(401,'plg_authentication_joomla','plugin','joomla','authentication',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_authentication_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_AUTH_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(402,'plg_authentication_ldap','plugin','ldap','authentication',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_authentication_ldap\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_LDAP_XML_DESCRIPTION\",\"group\":\"\"}','{\"host\":\"\",\"port\":\"389\",\"use_ldapV3\":\"0\",\"negotiate_tls\":\"0\",\"no_referrals\":\"0\",\"auth_method\":\"bind\",\"base_dn\":\"\",\"search_string\":\"\",\"users_dn\":\"\",\"username\":\"admin\",\"password\":\"bobby7\",\"ldap_fullname\":\"fullName\",\"ldap_email\":\"mail\",\"ldap_uid\":\"uid\"}','','',0,'0000-00-00 00:00:00',3,0),(404,'plg_content_emailcloak','plugin','emailcloak','content',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_content_emailcloak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION\",\"group\":\"\"}','{\"mode\":\"1\"}','','',0,'0000-00-00 00:00:00',1,0),(405,'plg_content_geshi','plugin','geshi','content',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_content_geshi\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"qbnz.com\\/highlighter\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_GESHI_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(406,'plg_content_loadmodule','plugin','loadmodule','content',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_content_loadmodule\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_LOADMODULE_XML_DESCRIPTION\",\"group\":\"\"}','{\"style\":\"xhtml\"}','','',0,'2011-09-18 15:22:50',0,0),(407,'plg_content_pagebreak','plugin','pagebreak','content',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_content_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\"}','{\"title\":\"1\",\"multipage_toc\":\"1\",\"showall\":\"1\"}','','',0,'0000-00-00 00:00:00',4,0),(408,'plg_content_pagenavigation','plugin','pagenavigation','content',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_content_pagenavigation\",\"type\":\"plugin\",\"creationDate\":\"January 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_PAGENAVIGATION_XML_DESCRIPTION\",\"group\":\"\"}','{\"position\":\"1\"}','','',0,'0000-00-00 00:00:00',5,0),(409,'plg_content_vote','plugin','vote','content',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_content_vote\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_VOTE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',6,0),(410,'plg_editors_codemirror','plugin','codemirror','editors',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors_codemirror\",\"type\":\"plugin\",\"creationDate\":\"28 March 2011\",\"author\":\"Marijn Haverbeke\",\"copyright\":\"\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"PLG_CODEMIRROR_XML_DESCRIPTION\",\"group\":\"\"}','{\"linenumbers\":\"0\",\"tabmode\":\"indent\"}','','',0,'0000-00-00 00:00:00',1,0),(411,'plg_editors_none','plugin','none','editors',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors_none\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Unknown\",\"copyright\":\"\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"\",\"version\":\"2.5.0\",\"description\":\"PLG_NONE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(412,'plg_editors_tinymce','plugin','tinymce','editors',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors_tinymce\",\"type\":\"plugin\",\"creationDate\":\"2005-2014\",\"author\":\"Moxiecode Systems AB\",\"copyright\":\"Moxiecode Systems AB\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"tinymce.moxiecode.com\\/\",\"version\":\"3.5.11\",\"description\":\"PLG_TINY_XML_DESCRIPTION\",\"group\":\"\"}','{\"mode\":\"1\",\"skin\":\"0\",\"entity_encoding\":\"raw\",\"lang_mode\":\"0\",\"lang_code\":\"en\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"extended_elements\":\"\",\"toolbar\":\"top\",\"toolbar_align\":\"left\",\"html_height\":\"550\",\"html_width\":\"750\",\"resizing\":\"true\",\"resize_horizontal\":\"false\",\"element_path\":\"1\",\"fonts\":\"1\",\"paste\":\"1\",\"searchreplace\":\"1\",\"insertdate\":\"1\",\"format_date\":\"%Y-%m-%d\",\"inserttime\":\"1\",\"format_time\":\"%H:%M:%S\",\"colors\":\"1\",\"table\":\"1\",\"smilies\":\"1\",\"media\":\"1\",\"hr\":\"1\",\"directionality\":\"1\",\"fullscreen\":\"1\",\"style\":\"1\",\"layer\":\"1\",\"xhtmlxtras\":\"1\",\"visualchars\":\"1\",\"nonbreaking\":\"1\",\"template\":\"1\",\"blockquote\":\"1\",\"wordcount\":\"1\",\"advimage\":\"1\",\"advlink\":\"1\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"inlinepopups\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"}','','',0,'0000-00-00 00:00:00',3,0),(413,'plg_editors-xtd_article','plugin','article','editors-xtd',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_editors-xtd_article\",\"type\":\"plugin\",\"creationDate\":\"October 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_ARTICLE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(414,'plg_editors-xtd_image','plugin','image','editors-xtd',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_editors-xtd_image\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_IMAGE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(415,'plg_editors-xtd_pagebreak','plugin','pagebreak','editors-xtd',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_editors-xtd_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',3,0),(416,'plg_editors-xtd_readmore','plugin','readmore','editors-xtd',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_editors-xtd_readmore\",\"type\":\"plugin\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_READMORE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',4,0),(417,'plg_search_categories','plugin','categories','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_categories\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(418,'plg_search_contacts','plugin','contacts','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_contacts\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_CONTACTS_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(419,'plg_search_content','plugin','content','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_content\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(420,'plg_search_newsfeeds','plugin','newsfeeds','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(421,'plg_search_weblinks','plugin','weblinks','search',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_search_weblinks\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEARCH_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(422,'plg_system_languagefilter','plugin','languagefilter','system',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_system_languagefilter\",\"type\":\"plugin\",\"creationDate\":\"July 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(423,'plg_system_p3p','plugin','p3p','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_p3p\",\"type\":\"plugin\",\"creationDate\":\"September 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_P3P_XML_DESCRIPTION\",\"group\":\"\"}','{\"headers\":\"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM\"}','','',0,'0000-00-00 00:00:00',2,0),(424,'plg_system_cache','plugin','cache','system',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_system_cache\",\"type\":\"plugin\",\"creationDate\":\"February 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CACHE_XML_DESCRIPTION\",\"group\":\"\"}','{\"browsercache\":\"0\",\"cachetime\":\"15\"}','','',0,'0000-00-00 00:00:00',9,0),(425,'plg_system_debug','plugin','debug','system',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_system_debug\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_DEBUG_XML_DESCRIPTION\",\"group\":\"\"}','{\"profile\":\"1\",\"queries\":\"1\",\"memory\":\"1\",\"language_files\":\"1\",\"language_strings\":\"1\",\"strip-first\":\"1\",\"strip-prefix\":\"\",\"strip-suffix\":\"\"}','','',0,'0000-00-00 00:00:00',4,0),(426,'plg_system_log','plugin','log','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_log\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_LOG_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',5,0),(427,'plg_system_redirect','plugin','redirect','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_redirect\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',6,0),(428,'plg_system_remember','plugin','remember','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_remember\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_REMEMBER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',7,0),(429,'plg_system_sef','plugin','sef','system',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_system_sef\",\"type\":\"plugin\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SEF_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',8,0),(430,'plg_system_logout','plugin','logout','system',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_system_logout\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',3,0),(431,'plg_user_contactcreator','plugin','contactcreator','user',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_user_contactcreator\",\"type\":\"plugin\",\"creationDate\":\"August 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTACTCREATOR_XML_DESCRIPTION\",\"group\":\"\"}','{\"autowebpage\":\"\",\"category\":\"34\",\"autopublish\":\"0\"}','','',0,'0000-00-00 00:00:00',1,0),(432,'plg_user_joomla','plugin','joomla','user',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_user_joomla\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2009 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_USER_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{\"autoregister\":\"1\"}','','',0,'0000-00-00 00:00:00',2,0),(433,'plg_user_profile','plugin','profile','user',0,0,1,1,'{\"legacy\":false,\"name\":\"plg_user_profile\",\"type\":\"plugin\",\"creationDate\":\"January 2008\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_USER_PROFILE_XML_DESCRIPTION\",\"group\":\"\"}','{\"register-require_address1\":\"1\",\"register-require_address2\":\"1\",\"register-require_city\":\"1\",\"register-require_region\":\"1\",\"register-require_country\":\"1\",\"register-require_postal_code\":\"1\",\"register-require_phone\":\"1\",\"register-require_website\":\"1\",\"register-require_favoritebook\":\"1\",\"register-require_aboutme\":\"1\",\"register-require_tos\":\"1\",\"register-require_dob\":\"1\",\"profile-require_address1\":\"1\",\"profile-require_address2\":\"1\",\"profile-require_city\":\"1\",\"profile-require_region\":\"1\",\"profile-require_country\":\"1\",\"profile-require_postal_code\":\"1\",\"profile-require_phone\":\"1\",\"profile-require_website\":\"1\",\"profile-require_favoritebook\":\"1\",\"profile-require_aboutme\":\"1\",\"profile-require_tos\":\"1\",\"profile-require_dob\":\"1\"}','','',0,'0000-00-00 00:00:00',0,0),(434,'plg_extension_joomla','plugin','joomla','extension',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_extension_joomla\",\"type\":\"plugin\",\"creationDate\":\"May 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(435,'plg_content_joomla','plugin','joomla','content',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_content_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(436,'plg_system_languagecode','plugin','languagecode','system',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_system_languagecode\",\"type\":\"plugin\",\"creationDate\":\"November 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',10,0),(437,'plg_quickicon_joomlaupdate','plugin','joomlaupdate','quickicon',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_quickicon_joomlaupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(438,'plg_quickicon_extensionupdate','plugin','extensionupdate','quickicon',0,1,1,1,'{\"legacy\":false,\"name\":\"plg_quickicon_extensionupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(439,'plg_captcha_recaptcha','plugin','recaptcha','captcha',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_captcha_recaptcha\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION\",\"group\":\"\"}','{\"public_key\":\"\",\"private_key\":\"\",\"theme\":\"clean\"}','','',0,'0000-00-00 00:00:00',0,0),(440,'plg_system_highlight','plugin','highlight','system',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_system_highlight\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',7,0),(441,'plg_content_finder','plugin','finder','content',0,0,1,0,'{\"legacy\":false,\"name\":\"plg_content_finder\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_CONTENT_FINDER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(442,'plg_finder_categories','plugin','categories','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_categories\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',1,0),(443,'plg_finder_contacts','plugin','contacts','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_contacts\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_CONTACTS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',2,0),(444,'plg_finder_content','plugin','content','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_content\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',3,0),(445,'plg_finder_newsfeeds','plugin','newsfeeds','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',4,0),(446,'plg_finder_weblinks','plugin','weblinks','finder',0,1,1,0,'{\"legacy\":false,\"name\":\"plg_finder_weblinks\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PLG_FINDER_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',5,0),(500,'atomic','template','atomic','',0,1,1,0,'{\"legacy\":false,\"name\":\"atomic\",\"type\":\"template\",\"creationDate\":\"10\\/10\\/09\",\"author\":\"Ron Severdia\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"contact@kontentdesign.com\",\"authorUrl\":\"http:\\/\\/www.kontentdesign.com\",\"version\":\"2.5.0\",\"description\":\"TPL_ATOMIC_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(502,'bluestork','template','bluestork','',1,1,1,0,'{\"legacy\":false,\"name\":\"bluestork\",\"type\":\"template\",\"creationDate\":\"07\\/02\\/09\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"TPL_BLUESTORK_XML_DESCRIPTION\",\"group\":\"\"}','{\"useRoundedCorners\":\"1\",\"showSiteName\":\"0\",\"textBig\":\"0\",\"highContrast\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(503,'beez_20','template','beez_20','',0,1,1,0,'{\"legacy\":false,\"name\":\"beez_20\",\"type\":\"template\",\"creationDate\":\"25 November 2009\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"2.5.0\",\"description\":\"TPL_BEEZ2_XML_DESCRIPTION\",\"group\":\"\"}','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"templatecolor\":\"nature\"}','','',0,'0000-00-00 00:00:00',0,0),(504,'hathor','template','hathor','',1,1,1,0,'{\"legacy\":false,\"name\":\"hathor\",\"type\":\"template\",\"creationDate\":\"May 2010\",\"author\":\"Andrea Tarr\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"hathor@tarrconsulting.com\",\"authorUrl\":\"http:\\/\\/www.tarrconsulting.com\",\"version\":\"2.5.0\",\"description\":\"TPL_HATHOR_XML_DESCRIPTION\",\"group\":\"\"}','{\"showSiteName\":\"0\",\"colourChoice\":\"0\",\"boldText\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(505,'beez5','template','beez5','',0,1,1,0,'{\"legacy\":false,\"name\":\"beez5\",\"type\":\"template\",\"creationDate\":\"21 May 2010\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"2.5.0\",\"description\":\"TPL_BEEZ5_XML_DESCRIPTION\",\"group\":\"\"}','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"html5\":\"0\"}','','',0,'0000-00-00 00:00:00',0,0),(600,'English (United Kingdom)','language','en-GB','',0,1,1,1,'{\"legacy\":false,\"name\":\"English (United Kingdom)\",\"type\":\"language\",\"creationDate\":\"2008-03-15\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.28\",\"description\":\"en-GB site language\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(601,'English (United Kingdom)','language','en-GB','',1,1,1,1,'{\"legacy\":false,\"name\":\"English (United Kingdom)\",\"type\":\"language\",\"creationDate\":\"2008-03-15\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.28\",\"description\":\"en-GB administrator language\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(700,'files_joomla','file','joomla','',0,1,1,1,'{\"legacy\":false,\"name\":\"files_joomla\",\"type\":\"file\",\"creationDate\":\"December 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.28\",\"description\":\"FILES_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(800,'PKG_JOOMLA','package','pkg_joomla','',0,1,1,1,'{\"legacy\":false,\"name\":\"PKG_JOOMLA\",\"type\":\"package\",\"creationDate\":\"2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"http:\\/\\/www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"PKG_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(900,'PLG_EOSNOTIFY','plugin','eosnotify','quickicon',0,1,1,1,'{\"legacy\":false,\"name\":\"PLG_EOSNOTIFY\",\"type\":\"plugin\",\"creationDate\":\"October 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"2.5.0\",\"description\":\"End of Support Notifier\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10000,'','language','zh-CN','',0,1,0,0,'{\"legacy\":true,\"name\":\"\\u7b80\\u4f53\\u4e2d\\u6587\",\"type\":\"language\",\"creationDate\":\"2013-04-15\",\"author\":\"CHN Translation Team\",\"copyright\":\"Copyright (C) 2010 CHN Joomla Translation Team  (http:\\/\\/joomlacode.org\\/gf\\/project\\/choice\\/). All rights reserved.\",\"authorEmail\":\"zhous1998@sohu.com\",\"authorUrl\":\"www.joomla.cn\",\"version\":\"2.5.20.1\",\"description\":\"\\n    \\n<div align=\\\"center\\\">\\n <table border=\\\"0\\\" width=\\\"90%\\\">\\n  <table width=\\\"100%\\\" border=\\\"0\\\">\\n  <tr>\\n    <td colspan=\\\"2\\\">Chinese language for Joomla 1.6 back-end. Translated by CHN Joomla Translation Team, one of Joomla Accredited Translations.<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">Joomla 2.5 \\u7b80\\u4f53\\u4e2d\\u6587\\u8bed\\u8a00\\u662f\\u7531Joomla\\u6388\\u6743\\u7ffb\\u8bd1\\u7ec4\\u7684Derek Joe\\u5728Joomla 1.6\\u7ffb\\u8bd1\\u5de5\\u4f5c\\u7684\\u57fa\\u7840\\u4e0a\\u8865\\u5145\\u7ffb\\u8bd1\\u3002<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">Joomla 2.5\\u7b80\\u4f53\\u4e2d\\u6587\\u8bed\\u8a00\\u5305\\u7684\\u4e3b\\u8981\\u8d21\\u732e\\u4eba\\uff1a<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u524d\\u53f0\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/wuyujie\\/\\\" target=\\\"_blank\\\">\\u6b66\\u7389\\u6770<\\/a>(wuyujie)\\u3001 <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/gzpan123\\/\\\" target=\\\"_blank\\\">\\u90ed\\u5fd7\\u6500<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u540e\\u53f0\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/keydiagram\\/\\\" target=\\\"_blank\\\">Key Diagram<\\/a>\\u3001<a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/tchyusuf\\/\\\">Yusuf  Wang<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u5b89\\u88c5\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/freechoice\\/\\\" target=\\\"_blank\\\">Johnathan Cheun<\\/a>\\u3001<a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/tchyusuf\\/\\\">Yusuf  Wang<\\/a>\\u3001 <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/zhous\\/\\\" target=\\\"_blank\\\">Derek Joe<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u793a\\u8303\\u5185\\u5bb9\\u53ca\\u7f16\\u8f91\\u5668\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/zhous\\/\\\" target=\\\"_blank\\\">Derek Joe<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u591a\\u8c22\\u5927\\u5bb6\\u7684\\u8f9b\\u52e4\\u52b3\\u52a8\\uff01\\u8c22\\u8c22wayne82\\u7684\\u53cd\\u9988\\u4e0e\\u5efa\\u8bae\\uff01<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td width=\\\"132\\\"><p><a href=\\\"http:\\/\\/www.joomla.cn\\/index.php?option=com_kunena&func=showcat&catid=34&Itemid=46&lang=zh\\\" target=\\\"_blank\\\"><img src=\\\"http:\\/\\/www.joomla.cn\\/images\\/aboutjoomlacn.png\\\" alt=\\\"\\u56e7\\u5566!\\u4e2d\\u56fd\\\" width=\\\"130\\\" height=\\\"70\\\" align=\\\"left\\\" longdesc=\\\"http:\\/\\/www.joomla.cn\\\"><br \\/>\\n    <\\/a><\\/p><\\/td>\\n    <td valign=\\\"middle\\\"><a href=\\\"http:\\/\\/www.joomla.cn\\/index.php?option=com_kunena&func=showcat&catid=34&Itemid=46&lang=zh\\\" target=\\\"_blank\\\">Joomla\\u53ca\\u5176\\u6269\\u5c55\\u6c49\\u5316\\u7684\\u5206\\u4eab\\u4e0e\\u8ba8\\u8bba\\u8bf7\\u8bbf\\u95ee\\\"\\u56e7\\u5566!\\u4e2d\\u56fd\\\"<\\/a><br \\/>\\n      <b>\\u6b22\\u8fce\\u559c\\u6b22\\u7ffb\\u8bd1\\u4e14\\u61c2\\u5f97\\u4f7f\\u7528SVN\\u7684\\u670b\\u53cb<\\/b><br \\/>\\n    <a href=\\\"http:\\/\\/www.joomla.cn\\/index.php?option=com_kunena&func=view&catid=34&id=9537&Itemid=46\\\" target=\\\"_blank\\\"><b>\\u52a0\\u5165\\u6211\\u4eec\\u7684\\u7ffb\\u8bd1\\u7ec4\\uff08\\u771f\\u6b63\\u81ea\\u4e3b\\u7684\\u534f\\u4f5c\\u65b9\\u5f0f\\uff09<\\/b><\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">&nbsp;<\\/td>\\n  <\\/tr>\\n<\\/table>\\n <\\/div>\\n  \\n\\t\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10001,'','language','zh-CN','',1,1,0,0,'{\"legacy\":true,\"name\":\"\\u7b80\\u4f53\\u4e2d\\u6587\",\"type\":\"language\",\"creationDate\":\"2013-04-15\",\"author\":\"Derek Joe(zhous)\",\"copyright\":\"Copyright (C) 2010 CHN Joomla Translation (http:\\/\\/joomlacode.org\\/gf\\/project\\/choice\\/). All rights reserved.\",\"authorEmail\":\"zhous1998@sohu.com\",\"authorUrl\":\"\",\"version\":\"2.5.20.1\",\"description\":\"\\n\\t    \\n<div align=\\\"center\\\">\\n <table border=\\\"0\\\" width=\\\"90%\\\">\\n  <table width=\\\"100%\\\" border=\\\"0\\\">\\n  <tr>\\n    <td colspan=\\\"2\\\">Chinese language for Joomla 2.5 back-end. Translated by CHN Joomla Translation Team, one of Joomla Accredited Translations.<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">Joomla 2.5 \\u7b80\\u4f53\\u4e2d\\u6587\\u8bed\\u8a00\\u662f\\u7531Joomla\\u6388\\u6743\\u7ffb\\u8bd1\\u7ec4\\u7684Derek Joe\\u5728Joomla 1.6\\u7ffb\\u8bd1\\u5de5\\u4f5c\\u7684\\u57fa\\u7840\\u4e0a\\u8865\\u5145\\u7ffb\\u8bd1\\u3002<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">Joomla 2.5\\u7b80\\u4f53\\u4e2d\\u6587\\u8bed\\u8a00\\u5305\\u7684\\u4e3b\\u8981\\u8d21\\u732e\\u4eba\\uff1a<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u524d\\u53f0\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/wuyujie\\/\\\" target=\\\"_blank\\\">\\u6b66\\u7389\\u6770<\\/a>(wuyujie)\\u3001 <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/gzpan123\\/\\\" target=\\\"_blank\\\">\\u90ed\\u5fd7\\u6500<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u540e\\u53f0\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/keydiagram\\/\\\" target=\\\"_blank\\\">Key Diagram<\\/a>\\u3001<a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/tchyusuf\\/\\\">Yusuf  Wang<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u5b89\\u88c5\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/freechoice\\/\\\" target=\\\"_blank\\\">Johnathan Cheun<\\/a>\\u3001<a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/tchyusuf\\/\\\">Yusuf  Wang<\\/a>\\u3001 <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/zhous\\/\\\" target=\\\"_blank\\\">Derek Joe<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u793a\\u8303\\u5185\\u5bb9\\u53ca\\u7f16\\u8f91\\u5668\\uff1a <a href=\\\"http:\\/\\/joomlacode.org\\/gf\\/user\\/zhous\\/\\\" target=\\\"_blank\\\">Derek Joe<\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">\\u591a\\u8c22\\u5927\\u5bb6\\u7684\\u8f9b\\u52e4\\u52b3\\u52a8\\uff01\\u8c22\\u8c22wayne82\\u7684\\u53cd\\u9988\\u4e0e\\u5efa\\u8bae\\uff01<\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td width=\\\"132\\\"><p><a href=\\\"http:\\/\\/www.joomla.cn\\/index.php?option=com_kunena&func=showcat&catid=34&Itemid=46&lang=zh\\\" target=\\\"_blank\\\"><img src=\\\"http:\\/\\/www.joomla.cn\\/images\\/aboutjoomlacn.png\\\" alt=\\\"\\u56e7\\u5566!\\u4e2d\\u56fd\\\" width=\\\"130\\\" height=\\\"70\\\" align=\\\"left\\\" longdesc=\\\"http:\\/\\/www.joomla.cn\\\"><br \\/>\\n    <\\/a><\\/p><\\/td>\\n    <td valign=\\\"middle\\\"><a href=\\\"http:\\/\\/www.joomla.cn\\/index.php?option=com_kunena&func=showcat&catid=34&Itemid=46&lang=zh\\\" target=\\\"_blank\\\">Joomla\\u53ca\\u5176\\u6269\\u5c55\\u6c49\\u5316\\u7684\\u5206\\u4eab\\u4e0e\\u8ba8\\u8bba\\u8bf7\\u8bbf\\u95ee\\\"\\u56e7\\u5566!\\u4e2d\\u56fd\\\"<\\/a><br \\/>\\n      <b>\\u6b22\\u8fce\\u559c\\u6b22\\u7ffb\\u8bd1\\u4e14\\u61c2\\u5f97\\u4f7f\\u7528SVN\\u7684\\u670b\\u53cb<\\/b><br \\/>\\n    <a href=\\\"http:\\/\\/www.joomla.cn\\/index.php?option=com_kunena&func=view&catid=34&id=9537&Itemid=46\\\" target=\\\"_blank\\\"><b>\\u52a0\\u5165\\u6211\\u4eec\\u7684\\u7ffb\\u8bd1\\u7ec4\\uff08\\u771f\\u6b63\\u81ea\\u4e3b\\u7684\\u534f\\u4f5c\\u65b9\\u5f0f\\uff09<\\/b><\\/a><\\/td>\\n  <\\/tr>\\n  <tr>\\n    <td colspan=\\\"2\\\">&nbsp;<\\/td>\\n  <\\/tr>\\n<\\/table>\\n <\\/div>\\n  \\n\\t\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10002,'TinyMCE zh-CN','file','tinymce_zh-CN','',0,1,0,0,'{\"legacy\":false,\"name\":\"TinyMCE zh-CN\",\"type\":\"file\",\"creationDate\":\"2012.05.23\",\"author\":\"Joomla! China\",\"copyright\":\"Copyright (C) 2005 - 2012 Open Source Matters. All rights reserved\",\"authorEmail\":\"zhous1998@gmail.com\",\"authorUrl\":\"www.joomla.cn\",\"version\":\"3.4.9\",\"description\":\"Joomla\\u6838\\u5fc3\\u7f16\\u8f91\\u5668TinyMCE 3.4.9\\u7684\\u7b80\\u4f53\\u4e2d\\u6587\\u8bed\\u8a00\\u5305\\u3002Simplified Chinese Language Package for TinyMCE 3.4.9 in Joomla 2.5.\",\"group\":\"\"}','','','',0,'0000-00-00 00:00:00',0,0),(10003,'zh-CN','package','pkg_zh-CN','',0,1,1,0,'{\"legacy\":false,\"name\":\"\\u7b80\\u4f53\\u4e2d\\u6587Simplified Chinese\",\"type\":\"package\",\"creationDate\":\"2013-12-19\",\"author\":\"CHN Translation Team\",\"copyright\":\"Copyright (C) 2010 CHN Joomla Translation Team  (http:\\/\\/joomlacode.org\\/gf\\/project\\/choice\\/). All rights reserved.\",\"authorEmail\":\"zhous1998@sohu.com\",\"authorUrl\":\"www.joomla.cn\",\"version\":\"2.5.20.1\",\"description\":\"\\n\\t\\n\\t<h3>Joomla! 2.5.20\\u7b80\\u4f53\\u4e2d\\u6587\\u8bed\\u8a00\\u5305\\u7b2c\\u4e00\\u7248<\\/h3>\\n    <h3>Joomla! 2.5.20 Full Simplified Chinese (zh-CN) Language Package version 1<\\/h3>\\n    <h3>\\u672c\\u5b89\\u88c5\\u5305\\u5df2\\u5305\\u542bJoomla\\u6838\\u5fc3\\u7f16\\u8f91\\u5668TinyMCE 3.4.9\\u7684\\u4e2d\\u6587\\u8bed\\u8a00<\\/h3>\\n\\t<div>\\n\\tJoomla 2.5.20\\u8bed\\u8a00\\u662f\\u7531Joomla\\u5b98\\u65b9\\u7ffb\\u8bd1\\u7ec4\\u7684Derek Joe\\u7ec4\\u7ec7\\u7ffb\\u8bd1\\u3002\\u5de5\\u4f5c\\u662f\\u5728Joomla1.6\\u7684\\u57fa\\u7840\\u4e0a\\u8fdb\\u884c\\u7684\\u3002Joomla 2.5.20\\u8bed\\u8a00\\u7684\\u8865\\u5145\\u7531Derek Joe\\u5b8c\\u6210\\u3002\\u611f\\u8c22Joomla\\u7b80\\u4f53\\u4e2d\\u6587\\u7ffb\\u8bd1\\u7ec4\\u7684\\u6240\\u6709\\u5fd7\\u613f\\u8005\\uff1a\\u6b66\\u7389\\u6770\\u3001Key Diagram\\u3001Yusuf  Wang\\u3001\\u90ed\\u5fd7\\u6500\\u3001Eric Wong\\uff08http:\\/\\/berocks2.com\\/\\uff09\\u3001wayne82\\uff01\\u7ffb\\u8bd1\\u57fa\\u5730\\uff1a<a href=\\\"http:\\/\\/www.joomla.cn\\\" target=\\\"_blank\\\">\\u56e7\\u5566!\\u4e2d\\u56fd\\uff08Joomla.cn\\uff09<\\/a>\\u3002\\u7ffb\\u8bd1\\u4e0e\\u4f7f\\u7528\\u4ea4\\u6d41\\uff1a\\uff1a<a href=\\\"http:\\/\\/weibo.com\\/joomlacn\\\" target=\\\"_blank\\\">\\u56e7\\u5566\\u4e2d\\u56fd\\uff08\\u65b0\\u6d6a\\u5fae\\u535a\\uff09<\\/a>\\u3002\\u6b22\\u8fce\\u559c\\u6b22\\u7ffb\\u8bd1\\u7684\\u670b\\u53cb\\u52a0\\u5165\\u6211\\u4eec\\u3002<br><br>\\n\\t\\u6b22\\u8fce\\u52a0\\u5165\\u201cJoomla\\u4f7f\\u7528\\u4ea4\\u6d41\\u201dQ\\u7fa4\\uff1a154673214\\u300172746093\\u3002<br> <br>\\n\\t<\\/div>\\n\\t\\n\\t\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10004,'com_project','component','com_project','',1,1,0,0,'{\"legacy\":false,\"name\":\"com_project\",\"type\":\"component\",\"creationDate\":\"08-31\",\"author\":\"Barton\",\"copyright\":\"(C) 2013 Packt publishing.All rights reserved.\",\"authorEmail\":\"example@packtpub\",\"authorUrl\":\"www.packtpub.com\",\"version\":\"1.0.0\",\"description\":\"COM_PROJECT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10005,'com_hospital','component','com_hospital','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_hospital\",\"type\":\"component\",\"creationDate\":\"2015-09-02\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.All rights reserved.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_HOSPITAL_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10006,'com_group','component','com_group','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_group\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_GROUP_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10007,'com_tehui','component','com_tehui','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_tehui\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_TEHUI_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10008,'com_act','component','com_act','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_act\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_ACT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10009,'com_cuser','component','com_cuser','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_cuser\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_CUSER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10010,'com_wenzhang','component','com_wenzhang','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_wenzhang\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_WENZHANG_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10011,'com_order','component','com_order','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_order\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_ORDER_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10012,'com_kecheng','component','com_kecheng','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_kecheng\",\"type\":\"component\",\"creationDate\":\"2015-09-02\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.All rights reserved.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_KECHENG_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10013,'com_baoxian','component','com_baoxian','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_baoxian\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_BAOXIAN_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0),(10014,'com_point','component','com_point','',1,1,1,0,'{\"legacy\":false,\"name\":\"com_point\",\"type\":\"component\",\"creationDate\":\"2015-09-29\",\"author\":\"WangRui\",\"copyright\":\"(C) 2015 Min-Fo.\",\"authorEmail\":\"183107471@qq.com\",\"authorUrl\":\"www.min-fo.com\",\"version\":\"1.0.0\",\"description\":\"COM_POINT_XML_DESCRIPTION\",\"group\":\"\"}','{}','','',0,'0000-00-00 00:00:00',0,0);
/*!40000 ALTER TABLE `qm_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_filters`
--

DROP TABLE IF EXISTS `qm_finder_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_filters` (
  `filter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL,
  `created_by_alias` varchar(255) NOT NULL,
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `map_count` int(10) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_filters`
--

LOCK TABLES `qm_finder_filters` WRITE;
/*!40000 ALTER TABLE `qm_finder_filters` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links`
--

DROP TABLE IF EXISTS `qm_finder_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `indexdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `state` int(5) DEFAULT '1',
  `access` int(5) DEFAULT '0',
  `language` varchar(8) NOT NULL,
  `publish_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `list_price` double unsigned NOT NULL DEFAULT '0',
  `sale_price` double unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `object` mediumblob NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links`
--

LOCK TABLES `qm_finder_links` WRITE;
/*!40000 ALTER TABLE `qm_finder_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms0`
--

DROP TABLE IF EXISTS `qm_finder_links_terms0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms0`
--

LOCK TABLES `qm_finder_links_terms0` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms0` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms1`
--

DROP TABLE IF EXISTS `qm_finder_links_terms1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms1`
--

LOCK TABLES `qm_finder_links_terms1` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms1` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms2`
--

DROP TABLE IF EXISTS `qm_finder_links_terms2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms2`
--

LOCK TABLES `qm_finder_links_terms2` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms2` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms3`
--

DROP TABLE IF EXISTS `qm_finder_links_terms3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms3`
--

LOCK TABLES `qm_finder_links_terms3` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms3` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms4`
--

DROP TABLE IF EXISTS `qm_finder_links_terms4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms4`
--

LOCK TABLES `qm_finder_links_terms4` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms4` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms5`
--

DROP TABLE IF EXISTS `qm_finder_links_terms5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms5`
--

LOCK TABLES `qm_finder_links_terms5` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms5` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms6`
--

DROP TABLE IF EXISTS `qm_finder_links_terms6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms6`
--

LOCK TABLES `qm_finder_links_terms6` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms6` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms7`
--

DROP TABLE IF EXISTS `qm_finder_links_terms7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms7`
--

LOCK TABLES `qm_finder_links_terms7` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms7` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms8`
--

DROP TABLE IF EXISTS `qm_finder_links_terms8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms8`
--

LOCK TABLES `qm_finder_links_terms8` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms8` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_terms9`
--

DROP TABLE IF EXISTS `qm_finder_links_terms9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_terms9`
--

LOCK TABLES `qm_finder_links_terms9` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_terms9` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_terms9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_termsa`
--

DROP TABLE IF EXISTS `qm_finder_links_termsa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_termsa`
--

LOCK TABLES `qm_finder_links_termsa` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_termsa` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_termsa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_termsb`
--

DROP TABLE IF EXISTS `qm_finder_links_termsb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_termsb`
--

LOCK TABLES `qm_finder_links_termsb` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_termsb` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_termsb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_termsc`
--

DROP TABLE IF EXISTS `qm_finder_links_termsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_termsc`
--

LOCK TABLES `qm_finder_links_termsc` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_termsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_termsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_termsd`
--

DROP TABLE IF EXISTS `qm_finder_links_termsd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_termsd`
--

LOCK TABLES `qm_finder_links_termsd` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_termsd` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_termsd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_termse`
--

DROP TABLE IF EXISTS `qm_finder_links_termse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_termse`
--

LOCK TABLES `qm_finder_links_termse` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_termse` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_termse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_links_termsf`
--

DROP TABLE IF EXISTS `qm_finder_links_termsf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_links_termsf`
--

LOCK TABLES `qm_finder_links_termsf` WRITE;
/*!40000 ALTER TABLE `qm_finder_links_termsf` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_links_termsf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_taxonomy`
--

DROP TABLE IF EXISTS `qm_finder_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_taxonomy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `access` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `state` (`state`),
  KEY `ordering` (`ordering`),
  KEY `access` (`access`),
  KEY `idx_parent_published` (`parent_id`,`state`,`access`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_taxonomy`
--

LOCK TABLES `qm_finder_taxonomy` WRITE;
/*!40000 ALTER TABLE `qm_finder_taxonomy` DISABLE KEYS */;
INSERT INTO `qm_finder_taxonomy` VALUES (1,0,'ROOT',0,0,0);
/*!40000 ALTER TABLE `qm_finder_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_taxonomy_map`
--

DROP TABLE IF EXISTS `qm_finder_taxonomy_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_taxonomy_map`
--

LOCK TABLES `qm_finder_taxonomy_map` WRITE;
/*!40000 ALTER TABLE `qm_finder_taxonomy_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_taxonomy_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_terms`
--

DROP TABLE IF EXISTS `qm_finder_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '0',
  `soundex` varchar(75) NOT NULL,
  `links` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term` (`term`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_terms`
--

LOCK TABLES `qm_finder_terms` WRITE;
/*!40000 ALTER TABLE `qm_finder_terms` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_terms_common`
--

DROP TABLE IF EXISTS `qm_finder_terms_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_terms_common`
--

LOCK TABLES `qm_finder_terms_common` WRITE;
/*!40000 ALTER TABLE `qm_finder_terms_common` DISABLE KEYS */;
INSERT INTO `qm_finder_terms_common` VALUES ('a','en'),('about','en'),('after','en'),('ago','en'),('all','en'),('am','en'),('an','en'),('and','en'),('ani','en'),('any','en'),('are','en'),('aren\'t','en'),('as','en'),('at','en'),('be','en'),('but','en'),('by','en'),('for','en'),('from','en'),('get','en'),('go','en'),('how','en'),('if','en'),('in','en'),('into','en'),('is','en'),('isn\'t','en'),('it','en'),('its','en'),('me','en'),('more','en'),('most','en'),('must','en'),('my','en'),('new','en'),('no','en'),('none','en'),('not','en'),('noth','en'),('nothing','en'),('of','en'),('off','en'),('often','en'),('old','en'),('on','en'),('onc','en'),('once','en'),('onli','en'),('only','en'),('or','en'),('other','en'),('our','en'),('ours','en'),('out','en'),('over','en'),('page','en'),('she','en'),('should','en'),('small','en'),('so','en'),('some','en'),('than','en'),('thank','en'),('that','en'),('the','en'),('their','en'),('theirs','en'),('them','en'),('then','en'),('there','en'),('these','en'),('they','en'),('this','en'),('those','en'),('thus','en'),('time','en'),('times','en'),('to','en'),('too','en'),('true','en'),('under','en'),('until','en'),('up','en'),('upon','en'),('use','en'),('user','en'),('users','en'),('veri','en'),('version','en'),('very','en'),('via','en'),('want','en'),('was','en'),('way','en'),('were','en'),('what','en'),('when','en'),('where','en'),('whi','en'),('which','en'),('who','en'),('whom','en'),('whose','en'),('why','en'),('wide','en'),('will','en'),('with','en'),('within','en'),('without','en'),('would','en'),('yes','en'),('yet','en'),('you','en'),('your','en'),('yours','en');
/*!40000 ALTER TABLE `qm_finder_terms_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_tokens`
--

DROP TABLE IF EXISTS `qm_finder_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_tokens` (
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '1',
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  KEY `idx_word` (`term`),
  KEY `idx_context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_tokens`
--

LOCK TABLES `qm_finder_tokens` WRITE;
/*!40000 ALTER TABLE `qm_finder_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_tokens_aggregate`
--

DROP TABLE IF EXISTS `qm_finder_tokens_aggregate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_tokens_aggregate` (
  `term_id` int(10) unsigned NOT NULL,
  `map_suffix` char(1) NOT NULL,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `term_weight` float unsigned NOT NULL,
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `context_weight` float unsigned NOT NULL,
  `total_weight` float unsigned NOT NULL,
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_tokens_aggregate`
--

LOCK TABLES `qm_finder_tokens_aggregate` WRITE;
/*!40000 ALTER TABLE `qm_finder_tokens_aggregate` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_tokens_aggregate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_finder_types`
--

DROP TABLE IF EXISTS `qm_finder_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_finder_types`
--

LOCK TABLES `qm_finder_types` WRITE;
/*!40000 ALTER TABLE `qm_finder_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_finder_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_group`
--

DROP TABLE IF EXISTS `qm_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `intro` text NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='小组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_group`
--

LOCK TABLES `qm_group` WRITE;
/*!40000 ALTER TABLE `qm_group` DISABLE KEYS */;
INSERT INTO `qm_group` VALUES (9,'眼部','images/yanjing.png','眼睛是心灵的窗户,真的哦',1454318606),(10,'鼻部','images/bizi.png','拥有好看精致的鼻子，是变美的第一步',1450836771),(11,'脸型','images/lian.png','女神养成记，你也可以',1450836806),(12,'皮肤','images/lianjia.png','一白遮百丑，肤差毁一生',1450836857),(13,'体型','images/yao.png','打造美好身材，迎接美好未来',1450836960),(14,'美胸','images/xiong.png','挺拔就好',1450836999),(15,'口唇','images/zui.png','迷人微笑，性感双唇',1450837060),(16,'杂谈','images/huihua.png','关于变美，我们无所不谈',1457587209);
/*!40000 ALTER TABLE `qm_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_group_project`
--

DROP TABLE IF EXISTS `qm_group_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_group_project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL,
  `gid` int(10) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='小组与项目关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_group_project`
--

LOCK TABLES `qm_group_project` WRITE;
/*!40000 ALTER TABLE `qm_group_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_group_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_group_tag`
--

DROP TABLE IF EXISTS `qm_group_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_group_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gid` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='小组的标签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_group_tag`
--

LOCK TABLES `qm_group_tag` WRITE;
/*!40000 ALTER TABLE `qm_group_tag` DISABLE KEYS */;
INSERT INTO `qm_group_tag` VALUES (43,9,'双眼皮',1450837126),(44,9,'开眼角',1450837134),(45,9,'眼袋',1450837142),(46,10,'隆鼻',1450837170),(47,10,'鼻翼',1450837177),(48,10,'鼻头',1450837184),(49,11,'额头',1450837210),(50,11,'太阳穴',1450837218),(51,12,'美白',1450837248),(52,12,'祛痘',1450837266),(53,12,'祛斑',1450837280),(54,13,'吸脂溶脂',1450837315),(55,13,'腰腹',1450837330),(56,14,'丰胸',1450837363),(57,14,'隆胸',1450837377),(58,14,'乳晕',1450837402),(59,15,'矫正',1450837420),(60,15,'美白',1450837431),(61,16,'心得',1450837447),(62,16,'意见',1450837456),(63,11,'颧骨',1458710356),(64,11,'下颌',1458710563),(65,14,'自体脂肪',1459998555),(66,14,'假体填充',1459998570),(67,11,'下巴',1460001503),(68,11,'肉毒素',1460003391),(69,11,'脂肪移植',1460010205),(70,9,'卧蚕',1460078132),(71,12,'脱毛',1460356573),(72,15,'丰唇',1460357741),(73,13,'大小腿',1460620351),(74,13,'手臂',1460620374),(75,11,'吸脂',1460622622),(76,11,'泪沟',1461048939),(77,11,'法令纹',1461048953);
/*!40000 ALTER TABLE `qm_group_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_group_user`
--

DROP TABLE IF EXISTS `qm_group_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_group_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gid` int(10) unsigned NOT NULL,
  `userid` int(9) unsigned NOT NULL,
  `isadmin` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1，普通；2，管理员',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='小组与用户关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_group_user`
--

LOCK TABLES `qm_group_user` WRITE;
/*!40000 ALTER TABLE `qm_group_user` DISABLE KEYS */;
INSERT INTO `qm_group_user` VALUES (12,10,379839552,1,1446108189),(25,14,379839552,1,1446433358),(26,9,116293669,1,1446448148),(33,15,84083833,1,1446777028),(35,9,678633437,1,1448246868),(36,9,277033886,1,1448248512),(41,9,785251622,1,1448958998),(48,9,990758369,1,1448965108),(49,11,990758369,1,1449022094),(52,11,449039907,1,1449026653),(62,13,990758369,1,1449108463),(64,11,490878686,1,1449135286),(66,15,490878686,1,1449135294),(67,12,669103067,1,1449565213),(69,13,336145299,1,1449568440),(72,10,785251622,1,1449651030),(73,10,336145299,1,1449652182),(82,14,990758369,1,1450076789),(83,11,594111915,1,1450078919),(88,16,594111915,1,1450080838),(90,16,436942141,1,1450085521),(91,9,599677187,1,1450087583),(93,11,599677187,1,1450144122),(94,12,599677187,1,1450144126),(95,13,599677187,1,1450144129),(96,14,599677187,1,1450144132),(97,15,599677187,1,1450144135),(98,16,599677187,1,1450144139),(100,16,785251622,1,1450318596),(101,13,785251622,1,1450318611),(102,13,490878686,1,1450691575),(104,12,436942141,1,1451195576),(105,10,594111915,1,1454324266),(106,13,449039907,1,1454324365),(108,15,594111915,1,1456138717),(109,13,436942141,1,1456598068),(110,9,887915923,1,1456816867),(111,9,436942141,1,1456817076),(112,12,887915923,1,1456823359),(113,16,887915923,1,1456891909),(114,14,509271164,1,1459999193),(115,11,767719481,1,1460221212),(116,16,440825519,1,1460364629),(117,14,583752415,1,1460703268),(118,14,563450421,1,1460703536),(119,9,563450421,1,1460703668),(120,10,563450421,1,1460703672),(121,11,563450421,1,1460703675),(122,12,563450421,1,1460703678),(123,13,563450421,1,1460703682),(124,15,563450421,1,1460703686),(125,16,563450421,1,1460703690),(126,9,928188059,1,1460703870),(127,14,928188059,1,1460703874),(128,16,928188059,1,1460703877),(129,12,928188059,1,1460703879),(130,11,928188059,1,1460703886),(131,10,928188059,1,1460703890),(132,15,928188059,1,1460703893),(133,13,928188059,1,1460703906),(134,14,217256685,1,1460705565),(135,9,217256685,1,1460705569),(136,10,217256685,1,1460705572),(137,11,217256685,1,1460705576),(138,12,217256685,1,1460705579),(139,13,217256685,1,1460705581),(140,15,217256685,1,1460705589),(141,16,217256685,1,1460705592),(142,14,843369688,1,1460706014),(143,9,843369688,1,1460706020),(144,10,843369688,1,1460706024),(145,11,843369688,1,1460706030),(146,12,843369688,1,1460706035),(147,13,843369688,1,1460706039),(148,15,843369688,1,1460706045),(149,16,843369688,1,1460706050),(150,11,512140113,1,1460707680),(151,11,48025602,1,1460708942),(152,11,934893010,1,1460710185),(153,9,934893010,1,1460710239),(154,10,934893010,1,1460710242),(155,12,934893010,1,1460710246),(156,13,934893010,1,1460710251),(157,14,934893010,1,1460710254),(158,15,934893010,1,1460710268),(159,16,934893010,1,1460710273),(160,11,921249596,1,1460712145),(161,9,921249596,1,1460712148),(162,12,921249596,1,1460712156),(163,13,921249596,1,1460712162),(164,14,921249596,1,1460712165),(165,15,921249596,1,1460712168),(166,16,921249596,1,1460712172),(167,10,42511265,1,1460712730),(168,9,42511265,1,1460712733),(169,11,42511265,1,1460712738),(170,12,42511265,1,1460712742),(171,13,42511265,1,1460712747),(172,14,42511265,1,1460712751),(173,15,42511265,1,1460712754),(174,16,42511265,1,1460712762),(175,11,6570781,1,1460716757),(176,9,6570781,1,1460716762),(177,10,6570781,1,1460716766),(178,12,6570781,1,1460716769),(179,13,6570781,1,1460716772),(180,14,6570781,1,1460716776),(181,15,6570781,1,1460716779),(182,16,6570781,1,1460716782),(183,9,846649983,1,1460717223),(184,10,846649983,1,1460717228),(185,11,846649983,1,1460717233),(186,12,846649983,1,1460717236),(187,13,846649983,1,1460717240),(188,14,846649983,1,1460717243),(189,15,846649983,1,1460717246),(190,16,846649983,1,1460717249),(191,11,960991456,1,1460719573),(192,9,960991456,1,1460719578),(193,10,960991456,1,1460719581),(194,12,960991456,1,1460719587),(195,13,960991456,1,1460719591),(196,14,960991456,1,1460719595),(197,15,960991456,1,1460719598),(198,16,960991456,1,1460719602),(199,11,681232735,1,1460950559),(200,9,681232735,1,1460950562),(201,10,681232735,1,1460950565),(202,12,681232735,1,1460950575),(203,13,681232735,1,1460950578),(204,14,681232735,1,1460950584),(205,15,681232735,1,1460950587),(206,16,681232735,1,1460950590),(207,9,776809621,1,1461044857),(208,10,776809621,1,1461044861),(209,11,776809621,1,1461044863),(210,12,776809621,1,1461044866),(211,13,776809621,1,1461044869),(212,14,776809621,1,1461044872),(213,15,776809621,1,1461044874),(214,16,776809621,1,1461044877),(215,9,5934398,1,1461047309),(216,10,5934398,1,1461047312),(217,11,5934398,1,1461047314),(218,12,5934398,1,1461047316),(219,13,5934398,1,1461047319),(220,14,5934398,1,1461047321),(221,15,5934398,1,1461047326),(222,16,5934398,1,1461047328),(223,13,328560380,1,1461053868),(224,9,328560380,1,1461053872),(225,10,328560380,1,1461053917),(226,11,328560380,1,1461053974),(227,12,328560380,1,1461053977),(228,14,328560380,1,1461053985),(229,15,328560380,1,1461053989),(230,16,328560380,1,1461053992),(231,15,208456024,1,1461057099),(232,14,208456024,1,1461057103),(233,13,208456024,1,1461057110),(234,12,208456024,1,1461057113),(235,11,208456024,1,1461057115),(236,10,208456024,1,1461057119),(237,9,208456024,1,1461057125),(238,16,208456024,1,1461057128),(239,11,525100226,1,1461058031),(240,9,525100226,1,1461058034),(241,10,525100226,1,1461058036),(242,12,525100226,1,1461058039),(243,13,525100226,1,1461058042),(244,14,525100226,1,1461058045),(245,15,525100226,1,1461058047),(246,16,525100226,1,1461058050),(247,9,396406924,1,1461058510),(248,10,396406924,1,1461058513),(249,11,396406924,1,1461058515),(250,12,396406924,1,1461058518),(251,13,396406924,1,1461058520),(252,14,396406924,1,1461058523),(253,15,396406924,1,1461058527),(254,16,396406924,1,1461058530),(255,9,325324811,1,1461059692),(256,10,325324811,1,1461059695),(257,11,325324811,1,1461059698),(258,12,325324811,1,1461059701),(259,13,325324811,1,1461059703),(260,14,325324811,1,1461059706),(261,15,325324811,1,1461059708),(262,16,325324811,1,1461059711),(263,10,936484204,1,1461061768),(264,11,936484204,1,1461066317),(265,12,936484204,1,1461066320),(266,13,936484204,1,1461066324),(267,14,936484204,1,1461066331),(268,15,936484204,1,1461066335),(269,16,936484204,1,1461066339),(270,10,518396413,1,1461209434),(272,9,508356011,1,1461374424),(273,10,508356011,1,1461374428),(274,11,508356011,1,1461374432),(275,12,508356011,1,1461374436),(276,13,508356011,1,1461374439),(277,14,508356011,1,1461374442),(278,15,508356011,1,1461374445),(279,16,508356011,1,1461374448),(280,9,292013660,1,1464487419),(281,9,856636367,1,1466059342),(282,10,856636367,1,1466060694),(284,16,559391868,1,1466663380),(285,9,321108478,1,1469255740),(286,10,321108478,1,1469256288),(287,9,594111915,1,1470646657),(288,9,449039907,1,1471075424);
/*!40000 ALTER TABLE `qm_group_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_hospital`
--

DROP TABLE IF EXISTS `qm_hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_hospital` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `pid` int(10) unsigned NOT NULL COMMENT 'Ê¡·Ýid',
  `cid` int(10) unsigned NOT NULL COMMENT '³ÇÊÐid',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ò½Ôº±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_hospital`
--

LOCK TABLES `qm_hospital` WRITE;
/*!40000 ALTER TABLE `qm_hospital` DISABLE KEYS */;
INSERT INTO `qm_hospital` VALUES (4,'利济全美整形美容','images/act/ico.png',17,169,1469270772),(5,'武汉华美整形外科医院','images/hospital/wuhanhuameilogo.jpg',17,169,1457698240),(6,'武汉艺星整形美容医院','images/hospital/yixing_logo2.png',17,169,1457673375),(7,'武汉乐美医疗美容门诊部','images/lemeilogo.png',17,169,1456551835),(8,'武汉新至美医疗美容医院','images/hospital/xinzhimeilogo.png',17,169,1461313748),(9,'武汉五洲美莱整形美容医院','images/hospital/wuzhoumeilailogo.jpg',17,169,1457677919),(10,'武汉鹏爱静港医疗美容','images/hospital/whPAlogo.jpg',17,169,1456982189),(11,'武汉叶子医疗美容','images/hospital/yezi_logo.jpg',17,169,1458544016),(12,'武汉九美医疗美容','images/hospital/jiumei_logo.png',17,169,1458644778),(13,'武汉亚太整形美容医院','images/hospital/yatai_logo00.jpg',17,169,1458812401),(14,'武汉仁爱整形医院','images/hospital/renai_logo.jpg',17,169,1458899292),(15,'楷恩国际医疗美容医院','images/act/KANElogo.png',17,169,1463620129);
/*!40000 ALTER TABLE `qm_hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_languages`
--

DROP TABLE IF EXISTS `qm_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_languages` (
  `lang_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `sef` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `sitename` varchar(1024) NOT NULL DEFAULT '',
  `published` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  UNIQUE KEY `idx_sef` (`sef`),
  UNIQUE KEY `idx_image` (`image`),
  UNIQUE KEY `idx_langcode` (`lang_code`),
  KEY `idx_access` (`access`),
  KEY `idx_ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_languages`
--

LOCK TABLES `qm_languages` WRITE;
/*!40000 ALTER TABLE `qm_languages` DISABLE KEYS */;
INSERT INTO `qm_languages` VALUES (1,'en-GB','English (UK)','English (UK)','en','en','','','','',1,1,1);
/*!40000 ALTER TABLE `qm_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_menu`
--

DROP TABLE IF EXISTS `qm_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `ordering` int(11) NOT NULL DEFAULT '0' COMMENT 'The relative ordering of the menu item in the tree.',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`,`language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(255)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_menu`
--

LOCK TABLES `qm_menu` WRITE;
/*!40000 ALTER TABLE `qm_menu` DISABLE KEYS */;
INSERT INTO `qm_menu` VALUES (1,'','Menu_Item_Root','root','','','','',1,0,0,0,0,0,'0000-00-00 00:00:00',0,0,'',0,'',0,65,0,'*',0),(2,'menu','com_banners','Banners','','Banners','index.php?option=com_banners','component',0,1,1,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners',0,'',1,10,0,'*',1),(3,'menu','com_banners','Banners','','Banners/Banners','index.php?option=com_banners','component',0,2,2,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners',0,'',2,3,0,'*',1),(4,'menu','com_banners_categories','Categories','','Banners/Categories','index.php?option=com_categories&extension=com_banners','component',0,2,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:banners-cat',0,'',4,5,0,'*',1),(5,'menu','com_banners_clients','Clients','','Banners/Clients','index.php?option=com_banners&view=clients','component',0,2,2,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners-clients',0,'',6,7,0,'*',1),(6,'menu','com_banners_tracks','Tracks','','Banners/Tracks','index.php?option=com_banners&view=tracks','component',0,2,2,4,0,0,'0000-00-00 00:00:00',0,0,'class:banners-tracks',0,'',8,9,0,'*',1),(7,'menu','com_contact','Contacts','','Contacts','index.php?option=com_contact','component',0,1,1,8,0,0,'0000-00-00 00:00:00',0,0,'class:contact',0,'',11,16,0,'*',1),(8,'menu','com_contact','Contacts','','Contacts/Contacts','index.php?option=com_contact','component',0,7,2,8,0,0,'0000-00-00 00:00:00',0,0,'class:contact',0,'',12,13,0,'*',1),(9,'menu','com_contact_categories','Categories','','Contacts/Categories','index.php?option=com_categories&extension=com_contact','component',0,7,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:contact-cat',0,'',14,15,0,'*',1),(10,'menu','com_messages','Messaging','','Messaging','index.php?option=com_messages','component',0,1,1,15,0,0,'0000-00-00 00:00:00',0,0,'class:messages',0,'',17,22,0,'*',1),(11,'menu','com_messages_add','New Private Message','','Messaging/New Private Message','index.php?option=com_messages&task=message.add','component',0,10,2,15,0,0,'0000-00-00 00:00:00',0,0,'class:messages-add',0,'',18,19,0,'*',1),(12,'menu','com_messages_read','Read Private Message','','Messaging/Read Private Message','index.php?option=com_messages','component',0,10,2,15,0,0,'0000-00-00 00:00:00',0,0,'class:messages-read',0,'',20,21,0,'*',1),(13,'menu','com_newsfeeds','News Feeds','','News Feeds','index.php?option=com_newsfeeds','component',0,1,1,17,0,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds',0,'',23,28,0,'*',1),(14,'menu','com_newsfeeds_feeds','Feeds','','News Feeds/Feeds','index.php?option=com_newsfeeds','component',0,13,2,17,0,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds',0,'',24,25,0,'*',1),(15,'menu','com_newsfeeds_categories','Categories','','News Feeds/Categories','index.php?option=com_categories&extension=com_newsfeeds','component',0,13,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:newsfeeds-cat',0,'',26,27,0,'*',1),(16,'menu','com_redirect','Redirect','','Redirect','index.php?option=com_redirect','component',0,1,1,24,0,0,'0000-00-00 00:00:00',0,0,'class:redirect',0,'',41,42,0,'*',1),(17,'menu','com_search','Basic Search','','Basic Search','index.php?option=com_search','component',0,1,1,19,0,0,'0000-00-00 00:00:00',0,0,'class:search',0,'',33,34,0,'*',1),(18,'menu','com_weblinks','Weblinks','','Weblinks','index.php?option=com_weblinks','component',0,1,1,21,0,0,'0000-00-00 00:00:00',0,0,'class:weblinks',0,'',35,40,0,'*',1),(19,'menu','com_weblinks_links','Links','','Weblinks/Links','index.php?option=com_weblinks','component',0,18,2,21,0,0,'0000-00-00 00:00:00',0,0,'class:weblinks',0,'',36,37,0,'*',1),(20,'menu','com_weblinks_categories','Categories','','Weblinks/Categories','index.php?option=com_categories&extension=com_weblinks','component',0,18,2,6,0,0,'0000-00-00 00:00:00',0,0,'class:weblinks-cat',0,'',38,39,0,'*',1),(21,'menu','com_finder','Smart Search','','Smart Search','index.php?option=com_finder','component',0,1,1,27,0,0,'0000-00-00 00:00:00',0,0,'class:finder',0,'',31,32,0,'*',1),(22,'menu','com_joomlaupdate','Joomla! Update','','Joomla! Update','index.php?option=com_joomlaupdate','component',0,1,1,28,0,0,'0000-00-00 00:00:00',0,0,'class:joomlaupdate',0,'',41,42,0,'*',1),(101,'mainmenu','Home','home','','home','index.php?option=com_content&view=featured','component',1,1,1,22,0,0,'0000-00-00 00:00:00',0,1,'',0,'{\"featured_categories\":[\"\"],\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"multi_column_order\":\"1\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_noauth\":\"\",\"article-allow_ratings\":\"\",\"article-allow_comments\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_readmore\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"show_page_heading\":1,\"page_title\":\"\",\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}',29,30,1,'*',0),(102,'main','COM_PROJECT_MENU','com-project-menu','','com-project-menu','index.php?option=com_project','component',0,1,1,10004,0,0,'0000-00-00 00:00:00',0,1,'class:newsfeeds',0,'',43,44,0,'',1),(103,'main','COM_HOSPITAL_MENU','com-hospital-menu','','com-hospital-menu','index.php?option=com_hospital','component',0,1,1,10005,0,0,'0000-00-00 00:00:00',0,1,'class:messages',0,'',45,46,0,'',1),(104,'main','COM_GROUP_MENU','com-group-menu','','com-group-menu','index.php?option=com_group','component',0,1,1,10006,0,0,'0000-00-00 00:00:00',0,1,'class:groups',0,'',47,48,0,'',1),(105,'main','COM_TEHUI_MENU','com-tehui-menu','','com-tehui-menu','index.php?option=com_tehui','component',0,1,1,10007,0,0,'0000-00-00 00:00:00',0,1,'class:install',0,'',49,50,0,'',1),(106,'main','COM_ACT_MENU','com-act-menu','','com-act-menu','index.php?option=com_act','component',0,1,1,10008,0,0,'0000-00-00 00:00:00',0,1,'class:language',0,'',51,52,0,'',1),(107,'main','COM_CUSER_MENU','com-cuser-menu','','com-cuser-menu','index.php?option=com_cuser','component',0,1,1,10009,0,0,'0000-00-00 00:00:00',0,1,'class:user',0,'',53,54,0,'',1),(108,'main','COM_WENZHANG_MENU','com-wenzhang-menu','','com-wenzhang-menu','index.php?option=com_wenzhang','component',0,1,1,10010,0,0,'0000-00-00 00:00:00',0,1,'class:article',0,'',55,56,0,'',1),(109,'main','COM_ORDER_MENU','com-order-menu','','com-order-menu','index.php?option=com_order','component',0,1,1,10011,0,0,'0000-00-00 00:00:00',0,1,'class:article',0,'',57,58,0,'',1),(110,'main','COM_KECHENG_MENU','com-kecheng-menu','','com-kecheng-menu','index.php?option=com_kecheng','component',0,1,1,10012,0,0,'0000-00-00 00:00:00',0,1,'class:messages',0,'',59,60,0,'',1),(111,'main','COM_BAOXIAN_MENU','com-baoxian-menu','','com-baoxian-menu','index.php?option=com_baoxian','component',0,1,1,10013,0,0,'0000-00-00 00:00:00',0,1,'class:install',0,'',61,62,0,'',1),(112,'main','COM_POINT_MENU','com-point-menu','','com-point-menu','index.php?option=com_point','component',0,1,1,10014,0,0,'0000-00-00 00:00:00',0,1,'class:install',0,'',63,64,0,'',1);
/*!40000 ALTER TABLE `qm_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_menu_types`
--

DROP TABLE IF EXISTS `qm_menu_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_menu_types`
--

LOCK TABLES `qm_menu_types` WRITE;
/*!40000 ALTER TABLE `qm_menu_types` DISABLE KEYS */;
INSERT INTO `qm_menu_types` VALUES (1,'mainmenu','Main Menu','The main menu for the site');
/*!40000 ALTER TABLE `qm_menu_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_messages`
--

DROP TABLE IF EXISTS `qm_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id_to` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_messages`
--

LOCK TABLES `qm_messages` WRITE;
/*!40000 ALTER TABLE `qm_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_messages_cfg`
--

DROP TABLE IF EXISTS `qm_messages_cfg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_messages_cfg`
--

LOCK TABLES `qm_messages_cfg` WRITE;
/*!40000 ALTER TABLE `qm_messages_cfg` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_messages_cfg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_modules`
--

DROP TABLE IF EXISTS `qm_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_modules`
--

LOCK TABLES `qm_modules` WRITE;
/*!40000 ALTER TABLE `qm_modules` DISABLE KEYS */;
INSERT INTO `qm_modules` VALUES (1,'Main Menu','','',1,'position-7',973,'2016-03-23 04:56:29','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',1,1,'{\"menutype\":\"mainmenu\",\"startLevel\":\"0\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(2,'Login','','',1,'login',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'',1,'*'),(3,'Popular Articles','','',3,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_popular',3,1,'{\"count\":\"5\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}',1,'*'),(4,'Recently Added Articles','','',4,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_latest',3,1,'{\"count\":\"5\",\"ordering\":\"c_dsc\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}',1,'*'),(8,'Toolbar','','',1,'toolbar',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_toolbar',3,1,'',1,'*'),(9,'Quick Icons','','',1,'icon',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_quickicon',3,1,'',1,'*'),(10,'Logged-in Users','','',2,'cpanel',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_logged',3,1,'{\"count\":\"5\",\"name\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}',1,'*'),(12,'Admin Menu','','',1,'menu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_menu',3,1,'{\"layout\":\"\",\"moduleclass_sfx\":\"\",\"shownew\":\"1\",\"showhelp\":\"1\",\"cache\":\"0\"}',1,'*'),(13,'Admin Submenu','','',1,'submenu',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_submenu',3,1,'',1,'*'),(14,'User Status','','',2,'status',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_status',3,1,'',1,'*'),(15,'Title','','',1,'title',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_title',3,1,'',1,'*'),(16,'Login Form','','',7,'position-7',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_login',1,1,'{\"greeting\":\"1\",\"name\":\"0\"}',0,'*'),(17,'Breadcrumbs','','',1,'position-2',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_breadcrumbs',1,1,'{\"moduleclass_sfx\":\"\",\"showHome\":\"1\",\"homeText\":\"Home\",\"showComponent\":\"1\",\"separator\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}',0,'*'),(79,'Multilanguage status','','',1,'status',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',0,'mod_multilangstatus',3,1,'{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*'),(86,'Joomla Version','','',1,'footer',0,'0000-00-00 00:00:00','0000-00-00 00:00:00','0000-00-00 00:00:00',1,'mod_version',3,1,'{\"format\":\"short\",\"product\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}',1,'*');
/*!40000 ALTER TABLE `qm_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_modules_menu`
--

DROP TABLE IF EXISTS `qm_modules_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_modules_menu`
--

LOCK TABLES `qm_modules_menu` WRITE;
/*!40000 ALTER TABLE `qm_modules_menu` DISABLE KEYS */;
INSERT INTO `qm_modules_menu` VALUES (1,0),(2,0),(3,0),(4,0),(6,0),(7,0),(8,0),(9,0),(10,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(79,0),(86,0);
/*!40000 ALTER TABLE `qm_modules_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_newsfeeds`
--

DROP TABLE IF EXISTS `qm_newsfeeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_newsfeeds` (
  `catid` int(11) NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `link` varchar(200) NOT NULL DEFAULT '',
  `filename` varchar(200) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `numarticles` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '3600',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_newsfeeds`
--

LOCK TABLES `qm_newsfeeds` WRITE;
/*!40000 ALTER TABLE `qm_newsfeeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_newsfeeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_overrider`
--

DROP TABLE IF EXISTS `qm_overrider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_overrider`
--

LOCK TABLES `qm_overrider` WRITE;
/*!40000 ALTER TABLE `qm_overrider` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_overrider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_pj`
--

DROP TABLE IF EXISTS `qm_pj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_pj` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(9) unsigned NOT NULL,
  `text` text,
  `hua` tinyint(1) unsigned NOT NULL,
  `sm` tinyint(1) unsigned NOT NULL,
  `hj` tinyint(1) unsigned NOT NULL,
  `fw` tinyint(1) unsigned NOT NULL,
  `hid` int(11) NOT NULL,
  `intime` int(11) NOT NULL,
  `orderid` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='åŒ»é™¢è¯„ä»·è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_pj`
--

LOCK TABLES `qm_pj` WRITE;
/*!40000 ALTER TABLE `qm_pj` DISABLE KEYS */;
INSERT INTO `qm_pj` VALUES (10,312194323,'lonvuptuowutzwbvjjhggggh',3,5,5,5,4,1451119277,'quanmei20151226144453'),(11,594111915,'很好',3,5,5,5,15,1464326858,'quanmei20160527131001'),(12,449039907,'很棒',1,5,5,5,15,1464329552,'quanmei20160527135043'),(13,449039907,'哈哈',3,5,5,5,15,1464331585,'quanmei20160527141543'),(14,449039907,'Very Good',3,5,5,5,15,1464333758,'quanmei20160527151257'),(15,887915923,'好评',3,5,5,5,15,1464753748,'quanmei20160601115601'),(16,856636367,'好，实惠',3,5,5,5,15,1464923264,'quanmei20160601142048'),(17,321108478,'好',3,5,5,5,4,1469588347,'quanmei20160727104252'),(18,321108478,'服务好，价格优惠！',3,5,5,5,4,1470111626,'quanmei20160723145736');
/*!40000 ALTER TABLE `qm_pj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_point_record`
--

DROP TABLE IF EXISTS `qm_point_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_point_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) unsigned NOT NULL COMMENT '积分类型，1签到2消费',
  `status` tinyint(1) unsigned NOT NULL COMMENT '积分状态，1正常2扣除',
  `order_num` varchar(255) NOT NULL,
  `order_fee` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `point` decimal(60,2) unsigned NOT NULL,
  `ctime` int(10) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=513 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_point_record`
--

LOCK TABLES `qm_point_record` WRITE;
/*!40000 ALTER TABLE `qm_point_record` DISABLE KEYS */;
INSERT INTO `qm_point_record` VALUES (1,1,1,' ',0.00,5.00,1456132055,1456132055,449039907),(2,1,1,' ',0.00,5.00,1456132900,1456132900,594111915),(3,1,1,' ',0.00,5.00,1456205084,1456205084,449039907),(4,1,1,' ',0.00,5.00,1456383737,1456383737,559391868),(5,1,1,' ',0.00,5.00,1456384564,1456384564,436942141),(6,2,1,'quanmei20160225194235',4000.00,4.00,1456400855,1456400855,436942141),(7,2,1,'quanmei20160225194823',4000.00,4.00,1456401002,1456401002,436942141),(8,1,1,' ',0.00,5.00,1456454915,1456454915,559391868),(9,1,1,' ',0.00,5.00,1456459892,1456459892,436942141),(10,1,1,' ',0.00,5.00,1456467968,1456467968,607552052),(11,1,1,' ',0.00,5.00,1456479921,1456479921,746621638),(12,1,1,' ',0.00,5.00,1456588152,1456588152,436942141),(13,1,1,' ',0.00,5.00,1456631100,1456631100,436942141),(14,1,1,' ',0.00,5.00,1456643753,1456643753,746621638),(15,1,1,' ',0.00,5.00,1456649798,1456649798,813079450),(16,1,1,' ',0.00,5.00,1456714238,1456714238,813079450),(17,1,1,' ',0.00,5.00,1456726819,1456726819,436942141),(18,1,1,' ',0.00,5.00,1456739848,1456739848,746621638),(19,1,1,' ',0.00,5.00,1456801712,1456801712,380934770),(20,1,1,' ',0.00,5.00,1456816065,1456816065,746621638),(21,1,1,' ',0.00,5.00,1456882180,1456882180,746621638),(22,1,1,' ',0.00,5.00,1456896416,1456896416,380934770),(23,1,1,' ',0.00,5.00,1456904510,1456904510,436942141),(24,1,1,' ',0.00,5.00,1456951252,1456951252,746621638),(25,1,1,' ',0.00,200.00,1457077540,1457077540,436942141),(26,1,1,' ',0.00,200.00,1457077551,1457077551,887915923),(27,1,1,' ',0.00,200.00,1457078144,1457078144,746621638),(28,1,1,' ',0.00,200.00,1457143040,1457143040,887915923),(29,1,1,' ',0.00,200.00,1457164165,1457164165,746621638),(30,1,1,' ',0.00,200.00,1457183113,1457183113,9774154),(31,1,1,' ',0.00,200.00,1457241169,1457241169,436942141),(32,1,1,' ',0.00,200.00,1457327102,1457327102,594111915),(33,1,1,' ',0.00,200.00,1457328375,1457328375,380934770),(34,1,1,' ',0.00,200.00,1457409592,1457409592,449039907),(35,1,1,' ',0.00,200.00,1457411703,1457411703,746621638),(36,1,1,' ',0.00,200.00,1457491537,1457491537,746621638),(37,1,1,' ',0.00,200.00,1457586229,1457586229,746621638),(38,1,1,' ',0.00,200.00,1457604307,1457604307,785251622),(39,1,1,' ',0.00,200.00,1457622614,1457622614,436942141),(40,1,1,' ',0.00,200.00,1457658013,1457658013,887915923),(41,1,1,' ',0.00,200.00,1457664868,1457664868,813079450),(42,1,1,' ',0.00,200.00,1457774274,1457774274,449039907),(43,1,1,' ',0.00,200.00,1457776495,1457776495,887915923),(44,1,1,' ',0.00,200.00,1457842384,1457842384,746621638),(45,1,1,' ',0.00,200.00,1457922430,1457922430,746621638),(46,1,1,' ',0.00,200.00,1458033621,1458033621,746621638),(47,1,1,' ',0.00,200.00,1458106424,1458106424,746621638),(48,1,1,' ',0.00,200.00,1458127345,1458127345,813079450),(49,1,1,' ',0.00,200.00,1458215524,1458215524,436942141),(50,1,1,' ',0.00,200.00,1458248329,1458248329,746621638),(51,1,1,' ',0.00,200.00,1458265584,1458265584,436942141),(52,1,1,' ',0.00,200.00,1458459861,1458459861,746621638),(53,1,1,' ',0.00,200.00,1458614167,1458614167,449039907),(54,1,1,' ',0.00,200.00,1458616612,1458616612,518396413),(55,1,1,' ',0.00,200.00,1458616662,1458616662,746621638),(56,1,1,' ',0.00,200.00,1458616824,1458616824,394358564),(57,1,1,' ',0.00,200.00,1458617573,1458617573,887915923),(58,1,1,' ',0.00,200.00,1458630174,1458630174,594111915),(59,1,1,' ',0.00,200.00,1458699793,1458699793,887915923),(60,1,1,' ',0.00,200.00,1458703660,1458703660,559391868),(61,1,1,' ',0.00,200.00,1458784417,1458784417,559391868),(62,1,1,' ',0.00,200.00,1458899773,1458899773,394358564),(63,1,1,' ',0.00,200.00,1459050760,1459050760,559391868),(64,1,1,' ',0.00,200.00,1459134963,1459134963,449039907),(65,1,1,' ',0.00,200.00,1459151389,1459151389,559391868),(66,1,1,' ',0.00,200.00,1459249518,1459249518,559391868),(67,1,1,' ',0.00,200.00,1459302308,1459302308,594111915),(68,1,1,' ',0.00,200.00,1459303935,1459303935,449039907),(69,1,1,' ',0.00,200.00,1459327367,1459327367,848109072),(70,1,1,' ',0.00,200.00,1459344056,1459344056,559391868),(71,1,1,' ',0.00,200.00,1459347434,1459347434,501493680),(72,1,1,' ',0.00,200.00,1459393080,1459393080,436942141),(73,1,1,' ',0.00,200.00,1459406403,1459406403,449039907),(74,1,1,' ',0.00,200.00,1459409572,1459409572,594111915),(75,1,1,' ',0.00,200.00,1459474698,1459474698,449039907),(76,1,1,' ',0.00,200.00,1459498673,1459498673,968220660),(77,1,1,' ',0.00,200.00,1459561636,1459561636,559391868),(78,1,1,' ',0.00,200.00,1459738874,1459738874,559391868),(79,1,1,' ',0.00,200.00,1459825418,1459825418,394358564),(80,1,1,' ',0.00,200.00,1459843981,1459843981,436942141),(81,1,1,' ',0.00,200.00,1459942692,1459942692,246667211),(82,1,1,' ',0.00,200.00,1459987126,1459987126,202834502),(83,1,1,' ',0.00,200.00,1459998081,1459998081,436942141),(84,1,1,' ',0.00,200.00,1459999608,1459999608,246667211),(85,1,1,' ',0.00,200.00,1460000287,1460000287,594111915),(86,1,1,' ',0.00,200.00,1460020816,1460020816,221058264),(87,1,1,' ',0.00,200.00,1460093993,1460093993,436942141),(88,1,1,' ',0.00,200.00,1460165331,1460165331,126150972),(89,1,1,' ',0.00,200.00,1460261690,1460261690,559391868),(90,1,1,' ',0.00,200.00,1460264612,1460264612,231324474),(91,1,1,' ',0.00,200.00,1460264807,1460264807,246667211),(92,1,1,' ',0.00,200.00,1460345439,1460345439,559391868),(93,1,1,' ',0.00,200.00,1460359343,1460359343,440825519),(94,1,1,' ',0.00,200.00,1460554212,1460554212,559391868),(95,1,1,' ',0.00,200.00,1460695198,1460695198,785251622),(96,1,1,' ',0.00,200.00,1460771186,1460771186,246667211),(97,1,1,' ',0.00,200.00,1460771490,1460771490,436942141),(98,1,1,' ',0.00,200.00,1460945461,1460945461,246667211),(99,1,1,' ',0.00,200.00,1461137929,1461137929,246667211),(100,1,1,' ',0.00,200.00,1461203114,1461203114,246667211),(101,1,1,' ',0.00,200.00,1461231945,1461231945,518396413),(102,1,1,' ',0.00,200.00,1461234029,1461234029,449039907),(103,1,1,' ',0.00,200.00,1461289413,1461289413,990318397),(104,1,1,' ',0.00,200.00,1461738607,1461738607,508356011),(105,1,1,' ',0.00,200.00,1461741085,1461741085,246667211),(106,1,1,' ',0.00,200.00,1462199272,1462199272,9774154),(107,1,1,' ',0.00,200.00,1462247000,1462247000,508356011),(108,1,1,' ',0.00,200.00,1462266089,1462266089,887915923),(109,1,1,' ',0.00,200.00,1462273719,1462273719,9774154),(110,1,1,' ',0.00,200.00,1462354063,1462354063,887915923),(111,1,1,' ',0.00,200.00,1462432087,1462432087,246667211),(112,1,1,' ',0.00,200.00,1462521260,1462521260,246667211),(113,1,1,' ',0.00,200.00,1462765652,1462765652,449039907),(114,1,1,' ',0.00,200.00,1462849177,1462849177,990318397),(115,1,1,' ',0.00,200.00,1462876042,1462876042,887915923),(116,1,1,' ',0.00,200.00,1462946368,1462946368,449039907),(117,1,1,' ',0.00,200.00,1462946788,1462946788,990318397),(118,1,1,' ',0.00,200.00,1463544769,1463544769,9774154),(119,1,1,' ',0.00,200.00,1463639203,1463639203,887915923),(120,1,1,' ',0.00,200.00,1464155270,1464155270,594111915),(121,1,1,' ',0.00,200.00,1464240375,1464240375,594111915),(122,1,1,' ',0.00,200.00,1464320472,1464320472,594111915),(123,1,1,' ',0.00,200.00,1464320709,1464320709,449039907),(124,2,2,'quanmei20160527114524',0.00,0.00,1464320758,1464320758,449039907),(125,2,2,'quanmei20160527114637',0.00,0.00,1464320831,1464320831,449039907),(126,2,2,'quanmei20160527114743',0.00,0.00,1464320875,1464320875,449039907),(127,2,2,'quanmei20160527114908',0.00,0.00,1464320960,1464320960,449039907),(128,2,2,'quanmei20160527115114',0.00,0.00,1464321087,1464321087,594111915),(129,2,2,'quanmei20160527115114',0.00,0.00,1464321337,1464321337,594111915),(130,2,1,'quanmei20160527115114',0.00,50.00,1464321576,0,594111915),(131,1,1,' ',0.00,200.00,1464322230,1464322230,300771575),(132,2,2,'quanmei20160527121119',0.00,0.00,1464322307,1464322307,300771575),(133,2,2,'quanmei20160527121513',0.00,0.00,1464322528,1464322528,300771575),(134,2,2,'quanmei20160527131001',0.00,0.00,1464325824,1464325824,594111915),(135,2,2,'quanmei20160527131001',0.00,0.00,1464325913,1464325913,594111915),(136,2,1,'quanmei20160527131001',2.00,70.00,1464326826,1464326826,594111915),(137,1,1,' ',0.00,200.00,1464327028,1464327028,931055416),(138,2,2,'quanmei20160527135018',0.00,200.00,1464328228,1464328228,594111915),(139,2,2,'quanmei20160527135043',0.00,200.00,1464328254,1464328254,449039907),(140,2,2,'quanmei20160527133832',0.00,200.00,1464328479,1464328479,594111915),(141,2,2,'quanmei20160527114346',0.00,200.00,1464328566,1464328566,594111915),(142,2,2,'quanmei20160527135913',0.00,200.00,1464328770,1464328770,594111915),(143,2,1,'quanmei20160527135913',2.00,0.00,1464329207,1464329207,594111915),(144,2,1,'quanmei20160527135018',2.00,0.00,1464329256,1464329256,594111915),(145,2,1,'quanmei20160527135043',2.00,0.00,1464329269,1464329269,449039907),(146,2,2,'quanmei20160527141543',0.00,200.00,1464329755,1464329755,449039907),(147,2,1,'quanmei20160527141543',2.00,0.00,1464330200,1464330200,449039907),(148,1,1,' ',0.00,200.00,1464330690,1464330690,321108478),(149,1,1,' ',0.00,200.00,1464330745,1464330745,856636367),(150,2,2,'quanmei20160527151257',0.00,100.00,1464333192,1464333192,449039907),(151,2,2,'quanmei20160527151257',0.00,100.00,1464333215,1464333215,449039907),(152,2,1,'quanmei20160527151257',2.00,0.00,1464333724,1464333724,449039907),(153,1,1,' ',0.00,200.00,1464340985,1464340985,559391868),(154,2,1,'quanmei20160527114524',0.00,100.00,1464341030,0,449039907),(155,2,1,'quanmei20160527114637',0.00,50.00,1464341228,0,449039907),(156,2,1,'quanmei20160527114908',0.00,1.00,1464341266,0,449039907),(157,1,1,' ',0.00,200.00,1464365224,1464365224,856636367),(158,1,1,' ',0.00,200.00,1464414907,1464414907,321108478),(159,1,1,' ',0.00,200.00,1464415560,1464415560,559391868),(160,1,1,' ',0.00,200.00,1464422687,1464422687,144055341),(161,1,1,' ',0.00,200.00,1464438540,1464438540,594111915),(162,1,1,' ',0.00,200.00,1464438562,1464438562,12279597),(163,1,1,' ',0.00,200.00,1464445359,1464445359,229788895),(164,1,1,' ',0.00,200.00,1464487396,1464487396,292013660),(165,1,1,' ',0.00,200.00,1464509846,1464509846,275116302),(166,1,1,' ',0.00,200.00,1464510462,1464510462,559391868),(167,1,1,' ',0.00,200.00,1464530146,1464530146,436942141),(168,1,1,' ',0.00,200.00,1464572583,1464572583,12279597),(169,1,1,' ',0.00,200.00,1464572603,1464572603,607552052),(170,1,1,' ',0.00,200.00,1464572706,1464572706,856636367),(171,1,1,' ',0.00,200.00,1464574731,1464574731,594111915),(172,1,1,' ',0.00,200.00,1464579430,1464579430,321108478),(173,1,1,' ',0.00,200.00,1464603360,1464603360,275116302),(174,1,1,' ',0.00,200.00,1464604998,1464604998,559391868),(175,1,1,' ',0.00,200.00,1464663163,1464663163,321108478),(176,1,1,' ',0.00,200.00,1464682345,1464682345,594111915),(177,1,1,' ',0.00,200.00,1464682731,1464682731,248595419),(178,1,1,' ',0.00,200.00,1464687674,1464687674,449039907),(179,1,1,' ',0.00,200.00,1464687812,1464687812,436942141),(180,1,1,' ',0.00,200.00,1464735574,1464735574,248595419),(181,1,1,' ',0.00,200.00,1464745007,1464745007,321108478),(182,1,1,' ',0.00,200.00,1464748471,1464748471,594111915),(183,1,1,' ',0.00,200.00,1464753339,1464753339,887915923),(184,2,2,'quanmei20160601115601',0.00,200.00,1464753380,1464753380,887915923),(185,2,1,'quanmei20160601115601',2.00,0.00,1464753669,1464753669,887915923),(186,1,1,' ',0.00,200.00,1464758144,1464758144,518396413),(187,1,1,' ',0.00,200.00,1464761181,1464761181,12279597),(188,1,1,' ',0.00,200.00,1464761859,1464761859,856636367),(189,2,2,'quanmei20160601142048',0.00,200.00,1464762126,1464762126,856636367),(190,2,1,'quanmei20160601142048',2.00,0.00,1464762288,1464762288,856636367),(191,1,1,' ',0.00,200.00,1464768065,1464768065,449039907),(192,1,1,' ',0.00,200.00,1464769436,1464769436,436942141),(193,1,1,' ',0.00,200.00,1464831590,1464831590,9774154),(194,1,1,' ',0.00,200.00,1464831591,1464831591,856636367),(195,1,1,' ',0.00,200.00,1464869347,1464869347,559391868),(196,1,1,' ',0.00,200.00,1464918760,1464918760,856636367),(197,2,2,'quanmei20160603100942',0.00,200.00,1464919804,1464919804,856636367),(198,2,1,'quanmei20160603100942',0.00,200.00,1464919997,1464919997,856636367),(199,2,2,'quanmei20160603110344',0.00,100.00,1464923032,1464923032,856636367),(200,2,2,'quanmei20160603110344',0.00,100.00,1464923152,1464923152,856636367),(201,1,1,' ',0.00,200.00,1464923423,1464923423,594111915),(202,1,1,' ',0.00,200.00,1464925930,1464925930,248595419),(203,1,1,' ',0.00,200.00,1464926215,1464926215,559391868),(204,1,1,' ',0.00,200.00,1464931138,1464931138,9774154),(205,1,1,' ',0.00,200.00,1464934989,1464934989,275116302),(206,1,1,' ',0.00,200.00,1465003788,1465003788,856636367),(207,1,1,' ',0.00,200.00,1465012064,1465012064,248595419),(208,1,1,' ',0.00,200.00,1465044796,1465044796,559391868),(209,1,1,' ',0.00,200.00,1465175130,1465175130,856636367),(210,1,1,' ',0.00,200.00,1465180104,1465180104,594111915),(211,1,1,' ',0.00,200.00,1465180285,1465180285,518396413),(212,1,1,' ',0.00,200.00,1465183650,1465183650,321108478),(213,1,1,' ',0.00,200.00,1465183774,1465183774,559391868),(214,1,1,' ',0.00,200.00,1465184363,1465184363,990318397),(215,1,1,' ',0.00,200.00,1465197702,1465197702,449039907),(216,1,1,' ',0.00,200.00,1465243507,1465243507,559391868),(217,1,1,' ',0.00,200.00,1465267554,1465267554,990318397),(218,1,1,' ',0.00,200.00,1465267596,1465267596,321108478),(219,1,1,' ',0.00,200.00,1465268231,1465268231,594111915),(220,1,1,' ',0.00,200.00,1465349414,1465349414,321108478),(221,1,1,' ',0.00,200.00,1465351259,1465351259,275116302),(222,1,1,' ',0.00,200.00,1465357675,1465357675,449039907),(223,1,1,' ',0.00,200.00,1465357996,1465357996,559391868),(224,1,1,' ',0.00,200.00,1465393124,1465393124,594111915),(225,1,1,' ',0.00,200.00,1465403655,1465403655,449039907),(226,1,1,' ',0.00,200.00,1465441031,1465441031,321108478),(227,1,1,' ',0.00,200.00,1465448691,1465448691,559391868),(228,1,1,' ',0.00,200.00,1465518529,1465518529,435496725),(229,1,1,' ',0.00,200.00,1465655709,1465655709,559391868),(230,1,1,' ',0.00,200.00,1465693805,1465693805,321108478),(231,1,1,' ',0.00,200.00,1465705928,1465705928,435496725),(232,1,1,' ',0.00,200.00,1465783573,1465783573,321108478),(233,1,1,' ',0.00,200.00,1465866377,1465866377,321108478),(234,1,1,' ',0.00,200.00,1465871662,1465871662,559391868),(235,1,1,' ',0.00,200.00,1465891396,1465891396,436942141),(236,1,1,' ',0.00,200.00,1465952947,1465952947,321108478),(237,1,1,' ',0.00,200.00,1465962309,1465962309,594111915),(238,1,1,' ',0.00,200.00,1465974843,1465974843,436942141),(239,1,1,' ',0.00,200.00,1465977805,1465977805,559391868),(240,1,1,' ',0.00,200.00,1465998469,1465998469,581125662),(241,1,1,' ',0.00,200.00,1466039243,1466039243,321108478),(242,1,1,' ',0.00,200.00,1466042584,1466042584,436942141),(243,1,1,' ',0.00,200.00,1466058679,1466058679,559391868),(244,1,1,' ',0.00,200.00,1466059154,1466059154,856636367),(245,1,1,' ',0.00,200.00,1466059468,1466059468,968527806),(246,1,1,' ',0.00,200.00,1466059662,1466059662,246667211),(247,1,1,' ',0.00,200.00,1466060517,1466060517,836100466),(248,1,1,' ',0.00,200.00,1466126634,1466126634,559391868),(249,1,1,' ',0.00,200.00,1466126991,1466126991,856636367),(250,1,1,' ',0.00,200.00,1466135597,1466135597,968527806),(251,1,1,' ',0.00,200.00,1466149467,1466149467,436942141),(252,1,1,' ',0.00,200.00,1466185397,1466185397,11266728),(253,1,1,' ',0.00,200.00,1466214063,1466214063,856636367),(254,1,1,' ',0.00,200.00,1466229228,1466229228,968527806),(255,1,1,' ',0.00,200.00,1466229526,1466229526,836100466),(256,1,1,' ',0.00,200.00,1466229531,1466229531,246667211),(257,2,2,'quanmei20160618140724',0.00,100.00,1466230053,1466230053,856636367),(258,1,1,' ',0.00,200.00,1466230153,1466230153,321108478),(259,2,2,'quanmei20160618140918',0.00,100.00,1466230166,1466230166,321108478),(260,1,1,' ',0.00,200.00,1466336979,1466336979,836100466),(261,1,1,' ',0.00,200.00,1466388497,1466388497,594111915),(262,1,1,' ',0.00,200.00,1466389864,1466389864,436942141),(263,1,1,' ',0.00,200.00,1466406036,1466406036,856636367),(264,1,1,' ',0.00,200.00,1466407599,1466407599,11266728),(265,1,1,' ',0.00,200.00,1466411392,1466411392,813079450),(266,1,1,' ',0.00,200.00,1466414955,1466414955,216284719),(267,1,1,' ',0.00,200.00,1466428371,1466428371,559391868),(268,1,1,' ',0.00,200.00,1466434430,1466434430,246667211),(269,1,1,' ',0.00,200.00,1466474136,1466474136,856636367),(270,1,1,' ',0.00,200.00,1466479881,1466479881,559391868),(271,1,1,' ',0.00,200.00,1466480589,1466480589,436942141),(272,1,1,' ',0.00,200.00,1466495693,1466495693,813079450),(273,1,1,' ',0.00,200.00,1466558125,1466558125,246667211),(274,1,1,' ',0.00,200.00,1466558323,1466558323,856636367),(275,1,1,' ',0.00,200.00,1466580877,1466580877,813079450),(276,1,1,' ',0.00,200.00,1466584260,1466584260,211377831),(277,1,1,' ',0.00,200.00,1466602591,1466602591,559391868),(278,1,1,' ',0.00,200.00,1466606517,1466606517,945521464),(279,1,1,' ',0.00,200.00,1466644487,1466644487,813079450),(280,1,1,' ',0.00,200.00,1466645425,1466645425,856636367),(281,1,1,' ',0.00,200.00,1466645666,1466645666,11266728),(282,1,1,' ',0.00,200.00,1466645758,1466645758,449039907),(283,1,1,' ',0.00,200.00,1466649184,1466649184,211377831),(284,1,1,' ',0.00,200.00,1466651896,1466651896,378741103),(285,2,2,'quanmei20160623114057',0.00,100.00,1466653297,1466653297,856636367),(286,2,2,'quanmei20160623114057',0.00,0.00,1466655094,1466655094,856636367),(287,2,1,'quanmei20160623114057',2.00,100.00,1466655258,1466655258,856636367),(288,1,1,' ',0.00,200.00,1466663314,1466663314,559391868),(289,1,1,' ',0.00,200.00,1466732827,1466732827,211377831),(290,1,1,' ',0.00,200.00,1466733038,1466733038,856636367),(291,1,1,' ',0.00,200.00,1466736866,1466736866,823738172),(292,1,1,' ',0.00,200.00,1466737097,1466737097,796741246),(293,1,1,' ',0.00,200.00,1466753539,1466753539,559391868),(294,2,1,'quanmei20160603110344',0.00,100.00,1466753863,1466753863,856636367),(295,2,1,'quanmei20160603110344',0.00,100.00,1466753869,1466753869,856636367),(296,2,1,'quanmei20160618140724',0.00,100.00,1466753948,1466753948,856636367),(297,1,1,' ',0.00,200.00,1466804694,1466804694,216284719),(298,1,1,' ',0.00,200.00,1466819193,1466819193,856636367),(299,1,1,' ',0.00,200.00,1466926783,1466926783,559391868),(300,1,1,' ',0.00,200.00,1466984370,1466984370,216284719),(301,1,1,' ',0.00,200.00,1466989964,1466989964,856636367),(302,1,1,' ',0.00,200.00,1466990777,1466990777,435496725),(303,1,1,' ',0.00,200.00,1466998187,1466998187,449039907),(304,1,1,' ',0.00,200.00,1467095691,1467095691,856636367),(305,1,1,' ',0.00,200.00,1467099014,1467099014,813079450),(306,1,1,' ',0.00,200.00,1467185773,1467185773,856636367),(307,1,1,' ',0.00,200.00,1467190052,1467190052,436942141),(308,1,1,' ',0.00,200.00,1467204544,1467204544,559391868),(309,1,1,' ',0.00,200.00,1467255252,1467255252,856636367),(310,1,1,' ',0.00,200.00,1467256911,1467256911,449039907),(311,1,1,' ',0.00,200.00,1467265678,1467265678,559391868),(312,1,1,' ',0.00,200.00,1467303500,1467303500,436942141),(313,1,1,' ',0.00,200.00,1467337080,1467337080,856636367),(314,1,1,' ',0.00,200.00,1467344733,1467344733,211377831),(315,1,1,' ',0.00,200.00,1467355825,1467355825,594111915),(316,1,1,' ',0.00,200.00,1467453656,1467453656,211377831),(317,1,1,' ',0.00,200.00,1467516700,1467516700,436942141),(318,1,1,' ',0.00,200.00,1467529696,1467529696,836100466),(319,1,1,' ',0.00,200.00,1467595540,1467595540,559391868),(320,1,1,' ',0.00,200.00,1467607574,1467607574,436942141),(321,1,1,' ',0.00,200.00,1467697058,1467697058,436942141),(322,1,1,' ',0.00,200.00,1467737951,1467737951,594111915),(323,1,1,' ',0.00,200.00,1467853946,1467853946,59378330),(324,1,1,' ',0.00,200.00,1467897756,1467897756,436942141),(325,1,1,' ',0.00,200.00,1467911793,1467911793,436942141),(326,1,1,' ',0.00,200.00,1468027462,1468027462,901690321),(327,1,1,' ',0.00,200.00,1468045331,1468045331,559391868),(328,1,1,' ',0.00,200.00,1468162204,1468162204,187018269),(329,1,1,' ',0.00,200.00,1468232582,1468232582,856636367),(330,1,1,' ',0.00,200.00,1468255287,1468255287,594111915),(331,1,1,' ',0.00,200.00,1468302128,1468302128,449039907),(332,1,1,' ',0.00,200.00,1468302171,1468302171,813079450),(333,1,1,' ',0.00,200.00,1468302690,1468302690,59378330),(334,1,1,' ',0.00,200.00,1468325757,1468325757,436942141),(335,1,1,' ',0.00,200.00,1468462671,1468462671,813079450),(336,1,1,' ',0.00,200.00,1468471085,1468471085,559391868),(337,1,1,' ',0.00,200.00,1468473423,1468473423,275116302),(338,1,1,' ',0.00,200.00,1468582943,1468582943,559391868),(339,1,1,' ',0.00,200.00,1468604736,1468604736,436942141),(340,1,1,' ',0.00,200.00,1468682514,1468682514,559391868),(341,1,1,' ',0.00,200.00,1468766513,1468766513,187018269),(342,1,1,' ',0.00,200.00,1468893116,1468893116,187018269),(343,1,1,' ',0.00,200.00,1468893392,1468893392,856636367),(344,1,1,' ',0.00,200.00,1468893781,1468893781,559391868),(345,1,1,' ',0.00,200.00,1468910075,1468910075,594111915),(346,1,1,' ',0.00,200.00,1468919005,1468919005,449039907),(347,1,1,' ',0.00,200.00,1468972326,1468972326,488826915),(348,1,1,' ',0.00,200.00,1468986461,1468986461,856636367),(349,1,1,' ',0.00,200.00,1468992454,1468992454,594111915),(350,1,1,' ',0.00,200.00,1469007315,1469007315,559391868),(351,1,1,' ',0.00,200.00,1469007626,1469007626,398846095),(352,1,1,' ',0.00,200.00,1469066830,1469066830,321108478),(353,1,1,' ',0.00,200.00,1469071611,1469071611,187018269),(354,1,1,' ',0.00,200.00,1469084622,1469084622,449039907),(355,1,1,' ',0.00,200.00,1469088674,1469088674,559391868),(356,2,2,'quanmei20160721194619',0.00,100.00,1469101637,1469101637,559391868),(357,2,2,'quanmei20160721194619',0.00,100.00,1469101735,1469101735,559391868),(358,1,1,' ',0.00,200.00,1469101828,1469101828,246667211),(359,2,2,'quanmei20160721195050',0.00,100.00,1469101865,1469101865,246667211),(360,2,2,'quanmei20160721195050',0.00,100.00,1469101984,1469101984,246667211),(361,1,1,' ',0.00,200.00,1469150057,1469150057,246667211),(362,1,1,' ',0.00,200.00,1469150112,1469150112,321108478),(363,1,1,' ',0.00,200.00,1469150117,1469150117,398846095),(364,1,1,' ',0.00,200.00,1469150128,1469150128,559391868),(365,2,2,'quanmei20160722091534',0.00,200.00,1469150158,1469150158,398846095),(366,2,2,'quanmei20160722091602',0.00,100.00,1469150179,1469150179,246667211),(367,2,2,'quanmei20160722091602',0.00,100.00,1469150210,1469150210,246667211),(368,2,1,'quanmei20160722091534',2.00,0.00,1469150378,1469150378,398846095),(369,2,1,'quanmei20160721195050',0.00,100.00,1469157975,1469157975,246667211),(370,2,1,'quanmei20160721195050',0.00,100.00,1469157978,1469157978,246667211),(371,2,1,'quanmei20160722091602',0.00,100.00,1469157997,1469157997,246667211),(372,2,1,'quanmei20160722091602',0.00,100.00,1469158001,1469158001,246667211),(373,2,1,'quanmei20160721194619',2.00,0.00,1469158018,1469158018,559391868),(374,1,1,' ',0.00,200.00,1469161256,1469161256,594111915),(375,1,1,' ',0.00,200.00,1469168766,1469168766,813079450),(376,1,1,' ',0.00,200.00,1469169770,1469169770,196931447),(377,1,1,' ',0.00,200.00,1469169790,1469169790,599677187),(378,1,1,' ',0.00,200.00,1469174961,1469174961,449039907),(379,2,2,'quanmei20160722171540',0.00,0.00,1469179004,1469179004,594111915),(380,2,2,'quanmei20160722172306',0.00,0.00,1469179472,1469179472,594111915),(381,1,1,' ',0.00,200.00,1469180004,1469180004,187018269),(382,2,2,'quanmei20160722172201',0.00,0.00,1469180062,1469180062,594111915),(383,1,1,' ',0.00,200.00,1469236689,1469236689,321108478),(384,1,1,' ',0.00,200.00,1469241194,1469241194,559391868),(385,1,1,' ',0.00,200.00,1469252913,1469252913,594111915),(386,1,1,' ',0.00,200.00,1469254628,1469254628,968527806),(387,1,1,' ',0.00,200.00,1469255833,1469255833,856636367),(388,2,1,'quanmei20160618140918',0.00,100.00,1469256576,1469256576,321108478),(389,2,2,'quanmei20160723145736',0.00,100.00,1469257062,1469257062,321108478),(390,2,2,'quanmei20160723145736',0.00,0.00,1469257118,1469257118,321108478),(391,2,1,'quanmei20160723145736',2.00,100.00,1469257231,1469257231,321108478),(392,2,2,'quanmei20160723150417',0.00,100.00,1469257461,1469257461,321108478),(393,1,1,' ',0.00,200.00,1469325214,1469325214,398846095),(394,1,1,' ',0.00,200.00,1469325752,1469325752,187018269),(395,1,1,' ',0.00,200.00,1469327527,1469327527,246667211),(396,1,1,' ',0.00,200.00,1469328852,1469328852,321108478),(397,1,1,' ',0.00,200.00,1469339200,1469339200,787747603),(398,1,1,' ',0.00,200.00,1469348119,1469348119,992902128),(399,1,1,' ',0.00,200.00,1469348473,1469348473,559391868),(400,2,2,'quanmei20160724182109',0.00,0.00,1469355708,1469355708,787747603),(401,2,2,'quanmei20160724182104',0.00,0.00,1469355776,1469355776,787747603),(402,2,1,'quanmei20160724182104',1200.00,120000.00,1469360428,1469360428,787747603),(403,2,1,'quanmei20160724182109',1200.00,119801.00,1469360440,1469360440,787747603),(404,1,1,' ',0.00,200.00,1469412911,1469412911,321108478),(405,1,1,' ',0.00,200.00,1469413786,1469413786,246667211),(406,1,1,' ',0.00,200.00,1469429759,1469429759,785251622),(407,1,1,' ',0.00,200.00,1469430309,1469430309,813079450),(408,1,1,' ',0.00,200.00,1469498307,1469498307,813079450),(409,1,1,' ',0.00,200.00,1469498383,1469498383,787747603),(410,1,1,' ',0.00,200.00,1469498840,1469498840,594111915),(411,2,2,'quanmei20160726103349',0.00,100.00,1469500449,1469500449,594111915),(412,1,1,' ',0.00,200.00,1469502004,1469502004,321108478),(413,1,1,' ',0.00,200.00,1469511245,1469511245,436942141),(414,1,1,' ',0.00,200.00,1469513701,1469513701,449039907),(415,1,1,' ',0.00,200.00,1469587242,1469587242,321108478),(416,2,2,'quanmei20160727104252',0.00,100.00,1469587383,1469587383,321108478),(417,2,1,'quanmei20160727104252',2.00,100.00,1469587585,1469587585,321108478),(418,1,1,' ',0.00,200.00,1469587924,1469587924,246667211),(419,1,1,' ',0.00,200.00,1469588481,1469588481,856636367),(420,1,1,' ',0.00,200.00,1469588970,1469588970,747892041),(421,2,2,'quanmei20160727145322',0.00,100.00,1469602411,1469602411,856636367),(422,2,1,'quanmei20160727145322',2.00,100.00,1469602809,1469602809,856636367),(423,1,1,' ',0.00,200.00,1469608772,1469608772,787747603),(424,1,1,' ',0.00,200.00,1469614504,1469614504,737426174),(425,1,1,' ',0.00,200.00,1469669524,1469669524,246667211),(426,1,1,' ',0.00,200.00,1469674753,1469674753,856636367),(427,1,1,' ',0.00,200.00,1469685318,1469685318,559391868),(428,1,1,' ',0.00,200.00,1469690638,1469690638,787747603),(429,1,1,' ',0.00,200.00,1469694104,1469694104,594111915),(430,1,1,' ',0.00,200.00,1469754413,1469754413,488826915),(431,1,1,' ',0.00,200.00,1469754681,1469754681,787747603),(432,1,1,' ',0.00,200.00,1469782663,1469782663,398846095),(433,1,1,' ',0.00,200.00,1469788759,1469788759,12279597),(434,1,1,' ',0.00,200.00,1469790421,1469790421,854364106),(435,1,1,' ',0.00,200.00,1469792908,1469792908,594111915),(436,1,1,' ',0.00,200.00,1469793198,1469793198,559391868),(437,1,1,' ',0.00,200.00,1469858561,1469858561,12279597),(438,1,1,' ',0.00,200.00,1469864307,1469864307,240291002),(439,1,1,' ',0.00,200.00,1469867478,1469867478,559391868),(440,1,1,' ',0.00,200.00,1469889969,1469889969,785251622),(441,1,1,' ',0.00,200.00,1469928046,1469928046,240291002),(442,1,1,' ',0.00,200.00,1469936821,1469936821,559391868),(443,1,1,' ',0.00,200.00,1469940988,1469940988,787747603),(444,1,1,' ',0.00,200.00,1469959073,1469959073,321108478),(445,1,1,' ',0.00,200.00,1470038843,1470038843,785251622),(446,1,1,' ',0.00,200.00,1470042153,1470042153,607552052),(447,1,1,' ',0.00,200.00,1470067917,1470067917,785251622),(448,1,1,' ',0.00,200.00,1470070512,1470070512,594111915),(449,1,1,' ',0.00,200.00,1470106546,1470106546,240291002),(450,1,1,' ',0.00,200.00,1470110136,1470110136,187018269),(451,1,1,' ',0.00,200.00,1470111203,1470111203,321108478),(452,2,2,'quanmei20160802122115',0.00,200.00,1470111692,1470111692,321108478),(453,2,1,'quanmei20160802122115',0.00,200.00,1470111789,1470111789,321108478),(454,2,1,'quanmei20160723150417',0.00,100.00,1470111841,1470111841,321108478),(455,2,2,'quanmei20160802122434',0.00,0.00,1470111923,1470111923,321108478),(456,2,1,'quanmei20160802122434',2.00,2.00,1470112388,1470112388,321108478),(457,2,2,'quanmei20160802124032',0.00,0.00,1470112979,1470112979,321108478),(458,2,2,'quanmei20160802124032',0.00,100.00,1470113015,1470113015,321108478),(459,2,2,'quanmei20160802124450',0.00,0.00,1470113117,1470113117,321108478),(460,2,2,'quanmei20160802124726',0.00,0.00,1470113273,1470113273,321108478),(461,2,2,'quanmei20160802124900',0.00,100.00,1470113351,1470113351,321108478),(462,2,2,'quanmei20160802124900',0.00,0.00,1470113373,1470113373,321108478),(463,2,1,'quanmei20160802124726',2.00,1.00,1470113904,1470113904,321108478),(464,2,1,'quanmei20160802124900',2.00,1.00,1470114067,1470114067,321108478),(465,2,1,'quanmei20160802124450',2.00,1.10,1470114231,1470114231,321108478),(466,1,1,' ',0.00,200.00,1470124528,1470124528,559391868),(467,1,1,' ',0.00,200.00,1470173607,1470173607,69401108),(468,1,1,' ',0.00,200.00,1470187996,1470187996,813079450),(469,1,1,' ',0.00,200.00,1470196674,1470196674,594111915),(470,2,2,'quanmei20160803115802',0.00,0.00,1470196715,1470196715,594111915),(471,2,1,'quanmei20160527114346',2.00,0.00,1470207358,1470207358,594111915),(472,1,1,' ',0.00,200.00,1470217293,1470217293,321108478),(473,1,1,' ',0.00,200.00,1470235058,1470235058,559391868),(474,1,1,' ',0.00,200.00,1470246069,1470246069,594111915),(475,1,1,' ',0.00,200.00,1470270580,1470270580,488826915),(476,1,1,' ',0.00,200.00,1470287655,1470287655,321108478),(477,1,1,' ',0.00,200.00,1470297017,1470297017,785251622),(478,1,1,' ',0.00,200.00,1470322803,1470322803,559391868),(479,1,1,' ',0.00,200.00,1470349662,1470349662,248595419),(480,1,1,' ',0.00,200.00,1470364674,1470364674,321108478),(481,1,1,' ',0.00,200.00,1470376067,1470376067,594111915),(482,1,1,' ',0.00,200.00,1470400645,1470400645,196931447),(483,1,1,' ',0.00,200.00,1470458000,1470458000,248595419),(484,1,1,' ',0.00,200.00,1470495350,1470495350,559391868),(485,1,1,' ',0.00,200.00,1470539201,1470539201,449039907),(486,1,1,' ',0.00,200.00,1470572399,1470572399,240291002),(487,1,1,' ',0.00,200.00,1470593333,1470593333,240291002),(488,1,1,' ',0.00,200.00,1470670065,1470670065,559391868),(489,1,1,' ',0.00,200.00,1470715912,1470715912,559391868),(490,1,1,' ',0.00,200.00,1470727401,1470727401,69401108),(491,1,1,' ',0.00,200.00,1470884812,1470884812,321108478),(492,1,1,' ',0.00,200.00,1470890971,1470890971,559391868),(493,2,2,'quanmei20160811174548',0.00,200.00,1470908760,1470908760,321108478),(494,2,2,'quanmei20160811174857',0.00,100.00,1470908944,1470908944,321108478),(495,1,1,' ',0.00,200.00,1470917002,1470917002,526235999),(496,1,1,' ',0.00,200.00,1470974124,1470974124,787747603),(497,1,1,' ',0.00,200.00,1470981191,1470981191,559391868),(498,1,1,' ',0.00,200.00,1471041783,1471041783,592063304),(499,1,1,' ',0.00,200.00,1471062565,1471062565,559391868),(500,1,1,' ',0.00,200.00,1471070346,1471070346,246667211),(501,1,1,' ',0.00,200.00,1471077464,1471077464,526235999),(502,1,1,' ',0.00,200.00,1471088386,1471088386,436942141),(503,1,1,' ',0.00,200.00,1471239158,1471239158,559391868),(504,1,1,' ',0.00,200.00,1471244574,1471244574,321108478),(505,2,1,'quanmei20160811174857',2.00,1.00,1471316283,1471316283,321108478),(506,2,1,'quanmei20160811174548',2.00,0.00,1471316290,1471316290,321108478),(507,1,1,' ',0.00,200.00,1471324789,1471324789,559391868),(508,1,1,' ',0.00,200.00,1471329489,1471329489,319813105),(509,1,1,' ',0.00,200.00,1471405771,1471405771,559391868),(510,1,1,' ',0.00,200.00,1471411647,1471411647,69401108),(511,1,1,' ',0.00,200.00,1471417009,1471417009,319813105),(512,1,1,' ',0.00,200.00,1471448094,1471448094,488826915);
/*!40000 ALTER TABLE `qm_point_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_point_rule`
--

DROP TABLE IF EXISTS `qm_point_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_point_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qd_point` decimal(10,2) unsigned NOT NULL,
  `xf_point` decimal(10,2) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  `xh_point` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='积分规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_point_rule`
--

LOCK TABLES `qm_point_rule` WRITE;
/*!40000 ALTER TABLE `qm_point_rule` DISABLE KEYS */;
INSERT INTO `qm_point_rule` VALUES (1,200.00,1.00,1470199811,100.00);
/*!40000 ALTER TABLE `qm_point_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_project`
--

DROP TABLE IF EXISTS `qm_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `jgfw` varchar(255) NOT NULL COMMENT '¼Û¸ñ·¶Î§',
  `fxzs` tinyint(1) unsigned NOT NULL COMMENT '·çÏÕÖ¸Êý',
  `cxsj` varchar(255) NOT NULL COMMENT '³ÖÐøÊ±¼ä',
  `zlsc` varchar(255) NOT NULL COMMENT 'ÖÎÁÆÊ±³¤',
  `zlcs` varchar(255) NOT NULL COMMENT 'ÖÎÁÆ´ÎÊý',
  `mzff` varchar(255) NOT NULL COMMENT 'Âé×í·½·¨',
  `sfzy` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'ÊÇ·ñ×¡Ôº£¬1·ñ2ÊÇ',
  `hfsj` varchar(255) NOT NULL COMMENT '»Ö¸´Ê±¼ä',
  `cxsj2` varchar(255) NOT NULL COMMENT '²ðÏßÊ±¼ä',
  `ptid` int(10) unsigned NOT NULL COMMENT 'ÏîÄ¿Àà±ð',
  `intime` int(10) NOT NULL COMMENT 'Ð´ÈëÊ±¼ä',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ÏîÄ¿±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_project`
--

LOCK TABLES `qm_project` WRITE;
/*!40000 ALTER TABLE `qm_project` DISABLE KEYS */;
INSERT INTO `qm_project` VALUES (1,'埋线双眼皮','1500元-5000元',2,'1-5年，因人而异','30分钟','1次','局麻',1,'完全恢复1-3个月','5-7天',2,1464775748),(2,'韩式微创双眼皮','3000元-10000元',3,'永久','30分钟','1次','局麻',1,'当天','5-7天',2,1464775875),(3,'全切双眼皮','3000元-5000元',4,'永久','1-2小时','1次','局麻',1,'2-3个月','5-7天',2,1466216683),(4,'健康风险评估','100-10000',1,'视具体项目而定','视具体项目而定','视具体项目而定','视具体项目而定',1,'视具体项目而定','无需缝拆线',1,1464851174),(5,'开眼角','3000-8000',4,'永久','1-2小时','1次','局麻',1,'2-3个月','5-7天',2,1466216731),(6,'立体纹眉','3000-5000',3,'永久','1-2小时','视具体情况而定','局麻',1,'3个月','无需缝拆线',2,1466216767),(7,'内路法祛眼袋','3000-5000',3,'永久，','30-40分钟','1次','局部',1,'7天','无需拆线',2,1464775948),(8,'外路法祛眼袋','3000-5000',1,'永久','40-60分钟','1次','局麻',1,'1-3个月','5-7天',2,1464775976),(9,'纹眼线','1000-6000',2,'因人而异','30-50分钟','视具体情况而定','局麻',1,'7-15天','无需拆线',2,1466216883),(10,'上睑下垂矫正术','2000-10000',1,'永久','20-30分钟','1次','局部麻醉',1,'3-6个月','5-7天',2,1466216942),(11,'宽鼻整形','5000-20000',4,'永久','1小时','1次','局麻',1,'半年','1-2周',3,1464776038),(12,'歪鼻矫正术','15000-30000',3,'永久','2小时','1次','局麻',1,'半年','1个月',3,1464776059),(13,'鼻头缩小术','15000-30000',4,'永久','1-2小时','1次','局麻',1,'半年','1-2周',3,1464776072),(14,'玻尿酸隆鼻','6000-10000',1,'一年左右','10分钟','1次','局麻',1,'1天','无需拆线',3,1464776090),(15,'膨体隆鼻','10000-30000',3,'永久','1-2小时','1次','局麻',2,'3-6个月','5-7天',3,1464776112),(16,'硅胶隆鼻','5000-10000',3,'永久','1-2小时','1次','局麻',1,'3-6个月','5-7天',3,1464776125),(17,'自体脂肪隆鼻','80000-20000',3,'半年左右','1-2小时','1次','局麻',1,'半年','5-7天',3,1464776144),(18,'自体软骨隆鼻','8000-20000',3,'永久','1-2小时','1次','局麻',1,'3-6个月','5-7天',3,1464776230),(19,'鼻综合整形','15000-30000',4,'永久','1-2小时','1次','局麻',1,'3-6个月','5-7天',3,1464776250),(20,'美白针','2000-6000',3,'1年','1-2小时','6-12次','无需麻醉',1,'1天','无需缝拆线',8,1466216544),(21,'丰太阳穴','3000-20000',3,'视材料而定','30-120分钟','视具体情况而定','局麻或全麻',1,'视手术方法而定','5-7天',4,1466049252),(22,'种植牙','1000-30000',3,'40年','3个月','1次','局部麻醉',1,'6个月','5-7天',9,1466216443),(23,'丰额头','3000-20000',3,'视材料而定','30-120分钟','视材料而定','局麻或全麻',1,'1-3个月','视手术方法而定',4,1466047709),(24,'激光溶脂术','3000-8000',1,'永久','15-60分钟','1次','局麻',1,'1天','无需拆线',6,1466216061),(25,'吸脂瘦身','4000-20000',4,'永久','1-2小时','1-3次，视具体情况而定','局麻',1,'1-3个月','5-7天',6,1466216073),(26,'自体脂肪丰臀','8000-30000',3,'永久','1-2小时','1-3次，视具体情况而定','局麻',1,'1-2个月','5-7天',6,1466216085),(27,'乳晕缩小术','6000-30000',3,'永久','1-2小时','1次','局麻',1,'2-3个月','7-8天',5,1466215960),(28,'假体隆胸术','12000-50000',5,'永久','3天','1次','局部麻醉',2,'3-6个月','7-10天',5,1466215974),(29,'自体脂肪隆胸','10000-30000',4,'永久','3小时','1-3次','局部麻醉',2,'3-6个月','7-10天',5,1466215994),(30,'阴道成形术','20000-10000',5,'永久','2-6小时','1次','局麻',2,'3-6个月','7-10天',10,1466216408),(31,'阴道紧缩术','6000-20000',3,'永久','40-60分钟','1次','局麻',2,'1-2个月','7-10天',10,1466216397),(32,'处女膜修复','3000-10000',3,'永久','30-40分钟','1次','局麻',1,'1-2个月','7-10天',10,1466216376),(33,'激光脱毛','2000-10000',2,'永久','15-30分钟','3-8次，因人而异','无需麻醉',1,'1-3天','无需缝拆线',7,1466216156),(34,'切眉术','1000-5000',3,'永久','30-60分钟','1次','局麻',1,'2-3个月','7-10天',2,1464776685),(35,'双眼皮修复','3000-8000',2,'永久','30-60分钟','1次','局麻',1,'3-5天','5-7天',2,1465356725),(36,'健康跟踪监测','2000-99999',1,'视具体方案而定','视具体方案而定','视具体方案而定','无需麻醉',1,'视具体方案而定','无需缝拆线',1,1464866372),(37,'激光祛斑','1000-5000',3,'永久','10-60分钟','2-4次','无需麻醉',1,'3天','无需拆线',7,1466216174),(38,'激光祛痘','1000-5000',1,'永久','10-30分钟','2-4次','无需麻醉',2,'1天','无需拆线',7,1466216184),(39,'光子嫩肤','1000-10000',1,'2-3年','30-60分钟','5次左右','无需麻醉',1,'7-10天','无需缝拆线',7,1466215838),(40,'自体脂肪除颈纹','2000-10000',3,'永久','30-60分钟','1次','局麻',1,'7-10天','无拆线',7,1466215856),(41,'注射除皱','3000-10000',2,'视材料而定','30-60分钟','视具体情况而定','局麻',1,'无需恢复期','无拆线',7,1466215876),(42,'丰下巴','3000-10000',4,'永久','30-60分钟','视具体情况而定','局麻',1,'7-10天','视手术方法而定',4,1466047305),(43,'超声刀','30000-50000',3,'3-5年','30-60分钟','1次','无需麻醉',1,'5-7天','无需缝拆线',7,1466215887),(44,'牙齿美白','200-20000',1,'3-5年','30-60分钟','1次','局麻',1,'1天','无需缝拆线',9,1466216328),(45,'健康干预','1000-99999',3,'视具体方案而定','视具体方案而定','视具体方案而定','视具体方案而定',1,'视具体方案而定','无需缝拆线',1,1464853469),(46,'水光针','1980-3980',1,'1-3个月','10-20分钟','1次','无需麻醉',1,'1-2天','无需缝拆线',8,1466216236),(47,'玻尿酸','1000-3000',1,'3-12个月','10-30分钟','1次','局部麻醉',1,'1-3天','无需缝拆线',8,1466216284),(48,'瘦脸针','2000-5000',2,'3-6个月','20-40分钟','1次','局部麻醉',1,'5-7天','无需缝拆线',8,1466216220),(49,'胶原蛋白','2000-5000',1,'1-2年','20-40分钟','2-3次','局部麻醉',1,'1-3天','无需缝拆线',8,1466216201),(50,'颧骨整形','10000-100000',5,'永久','3-6小时','1次','全身麻醉',2,'3-6个月','5-7天',4,1464779814),(51,'下颌角截骨术','10000-100000',5,'永久','1-3个小时','1次','全身麻醉',2,'3-6个月','5-7天',4,1464779828),(52,'自体脂肪丰面颊','3000-20000',3,'1年以上，甚至永久','30-60分钟','多次治疗','局部麻醉',1,'15-30天','无需缝拆线',4,1464779836),(53,'埋线提升','10000-50000',3,'1-5年，因人而异','30-60分钟','1次或多次','局部麻醉',1,'3-5天','无需拆线',7,1466215928),(54,'牙齿矫正','6000-30000',1,'永久','30-60分钟','多次治疗','局部麻醉',1,'1-3年','无需缝拆线',9,1466216346),(55,'热玛吉','30000-99999',2,'3-5年','40-60分钟','一次','局部麻醉',1,'1天','无需缝拆线',7,1466215941),(56,'面部吸脂','2000-5000',3,'永久','60分钟','1次','局部麻醉',1,'1-2个月','5-7天',4,1465877047),(57,'眉毛移植','5000-35000',3,'永久','60分钟','多次','局部麻醉',1,'3-6个月','5-7天',2,1465877496),(58,'丰唇','1000-6000',2,'视材料而定','30-50分钟','视材料而定','局部麻醉',1,'视手术方法而定','无需缝拆线',4,1466070182),(59,'丰苹果肌','2000-10000',2,'视材料而定','30-120分钟','视具体情况而定','局部麻醉',1,'视手术方法而定','无需缝拆线',4,1466071458);
/*!40000 ALTER TABLE `qm_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_project_type`
--

DROP TABLE IF EXISTS `qm_project_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_project_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='项目类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_project_type`
--

LOCK TABLES `qm_project_type` WRITE;
/*!40000 ALTER TABLE `qm_project_type` DISABLE KEYS */;
INSERT INTO `qm_project_type` VALUES (1,'健康管理','images/icon/project/jiankang5.png',1466215089),(2,'眼眉整形','images/icon/project/yanjing617.png',1466215113),(3,'鼻部整形','images/icon/project/bizi617.png',1466215133),(4,'面部轮廓','images/icon/project/lunkuo617.png',1466215160),(5,'胸部整形','images/icon/project/xiong617.png',1466215338),(6,'吸脂塑形','images/icon/project/xingti617.png',1466215429),(7,'皮肤美容','images/icon/project/pifu.png',1466215537),(8,'微整形','images/icon/project/weizheng617.png',1466215573),(9,'口腔美容','images/icon/project/ya617.png',1466215690),(10,'私密整形','images/icon/project/simi617.png',1470042856);
/*!40000 ALTER TABLE `qm_project_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_province`
--

DROP TABLE IF EXISTS `qm_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_province` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='省份表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_province`
--

LOCK TABLES `qm_province` WRITE;
/*!40000 ALTER TABLE `qm_province` DISABLE KEYS */;
INSERT INTO `qm_province` VALUES (1,'北京市'),(2,'天津市'),(3,'河北省'),(4,'山西省'),(5,'内蒙古自治区'),(6,'辽宁省'),(7,'吉林省'),(8,'黑龙江省'),(9,'上海市'),(10,'江苏省'),(11,'浙江省'),(12,'安徽省'),(13,'福建省'),(14,'江西省'),(15,'山东省'),(16,'河南省'),(17,'湖北省'),(18,'湖南省'),(19,'广东省'),(20,'广西壮族自治区'),(21,'海南省'),(22,'重庆市'),(23,'四川省'),(24,'贵州省'),(25,'云南省'),(26,'西藏自治区'),(27,'陕西省'),(28,'甘肃省'),(29,'青海省'),(30,'宁夏回族自治区'),(31,'新疆维吾尔自治区'),(32,'香港特别行政区'),(33,'澳门特别行政区'),(34,'台湾省');
/*!40000 ALTER TABLE `qm_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_redirect_links`
--

DROP TABLE IF EXISTS `qm_redirect_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) NOT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_redirect_links`
--

LOCK TABLES `qm_redirect_links` WRITE;
/*!40000 ALTER TABLE `qm_redirect_links` DISABLE KEYS */;
INSERT INTO `qm_redirect_links` VALUES (1,'http://www.baidu.comhttp//www.baidu.com/','','','',137,0,'2016-02-01 15:24:20','0000-00-00 00:00:00'),(2,'http://azenv.nethttp//azenv.net/','','','',1,0,'2016-02-03 04:05:54','0000-00-00 00:00:00'),(3,'http://www.baidu.comhttp//www.baidu.com','','','',6,0,'2016-02-03 07:11:58','0000-00-00 00:00:00'),(4,'http://www.so.comhttp//www.so.com/','','','',10,0,'2016-02-04 14:12:08','0000-00-00 00:00:00'),(5,'http://24x7-allrequestsallowed.comhttp//24x7-allrequestsallowed.com/?PHPSESSID=aab45f4f00143PSWJWWHYFEFUF[','','','',8,0,'2016-02-04 22:28:14','0000-00-00 00:00:00'),(6,'http://ip.cnhttp//ip.cn/','','','',1,0,'2016-02-05 09:54:15','0000-00-00 00:00:00'),(7,'http://www.example.comhttp//www.example.com/','','','',10,0,'2016-02-05 22:27:22','0000-00-00 00:00:00'),(8,'http://iwannaknow.tkhttp//iwannaknow.tk/index.php','','','',1,0,'2016-02-11 20:27:39','0000-00-00 00:00:00'),(9,'http://proxyjudge.ushttp//proxyjudge.us/','','','',3,0,'2016-02-13 21:38:44','0000-00-00 00:00:00'),(10,'http://114.119.41.119/index.php?option=com_contenthistory&view=history&list[ordering]=&item_id=1&type_id=1&list[select]=(select 1 from (select count(*),concat((select 0x6176666973686572),floor(rand(0)*2))x from information_schema.tables group by x)a)','','','',2,0,'2016-02-18 11:12:18','0000-00-00 00:00:00'),(11,'http://www.wikipedia.orghttp//www.wikipedia.org/','','','',1,0,'2016-02-22 07:15:59','0000-00-00 00:00:00'),(12,'http://wenku.baidu.comhttp//wenku.baidu.com/','','','',55,0,'2016-02-25 05:33:56','0000-00-00 00:00:00'),(13,'http://wzhidao.baidu.comhttp//wzhidao.baidu.com/','','','',2,0,'2016-02-27 07:44:04','0000-00-00 00:00:00'),(14,'http://wap.ip138.comhttp//wap.ip138.com/','','','',9,0,'2016-03-01 11:40:45','0000-00-00 00:00:00'),(15,'http://zhidao.baidu.comhttp//zhidao.baidu.com/','','','',15,0,'2016-03-01 15:04:08','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `qm_redirect_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_relation_pg`
--

DROP TABLE IF EXISTS `qm_relation_pg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_relation_pg` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL,
  `gid` int(10) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ÏîÄ¿ÓëÐ¡×é¹ØÁª±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_relation_pg`
--

LOCK TABLES `qm_relation_pg` WRITE;
/*!40000 ALTER TABLE `qm_relation_pg` DISABLE KEYS */;
INSERT INTO `qm_relation_pg` VALUES (1,2,9,1450007752),(2,1,9,1450007752),(3,59,11,1470042008),(4,9,9,1470114516),(5,6,9,1470114516),(6,5,9,1470114516),(7,3,9,1470114516),(8,35,9,1470114549),(9,34,9,1470114549),(10,57,9,1470114566),(11,19,10,1470114600),(12,18,10,1470114600),(13,17,10,1470114600),(14,16,10,1470114600),(15,15,10,1470114601),(16,14,10,1470114601),(17,13,10,1470114601),(18,12,10,1470114601),(19,11,10,1470114601),(20,10,9,1470114608),(21,8,9,1470114617),(22,7,9,1470114617),(23,23,11,1470114667),(24,21,11,1470114667),(25,58,11,1470114713),(26,56,11,1470114713),(27,52,11,1470114713),(28,51,11,1470114713),(29,50,11,1470114713),(30,48,11,1470114713),(31,47,11,1470114713),(32,42,11,1470114713),(33,55,12,1470114738),(34,53,12,1470114738),(35,49,12,1470114738),(36,46,12,1470114738),(37,41,12,1470114738),(38,40,12,1470114738),(39,39,12,1470114762),(40,38,12,1470114762),(41,37,12,1470114762),(42,33,12,1470114762),(43,20,12,1470114762),(44,26,13,1470114820),(45,25,13,1470114820),(46,24,13,1470114820),(47,29,14,1470114874),(48,28,14,1470114874),(49,27,14,1470114874),(50,22,15,1470114945),(51,54,15,1470114966),(52,44,15,1470114966),(53,45,16,1470114980),(54,36,16,1470114993),(55,4,16,1470115044);
/*!40000 ALTER TABLE `qm_relation_pg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_relation_wt`
--

DROP TABLE IF EXISTS `qm_relation_wt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_relation_wt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wid` int(10) unsigned NOT NULL,
  `tid` int(10) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=581 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ÎÄÕÂÓë±êÇ©¹ØÏµ±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_relation_wt`
--

LOCK TABLES `qm_relation_wt` WRITE;
/*!40000 ALTER TABLE `qm_relation_wt` DISABLE KEYS */;
INSERT INTO `qm_relation_wt` VALUES (171,166,43,1448940744),(172,167,43,1448941168),(173,168,43,1448943103),(174,169,43,1448944598),(175,170,44,1448946728),(176,171,44,1448947000),(177,172,44,1448955671),(178,173,44,1448956323),(179,174,44,1448956462),(180,175,43,1448957251),(181,176,43,1448957383),(182,177,43,1448957710),(183,178,46,1448958297),(184,179,50,1448959098),(185,180,49,1448959171),(186,181,43,1448959410),(187,196,55,1449022166),(188,197,55,1449022326),(189,198,55,1449022350),(190,199,55,1449022389),(191,200,43,1449025867),(192,201,43,1449025920),(193,202,43,1449026100),(194,203,50,1449026746),(195,204,55,1449032795),(196,205,55,1449035201),(197,206,55,1449035738),(198,207,47,1449037457),(199,208,57,1449055827),(200,209,55,1449128516),(201,210,43,1449214105),(202,211,43,1449215538),(203,212,44,1449215614),(204,212,45,1449215614),(205,213,45,1449219870),(206,214,44,1449219964),(207,215,44,1449221800),(208,217,43,1449474234),(209,218,50,1449474386),(210,219,43,1449476221),(211,220,46,1449476304),(212,221,46,1449483954),(213,222,46,1449483987),(214,223,44,1449484126),(215,224,43,1449484151),(216,225,47,1449537408),(217,226,46,1449543703),(218,228,43,1449545147),(219,229,43,1449545175),(220,230,43,1449548943),(221,232,43,1449549117),(222,233,43,1449549148),(223,234,43,1449554114),(224,235,43,1449554964),(225,236,43,1449555468),(226,237,43,1449562235),(227,237,44,1449562235),(228,237,45,1449562235),(229,238,43,1449562461),(230,239,54,1449564646),(231,239,55,1449564646),(232,240,55,1449564701),(233,240,54,1449564701),(234,241,52,1449565288),(235,242,52,1449565422),(236,243,53,1449565503),(237,244,51,1449565647),(238,245,51,1449565811),(239,246,51,1449565918),(240,247,54,1449566407),(241,248,55,1449568483),(242,248,54,1449568483),(243,249,55,1449568536),(244,249,54,1449568536),(245,250,55,1449568577),(246,250,54,1449568577),(247,251,43,1449628466),(248,252,54,1449798752),(249,253,47,1449798793),(250,254,61,1449811783),(251,255,43,1449911693),(252,256,43,1449999356),(253,257,44,1450001300),(254,258,56,1450073813),(255,259,43,1450079491),(256,260,61,1450080912),(257,261,61,1450081156),(258,262,44,1450086448),(259,263,46,1450086929),(260,264,50,1450086983),(261,265,51,1450087036),(262,266,55,1450087087),(263,268,43,1450087414),(264,269,47,1450087566),(265,270,49,1450087694),(266,271,52,1450087815),(267,272,44,1450162477),(268,273,43,1450163738),(269,274,44,1450167244),(270,275,44,1450167330),(271,276,43,1450173294),(272,277,44,1450173730),(273,278,50,1450326251),(274,279,53,1450326290),(275,280,53,1450326337),(276,281,54,1450329725),(277,281,55,1450329725),(278,282,47,1450330673),(279,283,50,1450330843),(280,284,62,1450332192),(281,285,60,1450332601),(282,286,50,1450333440),(283,287,50,1450333454),(284,288,50,1450333499),(285,289,50,1450333528),(286,290,50,1450333531),(287,291,50,1450333532),(288,292,50,1450333534),(289,293,50,1450333543),(290,294,50,1450333545),(291,295,50,1450333548),(292,296,50,1450333551),(293,296,50,1450333551),(294,298,50,1450333552),(295,298,50,1450333552),(296,300,50,1450333553),(297,301,50,1450333561),(298,302,50,1450333565),(299,303,50,1450333567),(300,304,50,1450333568),(301,305,49,1450333704),(302,306,56,1450334174),(303,307,61,1450334229),(304,308,62,1450343341),(305,308,61,1450343341),(306,309,47,1450663484),(307,310,54,1450690947),(308,310,55,1450690947),(309,311,55,1450693030),(310,312,44,1450695385),(311,313,48,1450695484),(312,314,50,1450695630),(313,315,57,1450695963),(314,316,47,1450748247),(315,317,55,1450756028),(316,317,54,1450756028),(317,318,57,1450759244),(318,319,44,1450759360),(319,320,44,1451096760),(320,321,43,1451101473),(321,322,44,1451105829),(322,325,46,1451108508),(323,326,47,1451108552),(324,327,50,1451108558),(325,329,47,1451108779),(326,330,46,1451108851),(327,331,61,1451109128),(328,333,62,1451109730),(329,334,61,1451109867),(330,335,59,1451110485),(331,336,59,1451110545),(332,337,59,1451110767),(333,338,47,1451110879),(334,339,62,1451111021),(335,339,61,1451111021),(336,340,50,1451111447),(337,341,47,1451111657),(338,342,49,1451111727),(339,343,61,1451111890),(340,344,52,1451111931),(341,346,56,1451112009),(342,347,57,1451112037),(343,349,47,1451112100),(344,350,47,1451112114),(345,351,48,1451112334),(346,353,60,1451118671),(347,354,44,1451440644),(348,356,44,1452133315),(349,357,44,1454059373),(350,358,43,1454059404),(351,360,44,1454480550),(352,361,47,1456137049),(353,362,44,1456192132),(354,363,44,1456192192),(355,364,44,1456194865),(356,365,43,1456194960),(357,366,48,1456195013),(358,367,46,1456195056),(359,368,48,1456195119),(360,369,47,1456195166),(361,370,45,1456197704),(362,371,47,1456203519),(363,372,47,1456203622),(364,379,43,1456820708),(365,380,43,1456820988),(366,381,43,1456820989),(367,381,43,1456820989),(368,381,43,1456820989),(369,384,43,1456820990),(370,384,43,1456820990),(371,395,54,1456825321),(372,403,54,1456887406),(373,403,55,1456887406),(374,404,57,1456887941),(375,406,56,1456888501),(376,407,56,1456888502),(377,416,43,1456895338),(378,417,43,1456895474),(379,418,43,1456896309),(380,809,51,1458630113),(381,810,51,1458630199),(382,819,43,1458706152),(383,819,44,1458706152),(384,821,43,1458706328),(385,823,45,1458706716),(386,823,43,1458706716),(387,824,43,1458706816),(388,824,44,1458706816),(389,825,43,1458706925),(390,826,43,1458707133),(391,831,46,1458709768),(392,834,64,1458710630),(393,840,59,1458711735),(394,855,47,1459843194),(395,855,48,1459843194),(396,856,64,1459844654),(397,857,46,1459846005),(398,860,43,1459943635),(399,862,64,1459944654),(400,865,64,1459945696),(401,867,63,1459946338),(402,867,64,1459946338),(403,869,59,1459947643),(404,870,43,1459995276),(405,871,46,1459995680),(406,872,43,1459996525),(407,873,55,1459996869),(408,873,54,1459996869),(409,875,43,1459997767),(410,877,56,1459999290),(411,877,65,1459999290),(412,878,46,1459999335),(413,879,46,1459999767),(414,880,63,1460001495),(415,880,64,1460001495),(416,881,54,1460003398),(417,882,55,1460008651),(418,882,54,1460008651),(419,883,46,1460008925),(420,883,47,1460008926),(421,883,48,1460008926),(422,884,56,1460009370),(423,884,66,1460009370),(424,885,43,1460009746),(425,887,69,1460015501),(426,888,51,1460015835),(427,889,46,1460016239),(428,890,43,1460016290),(429,891,43,1460016509),(430,891,44,1460016509),(431,892,46,1460016720),(432,893,43,1460016852),(433,894,46,1460016931),(434,895,46,1460017122),(435,897,62,1460032721),(436,899,43,1460078091),(437,900,43,1460080889),(438,901,69,1460081525),(439,902,56,1460082093),(440,903,49,1460082518),(441,904,49,1460084424),(442,904,50,1460084424),(443,904,63,1460084424),(444,904,64,1460084424),(445,904,67,1460084424),(446,905,46,1460099150),(447,906,46,1460099816),(448,907,46,1460099818),(449,909,66,1460165863),(450,909,56,1460165863),(451,910,46,1460173408),(452,916,43,1460177116),(453,918,46,1460189050),(454,919,70,1460190374),(455,920,46,1460191316),(456,921,46,1460191471),(457,922,46,1460191810),(458,923,43,1460192234),(459,923,70,1460192234),(460,924,43,1460192964),(461,925,49,1460193680),(462,925,63,1460193680),(463,927,43,1460338216),(464,928,69,1460338875),(465,929,63,1460339340),(466,930,64,1460340163),(467,930,63,1460340163),(468,931,53,1460340395),(469,933,66,1460341549),(470,934,54,1460342743),(471,935,45,1460343279),(472,936,49,1460343570),(473,937,69,1460356234),(474,938,71,1460356681),(475,939,72,1460357828),(476,941,55,1460358372),(477,944,57,1460360189),(478,944,66,1460360189),(479,945,46,1460360946),(480,950,45,1460425689),(481,951,45,1460426097),(482,952,45,1460426321),(483,953,43,1460426535),(484,954,43,1460427045),(485,955,43,1460427663),(486,955,45,1460427663),(487,956,43,1460428033),(488,956,44,1460428033),(489,957,43,1460428514),(490,958,43,1460428880),(491,959,54,1460620301),(492,960,73,1460620766),(493,961,75,1460622709),(494,962,73,1460623796),(495,963,75,1460683413),(496,964,63,1460684300),(497,964,64,1460684300),(498,965,63,1460684486),(499,965,64,1460684486),(500,966,75,1460685124),(501,967,67,1460685862),(502,968,66,1460686343),(503,968,57,1460686343),(504,969,55,1460686721),(505,970,57,1460686981),(506,970,66,1460686981),(507,971,57,1460687308),(508,971,66,1460687308),(509,972,57,1460687850),(510,972,66,1460687850),(511,973,65,1460688025),(512,973,56,1460688025),(513,974,57,1460702854),(514,974,66,1460702854),(515,975,57,1460703262),(516,975,66,1460703262),(517,976,57,1460703610),(518,976,66,1460703610),(519,977,57,1460704251),(520,977,66,1460704251),(521,978,57,1460705641),(522,978,66,1460705641),(523,979,64,1460706304),(524,980,64,1460706415),(525,981,64,1460707605),(526,981,63,1460707605),(527,982,63,1460707673),(528,982,64,1460707673),(529,984,64,1460710182),(530,985,67,1460712129),(531,986,43,1460712671),(532,986,44,1460712671),(533,986,45,1460712671),(534,987,63,1460716698),(535,987,64,1460716698),(536,987,67,1460716698),(537,988,43,1460717290),(538,989,64,1460719567),(539,989,67,1460719567),(540,990,74,1460949652),(541,991,63,1460950397),(542,992,64,1460972492),(543,993,75,1460973408),(544,993,49,1460973408),(545,994,43,1460974144),(546,994,44,1460974144),(547,995,43,1460974585),(548,995,44,1460974585),(549,996,65,1461044947),(550,996,56,1461044947),(551,997,69,1461047540),(552,998,75,1461048167),(553,998,63,1461048167),(554,1000,73,1461049819),(555,1001,73,1461054063),(556,1002,48,1461056653),(557,1003,72,1461057095),(558,1004,67,1461058029),(559,1004,68,1461058029),(560,1005,46,1461058851),(561,1006,46,1461059522),(562,1006,48,1461059522),(563,1007,46,1461061756),(564,1009,43,1466059338),(565,1010,46,1466059651),(566,1012,46,1466060981),(567,1013,46,1466061084),(568,1015,70,1466128429),(569,1016,70,1466128438),(570,1017,46,1466128602),(571,1018,56,1466129761),(572,1019,70,1466134696),(573,1020,43,1466229529),(574,1021,70,1466229609),(575,1021,44,1466229609),(576,1022,48,1466758307),(577,1023,43,1469255802),(578,1025,46,1470373546),(579,1026,70,1470647404),(580,1027,43,1470647670);
/*!40000 ALTER TABLE `qm_relation_wt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_report_wenzhang`
--

DROP TABLE IF EXISTS `qm_report_wenzhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_report_wenzhang` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `articleId` int(10) DEFAULT NULL,
  `reporterId` int(10) DEFAULT NULL,
  `intime` int(10) DEFAULT NULL,
  `authorId` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_report_wenzhang`
--

LOCK TABLES `qm_report_wenzhang` WRITE;
/*!40000 ALTER TABLE `qm_report_wenzhang` DISABLE KEYS */;
INSERT INTO `qm_report_wenzhang` VALUES (1,858,594111915,1470301742,682875857),(2,859,785251622,1470301758,726176698),(3,859,594111915,1471253501,726176698),(4,1027,785251622,1471328681,594111915);
/*!40000 ALTER TABLE `qm_report_wenzhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_sc`
--

DROP TABLE IF EXISTS `qm_sc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_sc` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(9) unsigned NOT NULL,
  `scid` int(10) unsigned NOT NULL COMMENT 'è¢«æ”¶è—çš„id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1ï¼Œæ–‡ç« ï¼›2ç‰¹æƒ ',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç”¨æˆ·æ”¶è—è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_sc`
--

LOCK TABLES `qm_sc` WRITE;
/*!40000 ALTER TABLE `qm_sc` DISABLE KEYS */;
INSERT INTO `qm_sc` VALUES (1,594111915,338,1,1451542819),(2,594111915,321,1,1451544357),(3,449039907,354,1,1451545126),(4,449039907,353,1,1451545477),(5,594111915,354,1,1451548606),(6,594111915,353,1,1451548614),(7,594111915,360,1,1456137239),(8,594111915,359,1,1456137244),(9,594111915,358,1,1456137250),(10,594111915,343,1,1456137257),(11,594111915,341,1,1456137266),(12,594111915,339,1,1456137273),(13,594111915,337,1,1456137278),(14,436942141,455,1,1457266884),(15,449039907,847,1,1459411451),(16,594111915,1001,1,1461207274),(17,518396413,1001,1,1461207276),(18,887915923,1008,1,1463566162),(19,559391868,854,1,1464605712),(20,856636367,859,1,1466062805),(21,968527806,1013,1,1466063160),(23,856636367,1021,1,1466676658),(26,813079450,1024,1,1469498511),(30,785251622,856,1,1470298641),(34,594111915,1024,1,1470378472),(35,321108478,858,1,1470386390),(36,594111915,1025,1,1470390073),(38,594111915,1027,1,1471340289);
/*!40000 ALTER TABLE `qm_sc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_schemas`
--

DROP TABLE IF EXISTS `qm_schemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_schemas`
--

LOCK TABLES `qm_schemas` WRITE;
/*!40000 ALTER TABLE `qm_schemas` DISABLE KEYS */;
INSERT INTO `qm_schemas` VALUES (700,'2.5.28');
/*!40000 ALTER TABLE `qm_schemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_session`
--

DROP TABLE IF EXISTS `qm_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_session` (
  `session_id` varchar(200) NOT NULL DEFAULT '',
  `client_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `guest` tinyint(4) unsigned DEFAULT '1',
  `time` varchar(14) DEFAULT '',
  `data` mediumtext,
  `userid` int(11) DEFAULT '0',
  `username` varchar(150) DEFAULT '',
  `usertype` varchar(50) DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `whosonline` (`guest`,`usertype`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_session`
--

LOCK TABLES `qm_session` WRITE;
/*!40000 ALTER TABLE `qm_session` DISABLE KEYS */;
INSERT INTO `qm_session` VALUES ('ed3a71f4918094b4a6be9952710e3d60',1,0,'1471316291','__default|a:8:{s:15:\"session.counter\";i:12;s:19:\"session.timer.start\";i:1471316253;s:18:\"session.timer.last\";i:1471316290;s:17:\"session.timer.now\";i:1471316291;s:22:\"session.client.browser\";s:72:\"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0\";s:8:\"registry\";O:9:\"JRegistry\":1:{s:7:\"\0*\0data\";O:8:\"stdClass\":3:{s:11:\"application\";O:8:\"stdClass\":1:{s:4:\"lang\";s:0:\"\";}s:9:\"com_tehui\";O:8:\"stdClass\":1:{s:6:\"tehuis\";O:8:\"stdClass\":1:{s:8:\"ordercol\";N;}}s:9:\"com_order\";O:8:\"stdClass\":1:{s:4:\"edit\";O:8:\"stdClass\":1:{s:5:\"order\";O:8:\"stdClass\":2:{s:2:\"id\";a:2:{i:0;i:94;i:1;i:93;}s:4:\"data\";N;}}}}}s:4:\"user\";O:5:\"JUser\":25:{s:9:\"\0*\0isRoot\";b:1;s:2:\"id\";s:3:\"973\";s:4:\"name\";s:10:\"Super User\";s:8:\"username\";s:5:\"admin\";s:5:\"email\";s:16:\"183107471@qq.com\";s:8:\"password\";s:34:\"$P$DSK2isjYoEz/KIxlVSSThfBp2fk28/0\";s:14:\"password_clear\";s:0:\"\";s:8:\"usertype\";s:10:\"deprecated\";s:5:\"block\";s:1:\"0\";s:9:\"sendEmail\";s:1:\"1\";s:12:\"registerDate\";s:19:\"2015-08-24 00:42:34\";s:13:\"lastvisitDate\";s:19:\"2016-08-15 09:48:23\";s:10:\"activation\";s:1:\"0\";s:6:\"params\";s:92:\"{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}\";s:6:\"groups\";a:1:{i:8;s:1:\"8\";}s:5:\"guest\";i:0;s:13:\"lastResetTime\";s:19:\"0000-00-00 00:00:00\";s:10:\"resetCount\";s:1:\"0\";s:10:\"\0*\0_params\";O:9:\"JRegistry\":1:{s:7:\"\0*\0data\";O:8:\"stdClass\":6:{s:11:\"admin_style\";s:0:\"\";s:14:\"admin_language\";s:0:\"\";s:8:\"language\";s:0:\"\";s:6:\"editor\";s:0:\"\";s:8:\"helpsite\";s:0:\"\";s:8:\"timezone\";s:0:\"\";}}s:14:\"\0*\0_authGroups\";a:2:{i:0;i:1;i:1;i:8;}s:14:\"\0*\0_authLevels\";a:4:{i:0;i:1;i:1;i:1;i:2;i:2;i:3;i:3;}s:15:\"\0*\0_authActions\";N;s:12:\"\0*\0_errorMsg\";N;s:10:\"\0*\0_errors\";a:0:{}s:3:\"aid\";i:0;}s:13:\"session.token\";s:32:\"85fd177123afce55ab1ebb4c403b1d38\";}',973,'admin','');
/*!40000 ALTER TABLE `qm_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_teacher`
--

DROP TABLE IF EXISTS `qm_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_teacher` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `courseid` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `intro` text NOT NULL,
  `img` varchar(255) DEFAULT NULL,
  `logo` varchar(255) NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='æ•™å¸ˆè¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_teacher`
--

LOCK TABLES `qm_teacher` WRITE;
/*!40000 ALTER TABLE `qm_teacher` DISABLE KEYS */;
INSERT INTO `qm_teacher` VALUES (1,1,'白洋','　　《由内而外的富足》传承训练师\r\n　　《富足系统》训练师演讲口才总导师\r\n　　深圳圣地雅歌文化传媒有限公司大型活动策划艺术总监导演\r\n　　企业品牌推广营销时尚活动策划人\r\n　　台湾心灵海国际教育集团企业魂内训训练师\r\n　　原广东电台播音主持人\r\n　　2005年获中国最佳新人主持人大奖，由前国务院副总理吴桂贤颁奖\r\n　　影响中国婚庆界十大候选人物及中国曦之缘高端婚礼主持人培训学校资深培训导师\r\n　　中国传统文化促进会——理事\r\n　　深圳市义工联艺术团——艺术总监\r\n　　中国人生爱心工程服务委员会——委员\r\n　　2005年感动中国人物，爱心大使，\r\n　　己故著名青年歌唱表演艺术家丛飞老师的关门大弟子；\r\n　　现担任国内三所助残学校机构名誉校长。\r\n\r\n　　人生格言：心中有爱，无所畏惧！','images/course/teacher/bg.png','images/course/teacher/t5.jpg',1457594603),(2,12,'房敏','　　《由内而外的富足》幸福训练师\r\n　　杭州市桐庐县优秀教师国家级心理咨询师\r\n　　浙江省中学一级心理教师\r\n　　桐庐县人民检察院聘为“2+1”帮教工作的志愿者\r\n　　被教育局聘为桐庐县中小学心理热线 58588500 的接线员志愿者。\r\n　　浙江省学校心理健康教育教师B级资格证书\r\n\r\n　　我问心，问问自己的内心，真正想要什么？\r\n　　我明白了我自己内心渴望的，就是做一个家庭教育的专业着和传播者！\r\n　　我渴望财富来改变家庭的现状。\r\n　　我开始向宇宙下订单，因为我相信我值得拥有。\r\n　　我也感悟到人生的价值和意义就是帮助了多少需要帮助的人们。\r\n　　只有这样当某一天我老去时才无悔于作为一个人来到这个世界。\r\n　　起于心，显于行，渡众生。\r\n　　我的人生格言是：人生就是一场圆梦的旅行。','images/course/teacher/teacher1.jpg','images/course/teacher/45a75234cec96aa594d0929e82275fb1.jpg',1457602338),(3,11,'周烨','　　《由内而外的富足》幸福训练师\r\n　　NLP高级执行师\r\n　　NAC心理学讲师\r\n　　超级记忆力实战训练师\r\n　　著作有《记忆密笈》\r\n\r\n　　参加过的课程：\r\n　　陈安之老师的《NAC心理学》\r\n　　戴洁老师的《亲子关系》\r\n　　陈帝豪老师的《36个鲜为人知的营销秘决》\r\n　　林君翰老师的《NLP领袖心理学》\r\n　　曹立青老师的《心灵成长》\r\n　　叶丽榕老师的《亲密关系》\r\n　　《由内而外的富足》微课系统\r\n\r\n　　人生格言：有爱的身躯不曾疲惫，有梦的翅膀才能高飞！\r\n\r\n　　感悟：上完《由内而外的富足》微课系统我觉得很落地，马上可以应用出来，我很喜欢的是，每次课程后老师所布置的功课，因为只有练习才能彻底改变我的行为模式，这不只是完成功课，更是在融入生活! 我认为一个课程能引领人们到生活中实践便是好课程。','images/course/teacher/teacher2.jpg','images/course/teacher/6144e40d1d9f6c69c974c8d1cb6d155b.jpg',1457602384),(4,10,'刘鸿','　　《由内而外的富足》幸福训练师\r\n　　2006年就读浙大成长型总裁班（EMBA），结业后任秘书长\r\n　　2010年成立浙江省服装行业协会制版分会秘书长（开创此平台，后为行业样板和标杆）\r\n　　2013年任杭州城市文化艺术交流中心80主任\r\n　　2013年任浙江山东商会副秘书长\r\n　　2014年，就读长江浙商领军班，结业后任长江浙商同学会副秘书长 \r\n\r\n　　汇灵老师人生格言：让事业在梦想中成长！','images/course/teacher/teacher3.jpeg','images/course/teacher/ec42ce33335fe7e9563d96acfac0a046.jpg',1457602431),(5,9,'彭福慧','　　《由内而外的富足》传承训练师\r\n　　陕西彭祖实业有限公司董事长\r\n　　世彭总商会副秘书长世彭总会理事\r\n　　陕西川渝商会副会长彭祖养生文化传承人\r\n　　彭祖商学院创始人\r\n　　彭祖福商城（网络）创始人\r\n　　北京大学EMBA毕业\r\n　　西北大学CEO总裁研修班毕业\r\n　　教练技术教练\r\n　　彭祖养生策划推广者，灵性企业家导师，身心灵幸福传播使者。\r\n　　她，不仅是销售高手，而且是高级园林工程师！\r\n　　她，27岁（1995年）不仅让百合花冬季开放，而且让西安的百合花销量一天3枝增长到上千枝！\r\n　　她，28岁（1996年）成为西安市的鲜花价格的标杆！\r\n　　她，29岁（1997年）成为拥有2000名员工的国有企业的正科级干部！管理投资2000多万的大型温室项目。\r\n　　她，为了追求更精彩的人生，2000年毅然离开舒适的国有企业开始创业！历经14年在园林界创业，大唐芙蓉园、南湖、汉城湖等西安著名文化景观项目留下她的身影！\r\n　　她，46岁，终于找到了自己人生最爱：传承彭祖养生文化，传播幸福智慧。成为演说家教练，成为由内而外富足训练师。 \r\n\r\n　　她的人生追求方向：做付出者，传播幸福智慧，用爱的力量，活在喜悦、富足、价值里，让每个人做最好的自己。','images/course/teacher/teacher4.jpg','images/course/teacher/4bb10fa80587aefdfd9977015c269388.jpg',1457602470),(6,7,'顾秋香','　　中国高级家庭教育指导师\r\n　　中国隔代家庭教育指导师\r\n　　《由内而外的富足》幸福训练师\r\n　　U+幸福课堂积极家庭教育创始人\r\n　　积极教育心理学辅导师\r\n　　婚姻家庭咨询师\r\n　　TA沟通分析治疗师\r\n　　美国正面管教学校讲师\r\n　　美国正面管教家长讲师\r\n　　催眠治疗师\r\n　　天赋潜能测试分析师\r\n　　中美教育研究协会特邀专家\r\n\r\n　　学习经历：\r\n　　师承德国系统排列老师伯图·乌沙莫、美国互动体验式教学专家Carla、瑞典资深心理学家Roland Jonsson、瑞典国际沟通分析师Annika Bj?rk、美国人类躯体运动治疗学家Valerie Baadh Garrett、美国正面管教高级导师Jane Nelsen、Cheryl Erwin、Jody McVittie、Lois Ingber、华德福教育专家Barbara Baldwin等；国内精英教育专家金子谦、积极心理学专家彭凯平、台湾全脑潜能开发科技专家陈明吉等，学习心理学/家庭教育界各流派，将中国和西方家庭教育进行本土化融合，进行长期的教育实践，开发出一套行之有效的家庭教育课程。','images/course/teacher/teacher5.jpg','images/course/teacher/b9083ed9eb6d8f83453fe649dae37650.jpg',1457602505),(7,8,'范小玲','　　《由内而外的富足》幸福训练师\r\n　　《超级演说家》教练身心灵成长导师青少年职业生涯规划师\r\n　　全国汽车后市场服务资源整合者\r\n　　2012年开始了自己的心灵成长历程，先后给几十家企业员工做心灵成长辅导，给上百位企业家做心灵成长训练，及中小学生心灵健康引导。\r\n\r\n　　曾经参加的课程：《有效沟通》、《赢在执行力》、《企业操盘手》、《绩效薪酬管理系统》、《超级演说家计划》、《九型人格与领导力》、《圣商大家族》、《由内而外的富足》、《富足之旅——遇见最美的自己》\r\n\r\n　　个人奋斗目标：终身追求最高境界个人身心成长！帮助更多的人坦诚接纳所有，帮助更多的人提高给予度。做一个善良、正直、有爱的传递者，传递光、传递爱！',NULL,'images/course/teacher/496f97885f3ff65bd28af28bfbbb6c57.jpg',1457594855),(8,2,'徐荃','　　徐荃曾是一名国家大型钢铁企业的能源管理者，源自于对生活的热爱和个人价值的体现，2008年毅然放弃了稳定的工作和舒适的环境，走进了自我成长和创业的道路！曾分别和两家知名品牌的直销公司合作过，具有十来年的营销和团队管理经验。现在师承言奇老师，是《由内而外的富足》传承训练师。\r\n\r\n曾是：\r\n   《N21国际商学院》高级训练师\r\n  　CP教练技术资深教练\r\n    江油读好书公益沙龙会创办人\r\n\r\n曾参加的课程有：\r\n  《N21国际商学院》持续5年的Acep的学习\r\n  《精英班的培训》\r\n  《TA领袖班的培训》\r\n  《创造之旅》\r\n\r\n个人奋斗目标：\r\n   终身追求个人成长！\r\n   热爱生活，热爱公益，并用爱去接纳所有遭遇的一切，做一个幸福使者，传递正能量！',NULL,'images/course/teacher/xuquan03.jpg',1457601201),(9,4,'郭梅婷','　　《由内而外的富足》传承训练师\r\n　　民族纳米高新技术企业钻石经理直销商\r\n　　泉州铭模坊模特大赛福建赛区优秀搭配师\r\n　　卓越国际彩妆造型高级美容师\r\n　　福建省爱和生命关怀公益协会    理事\r\n　　卡西龙商学院   内训师\r\n　　世界华人激励导师林金德E N S潜能培训师\r\n　　《华商书院商界领袖博学班》成长顾问\r\n　　安然商学院《情商管理与人际关系学》导师\r\n　　《领航商学院》演说家教练\r\n　　《富足之旅》导师\r\n\r\n　　人生追求的方向:和谐平衡人文环境，求真求善求美，并在真善美里修行！',NULL,'images/course/teacher/guomeiting01.jpg',1457602460),(10,3,'曾晓霜','　　《由内而外的富足》传承训练师\r\n　　北京泽西年代电影有限公司高级形象设计师\r\n　　香港爱星电影传媒有限公司艺术指导\r\n　　国家注册会计师\r\n　　高级理财规划师\r\n　　高级理财顾问 \r\n　　人力资源管理培训师、企业内训高级讲师\r\n　　《教练技术》一、二、三阶全程专职教练\r\n\r\n　　人生就是一个选择和不断学习的过程，迎接挑战方能迎来精彩的人生。\r\n　　曾参加的课程：《教练技术》《家庭幸福密码》《富足之旅》《由内而外的富足》《思八达运营智慧》《机制智慧》《魅力演说》等。\r\n\r\n　　人生座右铭：行到水穷处，坐看云起时！\r\n　　人生理想:用自己最真实的行动去感染身边的每一位朋友，让他们因为自己的存在而获得快乐、喜悦和富足的人生！',NULL,'images/course/teacher/zengxiaoshuang02.jpg',1457602420),(11,5,'普宁','　《由内而外的富足》传承训练师\r\n　《甜蜜的旅程》传承幸福导师\r\n　《赢在父母》幸福亲子关系 训练师\r\n　《幸福秘诀》训练师\r\n　　NLP国际执行师\r\n　　NGH催眠治疗师\r\n　　EFT情绪取向婚姻 治疗师\r\n　　EFT情绪聚焦治疗 治疗师\r\n　　家庭婚姻治疗师 国家二级\r\n　　青少年心理健康团体辅导员\r\n　　美国《亲密之旅》 实习培训师\r\n　　美国《今生无悔》 实习培训师\r\n　　浙江双枪竹木有限公司 董事\r\n\r\n　　她的人生追求方向：宁静、喜悦、富足、活在爱里，并在爱里修行。\r\n　　她拥有十年举办公益沙龙的经历，她始终坚信：分享是最好的学习，分享是最快的成长，分享者就是最大的收获者。',NULL,'images/course/teacher/AB5E775D8751439C4E84977241451A85.jpg',1457602581),(12,6,'言奇','　　——灵性派导师\r\n\r\n　　厚德载物，有容乃大！\r\n　　他，领航国际商学院联合创办人！\r\n　　他，领航国际慈善基金会创始人！\r\n　　他，拥有超过22年的企业经营管理经验，是中国最具实战经验的总裁讲师。\r\n　　他，立下大愿，帮助1万名大学生实现创业梦想，成为500家企业终身发展顾问。\r\n　　他，是美国箭牌服饰首席CEO、海博制衣有限公司董事长。\r\n　　他，通过了国家级企业管理师、NLP高级执行师认证。\r\n　　他，是灵性企业家导师，身心灵幸福传播使者。\r\n　　他，于2013年9月获得了世界级心灵导师、《心灵鸡汤》作者玛西?西莫夫老师《由内而外的富足》课程唯一中文版文的华人讲师。\r\n　　30年前，闽南流行一首歌叫“爱拼才会赢”，那时只要足够勤奋、足够的努力就能赢得财富、赢得市场！ 而今，面对瞬息万变的市场和现代商业文明的竞争，他把它更名为“拼爱才会赢”！他拼的是胸怀、拼的是格局、拼的是爱心、拼的是传承！\r\n\r\n　　他，从无到有，与三个儿时伙伴开始创业，20岁成了“老板”。历经风雨，经营企业十几载，30岁成了“老总”，并在服装行业成为了“T恤专家”。饱读诗书，视学习为一生的功课，40岁成了“老师”，在多所高校公益演讲，并写有著作《主动出击——做最好的大学生》（中国财富出版社出版）、《史上最伟大的幸福书——接纳》，还有即将出版的《由内而外的富足》心灵励志类书籍。',NULL,'images/course/teacher/yanqi01.jpg',1457602653);
/*!40000 ALTER TABLE `qm_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_tehui`
--

DROP TABLE IF EXISTS `qm_tehui`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_tehui` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `fname` varchar(255) NOT NULL COMMENT 'å‰¯æ ‡é¢˜',
  `oldval` int(10) unsigned NOT NULL,
  `newval` int(10) unsigned NOT NULL,
  `simg` varchar(255) NOT NULL,
  `bimg` varchar(255) NOT NULL,
  `detail` varchar(255) NOT NULL,
  `intro` text NOT NULL,
  `dj` int(10) unsigned NOT NULL COMMENT 'è®¢é‡‘',
  `hid` int(10) unsigned NOT NULL,
  `pid` int(10) unsigned NOT NULL,
  `tid` int(10) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  `val_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç‰¹æƒ è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_tehui`
--

LOCK TABLES `qm_tehui` WRITE;
/*!40000 ALTER TABLE `qm_tehui` DISABLE KEYS */;
INSERT INTO `qm_tehui` VALUES (130,'KANE至尊健康呵护卡','健康管理',21500,2980,'images/tehui/kane3.jpg','images/tehui/kane22.jpg','images/tehui_anli/kaneanli2.jpg','楷恩国际特推出至尊呵护卡，卡项包括：\r\n1、云平台健康大数据跟踪服务一年，价值6,000元；\r\n2、德国360°机体器官功能与衰老全景分析及评估，价值3980元；\r\n3、“人类基因组”推荐2项易感基因风险检测与分析，价值2560元；\r\n4、全身免疫系统风险深度检测与分析，价值880元；\r\n5、荷尔蒙六大项检测，价值280元；\r\n6、金牌设计师设计一次，价值1000元；\r\n7、生物科技无创除皱一次，价值6800元；\r\n8、国宾级私人管家式接待礼遇，两天一夜贴心食宿；\r\n9、往返交通的贴心安排。',1490,15,4,7,1466220652,NULL),(131,'易感基因检测','易感基因筛查(单项)',1280,1280,'images/tehui/jiyinjiance3.jpg','images/tehui/jiyinjiance001.png','images/tehui_anli/jiyinjiance000.png','基因检测是基因检测技术与预防医学、临床医学、健康管理学、营养学、健康心理学等有机结合形成的一种全新体检方法。具有更强的科学性、针对性和更远的前瞻性，为有效预防常见、多发、重大疾病提供个性化的健康管理方法和更全面、科学的健康指导服务。\r\n\r\n易感基因检测类型\r\n儿童：\r\n学习能力检测、运动能力检测，因材施教，让孩子赢在人生的起跑线。\r\n安全用药指导：\r\n退烧消炎药、止咳平喘药、胃肠不适药、抗高血压药、糖尿病药、激素及内分泌用药、降血脂药、心脏病用药、抗肿瘤药等，让您避免日常用药伤害，安全用药。\r\n大病风险预防：\r\n胰腺癌、肝癌、胃癌、前列腺癌、乳腺癌、卵巢癌、宫颈癌、子宫内膜癌、肺癌、甲状腺癌、大肠癌、糖尿病、冠心病、脑血栓等大病检测预防。\r\n健康养生指导：\r\n酒精耐受力、咖啡因兴奋度、尼古丁上瘾度等多项健康养身指导检测，让您对自己的身体状况更了解，合理饮食养身，健康百年。',640,15,4,7,1466220573,NULL),(132,'云平台健康大数据跟踪服务(一年)','云平台数据跟踪',6000,6000,'images/tehui/yunpingtai6221.jpg','images/act/yun2.jpg','images/tehui_anli/yunpingtai03.jpg','功能\r\n· 检测—长期监测并收集健康数据\r\n· 评估—综合所有健康数据进行评估\r\n· 干预—制定个性化方案指导干预\r\n· 跟踪—网络及移动电子设备跟踪提醒\r\n\r\n\r\n核心数据监测\r\n血压、总胆固醇、甘油三酯、血糖、体温、体质指数、体脂肪率、体重、心率、血氧、\r\n运动睡眠动态监测、尿比重、尿PH值、\r\n\r\n健康管理方案效果评估\r\n\r\n临床效果—临床数据提示正常\r\n功能效果—器官功能恢复正常\r\n主观意识—自我感观明显好转',3000,15,36,7,1466567005,NULL),(133,'德国360全身智能电子扫描检测','德国360细胞检测',3980,3680,'images/tehui/deguo36000001.jpg','images/tehui/deguo36004jpg.jpg','images/tehui_anli/deguo360001.jpg','德国360°全身智能电子扫描分析系统，让细胞“说话”\r\n\r\n利用低压直流电刺激感应技术\r\n中国健康管理机构最受欢迎的慢病检测分析系统；\r\n受到中华医学会健康管理分会；中华医学会体检协会；中华医学会亚健康管理分会高度评价。\r\n\r\n细胞级检测系统、欧洲最权威的全身健康检测系统、全球最安全的全身健康检测系统。\r\n医学界唯一可以对细胞间液的酸碱状态进行准确评测的医疗设备。\r\n\r\n中央领导、欧洲宇航员首选定期身体测试系统\r\n检测技术快速准确提供疾病风险预测\r\n对人体10大系统、96个体区的精准临床分析\r\n\r\n无侵入、无辐射、免禁食、免更衣、免等待',1990,15,4,7,1466220547,NULL),(134,'全身免疫系统风险深度检测与分析','免疫检测',880,880,'images/tehui/mianyijihuo0003.jpg','images/tehui/mianyijihuo0002.jpg','images/tehui_anli/mianyi0003.png','免疫功能下降是衰老最突出的特征；\r\n免疫功能失调可加速机体的衰老；\r\n全身免疫系统风险深度检测与分析，全面掌控您的免疫状况，提前预防，进行免疫细胞激活疗法。\r\n\r\n免疫细胞激活疗法十大功效：\r\n1、全面提升机体免疫力，御病抗癌；\r\n2、有效改善干燥粗糙暗黄肤质，面部及全身皮肤紧致光滑，细小皱纹消退，淡化面部色斑，延缓皮肤衰老；\r\n3、改善睡眠质量，治愈失眠多梦症，增强及恢复记忆力，治疗后一周，即可明显感觉疲惫感消退，精力增强；\r\n4、肌肉变得有力，全身筋骨变得柔软，血液循环通畅，腰漆酸软疼痛症状减轻，关节风湿痛明显减轻；\r\n5、改善男性性动力，促进性欲，延长性生活时间，提高性生活质量，改善尿频、尿不净、夜尿等尿道不适症；女性卵巢早衰患者经期可恢复正常，更年期症状明显改善；\r\n6、改善毛囊局部血液循环，改善干枯发质，减少脱发；\r\n7、加快新陈代谢，减肥塑形，有效降低体脂率，增加肌肉含量；\r\n8、增强食欲，改善腹胀、腹泻、便秘、肠道敏感等肠道紊乱异常现象；\r\n9、增强骨质密度，防止骨质疏松症，及因缺钙造成的肌肉痉挛症，预防老年骨折； \r\n10、促进器官细胞更新，过敏现象消失，机体各系统功能逐步恢复正常，机体各项指标恢复平衡状态，重获年轻态感受。',88,15,4,7,1466220422,NULL),(135,'荷尔蒙检测（六项）','荷尔蒙检测',280,280,'images/tehui/heermeng6221.jpg','images/tehui/heermeng00002.jpg','images/tehui_anli/heermeng02.jpg','　　楷恩提供性激素六项检查，即卵泡生成激素(FSH)、黄体生成激素(LH)、雌二醇 (E2)、孕酮(P)、睾酮(T)、催乳激素(PRL),对您的内分泌与生理功能进行一般性了解。针对您的荷尔蒙情况，进行荷尔蒙激活疗法，改善您的生理状况，延缓衰老。\r\n\r\n荷尔蒙激活平衡疗法的优势：\r\n\r\n·从自然植物提取物制造的生长因子，分子状态、组合结构和人体分泌的荷尔蒙一样\r\n·个性化治疗，个性化处方配置\r\n·研究证明补充天然荷尔蒙能改善健康和延长寿命\r\n·荷尔蒙激活平衡疗法能有效预防疾病\r\n·剂量灵活性，根据个人激素水平调整定制\r\n·经精准测试和评估，确定个性化处方配置\r\n·纯天然提取比合成荷尔蒙，更加安全、有效\r\n·减少或治愈潮汗、盗汗及失眠症状\r\n\r\n·改善身体肌肉组成，促进多余脂肪代谢\r\n·缓解焦虑症状，调节心情，治疗抑郁症\r\n·减少皱纹，改善脱发、皮肤干燥症状\r\n·增强精力和记忆力，提高综合免疫力\r\n·增加骨密度及骨量，降低骨质疏松风险\r\n·增强性功能，提高性欲\r\n·减少由激素引起的头痛、易怒、疲倦等经前综合症症状\r\n·调节月经经血量，舒缓经期疼痛症状',28,15,4,7,1466583695,NULL),(136,'万倍血液细胞风险筛查','血液筛查',1800,1800,'images/tehui/chaoxianwei6221.jpg','images/tehui/chaoxianwei6222.jpg','images/tehui_anli/xueshai0003.jpg','一万倍超显微血液筛查\r\n\r\n集光学、电学、电子学、影像学和多媒体技术于一体的全新亚健康检测方法。\r\n\r\n观察红细胞、白细胞、血小板、血脂  \r\n观察循环以及毒性物质\r\n\r\n可检测检查人体八大系统、四大组织的109种生理病变 ：\r\n只需指尖一滴血，通过万倍超显微镜对活血片和干血片的分析观察，无需经过特殊处理，即可获知人体健康状况的信息及潜在疾病如高血脂、高血粘度、动脉硬化、心脏病、大肠菌群失调、免疫力低下等，并对全身消化、呼吸、血液、内分泌等各大系统组织进行健康普查，以此结合临床对多种疾病作出诊断或提示。',900,15,4,7,1466589274,NULL),(137,'5D宇航员非线性亚健康检测','5D亚健康检测',2680,2680,'images/tehui/5D62211.jpg','images/tehui/5D0002.jpg','images/tehui_anli/5D0003.jpg','5D非线性亚健康检测原理：\r\n\r\n　　细胞是构成人体的基本单位，只要生命存在，细胞就会不停的进行振动。不同的器官其细胞的振动频率各不相同。人在生病前，最早发生变化的就是细胞。细胞的衰变会影响自身的振动频率。\r\n　　5D非线性亚健康检测仪由前苏联中央科学家与太空总署研发，用来监测无重力状态下航天员的健康情形。研发团队包含科学家、临床医生、统计学家、物理学家、资讯工程学家、计算机工程师及电机专家。耗费35年累积百万病例，建立庞大的临床数据库。早期作为航天员检查器官衰变的仪器，现在应用到临床，造福人类。能够直观地显示细胞的功能状态，提早发现当下的健康问题及其发展趋势。',1340,15,4,7,1466568519,NULL),(138,'活性细胞免疫细胞储存(十年)','生命银行',68000,68000,'images/tehui/xibaochucun0001.jpg','images/tehui/xibaochucun0002.jpg','images/tehui_anli/xibaochucun0003.jpg.png','KANE活性细胞银行\r\n\r\n中国规模最大的细胞银行之一\r\n－196℃ （深低温）液氮储存\r\n保活时间长达30年以上\r\n可随时提取供临床使用\r\n\r\nKANE活性细胞抗衰老疗法快、短时间内可以改善皮肤老化、肌肉无力症状，是最有效的免疫系统疾病疗法；治疗效果可维持10年以上。',34000,15,45,7,1466220694,NULL),(139,'以色列飞顿超冰半导体激光脱毛','冰点脱毛',18000,12000,'images/tehui/kaentuomao0001.jpg','images/tehui/kaentuomao0002.jpg','images/tehui_anli/kaentuomao0003.png','楷恩国际引进以色列飞顿超冰半导体激光脱毛仪\r\n半导体激光器与755nm波长创新结合，全球唯一。\r\n光斑大小15*10mm，10Hz\r\n脱毛安全、有效、舒适、快速\r\n全球最快速脱毛仪，无痛感\r\n\r\n楷恩国际冰点脱毛按部位与次数收费，12000元为一疗程价格，共6次，可用于脱唇毛、发际线、络腮胡、腋毛。',1200,15,33,5,1469159198,'全美特惠价为套餐6次唇毛发际线络腮胡腋毛四选一价格。'),(140,'以色列飞顿DPL精准嫩肤','DPL精准嫩肤',6800,6800,'images/tehui/kanedpl0001.jpg','images/tehui/kanedpl0002.jpg','images/tehui_anli/kanedpl0003.jpg','　　DPL精准嫩肤技术，可以激发出100nm波段的精选窄谱脉冲光，这个波段同时包含了黑色素及氧和血红蛋白的吸收峰值，这就使有效治疗能量得到精确的集中，可以快速、精准、高效的解决面部色斑和毛细血管扩张(红脸症)等多种皮肤问题，并且美白效果也不同凡响。由于DPL精准嫩肤技术之疗效显著超越光子嫩肤，且治疗周期明显缩短，被誉为划时代的光学美容嫩肤技术。',3400,15,39,6,1466220808,NULL),(141,'Naturalase飞顿大Q皮肤色素激光','激光祛斑',8800,8800,'images/tehui/daQ6221.jpg','images/tehui/daQ6222.jpg','images/tehui_anli/kanedaQ3.jpg','　　Naturalase飞顿大Q皮肤色素激光于2012年上市，是全球能量最高的皮肤色素激光，可治疗从表皮到真皮的各种色素性病变和祛除冷暖色纹身。 \r\n\r\n·能量高的皮肤色素激光：1000mJ\r\n·唯一一台拥有三种模式，纳秒级，微秒级，和点阵模式。\r\n·唯一拥有真实能量检测的皮肤色素激光，能量均匀\r\n\r\n·准确:光斑大而均匀，准确打击色素靶组织\r\n·安全:没有残留热量，创伤小，不易产生副反应\r\n·效果:高品质的光束确保最佳的治疗效果',4400,15,37,4,1466568816,NULL),(142,'热拉提无创紧肤除皱','射频提拉',19800,19800,'images/tehui/relati6221.jpg','images/tehui/relati6222.jpg','images/tehui_anli/kanerelati3.jpg','　　热拉提Thermo Lift是全球新一代无创紧肤除皱技术。它可以改善皱纹，唤醒皮肤弹性，深度提拉松弛的软组织结构，达到全脸紧致提升的年轻化效果。热拉提已通过美国FDA和中国CFDA认证的无创拉皮设备，FDA零不良反应记录，是安全性最高的紧肤手段，真正实现皮肤立体分层抗衰的紧肤技术。\r\n\r\n    热拉提将射频波外部频率进行调制，同时研发应用高频射频移相器，通过“波形压缩”及“相位移动”两个步骤，将射频波能量精准聚焦在皮下特定深度，成为市场上唯一做到“精准加热，分层抗衰”的射频紧肤技术。',9900,15,43,6,1466576526,NULL),(143,'菲蜜丽私密青春激光','私密整形',38000,38000,'images/tehui/kanefemilift1.jpg','images/tehui/kanefemilift2.jpg','images/tehui_anli/kanefemilift3.jpg','私密敏感——细胞新生，反应增强\r\n敏感度增强，使您更能感受到他带给您的快乐！\r\n作用原理：\r\nCO2激光的微脉管刺激作用，使血管舒张，血流量增加 ，细胞氧化和营养物质供应增加，细胞功能活跃，增强阴道血管对性刺激的完整、动态响应，进而使敏感度大幅提升。\r\n私密健康——综合改善，降低感染\r\n随着阴道组织的萎缩，女性容易被妇科感染所侵袭，容易出现白带异常，有的甚至逆行至子宫引起宫腔感染等，严重影响着女性的健康。\r\n菲蜜丽通过促进阴道内组织再生、重塑，使阴道PH、菌群正常化，进而降低妇科感染几率，还您健康清爽的感觉。\r\n 让您健康美丽，尽现女性魅力\r\n作用原理：\r\nCO2激光可改变组织特性，产生胶原增生、粘膜收紧、阴道润滑度及敏感度得到有效的提高； 健康的粘膜组织各项功能活跃，使PH值、菌群正常化，进而降低私密处感染几率。\r\n私密青春——全面抗衰，自信美丽\r\n雌激素能够使女性保持良好的血液循环系统的结构和功能。有和谐美好夫妻生活的女性，雌激素水平要高很多，菲蜜丽使您轻松拥有青春的阴道组织，让您的夫妻生活更加的和谐，进而促进您的雌激素及“快乐荷尔蒙”内啡肽的分泌，使您更加愉悦，更加富有青春活力。',19000,15,31,18,1466220782,NULL),(144,'Ulthera极线音波拉皮','超声刀',58000,58000,'images/tehui/chaoshengdao6221.jpg','images/chaoshengdao6222.jpg','images/tehui_anli/kanechaoshengdao3.jpg','　　Ulthera极线音波拉皮(超声刀)是以高强度聚焦式超音波作用于皮肤，并且有不同的探头，可分别作用到表皮、真皮层及以往只有手术拉皮才能达到的筋膜层，可由深到浅带动皮肤紧致提拉，一次治疗就可以达到明显的年轻化效果，随着胶原的不断增生重组，呈现整体年轻化状态。多探头作用不同层次 可媲美手术拉皮，治疗更安全可靠 效果更确切惊人。',29000,15,43,6,1466583254,NULL),(145,'韩式微创双眼皮打造魅力电眼成型自然','韩式微创',3800,2680,'images/tehui/hanshisandian681.jpg','images/tehui/hanshisandian682.jpg','images/tehui_anli/yan_jing/shuang_yan_pi/yezi_yanzhou360jingximeiyan03.jpg','韩式微创双眼皮优势\r\n\r\n成型自然:注重双眼皮成型设计，效果更自然，眼睛更大、更有神，更添自然美感.\r\n恢复迅速:对传统双眼皮切开术式改进，降低受创面积，愈合速度提升40%。\r\n美丽无痕:手术精细到0.1毫米，术后疤痕自然隐形，效果更加精致、细腻。\r\n效果完美:根据不同眼睛情况，结合五官整体美感，进行重睑方式的个性化设计，无痕、精细、自然、完美。',268,4,2,8,1469103278,'全美特惠价为限时活动价，活动结束后即恢复原价。眼部套餐价格更优惠。'),(146,'埋线双眼皮恢复快不留疤无需拆线职业女性的最佳选择','埋线重睑',1400,980,'images/tehui/shuangyanpi671.jpg','images/tehui/shuangyanpi672.jpg','images/tehui_anli/yan_jing/maixian683.jpg','适合人群：\r\n适用于眼睑皮肤薄、眼裂长、鼻梁高的求美者。\r\n\r\n手术过程：\r\n制定详细手术方案\r\n寻觅最佳位置1毫米切口\r\n完美比例去脂，精细缝合\r\n\r\n手术时间短，创伤小，恢复快，是职业女性的最佳选择！',98,4,1,8,1469158677,'全美特惠价为限时活动价，活动结束后即恢复原价。眼部套餐价格更优惠。'),(147,'切开双眼皮效果好皱襞深富有立体感稳定持久','切开双眼皮',2800,2240,'images/tehui/20160409170447305.jpg','images/tehui/qiekaifa682.jpg','images/tehui_anli/yan_jing/shuang_yan_pi/renai_shuangyanpi03.jpg','　　切开双眼皮在手术时，能调节和改变上睑各层次的组织结构，可以解决双眼皮存在的许多复杂问题，如上睑皮肤松弛、睫毛内翻、上睑臃肿、眶脂下垂、眶隔松弛、外上眶缘隆突等。\r\n　　切开法效果好，皱襞深，富有立体感；形成的双眼皮可靠、稳定，可以长久保持。',224,4,3,8,1469103199,'全美特惠价为限时活动价，活动结束后即恢复原价。眼部套餐价格更优惠哦。'),(148,'切开双眼皮加开内外眼角二选一','眼部套餐',5800,4500,'images/tehui/shuangyanpixiufu681.jpg','images/tehui/shuangyanpixiufu682.jpg','images/tehui_anli/yan_jing/shuangyanpixiufu683.jpg','　　眼部综合整形可根据眼部具体情况进行个性化设计，选择合适的眼部形态进行手术，一次性解决眼部脂肪过厚、上眼睑轻度下垂，眼裂过短等问题，为爱美者打造闪亮迷人的大眼。',450,4,3,8,1469158606,'全美特惠价为限时活动价，活动结束即恢复原价。'),(149,'韩式泪感去眼袋无痛快捷随治随走','眼袋内吸',3000,2400,'images/tehui/yandaineixi681.jpg','images/tehui/yandaineixi682.jpg','images/tehui_anli/yan_jing/yandaineixi683.jpg','　　利用激光快速、轻柔溶解下眼部脂肪，利用离子负压让已液化的脂肪如眼泪般自然流出，同时用微型组织定位器重新组织、定位收紧皮肤来实现去除眼袋的效果去眼袋后效果好，恢复快，对眼眶周围的血管和神经不会造成伤害，并发症少。',400,4,7,15,1469162483,'全美特惠价为限时活动价，活动结束后即恢复原价。'),(150,'外切法祛眼袋一次解决眼袋、皮肤松弛、眼周皱纹、黑眼圈四大问题','眼袋外切',3800,3000,'images/tehui/yandaiwaiqie681.jpg','images/tehui/waiqiequyandai682.jpg','images/tehui_anli/yan_jing/qu_yan_dai/waiqiequyandai683.jpg','　　超精细 无疼痛 无痕迹 恢复快 不复发\r\n\r\n　　快速——10分钟微创精细化手术，手术创伤更小，术后恢复更快。\r\n\r\n　　精细——微创1mm切口，即刻去除老态脂肪，恢复眼周年轻态。\r\n\r\n　　自然——严格参照美眼标准，分类而治，个性定制解决方案，术后效果自然。\r\n\r\n　　抗衰——特色青春抚平术，消除眼袋同时更能面部抗衰，轻松安全拥有年轻态。\r\n\r\n　　无痕——隐蔽位置1mm精细无痕，极速恢复，术后自然无痕。',300,4,8,15,1469162431,'全美特惠价为限时活动价，活动结束后即恢复原价。'),(151,'独特切口技术隐形无痕恢复快不回缩并发症少','无痕开眼角',3000,2400,'images/tehui/kaiyanjiao681.jpg','images/tehui/kaiyanjiao682.jpg','images/tehui/kaiyanjiao683.jpg','　　由于东方人的眼部结构特别，大部分人眼部都有内眦赘皮的情况，而内眦赘皮在客观上恰好限制了双眼皮和眼型的效果，内眦赘皮严重、两眼间距较宽，会让眼睛看起来比实际的小、圆、短，既不漂亮也没精神。全美无痕开内眼角手术通过打开眼睛前部的内眦赘皮，放大双眼，消除眼睛给人小、圆、短的印象，塑造自然完美的眼型。',240,4,5,9,1469103183,'全美特惠价为开内外眦单项价格'),(152,'采用韩国先进技术，隆高鼻梁，缩小鼻头，抬高鼻尖一体完成','国产硅胶隆鼻',2500,2000,'images/tehui/zonghelongbi6121.jpg','images/tehui/zonghelongbi6122.jpg','images/tehui_anli/bizi/jiatilongbi6123.jpg','　　手术采用韩国先进技术，隆高鼻梁，缩小鼻头，抬高鼻尖一体完成。在局部麻醉状态下，只需在鼻孔内做一个小切口，将预先消毒制作好的鼻模型垫在鼻骨骨膜与鼻部皮下之间，术后让您拥有极具中式的传统柔美，又充满个性的线条。',200,4,19,10,1469179232,'全美特惠价为限时活动价，活动结束即恢复原价。'),(153,'膨体材料填充更柔软更自然','膨体隆鼻',8800,7000,'images/longbi111.png','images/tehui/pengtilongbi6122.jpg','images/tehui_anli/bizi/pengtilongbi6123.jpg','　　膨体隆鼻整形手术能同时改变鼻梁和鼻头的状态，膨体材料与人体相容性最好，无毒、不致癌、不过敏，终身不需要改换。术后美观自然，特殊的微孔构造，机体组织细胞及血管可长入其中，构成组织衔接，跟自体组织一样完美，不挪动、不变形，与鼻体组织天衣无缝，更不可能穿出皮肤，无硅胶的“透明感”，重量轻，无下坠感。',700,4,15,10,1469159777,'全美特惠价使用的膨体为国产膨体。'),(154,'膨体材料填充更柔软更自然','进口膨体隆鼻',12800,11800,'images/tehui/renai_longbi01.jpg','images/tehui/zitiruangulongbi6122.jpg','images/tehui_anli/bizi/5.jpg','　　膨体隆鼻整形手术能同时改变鼻梁和鼻头的状态，膨体材料与人体相容性最好，无毒、不致癌、不过敏，终身不需要改换。术后美观自然，特殊的微孔构造，机体组织细胞及血管可长入其中，构成组织衔接，跟自体组织一样完美，不挪动、不变形，与鼻体组织天衣无缝，更不可能穿出皮肤，无硅胶的“透明感”，重量轻，无下坠感。',1180,4,15,10,1469159992,'全美特惠价使用的膨体为进口膨体。'),(155,'隐形提拉双层定位假体与乳房完美融合','国产假体丰胸',6800,4800,'images/tehui/huamei_longxiong01.jpg','images/tehui/1399859449790_up5z9d.jpg','images/tehui_anli/xiong/jiatifengxiong6123.jpg','　　★我们的品质与安全保障\r\n\r\n　　●材料安全保障：我们的丰胸材料均出自世界假体商，确保使用丰胸材料的安全性和合法性，终身负责。\r\n\r\n　　●环境安全保障：拥有洁净无菌手术室，的无菌环境和细胞培养的生物实验室，从根本上杜绝感染，保证了丰胸手术的安全。\r\n\r\n　　●技术安全保障：一对一人体工程学设计，内窥镜直视操作，精准精细，保障手术安全。\r\n\r\n　　●专家安全保障：丰胸专家亲诊，保障每一例手术完美。',480,4,28,20,1469174055,'全美特惠价为限时活动价，活动结束即恢复原价。'),(156,'形态手感真实效果好疼痛轻微恢复快','自体脂肪丰胸',11800,8280,'images/tehui/jiumei_femhxiong01.jpg','images/tehui/zitizhifangfengxiong6122.jpg','images/tehui_anli/xiong/zitizhifangdengxiong6123.jpg','　　自体脂肪丰胸优势：\r\n　　●手感真实：没有异物感，手感真实自然\r\n\r\n　　●疼痛底，恢复快：不需要组织的剥离，不影响胸大肌活动，术后疼痛度底\r\n\r\n　　●瘦身+丰胸一举两得：自体脂肪隆胸可以一起抽取多余脂肪，雕塑身形，一举两得\r\n\r\n　　●高存活 安全保障：采用分层注射技术，术后脂肪存活率较高。',828,4,29,20,1469175087,'全美特惠价为单次价，第二次享受原价5折优惠。'),(157,'针对大腿腹部顽固脂肪产后脂肪堆积问题让你轻松恢复身体曲线','腹部吸脂',6000,4000,'images/tehui/huamei_fengxiong01.jpg','images/tehui/xizhi7221.jpg','images/tehui_anli/lengdongrongzhi6123.jpg','　　针对身体脂肪堆积的部位，尤其是大腿和腰、腹部，利用负压真空吸引器，通过皮肤的小切口进入皮下，将局部堆积的脂肪组织吸出。手术快捷、靶向准确、创伤减少、回收有效、效果显著。爱美者再也不用担心肥胖问题了，吸脂让有效减肥变得更简单。',400,4,25,17,1469173471,'全美特惠价针对腹部和大腿，单部位普通吸脂1500元，韩式精雕2000元。'),(158,'吸取多余脂肪的同时重塑面部轮廓','面部脂肪填充',4800,3600,'images/tehui/1111zhifang111.jpg','images/tehui/20130724060128901.jpg','images/1111zhifang222.png','　　采用最新抽脂方法从大腿，腹部等脂肪堆积处抽取高活性脂肪，经绿色离 心技术分离、提纯，在实验室培养，提高脂肪的存活率，择取最优质的脂肪颗粒，分层注射移植到面部，达到面部塑形、抗衰除皱、美鼻塑造等一举多得的效果。',360,4,52,6,1469261956,'全美特惠价为单部位价格，多部位组合套餐价格更优惠。'),(159,'肉毒素除皱瘦脸无需开刀无需等待','衡力肉毒素',1680,1000,'images/tehui/shoulianzhen6121.jpg','images/tehui/shoulianzhen6132.jpg','images/shoulianzhen6123.jpg','1、无需开刀：肉毒素除皱手术注入的药物数小时就会被人体吸收，无需手术、无痛苦、见效快，安全可靠、简单有效。\r\n2、见效快：肉毒素除皱手术使用微量的生物制剂作面部多点皮下注射，短时间内精确消除面部密集细小皱纹，如前额、眉间、眼外眦部、颊部、口角、颈部等皱纹，使皮肤光泽有弹性。\r\n3、无需等待：肉毒素除皱手术是通过生物制剂对皱纹肌及其支配神经的麻痹作用达到治疗的目的，这种治疗不需要恢复期，只要几分钟即可直接回家或去办公室上班。无创伤，不需要休息，不影响工作；效果确切，立竿见影。',100,4,48,2,1469162358,'全美特惠价为最低价，实际价格视具体部位而定。'),(160,'美国进口正品肉毒素','Botox保妥适',2800,2000,'images/tehui/botox6131.jpg','images/tehui/botox6132.jpg','images/tehui_anli/lian/botox6133.jpg','　　美国保妥适（BOTOX）是目前国内唯一获SFDA批准的用于改善皱纹的进口肉毒SU类产品。由世界500强企业-美国艾尔建（Allergan)公司(当今世界最大的整形材料制造商)生产的高纯度BOTOX制剂，获得美国FDA认证。',200,4,48,2,1469161865,'全美特惠价为最低价，具体收费视具体部位而定。'),(161,'腋毛唇毛享受特惠体验价单次98元','冰点脱毛',300,98,'images/tehui/caigaungtuomao6401.jpg','images/tehui/caigaungtuomao6402.jpg','images/tehui_anli/caiguangtuomao6133.jpg','　　彩光脱毛是一种非剥脱、非侵入性的光子美容技术。运用特定波长的彩光穿过表皮，直接作用于毛囊，毛囊、毛干的黑色素选择性地吸收光能，由此产生的热效应使毛囊凝固坏死，毛发便不再生长，已破坏的毛囊经过一段自然生理过程之后被去除。',10,4,33,5,1469096788,'全美特惠价为单次体验价，腋毛唇毛优惠价1000元6次'),(162,'大小腿，上下臂大面积清凉无痛脱去多余毛发，有效保护周围皮肤','冰点脱毛',2400,1500,'images/tehui/bingdiantuomao6401.jpg','images/tehui/bingdiantuomao6402.jpg','images/tehui_anli/bingdiantuomao6133.jpg','全方位专业冰点脱毛解决方案 十分钟祛除毛发\r\n永不再生\\无痛苦\\不留疤痕\r\n\r\n原理：高科技冷光脱毛对皮肤实行冷麻醉，利用毛囊中的黑色素细胞对特定波段光的吸收，产生光热解反应，破坏毛囊中的毛乳头部 分，不损伤皮肤汗腺，从而达到永久性脱毛效果。同时收缩毛孔，美白皮肤。\r\n\r\n应用于：修眉毛，脱上、下唇毛、脱全脸毛、脱手毛、脱腋毛、脱大小臂毛、脱大小腿毛、比基尼部位、脱络腮胡须、脱发际线、脱胸毛和其他部位多余毛发。',150,4,33,5,1469096976,'全美特惠价为一疗程6次的价格，原价单次400元'),(163,'生物刺激作用和光热解原理祛痘祛斑祛红血丝紧致肌肤','光子嫩肤',9800,6800,'images/tehui/guangzinenfu6061.jpg','images/tehui/guangzinenfu6132.jpg','images/tehui_anli/guangzinenfu6133.jpg','　　光子嫩肤的生物刺激作用和光热解原理，生物刺激作用是强脉冲光作用在皮肤上产生的光化学反应，主要有让真皮层的胶原、弹力纤维的内部分子结构发生化学变化，恢复弹性。另外，强脉冲光产生的光热作用，能够增强血管功能，改善循环，缩小毛孔，消除浅表皱纹。',680,4,39,6,1466218978,NULL),(164,'点对点超微渗透技术打开微细管道直接将皮肤营养剂导入深层细胞','微针美塑',2800,800,'images/tehui/weizhenmeisu6131.jpg','images/tehui/weizhenmeisu6062.jpg','images/tehui_anli/weizhenmeisu6133.jpg','　　微针美容利用微针滚轮上许多微小的针头，刺激皮肤，采用“点对点”超微渗透技术，在很短时间内微针可以做出超过200，000个微细管道，定位、定层、定量地将包含细胞生长因子、排毒因子和超浓缩营养成分的“皮肤营养剂”直接导入到深层皮肤细胞。',80,4,38,4,1469189431,'全美特惠价为单次价，套餐价格更多优惠。'),(165,'穿透力强创伤性小覆盖均匀神奇治疗无伤害','点痣',50,2,'images/tehui/1111dianzhi1111.jpg','images/tehui/1111dianzhi2222.jpg','images/tehui_anli/ABUIABAEGAAgkaP7qQUowNXOPzDSAzj5AQ.png','　　激光除痣可控制最佳光点的大小及深度，不易留疤、不易感染。适用于大部分类型，包括深浅痣。通过激光祛痣治疗一次或多次可使色素消失或减轻。激光祛痣治疗在浅表进行，一般不出现疤痕。',1,4,38,4,1469587318,'全美特惠价为单颗限时活动价，活动结束即恢复原价。'),(166,'基础补水保湿紧致肌肤','水光针',1800,680,'images/tehui/shuigaungzhen671.jpg','images/tehui/shuigaungzhen672.jpg','images/tehui_anli/shuigaungzhen6133.jpg','　　韩国原装进口水立方水光注射仪采用声控负压技术，准确无误的在真皮层1.28mm深度下补充进肌肤所需营养物，在微针进入前利用声压机将皮肤稍微地提起，使得皮肤维持紧实后针头进入到准确的深度用多针来注入营养物（如玻尿酸、维生素C等）。',68,4,46,3,1469159233,'全美特惠价为限时活动价，活动结束后即恢复原价。'),(167,'水分储存库的天然保湿剂','伊婉玻尿酸',3800,1600,'images/tehui/boniaosuan671.jpg','images/tehui/boniaosuan672.jpg','images/tehui_anli/yiwan6133.jpg','塑性填充作用\r\n使用BDDE交联的高分子量透明质酸（玻尿酸），为塑型提供更好保障，更持久效果。\r\n\r\n高粘度和稳定性\r\n高浓度的游离透明质酸（玻尿酸），环绕在凝胶颗粒周围，提供更高的粘弹性和稳定性，塑型效果更加自然。\r\n\r\n品质保障\r\nYVOIRE伊婉原料获得了美国FDA和欧洲EDQM认证。\r\n\r\n安全性\r\n微生物发酵，非动物来源，避免动物性病毒感染及禽类抗原性过敏。\r\n\r\n使用方便\r\n注射器获得韩国设计大奖，符合人体工程学，使用更方便、舒适。',160,4,47,1,1466218827,NULL),(168,'瑞典进口，信赖优选，提升轮廓，亲和肌肤','瑞蓝2号玻尿酸',3800,1200,'images/tehui/20160421094124815.jpg','images/tehui/ruilan6132.jpg','images/tehui_anli/ruilan6133.jpg','瑞蓝独有的NASHA盈韧填充技术保留了透明质酸的天然结构，NASHA盈韧填充技术的修饰程度低，与人体透明质酸高度相似，亲和肌肤，可在体内自然吸收降解。\r\n提升轮廓，亲和肌肤：\r\n1.特有NASHA盈韧填充技术，有效提升轮廓，抚平皱纹。\r\n2.与人体透明质酸高度相似，可在体内自然吸收降解。\r\n瑞典进口，信赖优选：\r\n1.来自瑞典的专业医学美容品牌，谨遵严格质量标准。\r\n2.全球20年研发和生产经验，超过千万成功注射案例。\r\n3.首个获得中国CFDA批准的注射用修饰透明质酸凝胶。',200,4,47,1,1469339746,'全美特惠价为限时活动价，活动结束即恢复原价。'),(169,'触感柔软，与皮肤组织更易融合，疼痛感低','乔雅登玻尿酸',6800,2000,'images/tehui/jiuemi_bizonghe01.jpg','images/tehui/qiaoyadeng6132.jpg','images/tehui_anli/qiaoyadeng6133.jpg','　　Juvederm乔雅登玻尿酸的交联处理(cross-linking)采用了Hylacross专利技术，增强了玻尿酸凝胶的高度延展性，让玻尿酸具有流动特质，呈现出均匀柔软的凝胶状态。注射juvederm玻尿酸更加好推，疼痛感较低，Juvederm注射进皮肤后触感比较柔软，与皮肤组织更容易融合。',200,4,47,1,1466218683,NULL),(170,'BV5塑形玻尿酸专用注射技术打造专属你的美丽','润百颜玻尿酸',4800,1000,'images/tehui/quyandai111.png','images/tehui/runbaiyan6132.jpg','images/tehui_anli/runbaiyan6133.jpg','　　润百颜BV5是特别为润百颜塑形玻尿酸开发的专用注射技术。对面部5个因衰老而造成软组织流失的部位填充润百颜塑形玻尿酸，提供强有力的组织支撑力，丰盈提拉，有效改善软组织丰盈度，提升轮廓流畅度，实现全面部轮廓美化。 润百颜 BV5基于润百颜产品特性而研发设计，配合使用特定的润百颜塑形产品在指定位置，精准用量，才能达至理想的面部轮廓优化效果，打造专属你的美丽。',100,4,47,1,1466218654,NULL),(171,'复合透明质酸，美丽保质期更长','EME逸美玻尿酸',3800,1000,'images/tehui/huamei_nafu1.jpg','images/tehui/yimei6132.jpg','images/tehui_anli/yimei6143.jpg','专利交联技术，形态自然持久\r\n逸美采用专利交联技术，形成均匀的溶液状透明质酸，注射后即刻效果自然。逸美产品不含非交联透明质酸成分，有效成分含量更高。术后吸水反应轻微，吸水后形态稳固，不易变形，远期形态维持效果更好。\r\n \r\n可完全降解，美丽无后顾之忧\r\n逸美注入人体后，透明质酸通过自身酶和自由基作用会逐渐分解成为二氧化碳和水，羟丙基甲基纤维素通过吸收自由基逐渐氧化分解，免除您的后顾之忧。逸美产品也可通过注射玻璃酸酶快速酶解复原，注射后即刻起效，逐渐恢复原来面貌。\r\n \r\n多型号产品，面部综合解决方案\r\n逸美拥有全系列多型号复合透明质酸产品，针对面部不同部位的需求设计，不同型号产品可以提供面部美丽的综合解决方案，塑形、填充、补水一步到位。',100,4,47,1,1466218634,NULL),(172,'塑性提升去痕除皱，一品四效','海薇玻尿酸',3500,1000,'images/tehui/haiwei61411.jpg','images/tehui/haiwei61422.jpg','images/tehui_anli/haiwei6143.jpg','产品名称：注射用交联透明质酸钠凝胶\r\n产品规格：0.5ml/支，0.75ml/支,1.0ml/支,1.25ml/支，\r\n产品价格：3000元/支（0.5ml）\r\n海薇是中国唯一完全交联的透明质酸钠真皮填充剂，具有塑性、提升、去痕、除皱的功能，一品四效，在面部年轻化中发挥重要作用。',100,4,47,1,1466218544,NULL),(173,'纯植物萃取长效安全自然','宝尼达玻尿酸',3800,1000,'images/tehui/baonida6141.jpg','images/tehui/baonida6142.jpg','images/tehui_anli/baonida6143.jpg','　　生物可降解新材料北京市工程实验室联合EME Lab (Canadian) Inc和天津南开大学针对这个课题开展了大量的研究以及试验，前后历经7年时间，由中、美、法、日四个国家博士后组成的研发团队，成功开发并推出了宝尼达产品。\r\n　　宝尼达于2012年10月获得国家药监局（SFDA）的批准，用于皮肤真皮深层及皮下浅层之间的注射填充。\r\n　　宝尼达不仅起到填充作用，还有保持皮肤弹性的功能，并能锁住大量水分子，使肌肤饱满年轻有弹性。宝尼达的有效成分会刺激皮肤自身产生新的胶原，起到对皱纹和凹陷长期填充的作用。',100,4,47,1,1466218520,NULL),(174,'深层脱色，彻底美白，一次照射，长期有效','冷光美白',1800,1200,'images/tehui/lgmb_16.jpg','images/lengguangmeibai6142.jpg','images/lengguangmeibai6143.jpg','适用于多数未知诱因，引发的齿面黑黄色变\r\n外源性色素粘染（烟渍、咖啡、可乐等）\r\n内源性色素沉着（四环素牙等）\r\n先天性色泽不均等',120,4,44,21,1466218263,NULL),(175,'杀菌消毒防牙病修善病牙消除口气','超声波洁牙',1200,1000,'images/tehui/xinzhimei_3Dmeirongguan01.jpg','images/tehui/csbjy6142.jpg','images/csbjy6143.jpg','　　超声波洁牙，利用超声波产生的高频、高能振动通过光滑的超声波洁治机工作头把牙齿表面的牙结石、牙渍击碎，然后通过洁治机产生的水雾把碎石、菌斑冲刷下来，还您一口清洁、光滑、清新洁白的牙齿。',100,4,44,21,1466218248,NULL),(176,'快捷无痛不磨牙不麻醉20分钟取牙模3D设计生产1小时轻松安装','牙齿贴面',3000,2000,'images/tehui/yatiemian6141.jpg','images/tehui/yatiemian6142.jpg','images/yatiemian6143.jpg','首次就诊\r\n1）检查诊断\r\n详细的口腔检查，选择合适的适应症，患者、医生、技师之间交流沟通，制定合适的治疗计划。\r\n2）基础治疗：补该补的牙，专业化的牙齿清洁,消除牙龈炎症。\r\n3）患牙牙体预备\r\n根据患者牙齿具体情况预备适应的牙体\r\n4）印模、模型、比色\r\n用硅橡胶或弹性印模材料取印模，用耐高温代型材料直接灌制工作模型，或者用超硬石膏灌制工作模型，再用工作模型复制耐高温代型。比色时要考虑病人牙齿着色的深浅，修复后的色泽与余留真牙的色泽不能相差太大，否则会影响美观。\r\n5）暂时修复体\r\n制作并试戴，粘接剂粘接，调整和磨改修整。',200,4,44,21,1466218207,NULL),(177,'适用牙体折断缺损缺失畸形牙牙列不齐牙冠变色死髓牙四环素牙等','烤瓷牙',8000,6000,'images/tehui/c299595d922c252361a28a9d1acd6ee3.jpg','images/tehui/kcy6142.jpg','images/tehui/kcy6143.jpg','　　医生根据患者牙体缺损病因、缺损大小、缺损牙的位置、咬合情况、口内余牙情况，饮食习惯以及患者的要求等制定周密的修复治疗计划、选择合适的修复体类型，为修复体的制作提供修复空间。牙体预备完成后，医生选取合适的印模材料制作印模并灌制石膏模型，对修复体进行比色，制作修复体，最后进行临床试戴、粘接。',600,4,54,21,1466218232,NULL),(178,'高效快速安全无痛用时只需一个小时，七天给你自信笑容','美容冠',9800,8800,'images/tehui/mrg6151.jpg','images/tehui/mrg6152.jpg','images/tehui_anli/mrg6153.jpg','　　容冠在保障牙齿功能的同时，更强调牙齿的美容效果。运用数码定位系统，德国VITA比色技术，牙齿排列更整齐，色泽更自然、真实。美容冠完全符合口腔医学和人体工程学，安全无副作用，终身有保障，不会出现牙龈红肿、牙龈发黑等现象。',880,4,54,21,1466218220,NULL),(179,'稳定安全完全保留健康牙齿使用寿命长','种植牙',8800,8000,'images/tehui/zzy6151.jpg','images/tehui/zzy6152.jpg','images/tehui_anli/zzy6153.jpg','种植牙的过程\r\n1、口腔检查。做种植牙手术牙周病的治疗确不能保留的牙齿予以拔除，并且医生会将相邻病灶牙根管治疗。\r\n2、制作种植牙手术导板。根据病人骨骼条件设计种植方案，根据种植体位置，设计确定种植窝的模拟圆柱等10几种方案。\r\n3、备制种植窝。按预先设计制作模板，根据牙槽骨的骨量选择适宜长度的种植体及相应的系列钻。\r\n4、备制螺纹。用慢速钻，用大量生理盐水冲洗降温，用丝锥制备种植窝骨壁上的螺纹。\r\n5、植入种植体。将种植体缓缓植入已备好的种植窝内并小心地用特制工具加力旋紧，使种植体顶缘与骨面相平。\r\n6、缝合创口。以便创口能尽快的愈合，让种植体与牙槽骨能跟好的融合。\r\n7、带上牙冠。种植钉与牙槽骨紧密愈合后，安装烤瓷牙冠后就完成了整个种植牙手术的全过程。',800,4,22,21,1466218182,NULL),(180,'国产染料效果自然经验丰富的美容师专业塑美','韩式定妆眉',1600,680,'images/tehui/11123468ihgftg.jpg','images/tehui/1121133454567h.jpg','images/tehui_anli/111wenmei111.jpg','　　韩式定妆眉，又被称为雾状眉、半永久眉毛，后期效果非常自然，像眉粉扫过的一样淡淡的自然的感觉。韩式定妆眉效果可以保持1－2年，会随着人体新陈代谢慢慢退去还原成您原来的眉毛，到时又可以根据当下流行的眉型来为自己做眉毛了！',68,4,6,16,1469258780,'全美特惠价为限时活动价，活动结束即恢复原价。'),(181,'专家亲诊手术安全创伤小恢复快','进口假体丰胸',16800,11800,'images/tehui/rrzx6151.jpg','images/tehui/1130516p95547.jpg','images/140912154604361.jpg','　　从乳房美学和解剖学角度出发，根据身高、胸廓宽度、乳腺体等基础，综合个人气质，依据完美胸部标准，进行个性化手术方案定制。系统的对乳房的高度、坡度、峰距、乳沟等形态进行综合设计，选择不同材质和尺寸的丰胸假体，使效果更为真实自然，胸部达到比例协调、挺翘圆润、柔美性感、浑然天成的完美视觉及手感真实的触觉效果。术后双乳自然亲近，形成完美的水滴形态，和迷人深V诱惑，尽显性感妩媚。',1180,4,28,20,1469174829,'全美特惠价为限时活动价，活动结束即恢复原价。'),(182,'全方位定制设计，完美精细雕琢','国产膨体隆下巴',6800,5400,'images/tehui/111xiaba6666.jpg','images/tehui/11111xiaba7777.jpg','images/tehui/1111xiaba00000.jpg','　　根据面部美学比例，术前进行数字化精确设计，使下巴形态与脸型完美匹配，确保效果自然真实、线条流畅优雅。',540,4,42,11,1469243286,'全美特惠价为限时活动价，活动结束即恢复原价。'),(183,'腔内隐形微创切口，魅力不留痕迹','进口硅胶隆下巴',4500,3600,'images/tehui/1111xiaba111.jpg','images/tehui/185538799_23.jpg','images/tehui/1111xiaba00000.jpg','　　采用隐蔽内切口，根据患者的颏部外形对消毒好的硅胶假体进一步雕刻加工。消毒麻醉后，在齿龈沟处作1～2cm切口，在骨膜下向下分离，形成与假体相适应的腔穴，止血后，将假体植入，调整假体的位置和外形，待患者满意后，将硅胶假体固定，分层缝合。',360,4,42,11,1469243349,'全美特惠价为限时活动价，活动结束即恢复原价。'),(184,'娇俏尖下巴，凸显笑脸魅力','国产硅胶隆下巴',2500,2000,'images/tehui/111111xiaba222222.jpg','images/tehui/111111xiaba444.jpg','images/tehui/1111xiaba00000.jpg','　　采用隐蔽内切口，根据患者的颏部外形对消毒好的硅胶假体进一步雕刻加工。消毒麻醉后，在齿龈沟处作1～2cm切口，在骨膜下向下分离，形成与假体相适应的腔穴，止血后，将假体植入，调整假体的位置和外形，待患者满意后，将硅胶假体固定，分层缝合。',200,4,42,11,1469257909,'全美特惠价为限时活动价，活动结束即恢复原价。'),(185,'创伤更小，手法更精细，恢复更快','韩式切眉',3800,3000,'images/tehui/1111mei1111.jpg','images/tehui/1111mei3333.png','images/11111qiemei1111.jpg','　淑女、朋克、还是文艺？无论你想要怎样的气质，一对精致的眉毛绝对能为你增色不少。切眉术帮你打造属于你的气质眉。\r\n  　通过手术适当切除过剩的皮肤，也可矫治轻度上睑下垂、眼角外形不佳、轻度额纹，一举多得。',300,4,34,5,1469258034,'全美特惠价为限时活动价，活动结束即恢复原价。'),(186,'简便、安全、无痛苦、无疤痕，彻底去除坏眉','切眉',2800,2100,'images/tehui/001140123093402430.jpg','images/tehui/1111mei2222.png','images/11111qiemei1111.jpg','　　通过抬高眉的位置，上提上睑松弛皮肤，使双眼皮外形更为美观，改善眼周皱纹。\r\n　　在眉部切口分离额部皱纹，切除部分额肌，可明显减少额部皱纹。',210,4,34,5,1469258116,'全美特惠价为限时活动价，活动结束即恢复原价。'),(187,'改善五官比例与对称性，效果立竿见影','进口硅胶隆鼻',3500,2800,'images/tehui/bysx6151.jpg','images/tehui/bysx6152.jpg','images/tehui_anli/bysx6153.jpg','　　根据面部整体化全方位设计鼻部缺陷问题，只做适合爱美者的美鼻，为求美者量身定制的明星级个性化美鼻方案。从鼻根到鼻尖整体考量，对鼻子大小、高度、宽度，以及鼻背角、鼻唇角、鼻尖角等进行精确设定，精雕细琢，设计出最适合求美者的个性化、立体化鼻形。',280,4,19,10,1469179421,'全美特惠价为限时活动价，活动结束即恢复原价。'),(188,'做一次真正顶画千次，让您摆脱了每天脱妆卸妆的麻烦','美瞳线',1800,880,'images/tehui/bzz6161.jpg','images/tehui/bzz6162.jpg','images/111meitongxian.jpg','　　韩式定妆眼线，很多人称之为美瞳线，若有若无、淡淡的、自然的感觉，放大您的眼睛，提升眼部层次感，让您更显魅力无限。韩式定妆眼线可以保持3－5年，线条精致流畅。做一次真正顶画千次，让您摆脱了每天脱妆卸妆的麻烦！',88,4,9,16,1469258215,'全美特惠价为限时活动价，活动结束即恢复原价。'),(189,'国产染料唇色自然自然美唇效果','韩式定妆唇',2000,1000,'images/tehui/fc6161.jpg','images/tehui/x7yjiygn.jpg','images/tehui_anli/011wenchun.jpg','　　韩式定妆唇，唇色非常自然，改变乌唇、白唇，有效减少早晨的化妆时间。自然的美唇效果，更显年轻风采。清晨起床也可保持简单化妆的自然感觉，摆脱口红的烦恼。韩式定妆唇让您的双唇时刻保持粉润温柔。彰显魅力无限！',100,4,58,13,1469261332,'全美特惠价为限时活动价，活动结束即恢复原价。'),(190,'安全无痛，精细准确，严格保密','处女膜修补',3800,2600,'images/tehui/simi63031.jpg','images/tehui/simi63032.jpg','images/tehui/simi63033.jpg','　　韩式微创处女膜修复术采用国际最新技术的手术材料--韩国进口的纳米自吸收缝合线，手术后无需拆线，手术成功率高达95%以上。技术完全摈弃了传统的处女膜修补术采用人造处女膜的做法，而是利用受术者自有的残存处女膜进行修补，使其恢复到破裂前的状态，修复后的处女膜与破裂前几乎一样，其效果非常逼真。',260,4,32,18,1469158650,'全美特惠价为限时活动价，活动结束即恢复原价。'),(191,'手术方法安全，时间短，创伤小','阴道紧缩',12000,8000,'images/tehui/simi63021.jpg','images/tehui/simi63022.jpg','images/tehui/simi63023.jpg','　　手术根据患者的不同年龄、阴道松弛及会阴损伤的不同程度进行和使用私处细胞活力因子进行修补，通过手术修复损伤和松弛的肌肉和筋膜，使阴道弹性增强，松紧度变得合适，解除了患者心理上和生理上的痛苦，并提高了生活质量，恢复了女性的自信心。同时有利于预防和治疗因盆底组织松弛而导致的子宫脱垂及阴道前后壁膨出等疾患。',800,4,31,18,1467275301,NULL),(192,'韩式处女膜修复，采用韩国进口纳米自吸收缝合线，术后无需拆线','女性私密',5800,4000,'images/tehui/simi63011.jpg','images/tehui/simi63012.jpg','images/tehui/simi63013.jpg','　　韩式微创处女膜修复术采用国际最新技术的手术材料——韩国进口的纳米自吸收缝合线，手术后无需拆线，利用受术者自有的残存处女膜进行修补，使其恢复到破裂前的状态，修复后的处女膜与破裂前几乎一样，效果逼真且技术安全性高，无后遗症，手术过程完全无痛，手术只需30分钟，保证受术者的个人隐私，为众多女性找到了真爱。',400,4,30,18,1469189335,'全美特惠价为限时活动价，活动结束即恢复原价。'),(193,'直视操作，层次清晰，快速平整疤痕','疤痕切除',800,500,'images/tehui/bahenqiechu6231.jpg','images/tehui/bahenqiechu6272.jpg','images/tehui/bahenqiechu6273.jpg','　　了解患者想达到的预期效果，并仔细分析疤痕的大小、位置、形状、病因，结合患者体质，选择最佳的切除方案。疤痕切除手术，对于疤痕大小适度、位置和形状都适合疤痕切除方案的患者，即可一次性完全切除，而对于面积较大的疤痕，则可分次切除，术后使原来明显的疤痕变为一条不再引人注目的细小的线条。',50,4,37,4,1469185706,'全美特惠价为最低价，具体收费视疤痕面积和深度而定。'),(194,'弥补缺陷，缔造美丽','唇腭裂修复',8000,5000,'images/tehui/chunlie6281.jpg','images/tehui/chunlie6282.jpg','images/tehui/chunlie6283.jpg','先确定7个解剖基本点针对性地进行修复\r\n精细切分再将皮肤、肌肉、粘膜各层分离\r\n粘膜缝合后再交叉缝合肌层',500,4,58,13,1467279144,NULL),(195,'精细完美、自然和谐、长期持久','进口膨体隆下巴',16800,12800,'images/tehui/20160421140452380.jpg','images/tehui/111xiaba8888.jpg','images/tehui/1111xiaba00000.jpg','　　根据面部美学比例，术前进行数字化精确设计，使下巴形态与脸型完美匹配，确保效果自然真实、线条流畅优雅。',1280,4,42,11,1469243185,'全美特惠价为限时活动价，活动结束即恢复原价。'),(196,'唇部整形，完美面部形态，焕然新生','厚唇改薄',2000,1600,'images/tehui/houchungaibao6281.jpg','images/tehui/houchungaibao6282.jpg','images/tehui/houchungaibao6283.jpg','　　对患者的实际情况先进行术前精细设计，根据需切除红唇组织的宽度设计切口，再按照设计线切开黏膜，楔形加深切口适量切除口轮匝肌，并按照患者的五官比例设计出唇部的自然形态。厚唇变薄术后自然协调，美观大方。',160,4,58,13,1469185398,'全美特惠价为最低价，具体收费视手术方法和难易程度而定。'),(197,'方便快捷无伤口，做完就走，优点多多','激光除腋臭',1800,1400,'images/tehui/20130614020618371.jpg','images/tehui/1111yechou2.jpg','images/tehui/1111yechou4444.png','激光照射到腋窝时，会使大汗腺、毛囊及其附属组织碳化坏死，最后丧失其分泌汗液的机能，从而达到治疗腋臭的目的，激光去除腋臭的具体操作步骤为：\r\n① 受术者平卧，术区消毒并脱毛，涂冷凝膏。\r\n② 根据需要可涂抹表面麻醉膏，也可不涂。\r\n③ 用激光对准腋窝部并进行照射。',140,4,33,5,1469263054,'全美特惠价为单次价，套餐价格更多优惠。'),(198,'取出多余脂肪打造明星小V脸','面部吸脂',2000,1500,'images/tehui/967987_gic5896498.jpg','images/jiuwo6292.jpg','images/tehui/111313160202093ZcU.png','　　经口腔手术，面颊不留任何的痕迹。一般选择腮腺导管开口下约1厘米，于第1、第2磨牙相对的黏膜做一长1～2．5厘米的切口。暴露颊部，用血管钳朝向耳根作钝性分离，此时颊脂肪垫易于突向切口处，打开包膜，用手指在口腔外的颧弓下压迫，颊脂肪自动经切口脱出。',150,4,56,11,1469177862,'全美特惠价为单部位价格，多部位组合套餐价格更优惠。'),(199,'私人订制，让你重回年轻，改善面部细小皱纹','注射除皱',1680,1000,'images/tehui/111240404140222122K165.jpg','images/tehui/111156551afa2cb61.jpg','images/tehui/1115468751835618367.jpg','　　利用美丽容颜手术的方法，将面部和面颈部的皮肩拉紧移位，并去除多余皮肤，从而使皱纹展平、隐蔽；手术切口面部不留瘢痕，术后容貌焕然一新。',100,4,41,6,1469177316,'全美特惠价为单部位最低价，具体收费视部位大小而定。'),(200,'鼻子下巴硅胶假体取出，让你找回属于你的美丽','取假体',1800,1000,'images/tehui/qujiati6281.jpg','images/tehui/qujiati6282.jpg','images/tehui/qujiati6283.jpg','　　术前进行常规鼻部检查，清洁鼻部，手术局麻，从鼻孔内缘做切口，做出通往假体处的通道，取出假体，再注射生理盐水于原置假体腔隙进行清洗，之后缝合切口，根据患者情况意愿可重新设计并植入新的假体材料进行隆鼻。',100,4,19,10,1469176042,'全美特惠价为最低价，具体收费视难易程度而定。'),(201,'鼻部膨体取出安全保障术后全程护理','取假体',2800,2000,'images/tehui/tuofengbi6281.jpg','images/tehui/tuofengbi6282.jpg','images/tehui/qujiati6283.jpg','　　术前进行常规鼻部检查，清洁鼻部，手术局麻，从鼻孔内缘做切口，做出通往假体处的通道，取出假体，再注射生理盐水于原置假体腔隙进行清洗，之后缝合切口，根据患者情况意愿可重新设计并植入新的假体材料进行隆鼻。',200,4,19,10,1469176534,'全美特惠价为限时活动价，活动结束即恢复原价。'),(202,'损伤小，出血少，无痛苦，无需住院，术后疤痕小，不影响美观','腋臭手术',2800,2200,'images/tehui/11111yechou.png','images/tehui/111137151216110101311.jpg','images/tehui/111yechou3333.png','准确定位：能够准确定位每一个大汗腺，并彻底清除;同时具有无痛苦、无疤痕、随治随走、费用低等特点。\r\n微创治疗：在内窥镜下操作，手术视野放大500倍，无残漏地清除所有臭汗腺，手术精准、安全可靠。\r\n疗效显著：从临床治疗综合研究发现：治疗效果比较明显，且基本上无明显瘢痕及牵拉感。\r\n不易复发：运用先进诊疗模式，达到心理、生理双重健康标准，以免不必要的再次手术。\r\n随治随走：治疗快，无痛苦，无副作用，不影响工作、学习，随治随走。\r\n自然美观：腋下很小的切口，将腋下汗腺根部波坏，使其丧失分泌功能，治疗后皮肤皱褶自然美观。\r\n专业保密：由经验丰富的专业医师，亲自操作，安全无痛，保护每位患者的隐私。',220,4,33,5,1469262957,'全美特惠价为单次价，套餐价格更多优惠。');
/*!40000 ALTER TABLE `qm_tehui` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_tehui_type`
--

DROP TABLE IF EXISTS `qm_tehui_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_tehui_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='特惠类别';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_tehui_type`
--

LOCK TABLES `qm_tehui_type` WRITE;
/*!40000 ALTER TABLE `qm_tehui_type` DISABLE KEYS */;
INSERT INTO `qm_tehui_type` VALUES (1,'玻尿酸',1464690782),(2,'瘦脸针',1464690794),(3,'水光针',1464690816),(4,'祛痘祛斑',1464743762),(5,'毛发',1467287405),(6,'面部年轻化',1464745262),(7,'健康管理',1464745291),(8,'双眼皮',1444631742),(9,'开眼角',1444631750),(10,'隆鼻',1444631761),(11,'面部轮廓',1464744065),(12,'吸脂',1464744074),(13,'丰唇',1464744127),(14,'卧蚕',1464744213),(15,'祛眼袋',1464744233),(16,'韩式半永久',1469190495),(17,'形体',1464745112),(18,'私密',1464745137),(19,'超声刀',1444789732),(20,'丰胸',1464744996),(21,'口腔',1464744977);
/*!40000 ALTER TABLE `qm_tehui_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_template_styles`
--

DROP TABLE IF EXISTS `qm_template_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_template_styles`
--

LOCK TABLES `qm_template_styles` WRITE;
/*!40000 ALTER TABLE `qm_template_styles` DISABLE KEYS */;
INSERT INTO `qm_template_styles` VALUES (2,'bluestork',1,'1','Bluestork - Default','{\"useRoundedCorners\":\"1\",\"showSiteName\":\"0\"}'),(3,'atomic',0,'0','Atomic - Default','{}'),(4,'beez_20',0,'1','Beez2 - Default','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"images\\/joomla_black.gif\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"templatecolor\":\"personal\",\"html5\":\"0\"}'),(5,'hathor',1,'0','Hathor - Default','{\"showSiteName\":\"0\",\"colourChoice\":\"\",\"boldText\":\"0\"}'),(6,'beez5',0,'0','Beez5 - Default','{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"images\\/sampledata\\/fruitshop\\/fruits.gif\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"html5\":\"0\"}');
/*!40000 ALTER TABLE `qm_template_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_update_categories`
--

DROP TABLE IF EXISTS `qm_update_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_update_categories` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT '',
  `description` text NOT NULL,
  `parent` int(11) DEFAULT '0',
  `updatesite` int(11) DEFAULT '0',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Update Categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_update_categories`
--

LOCK TABLES `qm_update_categories` WRITE;
/*!40000 ALTER TABLE `qm_update_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_update_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_update_sites`
--

DROP TABLE IF EXISTS `qm_update_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `location` text NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Update Sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_update_sites`
--

LOCK TABLES `qm_update_sites` WRITE;
/*!40000 ALTER TABLE `qm_update_sites` DISABLE KEYS */;
INSERT INTO `qm_update_sites` VALUES (1,'Joomla Core','collection','http://update.joomla.org/core/list.xml',1,1443508345),(2,'Joomla Extension Directory','collection','http://update.joomla.org/jed/list.xml',1,1443508345),(3,'Accredited Joomla! Translations','collection','http://update.joomla.org/language/translationlist.xml',1,1443508345);
/*!40000 ALTER TABLE `qm_update_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_update_sites_extensions`
--

DROP TABLE IF EXISTS `qm_update_sites_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links extensions to update sites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_update_sites_extensions`
--

LOCK TABLES `qm_update_sites_extensions` WRITE;
/*!40000 ALTER TABLE `qm_update_sites_extensions` DISABLE KEYS */;
INSERT INTO `qm_update_sites_extensions` VALUES (1,700),(2,700),(3,600),(3,10003);
/*!40000 ALTER TABLE `qm_update_sites_extensions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_updates`
--

DROP TABLE IF EXISTS `qm_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_updates` (
  `update_id` int(11) NOT NULL AUTO_INCREMENT,
  `update_site_id` int(11) DEFAULT '0',
  `extension_id` int(11) DEFAULT '0',
  `categoryid` int(11) DEFAULT '0',
  `name` varchar(100) DEFAULT '',
  `description` text NOT NULL,
  `element` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `folder` varchar(20) DEFAULT '',
  `client_id` tinyint(3) DEFAULT '0',
  `version` varchar(10) DEFAULT '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  `infourl` text NOT NULL,
  PRIMARY KEY (`update_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='Available Updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_updates`
--

LOCK TABLES `qm_updates` WRITE;
/*!40000 ALTER TABLE `qm_updates` DISABLE KEYS */;
INSERT INTO `qm_updates` VALUES (1,3,0,0,'Armenian','','pkg_hy-AM','package','',0,'2.5.28.3','','http://update.joomla.org/language/details/hy-AM_details.xml',''),(2,3,0,0,'Bahasa Indonesia','','pkg_id-ID','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/id-ID_details.xml',''),(3,3,0,0,'Danish','','pkg_da-DK','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/da-DK_details.xml',''),(4,3,0,0,'Khmer','','pkg_km-KH','package','',0,'2.5.7.1','','http://update.joomla.org/language/details/km-KH_details.xml',''),(5,3,0,0,'Swedish','','pkg_sv-SE','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/sv-SE_details.xml',''),(6,3,0,0,'Hungarian','','pkg_hu-HU','package','',0,'2.5.14.1','','http://update.joomla.org/language/details/hu-HU_details.xml',''),(7,3,0,0,'Bulgarian','','pkg_bg-BG','package','',0,'2.5.7.1','','http://update.joomla.org/language/details/bg-BG_details.xml',''),(8,3,0,0,'French','','pkg_fr-FR','package','',0,'2.5.28.2','','http://update.joomla.org/language/details/fr-FR_details.xml',''),(9,3,0,0,'Italian','','pkg_it-IT','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/it-IT_details.xml',''),(10,3,0,0,'Spanish','','pkg_es-ES','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/es-ES_details.xml',''),(11,3,0,0,'Dutch','','pkg_nl-NL','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/nl-NL_details.xml',''),(12,3,0,0,'Turkish','','pkg_tr-TR','package','',0,'2.5.20.1','','http://update.joomla.org/language/details/tr-TR_details.xml',''),(13,3,0,0,'Ukrainian','','pkg_uk-UA','package','',0,'2.5.13.11','','http://update.joomla.org/language/details/uk-UA_details.xml',''),(14,3,0,0,'Slovak','','pkg_sk-SK','package','',0,'2.5.27.1','','http://update.joomla.org/language/details/sk-SK_details.xml',''),(15,3,0,0,'Belarusian','','pkg_be-BY','package','',0,'2.5.8.1','','http://update.joomla.org/language/details/be-BY_details.xml',''),(16,3,0,0,'Latvian','','pkg_lv-LV','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/lv-LV_details.xml',''),(17,3,0,0,'Estonian','','pkg_et-EE','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/et-EE_details.xml',''),(18,3,0,0,'Romanian','','pkg_ro-RO','package','',0,'2.5.11.1','','http://update.joomla.org/language/details/ro-RO_details.xml',''),(19,3,0,0,'Flemish','','pkg_nl-BE','package','',0,'2.5.27.1','','http://update.joomla.org/language/details/nl-BE_details.xml',''),(20,3,0,0,'Macedonian','','pkg_mk-MK','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/mk-MK_details.xml',''),(21,3,0,0,'Japanese','','pkg_ja-JP','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/ja-JP_details.xml',''),(22,3,0,0,'Serbian Latin','','pkg_sr-YU','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/sr-YU_details.xml',''),(23,3,0,0,'Arabic Unitag','','pkg_ar-AA','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/ar-AA_details.xml',''),(24,3,0,0,'German','','pkg_de-DE','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/de-DE_details.xml',''),(25,3,0,0,'Norwegian Bokmal','','pkg_nb-NO','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/nb-NO_details.xml',''),(26,3,0,0,'English AU','','pkg_en-AU','package','',0,'2.5.22.2','','http://update.joomla.org/language/details/en-AU_details.xml',''),(27,3,0,0,'English US','','pkg_en-US','package','',0,'2.5.22.1','','http://update.joomla.org/language/details/en-US_details.xml',''),(28,3,0,0,'Serbian Cyrillic','','pkg_sr-RS','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/sr-RS_details.xml',''),(29,3,0,0,'Lithuanian','','pkg_lt-LT','package','',0,'2.5.7.1','','http://update.joomla.org/language/details/lt-LT_details.xml',''),(30,3,0,0,'Albanian','','pkg_sq-AL','package','',0,'2.5.1.5','','http://update.joomla.org/language/details/sq-AL_details.xml',''),(31,3,0,0,'Czech','','pkg_cs-CZ','package','',0,'2.5.28.2','','http://update.joomla.org/language/details/cs-CZ_details.xml',''),(32,3,0,0,'Persian','','pkg_fa-IR','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/fa-IR_details.xml',''),(33,3,0,0,'Galician','','pkg_gl-ES','package','',0,'2.5.7.4','','http://update.joomla.org/language/details/gl-ES_details.xml',''),(34,3,0,0,'Polish','','pkg_pl-PL','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/pl-PL_details.xml',''),(35,3,0,0,'Syriac','','pkg_sy-IQ','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/sy-IQ_details.xml',''),(36,3,0,0,'Portuguese','','pkg_pt-PT','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/pt-PT_details.xml',''),(37,3,0,0,'Russian','','pkg_ru-RU','package','',0,'2.5.24.1','','http://update.joomla.org/language/details/ru-RU_details.xml',''),(38,3,0,0,'Hebrew','','pkg_he-IL','package','',0,'2.5.7.1','','http://update.joomla.org/language/details/he-IL_details.xml',''),(39,3,0,0,'Catalan','','pkg_ca-ES','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/ca-ES_details.xml',''),(40,3,0,0,'Laotian','','pkg_lo-LA','package','',0,'2.5.6.1','','http://update.joomla.org/language/details/lo-LA_details.xml',''),(41,3,0,0,'Afrikaans','','pkg_af-ZA','package','',0,'2.5.16.1','','http://update.joomla.org/language/details/af-ZA_details.xml',''),(43,3,0,0,'Greek','','pkg_el-GR','package','',0,'2.5.6.1','','http://update.joomla.org/language/details/el-GR_details.xml',''),(44,3,0,0,'Finnish','','pkg_fi-FI','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/fi-FI_details.xml',''),(45,3,0,0,'Portuguese Brazil','','pkg_pt-BR','package','',0,'2.5.9.1','','http://update.joomla.org/language/details/pt-BR_details.xml',''),(46,3,0,0,'Chinese Traditional','','pkg_zh-TW','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/zh-TW_details.xml',''),(47,3,0,0,'Vietnamese','','pkg_vi-VN','package','',0,'2.5.8.1','','http://update.joomla.org/language/details/vi-VN_details.xml',''),(48,3,0,0,'Kurdish Sorani','','pkg_ckb-IQ','package','',0,'2.5.9.1','','http://update.joomla.org/language/details/ckb-IQ_details.xml',''),(49,3,0,0,'Bengali','','pkg_bn-BD','package','',0,'2.5.0.1','','http://update.joomla.org/language/details/bn-BD_details.xml',''),(50,3,0,0,'Bosnian','','pkg_bs-BA','package','',0,'2.5.24.1','','http://update.joomla.org/language/details/bs-BA_details.xml',''),(51,3,0,0,'Croatian','','pkg_hr-HR','package','',0,'2.5.13.1','','http://update.joomla.org/language/details/hr-HR_details.xml',''),(52,3,0,0,'Azeri','','pkg_az-AZ','package','',0,'2.5.7.1','','http://update.joomla.org/language/details/az-AZ_details.xml',''),(53,3,0,0,'Norwegian Nynorsk','','pkg_nn-NO','package','',0,'2.5.8.1','','http://update.joomla.org/language/details/nn-NO_details.xml',''),(54,3,0,0,'Tamil India','','pkg_ta-IN','package','',0,'2.5.28.2','','http://update.joomla.org/language/details/ta-IN_details.xml',''),(55,3,0,0,'Scottish Gaelic','','pkg_gd-GB','package','',0,'2.5.7.1','','http://update.joomla.org/language/details/gd-GB_details.xml',''),(56,3,0,0,'Thai','','pkg_th-TH','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/th-TH_details.xml',''),(57,3,0,0,'Basque','','pkg_eu-ES','package','',0,'1.7.0.1','','http://update.joomla.org/language/details/eu-ES_details.xml',''),(58,3,0,0,'Uyghur','','pkg_ug-CN','package','',0,'2.5.7.2','','http://update.joomla.org/language/details/ug-CN_details.xml',''),(59,3,0,0,'Korean','','pkg_ko-KR','package','',0,'2.5.11.1','','http://update.joomla.org/language/details/ko-KR_details.xml',''),(60,3,0,0,'Hindi','','pkg_hi-IN','package','',0,'2.5.6.1','','http://update.joomla.org/language/details/hi-IN_details.xml',''),(61,3,0,0,'Welsh','','pkg_cy-GB','package','',0,'2.5.6.1','','http://update.joomla.org/language/details/cy-GB_details.xml',''),(62,3,0,0,'Swahili','','pkg_sw-KE','package','',0,'2.5.28.1','','http://update.joomla.org/language/details/sw-KE_details.xml','');
/*!40000 ALTER TABLE `qm_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_user_notes`
--

DROP TABLE IF EXISTS `qm_user_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_user_notes`
--

LOCK TABLES `qm_user_notes` WRITE;
/*!40000 ALTER TABLE `qm_user_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_user_notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_user_profiles`
--

DROP TABLE IF EXISTS `qm_user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_user_profiles`
--

LOCK TABLES `qm_user_profiles` WRITE;
/*!40000 ALTER TABLE `qm_user_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_user_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_user_usergroup_map`
--

DROP TABLE IF EXISTS `qm_user_usergroup_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_user_usergroup_map`
--

LOCK TABLES `qm_user_usergroup_map` WRITE;
/*!40000 ALTER TABLE `qm_user_usergroup_map` DISABLE KEYS */;
INSERT INTO `qm_user_usergroup_map` VALUES (973,8),(974,7),(975,7),(976,7);
/*!40000 ALTER TABLE `qm_user_usergroup_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_usergroups`
--

DROP TABLE IF EXISTS `qm_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_usergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Adjacency List Reference Id',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` (`lft`,`rgt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_usergroups`
--

LOCK TABLES `qm_usergroups` WRITE;
/*!40000 ALTER TABLE `qm_usergroups` DISABLE KEYS */;
INSERT INTO `qm_usergroups` VALUES (1,0,1,18,'全体用户'),(6,1,12,17,'管理员'),(7,6,15,16,'服务人员'),(8,1,10,11,'Super Users'),(9,6,13,14,'入驻医院服务站');
/*!40000 ALTER TABLE `qm_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_users`
--

DROP TABLE IF EXISTS `qm_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(150) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `usertype` varchar(25) NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  PRIMARY KEY (`id`),
  KEY `usertype` (`usertype`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=977 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_users`
--

LOCK TABLES `qm_users` WRITE;
/*!40000 ALTER TABLE `qm_users` DISABLE KEYS */;
INSERT INTO `qm_users` VALUES (973,'Super User','admin','183107471@qq.com','$P$DSK2isjYoEz/KIxlVSSThfBp2fk28/0','deprecated',0,1,'2015-08-24 00:42:34','2016-08-16 02:57:37','0','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00 00:00:00',0),(974,'server1','server1','1@qq.com','$P$DOKf3VrSASBQLjbq4qfydAYAgLAstj/','',0,0,'2016-05-27 04:58:36','0000-00-00 00:00:00','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00 00:00:00',0),(975,'方芳','fangfang','499063036@qq.com','$P$DSUNW4VJ4l3/O/bXLDJnRorW/vnaeB/','',0,0,'2016-06-01 03:41:10','0000-00-00 00:00:00','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00 00:00:00',0),(976,'server2','server2','2@qq.com','$P$DMrXNtL5gYjSwWzIjCHl5052KGHKio0','',0,0,'2016-06-01 03:52:02','0000-00-00 00:00:00','','{\"admin_style\":\"\",\"admin_language\":\"\",\"language\":\"\",\"editor\":\"\",\"helpsite\":\"\",\"timezone\":\"\"}','0000-00-00 00:00:00',0);
/*!40000 ALTER TABLE `qm_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_users_common`
--

DROP TABLE IF EXISTS `qm_users_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_users_common` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(9) unsigned NOT NULL,
  `username` varchar(255) NOT NULL,
  `tel` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `birthday` varchar(255) NOT NULL,
  `psw` varchar(255) NOT NULL,
  `pid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `sex` tinyint(1) unsigned NOT NULL,
  `block` tinyint(1) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Appç”¨æˆ·è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_users_common`
--

LOCK TABLES `qm_users_common` WRITE;
/*!40000 ALTER TABLE `qm_users_common` DISABLE KEYS */;
INSERT INTO `qm_users_common` VALUES (7,785251622,'-26#-72#-123#-25#-78#-91#-27#-80#-113#-24#-113#-100#','13717975635','http://139.196.172.208/qm/files/user/95/4c/d5/a5/785251622/1449193974.jpg','1990-1-1','111111',1,1,0,0,1464747937),(8,389604558,'229#143#145#233#146#177#229#149#166#','18518687508','http://139.196.172.208/qm/files/user/b8/da/2f/e1/389604558/1449119134.png','2014-03-16','111111',1,1,0,0,1449157703),(9,701603161,'104#98#118#104#','13812591716','','2013-02-16','111111',7,57,0,0,1449198741),(11,510739473,'-28#-72#-121#-23#-121#-116#-23#-107#-65#-27#-97#-114#','','http://q.qlogo.cn/qqapp/1104886532/5BB6E311662E88A173432BEB4FC99003/40','2008-1-1','',9,73,0,0,1449124470),(12,813079450,'-26#-72#-123#-25#-78#-91#','13241296545','http://139.196.172.208/qm/files/user/cf/fb/03/be/813079450/1455770826.jpg','2011-1-1','111111',0,0,0,0,1464747761),(13,449039907,'100#100#100#100#','13681339912','http://139.196.172.208/qm/files/user/17/82/2d/04/449039907/1467256983.png','1998-08-03','107038',13,121,0,0,1467256983),(14,990758369,'230#136#145#229#143#171#229#146#154#229#146#154#230#158#170#','','http://q.qlogo.cn/qqapp/1104886532/2236B30B7F7EB3678E13E3794AF139CB/40','2013-03-15','',0,0,0,0,1449193154),(15,336145299,'230#136#145#229#143#171#229#146#154#229#146#154#230#158#170#','','http://wx.qlogo.cn/mmopen/W1eKbA2RaawWfWlmYPCyC1B27XvfsicqXf1kia5ZqUKuWRcMKiahuJ1Ma7xk2xrtncfCmmkiaudqiaGkRy965dkFWcISq0koicTTu2/64','','',0,0,0,0,1448929672),(16,23869354,'229#146#140#229#176#154#229#183#178#229#171#129#228#186#186#','','http://tp2.sinaimg.cn/2990908177/50/0/1','','',0,0,0,0,1448931039),(17,581689868,'109#105#110#103#116#105#97#110#110#105#','13693338397','http://139.196.172.208/qm/files/user/e5/d9/55/02/581689868/1450693591.jpg','1970-1-1','123456',0,0,0,0,1450693591),(18,848109072,'115#117#110#110#121#','13269802202','http://q.qlogo.cn/qqapp/1104886532/DFCC865030FB23BA2D62C55000D270FB/40','','123456',1,1,0,0,1461232673),(19,304721101,'-27#-68#-96#-27#-82#-74#-26#-104#-116#','','','','',0,0,0,0,1448938665),(20,513472427,'229#145#168#229#191#151#232#182#133#','18500150900','','1976-3-26','123456',0,0,0,0,1448943409),(21,490878686,'104#103#102#104#104#104#','18500223763','http://139.196.172.208/qm/files/user/73/18/b8/b7/490878686/1450337266.png','2005-03-28','111111',27,294,0,0,1452818622),(22,3371723,'232#128#131#232#153#145#232#128#131#232#153#145#','15010651657','','1983-1-1','111111',0,0,0,0,1448953890),(23,594111915,'-27#-82#-94#-26#-93#-71#-27#-83#-92#-24#-120#-97#-27#-109#-121#-27#-111#-128#-27#-111#-128#','15301319969','http://139.196.172.208/qm/files/user/3e/6b/35/3f/594111915/1451465335.jpg','2004-1-1','123456',5,25,2,0,1467357334),(24,527013189,'119#106#112#','13546578612','','1993-6-13','123456',0,0,0,0,1448960030),(25,599677187,'-27#-120#-104#-23#-99#-103#-27#-109#-120#-27#-109#-120#-27#-107#-90#','15010809559','http://139.196.172.208/qm/files/user/43/3a/7d/22/599677187/1449452714.jpg','1990-1-1','123456',1,1,0,0,1450089940),(27,378741103,'-28#-72#-128#-28#-72#-128#','15003329021','','2015-12-1','123456',0,0,0,0,1448967476),(28,312194323,'122#103#114#101#101#110#','13911661144','http://139.196.172.208/qm/files/user/a1/ec/da/53/312194323/1451038735.jpg','1980-10-1','boyidea',2,2,0,0,1451038735),(29,998962158,'-27#-80#-113#-27#-83#-103#','15210377196','','2015-12-4','111111',0,0,0,0,1449215848),(30,746621638,'-27#-100#-88#-27#-112#-105#','18977888800','','2016-3-2','123456',1,1,0,0,1456882298),(31,518383848,'97#104#111#111#','18627295999','','1982-1-1','wh720681',0,0,0,0,1449383426),(32,669103067,'-24#-65#-104#-28#-72#-115#-25#-97#-91#-23#-127#-109#-27#-112#-115#-27#-83#-105#','18201433157','http://139.196.172.208/qm/files/user/a8/22/4a/f7/669103067/1449540974.jpg','1993-1-1','123456',12,98,0,0,1449540974),(33,157186697,'229#174#162#230#163#185#229#173#164#232#136#159#','','http://tp2.sinaimg.cn/2984274385/50/40057797765/0','','',0,0,0,0,1449911580),(34,387195170,'-17#-68#-122#-27#-123#-88#-26#-80#-111#-28#-70#-119#-23#-100#-72#-26#-72#-72#-26#-120#-113#-17#-68#-122#','','http://wx.qlogo.cn/mmopen/QKRv5AoxtFvX67T2icQ6PrRPznN21aIjvpGI9WUIKNWpr8WcTGzsn8rcJXG0clUibTt78k4wEia0iaOvWxv0c6oZ3ksFicvicoP83b/0','','',0,0,0,0,1450084116),(35,436942141,'116#116#116#116#116#','18986126111','http://139.196.172.208/qm/files/user/4e/55/b3/13/436942141/1456646066.jpg','2016-2-28','123456',1,1,0,0,1456646066),(36,473085438,'-27#-82#-94#-26#-93#-71#-27#-83#-92#-24#-120#-97#','','http://wx.qlogo.cn/mmopen/QKRv5AoxtFvLKGt0GQ4EoaaYiaoKud2icuUdL758MToa3th5fY04v8FvNoOsM848GNWtm54hzPIo12zXV5apaLYkLejVuP96eu/0','','',0,0,0,0,1450085733),(37,12279597,'115#117#110#110#121#','18701242134','http://139.196.172.208/qm/files/user/cd/bc/d0/2c/12279597/1460873560.jpg','','',0,0,0,0,1460873560),(38,681558568,'-27#-68#-96#-27#-82#-74#-26#-104#-116#','','http://139.196.172.208/qm/files/user/9a/bc/a1/46/681558568/1450676587.jpg','1992-1-1','',2,2,0,0,1450676597),(39,607552052,'-27#-82#-94#-26#-93#-71#-27#-83#-92#-24#-120#-97#','15301319969','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7VfTxPyR2ch4ZnTYTRUJA3Hv4biahwA6WXOquicn5uRDE85h7HLnQdib7orPMT7PCM59TickfCeLXtGIHebuHuVDBU/0','','',0,0,0,0,1461030570),(40,465386648,'-25#-114#-117#-25#-99#-65#','','http://wx.qlogo.cn/mmopen/Q3auHgzwzM4viaa6af8Btl2hj1GvaMCG0eibwI0nTVibGWDdwtj3XGuY5DWtdZOMPAib0rt7hlBUSx0r5UeksPWCudj6myYDB8abVjo7hrYJudQ/0','','',0,0,0,0,1450693727),(41,707440055,'-17#-68#-127#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7VfTxPyR2chzLG6LfogKmkickCvNchHNGrMn0qy5qZG940O0shrkGULp0xIVyFibjOUwpwZhdCibr1sFGD0NP8Vna/0','','',0,0,0,0,1450693778),(42,250827191,'232#191#158#232#182#133#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaEKYeARat8v9xkflLA0ONJHXIvV3jIPbVibVgyCiazy5hO9y46pKds9D0hDEZTuKRpO016pLib0Psd0LA/64','','',30,322,0,0,1450747536),(43,559391868,'-27#-92#-87#-27#-92#-87#-27#-91#-67#-27#-65#-125#-26#-125#-123#','18977888800','http://q.qlogo.cn/qqapp/1105019688/8B141529A28D7F126635E51A6B1ADED3/40','','',0,0,0,0,1465216255),(44,9946058,'-27#-92#-87#-27#-92#-87#-27#-91#-67#-27#-65#-125#-26#-125#-123#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1MD27Tadj6Pw9I7xKKhDoFfJC4HTNf9vBPs8PNaiaumtZ6DIK5ClC4Ey10lo6FHqDx6E9lWAknUnEqXEHDzAwPic8/0','','',0,0,0,0,1452849054),(45,306367496,'-28#-70#-111#-26#-80#-76#-25#-90#-123#-27#-65#-125#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1MD27Tadj6Pw5fgJCEAxZ575ZAetXj8hUQmvwsO1vcbZW4DcaQWFINrSFPpaWBOv5XJGZgjWA0WRJFj6Ib01wQ9/0','','',0,0,0,0,1453643793),(46,845393722,'-27#-68#-96#-23#-101#-73#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSXrHWgDC8LpjPqtiaicXplicOePeDt3QYyrF0GSuCsaOicJMGKgEZAYWvRzZa4Tckia3fKsR2zNfv0qXtUobqOo0H70j/0','','',0,0,0,0,1454131085),(47,518396413,'230#136#145#229#143#171#68#68#81#','','http://139.196.172.208/qm/files/user/cb/6c/0c/16/518396413/1461231627.png','1980-08-03','',18,183,0,0,1461231761),(48,689620122,'231#187#143#229#184#184#','18901119477','','1979-1-1','111111',0,0,0,0,1454379917),(49,248595419,'-24#-128#-127#-27#-111#-88#','13511013305','http://139.196.172.208:80/qm/files/user/04/a8/8a/b5/248595419/1471266520.png','1976-3-26','123456',1,1,1,0,1471266575),(50,249091022,'67#111#117#103#97#114#','18910519186','http://wx.qlogo.cn/mmopen/f0lbTtEzTSXom8HOicD2ZUh276NETnGabak5VDxJegGelsS9nBm13NdfyQIZjd6w9Cmdp0O834GbLVx06xtLnreh6oN6mjavH/0','','',0,0,0,0,1456403586),(51,380934770,'-26#-72#-123#-25#-78#-91#-27#-80#-113#-24#-113#-100#','','http://wx.qlogo.cn/mmopen/bMNQUGWqeU4LpEwKUk3GibGF9rBc0MOtWzdqWD7n0ibYgmjfBFvxEdeMDQn1HIpxB6fZNoXVlbWugCe1yQ9mFcP0UgKO5XeDhC/0','','',0,0,0,0,1456801091),(52,887915923,'-27#-123#-88#-25#-66#-114#-27#-80#-113#-25#-68#-106#','13260605192','http://139.196.172.208/qm/files/user/6e/d0/2e/e3/887915923/1458700251.jpg','1993-3-8','q19669394',17,169,0,0,1459399608),(53,9774154,'-28#-70#-70#-26#-73#-95#-27#-90#-126#-24#-113#-118#','18945667977','','1975-5-2','197500',0,0,0,0,1457181344),(54,574593838,'-25#-83#-119#-27#-66#-123#','15846800333','','2016-3-7','yang211314',0,0,0,0,1457310866),(55,394358564,'230#186#144#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaEIdVLsMUsWqibicX63BMlMhicNK728Tkr4gLmbDAABYPQmryvurPJQoaJXcmlQq39r5VvFPmO58r4rOQ/64','','',0,0,0,0,1458616813),(56,574987582,'-26#-80#-76#-25#-123#-82#-23#-79#-68#-25#-119#-121#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7VfTxPyR2chicHcvXUTuI13xxib5VyEnmWV60CWhF1ju0DQ4Fcwo9wAkQAMvzCibxOhCLicWU4rOOajVbaxNjvcQpg/0','','',0,0,0,0,1458786214),(57,501493680,'-26#-99#-88#-26#-99#-88#','13370815505','','1986-4-30','201148',0,0,0,0,1459344881),(58,968220660,'-23#-85#-104#-27#-126#-78#-27#-91#-77#-25#-114#-117#','18302888918','http://139.196.172.208/qm/files/user/2c/e3/dd/2f/968220660/1459771517.jpg','1988-10-1','huazai8311',0,0,0,0,1459771517),(59,669091325,'99#111#117#103#97#114#','','http://wx.qlogo.cn/mmopen/ajNVdqHZLLBevCwyYoOvLcvic7GFWE9QpHVYDickNrFopaHSYco4EE7C14Fic24ibicUS9XQwd16ry6F9ia3TVeBZGrg/0','','',0,0,0,0,1459513592),(60,321108478,'-25#-99#-95#-25#-91#-98#','13260605192','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7VfTxPyR2ch0v3gvIjbJUuFuDibX1Wy0hV65EAk2a9y9qUfAlNbqLoz7AbTXvca7a8CbPRcrn7gv6Lk5f9qUyss/0','1993-3-8','',17,169,2,0,1469256637),(61,822642142,'-25#-103#-66#-27#-112#-120#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSXz0sGuSZiaOB7ESM6GBYfVic8AMicbYCtWtDeA1vjb0dI7IgfukHvZv7aN35ibhKzZQLgkNrJmOsibBiaLVpRg4ecup5/0','','',0,0,0,0,1459515892),(62,988107387,'80#114#111#118#101#110#99#101#','','http://139.196.172.208/qm/files/user/f4/c3/45/b4/988107387/1459826719.jpg','','',0,0,0,0,1462245452),(63,315787180,'-23#-99#-110#-25#-111#-74#','','http://139.196.172.208/qm/files/user/2b/f8/b0/d2/315787180/1459840641.jpg','1990-5-3','',1,1,0,0,1459840641),(64,59977127,'-28#-70#-78#-27#-81#-122#-26#-105#-96#-25#-116#-100#','','http://139.196.172.208/qm/files/user/62/90/13/35/59977127/1459842433.jpg','','',0,0,0,0,1459843101),(65,946848813,'-28#-70#-108#-25#-90#-113#-28#-72#-76#-23#-105#-88#','15804661345','','1980-1-1','099880',0,0,0,0,1459842622),(66,832745935,'-27#-115#-118#-24#-66#-71#-26#-96#-111#','','http://139.196.172.208/qm/files/user/17/06/81/79/832745935/1459844304.jpg','','',0,0,0,0,1459844330),(67,682875857,'-24#-112#-116#-27#-88#-125#','18672948692','http://139.196.172.208/qm/files/user/65/6a/2a/fc/682875857/1459845767.jpg','1996-1-1','123456789',17,169,0,0,1459846413),(68,726176698,'-26#-120#-111#-28#-72#-70#-28#-67#-96#-23#-126#-93#-28#-71#-120#-27#-117#-121#-26#-107#-94#','','http://139.196.172.208/qm/files/user/7a/27/dc/3e/726176698/1459857066.jpg','1994-10-1','',0,0,0,0,1460358150),(69,17992305,'-26#-95#-125#-23#-93#-114#-26#-99#-113#-23#-101#-88#','','http://q.qlogo.cn/qqapp/1105019688/A97CAD279145E35655AEA1F8AC22065C/40','','',0,0,0,0,1459938147),(70,246667211,'-26#-123#-107#-27#-80#-104#','13147123042','http://139.196.172.208/qm/files/user/b4/6b/89/7d/246667211/1466231984.jpg','1994-3-23','1314520',17,169,2,0,1466231984),(71,214766593,'-26#-88#-79#-26#-95#-125#','','http://q.qlogo.cn/qqapp/1105019688/533231A3C8F9FA94F86F0F2D11E77C65/40','','',0,0,0,0,1459944570),(72,64707944,'-26#-105#-74#-27#-123#-119#-28#-69#-69#-28#-67#-96#-24#-67#-69#-24#-106#-124#','','http://q.qlogo.cn/qqapp/1105019688/7E4703C8765C2FEE47AF53600B0A3712/40','','',0,0,0,0,1459944936),(73,472888401,'83#117#109#109#101#114#','','http://q.qlogo.cn/qqapp/1105019688/5E2B7B8A0746503D1A28EBE432766007/40','','',0,0,0,0,1459945228),(74,318118360,'-27#-115#-118#-27#-81#-72#-26#-105#-74#-27#-123#-119#','','http://q.qlogo.cn/qqapp/1105019688/31B4F566C73D7B4D3520C6A6A6D7A219/40','','',0,0,0,0,1459945627),(75,249273711,'-25#-83#-119#-27#-128#-103#-28#-72#-117#-28#-72#-128#-28#-72#-86#-24#-118#-79#-27#-83#-93#','','http://q.qlogo.cn/qqapp/1105019688/29361F4F85CF5A6ED9B4B05FE265B8AF/40','','',0,0,0,0,1459945963),(76,272381300,'-26#-75#-123#-25#-84#-111#-26#-83#-116#','','http://q.qlogo.cn/qqapp/1105019688/161E19ED08B2BA530333BA161E0B1EB3/40','','',0,0,0,0,1459946273),(77,263910545,'-27#-73#-76#-23#-69#-114#-23#-122#-119#','','http://q.qlogo.cn/qqapp/1105019688/7A8E7384517DB7D075D84FEA404FDA25/40','','',0,0,0,0,1459946624),(78,491763369,'-26#-120#-111#-27#-113#-85#-26#-83#-90#-26#-97#-112#-26#-97#-112#','','http://q.qlogo.cn/qqapp/1105019688/D659A11DE0E5BF7256986219FD093F24/40','','',0,0,0,0,1459947502),(79,202834502,'49#51#53#52#48#55#53#56#54#49#','','http://q.qlogo.cn/qqapp/1105019688/C034C7E397CF25B13FCE9E68706C610B/40','','',0,0,0,0,1459987121),(80,796741246,'-28#-72#-121#-23#-121#-116#-23#-107#-65#-27#-97#-114#','','http://q.qlogo.cn/qqapp/1105019688/9DEDDAFB2EA0C0C9EBAD673C1C76E5EF/40','','',0,0,0,0,1459993780),(81,676262791,'-28#-68#-111#-26#-128#-99#','','http://q.qlogo.cn/qqapp/1105019688/FB8806DEB87CB4D2C47AE4D9AD61DA22/40','','',0,0,0,0,1459995195),(82,337271199,'-26#-107#-123#-26#-94#-90#','','http://q.qlogo.cn/qqapp/1105019688/1B44B4C963CEE760E850C66FB75C50FB/40','','',0,0,0,0,1459995560),(83,198420087,'-28#-67#-103#-26#-94#-90#-27#-65#-122#','','http://q.qlogo.cn/qqapp/1105019688/588A3403338B474EAC0777B29AC616E7/40','','',0,0,0,0,1459996206),(84,76361086,'-25#-104#-90#-27#-80#-79#-26#-104#-81#-25#-66#-114#','','http://q.qlogo.cn/qqapp/1105019688/EFA1CCBDD4F4730ECE01F83AD0A0858E/40','','',0,0,0,0,1459996782),(85,131400393,'-25#-120#-79#-27#-73#-90#-24#-124#-72#-25#-102#-124#-27#-89#-111#-27#-88#-104#','','http://q.qlogo.cn/qqapp/1105019688/BBFC1ACA109243B47E4DF9AB6DCC63ED/40','','',0,0,0,0,1459997133),(86,522278120,'86#105#118#105#97#110#','','http://q.qlogo.cn/qqapp/1105019688/787A3B2A97AAF34FA55B0D00697A0330/40','','',0,0,0,0,1459997706),(87,509271164,'76#105#122#','','http://q.qlogo.cn/qqapp/1105019688/EAC8D0218DAC5F317F5033BF78F314AB/40','','',0,0,0,0,1459998377),(88,658098270,'-27#-92#-89#-26#-121#-110#-25#-116#-85#','','http://q.qlogo.cn/qqapp/1105019688/4A73D74B7B20000BC27546F0710E6047/40','','',0,0,0,0,1459999670),(89,414879352,'82#111#115#101#32#-29#-125#-67#','','http://139.196.172.208/qm/files/user/27/3f/b6/56/414879352/1460001184.jpg','','',0,0,0,0,1460001184),(90,609265170,'-25#-103#-67#-24#-119#-78#-27#-73#-89#-27#-123#-117#-27#-118#-101#','','http://q.qlogo.cn/qqapp/1105019688/B0096DEBF445D8644B705E1B0E07AF8B/40','','',0,0,0,0,1460003099),(91,650451367,'114#111#115#101#32#98#97#98#121#','','http://q.qlogo.cn/qqapp/1105019688/BF11436743411A960A268D4C404ADBCC/40','','',0,0,0,0,1460007486),(92,832661816,'-27#-92#-87#-28#-67#-65#-27#-82#-99#-24#-76#-99#','','http://q.qlogo.cn/qqapp/1105019688/6F1EE98B4FF9C44B4AA23296723B3816/40','','',0,0,0,0,1460008856),(93,959640217,'109#97#114#121#','','http://q.qlogo.cn/qqapp/1105019688/9B4FDBCA2E3050F337E0110583D25B5A/40','','',0,0,0,0,1460009267),(94,565255803,'68#101#98#98#105#101#','','http://q.qlogo.cn/qqapp/1105019688/F865946A8A38BA11CC51470008843BEE/40','','',0,0,0,0,1460009648),(95,37300233,'-27#-112#-76#-26#-103#-105#','','http://q.qlogo.cn/qqapp/1105019688/28E0C92D7665D87893B649DCBA863D2A/40','','',0,0,0,0,1460010069),(96,405486436,'67#97#110#100#105#99#101#','','http://q.qlogo.cn/qqapp/1105019688/BA6FECBE6089D5FDF8CBE19BAB8C9DCF/40','','',0,0,0,0,1460015277),(97,812456945,'-26#-88#-79#-26#-95#-125#-27#-80#-113#-25#-117#-105#-27#-83#-112#','','http://q.qlogo.cn/qqapp/1105019688/DA24F62121533DB0ABB172F03D97BA5E/40','','',0,0,0,0,1460015702),(98,1963104,'-23#-122#-119#-27#-65#-122#-26#-104#-91#-27#-81#-110#','','http://q.qlogo.cn/qqapp/1105019688/9D8B95B5C48CD7026C72E5985FE51C98/40','','',0,0,0,0,1460016010),(99,366210955,'66#111#110#110#105#101#','','http://q.qlogo.cn/qqapp/1105019688/EC6215B77B0B859868859F161CA99DCC/40','','',0,0,0,0,1460016152),(100,643069036,'66#101#103#105#110#32#97#103#97#105#110#','','http://q.qlogo.cn/qqapp/1105019688/1FF8E446F3980A69DE880A73568D9BC7/40','','',0,0,0,0,1460016335),(101,686278701,'80#114#105#115#111#110#','','http://q.qlogo.cn/qqapp/1105019688/EECFDB00CC9115528044ED360BDD46A0/40','','',0,0,0,0,1460016585),(102,13707127,'-26#-73#-79#-26#-125#-123#-27#-88#-121#-27#-106#-104#','','http://q.qlogo.cn/qqapp/1105019688/5BFF1D3CC723181E22A237DA3675E0CE/40','','',0,0,0,0,1460016607),(103,727203889,'-25#-94#-114#-24#-81#-83#-26#-125#-123#-23#-107#-65#','','http://q.qlogo.cn/qqapp/1105019688/FB605985CA704E3B85BA6BCD739AF05B/40','','',0,0,0,0,1460016801),(104,221058264,'-25#-125#-83#-26#-127#-117#-27#-120#-80#-24#-128#-127#','','http://q.qlogo.cn/qqapp/1105019688/07F96DC1C2AB8F1BD6493D48340C6965/40','','',0,0,0,0,1460017023),(105,746448119,'-26#-81#-108#-26#-120#-111#-24#-65#-104#-24#-112#-116#-17#-68#-97#','','http://q.qlogo.cn/qqapp/1105019688/D0C17346EA424D5C21FEA7588F9007C8/40','1994-1-1','',17,169,0,0,1460078299),(106,321570634,'-25#-77#-106#-27#-82#-99#-27#-82#-99#-28#-72#-115#-27#-109#-83#','','http://q.qlogo.cn/qqapp/1105019688/0CD6C4A1D8E820A07B3B964E9C18396B/40','','',0,0,0,0,1460080402),(107,714135518,'-25#-77#-69#118#106#110#105#105#102#110#111#105#102#110#32#','','http://q.qlogo.cn/qqapp/1105019688/D73AC6F886B8B066FABDB96E70FC08FB/40','','',0,0,0,0,1460081305),(108,385056803,'-24#-91#-65#-27#-115#-105#-27#-112#-111#','','http://q.qlogo.cn/qqapp/1105019688/819A1A4FD79647DE84A3E03A3188FFC4/40','','',0,0,0,0,1460081955),(109,555118827,'-27#-113#-111#-28#-72#-128#-27#-82#-74#-26#-81#-108#-24#-66#-125#','','http://q.qlogo.cn/qqapp/1105019688/358C270F719E339C7BE472F8645DDB02/40','','',0,0,0,0,1460082385),(110,499427849,'-23#-83#-108#-27#-91#-77#','','','1987-1-1','',0,0,0,0,1460084082),(111,489140974,'-24#-117#-91#-26#-101#-90#97#','','','1991-1-1','',0,0,0,0,1460099232),(112,126150972,'104#97#112#112#121#','','http://139.196.172.208/qm/files/user/a4/79/f7/bf/126150972/1460099937.jpg','1992-1-1','',0,0,0,0,1460099971),(113,903411317,'-23#-99#-110#-24#-114#-78#-25#-103#-67#-23#-101#-66#','','http://139.196.172.208/qm/files/user/21/76/ca/79/903411317/1460114072.jpg','','',0,0,0,0,1460361579),(114,694890651,'-24#-111#-93#-27#-80#-113#-27#-89#-112#','','http://139.196.172.208/qm/files/user/35/1a/8b/9a/694890651/1460117872.jpg','','',0,0,0,0,1460369626),(115,856636367,'-26#-75#-123#-24#-115#-119#-27#-113#-74#-27#-83#-112#','13260605192','http://q.qlogo.cn/qqapp/1105019688/3433ECC79CB6F8A2B5001C43B554170F/40','1993-1-1','',17,169,2,0,1464762047),(116,274456814,'-24#-125#-72#-27#-71#-77#-26#-80#-108#-28#-72#-115#-27#-71#-77#','','http://q.qlogo.cn/qqapp/1105019688/63BE88D590DB34682C11970762F4C4C1/40','','',0,0,0,0,1460165482),(117,320311975,'-28#-72#-128#-26#-100#-99#-23#-93#-114#-26#-100#-120#','','http://q.qlogo.cn/qqapp/1105019688/64081A15AF53686A9095BE265A35DA2F/40','1990-1-1','',17,169,0,0,1460173207),(118,376303575,'69#109#105#108#121#','','http://139.196.172.208/qm/files/user/12/31/69/f1/376303575/1460174331.jpg','1993-1-1','',17,169,0,0,1460174388),(119,601793228,'65#98#98#121#','','http://q.qlogo.cn/qqapp/1105019688/F217E42D97C01277146DF42144C28871/40','','',0,0,0,0,1460175096),(120,248243140,'-27#-120#-104#-27#-87#-75#','','http://q.qlogo.cn/qqapp/1105019688/C44D932C0037911B0E3B097E86D10C35/40','1991-1-1','',17,169,0,0,1460176412),(121,521203221,'-27#-80#-113#-26#-88#-79#-26#-95#-125#','','http://q.qlogo.cn/qqapp/1105019688/D30DF847F6CE86DEC72B33ECFD4C1583/40','','',0,0,0,0,1460189812),(122,591582862,'-25#-122#-118#-27#-92#-89#-27#-92#-89#','','http://q.qlogo.cn/qqapp/1105019688/0412E6B129042A495F24E13C8DC6F932/40','','',0,0,0,0,1460190195),(123,116975794,'-27#-89#-112#-26#-117#-67#-26#-105#-77#-26#-81#-108#-28#-68#-79#-26#-100#-119#-26#-125#-123#-24#-80#-125#','','http://q.qlogo.cn/qqapp/1105019688/BF055D4ADC55BF7CB6A1672BDC4D5D1F/40','','',0,0,0,0,1460191210),(124,576635203,'-27#-121#-116#-26#-103#-88#-26#-125#-123#-24#-81#-99#','','http://q.qlogo.cn/qqapp/1105019688/EAA094D782550EBBC2391B7596182179/40','','',0,0,0,0,1460192284),(125,231324474,'-27#-119#-115#-27#-95#-75#-27#-66#-128#-26#-104#-108#','','http://q.qlogo.cn/qqapp/1105019688/9ED631B52AADA0520F420D4E45A85B24/40','','',0,0,0,0,1460193060),(126,767719481,'-25#-100#-119#-25#-101#-82#-24#-119#-77#-26#-106#-80#-26#-100#-120#','','http://q.qlogo.cn/qqapp/1105019688/85C1FB0A93E6A3E0861435BB62AE46F2/40','1993-1-1','',0,0,0,0,1460221112),(127,628399798,'-28#-67#-77#-28#-67#-77#','','http://139.196.172.208/qm/files/user/09/40/06/a0/628399798/1460338070.jpg','1992-1-1','',17,169,0,0,1460338087),(128,553589499,'-25#-86#-99#-27#-80#-79#-26#-104#-81#-24#-66#-93#-28#-71#-120#-23#-123#-73#','','http://139.196.172.208/qm/files/user/9f/3b/91/78/553589499/1460338703.jpg','1990-12-15','',17,169,0,0,1460338720),(129,871524759,'-27#-92#-79#-27#-65#-125#-27#-91#-77#-25#-91#-98#','','http://139.196.172.208/qm/files/user/27/ee/04/8c/871524759/1460339229.jpg','1989-11-8','',17,169,0,0,1460339263),(130,530457734,'32#-27#-108#-112#-27#-112#-101#-25#-110#-89#','','http://139.196.172.208/qm/files/user/0a/9b/74/8c/530457734/1460339686.jpg','1988-3-11','',17,169,0,0,1460339719),(131,680892692,'-26#-88#-79#-24#-118#-79#-25#-84#-111#','','http://139.196.172.208/qm/files/user/7a/bc/04/37/680892692/1460339959.jpg','1991-12-11','',17,169,0,0,1460340075),(132,609419201,'-27#-113#-74#-25#-82#-85#','','http://139.196.172.208/qm/files/user/14/34/b6/f4/609419201/1460340636.jpg','1991-1-1','',17,169,0,0,1460340661),(133,592618647,'-27#-87#-119#-27#-87#-73#32#','','http://139.196.172.208/qm/files/user/1c/93/85/07/592618647/1460341440.jpg','1992-1-1','',17,169,0,0,1460341473),(134,700944948,'-24#-124#-79#-23#-108#-128#-25#-102#-124#-25#-120#-79#105#32#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1PvLlKDGtaedpdy0tIiaw4IrKnDqW3YF2rmU1VcgIrcicTpAhJLCNxkdw6MBd2SW2BAWcB3xVtcAxwRlEricbu8Kg3/0','1992-12-11','',17,169,0,0,1460342643),(135,378136472,'-27#-115#-100#-27#-79#-123#-26#-93#-82#-26#-98#-105#','','http://139.196.172.208/qm/files/user/6d/86/28/5d/378136472/1460343148.jpg','1994-1-1','',17,169,0,0,1460343202),(136,60073566,'-24#-128#-127#-26#-78#-71#-26#-99#-95#-17#-68#-127#32#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1O0XDNNCca7iaGsxZHlhJ8muIyiaXnpNg5zpPkichYWNFjibBeQ1z9dicQruSa2ndiaJ87UfY3xewE3nzsjShL0DqrpAg/0','1987-12-1','',17,169,0,0,1460343433),(137,402902455,'-27#-90#-122#-27#-109#-83#-24#-118#-79#-28#-70#-122#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSX6S7Kbkics4sjia1LRefwodO61JNd9IgHZAyS7Y9EElPoIKUqIbic8ljz978C7cfCv5ibXiaMDGnXSZMUmnea6Uiaunv/0','1988-1-2','',17,169,0,0,1460356150),(138,477390991,'-28#-72#-115#-27#-71#-77#-24#-125#-72#-28#-67#-107#-28#-69#-91#-27#-71#-77#-27#-92#-87#-28#-72#-117#','','http://139.196.172.208/qm/files/user/54/4b/33/99/477390991/1460356500.jpg','1994-1-1','',17,169,0,0,1460356523),(139,456848930,'-26#-97#-96#-27#-121#-119#77#89#','','http://139.196.172.208/qm/files/user/3e/db/61/b6/456848930/1460357653.jpg','1994-1-1','',17,169,0,0,1460357713),(140,556914415,'67#97#114#114#105#101#','','http://139.196.172.208/qm/files/user/ee/5f/bf/cb/556914415/1460358208.jpg','1997-1-1','',17,169,0,0,1460358279),(141,335274654,'70#101#114#110#','','http://139.196.172.208/qm/files/user/90/06/7b/1a/335274654/1460358698.jpg','1990-1-1','',17,169,0,0,1460358726),(142,440825519,'-27#-68#-96#-27#-128#-87#-26#-107#-113#','15012432928','','2016-4-11','123456',0,0,0,0,1460359279),(143,779692121,'77#89#-24#-106#-124#-24#-115#-73#-27#-122#-80#','','http://139.196.172.208/qm/files/user/9b/4d/71/83/779692121/1460359821.jpg','1985-1-1','',17,169,0,0,1460359866),(144,956863590,'-23#-99#-110#-26#-91#-102#','','http://139.196.172.208/qm/files/user/78/3c/7c/92/956863590/1460360759.jpg','1989-1-1','',0,0,0,0,1460360823),(145,320295814,'32#-26#-88#-118#-27#-82#-93#-18#-112#-73#-24#-113#-127#','','http://139.196.172.208/qm/files/user/1a/72/6f/86/320295814/1460424780.jpg','1988-12-22','',17,169,0,0,1460424803),(146,743789845,'-27#-68#-96#-26#-97#-112#-27#-87#-73#','','http://wx.qlogo.cn/mmopen/kiaXicXJs2M4cicLWmMYKkfOOIYMj5BgibVnxNYrUvI8crClp6BYI2MDTYQa5CNyicMX3yEia27qZUibictGlic00BPdmOicLzZAQRTiadA/0','1983-1-1','',17,169,0,0,1460425770),(147,243326844,'-27#-115#-125#-25#-103#-66#-27#-70#-90#','','http://139.196.172.208/qm/files/user/71/19/53/71/243326844/1460426009.jpg','1988-1-1','',17,169,0,0,1460426031),(148,292865815,'-25#-122#-103#-23#-101#-81#32#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d6jJ0KbssdNAsZYxrdH3ianJqS7otsBjsictcn9icOX2hicNcKknU118JrVXWgP2UBEcdiatmo6VHDWibIP5Mw4icN27jD/0','','',0,0,0,0,1460426250),(149,872371930,'32#-23#-69#-114#-27#-91#-126#-18#-116#-87#-24#-118#-82#','','http://139.196.172.208/qm/files/user/04/a7/e2/14/872371930/1460427097.jpg','1990-1-1','',0,0,0,0,1460427113),(150,416130344,'-23#-101#-123#-24#-118#-103#32#','','http://139.196.172.208/qm/files/user/da/ca/89/45/416130344/1460427558.jpg','1992-1-1','',17,169,0,0,1460427572),(151,787824779,'-27#-80#-111#-27#-91#-77#-26#-105#-89#-26#-125#-123#-26#-83#-116#','','http://139.196.172.208/qm/files/user/4f/e5/e9/62/787824779/1460427959.jpg','1994-3-6','',17,169,0,0,1460427975),(152,399623422,'32#-26#-99#-114#-23#-72#-93#-18#-112#-73#-26#-106#-109#','','http://139.196.172.208/qm/files/user/8c/30/64/f6/399623422/1460428276.jpg','1992-1-1','',0,0,0,0,1460428430),(153,203737511,'32#-25#-114#-117#-28#-71#-108#-18#-116#-87#-24#-117#-105#','','http://139.196.172.208/qm/files/user/57/e4/ed/49/203737511/1460428728.jpg','1993-3-1','',17,169,0,0,1460428743),(154,306862977,'-24#-112#-79#-24#-112#-79#','','http://139.196.172.208/qm/files/user/df/9e/a3/90/306862977/1460620219.jpg','1992-1-2','',17,169,0,0,1460620234),(155,830600666,'-27#-92#-89#-24#-125#-122#-25#-102#-124#-27#-66#-128#-27#-119#-115#-24#-75#-80#32#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7VfTxPyR2chxTia4gmvKNT4qhX2UxqAmfEhYiaSJPcNw9HY2dKjSP4ZC0MsxmUtlqmjYLj69kTQ8KBibhibvDb1XiaV/0','1992-3-1','',17,169,0,0,1460620698),(156,120829343,'-23#-87#-84#-26#-95#-88#-24#-108#-68#-24#-128#-77#','','http://139.196.172.208/qm/files/user/64/e3/68/26/120829343/1460622562.jpg','1991-1-1','',17,169,0,0,1460622583),(157,312461138,'-24#-117#-113#-25#-123#-116#-23#-99#-103#','','http://139.196.172.208/qm/files/user/bf/d6/ff/61/312461138/1460623663.jpg','1992-1-1','',17,169,0,0,1460623686),(158,973796455,'-26#-93#-82#-25#-90#-69#-28#-71#-99#-62#-80#32#102#100#103#104#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1OUicW8duJpFGJQrPLxJCmY9ZcIzsicV9UbWTV46jLjyIDyGTIxyFwbPuqEKGwssNodcAxfibNc20fibzNYKJ2kbrou/0','1992-1-1','',17,169,0,0,1460683363),(159,313931150,'-25#-78#-66#-25#-127#-75#','','http://139.196.172.208/qm/files/user/6b/44/e7/22/313931150/1460684350.jpg','1993-1-1','',17,169,0,0,1460684412),(160,322865809,'-27#-83#-93#-24#-118#-71#','','http://139.196.172.208/qm/files/user/d7/99/6f/dc/322865809/1460684965.jpg','1991-1-1','',17,169,0,0,1460685043),(161,266364564,'-26#-120#-76#-25#-69#-76#-26#-106#-81#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7ODic6fWp97YQxPiaFibEJ3SNFtsC5zMInQ64WqnYRhkDSUU5DicGOic3ehPxNtC3HNEpJdGPCEia8l9O2HMBLicFkIn1/0','1995-1-1','',17,169,0,0,1460685762),(162,270500510,'-28#-67#-96#-26#-100#-119#-28#-69#-128#-28#-71#-120#-24#-75#-124#-26#-100#-84#-24#-73#-97#-26#-120#-111#-26#-117#-67#','','http://139.196.172.208/qm/files/user/3b/8a/0e/0d/270500510/1460686253.jpg','1989-1-1','',17,169,0,0,1460686282),(163,440925575,'-25#-123#-98#-25#-84#-108#','','http://139.196.172.208/qm/files/user/23/7c/28/30/440925575/1460686637.jpg','1992-5-5','',17,169,0,0,1460686661),(164,754322357,'-26#-103#-88#-23#-101#-88#-27#-120#-99#-27#-112#-84#32#','','http://139.196.172.208/qm/files/user/e7/b7/5d/bc/754322357/1460686926.jpg','1993-1-2','',17,169,0,0,1460686939),(165,566472386,'-25#-111#-66#-24#-119#-78#','','http://139.196.172.208/qm/files/user/86/d6/f2/37/566472386/1460687241.jpg','1992-1-1','',0,0,0,0,1460687263),(166,65983657,'-27#-126#-69#-28#-72#-115#-26#-91#-98#-25#-98#-86#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7l5FgEaWx6STJYoicq2JmqbosKlxiafno30Xww9JDKaRoPtA6ic9mKR55pvQe3HYDJA1uPYpHNabyl0m4NuSck605/0','1993-7-1','',17,169,0,0,1460687795),(167,541104368,'-23#-99#-110#-24#-95#-85#-27#-90#-126#-26#-107#-123#46#-26#-125#-77#-24#-75#-73#-27#-67#-109#-27#-120#-99#46#','','http://wx.qlogo.cn/mmopen/GjaPkpahg7tEsBCWAohMw1j9AiczDqRugjgSIBrYYtxu1bs33VaeGIqEHJm8ckyxm6C04eibQueoZpjqSYkmXbvVUEFukB4lYw/0','1991-1-1','',17,169,0,0,1460687971),(168,721000785,'32#-25#-125#-97#-27#-80#-104#-27#-113#-92#-23#-127#-109#','','http://139.196.172.208/qm/files/user/97/cf/71/8b/721000785/1460702771.jpg','1991-1-1','',17,169,0,0,1460702788),(169,583752415,'-26#-120#-111#-27#-65#-125#-26#-126#-96#-26#-126#-96#','','http://139.196.172.208/qm/files/user/9a/19/88/4f/583752415/1460703178.jpg','1989-1-1','',17,169,0,0,1460703202),(170,563450421,'32#-24#-116#-74#-26#-78#-77#','','http://139.196.172.208/qm/files/user/7d/23/14/c1/563450421/1460703556.jpg','1987-1-1','',17,169,0,0,1460703570),(171,928188059,'-27#-72#-120#-27#-92#-86#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d48iaxGojlicXVATGZwS37w0fPEyXf2HuDZlQj6d7fxqlJtyTah3C5OVfPytic9Hy1Np8RjFpib6qLbv8DKibl7sibibCq/0','','',0,0,0,0,1460703851),(172,217256685,'-27#-127#-102#-28#-72#-86#-27#-91#-67#-27#-89#-111#-27#-88#-104#32#','','http://wx.qlogo.cn/mmopen/Q3auHgzwzM6Y1ewI1z2WLftkO1hfhZbBcsBdre3icmJBwr3fvHiaxP3ReibZMLibDS3sE0lDSmrAaibGQvtaBibicvFACKhB91CKSJJIbF6owxDmyk/0','','',0,0,0,0,1460704868),(173,843369688,'-28#-72#-74#-24#-76#-87#-27#-115#-106#-26#-128#-99#-27#-65#-75#32#','','http://wx.qlogo.cn/mmopen/WORRC3nWv9RvTjcCsKkammA46KLyXN4KQvo5ga6eJ9ByicXDrmpOficLzXuUGvfKZrS6Qy8Mr7ptGGoGjAU8kLE9LRUQGJ4UHw/0','','',0,0,0,0,1460705992),(174,512140113,'-26#-101#-68#-27#-121#-99#32#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSXozcBYo1vTbpxvKmWcG8DNLUibNnDpsxtwiarlAnEyAUTcDAuk6KKjMOMUOfSPOibliajicVx7wn9HgrQW8bkMASmJx/0','','',0,0,0,0,1460707334),(175,48025602,'-25#-120#-67#-26#-83#-86#-26#-83#-86#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1PgiazXDSI1iae8tza56T5VB0ZMpynkrsnXC18wqOVhVBJpf67GxZxEg0x5Uqj6JJic3QCfJkVBtbYn0NVPmbgesib5/0','','',0,0,0,0,1460708731),(176,934893010,'-29#-125#-93#-26#-116#-126#-27#-65#-75#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1OqOiaY2Hjy7AAic5x5tbL6HdE4mNWaNrX6Dic3KLzcKUXjNBIfzia6YGonddXwfywa5YmtwOUKJ8V6G9NKdNKs6H0g/0','','',0,0,0,0,1460710040),(177,921249596,'-25#-107#-86#-24#-116#-124#-26#-109#-115#-24#-101#-117#','','','','',0,0,0,0,1460710492),(178,42511265,'-27#-115#-118#-28#-65#-105#-28#-72#-115#-23#-101#-123#','','http://139.196.172.208/qm/files/user/e8/7d/eb/5a/42511265/1460712848.jpg','','',0,0,0,0,1460712848),(179,6570781,'32#-24#-65#-98#-27#-80#-104#-25#-65#-114#','','http://139.196.172.208/qm/files/user/de/6c/c9/5a/6570781/1460716594.jpg','','',0,0,0,0,1460716594),(180,846649983,'32#-23#-93#-114#-27#-94#-88#-23#-104#-77#','','http://139.196.172.208/qm/files/user/12/fb/92/aa/846649983/1460717136.jpg','1995-1-1','',0,0,0,0,1460717144),(181,960991456,'-27#-91#-67#-23#-93#-114#-27#-90#-126#-26#-80#-76#32#','','http://139.196.172.208/qm/files/user/b2/90/dd/01/960991456/1460719509.jpg','','',0,0,0,0,1460719509),(182,963574608,'97#98#99#99#99#99#','15801309477','','2016-4-16','201126',0,0,0,0,1460771769),(183,196931447,'-27#-98#-102#-26#-73#-68#','','http://q.qlogo.cn/qqapp/1105019688/00F5032E9E1492EB4880DAC7E8545EEC/40','','',0,0,0,0,1460772055),(184,635705309,'-24#-81#-105#-24#-116#-75#32#','','http://wx.qlogo.cn/mmopen/2JtleCHj9r0gr6s8kQqo5U2O7uwZlUwuAUgAqjoQWoUM9CYpK8iapHK0TbLMhHI9vAXias4g0rJjiaBeUJIFpiaTPtQ2Go1brHcj/0','','',0,0,0,0,1460949592),(185,681232735,'-25#-85#-91#-24#-81#-102#-24#-128#-123#','','http://139.196.172.208/qm/files/user/36/68/91/63/681232735/1460950309.jpg','','',0,0,0,0,1460950309),(186,169152832,'-27#-116#-123#-26#-75#-73#-26#-66#-100#','','http://139.196.172.208/qm/files/user/65/82/75/c8/169152832/1460972391.jpg','','',0,0,0,0,1460972406),(187,751423359,'77#101#110#103#83#104#117#97#110#103#74#105#101#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1NOcicLLVeB1l9NPj43UpicGe6GuEQUib4O4VMStiaXOAb3bvK9CyP8FzmCLoP3RqL382ba4SU2xyLfwClyCvCWXWjic/0','','',0,0,0,0,1460973298),(188,845577820,'-28#-71#-106#-27#-82#-99#-27#-82#-99#','','http://139.196.172.208/qm/files/user/cf/f7/0d/26/845577820/1460974047.jpg','','',0,0,0,0,1460974074),(189,506624790,'-27#-113#-85#-26#-128#-99#-27#-65#-75#-28#-72#-115#-24#-90#-127#-27#-112#-75#46#','','http://139.196.172.208/qm/files/user/5d/3a/87/f4/506624790/1460974525.jpg','','',0,0,0,0,1460974525),(190,776809621,'32#-27#-73#-90#-26#-77#-94#-28#-72#-104#-26#-104#-109#-25#-125#-97#','','http://139.196.172.208/qm/files/user/32/f7/c8/8e/776809621/1461044849.jpg','','',0,0,0,0,1461044849),(191,5934398,'-23#-128#-119#-26#-117#-87#-25#-114#-87#-27#-92#-97#-25#-120#-79#-25#-102#-124#-28#-70#-70#','','http://139.196.172.208/qm/files/user/85/0f/15/f9/5934398/1461047297.jpg','','',0,0,0,0,1461047297),(192,305222015,'-26#-116#-67#-26#-119#-117#-27#-113#-103#-26#-105#-89#','','http://139.196.172.208/qm/files/user/74/98/2e/48/305222015/1461047995.jpg','','',0,0,0,0,1461048033),(193,258277174,'-28#-70#-78#-26#-80#-76#-30#-103#-113#-17#-72#-113#-28#-72#-128#-26#-96#-73#-25#-102#-124#-27#-91#-77#-28#-70#-70#','','http://139.196.172.208/qm/files/user/0c/42/33/32/258277174/1461048690.jpg','','',0,0,0,0,1461048690),(194,371875422,'-16#-97#-110#-94#-27#-81#-126#-16#-97#-110#-94#-27#-81#-98#-16#-97#-110#-94#-25#-83#-119#-16#-97#-110#-94#-26#-126#-90#-16#-97#-110#-94#','','http://139.196.172.208/qm/files/user/f4/d8/15/d8/371875422/1461049726.jpg','','',0,0,0,0,1461049726),(195,328560380,'-24#-108#-95#-26#-79#-112#-27#-90#-92#','','http://139.196.172.208/qm/files/user/35/13/35/81/328560380/1461053838.jpg','','',0,0,0,0,1461053838),(196,627078701,'32#70#97#110#74#105#110#103#-26#-73#-68#','','http://139.196.172.208/qm/files/user/2b/ec/ed/a3/627078701/1461056147.jpg','','',0,0,0,0,1461056147),(197,208456024,'-23#-69#-124#-28#-72#-121#-25#-70#-94#','','http://139.196.172.208/qm/files/user/21/87/95/17/208456024/1461056931.jpg','','',0,0,0,0,1461056931),(198,525100226,'-27#-85#-111#-24#-75#-80#','','http://139.196.172.208/qm/files/user/78/32/35/a1/525100226/1461057967.jpg','','',0,0,0,0,1461057967),(199,396406924,'32#-25#-69#-127#-27#-65#-122#-25#-127#-75#','','http://139.196.172.208/qm/files/user/2b/03/36/ed/396406924/1461058879.jpg','','',0,0,0,0,1461058879),(200,325324811,'-27#-122#-81#-28#-66#-99#-28#-66#-99#','','http://139.196.172.208/qm/files/user/65/a4/9b/5f/325324811/1461059435.jpg','','',0,0,0,0,1461059443),(201,936484204,'32#-27#-93#-71#-26#-97#-110#-26#-97#-110#','','http://139.196.172.208/qm/files/user/f3/67/0b/1e/936484204/1461061554.jpg','','',0,0,0,0,1461061554),(202,990318397,'98#98#98#98#98#','15201324657','http://139.196.172.208/qm/files/user/0d/29/cd/d1/990318397/1461235891.png','1994-1-1','111111',0,0,0,0,1461235891),(203,508356011,'-27#-80#-113#-27#-100#-122#','','http://139.196.172.208/qm/files/user/bd/bb/01/91/508356011/1461374415.jpg','','',0,0,0,0,1461374415),(204,851956124,'-23#-104#-65#-23#-101#-81#-27#-116#-105#-23#-68#-69#-30#-100#-116#','','http://q.qlogo.cn/qqapp/1105019688/302AC063A536F93420FD6D3C983699B2/40','','',0,0,0,0,1461565817),(205,307886085,'83#105#110#103#','','http://q.qlogo.cn/qqapp/1105019688/0A75B3896FE47D0A7FAE09E6C98A5A20/40','','',0,0,0,0,1461832924),(206,119031969,'-27#-109#-120#-27#-109#-120#','13731726411','','1999-9-20','121314',0,0,0,0,1462026147),(207,857837775,'46#','','http://wx.qlogo.cn/mmopen/Q3auHgzwzM6j5bFzJZlK3rQCqjvClT6YhtH61bBMJ2m9VOpHVTQkL1IJH9Vjsrnicbjk8QTzAficUKOWF2hia4JIg/0','','',0,0,0,0,1462431997),(208,592063304,'-25#-91#-98#-25#-102#-124#-27#-83#-87#-27#-83#-112#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d6iaWX00u7OR19Uv1diaASmt9dY4b7AibNL2iaf4oeXoMXT30wkGxoSNhrATrwLWLIXvcPAyugNMxcRHHnwPibQOwdMc/0','','',0,0,0,0,1462442345),(209,446570849,'-25#-76#-85#-24#-117#-113#-23#-90#-103#-24#-115#-119#','','http://q.qlogo.cn/qqapp/1105019688/E2A29EDC63B284B8A78A9513A45B49FF/40','','',0,0,0,0,1462442371),(210,812249209,'-25#-68#-104#-26#-94#-90#','','http://q.qlogo.cn/qqapp/1105019688/7A85618A910524D97B71FE1450E3692F/40','','',0,0,0,0,1462722501),(211,572481468,'-26#-99#-100#-27#-122#-80#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSWSLTaOLPtuoSoft39DCo8uGuhC4xiaUrcdjBicGthCMkJpLRHQkqicdiaib7v3lwIoy8H0IDKBUnkntxmR4kGMaSTBa/0','','',0,0,0,0,1462850316),(212,367869129,'-29#-125#-123#-26#-100#-85#-26#-105#-91#-26#-120#-112#-26#-84#-94#','','http://q.qlogo.cn/qqapp/1105019688/AA04FB6885BBD2CEFA3FACCE697BEF92/40','','',0,0,0,0,1462850400),(213,845264618,'230#136#145#229#143#171#229#146#154#229#146#154#230#158#170#','13521948502','','1990-1-1','111111',0,0,0,0,1462950774),(214,620182549,'-24#-111#-93#-24#-111#-93#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaEI1QrfzFBPeqRVGiaAXIl8f1hE6lsQj667FEK6s27syZRQFfJetXx0xlIsdMpka8syDkQkSBaib69ng/0','','',0,0,0,0,1462954095),(215,269684467,'-30#-107#-80#-25#-108#-100#-24#-88#-128#-24#-100#-100#-24#-81#-83#-27#-113#-86#-26#-100#-119#-28#-67#-96#-25#-69#-103#-26#-120#-111#-24#-81#-76#','','http://q.qlogo.cn/qqapp/1105019688/8F78B10A5A5CA646CCCCDED0DBE1C76B/40','','',0,0,0,0,1463299670),(216,170329202,'-25#-84#-111#-27#-81#-71#-28#-70#-70#-25#-108#-97#-17#-68#-127#','','http://wx.qlogo.cn/mmopen/kiaXicXJs2M4dibwQG6KkLxx4LliageIUOWsWFSDxc8r2uOSS98CVE8BicM5sYib3bS0QSW00UyMA0QnLicQgic1GfDibFp4GZ8jticz1t/0','','',0,0,0,0,1463390908),(217,753985972,'-26#-99#-114#-27#-88#-100#','','http://q.qlogo.cn/qqapp/1105019688/BF62913147A1FFE51AB22D37776E6A32/40','','',0,0,0,0,1463465711),(218,903222122,'-27#-126#-123#-28#-68#-97#-25#-70#-81#-17#-68#-120#112#117#114#101#-17#-68#-119#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSXibF4aWhs007ZMRkCkKHvkvhKq18aMhiagxlhAiclrjgLqaO8oCTvJ0q6cKI1GYDXG6Mc2V2fiaFL6LT9fdhEBVQNib/0','','',0,0,0,0,1464155783),(219,182796032,'-25#-67#-105#-26#-126#-97#-26#-101#-78#-26#-119#-114#','15084676789','','1975-6-16','120226',0,0,0,0,1464267054),(220,849251460,'-25#-70#-75#-27#-107#-122#-27#-92#-87#-28#-72#-117#-24#-65#-112#-24#-112#-91#-28#-72#-69#-25#-82#-95#-28#-67#-97#-27#-92#-89#-26#-79#-97#','','http://wx.qlogo.cn/mmopen/kiaXicXJs2M4cpd0v5e6tFPmlh01XQ0yjV37wovHwo529WoHXoASw8h1B1yibrLxNdXYmM4ltGOPibLoOzPXYxb1tQ/0','','',0,0,0,0,1464306960),(221,931055416,'-27#-80#-113#-25#-68#-106#','15045057565','','1990-1-20','123456',0,0,0,0,1464308388),(222,300771575,'-27#-110#-116#-27#-80#-102#-17#-68#-97#-27#-85#-127#-28#-70#-70#-28#-70#-122#','15010809559','http://q.qlogo.cn/qqapp/1105019688/406E769FE71F74DA934A370E5611CD2B/40','','',0,0,0,0,1464322278),(223,144055341,'-27#-122#-115#-25#-66#-114#-25#-102#-124#-26#-101#-66#-25#-69#-113#-29#-128#-127#-26#-120#-111#-27#-113#-86#-24#-125#-67#-27#-101#-98#-27#-65#-122#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaEKVJgHuX6WSiba5ScTaLnalNiajdyQRM3dOic9w5X3baBnN1YMhnEfBpn23roPbBWmIUfAoavYnN5ERw/0','','',0,0,0,0,1464422684),(224,229788895,'-17#-72#-74#-29#-124#-93#-24#-90#-86#-27#-103#-81#-29#-128#-127#-29#-127#-82#32#','','http://q.qlogo.cn/qqapp/1105019688/2DE6AE8AA991986D9EB00E90454F568F/40','','',0,0,0,0,1464445358),(225,292013660,'-29#-127#-127#-26#-106#-83#-23#-83#-126#-17#-65#-91#-25#-75#-82#-29#-127#-126#','','http://q.qlogo.cn/qqapp/1105019688/40F868249DBD457DA1E6262079759955/40','','',0,0,0,0,1464487394),(226,275116302,'-25#-96#-76#-26#-93#-117#-28#-70#-70#','15072384004','','1994-11-10','yemao5201314',0,0,0,0,1464509845),(227,387347220,'-27#-121#-119#-26#-125#-123#-27#-121#-119#-27#-65#-125#-27#-89#-111#-27#-88#-104#-25#-103#-66#-26#-81#-110#-28#-72#-115#-28#-66#-75#-17#-68#-122#','','http://q.qlogo.cn/qqapp/1105019688/147A1EDA1ABDB13F49C28ABAD2D58601/40','','',0,0,0,0,1465109023),(228,305465608,'65#-27#-115#-118#-27#-92#-100#-26#-94#-90#-24#-89#-127#-28#-67#-96#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSWGxIJWibdru2RktDtBTVzsea4V84Ko0ibE7GEbf4cDUuEVCr7fCl18o2cgyia3ibr8Qavpk1nc2Ay4fkaic8g7s31ibX/0','','',0,0,0,0,1465129959),(229,799917478,'119#104#97#116#32#32#32#32#32#121#101#108#108#111#119#63#','','http://q.qlogo.cn/qqapp/1105019688/B8D0F8CE822C817E7E34DEBF7FE62690/40','','',0,0,0,0,1465379348),(230,435496725,'-27#-92#-87#-23#-85#-104#-27#-67#-79#-24#-89#-122#-24#-128#-127#-25#-114#-117#32#','','http://q.qlogo.cn/qqapp/1105019688/6487451CA9CC531C924419266F5C1995/40','','',0,0,0,0,1465518528),(231,581125662,'-28#-65#-105#-28#-70#-122#-26#-72#-123#-23#-93#-114#','','http://q.qlogo.cn/qqapp/1105019688/9BCEBC42C86980D14139248C5F370417/40','1998-10-15','',23,251,0,0,1466054550),(232,968527806,'-17#-68#-122#-27#-121#-81#-26#-77#-67#-23#-111#-85#-17#-68#-122#','15804661345','http://q.qlogo.cn/qqapp/1105019688/7361989D761146E5171D9CB1BD134273/40','','',0,0,0,0,1466062372),(233,836100466,'70#-28#-70#-108#-25#-90#-113#-28#-72#-76#-23#-105#-88#','','http://q.qlogo.cn/qqapp/1105019688/E6325B293D8EA31E60F22F5033FF2037/40','','',0,0,0,0,1466060516),(234,11266728,'107#117#100#105#101#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSWUT5NlbF3GWpSN3oibqple9V9JEt2Xw3faItkyLTf8AT1PdgzNKAOzPRE56XyuqyTEqUNvLJma3ljszdPFY75en/0','','',0,0,0,0,1466185396),(235,407517990,'-26#-72#-87#-26#-97#-108#-24#-125#-116#-27#-112#-114#-25#-102#-124#-28#-68#-92#-25#-105#-101#','','http://q.qlogo.cn/qqapp/1105019688/EC67532528BC8D9D60D67BAC5A907BCB/40','','',0,0,0,0,1466225168),(236,216284719,'-28#-72#-83#-24#-123#-66#-28#-65#-95#-27#-113#-116#-27#-113#-116#49#53#54#48#48#48#54#48#52#49#48#','','http://wx.qlogo.cn/mmopen/kiaXicXJs2M4dvpuOlx7AdasbYRibU1t0NuEVCe0C89KcibazGsfSUdGY1xwcia3EWdEttchG5Qr9JOKXr4X2kxLFiauGF1C4E1HgO/0','','',0,0,0,0,1466414941),(237,211377831,'-26#-99#-91#-27#-110#-81#','13273661940','','2016-6-22','123456',0,0,0,0,1466584259),(238,945521464,'-23#-126#-79#-27#-92#-87#-27#-92#-87#','','http://wx.qlogo.cn/mmopen/m13T2pczibhZYYSgT5jSG2FT7z8rrTLtOuKSecHyrHWznu9OxHT2U21WBcJG0OtdcaXU1ibBdv0licAwCQTGSQxpX7KIic7dWejf/0','','',0,0,0,0,1466606516),(239,823738172,'-28#-68#-92#-28#-72#-115#-24#-75#-73#','','http://q.qlogo.cn/qqapp/1105019688/4162246DE8887744579B4FDAE76DAB71/40','','',0,0,0,0,1466736863),(240,548526182,'-26#-73#-95#-27#-82#-102#','','http://q.qlogo.cn/qqapp/1105019688/C221011F15317600DE3DBCDE761B6DF9/40','','',0,0,0,0,1466826179),(241,701096263,'-27#-109#-127#-28#-67#-115#32#32#32#32#-28#-70#-70#-25#-108#-97#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1MD27Tadj6Pwibg6UVcSsF2YyG5DIicUSDQmibvSvVYicpicBUHagGicElHtyyDPicyv7qzX43qBic9ib3rqBh6fBYleBYAB/0','','',0,0,0,0,1467444603),(242,59378330,'65#43#-24#-114#-79#-26#-126#-90#86#-26#-107#-76#-27#-67#-94#-26#-99#-88#-27#-116#-69#-25#-108#-97#49#53#56#48#55#49#50#51#52#55#56#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaELsaaCYhJibTLw1OP72o20X3SK39ky4mmo5u9L7g0LJjggemtoxpKdYldH93BMpms3dYm7HgX4DN8A/0','','',0,0,0,0,1467853944),(243,901690321,'-27#-80#-113#-25#-66#-114#-27#-91#-77#','','http://139.196.172.208/qm/files/user/ea/ed/53/98/901690321/1468027782.jpg','2016-7-9','',0,0,2,0,1468027782),(244,187018269,'-24#-114#-79#-26#-126#-90#-27#-66#-82#-25#-66#-114#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaELiaemYbd7S7aVdBf6u9anoTbLcTAobiaE8WcbxrBnK21xq9cTFbLiaZk6siaNicRhN9D785F9sicm5nAvA/0','','',0,0,0,0,1468162203),(245,488826915,'-25#-114#-117#-24#-119#-77#-27#-96#-126#-17#-68#-116#-27#-124#-65#-25#-85#-91#-27#-67#-79#-24#-89#-122#-24#-118#-126#-25#-101#-82#-26#-76#-69#-27#-118#-88#','','http://wx.qlogo.cn/mmopen/U2Lc5YKdq1NS988iaUzmsKJEHSbTHcYKOodztR2ia27HTUNRUG0Z3bFgzPT1Ec7qPbBKv3mqhvOdADqHU4UxbMthY3gvbm00q0/0','','',0,0,0,0,1468972325),(246,398846095,'76#76#','15623091676','','1994-9-7','992836005suj',0,0,0,0,1469007626),(247,216394723,'-27#-92#-89#32#32#32#32#32#98#111#115#115#','','http://q.qlogo.cn/qqapp/1105019688/D9FB789BD58E249B3033322298A275F8/40','','',0,0,0,0,1469084540),(248,482984949,'113#105#110#103#-24#-101#-117#-27#-124#-65#','13620639870','','2016-7-23','521521',0,0,0,0,1469272170),(249,787747603,'-26#-95#-109#-26#-95#-109#','15827044438','http://q.qlogo.cn/qqapp/1105019688/DF9ED20BB8985C3DF4971FD9E5EA39C9/40','','',0,0,0,0,1469347381),(250,992902128,'-25#-79#-77#-25#-85#-117#','13986107980','','1982-1-1','Believe8',0,0,0,0,1469348118),(251,747892041,'230#136#145#229#143#171#229#146#154#229#146#154#230#158#170#','','http://q.qlogo.cn/qqapp/1105019688/7364F498A7A2525370B7746D51204EAF/40','','',0,0,0,0,1469588968),(252,737426174,'-27#-115#-65#-26#-100#-84#-28#-67#-77#-28#-70#-70#','','http://wx.qlogo.cn/mmopen/PiajxSqBRaELibMrqcQ8CFo6a8TMKMVkKbUfLMq3VV7IZicjewdbmZ3iaLwelwm6Jbgws0tEYF0f4TzkSFpbXPDlTg/0','','',0,0,0,0,1469614503),(253,854364106,'100#111#110#103#110#105#','13661303856','','2016-7-29','123456',0,0,0,0,1469790420),(254,240291002,'-27#-120#-104#-26#-103#-88#-27#-123#-119#','18171451387','http://139.196.172.208/qm/files/user/5a/8b/05/8a/240291002/1469864361.jpg','1994-2-12','18171451387',17,177,1,0,1469864375),(255,69401108,'98#108#101#110#100#101#100#32#-62#-80#47#-26#-98#-100#-26#-98#-100#32#-62#-80#','','http://q.qlogo.cn/qqapp/1105019688/A255646591D8AE6376601F93E06C4E46/40','','',0,0,0,0,1470173606),(256,530964673,'-30#-124#-95#-27#-94#-88#-27#-97#-114#-26#-97#-77#-25#-125#-97#-26#-105#-96#-28#-70#-70#-26#-82#-121#-29#-125#-97#','','http://q.qlogo.cn/qqapp/1105019688/01A33D0C146B9FE5D0B3F1F3BD2D48E6/40','','',0,0,0,0,1470223464),(257,139546418,'-27#-71#-77#-27#-82#-119#-26#-104#-81#-25#-90#-113#32#-18#-108#-88#','','http://wx.qlogo.cn/mmopen/f0lbTtEzTSWSLTaOLPtuoX9F18Mk2HXf9sBOZgsEGYy9fHuHM9WATialA7gerHqibmYsaDBjrORuyU0KnmHf4iaDqKSljXGXCiaA/0','','',0,0,0,0,1470870654),(258,526235999,'-18#-116#-87#121#111#-28#-68#-104#-28#-68#-104#126#-27#-116#-69#-25#-66#-114#-18#-116#-89#-18#-116#-99#','','http://wx.qlogo.cn/mmopen/AFGdGJDl9d7VfTxPyR2chxnJZcrciaAn6cssw4ABwaMQNgKEl81P7uick6b0Edvyqrkv6cER5J8t67bogSuuOaf3NEyxycUskP/0','','',0,0,0,0,1470917002),(259,890058328,'-23#-104#-65#-25#-102#-124#-23#-104#-65#-25#-107#-103#','','http://q.qlogo.cn/qqapp/1105019688/8820CC53596B38BEBE3E100404A24181/40','','',0,0,0,0,1471175277),(260,319813105,'-27#-101#-67#-23#-103#-123#-27#-116#-69#-25#-66#-114#','','http://q.qlogo.cn/qqapp/1105019688/F67199205E95942A5C4BD3A5D40E19FD/40','','',0,0,0,0,1471329488);
/*!40000 ALTER TABLE `qm_users_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_users_dsf`
--

DROP TABLE IF EXISTS `qm_users_dsf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_users_dsf` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(9) unsigned NOT NULL,
  `openid` varchar(255) NOT NULL,
  `type` tinyint(1) unsigned NOT NULL COMMENT '1微信，2微博，3QQ',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='第三方openid与用户userid关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_users_dsf`
--

LOCK TABLES `qm_users_dsf` WRITE;
/*!40000 ALTER TABLE `qm_users_dsf` DISABLE KEYS */;
INSERT INTO `qm_users_dsf` VALUES (20,510739473,'5BB6E311662E88A173432BEB4FC99003',3,1448887082),(21,990758369,'2236B30B7F7EB3678E13E3794AF139CB',3,1448929526),(22,336145299,'of6yhs46L8eFVC3TwfgcqNLQPfkY',1,1448929672),(23,23869354,'2990908177',2,1448931039),(24,848109072,'DFCC865030FB23BA2D62C55000D270FB',3,1448935952),(25,304721101,'of6yhs1tWdllbZPwArSjINTKpKQ8',1,1448938665),(26,157186697,'2984274385',2,1449911580),(27,387195170,'of6yhs3vyGqo4Ere57xgFBLWJT5s',1,1450084116),(28,473085438,'of6yhsw0mvmE_AXa3kmdEWYoYHok',1,1450085733),(29,12279597,'52928A6F729DE6EC4CFE0C081B4878C3',3,1450088334),(30,681558568,'odbqQtxd8EWvCGxmTr3C46_XIAoE',1,1450676212),(31,607552052,'odbqQtwH4_W3idi5_JjgYb57ce34',1,1450693052),(32,465386648,'odbqQt7SGAVXY_oSP57wAG3n3BWA',1,1450693727),(33,707440055,'odbqQtzvfcdwVMMMO7exVzJobmBk',1,1450693778),(34,250827191,'of6yhs2FBsyu_jW3E6cQtNNYo8yw',1,1450693893),(35,559391868,'8B141529A28D7F126635E51A6B1ADED3',3,1450928126),(36,9946058,'odbqQtwhHFmEy4TmscYw82dNm5-o',1,1452849054),(37,306367496,'odbqQty6qO5WoGI1mCaTynqJGWvY',1,1453643793),(38,845393722,'odbqQty4_LVNz9D3yaW6la60lE2I',1,1454131085),(39,518396413,'odbqQt6mLAr5q8UmfT5RV4dLmcFI',1,1454292137),(40,249091022,'odbqQt6ILYild9DGKFzCREveT3p4',1,1456403542),(41,380934770,'odbqQt1gSUlQCmW0bsapZ8QAZuM4',1,1456801091),(42,394358564,'odbqQt-KAHS1tIpHuTTUgLCvLxc0',1,1458616813),(43,574987582,'odbqQt9DhGL1HkQ7WuClLiDW9dgE',1,1458786214),(44,669091325,'odbqQt8vQnREc_nT9HRatFQC1PFM',1,1459513592),(45,321108478,'odbqQtyglHUCC-ir7UYXtFT2wPl0',1,1459513677),(46,822642142,'odbqQt172egcPdodqNwCmW8IKV_w',1,1459515422),(47,988107387,'odbqQt9SxuGRzDd3Uz8tTv2XQqyM',1,1459826548),(48,315787180,'odbqQt0AngSLjQbDgPwK98jLNIOU',1,1459840286),(49,59977127,'odbqQt6FoXA1XgcifDBCq8z773yk',1,1459842354),(50,832745935,'odbqQt3gD6DMLrRmGnoBnR7vFhfY',1,1459844143),(51,726176698,'odbqQt9ASajohkOSrHQWEC7rP-Vk',1,1459856454),(52,17992305,'A97CAD279145E35655AEA1F8AC22065C',3,1459938147),(53,214766593,'533231A3C8F9FA94F86F0F2D11E77C65',3,1459944570),(54,64707944,'7E4703C8765C2FEE47AF53600B0A3712',3,1459944936),(55,472888401,'5E2B7B8A0746503D1A28EBE432766007',3,1459945206),(56,318118360,'31B4F566C73D7B4D3520C6A6A6D7A219',3,1459945627),(57,249273711,'29361F4F85CF5A6ED9B4B05FE265B8AF',3,1459945963),(58,272381300,'161E19ED08B2BA530333BA161E0B1EB3',3,1459946274),(59,263910545,'7A8E7384517DB7D075D84FEA404FDA25',3,1459946624),(60,491763369,'D659A11DE0E5BF7256986219FD093F24',3,1459947503),(61,202834502,'C034C7E397CF25B13FCE9E68706C610B',3,1459987121),(62,796741246,'9DEDDAFB2EA0C0C9EBAD673C1C76E5EF',3,1459993780),(63,676262791,'FB8806DEB87CB4D2C47AE4D9AD61DA22',3,1459995195),(64,337271199,'1B44B4C963CEE760E850C66FB75C50FB',3,1459995560),(65,198420087,'588A3403338B474EAC0777B29AC616E7',3,1459996206),(66,76361086,'EFA1CCBDD4F4730ECE01F83AD0A0858E',3,1459996782),(67,131400393,'BBFC1ACA109243B47E4DF9AB6DCC63ED',3,1459997133),(68,522278120,'787A3B2A97AAF34FA55B0D00697A0330',3,1459997706),(69,509271164,'EAC8D0218DAC5F317F5033BF78F314AB',3,1459998377),(70,658098270,'4A73D74B7B20000BC27546F0710E6047',3,1459999670),(71,414879352,'B507CB82DB5692B32FF79F4DBADD7F32',3,1460001122),(72,609265170,'B0096DEBF445D8644B705E1B0E07AF8B',3,1460003099),(73,650451367,'BF11436743411A960A268D4C404ADBCC',3,1460007486),(74,832661816,'6F1EE98B4FF9C44B4AA23296723B3816',3,1460008856),(75,959640217,'9B4FDBCA2E3050F337E0110583D25B5A',3,1460009267),(76,565255803,'F865946A8A38BA11CC51470008843BEE',3,1460009648),(77,37300233,'28E0C92D7665D87893B649DCBA863D2A',3,1460010069),(78,405486436,'BA6FECBE6089D5FDF8CBE19BAB8C9DCF',3,1460015277),(79,812456945,'DA24F62121533DB0ABB172F03D97BA5E',3,1460015702),(80,1963104,'9D8B95B5C48CD7026C72E5985FE51C98',3,1460016010),(81,366210955,'EC6215B77B0B859868859F161CA99DCC',3,1460016152),(82,643069036,'1FF8E446F3980A69DE880A73568D9BC7',3,1460016336),(83,686278701,'EECFDB00CC9115528044ED360BDD46A0',3,1460016585),(84,13707127,'5BFF1D3CC723181E22A237DA3675E0CE',3,1460016607),(85,727203889,'FB605985CA704E3B85BA6BCD739AF05B',3,1460016801),(86,221058264,'07F96DC1C2AB8F1BD6493D48340C6965',3,1460017023),(87,746448119,'D0C17346EA424D5C21FEA7588F9007C8',3,1460077972),(88,321570634,'0CD6C4A1D8E820A07B3B964E9C18396B',3,1460080402),(89,714135518,'D73AC6F886B8B066FABDB96E70FC08FB',3,1460081305),(90,385056803,'819A1A4FD79647DE84A3E03A3188FFC4',3,1460081955),(91,555118827,'358C270F719E339C7BE472F8645DDB02',3,1460082385),(92,499427849,'odbqQt0F7C2Sgh7vtYSmm_n_OHf0',1,1460084038),(93,489140974,'odbqQt3bBWvRznZSz7bSvLitPSTQ',1,1460099058),(94,126150972,'odbqQt0vJMupObEWF6J9eH12ccw4',1,1460099706),(95,903411317,'24B75E69F44DB4BCCADFD774F00446EA',3,1460114009),(96,694890651,'E63606D267EE7D6CABA8A5116F350523',3,1460117796),(97,856636367,'3433ECC79CB6F8A2B5001C43B554170F',3,1460163781),(98,274456814,'63BE88D590DB34682C11970762F4C4C1',3,1460165482),(99,320311975,'64081A15AF53686A9095BE265A35DA2F',3,1460173166),(100,376303575,'2ABF07F1D76341F36AE3D1A412D2DB94',3,1460174250),(101,601793228,'F217E42D97C01277146DF42144C28871',3,1460175096),(102,248243140,'C44D932C0037911B0E3B097E86D10C35',3,1460176368),(103,521203221,'D30DF847F6CE86DEC72B33ECFD4C1583',3,1460188809),(104,591582862,'0412E6B129042A495F24E13C8DC6F932',3,1460190073),(105,116975794,'BF055D4ADC55BF7CB6A1672BDC4D5D1F',3,1460190710),(106,576635203,'EAA094D782550EBBC2391B7596182179',3,1460192077),(107,231324474,'9ED631B52AADA0520F420D4E45A85B24',3,1460192696),(108,767719481,'85C1FB0A93E6A3E0861435BB62AE46F2',3,1460220679),(109,628399798,'odbqQt4W9SL3CxgLalvnVBg-RrVI',1,1460337613),(110,553589499,'odbqQt1Awa2YjVirH9xacl1r0U_Y',1,1460338508),(111,871524759,'odbqQt_oXMs-eTdUvSI9rO63Ju9U',1,1460339208),(112,530457734,'odbqQtwKxoZpMNwm7WEwsMInga2E',1,1460339645),(113,680892692,'odbqQt1m-vBk1B7-zs7RSL3zy6c8',1,1460339834),(114,609419201,'odbqQt26gtTRjT6B_EZdCghLKEp8',1,1460340514),(115,592618647,'odbqQt6VLZYp7ossm2F8_OsixSaE',1,1460341425),(116,700944948,'odbqQt-KdJxJQ2NaAQg87j6tKTiQ',1,1460342619),(117,378136472,'odbqQt-RE2MmJc2Z_KD3_G2kQrtk',1,1460343116),(118,60073566,'odbqQtx0pVMH8WnEcrTeuqjy_wOE',1,1460343409),(119,402902455,'odbqQt1tGY7QltvE5UfLKO53j3tM',1,1460356121),(120,477390991,'odbqQt7seaLA-K2QzDYTpBTQXeRs',1,1460356418),(121,456848930,'odbqQt_pFD3ums4MXVZHPQRp8yag',1,1460357606),(122,556914415,'odbqQt8MXLObeXP7MA9QfRm0merM',1,1460358188),(123,335274654,'odbqQtzY50ENBhZ9DDiWXIgzcCek',1,1460358682),(124,779692121,'odbqQtze3zUtz7Apo4u_k1VH8aJo',1,1460359778),(125,956863590,'odbqQt0Yu8BACtwpUxqPi4WpyCxs',1,1460360559),(126,320295814,'odbqQt4BBMmKduPicu8HSzRNl9rc',1,1460424744),(127,743789845,'odbqQt9g6-OPOjdTw91nip9Zf1ZI',1,1460425610),(128,243326844,'odbqQt7gbYHgxzTZW-jYU2TVCkUg',1,1460425959),(129,292865815,'odbqQtxjYheHNNUxbK876NqX4_dM',1,1460426250),(130,872371930,'odbqQt-JSfICR12L0H6xe2qZA38o',1,1460426471),(131,416130344,'odbqQt76rHHyxMztzCrt9U-FfiGg',1,1460427539),(132,787824779,'odbqQt9YLzG51aivaSOkiDaZZ6Iw',1,1460427940),(133,399623422,'odbqQt2LVJb3IBavIHLu6bqxASR8',1,1460428258),(134,203737511,'odbqQt1DVKF8kKp2VRiQ_NnFGpZA',1,1460428708),(135,306862977,'odbqQt_rpx-VJLUUcgrJWLKTat5Y',1,1460620188),(136,830600666,'odbqQt37JK7pYE65Kgx3rr94rk7Y',1,1460620651),(137,120829343,'odbqQt2w4Gbau1O5fizcxE4ER1SI',1,1460622545),(138,312461138,'odbqQt6OQNcQkLgb1jOKKbSBNaPg',1,1460623629),(139,973796455,'odbqQt9nMRx8_RR_oFXNEBKP3CwU',1,1460683339),(140,313931150,'odbqQt6qQOtdHLfubx6_02VTFPkc',1,1460684329),(141,322865809,'odbqQt5OGc_K0Kiu4pZWEPJ_Dq48',1,1460684932),(142,266364564,'odbqQtwBgfNNcn0739oAx4JMmmuQ',1,1460685742),(143,270500510,'odbqQt01qVgI6qGY87PeOmN2p7fo',1,1460686237),(144,440925575,'odbqQt9FBUbBoJMH8IPZ0CGvcOY0',1,1460686620),(145,754322357,'odbqQt_feLBs-9btfT2I6TNsTncE',1,1460686901),(146,566472386,'odbqQt9zVRiF0A61m7SueQal8Su8',1,1460687223),(147,65983657,'odbqQtwtBu2qS5eXsNUBMziwXZwM',1,1460687763),(148,541104368,'odbqQtxhfm9r0n-BYRMMl2vTZ_Bw',1,1460687951),(149,721000785,'odbqQt3lB-ipnLzwqZiiZOXhVIy8',1,1460702753),(150,583752415,'odbqQt_9Wc2Y_bYnhI45_lj7iJ-w',1,1460703121),(151,563450421,'odbqQt8tJPxoocaDTmE-VLKKJtw4',1,1460703530),(152,928188059,'odbqQtyCT89CvJCcNkLx-MlWOt3A',1,1460703851),(153,217256685,'odbqQt5YPo767QOfF2tlgll2xqag',1,1460704868),(154,843369688,'odbqQt_cJJB9Ja9FbjrJNlrwgsBM',1,1460705992),(155,512140113,'odbqQtwZmKsNz8q0oLrwHnpbqVco',1,1460707334),(156,48025602,'odbqQt3OnefGTtq9Wg6l3_EKHlBM',1,1460708731),(157,934893010,'odbqQt0UvaeLPdGw8CLXL-gePfcQ',1,1460710040),(158,921249596,'odbqQtwuVI_BztMmIBxqDZjNpJL8',1,1460710492),(159,42511265,'odbqQtyA6lV41hReRjXoWbxweXIk',1,1460712522),(160,6570781,'odbqQt9s9f5ZWRFMNAoiFKh8ywdU',1,1460716554),(161,846649983,'odbqQt3yA9qpEZUvNEOrNMKx8-nc',1,1460717117),(162,960991456,'odbqQtzfXMceeESzfIQi-PclyfXs',1,1460719484),(163,196931447,'00F5032E9E1492EB4880DAC7E8545EEC',3,1460772055),(164,635705309,'odbqQt7-WDrtY1JXcyLxgtH-nK_o',1,1460949592),(165,681232735,'odbqQt9LUb73EJSe_VNSb1H3A7i0',1,1460950256),(166,169152832,'odbqQt-VNMEPluIPECqsFlDDAEe8',1,1460971851),(167,751423359,'odbqQtzKh8lYGJ0h7swe6c6FDiPE',1,1460973298),(168,845577820,'odbqQt7y4pYpH_S01lFTIVMgWTMk',1,1460973983),(169,506624790,'odbqQt8wYvjexHKobR4XIenDEyXQ',1,1460974509),(170,776809621,'odbqQt_gXDb5ExGCuRD9ryOUJHmA',1,1461044716),(171,5934398,'odbqQt6cCY7ZzXSiFZvyLk1zeYUc',1,1461047263),(172,305222015,'odbqQt22dfUX3TMfrwTaOcBgmIC8',1,1461047922),(173,258277174,'odbqQt1BfrZbFcmezZ24_NSpwZ5U',1,1461048659),(174,371875422,'odbqQt_RvoHdb6NzVkIIGZeHrsLY',1,1461049678),(175,328560380,'odbqQt4CkNZpjyhS-tToheI2zwGM',1,1461053722),(176,627078701,'odbqQt8j5KO8fGeKQSSmpxbEGvEc',1,1461056113),(177,208456024,'odbqQt3-ArjpL-C1w-W4RVQW1_b0',1,1461056897),(178,525100226,'odbqQt8k6c1fWJtulFlDE3-hgPcs',1,1461057947),(179,396406924,'odbqQtxPCXgTmUfFiK3ACNbhFxNM',1,1461058490),(180,325324811,'odbqQt6ZBqEOLCq1LbRx73ScyAr8',1,1461059420),(181,936484204,'odbqQt2v3A3pi6ulKMi0zQzXo4zQ',1,1461061516),(182,508356011,'odbqQt107UzKGbd-5_qwaUcIYsrU',1,1461374389),(183,851956124,'302AC063A536F93420FD6D3C983699B2',3,1461565817),(184,307886085,'0A75B3896FE47D0A7FAE09E6C98A5A20',3,1461832925),(185,857837775,'odbqQt4eh9K5qoHL0ghWCMSgQRyw',1,1462431997),(186,592063304,'odbqQtzdom9qDWpee256tFPBK9gY',1,1462442345),(187,446570849,'E2A29EDC63B284B8A78A9513A45B49FF',3,1462442371),(188,812249209,'7A85618A910524D97B71FE1450E3692F',3,1462722501),(189,572481468,'odbqQt_sG2fPn682SR4TdZQXYs9E',1,1462850316),(190,367869129,'AA04FB6885BBD2CEFA3FACCE697BEF92',3,1462850400),(191,620182549,'odbqQt6EvzS_bCCqwdPtWweIo9LI',1,1462954095),(192,269684467,'8F78B10A5A5CA646CCCCDED0DBE1C76B',3,1463299670),(193,170329202,'odbqQt5Oo8Jk62Fe22f9v7RudHIg',1,1463390908),(194,753985972,'BF62913147A1FFE51AB22D37776E6A32',3,1463465711),(195,903222122,'odbqQt0lOGppinpRvxVSy_9X01io',1,1464155783),(196,849251460,'odbqQt5AbhQd3A8uSt27N1m1kiPA',1,1464306960),(197,300771575,'406E769FE71F74DA934A370E5611CD2B',3,1464322229),(198,144055341,'odbqQt-IUkICElFOqGGbsspj6ANQ',1,1464422684),(199,229788895,'2DE6AE8AA991986D9EB00E90454F568F',3,1464445358),(200,292013660,'40F868249DBD457DA1E6262079759955',3,1464487394),(201,387347220,'147A1EDA1ABDB13F49C28ABAD2D58601',3,1465109023),(202,305465608,'odbqQt0prZA7ilCWp59mGXVfkMPY',1,1465129959),(203,799917478,'B8D0F8CE822C817E7E34DEBF7FE62690',3,1465379348),(204,435496725,'6487451CA9CC531C924419266F5C1995',3,1465518528),(205,581125662,'9BCEBC42C86980D14139248C5F370417',3,1465985728),(206,968527806,'7361989D761146E5171D9CB1BD134273',3,1466059467),(207,836100466,'E6325B293D8EA31E60F22F5033FF2037',3,1466060516),(208,11266728,'odbqQt2nXNuT9k01IojRGp0t8Dl0',1,1466185396),(209,407517990,'EC67532528BC8D9D60D67BAC5A907BCB',3,1466225168),(210,216284719,'odbqQt9D5lPw4oTwQnhqPOQfMGv0',1,1466414941),(211,945521464,'odbqQty-1oo0Fp0kdO2zm4AgvDI8',1,1466606516),(212,823738172,'4162246DE8887744579B4FDAE76DAB71',3,1466736863),(213,548526182,'C221011F15317600DE3DBCDE761B6DF9',3,1466826179),(214,701096263,'odbqQt4nCdhmpfIyYED5r057mm30',1,1467444603),(215,59378330,'odbqQt8nIpw-MG-oNcMI3TyRDxPo',1,1467853944),(216,901690321,'2473DB63EB65D74BD0E16023F7FBAAE0',3,1468027460),(217,187018269,'odbqQt9qdv_awgn3kRrY6GnrvAHU',1,1468162203),(218,488826915,'odbqQt5BxTRRkyQrQ_wMdTtLKD8M',1,1468972325),(219,216394723,'D9FB789BD58E249B3033322298A275F8',3,1469084540),(220,787747603,'DF9ED20BB8985C3DF4971FD9E5EA39C9',3,1469339200),(221,747892041,'7364F498A7A2525370B7746D51204EAF',3,1469588969),(222,737426174,'odbqQt9EpIbu375i0deHcu7ieFgY',1,1469614503),(223,69401108,'A255646591D8AE6376601F93E06C4E46',3,1470173606),(224,530964673,'01A33D0C146B9FE5D0B3F1F3BD2D48E6',3,1470223464),(225,139546418,'odbqQt_BBVNef8nd_Cjixhu10kGk',1,1470870654),(226,526235999,'odbqQt1OyGXzzBSpLhBWIvfhMC-o',1,1470917002),(227,890058328,'8820CC53596B38BEBE3E100404A24181',3,1471175277),(228,319813105,'F67199205E95942A5C4BD3A5D40E19FD',3,1471329488);
/*!40000 ALTER TABLE `qm_users_dsf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_users_login`
--

DROP TABLE IF EXISTS `qm_users_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_users_login` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(9) unsigned NOT NULL,
  `deviceid` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL COMMENT '0æœªç™»å½•ï¼Œ1ç™»å½•',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=473 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Appç”¨æˆ·ç™»å½•è®°å½•è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_users_login`
--

LOCK TABLES `qm_users_login` WRITE;
/*!40000 ALTER TABLE `qm_users_login` DISABLE KEYS */;
INSERT INTO `qm_users_login` VALUES (131,594111915,'863784020521295',0),(132,594111915,'863585020396624',0),(133,389604558,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(134,599677187,'863585020396624',0),(135,599677187,'867570021057942',0),(136,599677187,'862845027751861',0),(137,785251622,'862845027751861',0),(138,990758369,'1f1cd9a88f95bedbf7332e835f238044',0),(139,599677187,'39aa8f4695bdadbd61b836db28b22d5a',0),(140,990758369,'35edbe59e3a94b977eded1ea7d1ced9c',0),(141,988042094,'867570021057942',0),(142,510739473,'862845027751861',0),(143,490878686,'1f1cd9a88f95bedbf7332e835f238044',1),(144,312194323,'865479025110800',1),(145,785251622,'867570021057942',0),(146,785251622,'863784020521295',0),(147,594111915,'862845027751861',0),(148,988042094,'862845027751861',0),(149,988042094,'863585020396624',0),(150,701603161,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(151,594111915,'865418027300829',0),(152,701603161,'266f8221d5bce5046d842786ecd848e8',0),(153,490878686,'39aa8f4695bdadbd61b836db28b22d5a',0),(154,23869354,'35edbe59e3a94b977eded1ea7d1ced9c',0),(155,998962158,'867570021057942',0),(156,746621638,'A0000047F6481B',0),(157,785251622,'863585020396624',0),(158,389604558,'39aa8f4695bdadbd61b836db28b22d5a',0),(159,518383848,'352343051212783',0),(160,336145299,'35edbe59e3a94b977eded1ea7d1ced9c',0),(161,449039907,'35edbe59e3a94b977eded1ea7d1ced9c',0),(162,988042094,'863784020521295',0),(163,449039907,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(164,669103067,'867570021057942',0),(165,490878686,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(166,449039907,'1f1cd9a88f95bedbf7332e835f238044',0),(167,594111915,'867570021057942',0),(168,988042094,'865418027300829',0),(169,599677187,'863784020521295',0),(170,527013189,'865418027300829',1),(171,599677187,'1f1cd9a88f95bedbf7332e835f238044',0),(172,848109072,'863585020396624',1),(173,157186697,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(174,599677187,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(175,599677187,'99000710024911',0),(176,785251622,'99000710024911',1),(177,848109072,'99000710024911',0),(178,599677187,'A0000047F6481B',0),(179,594111915,'99000710024911',0),(180,449039907,'863585020396624',0),(181,387195170,'99000475349410',0),(182,436942141,'352343051212783',0),(183,304721101,'862845027751861',0),(184,473085438,'99000710024911',0),(185,813079450,'862845027751861',0),(186,12279597,'99000710024911',0),(187,449039907,'865714024652851',0),(188,449039907,'862845027751861',0),(189,599677187,'35edbe59e3a94b977eded1ea7d1ced9c',0),(190,594111915,'35edbe59e3a94b977eded1ea7d1ced9c',0),(191,681558568,'862845027751861',0),(192,594111915,'865714024652851',0),(193,607552052,'99000710024911',0),(194,581689868,'866867020107921',0),(195,465386648,'863784020521295',0),(196,707440055,'866867020107921',1),(197,250827191,'35edbe59e3a94b977eded1ea7d1ced9c',0),(198,581689868,'865714024652851',1),(199,559391868,'A0000047F6481B',1),(200,785251622,'865418027300829',0),(201,813079450,'99000710024911',0),(202,813079450,'99000520829085',0),(203,449039907,'99000710024911',0),(204,9946058,'A0000047F6481B',0),(205,306367496,'99000554117439',0),(206,813079450,'863585020396624',0),(207,845393722,'867120020794465',1),(208,518396413,'35edbe59e3a94b977eded1ea7d1ced9c',0),(209,689620122,'35edbe59e3a94b977eded1ea7d1ced9c',0),(210,594111915,'867878020650967',0),(211,12279597,'867878020650967',0),(212,813079450,'867570021057942',1),(213,436942141,'99000714333063',1),(214,248595419,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(215,248595419,'353347060526645',0),(216,436942141,'869634023330612',0),(217,681558568,'867878020650967',0),(218,813079450,'867878020650967',0),(219,449039907,'9c807a98ee390064a4727fb767b99dd0',0),(220,249091022,'99000714333063',0),(221,380934770,'867570021057942',0),(222,887915923,'867496010644088',0),(223,813079450,'35edbe59e3a94b977eded1ea7d1ced9c',0),(224,848109072,'867878020650967',0),(225,449039907,'867878020650967',0),(226,9774154,'99000554117439',1),(227,574593838,'869841024560036',1),(228,813079450,'863784020521295',0),(229,518396413,'8c3c9e5ab0abea99e010d5428d1ba0d8',0),(230,449039907,'8c3c9e5ab0abea99e010d5428d1ba0d8',0),(231,394358564,'35edbe59e3a94b977eded1ea7d1ced9c',0),(232,574987582,'863738028195973',1),(233,594111915,'352562070832079',0),(234,785251622,'867878020650967',0),(235,848109072,'863784020521295',0),(236,501493680,'35734607202381',1),(237,968220660,'864397020248261',0),(238,669091325,'99000714333063',0),(239,321108478,'99000714333063',0),(240,822642142,'868256021689186',1),(241,321108478,'867496010644088',0),(242,988107387,'864397020248261',0),(243,315787180,'867496010644088',0),(244,59977127,'867496010644088',0),(245,946848813,'99000475349410',1),(246,832745935,'867496010644088',0),(247,682875857,'867496010644088',0),(248,726176698,'864397020248261',0),(249,17992305,'867496010644088',0),(250,246667211,'865242024141675',1),(251,214766593,'867496010644088',0),(252,64707944,'867496010644088',0),(253,472888401,'867496010644088',0),(254,318118360,'867496010644088',0),(255,249273711,'867496010644088',0),(256,272381300,'867496010644088',0),(257,263910545,'867496010644088',0),(258,491763369,'867496010644088',0),(259,202834502,'867194022383759',0),(260,796741246,'862845027751861',0),(261,676262791,'867496010644088',0),(262,337271199,'867496010644088',0),(263,198420087,'867496010644088',0),(264,76361086,'867496010644088',0),(265,131400393,'867496010644088',0),(266,522278120,'867496010644088',0),(267,509271164,'867496010644088',0),(268,658098270,'867496010644088',0),(269,414879352,'867496010644088',0),(270,609265170,'867496010644088',0),(271,650451367,'867496010644088',0),(272,832661816,'867496010644088',0),(273,959640217,'867496010644088',0),(274,565255803,'867496010644088',0),(275,37300233,'867496010644088',0),(276,405486436,'867496010644088',0),(277,812456945,'865242024141675',0),(278,1963104,'865242024141675',0),(279,366210955,'867496010644088',0),(280,643069036,'865242024141675',0),(281,686278701,'867496010644088',0),(282,13707127,'865242024141675',0),(283,727203889,'865242024141675',0),(284,221058264,'865242024141675',0),(285,746448119,'867496010644088',0),(286,321570634,'865242024141675',0),(287,714135518,'865242024141675',0),(288,385056803,'865242024141675',0),(289,555118827,'865242024141675',0),(290,499427849,'865242024141675',0),(291,489140974,'865242024141675',0),(292,126150972,'865242024141675',0),(293,903411317,'864397020248261',0),(294,694890651,'864397020248261',0),(295,856636367,'867496010644088',0),(296,274456814,'867496010644088',0),(297,320311975,'867496010644088',0),(298,376303575,'867496010644088',1),(299,601793228,'867496010644088',0),(300,248243140,'867496010644088',0),(301,521203221,'865242024141675',0),(302,591582862,'865242024141675',0),(303,116975794,'865242024141675',0),(304,576635203,'865242024141675',0),(305,231324474,'865242024141675',0),(306,767719481,'A0000045A125E6',0),(307,628399798,'867324020684409',0),(308,553589499,'867324020684409',0),(309,871524759,'867324020684409',0),(310,530457734,'865242024141675',0),(311,680892692,'867324020684409',0),(312,609419201,'867324020684409',0),(313,592618647,'867324020684409',0),(314,700944948,'867324020684409',0),(315,378136472,'867324020684409',0),(316,60073566,'867324020684409',0),(317,402902455,'867324020684409',0),(318,477390991,'867324020684409',0),(319,126150972,'867324020684409',0),(320,456848930,'867324020684409',0),(321,556914415,'867324020684409',0),(322,335274654,'867324020684409',0),(323,440825519,'359786050756759',1),(324,779692121,'867324020684409',0),(325,956863590,'867324020684409',0),(326,320295814,'865242024141675',0),(327,743789845,'867324020684409',0),(328,243326844,'867324020684409',0),(329,292865815,'867324020684409',0),(330,872371930,'867324020684409',0),(331,416130344,'867324020684409',0),(332,787824779,'867324020684409',0),(333,399623422,'867324020684409',0),(334,203737511,'867324020684409',0),(335,887915923,'867324020684409',0),(336,306862977,'867324020684409',0),(337,830600666,'867324020684409',0),(338,120829343,'867324020684409',0),(339,312461138,'867324020684409',0),(340,973796455,'867324020684409',0),(341,313931150,'867324020684409',0),(342,322865809,'867324020684409',0),(343,266364564,'867324020684409',0),(344,270500510,'867324020684409',0),(345,440925575,'867324020684409',0),(346,754322357,'867324020684409',0),(347,566472386,'867324020684409',0),(348,65983657,'867324020684409',0),(349,541104368,'867324020684409',0),(350,721000785,'867324020684409',0),(351,583752415,'867324020684409',0),(352,563450421,'867324020684409',0),(353,928188059,'867324020684409',0),(354,217256685,'867324020684409',0),(355,843369688,'867324020684409',0),(356,512140113,'867324020684409',0),(357,48025602,'867324020684409',0),(358,934893010,'867324020684409',0),(359,921249596,'867324020684409',0),(360,42511265,'867324020684409',0),(361,6570781,'867324020684409',0),(362,846649983,'867324020684409',0),(363,960991456,'867324020684409',0),(364,963574608,'352562070832079',0),(365,196931447,'352562070832079',1),(366,635705309,'867324020684409',0),(367,681232735,'867324020684409',0),(368,169152832,'867324020684409',0),(369,751423359,'867324020684409',0),(370,845577820,'867324020684409',0),(371,506624790,'867324020684409',0),(372,776809621,'867324020684409',0),(373,5934398,'867324020684409',0),(374,305222015,'867324020684409',0),(375,258277174,'867324020684409',0),(376,371875422,'867324020684409',0),(377,328560380,'867324020684409',0),(378,627078701,'867324020684409',0),(379,208456024,'867324020684409',0),(380,525100226,'867324020684409',0),(381,396406924,'867324020684409',0),(382,325324811,'867324020684409',0),(383,936484204,'867324020684409',0),(384,856636367,'867324020684409',0),(385,990318397,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(386,848109072,'866500026191686',0),(387,508356011,'867324020684409',0),(388,851956124,'867404024161198',1),(389,307886085,'342227654196692',1),(390,119031969,'868190026555169',1),(391,857837775,'861141036418663',1),(392,592063304,'869402029831649',0),(393,446570849,'869037026019473',1),(394,812249209,'868589027276875',1),(395,572481468,'869763021514024',1),(396,367869129,'868773021789220',1),(397,845264618,'8c3c9e5ab0abea99e010d5428d1ba0d8',0),(398,620182549,'A000004FD6863A',1),(399,269684467,'860737036663090',1),(400,170329202,'864789025646939',0),(401,753985972,'869555020097880',1),(402,903222122,'867302020040384',1),(403,321108478,'867324020684409',1),(404,182796032,'352105060574408',1),(405,849251460,'868375021945107',1),(406,931055416,'358094057721483',1),(407,300771575,'867601025045599',0),(408,144055341,'358016066373139',1),(409,229788895,'359596060539214',1),(410,292013660,'863802016649712',1),(411,275116302,'865790023715139',1),(412,248595419,'99000710024911',0),(413,248595419,'35edbe59e3a94b977eded1ea7d1ced9c',0),(414,12279597,'8c3c9e5ab0abea99e010d5428d1ba0d8',0),(415,387347220,'867757028319975',1),(416,305465608,'869526026899322',1),(417,990318397,'99000710024911',0),(418,799917478,'867857022307107',1),(419,435496725,'353765071776729',1),(420,581125662,'869832029017668',1),(421,968527806,'99000475349410',1),(422,836100466,'A00000558EE247',1),(423,11266728,'869158022370262',1),(424,407517990,'867228025583963',1),(425,216284719,'863165024830231',1),(426,592063304,'869011022129289',1),(427,211377831,'864301022368218',1),(428,945521464,'356156073578247',1),(429,378741103,'866184027129449',1),(430,823738172,'864301022368218',0),(431,548526182,'A100005247905B',1),(432,701096263,'868743025908621',1),(433,59378330,'869271025255065',1),(434,901690321,'867048020978681',1),(435,187018269,'869552025130931',1),(436,594111915,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(437,488826915,'99000706361616',1),(438,398846095,'869735022486824',1),(439,216394723,'868965027987820',1),(440,599677187,'867601025045599',1),(441,594111915,'ff10a15a251b70265d215b69de181c34',0),(442,594111915,'9c807a98ee390064a4727fb767b99dd0',0),(443,482984949,'869918024720511',1),(444,787747603,'868344020684299',1),(445,992902128,'865242024141675',0),(446,747892041,'8c3c9e5ab0abea99e010d5428d1ba0d8',1),(447,737426174,'867605020570584',1),(448,854364106,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(449,594111915,'3f102d716b2e1773e2a0bc3827d3bea4',0),(450,240291002,'862591036784952',1),(451,594111915,'67066490be14585754ec2a6ff784533b',0),(452,785251622,'35edbe59e3a94b977eded1ea7d1ced9c',0),(453,69401108,'866500026191686',1),(454,530964673,'869555028998659',1),(455,785251622,'ffa424aeb11b3d6cfbc45cda65a7eb6d',0),(456,248595419,'861726035479532',0),(457,139546418,'861572037983372',1),(458,526235999,'359596068521776',1),(459,594111915,'23dfd2b012427dca227c2759804989df',0),(460,449039907,'cb774072e9befcb835fa86c51c7e0b9b',0),(461,449039907,'b640364fe886f75dc04b094a1c102253',0),(462,449039907,'6816d36ada1960f601776cbe76dcaa48',0),(463,449039907,'42661d8036ada8b0ab484598b3b9e70e',0),(464,449039907,'e9da2e163f244ba3978514e94150a36c',0),(465,890058328,'A100004C2F776B',1),(466,594111915,'e9da2e163f244ba3978514e94150a36c',0),(467,248595419,'f406d7e1bd39e6bc5ee649059509ea92',0),(468,594111915,'f406d7e1bd39e6bc5ee649059509ea92',0),(469,12279597,'f406d7e1bd39e6bc5ee649059509ea92',0),(470,319813105,'862231037834650',1),(471,594111915,'c29fa89d6eb77c25805fb0c47ac264d1',0),(472,594111915,'0cdeb618a974a1f7f500e72203655180',1);
/*!40000 ALTER TABLE `qm_users_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_viewlevels`
--

DROP TABLE IF EXISTS `qm_viewlevels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_viewlevels`
--

LOCK TABLES `qm_viewlevels` WRITE;
/*!40000 ALTER TABLE `qm_viewlevels` DISABLE KEYS */;
INSERT INTO `qm_viewlevels` VALUES (1,'Public',0,'[1]'),(2,'Registered',1,'[6,8]'),(3,'Special',2,'[6,8]');
/*!40000 ALTER TABLE `qm_viewlevels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_weblinks`
--

DROP TABLE IF EXISTS `qm_weblinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_weblinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(250) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(250) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `access` int(11) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `language` char(7) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if link is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_weblinks`
--

LOCK TABLES `qm_weblinks` WRITE;
/*!40000 ALTER TABLE `qm_weblinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qm_weblinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_wenzhang`
--

DROP TABLE IF EXISTS `qm_wenzhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_wenzhang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `type` tinyint(1) unsigned NOT NULL COMMENT '1±íÊ¾Ìû×Ó£¬2±íÊ¾ÈÕ¼Ç',
  `gid` int(10) unsigned NOT NULL COMMENT 'ËùÊôÐ¡×é',
  `ctime` int(10) unsigned NOT NULL COMMENT '´´½¨Ê±¼ä',
  `intime` int(10) unsigned NOT NULL COMMENT '¼ÇÂ¼Ê±¼ä',
  `userid` int(9) unsigned NOT NULL,
  `isjing` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'ÊÇ·ñ¼Ó¾«£¬1·ñ2ÊÇ',
  `hname` varchar(255) DEFAULT NULL,
  `val` varchar(255) DEFAULT NULL,
  `parentid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1028 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ìû×Ó/ÈÕ¼Ç±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_wenzhang`
--

LOCK TABLES `qm_wenzhang` WRITE;
/*!40000 ALTER TABLE `qm_wenzhang` DISABLE KEYS */;
INSERT INTO `qm_wenzhang` VALUES (375,'双眼皮术后护理tips',2,9,1456818417,1456818417,887915923,2,NULL,NULL,0),(376,'面部轮廓精雕',2,11,1456818576,1456818576,887915923,1,NULL,NULL,0),(377,'埋线双眼皮的优点',2,9,1456820121,1456820121,887915923,1,NULL,NULL,0),(378,'7天恢复有神大眼',2,9,1456820400,1456820400,887915923,1,NULL,NULL,0),(379,'告别烦恼的双眼皮贴',2,9,1456820708,1456820708,887915923,2,NULL,NULL,0),(380,'只做了双眼皮气质就爆表了',2,9,1456820988,1456820988,887915923,1,NULL,NULL,0),(386,'90后姑娘的隆鼻日记',2,10,1456821365,1456821365,887915923,1,NULL,NULL,0),(387,'鼻部综合提升气质瞬间曝棚',2,10,1456821559,1456821559,887915923,1,NULL,NULL,0),(388,'玻尿酸隆鼻后秒变混血美女',2,10,1456821786,1456821786,887915923,2,NULL,NULL,0),(389,'面部轮廓手术2个月终于可以大吃大喝了',2,11,1456821989,1456821989,887915923,1,NULL,NULL,0),(390,'V脸来得太突然',2,11,1456822265,1456822265,887915923,2,NULL,NULL,0),(391,'再没人叫我斑花了',2,12,1456822585,1456822585,887915923,2,NULL,NULL,0),(394,'美丽改变命运',2,13,1456825016,1456825016,887915923,1,NULL,NULL,0),(396,'终于跟大象腿说了ByeBye',2,13,1456825674,1456825674,887915923,1,NULL,NULL,0),(399,'产后腰腹吸脂我也有小蛮腰了',2,13,1456826636,1456826636,887915923,2,NULL,NULL,0),(403,'做个精致的女人',1,13,1456887406,1456887406,887915923,1,'','6000-1万元',0),(404,'无痕隆胸，让我有些话不得不说',1,14,1456887941,1456887941,887915923,1,'','',0),(405,'改变的不只是胸，更是我的人生',1,14,1456888284,1456888284,887915923,2,'','',0),(406,'自体脂肪丰胸，嫩模蜕变豪乳',1,14,1456888501,1456888501,887915923,2,'','',0),(408,'胶原蛋白丰唇',1,15,1456889006,1456889006,887915923,1,'','',0),(409,'玻尿酸注射丰唇',2,15,1456889324,1456889324,887915923,1,NULL,NULL,0),(410,'纹唇术让女性轻松变美',2,15,1456889859,1456889859,887915923,1,NULL,NULL,0),(411,'绣眉知多少',1,16,1456890158,1456890158,887915923,1,'','',0),(412,'注射丰唇，全面释放唇情魅力',1,15,1456890892,1456890892,887915923,2,'','',0),(413,'变女神就是这么简单',1,9,1456891215,1456891215,887915923,2,'','',0),(414,'还原你的真实年龄',1,12,1456891609,1456891609,887915923,1,'','',0),(415,'尖尖翘翘美美哒的',2,16,1456892004,1456892004,887915923,1,NULL,NULL,0),(419,'注射后皮肤超滑嫩',1,12,1456898852,1456898852,887915923,1,'','',0),(421,'大圆脸终于不见了',1,11,1457055242,1457055242,887915923,1,'武汉艺星','',0),(423,'晒一晒做完双眼皮的感受',1,9,1457055483,1457055483,887915923,1,'','',0),(426,'马上雀斑就要离我远去了',1,12,1457055698,1457055698,887915923,1,'','',0),(428,'水光注射，让我重回18岁',1,12,1457055892,1457055892,887915923,1,'','',0),(429,'玻尿酸隆鼻效果很满意',1,10,1457056069,1457056069,887915923,1,'','',0),(431,'隆胸手术给了我自信',1,14,1457056251,1457056251,887915923,1,'武汉艺星','',0),(434,'秒变V脸',1,16,1457141100,1457141100,887915923,1,'','',0),(436,'做自己的明星 我为华美代颜',1,10,1457141644,1457141644,887915923,1,'','',0),(438,'专业祛斑，我当然会美丽',1,12,1457141935,1457141935,887915923,1,'','',0),(440,'胳膊“缩水”让我惊喜',1,13,1457142314,1457142314,887915923,1,'','',0),(444,'从此摆脱“小麻雀”命运',1,12,1457144526,1457144526,887915923,2,'','',0),(445,'瘦脸什么的简直太轻松了',1,11,1457145106,1457145106,887915923,2,'','',0),(447,'面部溶脂+玻尿酸填充额头',1,11,1457228047,1457228047,887915923,1,'','',0),(449,'填充后变得更美丽',1,9,1457228221,1457228221,887915923,1,'','',0),(452,'变成V型脸竟如此简单',1,11,1457228835,1457228835,887915923,1,'','',0),(455,'完美修复双眼皮',1,9,1457229571,1457229571,887915923,1,'','',0),(456,'假体隆胸手术6周',1,14,1457246001,1457246001,887915923,1,'','',0),(457,'腹部吸脂3个月了',1,13,1457246492,1457246492,887915923,1,'','',0),(459,'假体隆鼻两个月后',1,10,1457246987,1457246987,887915923,2,'','',0),(460,'从女生到女神,伽美蝶变',1,11,1457248522,1457248522,887915923,1,'','',0),(476,'你若脸美 才有晴天',1,11,1457253087,1457253087,887915923,1,'','',0),(477,'告别“女汉子”，以更美的姿态活下去',1,11,1457253367,1457253367,887915923,1,'','',0),(478,'变美从眼睛开始',1,9,1457253565,1457253565,887915923,1,'','',0),(479,'不要只说不做，行动要趁早',1,11,1457253847,1457253847,887915923,1,'','',0),(480,'简单中就这样变美啦',1,9,1457254196,1457254196,887915923,1,'','',0),(481,'爱情可以等，变美可不能停',1,10,1457254858,1457254858,887915923,1,'','',0),(487,'女人的私房钱放哪儿最安全  当然是自己脸上',1,10,1457256330,1457256330,887915923,1,'','',0),(488,'整形不是为了变成别人，而是发掘自身的美丽',1,9,1457256915,1457256915,887915923,1,'','',0),(490,'变美就是这么任性',1,10,1457257418,1457257418,887915923,1,'','',0),(492,'脸部比例日趋完美,体验从未有过的成就感',1,10,1457257823,1457257823,887915923,1,'','',0),(493,'不勇敢踏出一步，永远不知道自己可以这么美丽迷人',1,10,1457258148,1457258148,887915923,1,'','',0),(494,'终于找到属于自己的feel',1,9,1457258409,1457258409,887915923,1,'','',0),(495,'丑女变身记',1,16,1457259602,1457259602,887915923,2,'','',0),(496,'珍惜时间，让自己更美一点',1,16,1457259957,1457259957,887915923,1,'','',0),(497,'大家都是颜控',1,10,1457260312,1457260312,887915923,1,'','',0),(498,'越美越自信',1,16,1457260604,1457260604,887915923,1,'','',0),(499,'朋友们对我的大眼睛都羡慕不已',1,9,1457260915,1457260915,887915923,2,'','',0),(502,'美貌，女人一生最好的通行证',1,10,1457314016,1457314016,887915923,1,'','',0),(505,'整形是为了让自己更自信',1,9,1457314389,1457314389,887915923,1,'','',0),(508,'定制属于自己的美',1,16,1457315239,1457315239,887915923,1,'','',0),(509,'美丽是有生产力的，形象无价',1,11,1457315486,1457315486,887915923,1,'','',0),(510,'爱情的春天终于来啦',1,9,1457315823,1457315823,887915923,1,'','',0),(511,'只做了眼鼻，却给了我梦寐以求的容颜',1,9,1457316280,1457316280,887915923,1,'','',0),(512,'只为找到更美的自己',1,11,1457316728,1457316728,887915923,1,'','',0),(513,'漂亮才有前涂，不漂亮只能自求多福',1,16,1457316971,1457316971,887915923,1,'','',0),(514,'术前是路人，术后是女神',1,10,1457317506,1457317506,887915923,1,'','',0),(516,'做完鼻子和眼睛后，整个人都不一样了',1,9,1457317802,1457317802,887915923,1,'','',0),(517,'变美后，人生精彩不断',1,9,1457318316,1457318316,887915923,2,'','',0),(518,'打玻后，看我美不美',1,11,1457505352,1457505352,887915923,1,'','',0),(519,'整形后，效果是如此惊人',1,9,1457509665,1457509665,887915923,1,'','',0),(520,'人生反转剧，拒做平凡女',1,9,1457592205,1457592205,887915923,1,'','',0),(521,'灰姑娘的蜕变之旅',1,10,1457616167,1457616167,887915923,1,'','',0),(522,'自信就是取悦自己',1,9,1457616323,1457616323,887915923,1,'','',0),(523,'让美丽更上一层楼',1,16,1457616461,1457616461,887915923,1,'','',0),(524,'成为想要的自己，就是最好的幸福',1,16,1457616689,1457616689,887915923,1,'','',0),(525,'终于成为被别人羡慕的对象啦',1,16,1457616823,1457616823,887915923,1,'','',0),(526,'微整让我路人变女神',1,16,1457616957,1457616957,887915923,1,'','',0),(527,'人生的路还很长，作为女人，我不能输在起跑线上',1,11,1457658853,1457658853,887915923,1,'','',0),(528,'脱胎换骨给你看',1,10,1457659035,1457659035,887915923,1,'','',0),(529,'终于实现丑小鸭到天鹅的蜕变',1,9,1457659904,1457659904,887915923,1,'','',0),(530,'小小改动，变美的程度超乎自己想象',1,9,1457660035,1457660035,887915923,1,'','',0),(531,'来看看我眼睛整形前后大对比',1,9,1457660113,1457660113,887915923,1,'','',0),(532,'这下鼻子终于不是硬伤了',1,10,1457660401,1457660401,887915923,1,'','',0),(533,'水汪汪大眼睛，珍贵的你值得拥有',1,9,1457660793,1457660793,887915923,1,'','',0),(536,'华丽变身精致小V脸',1,11,1457664175,1457664175,887915923,1,'','',0),(537,'不是天生丽质，但我可以精雕细琢',1,11,1457664291,1457664291,887915923,1,'','',0),(538,'开启心灵之窗，华丽变身大眼美女',1,9,1457664387,1457664387,887915923,1,'','',0),(540,'拒做平凡女，打开美丽之门',1,10,1457664602,1457664602,887915923,1,'','',0),(541,'做了双眼皮，告别大妈脸，完美逆袭',1,9,1457664790,1457664790,887915923,1,'','',0),(542,'不要可爱要漂亮，邻家女孩变女神',1,11,1457664938,1457664938,887915923,1,'','',0),(543,'人生只有两个阶段,单眼皮的前生和双眼皮的今世',1,9,1457665102,1457665102,887915923,1,'','',0),(544,'完美脸型，美到没朋友',1,11,1457665209,1457665209,887915923,1,'','',0),(547,'灰姑娘“秒变”公主',1,11,1457665456,1457665456,887915923,1,'','',0),(548,'路人变女神，颜美就是任性',1,10,1457665607,1457665607,887915923,1,'','',0),(549,'做了双眼皮+隆鼻手术，可爱了呦',1,9,1457665760,1457665760,887915923,1,'','',0),(550,'做了双眼皮手术，水汪汪的大眼睛，珍贵的你值得拥有',1,9,1457666086,1457666086,887915923,1,'','',0),(551,'不满意内双，做了双眼皮，棒呆',1,9,1457666219,1457666219,887915923,1,'','',0),(552,'一年了,来看我眼鼻整形前后终极大对比',1,16,1457666585,1457666585,887915923,1,'','',0),(553,'做了面部注射,好喜欢现在的脸型',1,11,1457666980,1457666980,887915923,1,'','',0),(554,'脸瞬间就变小了很多',1,11,1457667422,1457667422,887915923,1,'','',0),(555,'做了双眼皮+开眼角后，拥有了一双清纯大眼',1,9,1457667575,1457667575,887915923,1,'','',0),(556,'整形让自卑的我拥有明星脸',1,11,1457745505,1457745505,887915923,1,'','',0),(557,'仅仅一个双眼皮，改变的却是我的整个世界',1,9,1457745726,1457745726,887915923,1,'','',0),(558,'眼鼻整形两个月而已，已经美翻天啦',1,9,1457745808,1457745808,887915923,1,'','',0),(559,'瘦脸后，小胖妞翻身啦',1,13,1457746411,1457746411,887915923,1,'','',0),(560,'男人也爱美，像这样才精神，来看男人整形效果吧',1,11,1457746510,1457746510,887915923,1,'','',0),(561,'刚刚做了双眼皮和开眼角，不要太羡慕我哦',1,9,1457746949,1457746949,887915923,1,'','',0),(562,'我不是明星，只是做了鼻子和脂肪填充而已',1,11,1457747006,1457747006,887915923,1,'','',0),(563,'眼部改造之后，我就这么容易的变成美女啦',1,9,1457747095,1457747095,887915923,1,'','',0),(564,'做了眼睛和鼻子，才一个多月，美美哒',1,10,1457747257,1457747257,887915923,1,'','',0),(565,'鼻综合让我整个面部轮廓都清新亮丽了',1,10,1457747462,1457747462,887915923,1,'','',0),(566,'眯眯眼被开除啦，现在本姑娘是大眼妹',1,9,1457747646,1457747646,887915923,1,'','',0),(567,'我也是面部立体自然的美女啦',1,11,1457747762,1457747762,887915923,1,'','',0),(568,'93的妹子，犹豫了很久，终于割了个双眼皮',1,9,1457749662,1457749662,887915923,1,'','',0),(569,'玻尿酸，让我拥有水润的苹果肌高鼻梁',1,12,1457750558,1457750558,887915923,1,'','',0),(570,'注射玻尿酸 让我萌萌哒',1,12,1457752925,1457752925,887915923,1,'','',0),(571,'分分钟秒变嫩萝莉',1,12,1457753068,1457753068,887915923,1,'','',0),(574,'赶走讨厌的雀斑，蜕变过程',1,12,1457753916,1457753916,887915923,1,'','',0),(575,'彩光嫩肤让我的脸变得美丽动人',1,12,1457753978,1457753978,887915923,1,'','',0),(576,'假体丰胸手术让我找回了自信',1,14,1457754166,1457754166,887915923,1,'','',0),(577,'双眼皮，我的美丽变身记',1,9,1457754351,1457754351,887915923,1,'','',0),(578,'自体脂肪隆胸，再也不怕穿低胸衣服了',1,14,1457754524,1457754524,887915923,1,'','',0),(579,'自体脂肪隆胸，再也不怕穿低胸衣服了',1,14,1457754525,1457754525,887915923,1,'','',0),(580,'变美后,参加聚会更有面子',1,9,1457754737,1457754737,887915923,1,'','',0),(583,'隆鼻后，自然美感宛如天生',1,10,1457754969,1457754969,887915923,1,'','',0),(584,'做个动人的“鼻美人”',1,10,1457755158,1457755158,887915923,1,'','',0),(585,'做完双眼皮像换了个人',1,9,1457755431,1457755431,887915923,1,'','',0),(586,'变化如此大，你还认得出来',1,16,1457784859,1457784859,887915923,1,'','',0),(587,'我是一只大眼睛的小鹿',1,9,1457784938,1457784938,887915923,1,'','',0),(588,'水汪汪的大眼睛，珍贵的你值得拥有',1,9,1457785004,1457785004,887915923,1,'','',0),(589,'做了眼睛后，整个人都漂亮了',1,9,1457785180,1457785180,887915923,1,'','',0),(590,'切割双眼皮后，眼睛好迷人',1,9,1457785255,1457785255,887915923,1,'','',0),(591,'现在我的眼睛你会喜欢吗',1,9,1457785383,1457785383,887915923,1,'','',0),(592,'告别单眼皮的我，现在开始也有人追啦',1,9,1457785491,1457785491,887915923,1,'','',0),(593,'鼻子逆袭后终于比一般正常的鼻子好看',1,10,1457785623,1457785623,887915923,1,'','',0),(594,'鼻子又小又塌，作为女孩我真的受不了',1,10,1457785889,1457785889,887915923,1,'','',0),(595,'大宽鼻整过后，小巧无比',1,10,1457786001,1457786001,887915923,1,'','',0),(596,'人生苦短，要幸福就从现在开始改变',1,10,1457786137,1457786137,887915923,1,'','',0),(597,'女人你不一定要最美，但一定要做最好的自己',1,11,1457786336,1457786336,887915923,1,'','',0),(598,'女人，不要停止对美的追求',1,11,1457786592,1457786592,887915923,1,'','',0),(599,'小改变，大不同',1,10,1457786675,1457786675,887915923,1,'','',0),(600,'不好意思，我变的更美了',1,10,1457786792,1457786792,887915923,1,'','',0),(601,'你以为你整的是形，其实你改变的是人生',1,10,1457786930,1457786930,887915923,1,'','',0),(602,'没有丑女人，只有还没变美的女人',1,9,1457787220,1457787220,887915923,1,'','',0),(603,'和我的大小眼说bye bye',1,9,1457787379,1457787379,887915923,1,'','',0),(604,'一直不相信奇迹，直到我遇见另一个自己',1,9,1457787527,1457787527,887915923,1,'','',0),(605,'和我眼睛一样的请自觉对号入座',1,9,1457787602,1457787602,887915923,1,'','',0),(606,'看脸的时代，你若不美，拿什么拼未来',1,10,1457923439,1457923439,887915923,1,'','',0),(607,'还在犹豫的姐妹们还不赶快过来瞧瞧',1,10,1457923710,1457923710,887915923,1,'','',0),(608,'丰面颊，秀秀我的术后变化',1,11,1457923928,1457923928,887915923,1,'','',0),(609,'变美需要决心',1,16,1457924157,1457924157,887915923,1,'','',0),(610,'整形，让我变美丽',1,16,1457924278,1457924278,887915923,1,'','',0),(611,'改变，就在一瞬间',1,16,1457924515,1457924515,887915923,2,'','',0),(612,'变成娃娃脸',1,11,1457924629,1457924629,887915923,2,'','',0),(613,'去黑眼圈',1,9,1457924966,1457924966,887915923,1,'','',0),(614,'分享一下祛眼袋经历吧',1,9,1457925332,1457925332,887915923,2,'','',0),(615,'我做了开眼角，眼睛变得更大更亮了',1,9,1457925436,1457925436,887915923,1,'','',0),(616,'双眼皮变女神，只为自己更自信',1,9,1457925580,1457925580,887915923,1,'','',0),(617,'看看还认得出我不',1,9,1457925698,1457925698,887915923,1,'','',0),(618,'手术后，超爱自己',1,9,1457925850,1457925850,887915923,2,'','',0),(619,'整形是女生的专利，如果你还抱有这样的想法那你就过时了',1,10,1457926075,1457926075,887915923,1,'','',0),(620,'我割的双眼皮很自然，别人以为是天生的呢',1,9,1457926147,1457926147,887915923,1,'','',0),(621,'我年轻，但我可以更年轻',1,9,1457926279,1457926279,887915923,1,'','',0),(622,'眼睛的改变，让我这么美',1,9,1457926361,1457926361,887915923,2,'','',0),(623,'觉得我变得有亲和力了吗',1,11,1457926494,1457926494,887915923,1,'','',0),(624,'切开法双眼皮+开内眼角整形2个月后',1,9,1457926584,1457926584,887915923,1,'','',0),(625,'做了溶脂，从此四方脸变小V脸',1,11,1457956904,1457956904,887915923,2,'','',0),(626,'注射瘦脸针的效果',1,11,1457956975,1457956975,887915923,1,'','',0),(627,'下巴整形改变人生',1,11,1457957214,1457957214,887915923,2,'','',0),(628,'假体垫下巴 感觉效果还是比较满意的',1,16,1457957362,1457957362,887915923,1,'','',0),(629,'自体脂肪丰胸，折腾了半年，感动死了',1,14,1457957416,1457957416,887915923,2,'','',0),(630,'外貌改变了我的一生',1,11,1457957884,1457957884,887915923,2,'','',0),(631,'注射肉毒素瘦瘦脸，分享一下我的经历',1,11,1458015879,1458015879,887915923,1,'','',0),(632,'隆胸，是我做过最对的选择',1,14,1458015953,1458015953,887915923,1,'','',0),(633,'大腿吸脂+自体脂肪移植丰臀',1,13,1458016030,1458016030,887915923,1,'','',0),(634,'大腿吸脂整形手术后记',1,13,1458016120,1458016120,887915923,1,'','',0),(635,'大腿吸脂术后8个月的后记',1,13,1458016354,1458016354,887915923,1,'','',0),(636,'面部吸脂整形手术后记',1,13,1458016467,1458016467,887915923,1,'','',0),(637,'告别鸡腿',1,13,1458016535,1458016535,887915923,1,'','',0),(638,'大屁股女人自述吸脂瘦臀经历，效果惊人',1,13,1458016887,1458016887,887915923,1,'','',0),(639,'面部吸脂整形手术',1,11,1458016951,1458016951,887915923,1,'','',0),(640,'腹部脂肪吸脂',1,13,1458017122,1458017122,887915923,1,'','',0),(641,'我的美丽腹部吸脂，自信，真相在此',1,13,1458017209,1458017209,887915923,1,'','',0),(642,'隆胸，让我做真女人',1,14,1458017404,1458017404,887915923,2,'','',0),(643,'假体隆胸',1,14,1458017488,1458017488,887915923,1,'','',0),(644,'假体隆胸的女孩',1,14,1458019008,1458019008,887915923,1,'','',0),(645,'自体脂肪丰胸后记',1,14,1458019113,1458019113,887915923,1,'','',0),(646,'假体285cc隆胸再手术5个多月后记',1,14,1458019245,1458019245,887915923,1,'','',0),(647,'即使生完孩，也要重视自己的胸部',1,14,1458019298,1458019298,887915923,1,'','',0),(648,'胸部变大了，更有自信了',1,14,1458019409,1458019409,887915923,1,'','',0),(649,'我拒绝再想起以前的自己',1,14,1458019467,1458019467,887915923,2,'','',0),(650,'变化“大大的”',1,14,1458019559,1458019559,887915923,1,'','',0),(651,'颧骨突出让我失去自信',1,11,1458019679,1458019679,887915923,1,'','',0),(652,'再见了，小方脸',1,11,1458019769,1458019769,887915923,2,'','',0),(653,'面部吸脂后记',1,11,1458019869,1458019869,887915923,1,'','',0),(654,'面部轮廓整形6个月后',1,11,1458019940,1458019940,887915923,1,'','',0),(655,'重返青春，致我的小V脸',1,11,1458020018,1458020018,887915923,2,'','',0),(656,'打肉毒素去抬头纹和眉间纹效果不错哦',2,12,1458108167,1458108167,887915923,1,NULL,NULL,0),(657,'小腿肌肉不见啦',1,13,1458108245,1458108245,887915923,1,'','',0),(658,'瘦腿针3月后',1,13,1458108468,1458108468,887915923,1,'','',0),(659,'不开刀都能瘦脸',1,11,1458108543,1458108543,887915923,1,'','',0),(660,'鼻子变美了',2,10,1458108640,1458108640,887915923,1,NULL,NULL,0),(661,'变成小V脸',1,11,1458108716,1458108716,887915923,1,'','',0),(662,'看看我的轮廓，多漂亮呢',1,11,1458108811,1458108811,887915923,1,'','',0),(663,'整形后韩范儿十足',2,16,1458109207,1458109207,887915923,1,NULL,NULL,0),(664,'玻尿酸注射隆鼻 感觉自己美美哒',1,10,1458109292,1458109292,887915923,1,'','',0),(665,'玻尿酸填充法令纹+泪沟',1,16,1458109475,1458109475,887915923,1,'','',0),(666,'手臂吸脂，我也能装个小鸟依人啦',1,13,1458109774,1458109774,887915923,1,'','',0),(667,'胳膊吸脂后记',1,13,1458109915,1458109915,887915923,1,'','',0),(668,'眼鼻手术让我变漂亮',2,16,1458109970,1458109970,887915923,1,NULL,NULL,0),(669,'颧骨整形手术',1,11,1458110181,1458110181,887915923,1,'','',0),(670,'终于变瓜子脸',1,11,1458110261,1458110261,887915923,1,'','',0),(671,'我再不需要浓妆艳抹了',1,10,1458110391,1458110391,887915923,1,'','',0),(672,'不要太羡慕我哦',2,9,1458110661,1458110661,887915923,1,NULL,NULL,0),(673,'借这个假期终于园了我的双眼皮梦',2,9,1458110730,1458110730,887915923,1,NULL,NULL,0),(674,'鼻子的改变带动了我整张脸的改变',1,10,1458111076,1458111076,887915923,1,'','',0),(675,'歪鼻驼峰鼻的娘子们过来看看，有图有真相',1,10,1458111225,1458111225,887915923,1,'','',0),(676,'做完自体软骨隆鼻觉得年轻了好多',1,10,1458111290,1458111290,887915923,1,'','',0),(677,'鼻头大 鼻梁低',1,10,1458111424,1458111424,887915923,1,'','',0),(678,'缩鼻翼',1,10,1458111548,1458111548,887915923,1,'','',0),(679,'玻尿酸丰唇垫下巴后记',1,15,1458111702,1458111702,887915923,1,'','',0),(680,'注射玻尿酸丰唇',1,15,1458112006,1458112006,887915923,1,'','',0),(682,'这下可以美美哒',2,10,1458187176,1458187176,887915923,1,NULL,NULL,0),(683,'告别塌塌鼻',2,10,1458187238,1458187238,887915923,1,NULL,NULL,0),(684,'嘴唇缩小整形手术',1,15,1458187420,1458187420,887915923,1,'','',0),(685,'隆胸3周后',1,14,1458187574,1458187574,887915923,1,'','',0),(686,'我去做了乳房下垂矫正的手术',1,14,1458187634,1458187634,887915923,1,'','',0),(687,'宽鼻梁矫正整形手术4个月后记',1,10,1458187716,1458187716,887915923,2,'','',0),(688,'鼻子整形2周后',1,10,1458187817,1458187817,887915923,1,'','',0),(689,'脂肪填充后效果不错',2,11,1458187942,1458187942,887915923,1,NULL,NULL,0),(690,'鼻头又肉又大，打肉毒素就能缩小',1,10,1458188072,1458188072,887915923,1,'','',0),(691,'成功把乳头缩小了 真让人高兴',1,14,1458188205,1458188205,887915923,1,'','',0),(692,'拒绝平胸就是拒绝平庸',2,14,1458188273,1458188273,887915923,1,NULL,NULL,0),(693,'矫正歪+矮+驼峰鼻，还有双眼皮',1,10,1458188426,1458188426,887915923,1,'','',0),(694,'驼峰鼻整形',1,10,1458188548,1458188548,887915923,1,'','',0),(695,'摆脱小眼睛',2,9,1458188618,1458188618,887915923,1,NULL,NULL,0),(696,'美丽大蜕变',2,9,1458188736,1458188736,887915923,1,NULL,NULL,0),(697,'重返青春',1,11,1458188809,1458188809,887915923,1,'','',0),(698,'颧骨磨骨，更年轻',1,11,1458189190,1458189190,887915923,1,'','',0),(699,'前颧骨磨骨+棱角下巴矫正整形',1,11,1458189361,1458189361,887915923,1,'','',0),(700,'颧骨缩小+溶脂',1,11,1458189456,1458189456,887915923,1,'','',0),(701,'整形见证奇迹',2,16,1458189595,1458189595,887915923,1,NULL,NULL,0),(702,'美女没烦恼',2,11,1458189654,1458189654,887915923,1,NULL,NULL,0),(703,'隆鼻后，脸都小啦',1,10,1458190880,1458190880,887915923,2,'','',0),(704,'皱纹没了，找回年轻水嫩的自己',1,12,1458191019,1458191019,887915923,1,'','',0),(705,'面部溶脂+玻尿酸填充额头',1,11,1458191101,1458191101,887915923,2,'','',0),(706,'做完双眼皮不是一般的好',1,9,1458191208,1458191208,887915923,1,'','',0),(707,'完爆双眼皮',2,9,1458272329,1458272329,887915923,1,NULL,NULL,0),(708,'原来我也可以拥有小脸耶',2,11,1458272412,1458272412,887915923,1,NULL,NULL,0),(709,'假体丰胸，美丽事业双丰收',1,14,1458272597,1458272597,887915923,1,'','',0),(710,'水动力吸脂轻松减肥',1,13,1458272719,1458272719,887915923,1,'','',0),(711,'垫下巴，植入了膨体，效果还行',1,11,1458272786,1458272786,887915923,1,'','',0),(712,'咬肌祛除，让我的脸型更加好看了',1,11,1458272844,1458272844,887915923,1,'','',0),(713,'大饼脸终于变成瓜子脸了',1,11,1458272898,1458272898,887915923,1,'','',0),(714,'变化好好哒',2,11,1458272970,1458272970,887915923,1,NULL,NULL,0),(715,'我做了磨骨手术现在是V型脸了',2,11,1458273047,1458273047,887915923,1,NULL,NULL,0),(716,'眼部综合整形，让我的眼睛更传神',1,9,1458273118,1458273118,887915923,1,'','',0),(717,'韩式双眼皮+开眼角+祛眼袋+卧蚕，有没有变美',1,9,1458273192,1458273192,887915923,1,'','',0),(718,'隆鼻修复，帮我完美重生',1,10,1458273294,1458273294,887915923,1,'','',0),(762,'关于瘦脸针，你了解多少',1,11,1458395789,1458395789,887915923,2,'','',0),(780,'面部提升以后，感觉年轻了N 岁，超有成就感',1,12,1458537867,1458537867,887915923,1,'','',0),(781,'脸上的肉肉没有了',1,11,1458538054,1458538054,887915923,1,'','',0),(782,'做了射频除皱，我找回了年轻的活力和靓丽',1,12,1458538267,1458538267,887915923,1,'','',0),(783,'自体脂肪丰额头术后两个月效果',1,11,1458538737,1458538737,887915923,1,'','',0),(784,'内双做切开双眼皮手术后超级自然',1,9,1458538911,1458538911,887915923,1,'','',0),(785,'激光祛斑，恢复中',1,12,1458539121,1458539121,887915923,1,'','',0),(786,'祛斑成功了，给大家分享下我的祛斑经历',1,12,1458539409,1458539409,887915923,1,'','',0),(787,'分享激光祛痣的经验',1,12,1458539486,1458539486,887915923,1,'','',0),(788,'玻尿酸隆鼻',1,10,1458539659,1458539659,887915923,1,'','',0),(789,'不得不说的微整形',1,16,1458616778,1458616778,887915923,2,'','',0),(790,'女儿去掉了雀斑成绩突飞猛进',2,12,1458616941,1458616941,887915923,1,NULL,NULL,0),(843,'微整形和整形的区别',1,16,1458908440,1458908440,887915923,2,'','',0),(844,'微整形的无创新时代',1,16,1459150649,1459150649,887915923,2,'','',0),(848,'看看我的膨体隆鼻和自体软骨效果怎样',1,10,1459516520,1459516520,822642142,1,'','',0),(850,'微针祛痘',1,12,1459740345,1459740345,887915923,1,'','',0),(851,'V-line瓜子脸手术',1,11,1459773049,1459773049,968220660,2,'','',0),(853,'宽下巴矫正术矫正宽下巴效果好好',1,11,1459827556,1459827556,988107387,2,'','',0),(854,'做了全切，开了内眼角',1,9,1459840746,1459840746,315787180,2,'','',0),(855,'整了鼻子，美美哒',1,10,1459843194,1459843194,59977127,2,'','',0),(856,'国字脸也能变瓜子脸哦',1,11,1459844654,1459844654,832745935,2,'','',0),(858,'隆鼻+假体丰额头',1,10,1459846032,1459846032,682875857,2,'','',0),(859,'大脸变身V脸',1,11,1459858065,1459858065,726176698,2,'','',0),(861,'做完双眼皮4个月',1,9,1459943765,1459943765,17992305,1,'','',0),(862,'我的小脸养成记',1,11,1459944654,1459944654,214766593,1,'','',0),(863,'我的V脸成形记',1,11,1459945004,1459945004,64707944,1,'','',0),(864,'V-line+颧骨整形，尖脸美女不是梦',1,11,1459945304,1459945304,472888401,1,'','',0),(865,'虽然花费不菲，但效果已觉此生足已',1,11,1459945696,1459945696,318118360,1,'','',0),(866,'鲍照，脂肪填充+隆鼻3个月',1,11,1459946034,1459946034,249273711,1,'','',0),(867,'方下巴手术和颧骨缩小术第九周',1,11,1459946337,1459946337,272381300,1,'','',0),(868,'展示我的完美蜕变',1,11,1459947158,1459947158,263910545,1,'','',0),(869,'大龅牙拜拜了，看看我的牙齿矫正',1,15,1459947643,1459947643,491763369,1,'','',0),(870,'体验韩式三点双眼皮',1,9,1459995276,1459995276,676262791,1,'','',0),(871,'做完隆鼻手术一年了',1,10,1459995680,1459995680,337271199,1,'','',0),(872,'嘎嘎嘎，终于变成双眼皮啦',1,9,1459996525,1459996525,198420087,1,'','',0),(873,'有图有真相，我的美丽腹部吸脂',1,13,1459996869,1459996869,76361086,1,'','',0),(874,'做了个酒窝，可爱了哟',1,16,1459997231,1459997231,131400393,1,'','',0),(875,'做了韩式双眼皮，眼睛大了一倍',1,9,1459997767,1459997767,522278120,1,'','',0),(877,'自体脂肪注射一年了，我很满意',1,14,1459999290,1459999290,509271164,1,'','',0),(878,'我做的鼻部修复手术',1,10,1459999335,1459999335,246667211,1,'','',0),(879,'鼻子整形后大变身',1,10,1459999767,1459999767,658098270,1,'','',0),(880,'颧骨+下颌角术后一个月了',1,11,1460001495,1460001495,414879352,1,'','',0),(881,'美腿来之不易',1,13,1460003398,1460003398,609265170,1,'','',0),(882,'腹部吸脂手术前后',1,13,1460008651,1460008651,650451367,1,'','',0),(883,'终于告别了猪鼻子',1,10,1460008925,1460008925,832661816,1,'','',0),(884,'哦，前凸的日子是那样的完美',1,14,1460009370,1460009370,959640217,1,'','',0),(885,'双眼皮整形，成功逆袭成女神',1,9,1460009746,1460009746,565255803,1,'','',0),(886,'祛眼袋+去鼻唇沟，这一下年轻很多',1,16,1460010160,1460010160,37300233,1,'','',0),(887,'脂肪移植+眼形矫正，照镜子都会被自己迷倒',1,11,1460015501,1460015501,405486436,1,'','',0),(888,'自体脂肪移植+水光注射针',1,12,1460015835,1460015835,812456945,1,'','',0),(889,'隆鼻之后，让我自信满满',1,10,1460016239,1460016239,1963104,1,'','',0),(890,'双眼皮真实体验',1,9,1460016290,1460016290,366210955,1,'','',0),(891,'“丑小鸭”正在变化',1,9,1460016509,1460016509,643069036,1,'','',0),(892,'隆鼻之后 塑造巅峰美鼻',1,10,1460016720,1460016720,13707127,1,'','',0),(893,'双眼皮让我的五官看起来更漂亮',1,9,1460016852,1460016852,686278701,1,'','',0),(894,'隆鼻+面部提升+注射痩脸整形 我的未来不再是梦',1,10,1460016931,1460016931,727203889,1,'','',0),(895,'双眼皮+隆鼻，做一次美容出一个精品',1,10,1460017122,1460017122,221058264,1,'','',0),(896,'双眼皮让我的五官看起来更漂亮',1,9,1460017190,1460017190,686278701,1,'','',0),(898,'如何辨别真假玻尿酸',2,16,1460034053,1460034053,887915923,1,NULL,NULL,0),(899,'双眼皮+隆鼻，缔造完美五官',1,9,1460078091,1460078091,746448119,1,'','',0),(900,'就从一双明眸开始',1,9,1460080889,1460080889,321570634,1,'','',0),(901,'改脸型，展示自然美丽',1,11,1460081525,1460081525,714135518,1,'','',0),(902,'假体隆胸手术好不好 看看我的效果你就知道了',1,14,1460082093,1460082093,385056803,1,'','',0),(903,'下颌骨整形 呈现面部完美抛物线',1,11,1460082518,1460082518,555118827,1,'','',0),(904,'颧骨+双眼皮+下颌骨+垫下巴+隆鼻 美是敢于改变',1,11,1460084424,1460084424,499427849,1,'','',0),(905,'隆鼻后，比原来漂亮多了',1,10,1460099150,1460099150,489140974,1,'','',0),(908,'隆鼻后，变化真的很大',1,10,1460100279,1460100279,126150972,1,'','',0),(909,'我的真实丰胸经历',1,14,1460165862,1460165862,274456814,1,'','',0),(910,'隆鼻术后，让我离梦想又近了一步',1,10,1460173408,1460173408,320311975,1,'','',0),(911,'爱美妞改善鼻部手术全过程',1,10,1460173788,1460173788,694890651,1,'','',0),(912,'做了埋线双眼皮，大爱我的双眼皮',1,9,1460174599,1460174599,376303575,1,'','',0),(913,'整形让我拥有了迷人大眼',1,9,1460175733,1460175733,601793228,1,'','',0),(915,'垫个下巴也可以变美',1,11,1460176738,1460176738,988107387,1,'','',0),(916,'双眼皮手术成功，出来亮个相',1,9,1460177116,1460177116,248243140,1,'','',0),(917,'隆下巴手术过程',1,11,1460186391,1460186391,726176698,1,'','',0),(918,'驼峰鼻一定要尽早矫正',1,10,1460189050,1460189050,521203221,1,'','',0),(919,'玻尿酸营造卧蚕',1,9,1460190374,1460190374,591582862,1,'','',0),(922,'我做的膨体隆鼻整形',1,10,1460191810,1460191810,116975794,1,'','',0),(923,'做了整形，不再是丑小鸭了',1,9,1460192234,1460192234,576635203,1,'','',0),(924,'埋线双眼皮，恢复完好',1,9,1460192964,1460192964,231324474,1,'','',0),(925,'做的项目比较多，但是变美了不少哈哈',1,11,1460193680,1460193680,231324474,1,'','',0),(926,'四方脸成功变身瓜子脸了',1,11,1460222023,1460222023,767719481,1,'','',0),(927,'内双也能变成真正的双眼皮',1,9,1460338216,1460338216,628399798,1,'','',0),(928,'脂肪移植术瘦脸',1,11,1460338875,1460338875,553589499,1,'','',0),(929,'看我72变，变身大美女',1,11,1460339340,1460339340,871524759,1,'','',0),(930,'真的瘦了，磨骨瘦脸手术帮我成功瘦脸',1,11,1460340162,1460340162,680892692,1,'','',0),(931,'光子祛斑',1,12,1460340395,1460340395,530457734,1,'','',0),(932,'做颧骨手术了，终于梦想成真了',1,11,1460340892,1460340892,609419201,1,'','',0),(933,'有图有真相，假体隆胸真不错',1,14,1460341549,1460341549,592618647,1,'','',0),(934,'激光溶脂瘦大腿',1,13,1460342743,1460342743,700944948,1,'','',0),(935,'眼袋也去掉了，鼻子也变好看了',1,9,1460343279,1460343279,378136472,1,'','',0),(936,'我的额头填充日记',1,11,1460343570,1460343570,60073566,1,'','',0),(937,'做脂肪移植15天，大家看看效果咋样',1,11,1460356233,1460356233,402902455,1,'','',0),(938,'现在不脱毛，更待何时啊',1,12,1460356681,1460356681,477390991,1,'','',0),(939,'我尝试了下玻尿酸丰唇',1,15,1460357828,1460357828,456848930,1,'','',0),(940,'吸脂减掉我的大粗腿',1,13,1460358228,1460358228,726176698,1,'','',0),(941,'坚持就是胜利，分享我的腹壁吸脂经历',1,13,1460358372,1460358372,556914415,1,'','',0),(943,'去颊脂垫',1,11,1460358820,1460358820,335274654,1,'','',0),(944,'硅胶330CC（腋下内视镜）手术后一个月',1,14,1460360189,1460360189,779692121,1,'','',0),(945,'矫正驼峰鼻',1,10,1460360946,1460360946,956863590,1,'','',0),(946,'卧蚕卧蚕，我做了卧蚕',1,11,1460361051,1460361051,903411317,1,'','',0),(947,'全切+开眼角，30天全记录',1,9,1460369814,1460369814,694890651,1,'','',0),(948,'小眼变电眼，双眼皮手术跻身圆眼妹',1,9,1460372955,1460372955,988107387,1,'','',0),(949,'我的面部改造计划',2,10,1460425088,1460425088,320295814,1,NULL,NULL,0),(950,'大婶变萌女，眼袋不见了',1,9,1460425689,1460425689,743789845,1,'','',0),(951,'祛眼袋一周，总算和眼袋白白了',1,9,1460426097,1460426097,243326844,1,'','',0),(952,'告别美颜相机，遗传性眼袋去掉了',1,9,1460426321,1460426321,292865815,1,'','',0),(953,'小内双变双眼皮，双眼皮恢复纪实',1,9,1460426535,1460426535,872371930,1,'','',0),(954,'做了双眼皮+隆鼻，电眼美女成形记',1,9,1460427045,1460427045,872371930,1,'','',0),(955,'双眼皮，去眼袋，整形让我年轻10岁',1,9,1460427663,1460427663,416130344,1,'','',0),(956,'开眼角+双眼皮让我变身大眼妹',1,9,1460428033,1460428033,787824779,1,'','',0),(957,'双眼皮全切，记录贴',1,9,1460428514,1460428514,399623422,1,'','',0),(958,'做双眼皮一冲动顺便做了鼻子，整个人都变了',1,9,1460428880,1460428880,203737511,1,'','',0),(959,'大腿吸脂+自体脂肪移植丰臀',1,13,1460620300,1460620300,306862977,1,'','',0),(960,'大腿吸脂术后8个月的后记',1,13,1460620766,1460620766,830600666,1,'','',0),(961,'面部吸脂整形手术后记',1,11,1460622709,1460622709,120829343,1,'','',0),(962,'告别鸡腿',1,13,1460623796,1460623796,312461138,1,'','',0),(963,'面部吸脂整形手术',1,11,1460683413,1460683413,973796455,1,'','',0),(965,'外貌改变了我的一生',1,11,1460684486,1460684486,313931150,1,'','',0),(966,'做了溶脂，从此四方脸变小V脸',1,11,1460685124,1460685124,322865809,1,'','',0),(967,'下巴整形改变人生',1,11,1460685862,1460685862,266364564,1,'','',0),(968,'隆胸，让我做真女人',1,14,1460686343,1460686343,270500510,1,'','',0),(969,'腹部脂肪吸脂',1,13,1460686721,1460686721,440925575,1,'','',0),(970,'隆胸，是我做过最对的选择',1,14,1460686981,1460686981,754322357,1,'','',0),(971,'假体隆胸',1,14,1460687308,1460687308,566472386,1,'','',0),(972,'假体隆胸的女孩',1,14,1460687850,1460687850,65983657,1,'','',0),(973,'自体脂肪丰胸后记',1,14,1460688025,1460688025,541104368,1,'','',0),(974,'假体285cc隆胸再手术5个多月后记',1,14,1460702854,1460702854,721000785,1,'','',0),(975,'即使生完孩，也要重视自己的胸部',1,14,1460703262,1460703262,583752415,1,'','',0),(976,'胸部变大了，更有自信了',1,14,1460703610,1460703610,563450421,1,'','',0),(977,'我拒绝再想起以前的自己',1,14,1460704251,1460704251,928188059,1,'','',0),(978,'变化“大大的”',1,14,1460705641,1460705641,217256685,1,'','',0),(980,'重返青春，致我的小V脸',1,11,1460706415,1460706415,843369688,1,'','',0),(981,'面部轮廓整形6个月后',2,11,1460707605,1460707605,512140113,1,NULL,NULL,0),(982,'面部轮廓整形6个月后',1,11,1460707673,1460707673,512140113,1,'','',0),(983,'面部吸脂后记',1,11,1460709106,1460709106,48025602,1,'','',0),(984,'再见了，小方脸',1,11,1460710182,1460710182,934893010,1,'','',0),(985,'觉得我变得有亲和力了吗',1,11,1460712129,1460712129,921249596,1,'','',0),(986,'眼睛的改变，让我这么美',1,9,1460712671,1460712671,42511265,1,'','',0),(987,'变美需要决心',1,11,1460716698,1460716698,6570781,1,'','',0),(988,'双眼皮变女神，只为自己更自信',1,9,1460717290,1460717290,846649983,1,'','',0),(989,'整形，让我变美丽',1,11,1460719567,1460719567,960991456,1,'','',0),(990,'胳膊吸脂后记',1,13,1460949652,1460949652,635705309,1,'','',0),(991,'颧骨突出让我失去自信',1,11,1460950397,1460950397,681232735,1,'','',0),(992,'改变，就在一瞬间',1,11,1460972492,1460972492,169152832,1,'','',0),(993,'变成娃娃脸',1,11,1460973408,1460973408,751423359,1,'','',0),(994,'埋线法双眼皮+开外眼角+软骨整形矫正短鼻+脸部自体脂肪移植',1,9,1460974144,1460974144,845577820,1,'','',0),(995,'切开法双眼皮+开内眼角整形2个月后',1,9,1460974585,1460974585,506624790,1,'','',0),(996,'自体脂肪丰胸，折腾了半年，感动死了',1,14,1461044947,1461044947,776809621,1,'','',0),(997,'太瘦反而不美',1,11,1461047540,1461047540,5934398,1,'','',0),(998,'颧骨缩小+溶脂',1,11,1461048167,1461048167,305222015,1,'','',0),(999,'玻尿酸填充法令纹+泪沟',1,11,1461049013,1461049013,258277174,1,'','',0),(1000,'小腿肌肉不见啦',1,13,1461049819,1461049819,371875422,1,'','',0),(1001,'瘦腿针3月后',1,13,1461054063,1461054063,328560380,1,'','',0),(1002,'鼻头又肉又大，打肉毒素就能缩小',1,10,1461056653,1461056653,627078701,1,'','',0),(1003,'玻尿酸丰唇垫下巴后记',1,15,1461057095,1461057095,208456024,1,'','',0),(1004,'看看我的轮廓，多漂亮呢',1,11,1461058029,1461058029,525100226,1,'','',0),(1005,'玻尿酸注射隆鼻，感觉自己美美哒',1,10,1461058851,1461058851,396406924,1,'','',0),(1006,'骗鬼的外貌不重要',1,10,1461059522,1461059522,325324811,1,'','',0),(1007,'矫正歪+矮+驼峰鼻，还有双眼皮',1,10,1461061756,1461061756,936484204,1,'','',0),(1008,'颧骨整形手术',1,11,1462245691,1462245691,988107387,1,'','',0),(1009,'双眼皮',1,9,1466059338,1466059338,856636367,1,'','3000元以下',0),(1010,'鼻子',2,10,1466059651,1466059651,856636367,1,NULL,NULL,0),(1011,'硅胶隆鼻',2,10,1466060715,1466060715,856636367,1,NULL,NULL,0),(1012,'玻尿酸隆鼻',1,10,1466060981,1466060981,856636367,1,'','',0),(1013,'玻尿酸隆鼻',1,10,1466061084,1466061084,856636367,1,'','',0),(1014,'健康检测',2,16,1466061720,1466061720,856636367,1,NULL,NULL,0),(1015,'哈哈哈',1,9,1466128429,1466128429,856636367,1,'全美百年','3000-6000元',0),(1016,'哈哈哈',1,9,1466128438,1466128438,856636367,1,'全美百年','3000-6000元',0),(1017,'呵呵呵',1,10,1466128602,1466128602,856636367,1,'全美百年','3000-6000元',0),(1018,'丰胸',1,14,1466129761,1466129761,856636367,1,'全美百年','6000-1万元',0),(1020,'ehfh',2,9,1466229529,1466229529,856636367,1,NULL,NULL,0),(1021,'vjj',1,9,1466229609,1466229609,856636367,1,'quanm','3000元以下',0),(1022,'鼻子之后几天',1,10,1466758307,1466758307,856636367,1,'全美','3000-6000元',0),(1023,'眼睛',2,9,1469255802,1469255802,321108478,1,NULL,NULL,0),(1024,'LOL空',1,10,1469256322,1469256322,321108478,1,'','',0),(1025,'隆鼻',1,10,1470373546,1470373546,321108478,1,'','1-2万元',0),(1026,'眼睛',2,9,1470647404,1470647404,594111915,1,NULL,NULL,0),(1027,'眼睛1714',2,9,1470647670,1470647670,594111915,1,NULL,NULL,0);
/*!40000 ALTER TABLE `qm_wenzhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_wenzhang_pl`
--

DROP TABLE IF EXISTS `qm_wenzhang_pl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_wenzhang_pl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(9) unsigned NOT NULL,
  `wid` int(10) unsigned NOT NULL,
  `userid2` int(9) unsigned NOT NULL DEFAULT '0' COMMENT '±»ÆÀÂÛÕßuserid',
  `parentid` int(10) unsigned NOT NULL DEFAULT '0',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=436 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ÆÀÂÛ¼ÇÂ¼±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_wenzhang_pl`
--

LOCK TABLES `qm_wenzhang_pl` WRITE;
/*!40000 ALTER TABLE `qm_wenzhang_pl` DISABLE KEYS */;
INSERT INTO `qm_wenzhang_pl` VALUES (281,594111915,355,0,0,1452051793),(282,594111915,355,0,0,1452051810),(286,594111915,355,0,282,1452063640),(287,594111915,355,0,282,1452063655),(288,594111915,355,0,282,1452063667),(289,594111915,355,0,282,1452063682),(290,594111915,355,0,282,1452063693),(291,594111915,355,0,282,1452063706),(292,594111915,355,0,282,1452063746),(293,594111915,356,0,0,1453608392),(294,594111915,356,0,0,1453608402),(296,594111915,356,0,0,1453702369),(299,813079450,355,0,0,1454052845),(301,813079450,355,0,0,1454056700),(310,813079450,355,0,0,1454058640),(315,594111915,358,0,0,1454059432),(316,594111915,358,0,0,1454059456),(317,594111915,358,0,0,1454059521),(318,594111915,358,0,0,1454059557),(319,594111915,358,0,0,1454059572),(320,594111915,358,0,0,1454059690),(321,594111915,357,0,0,1454059726),(322,594111915,357,0,0,1454059759),(323,594111915,357,0,0,1454059835),(324,594111915,357,0,0,1454059857),(325,594111915,357,0,0,1454059894),(326,594111915,358,0,0,1454060049),(327,594111915,358,0,0,1454060060),(328,594111915,358,0,0,1454060106),(329,594111915,358,0,0,1454060112),(331,594111915,357,0,0,1454060195),(332,594111915,357,0,0,1454060266),(333,594111915,358,0,0,1454060423),(334,594111915,357,0,0,1454060499),(335,594111915,357,0,0,1454060578),(336,594111915,357,0,0,1454060624),(337,594111915,357,0,0,1454060630),(338,594111915,357,0,0,1454060659),(339,594111915,357,0,0,1454060675),(340,594111915,357,0,0,1454060741),(351,607552052,371,0,0,1456541923),(352,813079450,371,0,0,1456542000),(353,594111915,355,0,0,1456542313),(354,594111915,355,0,0,1456542351),(355,594111915,355,0,0,1456542535),(356,746621638,355,594111915,355,1456628658),(357,436942141,419,0,0,1456899264),(358,746621638,406,0,0,1456918340),(359,848109072,413,0,0,1456976606),(360,682875857,850,0,0,1459846112),(361,609419201,915,0,0,1460341251),(362,956863590,903,0,0,1460373590),(363,960991456,986,0,0,1460719638),(364,960991456,974,0,0,1460719796),(365,635705309,986,0,0,1460949732),(366,635705309,985,0,0,1460949789),(367,635705309,983,0,0,1460949825),(368,635705309,980,0,0,1460949894),(369,635705309,980,0,368,1460949933),(370,681232735,987,0,0,1460950436),(371,681232735,984,0,0,1460950488),(372,681232735,980,0,0,1460950536),(373,169152832,991,0,0,1460972578),(374,169152832,990,0,0,1460972632),(375,169152832,989,0,0,1460972670),(376,169152832,988,0,0,1460972786),(377,169152832,974,0,0,1460972829),(378,169152832,968,0,0,1460972883),(379,169152832,962,0,0,1460972914),(380,169152832,961,0,0,1460972949),(381,751423359,992,0,0,1460973465),(382,751423359,989,0,0,1460973506),(383,751423359,987,0,0,1460973540),(384,751423359,984,681232735,371,1460973575),(385,506624790,987,0,0,1460974626),(386,506624790,986,635705309,365,1460974665),(387,506624790,985,635705309,366,1460974713),(388,506624790,975,0,0,1460974747),(389,506624790,965,0,0,1460974798),(390,776809621,978,0,0,1461045534),(391,776809621,977,0,0,1461045592),(392,776809621,973,0,0,1461045647),(393,776809621,972,0,0,1461045694),(394,776809621,970,0,0,1461045735),(395,328560380,1000,0,0,1461054181),(396,396406924,965,0,0,1461058759),(397,325324811,991,0,0,1461059653),(398,321108478,1008,0,0,1464580795),(399,559391868,854,0,0,1464605632),(400,968527806,1009,0,0,1466059677),(401,559391868,1009,0,0,1466059692),(402,968527806,1009,0,0,1466059697),(403,856636367,1009,968527806,402,1466059752),(404,856636367,1009,559391868,401,1466059791),(405,559391868,1009,0,401,1466059867),(406,856636367,1009,968527806,400,1466059875),(407,968527806,1010,0,0,1466060120),(408,968527806,1009,559391868,401,1466060192),(409,968527806,1012,0,0,1466061681),(410,968527806,1017,0,0,1466229439),(411,968527806,1017,0,0,1466229486),(412,246667211,1021,0,0,1466229701),(413,836100466,1021,246667211,412,1466229732),(414,968527806,1019,0,0,1466229735),(415,559391868,843,0,0,1466663406),(416,211377831,1021,0,0,1466733717),(418,856636367,1023,0,0,1469256232),(419,856636367,1024,0,0,1469256368),(420,594111915,1024,0,0,1470133554),(421,594111915,1021,0,0,1470646556),(422,594111915,1021,0,0,1470809496),(423,594111915,1021,836100466,412,1470811288),(424,594111915,1021,246667211,412,1470811534),(425,594111915,1021,211377831,416,1470812012),(426,594111915,1021,0,416,1470812284),(427,785251622,1021,836100466,412,1470812399),(428,785251622,1021,594111915,412,1470812426),(429,785251622,1021,246667211,412,1470812440),(430,785251622,1021,836100466,412,1470812540),(431,594111915,1021,785251622,412,1470817770),(432,594111915,1021,246667211,412,1470817802),(433,594111915,1021,0,412,1470821119),(434,594111915,1021,785251622,412,1470821324),(435,594111915,1021,246667211,412,1470821944);
/*!40000 ALTER TABLE `qm_wenzhang_pl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_yuyue`
--

DROP TABLE IF EXISTS `qm_yuyue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_yuyue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` varchar(255) NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  `tid` int(10) unsigned NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `dj_dsf_orderid` varchar(255) DEFAULT NULL,
  `dj_dsf_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dj_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `dj_real_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `dj_hf_point` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `dj_point_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `wk_dsf_orderid` varchar(255) DEFAULT NULL,
  `wk_dsf_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `wk_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `wk_type` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `wk_real_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `wk_point_money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `wk_hf_point` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `server_id` int(10) unsigned NOT NULL DEFAULT '0',
  `get_point` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `detail_img` text,
  `create_time` int(10) unsigned NOT NULL DEFAULT '0',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_yuyue`
--

LOCK TABLES `qm_yuyue` WRITE;
/*!40000 ALTER TABLE `qm_yuyue` DISABLE KEYS */;
INSERT INTO `qm_yuyue` VALUES (1,'quanmei20160527114346',594111915,134,3,NULL,0,1.00,0.50,50.00,0.50,NULL,0,1.00,2,0.00,2.00,200.00,974,0.00,'[\"images/order/quanmei20160527114346/1.jpg\",\"images/order/quanmei20160527114346/2.jpg\",\"images/order/quanmei20160527114346/3.jpg\"]',1464320626,1464320626),(2,'quanmei20160527114524',449039907,134,9,NULL,0,1.00,0.00,0.00,0.00,'2016052721001004710245675575',1,1.00,0,1.00,0.00,0.00,0,0.00,NULL,1464320724,1464328229),(3,'quanmei20160527114637',449039907,134,9,'2016052721001004710245167680',1,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1464320797,1464328226),(4,'quanmei20160527114743',449039907,134,9,NULL,0,1.00,0.00,0.00,0.00,'2016052721001004710245675639',1,1.00,0,2.00,0.00,0.00,0,0.00,NULL,1464320863,1464328223),(5,'quanmei20160527114908',449039907,134,9,'2016052721001004710246680269',1,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1464320948,1464328219),(6,'quanmei20160527115114',594111915,134,9,'2016052721001004020257217473',1,1.00,0.00,0.00,0.00,'2016052721001004020256737680',1,1.00,0,1.00,0.00,0.00,0,0.00,NULL,1464321074,1464321359),(7,'quanmei20160527121119',300771575,134,9,'2016052721001004330211364618',1,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1464322279,1464322351),(8,'quanmei20160527121513',300771575,134,9,'4006572001201605276366991913',2,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1464322513,1464322542),(9,'quanmei20160527131001',594111915,134,4,'2016052721001004020258439389',1,1.00,0.20,80.00,0.80,'2016052721001004020255910723',1,1.00,2,0.50,0.50,50.00,974,70.00,'[\"images/order/quanmei20160527131001/1.jpg\",\"images/order/quanmei20160527131001/2.jpg\"]',1464325801,1464326858),(10,'quanmei20160527133832',594111915,134,6,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,974,0.00,'[\"images/order/quanmei20160527133832/1.jpg\"]',1464327512,1464327512),(11,'quanmei20160527135018',594111915,134,3,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,974,0.00,'[\"images/order/quanmei20160527135018/1.jpg\",\"images/order/quanmei20160527135018/2.jpg\"]',1464328218,1464328218),(12,'quanmei20160527135043',449039907,134,4,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,974,0.00,'[\"images/order/quanmei20160527135043/1.png\",\"images/order/quanmei20160527135043/2.png\",\"images/order/quanmei20160527135043/3.png\"]',1464328243,1464329552),(13,'quanmei20160527135913',594111915,134,3,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,974,0.00,'[\"images/order/quanmei20160527135913/1.jpg\",\"images/order/quanmei20160527135913/2.jpg\",\"images/order/quanmei20160527135913/3.jpg\"]',1464328753,1464328753),(14,'quanmei20160527141543',449039907,134,4,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,974,0.00,'[\"images/order/quanmei20160527141543/1.png\",\"images/order/quanmei20160527141543/2.png\"]',1464329743,1464331585),(15,'quanmei20160527143354',436942141,133,1,NULL,0,1990.00,0.00,0.00,0.00,NULL,0,1990.00,0,0.00,0.00,0.00,0,0.00,NULL,1464330834,1464330834),(16,'quanmei20160527151257',449039907,134,4,NULL,0,1.00,0.00,100.00,1.00,NULL,0,1.00,2,0.00,1.00,100.00,974,0.00,'[\"images/order/quanmei20160527151257/1.png\"]',1464333177,1464333758),(17,'quanmei20160527151848',449039907,134,1,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1464333528,1464333528),(18,'quanmei20160530184309',275116302,139,1,NULL,0,6000.00,0.00,0.00,0.00,NULL,0,6000.00,0,0.00,0.00,0.00,0,0.00,NULL,1464604989,1464604989),(19,'quanmei20160601114348',594111915,135,1,NULL,0,100.00,0.00,0.00,0.00,NULL,0,180.00,0,0.00,0.00,0.00,0,0.00,NULL,1464752628,1464752628),(20,'quanmei20160601115601',887915923,134,4,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,975,0.00,'[\"images/order/quanmei20160601115601/1.jpg\"]',1464753361,1464753748),(21,'quanmei20160601142048',856636367,134,4,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,975,0.00,'[\"images/order/quanmei20160601142048/1.jpg\"]',1464762048,1464923264),(22,'quanmei20160603100942',856636367,134,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,975,0.00,NULL,1464919782,1464919971),(23,'quanmei20160603110344',856636367,134,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,975,0.00,NULL,1464923024,1464923220),(24,'quanmei20160606163811',990318397,138,1,NULL,0,34000.00,0.00,0.00,0.00,NULL,0,34000.00,0,0.00,0.00,0.00,0,0.00,NULL,1465202291,1465202291),(31,'quanmei20160615151524',436942141,140,1,NULL,0,3400.00,0.00,0.00,0.00,NULL,0,3400.00,0,0.00,0.00,0.00,0,0.00,NULL,1465974924,1465974924),(32,'quanmei20160616100435',436942141,159,1,NULL,0,98.00,0.00,0.00,0.00,NULL,0,882.00,0,0.00,0.00,0.00,0,0.00,NULL,1466042675,1466042675),(33,'quanmei20160616153252',968527806,162,1,NULL,0,298.00,297.99,1.00,0.01,NULL,0,2682.00,0,0.00,0.00,0.00,0,0.00,NULL,1466062372,1466062372),(37,'quanmei20160616155349',968527806,153,1,NULL,0,800.00,0.00,0.00,0.00,NULL,0,7200.00,0,0.00,0.00,0.00,0,0.00,NULL,1466063629,1466063629),(38,'quanmei20160618140427',968527806,151,1,NULL,0,300.00,300.00,0.00,0.00,NULL,0,2700.00,0,0.00,0.00,0.00,0,0.00,NULL,1466229867,1466229867),(40,'quanmei20160618140724',856636367,139,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1466230044,1466753830),(41,'quanmei20160618140918',321108478,139,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1466230158,1469256537),(43,'quanmei20160620174645',436942141,140,1,NULL,0,3400.00,0.00,0.00,0.00,NULL,0,3400.00,0,0.00,0.00,0.00,0,0.00,NULL,1466416005,1466416005),(44,'quanmei20160623114057',856636367,139,3,NULL,0,1.00,0.00,100.00,1.00,'2016062321001004200241373279',1,1.00,2,1.00,0.00,0.00,975,100.00,'[\"images/order/quanmei20160623114057/1.jpg\"]',1466653257,1466655094),(48,'quanmei20160629182519',856636367,135,1,NULL,0,28.00,0.00,0.00,0.00,NULL,0,252.00,0,0.00,0.00,0.00,0,0.00,NULL,1467195919,1467195919),(50,'quanmei20160701145843',594111915,195,1,NULL,0,600.00,0.00,0.00,0.00,NULL,0,5400.00,0,0.00,0.00,0.00,0,0.00,NULL,1467356323,1467356323),(51,'quanmei20160704124721',436942141,167,1,NULL,0,160.00,160.00,0.00,0.00,NULL,0,1440.00,0,0.00,0.00,0.00,0,0.00,NULL,1467607641,1467607641),(52,'quanmei20160719162702',594111915,201,1,NULL,0,500.00,0.00,0.00,0.00,NULL,0,4500.00,0,0.00,0.00,0.00,0,0.00,NULL,1468916822,1468916822),(55,'quanmei20160721194619',559391868,153,3,NULL,0,1.00,0.00,100.00,1.00,NULL,0,1.00,2,0.00,1.00,100.00,975,0.00,'[\"images/order/quanmei20160721194619/1.jpg\"]',1469101579,1469101579),(57,'quanmei20160721195050',246667211,153,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1469101850,1469150259),(58,'quanmei20160722091534',398846095,153,3,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,975,0.00,'[\"images/order/quanmei20160722091534/1.jpg\"]',1469150134,1469150134),(59,'quanmei20160722091602',246667211,153,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1469150162,1469150257),(60,'quanmei20160722171136',594111915,139,1,NULL,0,1200.00,1200.00,0.00,0.00,NULL,0,10800.00,0,0.00,0.00,0.00,0,0.00,NULL,1469178696,1469178696),(61,'quanmei20160722171540',594111915,165,9,'2016072221001004020242023799',1,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1469178940,1469179110),(62,'quanmei20160722172201',594111915,165,7,NULL,0,1.00,0.00,0.00,0.00,'2016072221001004020244989729',1,1.00,2,2.00,0.00,0.00,0,200.00,NULL,1469179321,1470208591),(63,'quanmei20160722172306',594111915,165,9,NULL,0,1.00,0.00,0.00,0.00,'2016072221001004020243102533',1,1.00,0,2.00,0.00,0.00,0,0.00,NULL,1469179386,1469179867),(64,'quanmei20160723145736',321108478,184,4,NULL,0,1.00,0.00,100.00,1.00,'2016072321001004200290708141',1,1.00,2,1.00,0.00,0.00,975,100.00,'[\"images/order/quanmei20160723145736/1.jpg\"]',1469257056,1470111626),(65,'quanmei20160723150417',321108478,184,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,975,0.00,NULL,1469257457,1470111519),(68,'quanmei20160724162142',992902128,168,1,NULL,0,200.00,0.00,0.00,0.00,NULL,0,1000.00,0,1200.00,0.00,0.00,0,0.00,NULL,1469348502,1469348502),(71,'quanmei20160724182104',787747603,168,3,'2016072421001004760249351225',1,200.00,200.00,0.00,0.00,NULL,0,1000.00,1,1000.00,0.00,0.00,975,120000.00,'[\"images/order/quanmei20160724182104/1.jpg\"]',1469355664,1469355776),(72,'quanmei20160724182109',787747603,168,3,'2016072421001004760250805463',1,200.00,198.01,199.00,1.99,NULL,0,1000.00,1,1000.00,0.00,0.00,975,119801.00,'[\"images/order/quanmei20160724182109/1.jpg\"]',1469355669,1469355708),(73,'quanmei20160726103349',594111915,165,2,NULL,0,1.00,0.00,100.00,1.00,NULL,0,9.00,0,0.00,0.00,0.00,0,0.00,NULL,1469500429,1469500429),(76,'quanmei20160727104252',321108478,165,4,NULL,0,1.00,0.00,100.00,1.00,NULL,0,1.00,1,1.00,0.00,0.00,975,100.00,'[\"images/order/quanmei20160727104252/1.jpg\"]',1469587372,1469588347),(77,'quanmei20160727130945',856636367,197,1,NULL,0,140.00,0.00,0.00,0.00,NULL,0,1260.00,0,0.00,0.00,0.00,0,0.00,NULL,1469596185,1469596185),(78,'quanmei20160727145322',856636367,165,3,NULL,0,1.00,0.00,100.00,1.00,NULL,0,1.00,1,1.00,0.00,0.00,975,100.00,'[\"images/order/quanmei20160727145322/1.jpg\"]',1469602402,1469602402),(79,'quanmei20160729183951',12279597,165,1,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1469788791,1469788791),(80,'quanmei20160731174224',240291002,143,1,NULL,0,19000.00,19000.00,0.00,0.00,NULL,0,19000.00,0,0.00,0.00,0.00,0,0.00,NULL,1469958144,1469958144),(81,'quanmei20160801170729',607552052,165,1,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1470042449,1470042449),(82,'quanmei20160802102120',594111915,165,1,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1470104480,1470104480),(83,'quanmei20160802122115',321108478,165,9,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1470111675,1470111731),(84,'quanmei20160802122434',321108478,165,3,NULL,0,1.00,0.00,0.00,0.00,'2016080221001004200233741770',1,1.00,2,2.00,0.00,0.00,975,200.00,'[\"images/order/quanmei20160802122434/1.jpg\"]',1470111874,1470111923),(85,'quanmei20160802124032',321108478,165,7,'2016080221001004200236450747',1,1.00,0.90,10.00,0.10,NULL,0,1.00,2,0.00,1.00,100.00,0,0.00,NULL,1470112832,1470113083),(86,'quanmei20160802124450',321108478,165,3,NULL,0,1.00,0.00,0.00,0.00,'2016080221001004200234801445',1,1.00,2,1.10,0.90,90.00,975,110.00,'[\"images/order/quanmei20160802124450/1.jpg\"]',1470113090,1470113117),(87,'quanmei20160802124726',321108478,165,3,NULL,0,1.00,0.00,0.00,0.00,'2016080221001004200234368482',1,1.00,2,1.00,1.00,100.00,975,100.00,'[\"images/order/quanmei20160802124726/1.jpg\"]',1470113246,1470113273),(88,'quanmei20160802124900',321108478,165,3,NULL,0,1.00,0.00,100.00,1.00,'2016080221001004200236200191',1,1.00,2,1.00,0.00,0.00,975,100.00,'[\"images/order/quanmei20160802124900/1.jpg\"]',1470113340,1470113373),(89,'quanmei20160803115802',594111915,165,8,'2016080321001004020297127624',1,1.00,1.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1470196682,1470207869),(90,'quanmei20160804124155',594111915,159,1,NULL,0,100.00,0.00,0.00,0.00,NULL,0,900.00,0,0.00,0.00,0.00,0,0.00,NULL,1470285715,1470285715),(91,'quanmei20160809151539',594111915,174,1,NULL,0,120.00,0.00,0.00,0.00,NULL,0,1080.00,0,0.00,0.00,0.00,0,0.00,NULL,1470726939,1470726939),(93,'quanmei20160811174548',321108478,165,3,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,2,0.00,2.00,200.00,975,0.00,'[\"images/order/quanmei20160811174548/1.jpg\"]',1470908748,1470908748),(94,'quanmei20160811174857',321108478,165,3,NULL,0,1.00,0.00,100.00,1.00,NULL,0,1.00,1,1.00,0.00,0.00,975,1.00,'[\"images/order/quanmei20160811174857/1.jpg\"]',1470908937,1470908937),(95,'quanmei20160815214305',594111915,165,1,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1471268585,1471268585),(96,'quanmei20160815215215',594111915,165,1,NULL,0,1.00,0.00,0.00,0.00,NULL,0,1.00,0,0.00,0.00,0.00,0,0.00,NULL,1471269135,1471269135);
/*!40000 ALTER TABLE `qm_yuyue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_zan`
--

DROP TABLE IF EXISTS `qm_zan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_zan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zanid` int(10) unsigned NOT NULL,
  `type` tinyint(1) unsigned NOT NULL,
  `userid` int(9) unsigned NOT NULL,
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ç‚¹èµžè®°å½•è¡¨';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_zan`
--

LOCK TABLES `qm_zan` WRITE;
/*!40000 ALTER TABLE `qm_zan` DISABLE KEYS */;
INSERT INTO `qm_zan` VALUES (92,269,2,594111915,1451105411),(94,273,2,436942141,1451195554),(98,269,2,12279597,1451369561),(117,282,2,594111915,1452062495),(125,298,2,436942141,1453734623),(126,356,1,449039907,1453776783),(128,282,2,813079450,1454052875),(132,281,2,813079450,1454053191),(133,355,1,813079450,1454053309),(146,310,2,813079450,1454058798),(147,301,2,813079450,1454058808),(148,299,2,813079450,1454058823),(150,302,2,594111915,1454058858),(151,309,2,594111915,1454058914),(153,311,2,594111915,1454059150),(154,311,2,813079450,1454059171),(155,302,2,813079450,1454059173),(156,273,2,813079450,1454059178),(157,313,2,813079450,1454059242),(158,314,2,594111915,1454059301),(159,358,1,594111915,1454059420),(161,357,1,594111915,1454059789),(162,325,2,594111915,1454059933),(163,331,2,594111915,1454060201),(164,332,2,594111915,1454060383),(165,324,2,594111915,1454060386),(166,323,2,594111915,1454060388),(167,322,2,594111915,1454060390),(168,316,2,594111915,1454060476),(169,317,2,594111915,1454060483),(170,318,2,594111915,1454060487),(171,334,2,594111915,1454060510),(172,333,2,594111915,1454060952),(173,330,2,594111915,1454060954),(174,329,2,594111915,1454060973),(176,328,2,594111915,1454060982),(177,340,2,594111915,1454061021),(181,341,2,594111915,1454390367),(182,342,2,594111915,1454390382),(186,274,2,594111915,1456138687),(188,371,1,607552052,1456541902),(189,371,1,813079450,1456541994),(190,355,1,594111915,1456542619),(191,296,2,746621638,1456645479),(192,379,1,746621638,1456823546),(193,391,1,436942141,1456824306),(194,390,1,436942141,1456824316),(195,414,1,746621638,1456892604),(196,419,1,436942141,1456899184),(197,413,1,594111915,1456976247),(198,412,1,594111915,1456976260),(199,390,1,594111915,1456976272),(200,379,1,594111915,1456976290),(201,359,2,594111915,1456976630),(202,431,1,436942141,1457078064),(203,406,1,436942141,1457241934),(205,655,1,594111915,1458537621),(206,703,1,594111915,1458812140),(207,687,1,594111915,1458813291),(214,855,1,682875857,1459846041),(215,856,1,682875857,1459846056),(216,851,1,682875857,1459846061),(217,850,1,682875857,1459846068),(220,858,1,246667211,1459999034),(222,910,1,694890651,1460176340),(224,925,1,609419201,1460341130),(225,922,1,609419201,1460341175),(226,881,1,700944948,1460342766),(227,903,1,956863590,1460373569),(228,969,1,928188059,1460703916),(229,968,1,928188059,1460703923),(230,967,1,928188059,1460703928),(232,965,1,928188059,1460703987),(233,961,1,928188059,1460703993),(234,975,1,928188059,1460704262),(235,974,1,928188059,1460704267),(236,973,1,928188059,1460704272),(237,972,1,928188059,1460704276),(238,971,1,928188059,1460704280),(239,970,1,928188059,1460704286),(240,944,1,928188059,1460704292),(241,976,1,928188059,1460704302),(242,977,1,217256685,1460705459),(243,976,1,217256685,1460705464),(244,974,1,217256685,1460705474),(245,973,1,217256685,1460705478),(246,972,1,217256685,1460705482),(247,971,1,217256685,1460705486),(248,970,1,217256685,1460705490),(249,969,1,217256685,1460705494),(250,968,1,217256685,1460705499),(251,967,1,217256685,1460705513),(252,966,1,217256685,1460705518),(253,963,1,217256685,1460705523),(254,965,1,217256685,1460705527),(255,961,1,217256685,1460705534),(256,960,1,217256685,1460705538),(257,959,1,217256685,1460705542),(258,957,1,217256685,1460705548),(259,978,1,843369688,1460706058),(260,976,1,843369688,1460706065),(261,969,1,843369688,1460706078),(262,970,1,843369688,1460706084),(263,971,1,843369688,1460706093),(264,982,1,48025602,1460709151),(265,980,1,48025602,1460709159),(266,967,1,48025602,1460709165),(267,966,1,48025602,1460709172),(268,965,1,48025602,1460709177),(269,963,1,48025602,1460709183),(270,961,1,48025602,1460709188),(271,946,1,48025602,1460709195),(272,943,1,48025602,1460709208),(273,937,1,48025602,1460709213),(274,936,1,48025602,1460709226),(275,932,1,48025602,1460709231),(276,930,1,48025602,1460709236),(277,929,1,48025602,1460709242),(278,928,1,48025602,1460709251),(279,926,1,48025602,1460709261),(280,925,1,48025602,1460709266),(282,915,1,48025602,1460709287),(283,904,1,48025602,1460709292),(284,903,1,48025602,1460709298),(285,901,1,48025602,1460709303),(286,887,1,48025602,1460709309),(287,880,1,48025602,1460709313),(288,868,1,48025602,1460709320),(289,867,1,48025602,1460709325),(290,866,1,48025602,1460709330),(291,865,1,48025602,1460709339),(292,864,1,48025602,1460709351),(293,863,1,48025602,1460709370),(295,862,1,48025602,1460709389),(296,783,1,48025602,1460709394),(297,781,1,48025602,1460709399),(300,983,1,934893010,1460710191),(301,982,1,934893010,1460710198),(302,980,1,934893010,1460710206),(303,967,1,934893010,1460710212),(304,966,1,934893010,1460710217),(305,965,1,934893010,1460710221),(306,963,1,934893010,1460710226),(307,961,1,934893010,1460710230),(308,984,1,921249596,1460712184),(309,983,1,921249596,1460712189),(310,982,1,921249596,1460712195),(311,981,1,921249596,1460712201),(312,980,1,921249596,1460712206),(313,978,1,921249596,1460712211),(314,977,1,921249596,1460712219),(315,976,1,921249596,1460712224),(316,975,1,921249596,1460712229),(317,974,1,921249596,1460712234),(318,986,1,42511265,1460712679),(319,958,1,42511265,1460712684),(320,956,1,42511265,1460712692),(321,955,1,42511265,1460712696),(322,954,1,42511265,1460712701),(323,953,1,42511265,1460712705),(324,952,1,42511265,1460712710),(325,951,1,42511265,1460712715),(326,950,1,42511265,1460712722),(327,986,1,6570781,1460716602),(328,983,1,6570781,1460716609),(329,978,1,6570781,1460716617),(330,976,1,6570781,1460716622),(331,946,1,6570781,1460716723),(332,937,1,6570781,1460716730),(333,932,1,6570781,1460716734),(334,930,1,6570781,1460716739),(335,929,1,6570781,1460716743),(336,928,1,6570781,1460716750),(337,986,1,846649983,1460717181),(338,958,1,846649983,1460717185),(339,957,1,846649983,1460717188),(340,956,1,846649983,1460717192),(341,955,1,846649983,1460717197),(342,954,1,846649983,1460717201),(343,953,1,846649983,1460717205),(344,952,1,846649983,1460717209),(345,951,1,846649983,1460717213),(346,950,1,846649983,1460717217),(347,987,1,960991456,1460719608),(348,986,1,960991456,1460719612),(349,985,1,960991456,1460719711),(350,984,1,960991456,1460719715),(351,983,1,960991456,1460719719),(352,981,1,960991456,1460719723),(353,980,1,960991456,1460719727),(354,978,1,960991456,1460719734),(355,977,1,960991456,1460719748),(356,976,1,960991456,1460719758),(357,974,1,960991456,1460719769),(358,989,1,635705309,1460949690),(359,986,1,635705309,1460949711),(360,985,1,635705309,1460949752),(361,983,1,635705309,1460949814),(362,984,1,681232735,1460950463),(363,991,1,169152832,1460972546),(364,990,1,169152832,1460972596),(365,989,1,169152832,1460972642),(366,988,1,169152832,1460972687),(367,992,1,751423359,1460973443),(368,991,1,751423359,1460973638),(369,986,1,751423359,1460973646),(370,984,1,751423359,1460973652),(371,988,1,845577820,1460974169),(372,986,1,845577820,1460974173),(373,958,1,845577820,1460974177),(374,957,1,845577820,1460974181),(375,955,1,845577820,1460974186),(376,952,1,845577820,1460974194),(377,986,1,506624790,1460974670),(378,975,1,506624790,1460974751),(379,978,1,776809621,1461045455),(380,977,1,776809621,1461045594),(381,976,1,776809621,1461045600),(382,974,1,776809621,1461045607),(383,972,1,776809621,1461045699),(384,971,1,776809621,1461045704),(385,970,1,776809621,1461045710),(386,995,1,776809621,1461045745),(387,994,1,776809621,1461045749),(388,993,1,776809621,1461045753),(389,992,1,776809621,1461045756),(390,991,1,776809621,1461045760),(391,990,1,776809621,1461045765),(392,989,1,776809621,1461045768),(393,988,1,776809621,1461045772),(394,987,1,776809621,1461045777),(395,986,1,776809621,1461045783),(396,985,1,776809621,1461045806),(397,984,1,776809621,1461045809),(398,983,1,776809621,1461045813),(399,982,1,776809621,1461045817),(400,995,1,5934398,1461047334),(401,994,1,5934398,1461047338),(402,993,1,5934398,1461047342),(403,992,1,5934398,1461047345),(404,991,1,5934398,1461047349),(405,990,1,5934398,1461047353),(406,989,1,5934398,1461047356),(407,988,1,5934398,1461047360),(408,987,1,5934398,1461047364),(409,986,1,5934398,1461047377),(410,985,1,5934398,1461047384),(411,984,1,5934398,1461047388),(412,983,1,5934398,1461047391),(413,980,1,5934398,1461047400),(414,977,1,5934398,1461047405),(415,976,1,5934398,1461047409),(416,997,1,305222015,1461048181),(418,992,1,305222015,1461048187),(419,991,1,305222015,1461048190),(420,989,1,305222015,1461048194),(421,987,1,305222015,1461048198),(422,985,1,305222015,1461048201),(423,984,1,305222015,1461048205),(424,983,1,305222015,1461048209),(425,982,1,305222015,1461048231),(426,980,1,305222015,1461048238),(427,967,1,305222015,1461048241),(428,966,1,305222015,1461048245),(429,965,1,305222015,1461048249),(430,963,1,305222015,1461048252),(431,961,1,305222015,1461048256),(432,946,1,305222015,1461048261),(433,943,1,305222015,1461048266),(434,937,1,305222015,1461048275),(435,936,1,305222015,1461048278),(436,932,1,305222015,1461048283),(437,930,1,305222015,1461048286),(438,929,1,305222015,1461048291),(439,928,1,305222015,1461048295),(440,926,1,305222015,1461048299),(441,925,1,305222015,1461048303),(442,917,1,305222015,1461048307),(443,915,1,305222015,1461048311),(444,904,1,305222015,1461048322),(445,903,1,305222015,1461048326),(446,887,1,305222015,1461048332),(447,867,1,305222015,1461048342),(448,865,1,305222015,1461048348),(449,864,1,305222015,1461048354),(450,863,1,305222015,1461048394),(451,996,1,305222015,1461048462),(452,995,1,305222015,1461048466),(453,994,1,305222015,1461048469),(454,993,1,305222015,1461048474),(455,999,1,258277174,1461049050),(456,998,1,258277174,1461049055),(457,997,1,258277174,1461049059),(458,996,1,258277174,1461049063),(459,995,1,258277174,1461049069),(460,994,1,258277174,1461049072),(461,993,1,258277174,1461049076),(462,992,1,258277174,1461049081),(463,991,1,258277174,1461049085),(464,990,1,258277174,1461049091),(465,989,1,258277174,1461049115),(466,988,1,258277174,1461049119),(467,987,1,258277174,1461049123),(468,986,1,258277174,1461049128),(469,985,1,258277174,1461049133),(470,984,1,258277174,1461049140),(471,983,1,258277174,1461049154),(472,982,1,258277174,1461049158),(473,981,1,258277174,1461049194),(474,980,1,258277174,1461049230),(475,990,1,371875422,1461049840),(476,969,1,371875422,1461049854),(477,962,1,371875422,1461049860),(478,960,1,371875422,1461049881),(479,941,1,371875422,1461049910),(480,998,1,371875422,1461049918),(481,995,1,371875422,1461049959),(482,994,1,371875422,1461049966),(483,993,1,371875422,1461049973),(484,992,1,371875422,1461049977),(485,999,1,328560380,1461054350),(486,998,1,328560380,1461054480),(487,997,1,328560380,1461054498),(488,996,1,328560380,1461054502),(489,995,1,328560380,1461054522),(490,994,1,328560380,1461054527),(491,993,1,328560380,1461054531),(492,992,1,328560380,1461054535),(493,991,1,328560380,1461054619),(494,990,1,328560380,1461054627),(495,989,1,328560380,1461054631),(496,988,1,328560380,1461054635),(497,987,1,328560380,1461054640),(498,986,1,328560380,1461054644),(499,984,1,328560380,1461054667),(500,983,1,328560380,1461054672),(501,982,1,328560380,1461054678),(502,980,1,328560380,1461054690),(503,978,1,328560380,1461054694),(504,977,1,328560380,1461054698),(505,976,1,328560380,1461054702),(506,975,1,328560380,1461054706),(507,974,1,328560380,1461054710),(508,973,1,328560380,1461054714),(509,972,1,328560380,1461054721),(510,971,1,328560380,1461054726),(511,970,1,328560380,1461054795),(512,969,1,328560380,1461054799),(513,968,1,328560380,1461054803),(515,895,1,627078701,1461056711),(516,918,1,627078701,1461056720),(517,1002,1,208456024,1461056942),(518,1001,1,208456024,1461056946),(519,1000,1,208456024,1461056950),(520,999,1,208456024,1461056954),(521,998,1,208456024,1461056957),(522,997,1,208456024,1461056961),(523,996,1,208456024,1461056964),(524,995,1,208456024,1461056967),(525,994,1,208456024,1461056970),(526,993,1,208456024,1461056974),(527,992,1,208456024,1461056988),(528,991,1,208456024,1461056991),(529,990,1,208456024,1461056995),(530,989,1,208456024,1461056999),(531,988,1,208456024,1461057003),(532,986,1,208456024,1461057010),(533,985,1,208456024,1461057014),(534,984,1,208456024,1461057018),(535,983,1,208456024,1461057021),(536,939,1,208456024,1461057037),(537,869,1,208456024,1461057041),(538,1003,1,525100226,1461058054),(539,1002,1,525100226,1461058057),(540,1001,1,525100226,1461058061),(541,1000,1,525100226,1461058064),(542,999,1,525100226,1461058068),(543,998,1,525100226,1461058072),(544,997,1,525100226,1461058076),(545,996,1,525100226,1461058080),(546,995,1,525100226,1461058083),(548,993,1,525100226,1461058098),(549,992,1,525100226,1461058102),(550,991,1,525100226,1461058106),(551,990,1,525100226,1461058110),(552,989,1,525100226,1461058115),(553,988,1,525100226,1461058119),(554,987,1,525100226,1461058123),(555,986,1,525100226,1461058126),(556,985,1,525100226,1461058135),(557,984,1,525100226,1461058139),(558,983,1,525100226,1461058142),(559,982,1,525100226,1461058145),(560,981,1,525100226,1461058148),(561,980,1,525100226,1461058152),(562,978,1,525100226,1461058156),(563,977,1,525100226,1461058159),(564,976,1,525100226,1461058163),(565,975,1,525100226,1461058165),(566,1004,1,396406924,1461058541),(567,1003,1,396406924,1461058545),(568,1002,1,396406924,1461058548),(569,1001,1,396406924,1461058551),(570,1000,1,396406924,1461058555),(571,999,1,396406924,1461058558),(572,998,1,396406924,1461058562),(573,997,1,396406924,1461058565),(574,996,1,396406924,1461058568),(575,995,1,396406924,1461058572),(576,994,1,396406924,1461058581),(577,993,1,396406924,1461058584),(578,992,1,396406924,1461058587),(579,991,1,396406924,1461058590),(580,990,1,396406924,1461058594),(581,989,1,396406924,1461058598),(582,988,1,396406924,1461058601),(583,987,1,396406924,1461058605),(584,986,1,396406924,1461058608),(585,985,1,396406924,1461058611),(588,984,1,396406924,1461058633),(589,982,1,396406924,1461058640),(590,981,1,396406924,1461058644),(591,980,1,396406924,1461058647),(592,978,1,396406924,1461058650),(593,977,1,396406924,1461058654),(594,976,1,396406924,1461058657),(595,975,1,396406924,1461058662),(596,974,1,396406924,1461058670),(597,973,1,396406924,1461058686),(598,972,1,396406924,1461058690),(599,971,1,396406924,1461058693),(600,970,1,396406924,1461058697),(601,969,1,396406924,1461058701),(602,859,1,196931447,1461058703),(603,968,1,396406924,1461058705),(604,967,1,396406924,1461058709),(605,966,1,396406924,1461058716),(606,965,1,396406924,1461058729),(607,1005,1,325324811,1461059539),(608,1002,1,325324811,1461059543),(609,945,1,325324811,1461059548),(610,922,1,325324811,1461059552),(611,918,1,325324811,1461059555),(612,911,1,325324811,1461059558),(613,910,1,325324811,1461059562),(614,908,1,325324811,1461059567),(615,1004,1,325324811,1461059576),(616,1003,1,325324811,1461059581),(617,1001,1,325324811,1461059588),(618,1000,1,325324811,1461059591),(619,999,1,325324811,1461059596),(620,998,1,325324811,1461059600),(621,997,1,325324811,1461059604),(622,996,1,325324811,1461059608),(623,995,1,325324811,1461059624),(624,994,1,325324811,1461059628),(625,993,1,325324811,1461059631),(626,991,1,325324811,1461059635),(627,986,1,325324811,1461059666),(628,985,1,325324811,1461059671),(629,983,1,325324811,1461059676),(630,982,1,325324811,1461059680),(631,1007,1,518396413,1461209953),(632,1007,1,436942141,1461743409),(633,1008,1,321108478,1464580745),(634,859,1,435496725,1465706001),(635,858,1,435496725,1465706011),(638,1009,1,968527806,1466059718),(639,1010,1,246667211,1466059860),(640,1012,1,968527806,1466061720),(641,409,2,968527806,1466061751),(642,1013,1,968527806,1466061969),(643,859,1,246667211,1466062062),(646,856,1,246667211,1466062111),(647,855,1,246667211,1466062132),(650,854,1,246667211,1466062177),(651,1003,1,246667211,1466063175),(652,1017,1,968527806,1466229453),(653,1021,1,246667211,1466229689),(655,997,1,246667211,1466230595),(657,993,1,246667211,1466230672),(658,909,1,246667211,1466232783),(660,858,1,187018269,1468162248),(661,1023,1,856636367,1469256220),(662,1024,1,856636367,1469256356),(663,419,2,856636367,1469256374),(664,419,2,594111915,1470121498),(666,1024,1,785251622,1470121819),(669,1024,1,594111915,1470638937),(674,1021,1,594111915,1470646506),(675,986,1,594111915,1470658284),(676,416,2,594111915,1470808066),(679,412,2,594111915,1470817835),(682,412,2,449039907,1471079500),(683,1027,1,449039907,1471096929),(684,859,1,594111915,1471338393),(685,1027,1,594111915,1471340102);
/*!40000 ALTER TABLE `qm_zan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qm_zf_record`
--

DROP TABLE IF EXISTS `qm_zf_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qm_zf_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trade_no` varchar(255) NOT NULL,
  `out_trade_no` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `intime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ö§¸¶¼ÇÂ¼±í';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qm_zf_record`
--

LOCK TABLES `qm_zf_record` WRITE;
/*!40000 ALTER TABLE `qm_zf_record` DISABLE KEYS */;
INSERT INTO `qm_zf_record` VALUES (78,'2015122521001004870088790368','quanmei20151225182318',1,1451039178),(79,'2015122621001004020002066410','quanmei20151222103655',1,1451105538),(80,'2015122621001004710092930034','quanmei20151226142444',1,1451111097),(81,'2015122621001004710061162654','quanmei20151226142421',1,1451111132),(82,'2015122621001004870015636574','quanmei20151226144453',1,1451112313),(83,'2015122621001004020007868118','quanmei20151226125145',1,1451113052),(84,'2015122621001004020007869340','quanmei20151226161628',1,1451117815),(85,'2015123021001004710093790725','quanmei20151226142419',1,1451439835),(86,'2015123021001004710093663056','quanmei20151226142405',1,1451439889),(87,'1010040058201601292973187207','quanmei20160129142527',2,1454048745),(88,'1010040058201601292973238224','quanmei20160129142830',2,1454048920),(89,'1010040058201601292973450298','quanmei20160129144015',2,1454049627),(90,'1010040058201601292973486881','quanmei20160129144213',2,1454049747),(91,'1010040058201601292973555805','quanmei20160129144542',2,1454049954),(92,'1010040058201601292973556778','quanmei20160129144647',2,1454050018),(93,'1010040058201601292977701468','quanmei20160129181643',2,1454062626),(94,'1000490058201601302990571612','quanmei20160130122750',2,1454128098),(95,'1010040058201602013034892666','quanmei20160201184505',2,1454323564),(96,'1010040058201602013034903725','quanmei20160201184637',2,1454323618),(97,'1010040058201602013035002063','quanmei20160201185525',2,1454324149),(98,'1010040058201602013037045006','quanmei20160201190232',2,1454324576),(99,'1010040058201602013035085530','quanmei20160201190342',2,1454324644),(100,'1010040058201602013037251335','quanmei20160201192306',2,1454325805),(101,'1010040058201602013037302534','quanmei20160201192804',2,1454326114),(102,'1010040058201602013037326351','quanmei20160201193028',2,1454326238),(103,'1010040058201602013035382062','quanmei20160201193105',2,1454326280),(104,'1010040058201602013037374597','quanmei20160201193529',2,1454326544),(105,'1010040058201602013035462760','quanmei20160201193844',2,1454326749),(106,'1010040058201602013037432651','quanmei20160201193950',2,1454326817),(107,'1010040058201602013037480016','quanmei20160201194348',2,1454327045),(108,'1010040058201602013035559323','quanmei20160201194848',2,1454327347),(109,'1010040058201602013035587130','quanmei20160201195151',2,1454327529),(110,'2016020121001004020075241139','quanmei20160201181051',1,1454355248),(111,'2016020121001004710040703325','quanmei20160201184120',1,1454357141),(112,'1006850058201602023043479189','quanmei20160202100948',2,1454379110),(113,'1010040058201602023045432500','quanmei20160202101543',2,1454379357),(114,'1010040058201602023045450217','quanmei20160202101730',2,1454379475),(115,'1006850058201602023043605974','quanmei20160202102605',2,1454379995),(116,'1006850058201602023045521178','quanmei20160202102656',2,1454380027),(117,'1006850058201602023043703275','quanmei20160202103834',2,1454380730),(118,'1010040058201602023045783061','quanmei20160202105507',2,1454381725),(119,'1010040058201602023043857038','quanmei20160202105532',2,1454381750),(120,'1006850058201602023043888940','quanmei20160202105907',2,1454381962),(121,'1006850058201602023043898208','quanmei20160202105945',2,1454382003),(122,'1006850058201602023045819974','quanmei20160202110005',2,1454382016),(123,'1006850058201602023045819974','quanmei20160202110005',2,1454382016),(124,'1006850058201602023043950339','quanmei20160202110624',2,1454382400),(125,'1006850058201602023043960081','quanmei20160202110724',2,1454382466),(126,'1006850058201602023045913976','quanmei20160202110850',2,1454382544),(127,'1010040058201602023044025393','quanmei20160202111437',2,1454382887),(128,'1006850058201602023046084632','quanmei20160202112658',2,1454383638),(129,'1006770058201602253528252986','quanmei20160225194235',2,1456400855),(130,'1006770058201602253530150920','quanmei20160225194823',2,1456401002);
/*!40000 ALTER TABLE `qm_zf_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-18 15:27:42
