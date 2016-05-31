<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class KechengModelKechengs extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.name',
				'price','a.price',
				'intime','a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.name,a.price,a.intime'));
		$query->from($db->quoteName('#__course')." AS a");

		//多表联查操作
		$query->select('t.name AS teachername');
		$query->join('LEFT', $db->quoteName('#__teacher').' AS t ON t.courseid = a.id');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

