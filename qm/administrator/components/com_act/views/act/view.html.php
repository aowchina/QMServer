<?php

defined('_JEXEC') or die;

class ActViewAct extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('主题管理：编辑'), 'langmanager.png');
		}else{
			JToolbarHelper::title(JText::_('主题管理 ：新建'), 'langmanager.png');
		}

		JToolbarHelper::save('act.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('act.cancel');
		}else{
			JToolbarHelper::cancel('act.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
