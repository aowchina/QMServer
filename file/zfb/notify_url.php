<?php
/* *
 * 功能：支付宝服务器异步通知页面
 * 版本：3.3
 * 日期：2012-07-23
 * 说明：
 * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 * 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。


 *************************页面功能说明*************************
 * 创建该页面文件时，请留心该页面文件中无任何HTML代码及空格。
 * 该页面不能在本机电脑测试，请到服务器上做测试。请确保外部可以访问该页面。
 * 该页面调试工具请使用写文本函数logResult，该函数已被默认关闭，见alipay_notify_class.php中的函数verifyNotify
 * 如果没有收到该页面返回的 success 信息，支付宝会在24小时内按一定的时间策略重发通知
 */

require_once("alipay.config.php");
require_once("lib/alipay_notify.class.php");
require_once("../functions_mdb.php");

//计算得出通知验证结果
$alipayNotify = new AlipayNotify($alipay_config);
$verify_result = $alipayNotify->verifyNotify();

if($verify_result) {//验证成功	
    //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表

	//商户订单号
	$out_trade_no = $_POST['out_trade_no'];

	//支付宝交易号
	$trade_no = $_POST['trade_no'];

	//交易状态
	$trade_status = $_POST['trade_status'];

    if($_POST['trade_status'] == 'TRADE_FINISHED') {
        //file_put_contents("/data/savedata/data_minfo/save_file/quanmei/dblock/2", " ");
		//判断该笔订单是否在商户网站中已经做过处理
    	//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
		//如果有做过处理，不执行商户的业务程序

        //连接db
        $con = conDb();
        if($con == ''){
            echo "fail";
            exit;
        }

        if(preg_match("/^(quanmei_course)[0-9]{14}$/", $out_trade_no)){
            $count = dbCount("qm_course_order", $con, "orderid = '".$out_trade_no."' and status = 0");
            if($count == 1){
                $data['status'] = 1;
                $data['intime'] = time();
                $data['out_num'] = $trade_no;

                if(dbUpdate($data, "qm_course_order", $con, "orderid = '".$out_trade_no."'")){

                    $sql = "select a.userid,b.price from qm_course_order as a,qm_course as b where a.orderid = '".$out_trade_no."' and a.courseid = b.id";
                    $order_info = dbLoad(dbQuery($sql, $con), true);

                    $data = array();
                    $data['userid'] = $order_info['userid'];
                    $data['order_num'] = $out_trade_no;
                    $data['order_fee'] = $order_info['price'];

                    $sql = "select * from qm_point_rule";
                    $rule_info = dbLoad(dbQuery($sql, $con), true);
                    if(isset($rule_info['xf_point'])){
                        $xf_point = number_format($order_info['price'] * $rule_info['xf_point'], 2);
                    }else{
                        $xf_point = 0;
                    }
                    $data['point'] = $xf_point;
                    $data['type'] = 2;
                    $data['status'] = 1;
                    $data['ctime'] = $data['intime'] = time();
                    dbAdd($data, 'qm_point_record', $con);

                    closeDb($con);
                    echo "success";
                    exit;
                }else{
                    closeDb($con);
                    echo "fail";
                    exit;
                }
            }
        }else{
            $count = dbCount("qm_yuyue", $con, "orderid = '".$out_trade_no."'");
            if($count > 0){
                $data['status'] = 2;
                $data['intime'] = time();
                if(dbUpdate($data, "qm_yuyue", $con, "orderid = '".$out_trade_no."'")){
                    $data_n['trade_no'] = $trade_no;
                    $data_n['out_trade_no'] = $out_trade_no;
                    $data_n['status'] = 1;
                    $data_n['intime'] = time();

                    dbAdd($data_n, "qm_zf_record", $con);

                    $sql = "select a.userid,b.newval from qm_yuyue as a,qm_tehui as b where a.orderid = '".$out_trade_no."' and a.tid = b.id";
                    $order_info = dbLoad(dbQuery($sql, $con), true);

                    $data = array();
                    $data['userid'] = $order_info['userid'];
                    $data['order_num'] = $out_trade_no;
                    $data['order_fee'] = $order_info['newval'];

                    $sql = "select * from qm_point_rule";
                    $rule_info = dbLoad(dbQuery($sql, $con), true);
                    if(isset($rule_info['xf_point'])){
                        $xf_point = number_format($order_info['newval'] * $rule_info['xf_point'], 2);
                    }else{
                        $xf_point = 0;
                    }
                    $data['point'] = $xf_point;
                    $data['type'] = 2;
                    $data['status'] = 1;
                    $data['ctime'] = $data['intime'] = time();
                    dbAdd($data, 'qm_point_record', $con);

                    closeDb($con);
                    echo "success";
                    exit;
                }else{
                    closeDb($con);
                    echo "fail";
                    exit;
                }
            }
            else{
                closeDb($con);
                echo "fail";
                exit;
            }
        }
		
		//注意：
		//退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
		//请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的

        //调试用，写文本函数记录程序运行情况是否正常
        //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
    }
    else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
        //file_put_contents("/data/savedata/data_minfo/save_file/quanmei/dblock/1", " ");
        
        //连接db
        $con = conDb();
        if($con == ''){
            echo "fail";
            exit;
        }

        if(preg_match("/^(quanmei_course)[0-9]{14}$/", $out_trade_no)){
            $count = dbCount("qm_course_order", $con, "orderid = '".$out_trade_no."' and status = 0");
            if($count == 1){
                $data['status'] = 1;
                $data['intime'] = time();
                $data['out_num'] = $trade_no;

                if(dbUpdate($data, "qm_course_order", $con, "orderid = '".$out_trade_no."'")){

                    $sql = "select a.userid,b.price from qm_course_order as a,qm_course as b where a.orderid = '".$out_trade_no."' and a.courseid = b.id";
                    $order_info = dbLoad(dbQuery($sql, $con), true);

                    $data = array();
                    $data['userid'] = $order_info['userid'];
                    $data['order_num'] = $out_trade_no;
                    $data['order_fee'] = $order_info['price'];

                    $sql = "select * from qm_point_rule";
                    $rule_info = dbLoad(dbQuery($sql, $con), true);
                    if(isset($rule_info['xf_point'])){
                        $xf_point = number_format($order_info['price'] * $rule_info['xf_point'], 2);
                    }else{
                        $xf_point = 0;
                    }
                    $data['point'] = $xf_point;
                    $data['type'] = 2;
                    $data['status'] = 1;
                    $data['ctime'] = $data['intime'] = time();
                    dbAdd($data, 'qm_point_record', $con);

                    closeDb($con);
                    echo "success";
                    exit;
                }else{
                    closeDb($con);
                    echo "fail";
                    exit;
                }
            }else{
                closeDb($con);
                echo "fail";
                exit;
            }
        }else{
            $count = dbCount("qm_yuyue", $con, "orderid = '".$out_trade_no."'");
            if($count > 0){
                $data['status'] = 2;
                $data['intime'] = time();
                if(dbUpdate($data, "qm_yuyue", $con, "orderid = '".$out_trade_no."'")){
                    $data_n['trade_no'] = $trade_no;
                    $data_n['out_trade_no'] = $out_trade_no;
                    $data_n['status'] = 1;
                    $data_n['intime'] = time();

                    dbAdd($data_n, "qm_zf_record", $con);

                    $sql = "select a.userid,b.newval from qm_yuyue as a,qm_tehui as b where a.orderid = '".$out_trade_no."' and a.tid = b.id";
                    $order_info = dbLoad(dbQuery($sql, $con), true);

                    $data = array();
                    $data['userid'] = $order_info['userid'];
                    $data['order_num'] = $out_trade_no;
                    $data['order_fee'] = $order_info['newval'];

                    $sql = "select * from qm_point_rule";
                    $rule_info = dbLoad(dbQuery($sql, $con), true);
                    if(isset($rule_info['xf_point'])){
                        $xf_point = number_format($order_info['newval'] * $rule_info['xf_point'], 2);
                    }else{
                        $xf_point = 0;
                    }
                    $data['point'] = $xf_point;
                    $data['type'] = 2;
                    $data['status'] = 1;
                    $data['ctime'] = $data['intime'] = time();
                    dbAdd($data, 'qm_point_record', $con);
                    
                    closeDb($con);
                    echo "success";
                    exit;
                }else{
                    closeDb($con);
                    echo "fail";
                    exit;
                }
            }
            else{
                closeDb($con);
                echo "fail";
                exit;
            }
        }
		//注意：
		//付款完成后，支付宝系统发送该交易状态通知
		//请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的

        //调试用，写文本函数记录程序运行情况是否正常
        //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
    }
        
	echo "success";		//请不要修改或删除
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
else {
    //验证失败
    echo "fail";

    //调试用，写文本函数记录程序运行情况是否正常
    //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
}
?>