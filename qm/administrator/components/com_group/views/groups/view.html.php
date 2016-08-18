<?php
defined('_JEXEC') or die;
class GroupViewGroups extends JViewLegacy{
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
		$canDo = GroupHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('小组管理：小组'), 'groups.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('group.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('group.edit');
		}
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_group');
		}
	}
}
