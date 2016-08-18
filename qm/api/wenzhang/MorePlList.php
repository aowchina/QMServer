<?php
/**
 * 评论的回复列表
 * 接口参数: 8段 * userid * 评论id
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

//验证评论id
$plid = intval(trim($reqlist[9]));
if($plid < 0){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(10, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
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

//验证评论id是否存在
$count = dbCount("qm_wenzhang_pl", $con, "id = $plid and parentid = 0");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(13, $return_list);
}

//获取评论数据
$sql = "select userid,intime from qm_wenzhang_pl where id = $plid";
$pl_info = dbLoad(dbQuery($sql, $con), true);

//评论者信息
$pl_userid = $pl_info['userid'];
$sql = "select username,img from qm_users_common where userid = $pl_userid";
$pl_userinfo = dbLoad(dbQuery($sql, $con), true);

$pl_info['username'] = getStrFromByte($pl_userinfo['username']);
$pl_info['userimg'] = getItem("img", $pl_userinfo);
$pl_info['pubtime'] = getShowTime($pl_info['intime']);

//评论内容
$pl_item_repath = date("Y", $pl_info['intime']).'/'.date("m", $pl_info['intime']).'/'.date("d", $pl_info['intime']).
    '/'.$pl_info['intime'];

$pl_itempath = $j_path."pl/".$pl_item_repath;
$text = "";
if(is_file($pl_itempath.'/text')){
    $text = file_get_contents($pl_itempath.'/text');
}
$pl_info['text'] = $text;

//回复记录
$count_hf = dbCount("qm_wenzhang_pl", $con, "parentid = $plid");

$hf_list = array();
if($count_hf > 0){
    $sql = "select wid,userid,userid2,intime from qm_wenzhang_pl where parentid = $plid order by intime desc";
    $son_list = dbLoad(dbQuery($sql, $con));

    foreach($son_list as $son_item){
        $hf_item = array();
        $hf_item['userid'] = $son_item['userid'];
        $hf_item['userid2'] = $son_item['userid2'];

        $sql = "select username from qm_users_common where userid = ".$hf_item['userid'];
        $u_info = dbLoad(dbQuery($sql, $con), true);
        $hf_item['username'] = getStrFromByte($u_info['username']);

        if($hf_item['userid2'] != 0){
            $sql = "select username from qm_users_common where userid = ".$hf_item['userid2'];
            $u_info = dbLoad(dbQuery($sql, $con), true);
            $hf_item['username2'] = getStrFromByte($u_info['username']);
        }else{
            $hf_item['username2'] = "";
        }
        
        $hf_item['pubtime'] = getShowTime($son_item['intime']);

        //评论内容
        $pl_item_repath = date("Y", $son_item['intime']).'/'.date("m", $son_item['intime']).
            '/'.date("d", $son_item['intime']).'/'.$son_item['intime'];

        $pl_itempath = $j_path."pl/".$pl_item_repath;
        $text = "";
        if(is_file($pl_itempath.'/text')){
            $text = file_get_contents($pl_itempath.'/text');
        }
        $hf_item['text'] = $text;

        $hf_item['wid'] = $son_item['wid'];
        $hf_item['id'] = $plid;
        $hf_list[] = $hf_item;
    }
}
$pl_info['son'] = $hf_list;

//是否点过赞
$count = dbCount("qm_zan", $con, "zanid = $plid and userid = $userid and type = 2");
if($count > 0){
    $pl_info['status'] = 1;
}else{
    $pl_info['status'] = 0;
}

$pl_info['id'] = $plid;

$return_list['data'] = json_encode($pl_info);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

function getShowTime($intime){
    $now_time = time();
    $cha_time = $now_time - $intime;
    if($cha_time < 60){
        $return_time = "刚刚";
    }
    elseif($cha_time < 3600){
        $return_time = floor($cha_time / 60)."分钟前";
    }
    elseif($cha_time < (3600 * 24)){
        $return_time = floor($cha_time / 3600)."小时前";
    }
    elseif($cha_time < (3600 * 24 * 30)){
        $return_time = floor($cha_time / (3600 * 24))."天前";
    }
    else{
        $return_time = '一个月前';
    }

    return $return_time;
}

?>
