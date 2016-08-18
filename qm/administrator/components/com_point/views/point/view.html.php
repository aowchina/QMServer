<?php

defined('_JEXEC') or die;

class PointViewPoint extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('积分管理：编辑规则'), 'install.png');
		}else{
			JToolbarHelper::title(JText::_('积分管理 ：新建规则'), 'install.png');
		}

		JToolbarHelper::save('point.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('point.cancel');
		}else{
			JToolbarHelper::cancel('point.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
