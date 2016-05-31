<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');
class GroupModelLabel extends JModelAdmin{
	protected $text_prefix = 'COM_LABEL';

	public function getTable($type = 'Label', $prefix = 'GroupTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_group.label', 'label', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_group.edit.label.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}
		return $data;
	}

	/*
	 * 保存数据
	 */
	public function save($data){
		$id = intval(trim($data['id']));
		$name = trim($data['name']);
		$gid = intval(trim($data['gid']));

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		if(empty($name)){
			$this->setError("：标签名称不能为空!");
			return false;
		}
		if(!$mp->isName($name, 6)){
			$this->setError("：标签名称不符合格式!");
			return false;
		}

		$db = JFactory::getDBO();

		//名称验重
		if($id > 0){
			$query = "select count(*) from #__group_tag where name = '".$name."' and gid = ".$gid." and id <> ".$id;
		}else{
			$query = "select count(*) from #__group_tag where name = '".$name."' and gid = ".$gid;
		}
		
		$db->setQuery($query);
		$count = $db->loadResult();
		if($count > 0){
			$this->setError("：同小组标签名称存在重复记录!");
			return false;
		}

		$save_array['name'] = $name;
		$save_array['intime'] = time();
		$save_array['gid'] = $gid;
		if($id != 0){
			$save_array['id'] = $id;
		}

		if($id > 0){
			$query = "select gid from #__group_tag where id = ".$id;
			$db->setQuery($query);
			$o_gid = $db->loadResult();
		}else{
			$o_gid = $gid;
		}

		if (parent::save($save_array)) {
			$this->updateJson($db, $mp, $gid, $o_gid);
			return true;
		}else{
			return false;
		}
	}

	//更新json文件
	private function updateJson($db, $mp, $gid, $o_gid){
		//小组标签
		$query = "select * from #__group_tag where gid = ".$gid;
		$db->setQuery($query);
		$tag_list = $db->loadObjectList();
		
		$group_item_path = $mp->getJsonPath(3).$gid;
		file_put_contents($group_item_path.'/tag', json_encode($tag_list));

		if($gid != $o_gid){
			$query = "select * from #__group_tag where gid = ".$o_gid;
			$db->setQuery($query);
			$tag_list = $db->loadObjectList();
			
			$group_item_path = $mp->getJsonPath(3).$o_gid;
			file_put_contents($group_item_path.'/tag', json_encode($tag_list));
		}
	}

	public function delete(&$data){
		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		$db = JFactory::getDBO();
		for($i = 0; $i < count($data); $i++){
			$id = $data[$i];

			$query = "select count(*) from #__group_tag where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}

			$query = "select gid from #__group_tag where id = ".$id;
			$db->setQuery($query);
			$gid = $db->loadResult();
			
			$table = $this->getTable();
			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}

			$this->updateJson($db, $mp, $gid, $gid);
		}
		
		return true;
	}
}



