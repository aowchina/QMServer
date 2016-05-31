<?php
/**
 * 文章详情
 * 接口参数: 8段 * ctime * userid
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

//验证ctime
$ctime = intval(trim($reqlist[8]));
if($ctime >= time() || $ctime <= 1443628800){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[9]));
if(!(($userid >= 100000 && $userid <= 999999999) || $userid == 0)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//userid打锁
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

$item_repath = date("Y", $ctime).'/'.date("m", $ctime).'/'.date("d", $ctime).'/'.$ctime;
$filename = $s_path.'files/wenzhang/'.$item_repath.'/baseinfo';
if(is_file($filename)){
    $info = json_decode(file_get_contents($filename), true);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(13, $return_list);
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

//获取发布者信息
$pubuserid = $info['userid'];
$sql = "select username,img from qm_users_common where userid = $pubuserid";
$uinfo = dbLoad(dbQuery($sql, $con), true);
$info['username'] = getStrFromByte($uinfo['username']);
$info['userimg'] = $uinfo['img'];
$info['pubtime'] = date("Y-m-d", $ctime);

//获取文字内容
$text = "";
if(is_file($s_path.'files/wenzhang/'.$item_repath.'/text')){
    $text = file_get_contents($s_path.'files/wenzhang/'.$item_repath.'/text');
}
$info['text'] = $text;

//获取图片内容
$imgs = array();
if(is_file($s_path.'files/wenzhang/'.$item_repath.'/img')){
    $imgs = json_decode(file_get_contents($s_path.'files/wenzhang/'.$item_repath.'/img'), true);
}
$info['imgs'] = $imgs;

//获取文章是否已被该用户点过赞
if($userid == 0){
    $info['iszan'] = 0;
}else{
    $count = dbCount("qm_zan", $con, "userid = $userid and type = 1 and zanid = ".$info['id']);
    if($count > 0){
        $info['iszan'] = 1;
    }else{
        $info['iszan'] = 0;
    }
}

//获取评论数据
$sql = "select id,userid from qm_zan where type = 1 and zanid = ".$info['id']." group by userid order by intime desc limit 5";
$pl_list = dbLoad(dbQuery($sql, $con));

$r_list = array();
if(count($pl_list) > 0){
    foreach($pl_list as $pl_item){
        $r_item = array();

        //评论者信息
        $pl_userid = $pl_item['userid'];
        $sql = "select img from qm_users_common where userid = $pl_userid";
        $pl_userinfo = dbLoad(dbQuery($sql, $con), true);

        $r_item['userid'] = $pl_userid;
        $r_item['userimg'] = getItem("img", $pl_userinfo);
        $r_list[] = $r_item;
    }
}
$info['pluser'] = $r_list;

//获取点赞数
$count = dbCount("qm_zan", $con, "type = 1 and zanid = ".$info['id']);
$info['zan'] = $count;

$return_list['data'] = json_encode($info);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);


?>
