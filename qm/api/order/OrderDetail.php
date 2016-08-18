<?php
/**
 * 订单详情
 * 接口参数: 8段 * userid * orderid
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$orderid = trim($reqlist[9]);
if(!preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
    unLock($dev_path.'lock');
    toExit(15, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(15, $return_list);
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
    toExit(12, $return_list);
}

//检查用户是否绑定手机号
$sql = "select tel from qm_users_common where userid = $userid";
$uinfo = dbLoad(dbQuery($sql, $con), true);
if(!$uinfo['tel']){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

//获取订单
$sql = "select * from qm_yuyue where userid = $userid and orderid = '$orderid'";
$re = dbLoad(dbQuery($sql, $con), true);

if(count($re) < 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}
else{
    //获取特惠数据
    $tid = $re['tid'];
    $filename = $j_path.'tehui/item/'.$tid.'/baseinfo';
    if(is_file($filename)){
        $info = json_decode(file_get_contents($filename), true);

        $re['simg'] = $s_url.getItem("simg", $info);
        $re['dj'] = getItem("dj", $info);
        $re['newval'] = getItem("newval", $info);
        $re['name'] = getItem('name', $info);
        $re['fname'] = getItem('fname', $info);

        //获取医院信息
        $hid = $info['hid'];
        $hinfo = array();
        if(is_file($j_path.'hospital/'.$hid."/baseinfo")){
            $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid."/baseinfo"), true);
        }
        $re['hname'] = getItem("name", $hinfo);
        $re['hid'] = $hid;
    }else{
        $re['simg'] = "";
        $re['dj'] = "";
        $re['name'] = "";
        $re['fname'] = "";
        $re['hname'] = "";
        $re['hid'] = 0;
    }

    $re['tel'] = $uinfo['tel'];

    if($re['create_time']){
        $re['ctime'] = date("Y-m-d H:i", $re['create_time']);

        if($re['status'] == 1){
            $re['chatime'] = time() - $re['create_time'];
        }
        else{
            $re['chatime'] = 0;
        }
    }
    else{
        $re['ctime'] = date("Y-m-d H:i", $re['intime']);

        if($re['status'] == 1){
            $re['chatime'] = time() - $re['intime'];
        }
        else{
            $re['chatime'] = 0;
        }
    }

    $re['have_pay'] = $re['dj_real_money'] + $re['wk_real_money'] + $re['dj_point_money'] + $re['wk_point_money'];
    $re['true_pay'] = $re['dj_real_money'] + $re['wk_real_money'];
    $re['point_money'] = $re['dj_point_money'] + $re['wk_point_money'];
}

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
$return_list['data'] = json_encode($re);
toExit(0, $return_list);

?>
