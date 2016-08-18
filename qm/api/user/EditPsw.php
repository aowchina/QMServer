<?php
/**
 * 修改昵称
 * 接口参数: 8段 * 手机号 * 密码 * 确认密码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");
include_once("../functions_mcheck.php");

//验证参数个数
if(!(count($reqlist) == 11)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证手机号
$tel = trim($reqlist[8]);
if(!isMobel($tel)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证密码
$psw = trim($reqlist[9]);
if(!isPsw($psw)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证确认密码
$psw2 = trim($reqlist[10]);
if($psw2 != $psw){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//连接db
$con = conDb();
if($con == ''){
    unLock($dev_path.'lock');
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(301, $return_list);
}

//验证userid是否已登录
$count = dbCount("qm_users_common", $con, "tel = $tel");
if($count != 1){
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

$data['psw'] = $psw;
$data['intime'] = time();

if(dbUpdate($data, "qm_users_common", $con, "tel = $tel")){
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(303, $return_list);
}

?>
