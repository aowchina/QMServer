<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controllerform');

class ProjectControllerProject extends JControllerForm{
	
	public function batch($model = null){
		$model = $this->getModel('Project', '', array());

		// Preset the redirect
		$this->setRedirect(JRoute::_('index.php?option=com_project&view=projects'.$this->getRedirectToListAppend(), false));

		return parent::batch($model);
	}
}

