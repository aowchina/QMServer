<?php
defined('_JEXEC') or die;
class ProjectController extends JControllerLegacy{
	protected $default_view = 'projects';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/project.php';
		ProjectHelper::addSubmenu(JRequest::getCmd('view'));
		$view = JRequest::getCmd('view', 'projects');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'project' && $layout == 'edit' && !$this->checkEditId('com_project.edit.project', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_project&view=projects', false));
			return false;
		}
		parent::display();
		
		return $this;
	}
}
?>