<?php
defined('_JEXEC') or die;
class KechengViewTeachers extends JViewLegacy{
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

		JToolbarHelper::title(JText::_('课程管理：教师'), 'help_header.png');
		
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('teacher.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('teacher.edit');
		}

		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'teachers.delete', 'JTOOLBAR_DELETE');
		}
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_kecheng');
		}
	}
}
