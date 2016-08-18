<?php
/**
 * 我的订单
 * 接口参数: 8段 * userid * 状态(1待支付，2待服务，3待评价，4已取消，5已完成) * 页码
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 11)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

$status = intval(trim($reqlist[9]));
if(!($status >= 1 && $status <= 5)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$page = intval(trim($reqlist[10]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
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

$limit = (($page - 1)*10).',10';

$field = 'tid,orderid,intime,create_time,userid,status';

//获取订单
switch($status){
    case 1:
        $sql = "select $field from qm_yuyue where userid = $userid and status = 1 order by intime desc limit $limit";
        break;
    case 2:
        $sql = "select $field from qm_yuyue where userid = $userid and (status = 5 or status = 2) order by intime desc limit $limit";
        break;
    case 3:
        $sql = "select $field from qm_yuyue where userid = $userid and status = 3 order by intime desc limit $limit";
        break;
    case 4:
        $sql = "select $field from qm_yuyue where userid = $userid and (status = 7 or status = 8 or status = 9) order by intime desc limit $limit";
        break;
    case 5:
        $sql = "select $field from qm_yuyue where userid = $userid and status = 4 order by intime desc limit $limit";
        break;
    default:
        $sql = "select $field from qm_yuyue where userid = $userid and status = 1 order by intime desc limit $limit";
        break;
}

$order_list = dbLoad(dbQuery($sql, $con));

if(count($order_list) > 0){
    foreach($order_list as &$order_item){
        //获取特惠数据
        $tid = $order_item['tid'];
        $filename = $j_path.'tehui/item/'.$tid.'/baseinfo';
        if(is_file($filename)){
            $info = json_decode(file_get_contents($filename), true);

            $order_item['simg'] = $s_url.getItem("simg", $info);
            $order_item['dj'] = getItem("dj", $info);
            $order_item['newval'] = getItem("newval", $info);
            $order_item['name'] = getItem('name', $info);
            $order_item['fname'] = getItem('fname', $info);

            //获取医院信息
            $hid = $info['hid'];
            $hinfo = array();
            if(is_file($j_path.'hospital/'.$hid."/baseinfo")){
                $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid."/baseinfo"), true);
            }
            $order_item['hname'] = getItem("name", $hinfo);
            $order_item['hid'] = $hid;
        }else{
            $order_item['simg'] = "";
            $order_item['dj'] = "";
            $order_item['name'] = "";
            $order_item['fname'] = "";
            $order_item['hname'] = "";
            $order_item['hid'] = 0;
        }

        $sql = "select tel from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        $order_item['tel'] = $uinfo['tel'];

        if($order_item['create_time']){
            $order_item['create_time'] = date("Y-m-d H:i", $order_item['create_time']);
        }else{
            $order_item['create_time'] = date("Y-m-d H:i", $order_item['intime']);
        }
    }
}else{
    $order_list = array();
}

unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
$return_list['data'] = json_encode($order_list);
toExit(0, $return_list);

?>
