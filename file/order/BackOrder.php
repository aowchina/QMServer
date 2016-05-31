<?php
/**
 * 退单
 * 接口参数: 8段 * userid * 订单号
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

//订单是否存在
$count = dbCount("qm_yuyue", $con, "orderid = '$orderid' and (status = 2 or status = 5) and userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(20, $return_list);
}

$sql = "select * from qm_yuyue where orderid = '$orderid'";
$oinfo = dbLoad(dbQuery($sql, $con), true);

if(!($oinfo['status'] == 2 || $oinfo['status'] == 5)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(21, $return_list);
}

if($oinfo['status'] == 2){
    $data['intime'] = time();
    $data['status'] = 8;
    if(!dbUpdate($data, 'qm_yuyue', $con, "orderid = '$orderid'")){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(301, $return_list);
    }
}
else{
    $data['intime'] = time();
    $data['status'] = 7;
    if(!dbUpdate($data, 'qm_yuyue', $con, "orderid = '$orderid'")){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(301, $return_list);
    }
}

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list);

?>
