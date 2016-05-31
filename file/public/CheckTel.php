<?php
/**
 * 手机号验重
 * 接口参数: 8段 * 手机号
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");
include_once("../functions_mcheck.php");

//验证参数个数
if(!(count($reqlist) == 9)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证手机号
$tel = trim($reqlist[8]);
if(!isMobel($tel)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//手机号打锁
$tel_lockpath = $j_path.'guanlian/tel/'.getSubPath($tel, 4, true);
if(!mkdirs($tel_lockpath)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
$tel_lockname = $tel_lockpath.'lock';
if(!file_put_contents($tel_lockname, " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//连接db
$con = conDb();
if($con == ''){
    unLock($dev_path.'lock');
    unLock($tel_lockname);
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    unLock($dev_path.'lock');
    unLock($tel_lockname);
    closeDb($con);
    toExit(301, $return_list);
}

//获取当前用户登录状态
$condition = "tel = '$tel'";
$count = dbCount('qm_users_common', $con, $condition);
if($count > 0){
    unLock($dev_path.'lock');
    unLock($tel_lockname);
    closeDb($con);
    toExit(12, $return_list);
}

unLock($dev_path.'lock');
unLock($tel_lockname);
closeDb($con);
toExit(0, $return_list);

?>
