<?php

defined('_JEXEC') or die;

class ProjectViewTypes extends JViewLegacy{
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
		$canDo = ProjectHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('项目管理：项目类别'), 'newsfeeds.png');

		if($canDo->get('core.create')){
			JToolbarHelper::addNew('type.add');
		}

		if($canDo->get('core.edit')){
			JToolbarHelper::editList('type.edit');
		}

		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'types.delete');
			JToolBarHelper::divider();
		}

		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_project');
		}
	}
}
