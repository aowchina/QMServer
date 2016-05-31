<?php
/**
 * 订单传图
 * 接口参数: 8段 * userid * orderid
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

$orderid = trim($reqlist[9]);
if(!preg_match("/^(quanmei)[0-9]{14}$/", $orderid)){
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

//是否存在
$count = dbCount("qm_yuyue", $con, "orderid = '$orderid'");
if($count != 1){
    forExit($lock_array, $con);
    toExit(14, $return_list);
}

$sql = "select * from qm_yuyue where orderid = '$orderid'";
$oinfo = dbLoad(dbQuery($sql, $con), true);

if($oinfo['status'] != 5){
    forExit($lock_array, $con);
    toExit(15, $return_list);
}

if($oinfo['server_id'] != $userid){
    forExit($lock_array, $con);
    toExit(16, $return_list);
}

$img_amount = count($_FILES);
if($img_amount <= 0 || $img_amount > 9){
    forExit($lock_array, $con);
    toExit(17, $return_list);
}

$img_path = $s_path.'images/order/'.$orderid;
mkdirs($img_path);

//文件上传
$img_array = array();
for($i = 0; $i < $img_amount; $i++){
    $up_filename = trim($_FILES['img'.$i]['name']);
    $img_suffix = getImgType($up_filename);  //图片后缀
    $new_filename = ($i + 1).".".$img_suffix;
    
    move_uploaded_file($_FILES['img'.$i]['tmp_name'], $img_path.'/'.$new_filename);
    $img_array[] = 'images/order/'.$orderid.'/'.$new_filename;
}

$data = array();
$data['detail_img'] = json_encode($img_array);
$data['status'] = 6;

if(!dbUpdate($data, 'qm_yuyue', $con, "orderid = '$orderid'")){
    forExit($lock_array, $con);
    toExit(302, $return_list);
}

forExit($lock_array, $con);
toExit(0, $return_list);

?>
