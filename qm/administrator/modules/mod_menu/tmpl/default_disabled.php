<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	mod_menu
 * @copyright	Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access.
defined('_JEXEC') or die;

$showhelp 	= $params->get('showhelp', 1);

//网站
$menu->addChild(new JMenuNode(JText::_('JSITE'), null, 'disabled'));

//
// Users Submenu
//
/*
if ($user->authorise('core.manage', 'com_users'))
{
	$menu->addChild(new JMenuNode(JText::_('MOD_MENU_COM_USERS'), null, 'disabled'));
}

/*
//菜单
if ($user->authorise('core.manage', 'com_menus'))
{
	$menu->addChild(new JMenuNode(JText::_('MOD_MENU_MENUS'), null, 'disabled'));
}

//文章
if ($user->authorise('core.manage', 'com_content'))
{
	$menu->addChild(new JMenuNode(JText::_('MOD_MENU_COM_CONTENT'), null, 'disabled'));
}
*/


//组件
// Get the authorised components and sub-menus.
$components = ModMenuHelper::getComponents( true );
// Check if there are any components, otherwise, don't display the components menu item
if ($components) {
	$menu->addChild(new JMenuNode(JText::_('MOD_MENU_COMPONENTS'),  null, 'disabled'));
}

/*
//扩展
$im = $user->authorise('core.manage', 'com_installer');
$mm = $user->authorise('core.manage', 'com_modules');
$pm = $user->authorise('core.manage', 'com_plugins');
$tm = $user->authorise('core.manage', 'com_templates');
$lm = $user->authorise('core.manage', 'com_languages');

if ($im || $mm || $pm || $tm || $lm)
{
	$menu->addChild(new JMenuNode(JText::_('MOD_MENU_EXTENSIONS_EXTENSIONS'), null, 'disabled'));
}
*/
//帮助
/*
if ($showhelp == 1) {
$menu->addChild(new JMenuNode(JText::_('MOD_MENU_HELP'), null, 'disabled'));
}
*/