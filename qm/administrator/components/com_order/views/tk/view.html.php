<?php

defined('_JEXEC') or die;

class OrderViewTk extends JViewLegacy{
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

		JToolbarHelper::title(JText::_('订单：退款'), 'article-add');

		JToolbarHelper::save('tk.save');

		JToolbarHelper::cancel('tk.cancel');
	}
}
