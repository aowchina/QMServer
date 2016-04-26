<?php
defined('_JEXEC') or die;

class KechengHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_kecheng';
			$level = 'component';
		}else{  
			$assetName = 'com_kecheng.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_kecheng', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	public static function addSubmenu($vName){
		JSubMenuHelper::addEntry(JText::_('课程'),'index.php?option=com_kecheng&view=kechengs',$vName == 'kechengs');
		JSubMenuHelper::addEntry(JText::_('教师'),'index.php?option=com_kecheng&view=teachers',$vName == 'teachers');
		JSubMenuHelper::addEntry(JText::_('报名'),'index.php?option=com_kecheng&view=orders',$vName == 'orders');
	}
}
