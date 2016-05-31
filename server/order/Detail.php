<?php
/**
 * 订单详情
 * 接口参数: 8段 * userid * orderid
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 1 && $userid <= 999999999)){
    forExit($lock_array);
    toExit(10, $return_list);
}

$orderid = trim($reqlist[9]);
if(!preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
    forExit($lock_array);
    toExit(11, $return_list);
}

//连接db
$con = conDb();
if($con == ''){
    forExit($lock_array);
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    forExit($lock_array, $con);
    toExit(301, $return_list);
}

//检查用户是否存在
$count = dbCount("qm_users", $con, "id = $userid");
if($count != 1){
    forExit($lock_array, $con);
    toExit(12, $return_list);
}

$sql = "select group_id from qm_user_usergroup_map where user_id = $userid";
$re = dbLoad(dbQuery($sql, $con), true);
$group_id = $re['group_id'];
if($group_id != 7){
    forExit($lock_array, $con);
    toExit(13, $return_list);
}

//是否存在
$count = dbCount("qm_yuyue", $con, "orderid = '$orderid'");
if($count != 1){
    forExit($lock_array, $con);
    toExit(14, $return_list);
}

$sql = "select * from qm_yuyue where orderid = '$orderid'";
$oinfo = dbLoad(dbQuery($sql, $con), true);

if($oinfo['server_id'] != $userid){
    forExit($lock_array, $con);
    toExit(16, $return_list);
}

//获取特惠数据
$tid = $oinfo['tid'];
$filename = $j_path.'tehui/item/'.$tid.'/baseinfo';
if(is_file($filename)){
    $info = json_decode(file_get_contents($filename), true);

    $oinfo['simg'] = $s_url.getItem("simg", $info);
    $oinfo['dj'] = getItem("dj", $info);
    $oinfo['newval'] = getItem("newval", $info);
    $oinfo['name'] = getItem('name', $info);
    $oinfo['fname'] = getItem('fname', $info);

    //获取医院信息
    $hid = $info['hid'];
    $hinfo = array();
    if(is_file($j_path.'hospital/'.$hid."/baseinfo")){
        $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid."/baseinfo"), true);
    }
    $oinfo['hname'] = getItem("name", $hinfo);
    $oinfo['hid'] = $hid;
}else{
    $oinfo['simg'] = "";
    $oinfo['dj'] = "";
    $oinfo['name'] = "";
    $oinfo['fname'] = "";
    $oinfo['hname'] = "";
    $oinfo['hid'] = 0;
}

$sql = "select tel from qm_users_common where userid = ".$oinfo['userid'];
$uinfo = dbLoad(dbQuery($sql, $con), true);
$oinfo['tel'] = $uinfo['tel'];

if($oinfo['create_time']){
    $oinfo['ctime'] = date("Y-m-d H:i", $oinfo['create_time']);
}
else{
    $oinfo['ctime'] = date("Y-m-d H:i", $oinfo['intime']);
}

$oinfo['have_pay'] = $oinfo['dj_real_money'] + $oinfo['wk_real_money'] + $oinfo['dj_point_money'] + $oinfo['wk_point_money'];
$oinfo['true_pay'] = $oinfo['dj_real_money'] + $oinfo['wk_real_money'];
$oinfo['point_money'] = $oinfo['dj_point_money'] + $oinfo['wk_point_money'];

forExit($lock_array, $con);
$return_list['data'] = json_encode($oinfo);
toExit(0, $return_list);

?>
