<?php

defined('_JEXEC') or die;

class KechengViewTeacher extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('课程管理：编辑教师'), 'help_header.png');
		}else{
			JToolbarHelper::title(JText::_('课程管理：添加教师'), 'help_header.png');
		}

		JToolbarHelper::save('teacher.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('teacher.cancel');
		}else{
			JToolbarHelper::cancel('teacher.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}

?>
