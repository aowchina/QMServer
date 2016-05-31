<?php
defined('_JEXEC') or die;

class TehuiController extends JControllerLegacy{
	protected $default_view = 'tehuis';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/tehui.php';
		TehuiHelper::addSubmenu(JRequest::getCmd('view'));

		$view = JRequest::getCmd('view', 'tehuis');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'tehui' && $layout == 'edit' && !$this->checkEditId('com_tehui.edit.tehui', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_tehui&view=tehuis', false));
			return false;
		}
		
		parent::display();
		return $this;
	}
}
?>