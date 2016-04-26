<?php
/**
 * 用户注册
 * 接口参数: 8段 * 昵称 * 生日 * 手机号 * 密码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mcheck.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 12)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证昵称
$name = trim($reqlist[8]);
if(strlen($name) > 255){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}
if(!strpos($name, "#")){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证生日
$birthday = trim($reqlist[9]);
if(!isBirthday($birthday)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证手机号
$tel = trim($reqlist[10]);
if(!isMobel($tel)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//验证密码
$psw = trim($reqlist[11]);
if(!isPsw($psw)){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
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

//锁表
$db_lockname = $j_path.'dblock/qm_users_common';
if(!lockDb($db_lockname)){
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(302, $return_list);
}

//手机号验重
$condition = "tel = '$tel'";
$count_tel = dbCount('qm_users_common', $con, $condition);
if($count_tel > 0){
    unLock($dev_path.'lock');
    closeDb($con);
    unLock($db_lockname);
    toExit(15, $return_list);
}

//检查该设备是否有其它用户在登录
$condition = "deviceid = '$deviceid' and status = 1";
$count = dbCount('qm_users_login', $con, $condition);
if($count > 0){
    $data_out['status'] = 0;

    $sql = "select userid from qm_users_login where ".$condition;

    $old_userid_list = dbLoad(dbQuery($sql, $con));    

    for($i = 0; $i < count($old_userid_list); $i++){
        $condition_out = "userid = ".$old_userid_list[$i]['userid'];
        dbUpdate($data_out, 'qm_users_login', $con, $condition_out);
    }
}

//生成随机userid
while(true){
    $userid = rand(100000, 999999999);
    $count = dbCount('qm_users_common', $con, 'userid = '.$userid);
    if($count == 0){
        break;
    }
}

$data['tel'] = $tel;
$data['userid'] = $userid;
$data['psw'] = $psw;
$data['block'] = 0;
$data['birthday'] = $birthday;
$data['username'] = $name;
$data['img'] = "";
$data['pid'] = 0;
$data['cid'] = 0;
$data['sex'] = 0;
$data['intime'] = time();

if(dbAdd($data, 'qm_users_common', $con)){

    $data_in['userid'] = $userid;
    $data_in['deviceid'] = $deviceid;
    $data_in['status'] = 1;
    dbAdd($data_in, 'qm_users_login', $con);

    //更新个人基本信息文件
    $user_path = $j_path.'user/'.getSubPath($userid, 4, true);
    if(!mkdirs($user_path)){
        unLock($dev_path.'lock');
        closeDb($con);
        unLock($db_lockname);
        $return_list['data'] = $userid;
        toExit(16, $return_list);
    }

    //生成登录记录文件
    $key_name = date("Y", $now_time).date("m", $now_time).date("d", $now_time);
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
    closeDb($con);
    unLock($db_lockname);
    toExit(0, $return_list);

}else{
    unLock($dev_path.'lock');
    closeDb($con);
    unLock($db_lockname);
    toExit(303, $return_list);
}

?>
