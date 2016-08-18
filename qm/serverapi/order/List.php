<?php
/**
 * 绑定的订单列表
 * 接口参数: 8段 * userid * 页码
 * author wangrui@min-fo.com
 */

include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 1 && $userid <= 999999999)){
    forExit($lock_array);
    toExit(10, $return_list);
}

$page = intval(trim($reqlist[9]));
if($page < 1){
    forExit($lock_array);
    toExit(11, $return_list);
}

//连接db
$con = conDb();
if($con == ''){
    forExit($lock_array);
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    forExit($lock_array, $con);
    toExit(301, $return_list);
}

//检查用户是否存在
$count = dbCount("qm_users", $con, "id = $userid");
if($count != 1){
    forExit($lock_array, $con);
    toExit(12, $return_list);
}

$sql = "select group_id from qm_user_usergroup_map where user_id = $userid";
$re = dbLoad(dbQuery($sql, $con), true);
$group_id = $re['group_id'];
if($group_id != 7){
    forExit($lock_array, $con);
    toExit(13, $return_list);
}

$limit = (($page - 1)*10).',10';

$sql = "select tid,orderid,intime,create_time,userid from qm_yuyue where server_id = $userid order by intime desc limit $limit";

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

forExit($lock_array, $con);
$return_list['data'] = json_encode($order_list);
toExit(0, $return_list);

?>
