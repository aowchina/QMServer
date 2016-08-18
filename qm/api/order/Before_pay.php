<?php
/**
 * 支付之前获取支付信息
 * 接口参数: 8段 * userid * 订单号 * 支付类型(1定金，2全款，3追加尾款) * 支付方式(1支付宝，2微信) * 消耗积分
 * author wangrui@min-fo.com
 * date 2015-05-01
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

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
    toExit(13, $return_list);
}
if(is_file($user_path.'lock')){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}

$pay_kind = intval(trim($reqlist[10]));
if(!($pay_kind == 1 || $pay_kind == 2 || $pay_kind == 3)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(15, $return_list);
}

$pay_type = intval(trim($reqlist[11]));
if(!($pay_type == 1 || $pay_type == 2)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(16, $return_list);
}

$hf_point = trim($reqlist[12]);
if(!isFloat($hf_point, 8, 2)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(17, $return_list);
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
if($pay_kind == 1 || $pay_kind == 2){
    $count = dbCount("qm_yuyue", $con, "orderid = '$orderid' and status = 1");
}
else{
    $count = dbCount("qm_yuyue", $con, "orderid = '$orderid' and status = 2");
}
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(20, $return_list);
}

$sql = "select dj_money,wk_money from qm_yuyue where orderid = '$orderid'";
$oinfo = dbLoad(dbQuery($sql, $con), true);
$dj_money = $oinfo['dj_money'];
$wk_money = $oinfo['wk_money'];

//查询用户积分
$sql = "select sum(point) from qm_point_record where userid = $userid and status = 1";
$result = dbLoad(dbQuery($sql, $con), true);
$get_point = $result['sum(point)'];
if(!$get_point){
    $get_point = 0;
}

$sql = "select sum(point) from qm_point_record where userid = $userid and status = 2";
$result = dbLoad(dbQuery($sql, $con), true);
$out_point = $result['sum(point)'];
if(!$out_point){
    $out_point = 0;
}

$can_use_point = $get_point - $out_point;
if($can_use_point < $hf_point){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(21, $return_list);
}

//查询积分能兑换成多少钱
$sql = "select * from qm_point_rule";
$re = dbLoad(dbQuery($sql, $con), true);
$point_money = round($hf_point / $re['xh_point'], 2);

//构造更新数组
$data = array();

//定金
if($pay_kind == 1){
    $need_pay = $dj_money - $point_money;

    $data['dj_real_money'] = $need_pay;
    $data['dj_hf_point'] = $hf_point;
    $data['dj_point_money'] = $point_money;

    if($need_pay == 0){
        $data['status'] = 2;
    }
}
//全款
elseif($pay_kind == 2){
    $need_pay = $dj_money + $wk_money - $point_money;

    $data['wk_point_money'] = $point_money;
    $data['wk_hf_point'] = $hf_point;
    $data['wk_real_money'] = $need_pay;

    if($need_pay == 0){
        $data['wk_type'] = 2;
        $data['status'] = 5;
    }
}
//追加
else{
    $need_pay = $wk_money - $point_money;

    $data['wk_point_money'] = $point_money;
    $data['wk_hf_point'] = $hf_point;
    $data['wk_real_money'] = $need_pay;

    if($need_pay == 0){
        $data['wk_type'] = 2;
        $data['status'] = 5;
    }
}

if($need_pay < 0){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(22, $return_list);
}

//更新db
if(!dbUpdate($data, 'qm_yuyue', $con, "orderid = '$orderid'")){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(302, $return_list);
}

if($need_pay == 0){
    //扣除积分
    $data = array();
    $data['point'] = $hf_point;
    $data['type'] = 2;
    $data['status'] = 2;
    $data['order_num'] = $orderid;
    $data['userid'] = $userid;
    $data['ctime'] = $data['intime'] = time();
    dbAdd($data, 'qm_point_record', $con);
}

if($pay_type == 1){
    if($pay_kind == 1){
        $r_data['orderid'] = $orderid.'dj';
    }
    elseif($pay_kind == 2){
        $r_data['orderid'] = $orderid.'qk';
    }
    else{
        $r_data['orderid'] = $orderid.'wk';
    }

    $r_data['money'] = $need_pay;
    $return_list['data'] = json_encode($r_data);
}
else{
    if($need_pay != 0){
        //拼接请求微信的数组
        $now_time = time();

        $req = array();
        $req['appid'] = "wx719c1e4eebfb3fb7";
        $req['body'] = "全美--订单支付";
        $req['mch_id'] = "1311715801";
        $req['nonce_str'] = md5($now_time);    //随机字符串,32位
        $req['notify_url'] = "http://139.196.172.208/qm/api/order/WxNotify.php";

        if($pay_kind == 1){
            $req['out_trade_no'] = $orderid.'dj';
        }
        elseif($pay_kind == 2){
            $req['out_trade_no'] = $orderid.'qk';
        }
        else{
            $req['out_trade_no'] = $orderid.'wk';
        }

        $req['spbill_create_ip'] = "127.0.0.1";
        $req['total_fee'] = $need_pay * 100;
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
            toExit(23, $return_list);
        }

        $xml_array = simplexml_load_string($data, null, LIBXML_NOCDATA);

        if($xml_array->return_code != "SUCCESS"){
            unLock($dev_path.'lock');
            unLock($user_path.'lock');
            closeDb($con);
            toExit(24, $return_list);
        }

        if($xml_array->result_code != "SUCCESS"){
            unLock($dev_path.'lock');
            unLock($user_path.'lock');
            closeDb($con);
            toExit(25, $return_list);
        }

        $r_data["pid"] = (String)$xml_array->prepay_id;
        $r_data['money'] = $need_pay;
        $r_data["orderid"] = $req['out_trade_no'];
        $r_data["nonce_str"] = md5($now_time);
        $r_data["timestamp"] = $now_time;

        $sign_array['partnerid'] = "1311715801";
        $sign_array['pripayid'] = (String)$xml_array->prepay_id;
        $sign_array['package'] = "Sign=WXPay";
        $sign_array['noncestr'] = md5($now_time);
        $sign_array['timestamp'] = $now_time;

        $r_data["sign"] = getSign($sign_array);

        $return_list['data'] = json_encode($r_data);
    }
    else{
        $r_data['money'] = $need_pay;
        $return_list['data'] = json_encode($r_data);
    }
}

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list);

//验证是否为整数或小数
function isFloat($str, $int_length, $point_length){
    if(strpos($str, '.') !== false){
        $str_list = explode('.', $str);
        if(count($str_list) == 2 && preg_match("/^[0-9]{1}$/", $str_list[0]) && preg_match("/^[0-9]{1}$/", $str_list[1])){

            return true;
        }
    }
    else{
        if(preg_match("/^[0-9]+$/", $str) && strlen($str) <= $int_length){
            return true;
        }
    }

    return false;
}

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
