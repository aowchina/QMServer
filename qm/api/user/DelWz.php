<?php
/**
 * 删除文章
 * 接口参数: 8段 * userid * 文章id
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

//验证文章id
$wid = intval(trim($reqlist[9]));
if($wid < 1){
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
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
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

//验证userid是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and deviceid = '".$deviceid."' and status = 1");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

//验证wid是否存在
$count = dbCount("qm_wenzhang", $con, "id = $wid and userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}

//获取ctime
$sql = "select ctime from qm_wenzhang where id = $wid";
$winfo = dbLoad(dbQuery($sql, $con), true);
$ctime = $winfo['ctime'];

if(dbDelete("qm_wenzhang", $con, "id = $wid")){
    
    //删除文章文件
    $wz_itempath = $s_path.'files/wenzhang/'.date("Y", $ctime).'/'.date("m", $ctime).'/'.date('d', $ctime).'/'.$ctime;
    delDirFile($wz_itempath);
    delPath($wz_itempath, 4);

    //删除文章点赞记录
    dbDelete("qm_zan", $con, "zanid = $wid and type = 1");

    //删除文章评论记录
    $sql = "select id,intime from qm_wenzhang_pl where wid = $wid";
    $pl_list = dbLoad(dbQuery($sql, $con));
    foreach($pl_list as $pl_item){
        dbDelete("qm_zan", $con, "type = 2 and zanid = ".$pl_item['id']);
        dbDelete("qm_wenzhang_pl", $con, "wid = $wid");

        $intime = $pl_item['intime'];
        $pl_itempath = $j_path.'pl/'.date("Y", $intime).'/'.date("m", $intime).'/'.date('d', $intime).'/'.$intime;

        delDirFile($pl_itempath);
        delPath($pl_itempath, 4);
    }
    
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(303, $return_list);
}

?>
