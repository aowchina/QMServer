<?php

defined('_JEXEC') or die;

class TehuiViewTehui extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('特惠管理：编辑'), 'install.png');
		}else{
			JToolbarHelper::title(JText::_('特惠管理 ：新建'), 'install.png');
		}

		JToolbarHelper::save('tehui.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('tehui.cancel');
		}else{
			JToolbarHelper::cancel('tehui.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
