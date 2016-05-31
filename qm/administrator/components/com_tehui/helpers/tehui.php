<?php
defined('_JEXEC') or die;

class TehuiHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_tehui';
			$level = 'component';
		}else{
			$assetName = 'com_tehui.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_tehui', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	public static function addSubmenu($vName){
		JSubMenuHelper::addEntry(JText::_('限时特惠'),'index.php?option=com_tehui&view=tehuis',$vName == 'tehuis');
		JSubMenuHelper::addEntry(JText::_('特惠类别'),'index.php?option=com_tehui&view=types',$vName == 'types');
	}
}
