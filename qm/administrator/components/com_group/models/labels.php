<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class GroupModelLabels extends JModelList{
	
	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.name',
				'gid', 'a.gid'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.name,a.gid'));
		$query->from($db->quoteName('#__group_tag')." AS a");

		//多表联查操作
		$query->select('g.name AS gtname');
		$query->join('LEFT', $db->quoteName('#__group').' AS g ON g.id = a.gid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'asc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

