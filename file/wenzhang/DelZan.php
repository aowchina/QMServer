<?php
/**
 * 取消文章/评论赞
 * 接口参数: 8段 * userid * type * id
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 11)){
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

//验证type
$type = intval(trim($reqlist[9]));
if(!($type == 1 || $type == 2)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(12, $return_list);
}

//验证id
$id = trim($reqlist[10]);
if($id < 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(13, $return_list);
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

//检查用户是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and status = 1 and deviceid = '$deviceid'");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}

//验证id是否存在
if($type == 1){
    $tablename = "qm_wenzhang";
    $tablename2 = "qm_zan";
    $count_where = "userid = $userid and wid = $id";
}else{
    $tablename = "qm_wenzhang_pl";
    $tablename2 = "qm_zan";
    $count_where = "userid = $userid and plid = $id";
}

$count = dbCount($tablename, $con, "id = $id");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(15, $return_list);
}

//验证是否评论过
$count = dbCount($tablename2, $con, "userid = $userid and type = $type and zanid = $id");
if($count < 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(16, $return_list);
}

if(dbDelete($tablename2, $con, "userid = $userid and type = $type and zanid = $id")){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(302, $return_list);
}

?>
