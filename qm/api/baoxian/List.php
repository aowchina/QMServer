<?php
/**
 * 保险列表
 * 接口参数: 8段
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");

//验证参数个数
if(!(count($reqlist) == 8)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

$filename = $j_path.'baoxian/list';
if(is_file($filename)){
    $list = json_decode(file_get_contents($filename), true);
    foreach($list as &$item){
        $item['img'] = $s_url.getItem('img', $item);
    }
}
else{
    $list = array();
}

$return_list['data'] = json_encode($list[0]);
unLock($dev_path.'lock');
toExit(0, $return_list, false);

?>
