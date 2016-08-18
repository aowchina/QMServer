<?php
/**
 * 首页
 * 接口参数: 8段
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");
$redis = new Redis();
$redis->connect('139.196.172.208',6379);

//验证参数个数
if(!(count($reqlist) == 8)){
    toExit(6, $return_list);
}

$securityDeposit = $redis->get('securityDeposit');

$r_list['securityDeposit'] = $securityDeposit;
$return_list['data'] = json_encode($r_list);
toExit(0, $return_list, false);

?>
