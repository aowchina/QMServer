<?php
/**
 * 预订
 * 接口参数: 8段 * userid * orderid * hid * hua * sm * hj * fw * text
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 16)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证orderid
$orderid = trim($reqlist[9]);
if(!preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证hid
$hid = intval(trim($reqlist[10]));
if($hid < 1){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证花
$hua = intval(trim($reqlist[11]));
if(!($hua == 1 || $hua == 2 || $hua == 3)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//验证审美
$sm = intval(trim($reqlist[12]));
if(!($sm >= 1 && $sm <= 5)){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
}

//验证环境
$hj = intval(trim($reqlist[13]));
if(!($hj >= 1 && $hj <= 5)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}

//验证服务
$fw = intval(trim($reqlist[14]));
if(!($fw >= 1 && $fw <= 5)){
    unLock($dev_path.'lock');
    toExit(15, $return_list);
}

//验证评论内容
$text = getStrFromByte(trim($reqlist[15]));
if($text == '' || $text == null){
    unLock($dev_path.'lock');
    toExit(16, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(17, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(18, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(18, $return_list);
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
$count = dbCount("qm_users_login", $con, "userid = $userid and deviceid = '$deviceid' and status = 1");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(19, $return_list);
}

//订单号是否存在
$count = dbCount("qm_yuyue", $con, "orderid = '".$orderid."' and status = 3 and userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(20, $return_list);
}

//对比医院id
$sql = "select tid from qm_yuyue where orderid = '".$orderid."'";
$oinfo = dbLoad(dbQuery($sql, $con), true);
$tid = $oinfo['tid'];

$sql = "select hid from qm_tehui where id = $tid";
$tinfo = dbLoad(dbQuery($sql, $con), true);
if($tinfo['hid'] != $hid){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(12, $return_list);
}

//生成记录
$data['userid'] = $userid;
$data['orderid'] = $orderid;
$data['hid'] = $hid;
$data['text'] = mysql_real_escape_string($text, $con);
$data['hua'] = $hua;
$data['sm'] = $sm;
$data['hj'] = $hj;
$data['fw'] = $fw;
$data['intime'] = time();

if(dbAdd($data, "qm_pj", $con)){
    $data_up['status'] = 4;
    $data_up['intime'] = time();
    dbUpdate($data_up, "qm_yuyue", $con, "orderid = '".$orderid."'");

	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}
else{
	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(302, $return_list);
}

?>
