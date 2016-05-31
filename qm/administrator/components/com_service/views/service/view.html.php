<?php

defined('_JEXEC') or die;

class ServiceViewService extends JViewLegacy{
	protected $item;
	protected $form;

	public function display($tpl = null){
		$this->item = $this->get('Item');
		$this->form = $this->get('Form');

		if(count($errors = $this->get('Errors'))){
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}
		
		$this->addToolbar();
		parent::display($tpl);
	}

	protected function addToolbar(){
		JFactory::getApplication()->input->set('hidemainmenu', true);

		$id = $this->item->id;
		if($id){
			JToolbarHelper::title(JText::_('服务站：编辑'), 'article.png');
		}else{
			JToolbarHelper::title(JText::_('服务站：新建'), 'article.png');
		}

		JToolbarHelper::save('service.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('service.cancel');
		}else{
			JToolbarHelper::cancel('service.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
