<?php
/**
 * 项目详情
 * 接口参数: 8段 * 项目id
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 9)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证id
$id = intval(trim($reqlist[8]));
if(!($id > 0 && $id < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//获取详情数组
$info = array();
$filename = $j_path.'project/item/'.$id.'/baseinfo';
if(is_file($filename)){
    $info = json_decode(file_get_contents($filename), true);
}
$r_data['baseinfo'] = $info;

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

//获取产品
$filename = $j_path.'tehui/project/'.$id.'/1';
if(is_file($filename)){
    $goods_list = json_decode(file_get_contents($filename), true);
}else{
    $goods_list = array();
}

foreach($goods_list as &$goods_item){
    $id = $goods_item['id'];
    $filename = $j_path.'tehui/item/'.$id.'/baseinfo';
    $info = array();
    if(is_file($filename)){
        $info = json_decode(file_get_contents($filename), true);
    }
    
    $goods_item['name'] = getItem('name', $info);
    $goods_item['fname'] = getItem('fname', $info);
    $goods_item['oldval'] = getItem('oldval', $info);
    $goods_item['newval'] = getItem('newval', $info);
    $goods_item['simg'] = $s_url.getItem('simg', $info);

    $count = dbCount("qm_yuyue", $con, 'tid = '.$id.' and status = 2');
    $goods_item['sellout'] = $count;

    //获取医院名
    $hid = $info['hid'];
    $hinfo = array();
    if(is_file($j_path.'hospital/'.$hid.'/baseinfo')){
    	$hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid.'/baseinfo'), true);
    }
    $goods_item['hname'] = getItem('name', $hinfo);
}
$r_data['goods'] = $goods_list;

$return_list['data'] = json_encode($r_data);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
