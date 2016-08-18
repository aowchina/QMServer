<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class KechengModelOrders extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'orderid', 'a.orderid',
				'amount','a.amount',
				'userid','a.userid',
				'courseid','a.courseid',
				'create_time','a.create_time',
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id, a.orderid, a.amount, a.create_time, a.status, a.userid, a.courseid'));
		$query->from($db->quoteName('#__course_order')." AS a");

		//多表联查操作
		$query->select('u.username AS uname,u.tel AS utel');
		$query->join('LEFT', $db->quoteName('#__users_common').' AS u ON u.userid = a.userid');

		$query->select('c.name AS cname');
		$query->join('LEFT', $db->quoteName('#__course').' AS c ON c.id = a.courseid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.id');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

