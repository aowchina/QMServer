<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class KechengModelTeachers extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.pid',
				'courseid','a.courseid',
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.name, a.courseid'));
		$query->from($db->quoteName('#__teacher')." AS a");

		//多表联查操作
		$query->select('c.name AS cname');
		$query->join('LEFT', $db->quoteName('#__course').' AS c ON c.id = a.courseid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'asc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

