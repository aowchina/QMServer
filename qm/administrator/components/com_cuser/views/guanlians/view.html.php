<?php

defined('_JEXEC') or die;

class CuserViewGuanlians extends JViewLegacy{
	protected $items;

	public function display($tpl = null){
		$this->items = $this->get('Items');
		$this->pagination = $this->get('Pagination');
		
		if(count($errors = $this->get('Errors'))){
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}
		$this->addToolbar();
		parent::display($tpl);
	}

	protected function addToolbar(){
		$canDo = CuserHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('APP用户管理：第三方帐号关联'), 'user.png');

		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_cuser');
		}
	}
}
