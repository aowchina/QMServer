<?php

defined('_JEXEC') or die;

class KechengViewKecheng extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('课程管理：编辑课程'), 'help_header.png');
		}else{
			JToolbarHelper::title(JText::_('课程管理：添加课程'), 'help_header.png');
		}

		JToolbarHelper::save('kecheng.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('kecheng.cancel');
		}else{
			JToolbarHelper::cancel('kecheng.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}

?>
