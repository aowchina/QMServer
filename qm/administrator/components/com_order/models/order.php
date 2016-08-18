<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class OrderModelOrder extends JModelAdmin{
	protected $text_prefix = 'COM_ORDER';

	public function getTable($type = 'Order', $prefix = 'OrderTable', $config = array()){
		return JTable::getInstance($type, $prefix, $config);
	}

	public function getForm($data = array(), $loadData = true){
		$app = JFactory::getApplication();
		$form = $this->loadForm('com_order.order', 'order', array('control'=>'jform', 'load_data'=>$loadData));

		if(empty($form)){
			return false;
		}

		return $form;
	}

	protected function loadFormData(){
		$data = JFactory::getApplication()->getUserState('com_order.edit.order.data', array());

		if(empty($data)){
			$data = $this->getItem();

			$db = JFactory::getDbo();
			$sql = "select tel,username from #__users_common where userid = ".$data->userid;
			$db->setQuery($sql);
			$uinfo = $db->loadObject();

			include_once(JPATH_ROOT.'/Utils.php');
			$mp = new Utils;
			$data->username = $mp->getStrFromByte($uinfo->username);
			$data->tel = $uinfo->tel;

			$sql = "select name,hid from #__tehui where id = ".$data->tid;
			$db->setQuery($sql);
			$tinfo = $db->loadObject();

			$data->tname = $tinfo->name;

			$sql = "select name from #__hospital where id = ".$tinfo->hid;
			$db->setQuery($sql);
			$hinfo = $db->loadObject();
			$data->hospital = $hinfo->name;

			$detail_img = $data->detail_img;
			if($detail_img){
				$img_list = json_decode($detail_img, true);

				$str = '';
				foreach($img_list as $img_item){
					$str .= '<span style="display:inline-block;width:30%"><img src="http://'.
						$_SERVER['HTTP_HOST'].'/qm/'.$img_item.'" width="100%"/></span>';
				}
				$data->detail_img = $str;
			}
			else{
				$data->detail_img = '暂未上传';
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

			$query = "select count(*) from #__yuyue where id = ".$id;
			$db->setQuery($query);
			$result = $db->loadResult();

			if($result != 1){
				$this->setError("：记录不存在或已被删除!");
				return false;
			}
			
			$table = $this->getTable();
			$query = "select status from #__yuyue where id = ".$id;
			$db->setQuery($query);
			$status = $db->loadResult();

			if($status != 1){
				$this->setError("：您不能删除已预约的订单!");
				return false;
			}

			if(!$table->delete($id)){
				$this->setError("：删除失败，请重新操作!");
				return false;
			}
		}
		
		return true;
	}
}
