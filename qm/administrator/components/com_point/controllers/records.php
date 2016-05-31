<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class PointControllerRecords extends JControllerAdmin{
	
	protected $text_prefix = 'COM_POINT_RECORDS';

	public function getModel($name = 'Record', $prefix = 'PointModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

}