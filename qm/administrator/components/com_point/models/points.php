<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class PointModelPoints extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'qd_point','a.qd_point',
				'xf_point', 'a.xf_point',
				'xh_point', 'a.xh_point',
				'intime', 'a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.qd_point,a.xf_point,a.intime,a.xh_point'));
		$query->from($db->quoteName('#__point_rule')." AS a");

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.intime');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

