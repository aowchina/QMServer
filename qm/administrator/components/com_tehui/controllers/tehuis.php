<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class TehuiControllerTehuis extends JControllerAdmin{

	public function getModel($name = 'Tehui', $prefix = 'TehuiModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

	public function push(){
		$ids = JRequest::getVar('cid', array(), '', 'array');
		
		if(count($ids) < 1){
			JError::raiseWarning(500, '请先从列表中选择特惠');
			$this->setRedirect(JRoute::_('index.php?option=com_tehui&view=tehuis', false));
			return false;
		}
		
		$db = JFactory::getDbo();
		
		include_once(JPATH_ROOT.'/Jpush.php');
		$jp = new Jpush();
		
		foreach($ids as $id){
			$sql = "select name from #__tehui where id = $id";
			$db->setQuery($sql);
			$name = $db->loadResult();

			$jp->push('all', $name."隆重推出~", '86400', 1, $id);
		}

		$this->setMessage('操作成功');
		$this->setRedirect(JRoute::_('index.php?option=com_tehui&view=tehuis', false));
	}
}

