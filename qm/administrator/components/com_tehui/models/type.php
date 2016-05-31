<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TehuiModelType extends JModelAdmin{

	public function getTable($type = 'Type', $prefix = 'TehuiTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_tehui.type', 'type', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_tehui.edit.type.data', array());

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

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;
		
		//验证名称
		if($name == '' || $name == null){
			$this->setError("：请填写名称!");
			return false;
		}
		if(!$mp->isName($name, 4)){
			$this->setError("：名称不符合格式!");
			return false;
		}
	
		$db = JFactory::getDBO();

		//名称验重
		if($id > 0){
			$query = "select count(*) from #__tehui_type where name = '".$name."' and id <> ".$id;
		}else{
			$query = "select count(*) from #__tehui_type where name = '".$name."'";
		}
		
		$db->setQuery($query);
		$count = $db->loadResult();
		if($count > 0){
			$this->setError("：名称存在重复记录!");
			return false;
		}

		$save_array['name'] = $name;
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

	//更新Json文件
	private function updateJson($db){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$query = "select * from #__tehui_type order by id";
		$db->setQuery($query);
		$list = $db->loadObjectList();

		$filepath = $mp->getJsonPath(4).'type';
		if(!is_dir($filepath)){
			mkdir($filepath);
		}
		$filename = $filepath.'/list';

		file_put_contents($filename, json_encode($list));
	}
}
