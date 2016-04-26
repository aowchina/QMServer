<?php
defined('_JEXEC') or die;

class TehuiViewTehuis extends JViewLegacy{
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
		$canDo = TehuiHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('特惠管理：特惠'), 'install.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('tehui.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('tehui.edit');
		}
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_tehui');
		}
		
	}
}
