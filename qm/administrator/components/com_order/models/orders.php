<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class OrderModelOrders extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'orderid', 'a.orderid',
				'tid', 'a.tid',
				'userid', 'a.userid',
				'status', 'a.status',
				'intime', 'a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function populateState($ordering = null,$direction = null){
		$app = JFactory::getApplication();
		$session = JFactory::getSession();

		if($layout = JRequest::getVar('layout')){
			$this->context.='.'.$layout;
		}

		$level = $this->getUserStateFromRequest($this->context.'.filter.level','filter_level',0,'int');
		$this->setState('filter.level',$level);

		parent::populateState('a.intime','desc');
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);


		$query->select($this->getState('list.select', 'a.id,a.orderid,a.tid,a.status,a.userid,a.intime'));
		$query->from($db->quoteName('#__yuyue')." AS a");
		

		if($level = $this->getState('filter.level')){
			$query->where('a.status='.$level);
		}
		//多表联查操作
		$query->select('u.username AS uname');
		$query->join('LEFT', $db->quoteName('#__users_common').' AS u ON u.userid = a.userid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.intime');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

