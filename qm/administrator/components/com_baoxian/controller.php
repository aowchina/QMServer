<?php
defined('_JEXEC') or die;

class BaoxianController extends JControllerLegacy{
	protected $default_view = 'baoxians';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/baoxian.php';
		//TehuiHelper::addSubmenu(JRequest::getCmd('view'));

		$view = JRequest::getCmd('view', 'baoxians');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'baoxian' && $layout == 'edit' && !$this->checkEditId('com_baoxian.edit.baoxian', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_baoxian&view=baoxians', false));
			return false;
		}
		
		parent::display();
		return $this;
	}
}
?>