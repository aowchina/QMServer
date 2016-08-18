<?php
/**
 * 课程预订
 * 接口参数: 8段 * userid * 课程id * 数量 * 单价
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 12)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证课程id
$courseid = intval(trim($reqlist[9]));
if($courseid < 1){
	unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//数量
$amount = intval(trim($reqlist[10]));
if($amount < 1){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//价格
$price = trim($reqlist[11]);
if(!isPoint($price, 8, 2)){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(15, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(16, $return_list);
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
    toExit(17, $return_list);
}

//检查用户是否绑定手机号
$sql = "select tel from qm_users_common where userid = $userid";
$uinfo = dbLoad(dbQuery($sql, $con), true);
if(!$uinfo['tel']){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(18, $return_list);
}

//课程id是否存在
$count = dbCount("qm_course", $con, "id = $courseid");
if($count != 1){
	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(19, $return_list);
}

//价格是否一样
$sql = "select price from qm_course where id = $courseid";
$course_info = dbLoad(dbQuery($sql, $con), true);
$db_price = $course_info['price'];
if($price != $db_price){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(20, $return_list);
}

//锁订单表
$db_lockfile = $j_path.'dblock/order';
if(!file_put_contents($db_lockfile, " ", LOCK_EX)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(21, $return_list);
}

//生成订单
$data['userid'] = $userid;
$data['orderid'] = "quanmei_course".date("YmdHis", time());
$data['status'] = 0;
$data['courseid'] = $courseid;
$data['amount'] = $amount;
$data['create_time'] = $data['intime'] = time();

if(dbAdd($data, "qm_course_order", $con)){
	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    unLock($db_lockfile);
    closeDb($con);

    $r_data['orderid'] = $data['orderid'];
    $return_list['data'] = json_encode($r_data);
    toExit(0, $return_list);
}
else{
	unLock($dev_path.'lock');
    unLock($user_path.'lock');
    unLock($db_lockfile);
    closeDb($con);
    toExit(302, $return_list);
}

//是否为整数或小数
function isPoint($str, $intLen = 4, $floatLen = 2){
    $int_exp = "/^[1-9]{1}[0-9]{0,".($intLen-1)."}$/";
    $float_exp = "/^[0-9]{0,".$floatLen."}$/";

    if(strpos($str, ".") === false){
        if(preg_match($int_exp, $str)){
            return true;
        }
    }
    else{
        $str_array = explode(".", $str);
        if(count($str_array) == 2){
            $int_str = $str_array[0];
            $float_str = $str_array[1];

            if(preg_match($int_exp, $int_str) && preg_match($float_exp, $float_str)){
                return true;
            }
        }
    }

    return false;
}

?>
