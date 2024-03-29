<?php

defined('_JEXEC') or die;

class ProjectViewProject extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('项目：编辑'), 'newsfeeds.png');
		}else{
			JToolbarHelper::title(JText::_('项目：新建'), 'newsfeeds.png');
		}

		JToolbarHelper::save('project.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('project.cancel');
		}else{
			JToolbarHelper::cancel('project.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
