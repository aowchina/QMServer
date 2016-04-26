<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class OrderControllerOrders extends JControllerAdmin{

	public function getModel($name = 'Order', $prefix = 'OrderModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

	public function wc(){
		//获取选取的id
		$id = JRequest::getVar('cid', array(), '', 'array');

		if(count($id) == 0){
			JError::raiseWarning(500, JText::_("请选择完成的订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
			return false;
		}

		$db = JFactory::getDBO();
		
		for($i = 0; $i < count($id); $i++){
			$sql = "select status from #__yuyue where id = ".$id[$i];
			$db->setQuery($sql);
			$status = $db->loadResult();
			if($status != 2){
				JError::raiseWarning(500, JText::_("您只能完成已支付的订单!"));
				$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
				return false;
			}

			$sql = "update #__yuyue set status = 3 where id = ".$id[$i];
			$db->setQuery($sql);
			$db->query();
		}

		$this->setMessage(JText::_("操作成功!"));
		$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
	}
}

