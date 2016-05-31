<?php
defined('_JEXEC') or die;
class OrderViewOrders extends JViewLegacy{
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
		$canDo = OrderHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('订单管理：订单'), 'article.png');

		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'orders.delete', 'JTOOLBAR_DELETE');
		}
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_order');
		}
	}
}
