<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class CuserControllerGuanlians extends JControllerAdmin{
	
	protected $text_prefix = 'COM_CUSER_GUANLIANS';

	public function getModel($name = 'Guanlian', $prefix = 'CuserModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

}