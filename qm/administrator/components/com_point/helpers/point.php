<?php
defined('_JEXEC') or die;

class PointHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_point';
			$level = 'component';
		}else{
			$assetName = 'com_point.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_point', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	public static function addSubmenu($vName){
		JSubMenuHelper::addEntry(JText::_('积分规则'),'index.php?option=com_point&view=points',$vName == 'points');
		JSubMenuHelper::addEntry(JText::_('积分记录'),'index.php?option=com_point&view=records',$vName == 'records');
	}
}
