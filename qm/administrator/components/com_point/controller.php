<?php
defined('_JEXEC') or die;

class PointController extends JControllerLegacy{
	protected $default_view = 'points';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/point.php';
		PointHelper::addSubmenu(JRequest::getCmd('view'));

		$view = JRequest::getCmd('view', 'points');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'point' && $layout == 'edit' && !$this->checkEditId('com_point.edit.point', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_point&view=points', false));
			return false;
		}
		
		parent::display();
		return $this;
	}
}
?>