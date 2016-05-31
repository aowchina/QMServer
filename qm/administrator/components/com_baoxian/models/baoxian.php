<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class BaoxianModelBaoxian extends JModelAdmin{
	protected $text_prefix = 'COM_BAOXIAN';

	public function getTable($type = 'Baoxian', $prefix = 'BaoxianTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_baoxian.baoxian', 'baoxian', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_baoxian.edit.baoxian.data', array());

		if(empty($data)){
			$data = $this->getItem();
		}
		return $data;
	}

	//保存
	public function save($data){
		$id = trim($data['id']);
		$title = trim($data['title']);
		$img = trim($data['img']);
		$intro = trim($data['intro']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		if(empty($title)){
			$this->setError("：请填写标题!");
			return false;
		}
		if(!$mp->isName($title, 9)){
			$this->setError("：标题不符合格式!");
			return false;
		}

		if(!$mp->isImg($img)){
			$this->setError("：宣传图名或类型不符合要求!");
			return false;
		}
		if(strpos($simg, 'http') !== false){
			$this->setError("：图片请上传，暂不支持网络图片!");
			return false;
		}

		$db = JFactory::getDBO();

		$save_array['title'] = $title;
		$save_array['img'] = $img;
		$save_array['intro'] = $intro;
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
		$query = "select * from #__baoxian order by intime desc";
		$db->setQuery($query);
		$t_list = $db->loadObjectList();

		file_put_contents($mp->getJsonPath(10).'list', json_encode($t_list));
	}
}
