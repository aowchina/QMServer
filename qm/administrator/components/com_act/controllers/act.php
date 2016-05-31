<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controllerform');

class ActControllerAct extends JControllerForm{

	public function getList(){
		$info = JRequest::get('get');

		$tag = intval($info['tag']);

		$db = JFactory::getDBO();
		if($tag == 1){
			$query = "select id,name from #__hospital";
		}else{
			$query = "select id,name from #__project";
		}

		$db->setQuery($query);
		$list = $db->loadObjectList();

		echo json_encode($list);
		exit;
	}
	
}

