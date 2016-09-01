<?php
/**
 * 用户登录
 * 接口参数: 8段 * 第三方登录类型 * openid * name * img
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mcheck.php");
include_once("../functions_mdb.php");
include_once("../Jpush.php");

//验证参数个数
if(!(count($reqlist) == 12)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证登录类型
$type = trim($reqlist[8]);
if(!($type == 1 || $type == 2 || $type == 3)){
    toExit(10, $return_list);
}

//验证openid
$openid = trim($reqlist[9]);
if(empty($openid)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

$name = trim($reqlist[10]);
if(strlen($name) > 255){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//验证头像
$img = trim($reqlist[11]);

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

//openid是否存在
$condition = "type = $type and openid = '".mysql_real_escape_string($openid, $con)."'";
$count = dbCount('qm_users_dsf', $con, $condition);

if($count > 0){
    //用户注册过,走登录流程
    $sql = "select userid from qm_users_dsf where $condition";
    $user_info = dbLoad(dbQuery($sql, $con), true);
    $userid = $user_info['userid'];

    //打用户锁
    $user_path = $j_path.'user/'.getSubPath($userid, 4, true);
    if(!file_put_contents($user_path."lock", " ", LOCK_EX)){
        unLock($dev_path.'lock');
        closeDb($con);
        toExit(12, $return_list);
    }

    //检查是否有其它设备登录此号
    $condition = "userid = $userid and deviceid != '$deviceid' and status = 1";
    $count = dbCount('qm_users_login', $con, $condition);
    if($count > 0){
        $data_out['status'] = 0;

        $sql = "select deviceid from qm_users_login where ".$condition;
        $old_userinfo_list = dbLoad(dbQuery($sql, $con));

        for($i = 0; $i < count($old_userinfo_list); $i++){
            $condition_out = "deviceid = '".$old_userinfo_list[$i]['deviceid']."' and userid = $userid";
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

        $sql = "select userid from qm_users_login where ".$condition;
        $old_userinfo_list = dbLoad(dbQuery($sql, $con));

        for($i = 0; $i < count($old_userinfo_list); $i++){
            $condition_out = "deviceid = '$deviceid' and userid = ".$old_userinfo_list[$i]['userid'];
            dbUpdate($data_out, 'qm_users_login', $con, $condition_out);
        }
    }

    //更新当前用户登录状态
    $condition = "userid = $userid and deviceid = '$deviceid' and status = 1";
    $count = dbCount('qm_users_login', $con, $condition);
    if($count != 1){
        $condition2 = "userid = $userid and deviceid = '$deviceid'";
        $count = dbCount('qm_users_login', $con, $condition2);
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
    closeDb($con);
    toExit(0, $return_list);
}
else{
    //锁表
    $db_lockname = $j_path.'dblock/qm_users_common';
    if(!lockDb($db_lockname)){
        unLock($dev_path.'lock');
        closeDb($con);
        toExit(302, $return_list);
    }

    //没注册过，走注册流程
    //生成随机userid
    while(true){
        $userid = rand(100000, 999999999);
        $count = dbCount('qm_users_common', $con, 'userid = '.$userid);
        if($count == 0){
            break;
        }
    }
    $data['tel'] = "";
    $data['userid'] = $userid;
    $data['psw'] = "";
    $data['block'] = 0;
    $data['birthday'] = "";
    $data['username'] = $name;
    $data['img'] = $img;
    $data['pid'] = 0;
    $data['cid'] = 0;
    $data['sex'] = 0;
    $data['intime'] = time();

    if(dbAdd($data, 'qm_users_common', $con)){

        $data_in['userid'] = $userid;
        $data_in['deviceid'] = $deviceid;
        $data_in['status'] = 1;
        dbAdd($data_in, 'qm_users_login', $con);

        $data_in_dsf['userid'] = $userid;
        $data_in_dsf['type'] = $type;
        $data_in_dsf['openid'] = mysql_real_escape_string($openid, $con);
        $data_in_dsf['intime'] = time();
        dbAdd($data_in_dsf, 'qm_users_dsf', $con);

        //更新个人基本信息文件
        $user_path = $j_path.'user/'.getSubPath($userid, 4, true);
        mkdirs($user_path);

        //生成登录记录文件
        $key_name = date("Y", $now_time).date("m", $now_time).date("d", $now_time);
        $login_info[$key_name][] = $now_time;
        file_put_contents($user_path.'logininfo', json_encode($login_info));

        $sql = "select username,img from qm_users_common where userid = $userid";
        $now_userinfo = dbLoad(dbQuery($sql, $con), true);
        $userimg = $now_userinfo['img'];
        $r_data['username'] = getStrFromByte($now_userinfo['username']);
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
}

?>
