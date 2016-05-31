<?php
/**
 * 项目大全
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

$list_filename = $j_path.'project/total';
        
if(is_file($list_filename)){
    $list = json_decode(file_get_contents($list_filename), true);
    if(count($list) > 0){
        foreach($list as &$p_item){
            $p_item['icon'] = $s_url.$p_item['icon'];
        }
    }
}else{
    $list = array();
}

$return_list['data'] = json_encode($list);
unLock($dev_path.'lock');
toExit(0, $return_list, false);

?>
