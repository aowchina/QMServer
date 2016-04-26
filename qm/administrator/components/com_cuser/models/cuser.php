<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class CuserModelCuser extends JModelAdmin{
	protected $text_prefix = 'COM_CUSER';

	public function getTable($type = 'Cuser', $prefix = 'CuserTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_cuser.cuser', 'cuser', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_cuser.edit.cuser.data', array());

		if(empty($data)){
			$data = $this->getItem();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;
			$db = JFactory::getDBO();

			$data->username = $mp->getStrFromByte($data->username);

			if(!$data->tel){
				$data->tel = '未设置';
			}

			switch($data->sex){
				case 1:
					$data->sex = '女';
					break;
				case 2:
					$data->sex = '男';
					break;
				default:
					$data->sex = '保密';
					break;
			}

			if($data->block){
				$data->block = "拉黑";
			}else{
				$data->block = "正常";
			}

			if($data->pid){
				$query = "select name from #__province where id = ".$data->pid;
				$db->setQuery($query);
				$data->pid = $db->loadResult();
			}else{
				$data->pid = '未设置';
			}

			if($data->cid){
				$query = "select name from #__city where id = ".$data->pid;
				$db->setQuery($query);
				$data->cid = $db->loadResult();
			}else{
				$data->cid = '未设置';
			}

			$data->intime = date("Y-m-d H:i:s", $data->intime);
		}
		return $data;
	}

	//保存
	public function save($data){
		$id = trim($data['id']);
		$name = trim($data['name']);
		$fname = trim($data['fname']);
		$oldval = intval(trim($data['oldval']));
		$newval = intval(trim($data['newval']));
		$dj = intval(trim($data['dj']));
		$pid = intval(trim($data['pid']));
		$hid = intval(trim($data['hid']));
		$tid = intval(trim($data['tid']));
		$simg = trim($data['simg']);
		$bimg = trim($data['bimg']);
		$intro = trim($data['intro']);
		$lc = trim($data['lc']);
		$detail = trim($data['detail']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		if(!$mp->isExp($simg, 1)){
			$this->setError("：小图名或类型不符合要求!");
			return false;
		}

		if(!$mp->isExp($bimg, 1)){
			$this->setError("：大图名或类型不符合要求!");
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
		$save_array['lc'] = $lc;
		$save_array['detail'] = $detail;
		$save_array['intime'] = time();

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			$this->updateJson($db, $mp);
			return true;
		}else{
			return false;
		}
	}

	//更新json
	private function updateJson($db, $mp){
		//首先更新全部特惠
		$query = "select * from #__tehui order by intime desc";
		$db->setQuery($query);
		$t_list = $db->loadObjectList();

		$file_amount = ceil(count($t_list) / 10);
		$tehui_path = $mp->getJsonPath(4).'total';
		if(!is_dir($tehui_path)){
			mkdir($tehui_path);
		}
		for($i = 0; $i < count($file_amount); $i++){
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

			$query = "select * from #__tehui where tid = ".$id." order by intime desc";
			$db->setQuery($query);
			$t_list = $db->loadObjectList();
			$file_amount = ceil(count($t_list) / 10);
			if(!is_dir($tehui_type_path.'/'.$id)){
				mkdir($tehui_type_path.'/'.$id);
			}

			for($i = 0; $i < count($file_amount); $i++){
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

			$query = "select * from #__tehui where pid = ".$id." order by intime desc";
			$db->setQuery($query);
			$t_list = $db->loadObjectList();
			$file_amount = ceil(count($t_list) / 10);
			if(!is_dir($tehui_project_path.'/'.$id)){
				mkdir($tehui_project_path.'/'.$id);
			}

			for($i = 0; $i < count($file_amount); $i++){
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

			$query = "select * from #__tehui where hid = ".$id." order by intime desc";
			$db->setQuery($query);
			$t_list = $db->loadObjectList();
			$file_amount = ceil(count($t_list) / 10);
			if(!is_dir($tehui_hospital_path.'/'.$id)){
				mkdir($tehui_hospital_path.'/'.$id);
			}

			for($i = 0; $i < count($file_amount); $i++){
				file_put_contents($tehui_hospital_path.'/'.$id.'/'.($i+1), json_encode(array_slice($t_list, $i*10, 10)));
			}
		}
	}
}




