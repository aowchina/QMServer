<?php

defined('_JEXEC') or die;

class GroupViewGroup extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('小组：编辑'), 'groups.png');
		}else{
			JToolbarHelper::title(JText::_('小组：新建'), 'groups.png');
		}

		JToolbarHelper::save('group.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('group.cancel');
		}else{
			JToolbarHelper::cancel('group.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
