<?php
defined('_JEXEC') or die;

class WenzhangHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_wenzhang';
			$level = 'component';
		}else{
			$assetName = 'com_wenzhang.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_wenzhang', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	/*
 	public static function addSubmenu($vName){
 		JSubMenuHelper::addEntry(JText::_('小组'),'index.php?option=com_group&view=groups',$vName == 'groups');
		JSubMenuHelper::addEntry(JText::_('标签'),'index.php?option=com_group&view=labels',$vName == 'labels');
	}
	*/
}
