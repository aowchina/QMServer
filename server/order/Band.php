<?php
/**
 * 绑定订单
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

if($oinfo['status'] != 5){
    forExit($lock_array, $con);
    toExit(15, $return_list);
}

if($oinfo['server_id'] != 0 && $oinfo['server_id'] != $userid){
    forExit($lock_array, $con);
    toExit(16, $return_list);
}

if($oinfo['server_id'] == 0){
    $data = array();
    $data['server_id'] = $userid;

    if(!dbUpdate($data, 'qm_yuyue', $con, "orderid = '$orderid'")){
        forExit($lock_array, $con);
        toExit(302, $return_list);
    }
}

$r_data['orderid'] = $orderid;
$return_list['data'] = json_encode($r_data);
forExit($lock_array, $con);
toExit(0, $return_list);

?>
