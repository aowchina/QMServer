<?php
defined('_JEXEC') or die;
class OrderController extends JControllerLegacy{
	protected $default_view = 'orders';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/order.php';
		OrderHelper::addSubmenu(JRequest::getCmd('view'));
		
		$view = JRequest::getCmd('view', 'orders');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		if($view == 'order' && $layout == 'edit' && !$this->checkEditId('com_order.edit.order', $id)){
			$this->setError(JText::sprintf('JLIB_APPLICATION_ERROR_UNHELD_ID', $id));
			$this->setMessage($this->getError(), 'error');
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
			return false;
		}
		parent::display();
		return $this;
	}
}
?>