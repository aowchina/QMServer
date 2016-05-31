<?php
defined('_JEXEC') or die;
class ServiceController extends JControllerLegacy{
	protected $default_view = 'services';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/service.php';
		
		$view = JRequest::getCmd('view', 'services');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'service' && $layout == 'edit' && !$this->checkEditId('com_service.edit.service', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_service&view=services', false));
			return false;
		}
		parent::display();
		return $this;
	}
}
?>