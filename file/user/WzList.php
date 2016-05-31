<?php
/**
 * 我的日记/帖子列表
 * 接口参数: 8段 * userid * type * 页码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 11)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证type
$type = intval(trim($reqlist[9]));
if(!($type == 1 || $type == 2)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证页码
$page = intval(trim($reqlist[10]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}
//userid打锁
$user_repath = getSubPath($userid, 4, true);
$user_path = $j_path.'user/'.$user_repath;
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
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

//获取日记数据
$limit = (($page - 1)*10).',10';
$sql = "select id,title,type,isjing,gid,ctime,userid from qm_wenzhang where type = $type and userid = $userid 
    order by ctime desc limit $limit";

$wz_list = dbLoad(dbQuery($sql, $con));
if(count($wz_list) > 0){
    $sql = "select username,img from qm_users_common where userid = $userid";
    $uinfo = dbLoad(dbQuery($sql, $con), true);

    foreach($wz_list as &$wz_item){
        //发布者信息
        $wz_item['username'] = getStrFromByte($uinfo['username']);
        $wz_item['userimg'] = $uinfo['img'];

        //发布时间
        $now_time = time();
        $cha_time = $now_time - $wz_item['ctime'];
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

        $wz_item_path = $s_path.'files/wenzhang/'.date("Y", $wz_item['ctime']).'/'.date("m", $wz_item['ctime']).
            '/'.date("d", $wz_item['ctime']).'/'.$wz_item['ctime'];

        if($type == 1){
            if(is_file($wz_item_path.'/img')){
                $imglist = json_decode(file_get_contents($wz_item_path.'/img'), true);
            }else{
                $imglist = array();
            }
            $wz_item['imgs'] = $imglist;
            $wz_item['text'] = '';
        }else{
            if(is_file($wz_item_path.'/text')){
                $text = file_get_contents($wz_item_path.'/text');
            }else{
                $text = '';
            }
            $wz_item['imgs'] = array();
            $wz_item['text'] = mb_substr($text, 0, 20, 'utf-8');
        }
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
