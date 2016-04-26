<?php
defined('_JEXEC') or die;

class BaoxianHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_baoxian';
			$level = 'component';
		}else{
			$assetName = 'com_baoxian.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_baoxian', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}
}
