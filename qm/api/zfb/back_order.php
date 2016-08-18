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

    //批量退款数据中的详细信息
    $result_details = $_POST['result_details'];

    $order_list = explode('^', $result_details);
    $dsf_orderid = $order_list[0];

    $con = conDb();
    if($con == ''){
        echo "fail";
        exit;
    }

    $condition = "wk_dsf_orderid = '$dsf_orderid' and status = 7 and wk_dsf_type = 1";
    $count = dbCount('qm_yuyue', $con, $condition);
    if($count == 1){
        $sql = "select * from qm_yuyue where $condition";
        $oinfo = dbLoad(dbQuery($sql, $con), true);

        $back_money = $oinfo['wk_real_money'];        //实付尾款
        if($back_money != $order_list[1]){
            closeDb($con);
            echo "fail";
            exit;
        }

        $data['status'] = 8;
        $data['wk_type'] = 0;
        $data['wk_point_money'] = 0;
        $data['wk_hf_point'] = 0;
        $data['get_point'] = 0;

        if(!dbUpdate($data, "qm_yuyue", $con, $condition)){
            closeDb($con);
            echo "fail";
            exit;
        }

        if($oinfo['wk_hf_point'] > 0){
            $data = array();
            $data['point'] = $oinfo['wk_hf_point'];
            $data['userid'] = $oinfo['userid'];
            $data['order_num'] = $oinfo['orderid'];
            $data['status'] = 1;
            $data['type'] = 2;
            $data['ctime'] = $data['ctime'] = time();

            dbAdd($data, 'qm_point_record', $con);
        }

        closeDb($con);
        echo "success"; 
    }
    else{
        $condition = "dj_dsf_orderid = '$dsf_orderid' and status = 8 and dj_dsf_type = 1";
        $count = dbCount('qm_yuyue', $con, $condition);
        if($count == 1){
            $sql = "select * from qm_yuyue where $condition";
            $oinfo = dbLoad(dbQuery($sql, $con), true);

            $back_money = $oinfo['dj_real_money'];        //实付款
            if($back_money != $order_list[1]){
                closeDb($con);
                echo "fail";
                exit;
            }

            $data['status'] = 9;
            $data['dj_point_money'] = 0;
            $data['dj_real_money'] = 0;
            $data['dj_hf_point'] = 0;

            if(!dbUpdate($data, "qm_yuyue", $con, $condition)){
                closeDb($con);
                echo "fail";
                exit;
            }

            if($oinfo['dj_hf_point'] > 0){
                $data = array();
                $data['point'] = $oinfo['dj_hf_point'];
                $data['userid'] = $oinfo['userid'];
                $data['order_num'] = $oinfo['orderid'];
                $data['status'] = 1;
                $data['type'] = 2;
                $data['ctime'] = $data['ctime'] = time();

                dbAdd($data, 'qm_point_record', $con);
            }

            closeDb($con);
            echo "success"; 
        }
        else{
            closeDb($con);
            echo "fail";
            exit;
        }
    }
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
else {
    //验证失败
    echo "fail";
    //调试用，写文本函数记录程序运行情况是否正常
    //logResult("这里写入想要调试的代码变量值，或其他运行的结果记录");
}
?>