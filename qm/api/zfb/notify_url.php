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

    //收到的钱
    $total_fee = $_POST['total_fee'];

    if($_POST['trade_status'] == 'TRADE_FINISHED') {
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
            }else{
                closeDb($con);
                echo "fail";
                exit;
            }
        }else{
            $true_orderid = substr($out_trade_no, 0, strlen($out_trade_no) - 2);
            $order_type = substr($out_trade_no, -2);

            $condition = "orderid = '".$true_orderid."'";
            $count = dbCount("qm_yuyue", $con, $condition);

            if($count > 0){
                //验证收款是否正确
                $sql = "select * from qm_yuyue where $condition";
                $oinfo = dbLoad(dbQuery($sql, $con), true);

                $dj_money = $oinfo['dj_real_money'];
                $wk_money = $oinfo['wk_real_money'];

                if($order_type == 'dj'){
                    $need_money = $dj_money;
                    $data['status'] = 2;
                    $data['dj_dsf_orderid'] = $trade_no;
                    $data['dj_dsf_type'] = 1;
                }
                elseif($order_type == 'wk'){
                    $need_money = $wk_money;
                    $data['status'] = 5;
                    $data['wk_dsf_orderid'] = $trade_no;
                    $data['wk_dsf_type'] = 1;
                    $data['wk_type'] = 2;

                    $sql = "select * from qm_point_rule";
                    $re = dbLoad(dbQuery($sql, $con), true);
                    $data['get_point'] = round($re['xf_point'] * ($need_money + $dj_money), 2);
                }
                else{
                    $need_money = $dj_money + $wk_money;
                    $data['status'] = 5;
                    $data['wk_dsf_orderid'] = $trade_no;
                    $data['wk_dsf_type'] = 1;
                    $data['wk_type'] = 2;

                    $sql = "select * from qm_point_rule";
                    $re = dbLoad(dbQuery($sql, $con), true);
                    $data['get_point'] = round($re['xf_point'] * $need_money, 2);
                }

                if($need_money != $total_fee){
                    closeDb($con);
                    echo "fail";
                }

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
            $true_orderid = substr($out_trade_no, 0, strlen($out_trade_no) - 2);
            $order_type = substr($out_trade_no, -2);

            $condition = "orderid = '".$true_orderid."'";
            $count = dbCount("qm_yuyue", $con, $condition);

            if($count > 0){
                //验证收款是否正确
                $sql = "select * from qm_yuyue where $condition";
                $oinfo = dbLoad(dbQuery($sql, $con), true);

                $dj_money = $oinfo['dj_real_money'];
                $wk_money = $oinfo['wk_real_money'];

                if($order_type == 'dj'){
                    $need_money = $dj_money;
                    $data['status'] = 2;
                    $data['dj_dsf_orderid'] = $trade_no;
                    $data['dj_dsf_type'] = 1;
                }
                elseif($order_type == 'wk'){
                    $need_money = $wk_money;
                    $data['status'] = 5;
                    $data['wk_dsf_orderid'] = $trade_no;
                    $data['wk_dsf_type'] = 1;
                    $data['wk_type'] = 2;

                    $sql = "select * from qm_point_rule";
                    $re = dbLoad(dbQuery($sql, $con), true);
                    $data['get_point'] = round($re['xf_point'] * ($need_money + $dj_money), 2);
                }
                else{
                    $need_money = $dj_money + $wk_money;
                    $data['status'] = 5;
                    $data['wk_dsf_orderid'] = $trade_no;
                    $data['wk_dsf_type'] = 1;
                    $data['wk_type'] = 2;

                    $sql = "select * from qm_point_rule";
                    $re = dbLoad(dbQuery($sql, $con), true);
                    $data['get_point'] = round($re['xf_point'] * $need_money, 2);
                }

                if($need_money != $total_fee){
                    closeDb($con);
                    echo "fail";
                }

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