<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TehuiModelTehui extends JModelAdmin{
	protected $text_prefix = 'COM_TEHUI';

	public function getTable($type = 'Tehui', $prefix = 'TehuiTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_tehui.tehui', 'tehui', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_tehui.edit.tehui.data', array());

		if(empty($data)){
			$data = $this->getItem();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;

			$item_file = $mp->getJsonPath(4).'item/'.$data->id."/baseinfo";
			$info = json_decode(file_get_contents($item_file), true);

			$data->intro = $info['intro'];
			$data->detail = $info['detail'];
		}
		return $data;
	}

	//保存
	public function save($data){
		$id = trim($data['id']);
		$name = trim($data['name']);
		$fname = trim($data['fname']);
		$oldval = trim($data['oldval']);
		$newval = trim($data['newval']);
		$dj = trim($data['dj']);
		$pid = intval(trim($data['pid']));
		$hid = intval(trim($data['hid']));
		$tid = intval(trim($data['tid']));
		$simg = trim($data['simg']);
		$bimg = trim($data['bimg']);
		$intro = trim($data['intro']);
		$detail = trim($data['detail']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		if(empty($name)){
			$this->setError("：请填写特惠名称!");
			return false;
		}
		if(!$mp->isName($name, 9)){
			$this->setError("：特惠名称不符合格式!");
			return false;
		}

		if(empty($fname)){
			$this->setError("：请填写前缀标题!");
			return false;
		}
		if(!$mp->isName($fname, 9)){
			$this->setError("：前缀标题不符合格式!");
			return false;
		}

		if(!$mp->isImg($simg)){
			$this->setError("：小图名或类型不符合要求!");
			return false;
		}
		if(strpos($simg, 'http') !== false){
			$this->setError("：图片请上传，暂不支持网络图片!");
			return false;
		}

		if(!$mp->isImg($bimg)){
			$this->setError("：大图名或类型不符合要求!");
			return false;
		}
		if(strpos($bimg, 'http') !== false){
			$this->setError("：图片请上传，暂不支持网络图片!");
			return false;
		}

		if(!$mp->isImg($detail)){
			$this->setError("：展示图名或类型不符合要求!");
			return false;
		}
		if(strpos($detail, 'http') !== false){
			$this->setError("：图片请上传，暂不支持网络图片!");
			return false;
		}

		if(empty($oldval)){
			$this->setError("：请填写原价!");
			return false;
		}
		if(!$mp->isName($oldval, 10)){
			$this->setError("：原价不符合格式!");
			return false;
		}

		if(empty($newval)){
			$this->setError("：请填写特惠价!");
			return false;
		}
		if(!$mp->isName($newval, 10)){
			$this->setError("：特惠价不符合格式!");
			return false;
		}

		if(empty($dj)){
			$this->setError("：请填写原价!");
			return false;
		}
		if(!$mp->isName($dj, 10)){
			$this->setError("：订金不符合格式!");
			return false;
		}

		$db = JFactory::getDBO();

		$save_array['name'] = $name;
		$save_array['fname'] = $fname;
		$save_array['oldval'] = $oldval;
		$save_array['newval'] = $newval;
		$save_array['dj'] = $dj;
		$save_array['pid'] = $pid;
		$save_array['hid'] = $hid;
		$save_array['tid'] = $tid;
		$save_array['simg'] = $simg;
		$save_array['bimg'] = $bimg;
		$save_array['intro'] = $intro;
		$save_array['detail'] = $detail;
		$save_array['intime'] = time();

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			if($id == 0){
				$query = "select id from #__tehui where intime = ".$save_array['intime'];
				$db->setQuery($query);
				$id = $db->loadResult();
				$save_array['id'] = $id;
			}

			$item_path = $mp->getJsonPath(4).'item/'.$id;
			$mp->mkdirs($item_path);
			file_put_contents($item_path.'/baseinfo', json_encode($save_array));

			$this->updateJson($db, $mp);
			return true;
		}else{
			return false;
		}
	}

	//更新json
	private function updateJson($db, $mp){
		//首先更新全部特惠
		$query = "select id from #__tehui order by intime desc";
		$db->setQuery($query);
		$t_list = $db->loadObjectList();

		$file_amount = ceil(count($t_list) / 10);
		$tehui_path = $mp->getJsonPath(4).'total';
		if(!is_dir($tehui_path)){
			mkdir($tehui_path);
		}
		for($i = 0; $i < $file_amount; $i++){
			file_put_contents($tehui_path.'/'.($i+1), json_encode(array_slice($t_list, $i*10, 10)));
		}

		//然后按类别更新json
		$tehui_type_path = $mp->getJsonPath(4).'type';
		if(!is_dir($tehui_type_path)){
			mkdir($tehui_type_path);
		}
		$query = "select id from #__tehui_type";
		$db->setQuery($query);
		$type_list = $db->loadObjectList();
		foreach($type_list as $type_item){
			$id = $type_item->id;

			$query = "select id from #__tehui where tid = ".$id." order by intime desc";
			$db->setQuery($query);
			$t_list = $db->loadObjectList();
			$file_amount = ceil(count($t_list) / 10);
			if(!is_dir($tehui_type_path.'/'.$id)){
				mkdir($tehui_type_path.'/'.$id);
			}

			for($i = 0; $i < $file_amount; $i++){
				file_put_contents($tehui_type_path.'/'.$id.'/'.($i+1), json_encode(array_slice($t_list, $i*10, 10)));
			}
		}

		//然后按项目更新json
		$tehui_project_path = $mp->getJsonPath(4).'project';
		if(!is_dir($tehui_project_path)){
			mkdir($tehui_project_path);
		}
		$query = "select id from #__project";
		$db->setQuery($query);
		$p_list = $db->loadObjectList();
		foreach($p_list as $p_item){
			$id = $p_item->id;

			$query = "select id from #__tehui where pid = ".$id." order by intime desc";
			$db->setQuery($query);
			$t_list = $db->loadObjectList();
			$file_amount = ceil(count($t_list) / 10);
			if(!is_dir($tehui_project_path.'/'.$id)){
				mkdir($tehui_project_path.'/'.$id);
			}

			for($i = 0; $i < $file_amount; $i++){
				file_put_contents($tehui_project_path.'/'.$id.'/'.($i+1), json_encode(array_slice($t_list, $i*10, 10)));
			}
		}

		//然后按医院更新json
		$tehui_hospital_path = $mp->getJsonPath(4).'hospital';
		if(!is_dir($tehui_hospital_path)){
			mkdir($tehui_hospital_path);
		}
		$query = "select id from #__hospital";
		$db->setQuery($query);
		$h_list = $db->loadObjectList();
		foreach($h_list as $h_item){
			$id = $h_item->id;

			$query = "select id from #__tehui where hid = ".$id." order by intime desc";
			$db->setQuery($query);
			$t_list = $db->loadObjectList();
			$file_amount = ceil(count($t_list) / 10);
			if(!is_dir($tehui_hospital_path.'/'.$id)){
				mkdir($tehui_hospital_path.'/'.$id);
			}

			for($i = 0; $i < $file_amount; $i++){
				file_put_contents($tehui_hospital_path.'/'.$id.'/'.($i+1), json_encode(array_slice($t_list, $i*10, 10)));
			}
		}
	}
}
