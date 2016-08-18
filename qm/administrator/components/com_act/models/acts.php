<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class ActModelActs extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name','a.name',
				'fname', 'a.fname',
				'pid', 'a.pid',
				'hid', 'a.hid',
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.name,a.fname,a.pid,a.hid'));
		$query->from($db->quoteName('#__act')." AS a");
		return $query;
	}
}

