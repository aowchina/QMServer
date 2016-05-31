<?php
/**
 * 筛选特惠/文章
 * 接口参数: 8段 * userid * 筛选的字符串 * type * 页码
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 12)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证筛选字符串
$str = getStrFromByte(trim($reqlist[9]));
if(empty($str)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证type
$type = intval(trim($reqlist[10]));
if(!($type == 1 || $type == 2)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证页码
$page = intval(trim($reqlist[11]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
}
//userid打锁
$user_repath = getSubPath($userid, 4, true);
$user_path = $j_path.'user/'.$user_repath;
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(14, $return_list);
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
$condition = mysql_real_escape_string($str, $con);

$limit = (($page - 1)*10).',10';
$condition_rj = "title like '%".$condition."%' and type = $type";
$count = dbCount("qm_wenzhang", $con, $condition_rj);
$r_data['rj_amount'] = $count;

$rj_list = array();
if($count > 0){
    $sql = "select id,title,type,isjing,gid,ctime,userid from qm_wenzhang where $condition_rj 
        order by ctime desc limit $limit";
    $rj_list = dbLoad(dbQuery($sql, $con));
    foreach($rj_list as &$rj_item){
        //小组名
        $gid = $rj_item['gid'];
        $sql = "select name from qm_group where id = $gid";
        $ginfo = dbLoad(dbQuery($sql, $con), true);
        $rj_item['groupname'] = $ginfo['name'];

        //发布者信息
        $userid = $rj_item['userid'];
        $sql = "select username,img from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        $rj_item['username'] = getStrFromByte($uinfo['username']);
        $rj_item['userimg'] = $uinfo['img'];

        //发布时间
        $now_time = time();
        $cha_time = $now_time - $rj_item['ctime'];
        if($cha_time < 60){
            $rj_item['pubtime'] = "刚刚";
        }
        elseif($cha_time < 3600){
            $rj_item['pubtime'] = floor($cha_time / 60)."分钟前";
        }
        elseif($cha_time < (3600 * 24)){
            $rj_item['pubtime'] = floor($cha_time / 3600)."小时前";
        }
        elseif($cha_time < (3600 * 24 * 30)){
            $rj_item['pubtime'] = floor($cha_time / (3600 * 24))."天前";
        }
        else{
            $rj_item['pubtime'] = '一个月前';
        }

        //点赞数
        $rj_item['zan'] = dbCount("qm_zan", $con, "type = 1 and zanid = ".$rj_item['id']);
        
        //评论数
        $rj_item['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = ".$rj_item['id']);

        $rj_item_path = $s_path.'files/wenzhang/'.date("Y", $rj_item['ctime']).'/'.date("m", $rj_item['ctime']).
            '/'.date("d", $rj_item['ctime']).'/'.$rj_item['ctime'];

        if($rj_item['type'] == 1){
            if(is_file($rj_item_path.'/img')){
                $imglist = json_decode(file_get_contents($rj_item_path.'/img'), true);
            }else{
                $imglist = array();
            }
            $rj_item['imgs'] = $imglist;
            $rj_item['text'] = '';
        }else{
            if(is_file($rj_item_path.'/text')){
                $text = file_get_contents($rj_item_path.'/text');
            }else{
                $text = '';
            }
            $rj_item['imgs'] = array();
            $rj_item['text'] = mb_substr($text, 0, 20, 'utf-8');
        }
    }
}

$return_list['data'] = json_encode($rj_list);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
