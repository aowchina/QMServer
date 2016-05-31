<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class KechengControllerOrders extends JControllerAdmin{

	public function getModel($name = 'Order', $prefix = 'OrderModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}
}

