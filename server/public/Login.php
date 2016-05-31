<?php
/**
 * 用户登录
 * 接口参数: 8段 * 用户名 * 密码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    forExit($lock_array);
    toExit(6, $return_list);
}

$username = trim($reqlist[8]);
$psw = trim($reqlist[9]);

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

//是否存在
$condition = "username = '$username'";
$count_tel = dbCount('qm_users', $con, $condition);
if($count_tel < 1){
    forExit($lock_array, $con);
    toExit(10, $return_list);
}

//获取userid
$sql = "select id from qm_users where ".$condition;
$now_userinfo = dbLoad(dbQuery($sql, $con), true);
$userid = $now_userinfo['id'];

$r_data['userid'] = $userid;

$return_list['data'] = json_encode($r_data);
forExit($lock_array, $con);
toExit(0, $return_list, true);

?>
