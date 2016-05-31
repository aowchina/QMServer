<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class PointModelRecords extends JModelList{
	
	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'userid', 'a.userid',
				'type', 'a.type',
				'status', 'a.status',
				'point', 'a.point',
				'order_num', 'a.order_num',
				'order_fee', 'a.order_fee',
				'ctime', 'a.ctime',
				'intime', 'a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.userid,a.intime,a.type,a.status,a.point,a.order_num,a.order_fee,a.ctime'));
		$query->from($db->quoteName('#__point_record')." AS a");

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

