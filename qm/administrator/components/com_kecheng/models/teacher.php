<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class KechengModelTeacher extends JModelAdmin{
	protected $text_prefix = 'COM_KECHENG';

	public function getTable($type = 'Teacher', $prefix = 'KechengTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_kecheng.teacher', 'teacher', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_kecheng.edit.teacher.data', array());

		if(empty($data)){
			$data = $this->getItem();
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
		$logo = trim($data['logo']);
		$intro = trim($data['intro']);
		$courseid = intval(trim($data['courseid']));

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
		if(empty($logo)){
			$this->setError("：请上传头像图片!");
			return false;
		}
		if(!$mp->isImg($logo)){
			$this->setError("：头像图片名或类型不符合要求!");
			return false;
		}
		if(strpos($logo, 'http') !== false){
			$this->setError("：头像图片请上传，暂不支持网络图片!");
			return false;
		}

		//验证简介
		if(empty($intro)){
			$this->setError("：请填写简介!");
			return false;
		}

		$db = JFactory::getDBO();

		if($id == 0){
			$query = "select count(*) from #__teacher where courseid = ".$courseid;
		}else{
			$query = "select count(*) from #__teacher where courseid = ".$courseid." and id <> ".$id;
		}
		
		$db->setQuery($query);
		$result = $db->loadResult();
		if($result > 0){
			$this->setError("：该课程已绑定其它教师!");
			return false;
		}

		$save_array['name'] = $name;
		$save_array['courseid'] = $courseid;
		$save_array['logo'] = $logo;
		$save_array['intro'] = $intro;
		$save_array['intime'] = time();

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			$item_path = $mp->getJsonPath(8);

			$query = "select * from #__teacher where intime = ".$save_array['intime'];
			$db->setQuery($query);
			$info = $db->loadObject();

			file_put_contents($item_path.'/'.$info->id, json_encode($info));

			$query = "select id,logo,name from #__teacher order by id desc";
			$db->setQuery($query);
			$list = $db->loadObjectList();
			file_put_contents($item_path.'/list', json_encode($list));

			return true;
		}else{
			return false;
		}
	}

	//实现删除功能
	public function delete(&$data){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$db = JFactory::getDBO();
		for($i = 0; $i < count($data); $i++){
			$id = $data[$i];

			$query = "select count(*) from #__teacher where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}

			$item_path = $mp->getJsonPath(8);
			unlink($item_path.'/'.$id);

			$query = "select * from #__teacher order by id desc";
			$db->setQuery($query);
			$list = $db->loadObjectList();
			file_put_contents($item_path.'/list', json_encode($list));
		}
		
		return true;
	}
}