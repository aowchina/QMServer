<?php
defined('_JEXEC') or die;

class ActViewActs extends JViewLegacy{
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
		$canDo = ActHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('主题管理：主题'), 'langmanager.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('act.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('act.edit');
		}
		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'acts.delete', 'JTOOLBAR_DELETE');
		}
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_act');
		}
		
	}
}
