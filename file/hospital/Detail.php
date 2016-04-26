<?php
/**
 * 医院详情
 * 接口参数: 8段 * 医院id
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

//验证医院id
$hid = intval(trim($reqlist[8]));
if(!($hid > 0 && $hid < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$item_path = $j_path.'hospital/'.$hid;
if(!is_file($item_path.'/baseinfo')){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

$hinfo = json_decode(file_get_contents($item_path.'/baseinfo'), true);
$r_data['id'] = $hid;
$r_data['name'] = getItem("name", $hinfo);
$r_data['logo'] = $s_url.getItem('logo', $hinfo);

$intro = file_get_contents($item_path.'/intro');
if($intro){
    $r_data['intro'] = $intro;
}else{
    $r_data['intro'] = "";
}

$xc_img = array();
if(is_file($item_path.'/xcimg')){
    $xc_img = json_decode(file_get_contents($item_path.'/xcimg'), true);
    foreach($xc_img as &$xc_item){
        $xc_item = $s_url.$xc_item;
    }
}
$r_data['xcimg'] = $xc_img;

$al_img = array();
if(is_file($item_path.'/alimg')){
    $al_img = json_decode(file_get_contents($item_path.'/alimg'), true);
    foreach($al_img as &$al_item){
        $al_item = $s_url.$al_item;
    }
}
$r_data['alimg'] = $al_img;

$return_list['data'] = json_encode($r_data);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);


?>
