<?php
defined('_JEXEC') or die;

class CuserHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_cuser';
			$level = 'component';
		}else{
			$assetName = 'com_cuser.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_cuser', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	public static function addSubmenu($vName){
		JSubMenuHelper::addEntry(JText::_('APP用户'),'index.php?option=com_cuser&view=cusers',$vName == 'cusers');
		JSubMenuHelper::addEntry(JText::_('第三方帐号关联'),'index.php?option=com_cuser&view=guanlians',$vName == 'guanlians');
	}

}
