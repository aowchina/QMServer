<?php
defined('_JEXEC') or die;
class KechengViewOrders extends JViewLegacy{
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
		$canDo = KechengHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('课程管理：预订'), 'help_header.png');
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_kecheng');
		}
	}
}
