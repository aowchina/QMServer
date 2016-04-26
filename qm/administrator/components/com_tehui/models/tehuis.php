<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class TehuiModelTehuis extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'name','a.name',
				'dj', 'a.dj',
				'oldval', 'a.oldval',
				'newval', 'a.newval',
				'hid', 'a.hid',
				'tid', 'a.tid',
				'pid', 'a.pid',
				'intime', 'a.intime'
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.name,a.dj,a.oldval,a.newval,a.intime,a.hid,a.tid,a.pid'));
		$query->from($db->quoteName('#__tehui')." AS a");

		//多表联查操作
		$query->select('h.name AS hname');
		$query->join('LEFT', $db->quoteName('#__hospital').' AS h ON h.id = a.hid');

		//多表联查操作
		$query->select('p.name AS pname');
		$query->join('LEFT', $db->quoteName('#__project').' AS p ON p.id = a.pid');

		//多表联查操作
		$query->select('t.name AS tname');
		$query->join('LEFT', $db->quoteName('#__tehui_type').' AS t ON t.id = a.tid');

		//排序操作
		$orderCol = $this->state->get('list.ordering', 'a.intime');
		$orderDirn = $this->state->get('list.direction', 'desc');
		$query->order($db->escape($orderCol.' '.$orderDirn));

		return $query;
	}
}

