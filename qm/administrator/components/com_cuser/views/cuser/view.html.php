<?php

defined('_JEXEC') or die;

class CuserViewCuser extends JViewLegacy{
	protected $item;
	protected $form;

	public function display($tpl = null){
		$this->item = $this->get('Item');
		$this->form = $this->get('Form');

		if(count($errors = $this->get('Errors'))){
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}
		
		$this->addToolbar();
		parent::display($tpl);
	}

	protected function addToolbar(){
		JFactory::getApplication()->input->set('hidemainmenu', true);

		$id = $this->item->id;
		JToolbarHelper::title(JText::_('APP用户管理：详情'), 'user.png');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('cuser.cancel');
		}else{
			JToolbarHelper::cancel('cuser.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
