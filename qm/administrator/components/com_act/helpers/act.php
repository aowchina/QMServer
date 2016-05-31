<?php
defined('_JEXEC') or die;

class ActHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_act';
			$level = 'component';
		}else{
			$assetName = 'com_act.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_act', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}
}
