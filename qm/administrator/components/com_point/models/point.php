<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class PointModelPoint extends JModelAdmin{
	protected $text_prefix = 'COM_POINT';

	public function getTable($type = 'Point', $prefix = 'PointTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_point.point', 'point', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_point.edit.point.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}
		return $data;
	}

	//保存
	public function save($data){
		$id = trim($data['id']);
		$qd_point = trim($data['qd_point']);
		$xf_point = trim($data['xf_point']);

		if(empty($qd_point)){
			$this->setError("：请填写签到积分!");
			return false;
		}

		if(empty($xf_point)){
			$this->setError("：请填写消费积分!");
			return false;
		}
		
		if(!$this->isFloat($qd_point, 8, 2)){
			$this->setError("：签到积分不符合要求!");
			return false;
		}

		if(!$this->isFloat($xf_point, 8, 2)){
			$this->setError("：消费积分不符合要求!");
			return false;
		}

		$db = JFactory::getDBO();

		$sql = "select count(*) from #__point_rule";
		$db->setQuery($sql);
		$count = $db->loadResult();

		if($id > 0){
			if($count != 1){
				$this->setError("：只能拟订一条规则!");
				return false;
			}
		}else{
			if($count != 0){
				$this->setError("：只能拟订一条规则!");
				return false;
			}
		}

		$save_array['qd_point'] = $qd_point;
		$save_array['xf_point'] = $xf_point;
		$save_array['intime'] = time();

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			return true;
		}else{
			return false;
		}
	}

	private function isFloat($str, $int_len, $num_len){
		if(strpos($str, '.') !== false){
			$list = explode('.', $str);

			if(preg_match('/^[0-9]{1,8}$/', $list[0]) && preg_match('/^[0-9]{1,2}$/', $list[1])){
				if($str > 0){
					return true;
				}
			}
		}
		else{
			if(preg_match('/^[0-9]{1,8}$/', $str)){
				if($str > 0){
					return true;
				}
			}
		}
		return false;
	}
}
