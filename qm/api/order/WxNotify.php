<?php
/** 
 * 更新支付结果
 * 参数：8段 * userid * 订单号
 */
require_once("../functions_mdb.php");

$postStr = $GLOBALS["HTTP_RAW_POST_DATA"];

if($postStr){
	$xml_array = simplexml_load_string($postStr, null, LIBXML_NOCDATA);

	if($xml_array->return_code == "SUCCESS"){
		
	    if($xml_array->result_code == "SUCCESS"){

	    	if($xml_array->appid == 'wx719c1e4eebfb3fb7' && $xml_array->mch_id == '1311715801'){
	    		
	    		$orderid = $xml_array->out_trade_no;
	    		$true_orderid = substr($orderid, 0, strlen($orderid) - 2);
	    		$order_type = substr($orderid, -2);
	    		$wx_orderid = $xml_array->transaction_id;

	    		//查询订单
	    		$con = conDb();
	    		if($con){
	    			
	    			//订单号存在，且金额相同，且未支付
	    			$wx_fee = $xml_array->total_fee / 100;

	    			$condition = "orderid = '$true_orderid'";
	    			$count = dbCount('qm_yuyue', $con, $condition);

	    			if($count == 1){
	    				
	    				//验证收款是否正确
		                $sql = "select * from qm_yuyue where $condition";
		                $oinfo = dbLoad(dbQuery($sql, $con), true);

		                $dj_money = $oinfo['dj_real_money'];        //实付定金
		                $wk_money = $oinfo['wk_real_money'];        //实付尾款

		                if($order_type == 'dj'){
		                	$need_money = $dj_money;

		                	$data['dj_dsf_orderid'] = $wx_orderid;
			                $data['dj_dsf_type'] = 2;
			                $data['status'] = 2;
		                }
		                elseif($order_type == 'qk'){
		                	$need_money = $wk_money;

		                	$data['wk_dsf_orderid'] = $wx_orderid;
			                $data['wk_dsf_type'] = 2;
		                	$data['status'] = 5;
		                	$data['wk_type'] = 2;

		                	$sql = "select * from qm_point_rule";
		                    $re = dbLoad(dbQuery($sql, $con), true);
		                    $data['get_point'] = round($re['xf_point'] * $need_money, 2);
		                }
		                else{
		                	$need_money = $wk_money;

		                	$data['wk_dsf_orderid'] = $wx_orderid;
			                $data['wk_dsf_type'] = 2;
		                	$data['status'] = 5;
		                	$data['wk_type'] = 2;

		                	$sql = "select * from qm_point_rule";
		                    $re = dbLoad(dbQuery($sql, $con), true);
		                    $data['get_point'] = round($re['xf_point'] * ($need_money + $dj_money), 2);
		                }

		                if($need_money == $wx_fee){
			                $data['intime'] = time();

			                if(dbUpdate($data, "qm_yuyue", $con, "orderid = '".$true_orderid."'")){
			                	//扣除积分
			                    $hf_point = $oinfo['hf_point'];

			                    //扣除积分
			                    $data = array();
			                    $data['point'] = $hf_point;
			                    $data['type'] = 2;
			                    $data['status'] = 2;
			                    $data['order_num'] = $true_orderid;
			                    $data['userid'] = $oinfo['userid'];
			                    $data['ctime'] = $data['intime'] = time();
			                    dbAdd($data, 'qm_point_record', $con);

			                    closeDb($con);
				                $return_xml = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
								echo $return_xml;
								exit;
			                }
		                }
	    			}
	    		}

	    		closeDb($con);
	    	}
	    }
	}
}

$return_xml = "<xml><return_code><![CDATA[FAIL]]></return_code><return_msg><![CDATA[]]></return_msg></xml>";

echo $return_xml;
exit;

?>