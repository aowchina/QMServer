<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class WenzhangControllerWenzhangs extends JControllerAdmin{

	public function getModel($name = 'Wenzhang', $prefix = 'WenzhangModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

	public function jing(){
		$ids = JRequest::getVar('cid', array(), '', 'array');

		if(count($ids) > 0){
			$db = JFactory::getDbo();
			foreach($ids as $id){
				$sql = "select count(*) from #__wenzhang where id = ".$id;
				$db->setQuery($sql);
				$count = $db->loadResult();

				if($count == 1){
					$sql = "select isjing from #__wenzhang where id = ".$id;
					$db->setQuery($sql);
					$isjing = $db->loadResult();

					if($isjing == 1){
						$isjing = 2;
					}else{
						$isjing = 1;
					}

					$sql = "update #__wenzhang set isjing = ".$isjing." where id = ".$id;
					$db->setQuery($sql);
					$db->query();
				}
			}
		}

		$this->setMessage(JText::_("操作成功!"));
		$this->setRedirect(JRoute::_('index.php?option=com_wenzhang&view=wenzhangs', false));
	}
}

