<?php
/**
 * 取消收藏
 * 接口参数: 8段 * userid * 收藏id
 * author wangrui@min-fo.com
 * date 2016-06-23
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

// 验证收藏id
$scid = intval(trim($reqlist[9]));
if (!(is_numeric($scid) && $scid<999999999)) {
    unLock($dev_path.'lock');
    toExit(7, $return_list);
}
//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(8, $return_list);
}
//userid打锁
$user_repath = getSubPath($userid, 4, true);
$user_path = $j_path.'user/'.$user_repath;
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(9, $return_list);
}
// 防止并发
if (is_file($user_path.'lock')) {
    unLock($dev_path.'lock');
    toExit(10, $return_list);
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

// 检查用户是否处于登录状态
$count = dbCount("qm_users_login", $con, "userid = $userid and deviceid = '$deviceid' and status = 1");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(12, $return_list);
}

// 检查文章id是否存在
$count = dbCount("qm_sc",$con,'userid = '.$userid.' and scid = '.$scid);
if ($count != 1) {
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

// 删除收藏表中该收藏
$delete_result = dbDelete('qm_sc',$con,'userid = '.$userid.' and scid = '.$scid);
if ($delete_result) {
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}


?>
