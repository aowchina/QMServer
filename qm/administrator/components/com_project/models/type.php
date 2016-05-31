<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class ProjectModelType extends JModelAdmin{

	public function getTable($type = 'Type', $prefix = 'ProjectTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_project.type', 'type', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_project.edit.type.data', array());

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
		$icon = trim($data['icon']);
		
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		//验证名称
		if($name == '' || $name == null){
			$this->setError("：请填写名称!");
			return false;
		}
		if(!$mp->isName($name, 6)){
			$this->setError("：名称不符合格式!");
			return false;
		}

		//验证icon
		if($icon == '' || $icon == null){
			$this->setError("：请上传icon图标!");
			return false;
		}
		if(!$mp->isImg($icon)){
			$this->setError("：图片名或类型不符合要求!");
			return false;
		}
		if(strpos($icon, 'http') !== false){
			$this->setError("：图片请上传，暂不支持网络图片!");
			return false;
		}
	
		$db = JFactory::getDBO();

		//名称验重
		if($id > 0){
			$query = "select count(*) from #__project_type where name = '".$name."' and id <> ".$id;
		}else{
			$query = "select count(*) from #__project_type where name = '".$name."'";
		}
		
		$db->setQuery($query);
		$count = $db->loadResult();
		if($count > 0){
			$this->setError("：名称存在重复记录!");
			return false;
		}

		$save_array['name'] = $name;
		$save_array['icon'] = $icon;
		$save_array['intime'] = time();

		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			$this->updateJson($db);
			return true;
		}else{
			return false;
		}
	}

	/**
	 * 实现删除功能
	 * author wangrui
	 * date 2015-04-27
	 */
	public function delete(&$data){
		$db = JFactory::getDBO();
		for($i = 0; $i < count($data); $i++){
			$id = $data[$i];

			$query = "select count(*) from #__project_type where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();
			if($result != 1){
				$this->setError("：第".($i+1)."条记录不存在或已被删除!");
				return false;
			}

			$query = "select count(*) from #__project where ptid = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result > 0){
				$this->setError("：第".($i+1)."个类别下有项目记录，不能删除!");
				return false;
			}
			
			$table = $this->getTable();
			$table->delete($id);
		}
		$this->updateJson($db);
		return true;
	}

	//更新Json文件
	private function updateJson($db){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$query = "select * from #__project_type order by id";
		$db->setQuery($query);
		$list_t = $db->loadObjectList();

		for($i = 0; $i < count($list_t); $i++){
			$query = "select id,name from #__project where ptid = ".$list_t[$i]->id." order by id";
			$db->setQuery($query);
			$list_p = $db->loadObjectList();
			if(count($list_p) <= 0){
				$list_p = array();
			}

			$list_t[$i]->list = $list_p;
		}

		$filename = $mp->getJsonPath(2).'total';

		file_put_contents($filename, json_encode($list_t));
	}
}
