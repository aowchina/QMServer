<?php

defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

//类别 组件名.Controller.View名
class OrderControllerOrders extends JControllerAdmin{

	public function getModel($name = 'Order', $prefix = 'OrderModel', $config = array('ignore_request'=>true)){
		$model = parent::getModel($name, $prefix, $config);
		return $model;
	}

	//退线上定金
	public function tdj_xs(){
		$id = $_GET['id'];

		$db = JFactory::getDBO();

		$sql = "select * from #__yuyue where id = ".$id;
		$db->setQuery($sql);
		$oinfo = $db->loadObject();

		if($oinfo->status != 8){
			JError::raiseWarning(500, JText::_("不能操作此订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		$back_money = $oinfo->dj_real_money;
		if($back_money > 0){

			if($oinfo->dj_dsf_type == 1){
				require_once("alipay.config.php");
				require_once("lib/alipay_submit.class.php");

				//构造要请求的参数数组，无需改动
				$parameter = array(
						"service" => trim($alipay_config['service']),
						"partner" => trim($alipay_config['partner']),
						"notify_url"	=> trim($alipay_config['notify_url']),
						"seller_user_id"	=> trim($alipay_config['seller_user_id']),
						"refund_date"	=> trim($alipay_config['refund_date']),
						"batch_no"	=> date("Ymd", time()).substr($oinfo->orderid.'dj', 7),
						"batch_num"	=> '1',
						"detail_data"	=> $oinfo->dj_dsf_orderid.'^'.$back_money.'^线上退款',
						"_input_charset"	=> trim(strtolower($alipay_config['input_charset']))
				);

				//建立请求
				$alipaySubmit = new AlipaySubmit($alipay_config);
				$html_text = $alipaySubmit->buildRequestForm($parameter,"get", "确认");
				echo $html_text;
				//$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
			}
			else{
				//拼接请求微信的数组
	            $now_time = time();

	            $req = array();
	            $req['appid'] = "wx719c1e4eebfb3fb7";
	            $req['mch_id'] = "1311715801";
	            $req['nonce_str'] = md5($now_time);    //随机字符串,32位
	            $req['op_user_id'] = "1311715801";
	            $req['out_refund_no'] = $now_time;
	            $req['refund_fee'] = $back_money * 100;
	            $req['total_fee'] = $back_money * 100;
	            $req['transaction_id'] = $oinfo->dj_dsf_orderid;
	            $req['sign'] = $this->getSign($req);

	            //拼接请求微信服务器的xml
	            $post_xml = $this->getXml($req);
	            $data = $this->curl_post_ssl('https://api.mch.weixin.qq.com/secapi/pay/refund', $post_xml, getcwd().'/cert/');

	            if(!$data){
	                JError::raiseWarning(500, JText::_("微信请求异常!"));
					$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
					return false;
	            }

	            $xml_array = simplexml_load_string($data, null, LIBXML_NOCDATA);

	            if($xml_array->return_code != "SUCCESS"){
	                JError::raiseWarning(500, JText::_("微信请求异常!"));
					$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
					return false;
	            }

	            if($xml_array->result_code != "SUCCESS"){
	                JError::raiseWarning(500, JText::_("微信请求异常!"));
					$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
					return false;
	            }

	            $sql = "update qm_yuyue set status = 9,dj_real_money = 0,dj_point_money = 0,
	            	dj_hf_point = 0 where orderid = '".$oinfo->orderid."'";
	            $db->setQuery($sql);
	            $db->query();

	            if($oinfo->dj_hf_point > 0){
					$now_time = time();
					$sql = "insert into qm_point_record (point,type,status,order_num,userid,ctime,intime) values 
						($oinfo->dj_hf_point,2,1,'$oinfo->orderid',$oinfo->userid,$now_time,$now_time)";
					$db->setQuery($sql);
		        	$db->query();
				}

				$this->setMessage(JText::_("操作成功!"));
				$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
			}
		}
		else{
			$sql = "update qm_yuyue set status = 9,dj_real_money = 0,dj_point_money = 0,
	            dj_hf_point = 0 where orderid = '".$oinfo->orderid."'";
            $db->setQuery($sql);
            $db->query();

			if($oinfo->dj_hf_point > 0){
				$now_time = time();
				$sql = "insert into qm_point_record (point,type,status,order_num,userid,ctime,intime) values 
					($oinfo->dj_hf_point,2,1,'$oinfo->orderid',$oinfo->userid,$now_time,$now_time)";
				$db->setQuery($sql);
	        	$db->query();
			}

			$this->setMessage(JText::_("操作成功!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
		}
	}

	//退线上尾款
	public function twk_xs(){
		$id = $_GET['id'];

		$db = JFactory::getDBO();

		$sql = "select * from #__yuyue where id = ".$id;
		$db->setQuery($sql);
		$oinfo = $db->loadObject();

		if($oinfo->status != 7){
			JError::raiseWarning(500, JText::_("不能操作此订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		if($oinfo->wk_type != 2){
			JError::raiseWarning(500, JText::_("不能操作此订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		$back_money = $oinfo->wk_real_money;
		if($back_money > 0){

			if($oinfo->wk_dsf_type == 1){
				require_once("alipay.config.php");
				require_once("lib/alipay_submit.class.php");

				//构造要请求的参数数组，无需改动
				$parameter = array(
						"service" => trim($alipay_config['service']),
						"partner" => trim($alipay_config['partner']),
						"notify_url"	=> trim($alipay_config['notify_url']),
						"seller_user_id"	=> trim($alipay_config['seller_user_id']),
						"refund_date"	=> trim($alipay_config['refund_date']),
						"batch_no"	=> date("Ymd", time()).substr($oinfo->orderid, 7),
						"batch_num"	=> '1',
						"detail_data"	=> $oinfo->wk_dsf_orderid.'^'.$back_money.'^线上退款',
						"_input_charset"	=> trim(strtolower($alipay_config['input_charset']))
				);

				//建立请求
				$alipaySubmit = new AlipaySubmit($alipay_config);
				$html_text = $alipaySubmit->buildRequestForm($parameter,"get", "确认");
				echo $html_text;
				//$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
			}
			else{
				//拼接请求微信的数组
	            $now_time = time();

	            $req = array();
	            $req['appid'] = "wx719c1e4eebfb3fb7";
	            $req['mch_id'] = "1311715801";
	            $req['nonce_str'] = md5($now_time);    //随机字符串,32位
	            $req['op_user_id'] = "1311715801";
	            $req['out_refund_no'] = $now_time;
	            $req['refund_fee'] = $back_money * 100;
	            $req['total_fee'] = $back_money * 100;
	            $req['transaction_id'] = $oinfo->wk_dsf_orderid;
	            $req['sign'] = $this->getSign($req);

	            //拼接请求微信服务器的xml
	            $post_xml = $this->getXml($req);
	            $data = $this->curl_post_ssl('https://api.mch.weixin.qq.com/secapi/pay/refund', $post_xml, getcwd().'/cert/');

	            if(!$data){
	                JError::raiseWarning(500, JText::_("微信请求异常!"));
					$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
					return false;
	            }

	            $xml_array = simplexml_load_string($data, null, LIBXML_NOCDATA);

	            if($xml_array->return_code != "SUCCESS"){
	                JError::raiseWarning(500, JText::_("微信请求异常!"));
					$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
					return false;
	            }

	            if($xml_array->result_code != "SUCCESS"){
	                JError::raiseWarning(500, JText::_("微信请求异常!"));
					$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
					return false;
	            }

	            $sql = "update qm_yuyue set status = 8,wk_real_money = 0,wk_type = 0,
	            	wk_hf_point = 0,wk_point_money = 0,get_point = 0 where orderid = '".$oinfo->orderid."'";
	            $db->setQuery($sql);
	            $db->query();

	            if($oinfo->wk_hf_point > 0){
					$now_time = time();
					$sql = "insert into qm_point_record (point,type,status,order_num,userid,ctime,intime) values 
						($oinfo->wk_hf_point,2,1,'$oinfo->orderid',$oinfo->userid,$now_time,$now_time)";
					$db->setQuery($sql);
		        	$db->query();
				}

				$this->setMessage(JText::_("操作成功!"));
				$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
			}
		}
		else{
			$sql = "update qm_yuyue set status = 8,wk_real_money = 0,wk_type = 0,
            	wk_hf_point = 0,wk_point_money = 0,get_point = 0 where orderid = '".$oinfo->orderid."'";
            $db->setQuery($sql);
            $db->query();
	            
			if($oinfo->wk_hf_point > 0){
				$now_time = time();
				$sql = "insert into qm_point_record (point,type,status,order_num,userid,ctime,intime) values 
					($oinfo->wk_hf_point,2,1,'$oinfo->orderid',$oinfo->userid,$now_time,$now_time)";
				$db->setQuery($sql);
	        	$db->query();
			}

			$this->setMessage(JText::_("操作成功!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
		}
	}

	//退线下尾款
	public function twk_xx(){
		$id = $_GET['id'];

		$db = JFactory::getDBO();

		$sql = "select * from #__yuyue where id = ".$id;
		$db->setQuery($sql);
		$oinfo = $db->loadObject();

		if($oinfo->status != 7){
			JError::raiseWarning(500, JText::_("不能操作此订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		if($oinfo->wk_type != 1){
			JError::raiseWarning(500, JText::_("不能操作此订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		//更新状态
		$sql = "update #__yuyue set status = 8, wk_real_money = 0, get_point = 0, wk_type = 0 where id = $id";
		$db->setQuery($sql);
		$db->query();

		$this->setMessage(JText::_("操作成功!"));
		$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
	}

	//更改状态为已付全款
	public function wk(){
		$id = $_GET['id'];

		$db = JFactory::getDBO();

		$sql = "select * from #__yuyue where id = ".$id;
		$db->setQuery($sql);
		$oinfo = $db->loadObject();

		if($oinfo->status != 2){
			JError::raiseWarning(500, JText::_("您只能操作已预订的订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		$money = $oinfo->dj_real_money + $oinfo->wk_money;

		$sql = "select xf_point from #__point_rule";
		$db->setQuery($sql);
		$xf_point = $db->loadResult();

		$get_point = round($xf_point * $money, 2);

		$sql = "update #__yuyue set status = 5,get_point = $get_point,wk_type = 1,wk_real_money = $oinfo->wk_money where id = ".$id;
		$db->setQuery($sql);
		$db->query();

		$this->setMessage(JText::_("操作成功!"));
		$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
	}

	//更改状态为完成
	public function wc(){
		$id = $_GET['id'];
		$db = JFactory::getDBO();
		
		$sql = "select * from #__yuyue where id = ".$id;
		$db->setQuery($sql);
		$oinfo = $db->loadObject();

		if($oinfo->status != 6){
			JError::raiseWarning(500, JText::_("您只能操作已传图的订单!"));
			$this->setRedirect(JRoute::_('index.php?option=com_order&view=order&layout=edit&id='.$id, false));
			return false;
		}

		$sql = "insert into #__point_record (userid,type,status,order_num,order_fee,point,ctime,intime) values(".
			$oinfo->userid.",2,1,'".$oinfo->orderid."',".($oinfo->dj_money+$oinfo->wk_money).",".$oinfo->get_point.",".time().",".time().")";
		$db->setQuery($sql);
		$db->query();

		$sql = "update #__yuyue set status = 3 where id = ".$id;
		$db->setQuery($sql);
		$db->query();

		$this->setMessage(JText::_("操作成功!"));
		$this->setRedirect(JRoute::_('index.php?option=com_order&view=orders', false));
	}

	private function getSign($reqArray){
	    $str = "";
	    $key_list = array_keys($reqArray);

	    for($i = 0; $i < count($reqArray); $i++){
	        $str = $str.$key_list[$i]."=".$reqArray[$key_list[$i]]."&";
	    }

	    $new_str = $str."key=qazwsxedcrfvtgbyhnujmikolp123456";
	    return strtoupper(md5($new_str));
	}

	//post提交
	private function file_get_contents_post($url, $post) {  
	    $options = array(  
	        'http' => array(  
	            'method' => 'POST',  
	            'content' => $post,  
	        ),  
	    );  
	  
	    $result = file_get_contents($url, false, stream_context_create($options));  
	  
	    return $result;  
	}

	private function getXml($reqArray){
	    $str = "<xml>";
	    $key_list = array_keys($reqArray);

	    for($i = 0; $i < count($reqArray); $i++){
	        $str = $str."<".$key_list[$i].">".$reqArray[$key_list[$i]]."</".$key_list[$i].">";
	    }

	    return $str."</xml>";
	}

	private function curl_post_ssl($url, $vars, $path, $second=30,$aHeader=array()){
	    $ch = curl_init();
	    curl_setopt($ch,CURLOPT_TIMEOUT,$second);
	    curl_setopt($ch,CURLOPT_RETURNTRANSFER, 1);
	    curl_setopt($ch,CURLOPT_URL,$url);
	    curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,false);
	    curl_setopt($ch,CURLOPT_SSL_VERIFYHOST,false);
	    curl_setopt($ch,CURLOPT_SSLCERT, $path.'apiclient_cert.pem');
	    curl_setopt($ch,CURLOPT_SSLKEY, $path.'apiclient_key.pem');
	    curl_setopt($ch,CURLOPT_CAINFO, $path.'rootca.pem');
	 
	    if( count($aHeader) >= 1 ){
	        curl_setopt($ch, CURLOPT_HTTPHEADER, $aHeader);
	    }
	 
	    curl_setopt($ch,CURLOPT_POST, 1);
	    curl_setopt($ch,CURLOPT_POSTFIELDS,$vars);
	    $data = curl_exec($ch);
	    if($data){
	        curl_close($ch);
	        return $data;
	    }
	    else {
	        curl_close($ch);
	        return false;
	    }
	}
}

