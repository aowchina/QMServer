<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class KechengControllerKechengs extends JControllerAdmin{

	public function getModel($name = 'Kecheng', $prefix = 'KechengModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}
}

