<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class CuserModelGuanlians extends JModelList{
	
	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'userid', 'a.userid',
				'type', 'a.type',
				'openid', 'a.openid'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.userid,a.type,a.openid'));
		$query->from($db->quoteName('#__users_dsf')." AS a");

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'asc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

