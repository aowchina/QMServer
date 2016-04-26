<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class TehuiControllerTypes extends JControllerAdmin{
	
	protected $text_prefix = 'COM_TEHUI_TYPES';

	public function getModel($name = 'Type', $prefix = 'TehuiModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

}