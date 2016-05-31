<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class HospitalModelDoctor extends JModelAdmin{
	protected $text_prefix = 'COM_HOSPITAL';

	public function getTable($type = 'Doctor', $prefix = 'HospitalTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_hospital.doctor', 'doctor', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_hospital.edit.doctor.data', array());

		if(empty($data)){
			$data = $this->getItem();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;

			$doctor_item_path = $mp->getJsonPath(6);
			$item_info = json_decode(file_get_contents($doctor_item_path.'/'.$data->id), true);

			$data->intro = $item_info['intro'];
		}

		return $data;
	}

	/**
	 * 实现保存功能
	 * author wangrui
	 * date 2015-04-27
	 */
	public function save($data){
		$id = trim($data['id']);
		$name = trim($data['name']);
		$pos = trim($data['pos']);
		$img = trim($data['img']);
		$direction = trim($data['direction']);
		$intro = trim($data['intro']);
		$hid = intval(trim($data['hid']));

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		//验证姓名
		if(empty($name)){
			$this->setError("：请填写姓名!");
			return false;
		}
		if(!$mp->isXingming($name)){
			$this->setError("：姓名不符合格式!");
			return false;
		}

		//验证头像图片
		if(empty($img)){
			$this->setError("：请上传头像图片!");
			return false;
		}
		if(!$mp->isImg($img)){
			$this->setError("：头像图片名或类型不符合要求!");
			return false;
		}
		if(strpos($img, 'http') !== false){
			$this->setError("：头像图片请上传，暂不支持网络图片!");
			return false;
		}

		//验证职称
		if(empty($pos)){
			$this->setError("：请填写职称!");
			return false;
		}
		if(!$mp->isName($pos, 2)){
			$this->setError("：职称不符合格式!");
			return false;
		}

		//验证方向
		if(empty($direction)){
			$this->setError("：请填写主攻方向!");
			return false;
		}
		if(!$mp->isName($direction, 3)){
			$this->setError("：主攻方向不符合格式!");
			return false;
		}

		//验证简介
		if(empty($intro)){
			$this->setError("：请填写医生简介!");
			return false;
		}

		$db = JFactory::getDBO();

		//获取之前的hid
		if($id > 0){
			$query = "select hid from #__doctor where id = ".$id;
			$db->setQuery($query);
			$old_hid = $db->loadResult();
		}else{
			$old_hid = $hid;
		}

		$save_array['name'] = $name;
		$save_array['hid'] = $hid;
		$save_array['img'] = $img;
		$save_array['pos'] = $pos;
		$save_array['direction'] = $direction;
		$save_array['intime'] = time();

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			$doctor_item_path = $mp->getJsonPath(6);

			$query = "select * from #__doctor where intime = ".$save_array['intime'];
			$db->setQuery($query);
			$info = $db->loadObject();
			$info->intro = $intro;

			file_put_contents($doctor_item_path.'/'.$info->id, json_encode($info));

			$this->updateJson($db, $mp, $hid, $old_hid);

			return true;
		}else{
			return false;
		}
	}

	//更新json文件
	private function updateJson($db, $mp, $hid, $old_hid){
		$query = "select id from #__doctor where hid = ".$hid;
		$db->setQuery($query);
		$d_list = $db->loadObjectList();

		$hosital_item_path = $mp->getJsonPath(1).$hid;
		file_put_contents($hosital_item_path.'/doctor', json_encode($d_list));

		if($hid != $old_hid){
			$query = "select * from #__doctor where hid = ".$old_hid;
			$db->setQuery($query);
			$d_list = $db->loadObjectList();

			$hosital_item_path = $mp->getJsonPath(1).$old_hid;
			file_put_contents($mp->getJsonPath(1).$old_hid."/doctor", json_encode($d_list));
		}
	}

	//实现删除功能
	public function delete(&$data){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$db = JFactory::getDBO();
		for($i = 0; $i < count($data); $i++){
			$id = $data[$i];

			$query = "select count(*) from #__doctor where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}

			$query = "select hid from #__doctor where id = ".$id;
			$db->setQuery($query);
			$hid = $db->loadResult();
			
			$table = $this->getTable();
			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}

			$doctor_item_path = $mp->getJsonPath(6);
			unlink($doctor_item_path.'/'.$id);

			$this->updateJson($db, $mp, $hid, $hid);
		}
		
		return true;
	}
}