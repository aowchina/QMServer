<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class ProjectModelProject extends JModelAdmin{
	protected $text_prefix = 'COM_PROJECT';

	public function getTable($type = 'Project', $prefix = 'ProjectTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_project.project', 'project', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_project.edit.project.data', array());

		if(empty($data)){
			$data = $this->getItem();

			}

		return $data;
	
}

}




