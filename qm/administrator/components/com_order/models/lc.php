<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

/**
 * 详情模型类
 * author wangrui
 * date 2015-04-27
 */
class OrderModelLc extends JModelAdmin{
	protected $text_prefix = 'COM_ORDER';

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_order.lc', 'lc', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_order.edit.lc.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}

		return $data;
	}

	public function getItem(){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$filename = $mp->getJsonPath(4).'lc';
		if(is_file($filename)){
			$data->lc = file_get_contents($filename);
		}else{
			$data->lc = "";
		}

		$filename = $mp->getJsonPath(4).'lcnote';
		if(is_file($filename)){
			$data->lcnote = file_get_contents($filename);
		}else{
			$data->lcnote = "";
		}

		return $data;
	}
}
