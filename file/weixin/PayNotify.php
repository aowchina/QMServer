<?php
/**
 * 确认订单
 * 接口参数: 8段 * userid * 订单号
 * author wangrui@min-fo.com
 * date 2015-05-01
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

$orderid = trim($reqlist[9]);
if(!(preg_match("/^(quanmei)[0-9]{14}$/", $orderid) || preg_match("/^(quanmei_course)[0-9]{14}$/", $orderid))){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}

$orderid = trim($reqlist[9]);

$req = array();
$req['appid'] = "wx719c1e4eebfb3fb7";
$req['mch_id'] = "1311715801";
$req['nonce_str'] = md5($now_time);    //随机字符串,32位
$req['out_trade_no'] = $orderid;
$req['sign'] = getSign($req);

//拼接请求微信服务器的xml
$post_xml = getXml($req);
$data = file_get_contents_post("https://api.mch.weixin.qq.com/pay/orderquery", $post_xml);

//解析微信返回的xml
if(!$data){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(15, $return_list);
}

$xml_array = simplexml_load_string($data, null, LIBXML_NOCDATA);
if($xml_array->return_code != "SUCCESS"){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(16, $return_list);
}

if($xml_array->result_code != "SUCCESS"){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(17, $return_list);
}

if($xml_array->trade_state != "SUCCESS"){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(18, $return_list);
}

$trade_no = $xml_array->transaction_id;

//连接db
$con = conDb();
if($con == ''){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(301, $return_list);
}

//查询我方订单记录
if(preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
    $o_type = 1;
}else{
    $o_type = 2;
}

if($o_type == 1){
    $count = dbCount("qm_yuyue", $con, 'userid = '.$userid." and orderid = '".$orderid."'");
}else{
    $count = dbCount("qm_course_order", $con, 'userid = '.$userid." and orderid = '".$orderid."'");
}

if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(19, $return_list);
}

if($o_type == 1){
    $sql = "select status from qm_yuyue where orderid = '".$orderid."'";
    $order_info = dbLoad(dbQuery($sql, $con), true);

    //查询我方订单状态
    if($order_info['status'] != 1){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(20, $return_list);
    }
}else{
    $sql = "select status from qm_course_order where orderid = '".$orderid."'";
    $order_info = dbLoad(dbQuery($sql, $con), true);

    //查询我方订单状态
    if($order_info['status'] != 0){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(20, $return_list);
    }
}

$data = array();

if($o_type == 1){
    //更新订单记录
    $data['status'] = 2;
    $data['intime'] = time();
    if(!dbUpdate($data, "qm_yuyue", $con, "orderid = '".$orderid."'")){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(302, $return_list);
    }

    //更新充值记录
    $data_n['trade_no'] = $trade_no;
    $data_n['out_trade_no'] = $orderid;
    $data_n['status'] = 2;
    $data_n['intime'] = time();

    dbAdd($data_n, "qm_zf_record", $con);

    //更新积分
    $sql = "select a.userid,b.newval from qm_yuyue as a,qm_tehui as b where a.orderid = '".$orderid."' and a.tid = b.id";
    $order_info = dbLoad(dbQuery($sql, $con), true);

    $data = array();
    $data['userid'] = $order_info['userid'];
    $data['order_num'] = $orderid;
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
}
else{
    $data['status'] = 1;
    $data['intime'] = time();
    $data['out_num'] = $trade_no;

    if(!dbUpdate($data, "qm_course_order", $con, "orderid = '".$orderid."'")){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(302, $return_list);
    }

    $sql = "select a.userid,b.price from qm_course_order as a,qm_course as b where a.orderid = '".$orderid."' and a.courseid = b.id";
    $order_info = dbLoad(dbQuery($sql, $con), true);

    $data = array();
    $data['userid'] = $order_info['userid'];
    $data['order_num'] = $orderid;
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
}

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list);

//post提交
function file_get_contents_post($url, $post) {  
    $options = array(  
        'http' => array(  
            'method' => 'POST',  
            'content' => $post,  
        ),  
    );  
  
    $result = file_get_contents($url, false, stream_context_create($options));  
  
    return $result;  
}

function getXml($reqArray){
    $str = "<xml>";
    $key_list = array_keys($reqArray);

    for($i = 0; $i < count($reqArray); $i++){
        $str = $str."<".$key_list[$i].">".$reqArray[$key_list[$i]]."</".$key_list[$i].">";
    }

    return $str."</xml>";
}

function getSign($reqArray){
    $str = "";
    $key_list = array_keys($reqArray);

    for($i = 0; $i < count($reqArray); $i++){
        $str = $str.$key_list[$i]."=".$reqArray[$key_list[$i]]."&";
    }

    $new_str = $str."key=qazwsxedcrfvtgbyhnujmikolp123456";
    return strtoupper(md5($new_str));
}
?>
