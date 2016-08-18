<?php
/**
 * 预订
 * 接口参数: 8段 * userid * tid
 * author wangrui@min-fo.com
 */
include_once("/data/pubout/minfo/service_minfo/quanmei/api/one/functions_mdb.php");

//连接db
$con = conDb();
if($con == ''){
    exit;
}

//检查连接数
if(!checkDbCon($con)){
    exit;
}

$now_time = time();

$sql = "delete from qm_yuyue where ($now_time - intime) >= 1800 and status = 1";
dbQuery($sql, $con);
closeDb($con);
exit;

?>
