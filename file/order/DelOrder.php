<?php
/**
 * 删除订单
 * 接口参数: 8段 * userid * orderid
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证文章id
$orderid = trim($reqlist[9]);
if(!preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
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

//验证userid是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and deviceid = '".$deviceid."' and status = 1");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

//验证orderid是否存在
$count = dbCount("qm_yuyue", $con, "orderid = '".$orderid."' and userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}

//获取状态
$sql = "select status from qm_yuyue where orderid = '".$orderid."'";
$oinfo = dbLoad(dbQuery($sql, $con), true);
$status = $oinfo['status'];

if($status != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(15, $return_list);
}

$sql = "delete from qm_yuyue where orderid = '".$orderid."'";
if(dbQuery($sql, $con)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}
else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(303, $return_list);
}

?>
