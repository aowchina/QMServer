<?php

defined('_JEXEC') or die;

class WenzhangViewWenzhang extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('文章：编辑'), 'article.png');
		}else{
			JToolbarHelper::title(JText::_('文章：新建'), 'article.png');
		}

		if(empty($this->item->id)){
			JToolbarHelper::cancel('wenzhang.cancel');
		}else{
			JToolbarHelper::cancel('wenzhang.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
