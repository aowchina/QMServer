<?php
defined('_JEXEC') or die;
class WenzhangController extends JControllerLegacy{
	protected $default_view = 'wenzhangs';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/wenzhang.php';
		//GroupHelper::addSubmenu(JRequest::getCmd('view'));
		
		$view = JRequest::getCmd('view', 'wenzhangs');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'wenzhang' && $layout == 'edit' && !$this->checkEditId('com_wenzhang.edit.wenzhang', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_wenzhang&view=wenzhangs', false));
			return false;
		}
		parent::display();
		return $this;
	}
}
?>