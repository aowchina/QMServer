<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class KechengModelKecheng extends JModelAdmin{
	protected $text_prefix = 'COM_KECHENG';

	public function getTable($type = 'Kecheng', $prefix = 'KechengTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_kecheng.kecheng', 'kecheng', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_kecheng.edit.kecheng.data', array());

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
		$banner = trim($data['banner']);
		$price = trim($data['price']);
		$intro = trim($data['intro']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		//验证医院名称
		if(empty($name)){
			$this->setError("：请填写名称!");
			return false;
		}
		if(!$mp->isName($name, 3)){
			$this->setError("：名称不符合格式!");
			return false;
		}

		if(empty($banner)){
			$this->setError("：请上传宣传图!");
			return false;
		}

		if(strpos($banner, 'http') !== false){
			$this->setError("：图片请上传，暂不支持网络图片!");
			return false;
		}

		if(!$mp->isImg($banner)){
			$this->setError("：图片名或类型不符合要求!");
			return false;
		}

		//验证简介
		if(empty($intro)){
			$this->setError("：请填写简介!");
			return false;
		}

		$db = JFactory::getDBO();

		//构建db插入数组
		$save_array['name'] = $name;
		$save_array['banner'] = $banner;
		$save_array['price'] = $price;
		$save_array['intro'] = $intro;
		$save_array['intime'] = time();
		if($id != 0){
			$save_array['id'] = $id;
		}

		if(parent::save($save_array)){
			if($id == 0){
				$query = "select id from #__course where intime = ".$save_array['intime'];
				$db->setQuery($query);
				$id = $db->loadResult();
			}

			//更新json文件
			$query = "select * from #__course where id = ".$id;
			$db->setQuery($query);
			$info = $db->loadObject();

			$item_path = $mp->getJsonPath(9);

			file_put_contents($item_path.'/'.$id, json_encode($info));
			
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

			$query = "select count(*) from #__course where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}

			$query = "select count(*) from #__teacher where courseid = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result > 0){
				$this->setError("：该课程已绑定教师，不能删除!");
				return false;
			}
			
			$table = $this->getTable();
			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}

			$item_path = $mp->getJsonPath(9);
			unlink($item_path.'/'.$id);
		}
		
		return true;
	}
}