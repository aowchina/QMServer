<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class BaoxianControllerBaoxians extends JControllerAdmin{

	public function getModel($name = 'Baoxian', $prefix = 'BaoxianModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}
}

