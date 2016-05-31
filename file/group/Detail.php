<?php
/**
 * 小组详情
 * 接口参数: 8段 * 小组id * userid
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 10)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证gid
$gid = intval(trim($reqlist[8]));
if(!($gid > 0 && $gid < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[9]));
if(!($userid == 0 || ($userid >= 100000 && $userid <= 999999999))){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if($userid != 0){
    if(!is_dir($user_path)){
        unLock($dev_path.'lock');
        toExit(12, $return_list);
    }
    if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
        unLock($dev_path.'lock');
        toExit(12, $return_list);
    }
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

//获取详情数组
$info = array();
$filename = $j_path.'group/'.$gid.'/baseinfo';
if(is_file($filename)){
    $baseinfo = json_decode(file_get_contents($filename), true);
}else{
    $baseinfo = array();
}
$baseinfo['icon'] = $s_url.$baseinfo['icon'];

//小组人数
$count = dbCount("qm_group_user", $con, "gid = $gid");
$baseinfo['amount'] = $count;

//小组标签
$filename = $j_path.'group/'.$gid.'/tag';
$tag_list = array();
if(is_file($filename)){
    $tag_list = json_decode(file_get_contents($filename), true);
}
$baseinfo['tag'] = $tag_list;

//判断用户是否已加入小组
$intag = 0;  //默认，未加入
if($userid > 0){
    $count = dbCount("qm_group_user", $con, "gid = $gid and userid = $userid");
    if($count > 0){
        $intag = 1;
    }
}
$baseinfo['isin'] = $intag;
$baseinfo['ht'] = array();

$return_list['data'] = json_encode($baseinfo);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
