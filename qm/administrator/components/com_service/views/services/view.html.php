<?php
defined('_JEXEC') or die;
class ServiceViewServices extends JViewLegacy{
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
		$canDo = ServiceHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('服务站管理：服务站'), 'article.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('service.add');
		}
		
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('service.edit');
		}
		
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_service');
		}
	}
}
