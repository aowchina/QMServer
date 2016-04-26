<?php
defined('_JEXEC') or die;
class ProjectHelper{
	public static function getActions($categoryId = 0){
		$user = JFactory::getUser();
		$result = new JObject;

		if(empty($categoryId)){
			$assetName = 'com_project';
			$level = 'component';
		}else{
			$assetName = 'com_project.category.'.(int)$categoryId;
			$level = 'category';
		}

		$actions = JAccess::getActions('com_project', $level);

		foreach($actions as $action){
			$result->set($action->name, $user->authorise($action->name, $assetName));
		}

		return $result;
	}

	public static function addSubmenu($vName){
		JSubMenuHelper::addEntry(JText::_(' 项目'),'index.php?option=com_project&view=projects',$vName == 'projects');
		JSubMenuHelper::addEntry(JText::_(' 项目类别'),'index.php?option=com_project&view=pcategorys',$vName == 'pcategorys');
		
	}


}
