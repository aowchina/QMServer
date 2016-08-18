<?php

defined('_JEXEC') or die;

class BaoxianViewBaoxian extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('保险管理：编辑'), 'install.png');
		}else{
			JToolbarHelper::title(JText::_('保险管理 ：新建'), 'install.png');
		}

		JToolbarHelper::save('baoxian.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('baoxian.cancel');
		}else{
			JToolbarHelper::cancel('baoxian.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
