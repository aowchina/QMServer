<?php
defined('_JEXEC') or die;
class OrderViewOrders extends JViewLegacy{
	protected $items;
	protected $state;

	public function display($tpl = null){
		$this->items = $this->get('Items');
		$this->pagination = $this->get('Pagination');
		$this->state = $this->get('State');

		if(count($errors = $this->get('Errors'))){
			JError::raiseError(500, implode("\n", $errors));
			return false;
		}

		$options	= array();
		$options[]	= JHtml::_('select.option', '1', JText::_('待支付'));
		$options[]	= JHtml::_('select.option', '2', JText::_('已付定金'));
		$options[]	= JHtml::_('select.option', '3', JText::_('待评价'));
		$options[]	= JHtml::_('select.option', '5', JText::_('已付全款'));
		$options[]	= JHtml::_('select.option', '6', JText::_('已上传图片'));
		$options[]	= JHtml::_('select.option', '7', JText::_('待退尾款'));
		$options[]	= JHtml::_('select.option', '8', JText::_('待退定金'));
		$options[]	= JHtml::_('select.option', '9', JText::_('已退款'));
		$options[]	= JHtml::_('select.option', '4', JText::_('已结束'));


		$this->f_levels = $options;
		
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
