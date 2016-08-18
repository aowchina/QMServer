<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controllerform');

class ProjectControllerPcategorys extends JControllerForm{
	
	public function getModel($name = 'Pcategory', $prefix = 'ProjectModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

}