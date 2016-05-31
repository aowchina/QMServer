<?php
defined('_JEXEC') or die;

class PointViewPoints extends JViewLegacy{
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
		$canDo = PointHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('积分管理：积分规则'), 'install.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('point.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('point.edit');
		}
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_point');
		}
		
	}
}
