<?php
/**
 * 特惠列表(主题活动的)
 * 接口参数: 8段 * 医院id * 项目id * 页码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证医院id
$hid = intval(trim($reqlist[8]));
if(!($hid >= 0 && $hid < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证项目id
$pid = intval(trim($reqlist[9]));
if(!($pid >= 0 && $pid < 4294967296)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

if($hid == 0 && $pid == 0){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

$page = intval(trim($reqlist[10]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
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

if($hid != 0){
    if(is_file($j_path.'tehui/hospital/'.$hid.'/'.$page)){
        $list = json_decode(file_get_contents($j_path.'tehui/hospital/'.$hid.'/'.$page), true);
    }else{
        $list = array();
    }
}
else{
    if(is_file($j_path.'tehui/project/'.$pid.'/'.$page)){
        $list = json_decode(file_get_contents($j_path.'tehui/project/'.$pid.'/'.$page), true);
    }else{
        $list = array();
    }
}

foreach($list as &$id_item){
    $id = $id_item['id'];
    $filename = $j_path.'tehui/item/'.$id.'/baseinfo';
    $info = array();
    if(is_file($filename)){
        $info = json_decode(file_get_contents($filename), true);
    }
    
    $id_item['name'] = getItem('name', $info);
    $id_item['fname'] = getItem('fname', $info);
    $id_item['oldval'] = getItem('oldval', $info);
    $id_item['newval'] = getItem('newval', $info);
    $id_item['simg'] = $s_url.getItem('simg', $info);

    $count = dbCount("qm_yuyue", $con, 'tid = '.$id);
    $id_item['sellout'] = $count;

    //获取医院名
    $hid = $info['hid'];
    $hinfo = array();
    if(is_file($j_path.'hospital/'.$hid.'/baseinfo')){
        $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid.'/baseinfo'), true);
    }
    $id_item['hname'] = getItem('name', $hinfo);
}

$return_list['data'] = json_encode($list);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
