<?php

defined('_JEXEC') or die;

class ProjectViewType extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('项目管理：编辑类别'), 'newsfeeds.png');
		}else{
			JToolbarHelper::title(JText::_('项目管理：添加类别'), 'newsfeeds.png');
		}

		JToolbarHelper::save('type.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('type.cancel');
		}else{
			JToolbarHelper::cancel('type.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
