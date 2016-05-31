<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class WenzhangModelWenzhangs extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'title', 'a.title',
				'type', 'a.type',
				'userid', 'a.userid',
				'isjing', 'a.isjing',
				'ctime', 'a.ctime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.title,a.ctime,a.type,a.userid,a.isjing'));
		$query->from($db->quoteName('#__wenzhang')." AS a");

		//多表联查操作
		$query->select('u.username AS uname');
		$query->join('LEFT', $db->quoteName('#__users_common').' AS u ON u.userid = a.userid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.ctime');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

