<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');

class CuserModelCusers extends JModelList{

	public function __construct($config = array()){
		if(empty($config['filter_fields'])){

			$config['filter_fields'] = array(
				'id', 'a.id',
				'userid', 'a.userid',
				'username','a.username',
				'tel', 'a.tel',
				'birthday', 'a.birthday',
				'sex', 'a.sex',
				'block', 'a.block',
				'intime', 'a.intime',
			);
		}

		parent::__construct($config);
	}

	protected function getListQuery(){
		$db = $this->getDbo();
		$query = $db->getQuery(true);
		$query->select($this->getState('list.select', 'a.id,a.userid,a.username,a.tel,a.birthday,a.sex,a.block,a.intime'));
		$query->from($db->quoteName('#__users_common')." AS a");
		return $query;
	}
}

