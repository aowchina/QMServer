<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class KechengControllerTeachers extends JControllerAdmin{

	public function getModel($name = 'Teacher', $prefix = 'TeacherModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}
}

