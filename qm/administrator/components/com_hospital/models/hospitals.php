<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class HospitalModelHospitals extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'pid', 'a.pid',
				'name', 'a.name',
				'cid', 'a.cid',
				'intime','a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.pid, a.name,a.cid,a.intime'));
		$query->from($db->quoteName('#__hospital')." AS a");

		//多表联查操作
		$query->select('p.name AS pname');
		$query->join('LEFT', $db->quoteName('#__province').' AS p ON p.id = a.pid');

		$query->select('c.name AS cname');
		$query->join('LEFT', $db->quoteName('#__city').' AS c ON c.id = a.cid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.intime');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

