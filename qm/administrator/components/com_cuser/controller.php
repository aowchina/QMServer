<?php
defined('_JEXEC') or die;

class CuserController extends JControllerLegacy{
	protected $default_view = 'cusers';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/cuser.php';
		CuserHelper::addSubmenu(JRequest::getCmd('view'));
		
		$view = JRequest::getCmd('view', 'cusers');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'cuser' && $layout == 'edit' && !$this->checkEditId('com_cuser.edit.cuser', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_cuser&view=cusers', false));
			return false;
		}
		
		parent::display();
		return $this;
	}
}
?>