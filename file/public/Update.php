<?php
/**
 * 获取应用版本信息
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

if(!is_file($j_path.'xml/quanmei')){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$return_list['data'] = file_get_contents($j_path.'xml/quanmei');

unLock($dev_path.'lock');
toExit(0, $return_list);

?>
