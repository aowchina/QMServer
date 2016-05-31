<?php
/**
 * 文章评论
 * 接口参数: 8段 * userid * 被评论者userid * 文章id * 父评论id * 评论内容
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");
include_once("../Jpush.php");

//验证参数个数
if(!(count($reqlist) == 13)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证被评论者userid
$b_userid = intval(trim($reqlist[9]));
if($b_userid != 0){
    if($b_userid == $userid){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        toExit(12, $return_list);
    }

    $b_user_path = $j_path.'user/'.getSubPath($b_userid, 4, true);
    if(!is_dir($b_user_path)){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        toExit(12, $return_list);
    }
}

//验证文章id
$wid = intval(trim($reqlist[10]));
if($wid < 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(13, $return_list);
}

//验证父级评论id
$parentid = intval(trim($reqlist[11]));
if($parentid < 0){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(14, $return_list);
}

//验证评论内容
$text = getStrFromByte(trim($reqlist[12]));
if($text == '' || $text == null){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(15, $return_list);
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

//检查用户是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and status = 1 and deviceid = '$deviceid'");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(16, $return_list);
}

//验证文章id是否存在
$count = dbCount("qm_wenzhang", $con, "id = $wid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(17, $return_list);
}

//验证被评论者userid是否存在
if($b_userid != 0){
    $count = dbCount("qm_wenzhang_pl", $con, "userid = $b_userid and wid = $wid");
    if($count < 1){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(18, $return_list);
    }
}

//验证父级评论id是否存在
if($parentid != 0){
    $count = dbCount("qm_wenzhang_pl", $con, "id = $parentid and parentid = 0");
    if($count != 1){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(19, $return_list);
    }
}

//锁评论表
$db_lockname = $j_path.'dblock/qm_wenzhang_pl';
if(!lockDb($db_lockname)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(20, $return_list);
}

$data['userid'] = $userid;
$data['userid2'] = $b_userid;
$data['parentid'] = $parentid;
$data['wid'] = $wid;
$data['intime'] = time();

if(dbAdd($data, "qm_wenzhang_pl", $con)){
    $item_repath = date("Y", $data['intime']).'/'.date("m", $data['intime']).'/'.date("d", $data['intime']).
        '/'.$data['intime'];
        
    $item_path = $j_path.'pl/'.$item_repath;
    mkdirs($item_path);
    file_put_contents($item_path.'/text', $text);

    //给被评论者推送消息
    if($b_userid != 0){
        $sql = "select deviceid from qm_users_login where userid = $b_userid and status = 1";
        $dinfo = dbLoad(dbQuery($sql, $con), true);
        if($dinfo['deviceid']){
            $jpush_filename = $j_path.'device/'.getSubPath($dinfo['deviceid'], 4, true)."jpush";
            if(is_file($jpush_filename)){
                $jpushid = file_get_contents($jpush_filename);
                if($jpushid){
                    $jp = new Jpush();
                    $jp->push(array('registration_id'=>array($jpushid)), '您收到一条回复~');
                }
            }
        }
    }else{
        $sql = "select userid from qm_wenzhang where id = $wid";
        $winfo = dbLoad(dbQuery($sql, $con), true);
        $b_userid = $winfo['userid'];

        $sql = "select deviceid from qm_users_login where userid = $b_userid and status = 1";
        $dinfo = dbLoad(dbQuery($sql, $con), true);
        if($dinfo['deviceid']){
            $jpush_filename = $j_path.'device/'.getSubPath($dinfo['deviceid'], 4, true)."jpush";
            if(is_file($jpush_filename)){
                $jpushid = file_get_contents($jpush_filename);
                if($jpushid){
                    $jp = new Jpush();
                    $jp->push(array('registration_id'=>array($jpushid)), '您收到一条回复~');
                }
            }
        }
    }

    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    unLock($db_lockname);
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    unLock($db_lockname);
    closeDb($con);
    toExit(302, $return_list);
}

?>
