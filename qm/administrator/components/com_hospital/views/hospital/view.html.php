<?php

defined('_JEXEC') or die;

class HospitalViewHospital extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('医院管理：编辑医院'), 'help_header.png');
		}else{
			JToolbarHelper::title(JText::_('医院管理：添加医院'), 'help_header.png');
		}

		JToolbarHelper::save('hospital.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('hospital.cancel');
		}else{
			JToolbarHelper::cancel('hospital.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}

?>
