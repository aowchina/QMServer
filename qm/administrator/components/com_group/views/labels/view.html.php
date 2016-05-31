<?php

defined('_JEXEC') or die;

class GroupViewLabels extends JViewLegacy{
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

		JToolbarHelper::title(JText::_('小组管理：标签'), 'groups.png');

		if($canDo->get('core.create')){
			JToolbarHelper::addNew('label.add');
		}

		if($canDo->get('core.edit')){
			JToolbarHelper::editList('label.edit');
		}

		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'labels.delete', 'JTOOLBAR_DELETE');
		}
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_label');
		}
	}
}
