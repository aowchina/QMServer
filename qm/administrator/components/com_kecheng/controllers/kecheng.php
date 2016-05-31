<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controllerform');

class KechengControllerKecheng extends JControllerForm{

	public function getCity(){
		$info = JRequest::get('get');

		$pid = intval($info['pid']);

		$db = JFactory::getDBO();
		$query = "select id,name from #__city where pid = ".$pid;
		$db->setQuery($query);
		$list = $db->loadObjectList();

		echo json_encode($list);
		exit;
	}
}

