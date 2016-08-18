<?php
/**
 * 教师列表
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

$filename = $j_path.'teacher/list';
if(is_file($filename)){
    $list = json_decode(file_get_contents($filename), true);
    foreach($list as &$item){
        $item['logo'] = $s_url.getItem('logo', $item);
    }
}
else{
    $list = array();
}

$return_list['data'] = json_encode($list);
unLock($dev_path.'lock');
toExit(0, $return_list, false);

?>
