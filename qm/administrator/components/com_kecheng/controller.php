<?php
defined('_JEXEC') or die;

class KechengController extends JControllerLegacy{
	protected $default_view = 'kechengs';

	public function display($cachable = false, $urlparams = false){
		require_once JPATH_COMPONENT.'/helpers/kecheng.php';
		KechengHelper::addSubmenu(JRequest::getCmd('view'));

		$view = JRequest::getCmd('view', 'kechengs');
		$layout = JRequest::getCmd('layout', 'default');
		$id = JRequest::getCmd('id');

		parent::display();
		
		return $this;
	}
}
?>