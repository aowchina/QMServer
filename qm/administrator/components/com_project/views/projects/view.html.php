<?php
defined('_JEXEC') or die;
class ProjectViewProjects extends JViewLegacy{
	protected $items;
	protected $groups;

	public function display($tpl = null){

		$this->items = $this->get('Items');
		$this->pagination = $this->get('Pagination');

		if(count($errors = $this->get('Errors'))){
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}

		$this->groups = $this->get("Groups");
		
		$this->addToolbar();
		parent::display($tpl);
	}

	protected function addToolbar(){
		$canDo = ProjectHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('项目管理：项目'), 'newsfeeds.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('project.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('project.edit');
		}
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_project');
		}
		
	}
}
