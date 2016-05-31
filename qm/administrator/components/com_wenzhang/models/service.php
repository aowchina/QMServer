<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class WenzhangModelWenzhang extends JModelAdmin{
	protected $text_prefix = 'COM_WENZHANG';

	public function getTable($type = 'Wenzhang', $prefix = 'WenzhangTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_wenzhang.wenzhang', 'wenzhang', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_wenzhang.edit.wenzhang.data', array());

		if(empty($data)){
			$data = $this->getItem();

			$db = JFactory::getDbo();
			$sql = "select username from #__users_common where userid = ".$data->userid;
			$db->setQuery($sql);
			$uinfo = $db->loadResult();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;
			$data->username = $mp->getStrFromByte($uinfo);

			$ctime = $data->ctime;
			$filepath = JPATH_ROOT.'/files/wenzhang/'.date("Y", $ctime).'/'.date("m", $ctime).'/'.date("d", $ctime).'/'.$ctime;

			if(is_file($filepath.'/text')){
				$data->text = file_get_contents($filepath."/text");
			}else{
				$data->text = "";
			}
		}
		return $data;
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

			$query = "select count(*) from #__wenzhang where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}
			
			$table = $this->getTable();
			$query = "select ctime from #__wenzhang where id = ".$id;
			$db->setQuery($query);
			$ctime = $db->loadResult();

			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}

			$filepath = JPATH_ROOT.'/files/wenzhang/'.date("Y", $ctime).'/'.
				date("m", $ctime).'/'.date("d", $ctime).'/'.$ctime;

			$mp->delDirFile($filepath);
			$mp->delPath($filepath, 4);

			$sql = "select id,intime from #__wenzhang_pl where wid = ".$id;
			$db->setQuery($sql);
			$zan_list = $db->loadObjectList();
			for($j = 0; $j < count($zan_list); $j++){
				$intime = $zan_list[$i]['intime'];
				$filepath = $mp->getJsonPath.date("Y", $intime).'/'.
					date("m", $intime).'/'.date("d", $intime).'/'.$intime;
				$mp->delDirFile($filepath);
				$mp->delPath($filepath, 4);

				$sql = "delete from #__zan where zanid = ".$zan_list[$i]['id']." and type = 2";
				$db->setQuery($sql);
				$db->query();
			}
			$sql = "delete from #__wenzhang_pl where wid = ".$id;
			$db->setQuery($sql);
			$db->query();

			$sql = "delete from #__zan where type = 1 and zanid = ".$id;
			$db->setQuery($sql);
			$db->query();
		}
		
		return true;
	}
}
