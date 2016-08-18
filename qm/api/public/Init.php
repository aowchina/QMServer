<?php
/**
 * 用户初始化
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
$userid = trim($reqlist[8]);
if($userid < 100000 || $userid > 999999999){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!file_put_contents($user_path."lock", " ", LOCK_EX)){
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

//获取当前用户登录状态
$condition = "userid = $userid and deviceid = '$deviceid' and status = 1";
$count = dbCount('qm_users_login', $con, $condition);
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(12, $return_list);
}

//更新登录记录文件
$now_time = time();
$key_name = date("Y", $now_time).date("m", $now_time).date("d", $now_time);
if(is_file($user_path.'logininfo')){
    $login_info = json_decode(file_get_contents($user_path.'logininfo'), true);
}else{
    $login_info = array();
}

$login_info[$key_name][] = $now_time;
file_put_contents($user_path.'logininfo', json_encode($login_info));

$sql = "select img from qm_users_common where userid = $userid";
$now_userinfo = dbLoad(dbQuery($sql, $con), true);
$userimg = $now_userinfo['img'];
if($userimg){
    $r_data['userimg'] = $userimg;
}else{
    $r_data['userimg'] = "";
}
$r_data['userid'] = $userid;
$return_list['data'] = json_encode($r_data);

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list);

?>
