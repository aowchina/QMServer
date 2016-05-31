<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class ServiceModelServices extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'userid', 'a.userid',
				'hid', 'a.hid',
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.userid,a.hid'));
		$query->from($db->quoteName('#__service')." AS a");

		//多表联查操作
		$query->select('u.name AS uname');
		$query->join('LEFT', $db->quoteName('#__users').' AS u ON u.id = a.userid');

		$query->select('h.name AS hname');
		$query->join('LEFT', $db->quoteName('#__hospital').' AS h ON h.id = a.hid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

