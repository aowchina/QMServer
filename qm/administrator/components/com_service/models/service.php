<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class ServiceModelService extends JModelAdmin{
	protected $text_prefix = 'COM_SERVICE';

	public function getTable($type = 'Service', $prefix = 'ServiceTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_service.service', 'service', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_service.edit.service.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}
		return $data;
	}
}
