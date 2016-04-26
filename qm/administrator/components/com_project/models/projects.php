<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class ProjectModelProjects extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.name',
				'ptid', 'a.ptid',
				'intime', 'a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.name,a.ptid,a.intime'));
		$query->from($db->quoteName('#__project')." AS a");

		//多表联查操作
		$query->select('pt.name AS ptname');
		$query->join('LEFT', $db->quoteName('#__project_type').' AS pt ON pt.id = a.ptid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}

	public function getGroups(){
		$db = $this->getDBO();
		$query = "select id,name from #__group order by id";
		$db->setQuery($query);
		$list = $db->loadObjectList();
		return $list;
	}
}

