<?php
/**
 * 积分记录列表
 * 接口参数: 8段 * userid * 页码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

$weekarray=array("日","一","二","三","四","五","六");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证页码
$page = intval(trim($reqlist[9]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
//userid打锁
$user_repath = getSubPath($userid, 4, true);
$user_path = $j_path.'user/'.$user_repath;
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//连接db
$con = conDb();
if($con == ''){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(301, $return_list);
}

//获取
$limit = (($page - 1)*10).',10';
$sql = "select * from qm_point_record where userid = $userid order by ctime desc limit $limit";

$list = dbLoad(dbQuery($sql, $con));
if(count($list) > 0){
    foreach($list as &$item){
        $item['week'] = '星期'.$weekarray[date('w', $item['ctime'])];
        $item['year'] = date("Y", $item['ctime']);
        $item['month'] = date("m", $item['ctime']);
        $item['day'] = date("d", $item['ctime']);
    }
}else{
    $list = array();
}

//计算总分
$sql = "select sum(point) from qm_point_record where userid = ".$userid." and status = 1";
$result = dbLoad(dbQuery($sql, $con), true);
$get_point = $result['sum(point)'];
if(!$get_point){
    $get_point = '0.00';
}

$sql = "select sum(point) from qm_point_record where userid = ".$userid." and status = 2";
$result = dbLoad(dbQuery($sql, $con), true);
$out_point = $result['sum(point)'];
if(!$get_point){
    $get_point = '0.00';
}

$point = $get_point - $out_point;

$r_data['point'] = $point;
$r_data['list'] = $list;

$return_list['data'] = json_encode($r_data);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
