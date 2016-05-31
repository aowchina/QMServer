<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class ActModelAct extends JModelAdmin{
	protected $text_prefix = 'COM_ACT';

	public function getTable($type = 'Act', $prefix = 'ActTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_act.act', 'act', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_act.edit.act.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}
		return $data;
	}

	//保存
	public function save($data){
		$id = trim($data['id']);
		$name = trim($data['name']);
		$fname = trim($data['fname']);
		$hid = intval(trim($data['hid']));
		$pid = intval(trim($data['pid']));
		$simg = trim($data['simg']);
		$bimg = trim($data['bimg']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		//验名称
		if(empty($name)){
			$this->setError("：请填写主题标题!");
			return false;
		}
		if(!$mp->isName($name, 8)){
			$this->setError("：标题不符合格式!");
			return false;
		}

		//副标题
		if(empty($fname)){
			$this->setError("：请填写主题副标题!");
			return false;
		}
		if(!$mp->isName($fname, 8)){
			$this->setError("：副标题不符合格式!");
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

		if($pid != 0 && $hid != 0){
			$this->setError("：主题活动只能面向一个医院或项目!");
			return false;
		}

		if($pid == 0 && $hid == 0){
			$this->setError("：主题活动必须面向一个医院或项目!");
			return false;
		}

		$db = JFactory::getDBO();

		if($id > 0){
			$query = "select count(*) from #__act where name = '".$name."' and id <> ".$id;
		}else{
			$query = "select count(*) from #__act where name = '".$name."'";
		}

		$save_array['name'] = $name;
		$save_array['fname'] = $fname;
		$save_array['hid'] = $hid;
		$save_array['pid'] = $pid;
		$save_array['simg'] = $simg;
		$save_array['bimg'] = $bimg;
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
		//首先更新全部主题
		$query = "select * from #__act order by intime desc";
		$db->setQuery($query);
		$t_list = $db->loadObjectList();

		$act_path = $mp->getJsonPath(5).'total';
		if(!is_dir($act_path)){
			mkdir($act_path);
		}
		file_put_contents($act_path.'/list', json_encode($t_list));
	}

	/**
	 * 实现删除功能
	 * author wangrui
	 * date 2015-04-27
	 */
	public function delete(&$data){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$db = JFactory::getDBO();
		for($i = 0; $i < count($data); $i++){
			$id = $data[$i];

			$query = "select count(*) from #__act where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}
			
			$table = $this->getTable();
			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}
		}
		
		$this->updateJson($db, $mp);
		return true;
	}
}




