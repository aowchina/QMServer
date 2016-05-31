<?php
defined('_JEXEC') or die;
class HospitalViewHospitals extends JViewLegacy{
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
		$canDo = HospitalHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('医院管理：医院'), 'help_header.png');
		
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('hospital.add');
		}
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('hospital.edit');
		}

		/*
		JToolBarHelper::custom('hospitals.seedoctors', 'search.png', 'search.png', '医生', false);
		JToolBarHelper::divider();
		*/
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_hospital');
		}
	}
}
