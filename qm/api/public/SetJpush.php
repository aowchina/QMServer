<?php
/**
 * 记录极光ID
 * 接口参数: 8段 * jpushid
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");

//验证参数个数
if(!(count($reqlist) == 9)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证极光ID
$jpushid = trim($reqlist[8]);
if(!preg_match("/^[0-9a-zA-Z]+$/", $jpushid)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

if(!file_put_contents($dev_path.'jpush', $jpushid)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

unLock($dev_path.'lock');
toExit(0, $return_list);

?>
