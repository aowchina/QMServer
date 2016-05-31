<?php
/**
 * 检查用户能否签到
 * 接口参数: 8段 * userid
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 9)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
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

//验证userid是否存在
$count = dbCount("qm_users_common", $con, "userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(12, $return_list);
}

$now_time = time();
$now_date = date("Y-m-d", $now_time);

$stime = strtotime($now_date.' 00:00:00');
$etime = strtotime($now_date.' 23:59:59');

$count = dbCount('qm_point_record', $con, 'userid = '.$userid." and type = 1 and (ctime between $stime and $etime)");
if($count > 0){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list);

?>
