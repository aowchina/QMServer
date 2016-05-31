<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class HospitalModelDoctors extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.pid',
				'pos', 'a.name',
				'hid', 'a.hid',
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.name, a.pos, a.hid'));
		$query->from($db->quoteName('#__doctor')." AS a");

		//多表联查操作
		$query->select('b.name AS hname');
		$query->join('LEFT', $db->quoteName('#__hospital').' AS b ON b.id = a.hid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'asc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

