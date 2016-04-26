<?php

defined('_JEXEC') or die;

class GroupViewLabel extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('标签：编辑'), 'groups.png');
		}else{
			JToolbarHelper::title(JText::_('标签：新建'), 'groups.png');
		}

		JToolbarHelper::save('label.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('label.cancel');
		}else{
			JToolbarHelper::cancel('label.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
