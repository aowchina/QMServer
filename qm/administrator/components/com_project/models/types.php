<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class ProjectModelTypes extends JModelList{
	
	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.name',
				'intime', 'a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.name,a.intime'));
		$query->from($db->quoteName('#__project_type')." AS a");

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.intime');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

