<?php
/**
 * 小组列表
 * 接口参数: 8段
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 8)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

$list_filename = $j_path.'group/list';
$id_list = array();
if(is_file($list_filename)){
    $id_list = json_decode(file_get_contents($list_filename), true);
}

if(count($id_list) > 0){
    foreach($id_list as &$id_item){
        $gid = $id_item['id'];
        $filename = $j_path.'group/'.$gid.'/baseinfo';
        if(is_file($filename)){
            $info = json_decode(file_get_contents($filename), true);
        }else{
            $info = array();
        }

        $id_item['name'] = getItem('name', $info);
        $id_item['icon'] = $s_url.getItem('icon', $info);
    }
}

$return_list['data'] = json_encode($id_list);
unLock($dev_path.'lock');
toExit(0, $return_list, false);

?>
