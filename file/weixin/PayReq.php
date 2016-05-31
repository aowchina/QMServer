<?php
/**
 * 获取微信订单号
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

//验证订单号
$orderid = trim($reqlist[9]);
if(!preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
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

//检查用户是否存在
$count = dbCount("qm_users_common", $con, "userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(18, $return_list);
}

//检查用户是否绑定手机号
$sql = "select tel from qm_users_common where userid = $userid";
$uinfo = dbLoad(dbQuery($sql, $con), true);
if(!$uinfo['tel']){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(19, $return_list);
}

//订单是否存在
$count = dbCount("qm_yuyue", $con, "orderid = '$orderid' and status = 1");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(20, $return_list);
}

//查询特惠
$sql = "select tid from qm_yuyue where orderid = '$orderid'";
$oinfo = dbLoad(dbQuery($sql, $con), true);
$tid = $oinfo['tid'];

$sql = "select dj from qm_tehui where id = ".$tid;
$tinfo = dbLoad(dbQuery($sql, $con), true);
$money = $tinfo['dj'];

//拼接请求微信的数组
$now_time = time();

$req = array();
$req['appid'] = "wx719c1e4eebfb3fb7";
$req['body'] = "全美--订单支付";
$req['mch_id'] = "1311715801";
$req['nonce_str'] = md5($now_time);    //随机字符串,32位
$req['notify_url'] = "http://192.168.1.101/test/game/zuqiu/api/one/";
$req['out_trade_no'] = $orderid;
$req['spbill_create_ip'] = "127.0.0.1";
//$req['total_fee'] = $money * 100;
$req['total_fee'] = 1;
$req['trade_type'] = "APP";
$req['sign'] = getSign($req);

//拼接请求微信服务器的xml
$post_xml = getXml($req);
$data = file_get_contents_post("https://api.mch.weixin.qq.com/pay/unifiedorder", $post_xml);

//解析微信返回的xml
if(!$data){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(15, $return_list);
}

$xml_array = simplexml_load_string($data, null, LIBXML_NOCDATA);

if($xml_array->return_code != "SUCCESS"){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(16, $return_list);
}

if($xml_array->result_code != "SUCCESS"){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(17, $return_list);
}

$rs_list["pid"] = (String)$xml_array->prepay_id;
$rs_list["orderid"] = $orderid;
$rs_list["nonce_str"] = md5($now_time);
$rs_list["timestamp"] = $now_time;

$req2['partnerid'] = "1311715801";
$req2['pripayid'] = (String)$xml_array->prepay_id;
$req2['package'] = "Sign=WXPay";
$req2['noncestr'] = md5($now_time);
$req2['timestamp'] = $now_time;

$rs_list["sign"] = getSign($req2);

$r_data['wxinfo'] = $rs_list;
$r_data['tel'] = $uinfo['tel'];

$return_list['data'] = json_encode($r_data);
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
