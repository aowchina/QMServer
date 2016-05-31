<?php
defined('_JEXEC') or die;
class GroupController extends JControllerLegacy{
	protected $default_view = 'groups';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/group.php';
		GroupHelper::addSubmenu(JRequest::getCmd('view'));
		
		$view = JRequest::getCmd('view', 'groups');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'group' && $layout == 'edit' && !$this->checkEditId('com_group.edit.group', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_group&view=groups', false));
			return false;
		}
		parent::display();
		
		return $this;
	}
}
?>