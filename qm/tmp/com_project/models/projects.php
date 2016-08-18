<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class ProjectModelProjects extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name', 'a.name',
			
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.name,a.createtime,a.intime'));
		$query->from($db->quoteName('#__project')." AS a");


		return $query;
	}
}

