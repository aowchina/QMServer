<?php
defined('_JEXEC') or die;

class ActController extends JControllerLegacy{
	protected $default_view = 'acts';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/act.php';
		
		$view = JRequest::getCmd('view', 'acts');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'act' && $layout == 'edit' && !$this->checkEditId('com_act.edit.act', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_act&view=acts', false));
			return false;
		}
		
		parent::display();
		return $this;
	}
}
?>