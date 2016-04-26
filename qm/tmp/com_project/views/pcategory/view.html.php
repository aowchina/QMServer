<?php

defined('_JEXEC') or die;

class ProjectViewPcategory extends JViewLegacy{
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
			JToolbarHelper::title(JText::_('项目类别：编辑'), 'newsfeeds.png');
		}else{
			JToolbarHelper::title(JText::_('项目类别：新建'), 'newsfeeds.png');
		}

		JToolbarHelper::save('pcategory.save');

		if(empty($this->item->id)){
			JToolbarHelper::cancel('pcategory.cancel');
		}else{
			JToolbarHelper::cancel('pcategory.cancel', 'JTOOLBAR_CLOSE');
		}
	}
}
