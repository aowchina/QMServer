<?php
/**
 * 医院医生
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

$did_list = array();
$filename = $item_path.'/doctor';
if(is_file($filename)){
    $did_list = json_decode(file_get_contents($filename), true);

    foreach($did_list as &$did_item){
        $did = $did_item['id'];
        $filename2 = $j_path.'doctor/'.$did;
        if(is_file($filename2)){
            $d_info = json_decode(file_get_contents($filename2), true);
            $did_item['name'] = $d_info['name'];
            $did_item['direction'] = $d_info['direction'];
            $did_item['img'] = $s_url.$d_info['img'];
            $did_item['pos'] = $d_info['pos'];
            $did_item['intro'] = $d_info['intro'];
        }else{
            $did_item['name'] = '';
            $did_item['direction'] = '';
            $did_item['img'] = '';
            $did_item['pos'] = '';
            $did_item['intro'] = '';
        }
    }
}
$r_data['doctor'] = $did_list;

$return_list['data'] = json_encode($r_data);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);


?>
