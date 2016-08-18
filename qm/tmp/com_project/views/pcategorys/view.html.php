<?php

defined('_JEXEC') or die;

class ProjectViewPcategorys extends JViewLegacy{
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

		JToolbarHelper::title(JText::_('项目类别'), 'module.png');

		if($canDo->get('core.create')){
			JToolbarHelper::addNew('pcategory.add');
		}

		if($canDo->get('core.edit')){
			JToolbarHelper::editList('pcategory.edit');
		}

		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'pcategorys.delete', 'JTOOLBAR_DELETE');
		}
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_pcategory');
		}
	}
}
