<?php
defined('_JEXEC') or die;

class HospitalHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_hospital';
			$level = 'component';
		}else{  
			$assetName = 'com_hospital.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_hospital', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	public static function addSubmenu($vName){
		JSubMenuHelper::addEntry(JText::_('医院'),'index.php?option=com_hospital&view=hospitals',$vName == 'hospitals');
		JSubMenuHelper::addEntry(JText::_('医生'),'index.php?option=com_hospital&view=doctors',$vName == 'doctors');
	}
}
