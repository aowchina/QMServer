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

		JToolBarHelper::custom('orders.wc', 'apply.png', 'apply.png', '标记完成', false);
		JToolBarHelper::divider();

		JToolBarHelper::custom('orders.wk', 'archive.png', 'archive.png', '已收尾款', false);
		JToolBarHelper::divider();

		JToolBarHelper::custom('orders.twk_xx', 'purge.png', 'purge.png', '退线下尾款', false);
		JToolBarHelper::divider();

		JToolBarHelper::custom('orders.twk_xs', 'refresh.png', 'refresh.png', '退线上尾款', false);
		JToolBarHelper::divider();

		JToolBarHelper::custom('orders.tdj_xs', 'back.png', 'back.png', '退线上订金', false);
		JToolBarHelper::divider();

		if(empty($this->item->id)){
			JToolbarHelper::cancel('order.cancel');
		}else{
			JToolbarHelper::cancel('order.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
