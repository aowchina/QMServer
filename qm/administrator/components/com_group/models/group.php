<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class GroupModelGroup extends JModelAdmin{
	protected $text_prefix = 'COM_GROUP';

	public function getTable($type = 'Group', $prefix = 'GroupTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_group.group', 'group', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_group.edit.group.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}
		return $data;
	}

	/*
	 * 保存数据
	 */
	public function save($data){
		$id = trim($data['id']);
		$name = trim($data['name']);
		$icon = $data['icon'];
		$intro = $data['intro'];

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		//验证小组名
		if($name == '' || $name == null){
			$this->setError("：小组名称不能为空!");
			return false;
		}
		if(!$mp->isName($name, 4)){
			$this->setError("：小组名称不符合格式!");
			return false;
		}

		//验证图片名
		if($icon == '' || $icon == null){
			$this->setError("：icon不能为空");
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

		//验证简介
		if($intro == '' || $intro == null){
			$this->setError("：简介描述不能为空");
			return false;
		}
		if(!$mp->isName($intro, 5)){
			$this->setError("：小简介描述不符合格式!");
			return false;
		}

		$db = JFactory::getDBO();

		//名称验重
		if($id > 0){
			$query = "select count(*) from #__group where name = '".$name."' and id <> ".$id;
		}else{
			$query = "select count(*) from #__group where name = '".$name."'";
		}
		
		$db->setQuery($query);
		$count = $db->loadResult();
		if($count > 0){
			$this->setError("：名称存在重复记录!");
			return false;
		}

		//个数上限
		if($id == 0){
			$query = "select count(*) from #__group";
			$db->setQuery($query);
			$count = $db->loadResult();
			if($count >= 8){
				$this->setError("：最多能创建8个小组!");
				return false;
			}
		}

		$save_array['name'] = $name;
		$save_array['intime'] = time();
		$save_array['icon'] = $icon;
		$save_array['intro'] = $intro;
		$save_array['intime'] = time();
		if($id != 0){
			$save_array['id'] = $id;
		}

		if (parent::save($save_array)) {

			//生成单个小组数据
			$query = "select * from #__group where name = '".$name."'";
			$db->setQuery($query);
			$info = $db->loadObject();
			$group_item_path = $mp->getJsonPath(3).$info->id;
			$mp->mkdirs($group_item_path);
			file_put_contents($group_item_path.'/baseinfo', json_encode($info));

			$this->updateJson($db, $mp);
			return true;
		}else{
			return false;
		}
	}

	//更新json文件
	private function updateJson($db, $mp){
		$query = "select id from #__group order by id";
		$db->setQuery($query);
		$g_list = $db->loadObjectList();

		$json_path = $mp->getJsonPath(3);
		file_put_contents($json_path.'/list', json_encode($g_list));
	}
}
