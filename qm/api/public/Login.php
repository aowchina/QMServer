<?php
/**
 * 用户登录
 * 接口参数: 8段 * 手机号 * 密码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mcheck.php");
include_once("../functions_mdb.php");
include_once("../Jpush.php");

//验证参数个数
if(!(count($reqlist) == 10)){
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

//手机号打锁
$tel_lockpath = $j_path.'guanlian/tel/'.getSubPath($tel, 4, true);
if(!mkdirs($tel_lockpath)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}
$tel_lockname = $tel_lockpath.'lock';
if(!file_put_contents($tel_lockname, " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
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

//手机号是否存在
$condition = "tel = '$tel'";
$count_tel = dbCount('qm_users_common', $con, $condition);
if($count_tel < 1){
    unLock($dev_path.'lock');
    unLock($tel_lockname);
    closeDb($con);
    toExit(13, $return_list);
}

//密码正确
$condition = "psw = '".$psw."' and tel = '$tel'";
$count = dbCount('qm_users_common', $con, $condition);
if($count != 1){
    unLock($dev_path.'lock');
    unLock($tel_lockname);
    closeDb($con);
    toExit(14, $return_list);
}

//获取userid
$sql = "select userid from qm_users_common where ".$condition;
$now_userinfo = dbLoad(dbQuery($sql, $con), true);
$userid = $now_userinfo['userid'];

//打用户锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!file_put_contents($user_path."lock", " ", LOCK_EX)){
    unLock($dev_path.'lock');
    unLock($tel_lockname);
    closeDb($con);
    toExit(16, $return_list);
}

//检查是否有其它设备登录此号
$condition = "userid = $userid and deviceid != '$deviceid' and status = 1";
$count = dbCount('qm_users_login', $con, $condition);
if($count > 0){
    $data_out['status'] = 0;

    $sql = "select userid,deviceid from qm_users_login where ".$condition;
    $old_userinfo_list = dbLoad(dbQuery($sql, $con));

    for($i = 0; $i < count($old_userinfo_list); $i++){
        $condition_out = "deviceid = '".$old_userinfo_list[$i]['deviceid']."' and userid = ".$old_userinfo_list[$i]['userid'];
        dbUpdate($data_out, 'qm_users_login', $con, $condition_out);

        $jpush_filename = $j_path.'device/'.getSubPath($old_userinfo_list[$i]['deviceid'], 4, true)."jpush";
        if(is_file($jpush_filename)){
            $jpushid = file_get_contents($jpush_filename);
            if($jpushid){
                $jp = new Jpush();
                $jp->push(array('registration_id'=>array($jpushid)), '设备已登录');
            }
        }
    }
}

//检查是否有其它人在此设备已登录
$condition = "userid != $userid and deviceid = '$deviceid' and status = 1";
$count = dbCount('qm_users_login', $con, $condition);
if($count > 0){
    $data_out['status'] = 0;

    $sql = "select userid,deviceid from qm_users_login where ".$condition;
    $old_userinfo_list = dbLoad(dbQuery($sql, $con));

    for($i = 0; $i < count($old_userinfo_list); $i++){
        $condition_out = "deviceid = '".$old_userinfo_list[$i]['deviceid']."' and userid = ".$old_userinfo_list[$i]['userid'];
        dbUpdate($data_out, 'qm_users_login', $con, $condition_out);
    }
}

//更新当前用户登录状态
$condition = "userid = $userid and deviceid = '$deviceid' and status = 1";
$count = dbCount('qm_users_login', $con, $condition);
if($count != 1){
    $condition2 = "userid = $userid and deviceid = '$deviceid'";
    $count = dbCount("qm_users_login", $con, $condition2);
    if($count > 0){
        $data_in['status'] = 1;
        $condition_in = "deviceid = '$deviceid' and userid = $userid";
        dbUpdate($data_in, 'qm_users_login', $con, $condition_in);
    }
    else{
        $data_in['status'] = 1;
        $data_in['userid'] = $userid;
        $data_in['deviceid'] = $deviceid;
        dbAdd($data_in, 'qm_users_login', $con);
    }
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
unLock($tel_lockname);
closeDb($con);
toExit(0, $return_list);

?>
