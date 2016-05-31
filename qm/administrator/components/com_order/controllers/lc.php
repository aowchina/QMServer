<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controllerform');

//类别 组件名.Controller.View名
class OrderControllerLc extends JControllerForm{

	public function save(){
		//获取data
		$data = JRequest::getVar('jform', array(), 'post', 'array');

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$lc = trim($data['lc']);
		$lcnote = trim($data['lcnote']);
		if(empty($lc)){
			JError::raiseWarning(403, JText::_('请填写流程说明!'));
            $this->setRedirect(JRoute::_('index.php?option=com_order&view=lc', false));
            return false;
		}

		if(empty($lcnote)){
			JError::raiseWarning(403, JText::_('请填写流程备注!'));
            $this->setRedirect(JRoute::_('index.php?option=com_order&view=lc', false));
            return false;
		}

		$filename = $mp->getJsonPath(4)."lc";
		$filename2 = $mp->getJsonPath(4)."lcnote";
		if(file_put_contents($filename, $lc) && file_put_contents($filename2, $lcnote)){
			$this->setRedirect(JRoute::_('index.php?option=com_order', false));
		    return true;
		}else{
			JError::raiseWarning(403, JText::_('服务器繁忙，请稍后重试!'));
            $this->setRedirect(JRoute::_('index.php?option=com_order&view=lc', false));
            return false;
		}
	}

	public function cancel(){
		$this->setRedirect(JRoute::_('index.php?option=com_order', false));
	}
}

