<?php
/**
 * 预订
 * 接口参数: 8段 * userid * tid
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证tid
$tid = intval(trim($reqlist[9]));
if($tid < 1){
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
    toExit(15, $return_list);
}

//检查用户是否绑定手机号
$sql = "select tel from qm_users_common where userid = $userid";
$uinfo = dbLoad(dbQuery($sql, $con), true);
if(!$uinfo['tel']){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(17, $return_list);
}

//特惠id是否存在
$count = dbCount("qm_tehui", $con, "id = $tid");
if($count != 1){
	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(16, $return_list);
}

//查询特惠信息
$sql = "select newval,dj from qm_tehui where id = $tid";
$tinfo = dbLoad(dbQuery($sql, $con), true);

//生成订单
$data['userid'] = $userid;
$data['orderid'] = "quanmei".date("YmdHis", time());
$data['status'] = 1;
$data['tid'] = $tid;
$data['intime'] = time();
$data['create_time'] = time();
$data['dj_money'] = $tinfo['dj'];
$data['wk_money'] = $tinfo['newval'] - $tinfo['dj'];

if(dbAdd($data, "qm_yuyue", $con)){
    $r_data['orderid'] = $data['orderid'];

	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    $return_list['data'] = json_encode($r_data);
    toExit(0, $return_list);
}
else{
	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(302, $return_list);
}

?>
