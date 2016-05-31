<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class GroupControllerLabels extends JControllerAdmin{
	
	protected $text_prefix = 'COM_GROUP_LABELS';

	public function getModel($name = 'Label', $prefix = 'GroupModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

}