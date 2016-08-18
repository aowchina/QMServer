<?php

defined('_JEXEC') or die;

class HospitalViewDoctor extends JViewLegacy{
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
		if($id){
			JToolbarHelper::title(JText::_('医院管理：编辑医生'), 'help_header.png');
		}else{
			JToolbarHelper::title(JText::_('医院管理：添加医生'), 'help_header.png');
		}

		JToolbarHelper::save('doctor.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('doctor.cancel');
		}else{
			JToolbarHelper::cancel('doctor.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}

?>
