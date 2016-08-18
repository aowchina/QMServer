<?php
/**
 * @package		Joomla.Administrator
 * @subpackage	mod_quickicon
 * @copyright	Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license		GNU General Public License version 2 or later; see LICENSE.txt
 */

// No direct access.
defined('_JEXEC') or die;

/**
 * @package		Joomla.Administrator
 * @subpackage	mod_quickicon
 * @since		1.6
 */
abstract class modQuickIconHelper
{
	/**
	 * Stack to hold buttons
	 *
	 * @since	1.6
	 */
	protected static $buttons = array();

	/**
	 * Helper method to return button list.
	 *
	 * This method returns the array by reference so it can be
	 * used to add custom buttons or remove default ones.
	 *
	 * @param	JRegistry	The module parameters.
	 *
	 * @return	array	An array of buttons
	 * @since	1.6
	 */
	public static function &getButtons($params)
	{
		$key = (string)$params;
		if (!isset(self::$buttons[$key])) {
			$context = $params->get('context', 'mod_quickicon');
			if ($context == 'mod_quickicon')
			{
				// Load mod_quickicon language file in case this method is called before rendering the module
			JFactory::getLanguage()->load('mod_quickicon');

				self::$buttons[$key] = array(
					array(
						'link' => JRoute::_('index.php?option=com_cuser'),
						'image' => 'header/icon-48-user.png',
						'text' => JText::_('APP用户'),
						'access' => array('core.manage', 'com_cuser')
					),
					array(
						'link' => JRoute::_('index.php?option=com_group'),
						'image' => 'header/icon-48-contacts-categories.png',
						'text' => JText::_('小组'),
						'access' => array('core.manage', 'com_group')
					),
					array(
						'link' => JRoute::_('index.php?option=com_project'),
						'image' => 'header/icon-48-banner-client.png',
						'text' => JText::_('项目'),
						'access' => array('core.manage', 'com_project')
					),
					array(
						'link' => JRoute::_('index.php?option=com_act'),
						'image' => 'header/icon-48-help-forum.png',
						'text' => JText::_('主题活动'),
						'access' => array('core.manage', 'com_media')
					),
					array(
						'link' => JRoute::_('index.php?option=com_tehui'),
						'image' => 'header/icon-48-help-this.png',
						'text' => JText::_('限时特惠'),
						'access' => array('core.manage', 'com_tehui')
					),
					array(
						'link' => JRoute::_('index.php?option=com_hospital'),
						'image' => 'header/icon-48-frontpage.png',
						'text' => JText::_('医院'),
						'access' => array('core.manage', 'com_hospital')
					),
					array(
						'link' => JRoute::_('index.php?option=com_wenzhang'),
						'image' => 'header/icon-48-article.png',
						'text' => JText::_('帖子/日记'),
						'access' => array('core.manage', 'com_wenzhang')
					),
					array(
						'link' => JRoute::_('index.php?option=com_order'),
						'image' => 'header/icon-48-article.png',
						'text' => JText::_('订单'),
						'access' => array('core.manage', 'com_order')
					),
				);
			}
			else
			{
				self::$buttons[$key] = array();
			}
		}

		return self::$buttons[$key];
	}

	/**
	 * Get the alternate title for the module
	 *
	 * @param	JRegistry	The module parameters.
	 * @param	object		The module.
	 *
	 * @return	string	The alternate title for the module.
	 */
	public static function getTitle($params, $module)
	{
		$key = $params->get('context', 'mod_quickicon') . '_title';
		if (JFactory::getLanguage()->hasKey($key))
		{
			return JText::_($key);
		}
		else
		{
			return $module->title;
		}
	}
}
