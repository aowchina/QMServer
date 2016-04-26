<?php
defined('_JEXEC') or die;
class WenzhangViewWenzhangs extends JViewLegacy{
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
		$canDo = WenzhangHelper::getActions();
		$bar = JToolBar::getInstance('toolbar');

		JToolbarHelper::title(JText::_('文章管理：文章'), 'article.png');
		if($canDo->get('core.create')){
			JToolbarHelper::addNew('wenzhang.add');
		}

		/*
		JToolBarHelper::custom('wenzhangs.see', 'search.png', 'search.png', '查看', false);
		JToolBarHelper::divider();
		*/
		
		if($canDo->get('core.edit')){
			JToolbarHelper::editList('wenzhang.edit');
			
			JToolBarHelper::custom('wenzhangs.jing', 'unblock.png', 'unblock.png', '加精', false);
			JToolBarHelper::divider();

			JToolBarHelper::custom('wenzhangs.jing', 'unpublish.png', 'unpublish.png', '取消加精', false);
			JToolBarHelper::divider();
		}

		if($canDo->get('core.delete')){
			JToolbarHelper::deleteList('', 'wenzhangs.delete', 'JTOOLBAR_DELETE');
		}
		if($canDo->get('core.admin')){
			JToolbarHelper::preferences('com_wenzhang');
		}
	}
}
