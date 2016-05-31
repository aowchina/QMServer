<?php
defined('_JEXEC') or die;

class HospitalController extends JControllerLegacy{
	protected $default_view = 'hospitals';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/hospital.php';
		HospitalHelper::addSubmenu(JRequest::getCmd('view'));

		$view = JRequest::getCmd('view', 'hospitals');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'hospital' && $layout == 'edit' && !$this->checkEditId('com_hospital.edit.hospital', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_hospital&view=hospitals', false));
			return false;
		}
		parent::display();
		
		return $this;
	}
}
?>