<?php
/**
 * 我的被回复列表
 * 接口参数: 8段 * userid * 页码
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

//获取回复数据
$limit = (($page - 1)*10).',10';
$sql = "select id,userid,userid2,intime,parentid,wid from qm_wenzhang_pl where userid2 = $userid 
    or (wid in (select id from qm_wenzhang where userid = $userid) and userid2 = 0)order by intime desc limit $limit";

$wz_list = dbLoad(dbQuery($sql, $con));
if(count($wz_list) > 0){
    
    foreach($wz_list as &$wz_item){
        $sql = "select username,img from qm_users_common where userid = ".$wz_item['userid'];
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        //发布者信息
        $wz_item['username'] = getStrFromByte($uinfo['username']);
        $wz_item['userimg'] = $uinfo['img'];

        //发布时间
        $now_time = time();
        $cha_time = $now_time - $wz_item['intime'];
        if($cha_time < 60){
            $wz_item['pubtime'] = "刚刚";
        }
        elseif($cha_time < 3600){
            $wz_item['pubtime'] = floor($cha_time / 60)."分钟前";
        }
        elseif($cha_time < (3600 * 24)){
            $wz_item['pubtime'] = floor($cha_time / 3600)."小时前";
        }
        elseif($cha_time < (3600 * 24 * 30)){
            $wz_item['pubtime'] = floor($cha_time / (3600 * 24))."天前";
        }
        else{
            $wz_item['pubtime'] = '一个月前';
        }

        //获取回复内容
        $wz_itempath = $j_path.'pl/'.date("Y", $wz_item['intime']).'/'.
            date("m", $wz_item['intime']).'/'.date('d', $wz_item['intime']).'/'.$wz_item['intime'];

        if(is_file($wz_itempath.'/text')){
            $text = file_get_contents($wz_itempath.'/text');
        }else{
            $text = '';
        }
        $wz_item['text'] = $text;

        //获取被回复内容
        if($wz_item['parentid'] != 0){
            $sql = "select intime from qm_wenzhang_pl where id = ".$wz_item['parentid'];
            $plinfo = dbLoad(dbQuery($sql, $con), true);
            $pl_itempath = $j_path.'pl/'.date("Y", $plinfo['intime']).'/'.
                date("m", $plinfo['intime']).'/'.date('d', $plinfo['intime']).'/'.$plinfo['intime'];
            if(is_file($pl_itempath.'/text')){
                $text = file_get_contents($pl_itempath.'/text');
            }else{
                $text = '';
            }
            $wz_item['text2'] = $text;
        }else{
            $sql = "select title from qm_wenzhang where id = ".$wz_item['wid'];
            $wlinfo = dbLoad(dbQuery($sql, $con), true);
            $wz_item['text2'] = $wlinfo['title'];
        }

        $sql = "select username from qm_users_common where userid = ".$wz_item['userid2'];
        $uinfo2 = dbLoad(dbQuery($sql, $con), true);

        $wz_item['username2'] = getStrFromByte($uinfo2['username']);
    }
}else{
    $wz_list = array();
}

$return_list['data'] = json_encode($wz_list);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
