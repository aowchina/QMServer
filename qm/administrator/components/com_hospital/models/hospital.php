<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class HospitalModelHospital extends JModelAdmin{
	protected $text_prefix = 'COM_HOSPITAL';

	public function getTable($type = 'Hospital', $prefix = 'HospitalTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_hospital.hospital', 'hospital', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_hospital.edit.hospital.data', array());

		if(empty($data)){
			$data = $this->getItem();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;

			$hospital_item_path = $mp->getJsonPath(1).$data->id;
			$xc_list = json_decode(file_get_contents($hospital_item_path.'/xcimg'), true);
			foreach($xc_list as $key => $item_xc){
				$var_name = "simg".($key+1);
				$data->$var_name = $item_xc;
			}

			$al_list = json_decode(file_get_contents($hospital_item_path.'/alimg'), true);
			foreach($al_list as $key => $item_al){
				$var_name = "alimg".($key+1);
				$data->$var_name = $item_al;
			}

			$data->intro = file_get_contents($hospital_item_path.'/intro');
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
		$pid = intval(trim($data['pid']));
		$cid = intval(trim($data['cid']));
		$logo = trim($data['logo']);
		$intro = trim($data['intro']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		//验证医院名称
		if(empty($name)){
			$this->setError("：请填写医院名称!");
			return false;
		}
		if(!$mp->isName($name, 1)){
			$this->setError("：医院名称不符合格式!");
			return false;
		}

		//验证logo图片
		if(empty($logo)){
			$this->setError("：请上传LOGO图片!");
			return false;
		}
		if(strpos($logo, 'http') !== false){
			$this->setError("：LOGO图片请上传，暂不支持网络图片!");
			return false;
		}

		if(!$mp->isImg($logo)){
			$this->setError("：LOGO图片名或类型不符合要求!");
			return false;
		}

		//验证简介
		if(empty($intro)){
			$this->setError("：请填写医院简介!");
			return false;
		}

		//验证宣传图
		$xc_list = array();
		for($i = 1; $i <= 4; $i++){
			$simg = trim($data['simg'.$i]);
			if(!empty($simg)){
				if(!$mp->isImg($simg)){
					$this->setError("：宣传图".$i."名或类型不符合要求!");
					return false;
				}

				if(strpos($simg, 'http') !== false){
					$this->setError("：宣传图".$i."请上传，暂不支持网络图片!");
					return false;
				}

				$xc_list[] = $simg;
			}
		}

		//验证案例图
		$al_list = array();
		for($i = 1; $i <= 3; $i++){
			$alimg = trim($data['alimg'.$i]);
			if(!empty($alimg)){
				if(!$mp->isImg($alimg)){
					$this->setError("：案例图".$i."名或类型不符合要求!");
					return false;
				}

				if(strpos($alimg, 'http') !== false){
					$this->setError("：案例图".$i."请上传，暂不支持网络图片!");
				}

				$al_list[] = $alimg;
			}
		}

		$db = JFactory::getDBO();

		//医院名验重
		if($id == 0){
			$query = "select count(*) from #__hospital where name = '".$name."'";
		}else{
			$query = "select count(*) from #__hospital where name = '".$name."' and id <> ".$id;
		}
		$db->setQuery($query);
		$count = $db->loadResult();
		if($count > 0){
			$this->setError("：医院名称存在重复记录!");
			return false;
		}

		//构建db插入数组
		$save_array['name'] = $name;
		$save_array['pid'] = $pid;
		$save_array['cid'] = $cid;
		$save_array['logo'] = $logo;
		$save_array['intime'] = time();
		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			if($id == 0){
				$query = "select id from #__hospital where name = '".$name."'";
				$db->setQuery($query);
				$id = $db->loadResult();
			}

			//更新json文件
			$query = "select * from #__hospital where id = ".$id;
			$db->setQuery($query);
			$info = $db->loadObject();

			$hospital_item_path = $mp->getJsonPath(1).$id;
			$mp->mkdirs($hospital_item_path);

			file_put_contents($hospital_item_path.'/baseinfo', json_encode($info));
			file_put_contents($hospital_item_path.'/alimg', json_encode($al_list));
			file_put_contents($hospital_item_path.'/xcimg', json_encode($xc_list));
			file_put_contents($hospital_item_path.'/intro', $intro);

			return true;
		}else{
			return false;
		}
	}
}