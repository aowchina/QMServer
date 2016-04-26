<?php

defined('_JEXEC') or die;

class OrderViewOrder extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('订单：详情'), 'article.png');
		}else{
			JToolbarHelper::title(JText::_('订单：详情'), 'article.png');
		}

		if(empty($this->item->id)){
			JToolbarHelper::cancel('order.cancel');
		}else{
			JToolbarHelper::cancel('order.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
