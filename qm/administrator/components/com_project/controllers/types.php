<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class ProjectControllerTypes extends JControllerAdmin{
	
	protected $text_prefix = 'COM_PROJECT_TYPES';

	public function getModel($name = 'Type', $prefix = 'ProjectModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

}