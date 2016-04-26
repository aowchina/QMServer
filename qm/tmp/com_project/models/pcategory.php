<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');
class ProjectModelPcategory extends JModelAdmin{
	protected $text_prefix = 'COM_PCATEGORY';

	public function getTable($type = 'Pcategory', $prefix = 'ProjectTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_project.pcategory', 'pcategory', array('control'=>'jform', 'load_data'=>$loadData));

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

	/**
	 * 实现保存功能
	 * author wangrui
	 * date 2015-04-27
	 */
	/*
	public function save($data){
		$id = trim($data['id']);
		$name = trim($data['name']);
		$imgurl = trim($data['imgurl']);
		$hid = intval(trim($data['hid']));
		$position = trim($data['position']);
		$direction = trim($data['direction']);
		$weight = trim($data['weight']);
		//验证医生姓名
		if($name == '' || $name == null){
			$this->setError("：请填写姓名!");
			return false;
		}

		//验证照片
		if($imgurl == '' || $imgurl == null){
			$this->setError("：请上传本人照片!");
			return false;
		}

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		if(!$mp->isExp($imgurl, 1)){
			$this->setError("：照片名或类型不符合要求!");
			return false;
		}

		//验证职位
		if($position = '' ||$position = null)
		{
			$this->setError(":请填写您的职位");
			return false;
		}

		//验证临床方向
		if($direction == null || $direction == ''){
			$this->setError("：请填写临床方向!");
			return false;
		}

		

		//验证权重
		if($weight == null || $weight == ''){
			$this->setError("：请填写权重!");
			return false;
		}
	
		$db = JFactory::getDBO();

		if($id == 0){
			$now_time = time();
			$createtime = $now_time;
			$save_array['createtime'] = $save_array['intime'] = $now_time;
		}else{
			$query = "select createtime from #__doctor where id = ".$id;
			$db->setQuery($query);
			$createtime = $db->loadResult();

			$save_array['createtime'] = $createtime;
			$save_array['intime'] = time();
		}

		$save_array['name'] = $name;
		$save_array['imgurl'] = $imgurl;
		$save_array['position'] = $position;
		$save_array['hid'] = $hid;
		$save_array['direction'] = $direction;
		$save_array['weight'] = $weight;

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			return true;
		}
		}

	/**
	 * 实现删除功能
	 * author wangrui
	 * date 2015-04-27
	 */
	/*
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

			/*
			$query = "select createtime from #__doctor where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			$save_path = $mp->getJsonPath(1).$result;
			*/
			/*
			$table = $this->getTable();
			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}
		}

		return true;
	}
*/
}
