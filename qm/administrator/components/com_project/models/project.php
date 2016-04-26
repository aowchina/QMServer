<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class ProjectModelProject extends JModelAdmin{
	protected $text_prefix = 'COM_PROJECT';

	public function getTable($type = 'Project', $prefix = 'ProjectTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_project.project', 'project', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_project.edit.project.data', array());

		if(empty($data)){
			$data = $this->getItem();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;

			$item_path = $mp->getJsonPath(2).'item/'.$data->id."/baseinfo";
			$item_info = json_decode(file_get_contents($item_path), true);

			$data->jj = $item_info['jj'];
			$data->yd = $item_info['yd'];
			$data->qd = $item_info['qd'];
			$data->fxts = $item_info['fxts'];
			$data->syrq = $item_info['syrq'];
			$data->jjrq = $item_info['jjrq'];
			$data->zysx = $item_info['zysx'];
		}

		return $data;
	}

	//保存or修改
	public function save($data){
		$id = trim($data['id']);
		$ptid = intval(trim($data['ptid']));

		$name = trim($data['name']);
		$jgfw = trim($data['jgfw']);
		$fxzs = intval(trim($data['fxzs']));
		$cxsj = trim($data['cxsj']);
		$cxsj2 = trim($data['cxsj2']);
		$zlsc = trim($data['zlsc']);
		$zlcs = trim($data['zlcs']);
		$mzff = trim($data['mzff']);
		$sfzy = intval(trim($data['sfzy']));
		$hfsj = trim($data['hfsj']);

		$yd = trim($data['yd']);
		$qd = trim($data['qd']);
		$zysx = trim($data['zysx']);
		$syrq = trim($data['syrq']);
		$jjrq = trim($data['jjrq']);
		$jj = trim($data['jj']);
		$fxts = trim($data['fxts']);

		include_once(JPATH_ROOT.'/Utils.php');
		$mp = new Utils;

		if($ptid == 0){
			$this->setError("：请选择所属类别，若无类别，请先添加类别!");
			return false;
		}

		//验名称
		if(empty($name)){
			$this->setError("：请填写项目名称!");
			return false;
		}
		if(!$mp->isName($name, 6)){
			$this->setError("：名称不符合格式!");
			return false;
		}

		//价格范围
		if(empty($jgfw)){
			$this->setError("：请填写价格范围!");
			return false;
		}
		if(!$mp->isName($jgfw, 7)){
			$this->setError("：价格范围不符合格式!");
			return false;
		}

		//持续时间
		if(empty($cxsj)){
			$this->setError("：请填写持续时间!");
			return false;
		}
		if(!$mp->isName($cxsj, 8)){
			$this->setError("：持续时间不符合格式!");
			return false;
		}

		//拆线时间
		if(empty($cxsj2)){
			$this->setError("：请填写拆线时间!");
			return false;
		}
		if(!$mp->isName($cxsj2, 8)){
			$this->setError("：拆线时间不符合格式!");
			return false;
		}

		//治疗时长
		if(empty($zlsc)){
			$this->setError("：请填写治疗时长!");
			return false;
		}
		if(!$mp->isName($zlsc, 8)){
			$this->setError("：治疗时长不符合格式!");
			return false;
		}

		//治疗次数
		if(empty($zlcs)){
			$this->setError("：请填写治疗次数!");
			return false;
		}
		if(!$mp->isName($zlcs, 8)){
			$this->setError("：治疗次数不符合格式!");
			return false;
		}

		//麻醉方法
		if(empty($mzff)){
			$this->setError("：请填写麻醉方法!");
			return false;
		}
		if(!$mp->isName($mzff, 8)){
			$this->setError("：麻醉方法不符合格式!");
			return false;
		}

		//恢复时间
		if(empty($hfsj)){
			$this->setError("：请填写恢复时间!");
			return false;
		}
		if(!$mp->isName($hfsj, 8)){
			$this->setError("：恢复时间不符合格式!");
			return false;
		}
	
		$db = JFactory::getDBO();

		if($id > 0){
			$query = "select count(*) from #__project where name = '".$name."' and id <> ".$id;
		}else{
			$query = "select count(*) from #__project where name = '".$name."'";
		}
		$db->setQuery($query);
		$count = $db->loadResult();
		if($count > 0){
			$this->setError("：名称存在重复记录!");
			return false;
		}

		$s_data['id'] = $id;
		$s_data['ptid'] = $ptid;
		$s_data['name'] = $name;
		$s_data['jgfw'] = $jgfw;
		$s_data['fxzs'] = $fxzs;
		$s_data['cxsj'] = $cxsj;
		$s_data['cxsj2'] = $cxsj2;
		$s_data['zlsc'] = $zlsc;
		$s_data['zlcs'] = $zlcs;
		$s_data['mzff'] = $mzff;
		$s_data['sfzy'] = $sfzy;
		$s_data['hfsj'] = $hfsj;
		$s_data['intime'] = time();
		if($id > 0){
			$s_data['id'] = $id;
		}

		if(parent::save($s_data)){
			if($id == 0){
				$query = "select id from #__project where intime = ".$s_data['intime'];
				$db->setQuery($query);
				$id = $db->loadResult();
				$data['id'] = $id;
				$data['intime'] = $s_data['intime'];
			}

			$item_path = $mp->getJsonPath(2).'item/'.$id;
			$mp->mkdirs($item_path);
			file_put_contents($item_path.'/baseinfo', json_encode($data));

			$this->updateJson($db, $mp);
			return true;
		}else{
			return false;
		}
	}

	//更新项目Json文件
	private function updateJson($db, $mp){
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

	//实现批量导入
	public function batch($commands, $pks, $contexts){
		if($commands['group_action'] == 'add'){
			$tag = 1;  //添加
		}else{ 
			$tag = 2;  //删除
		}

		$gid = intval($commands['group_id']);
		if($gid <= 0){
			$this->setError("：请选择关联小组!");
			return false;
		}

		if(count($pks) <= 0){
			$this->setError("：请选择项目!");
			return false;
		}

		$sql_array = array();
		$db = JFactory::getDBO();

		for($i = 0; $i < count($pks); $i++){
			$pid = intval($pks[$i]);

			//查询是否存在
			$query = "select count(*) from #__project where id = ".$pid;
			$db->setQuery($query);
			$count = $db->loadResult();

			if($count == 1){
				$query = "select count(*) from #__relation_pg where pid = ".$pid." and gid = ".$gid;
				$db->setQuery($query);
				$count2 = $db->loadResult();

				if($tag == 1){
					if($count2 == 0){
						$sql_array[] = "insert into #__relation_pg (pid,gid,intime) values (".$pid.",".$gid.",".time().")";
					}
				}else{
					if($count2 == 1){
						$sql_array[] = "delete from #__relation_pg where pid = ".$pid." and gid = ".$gid;
					}else{
						$this->setError("：第".($i+1)."个项目数据异常!");
						return false;
					}
				}
			}else{
				$this->setError("：第".($i+1)."个项目数据异常，请刷新页面重新操作!");
				return false;
			}
		}

		for($i = 0; $i < count($sql_array); $i++){
			$query = $sql_array[$i];
			$db->setQuery($query);
			$db->query();
		}

		return true;
	}
}
