<?php
/**
 * 文章的评论列表
 * 接口参数: 8段 * userid * 文章id * 页码
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

//验证文章id
$wid = intval(trim($reqlist[9]));
if($wid < 0){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(12, $return_list);
}

//验证页码
$page = intval(trim($reqlist[10]));
if($page < 1){
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

//验证文章id是否存在
$count = dbCount("qm_wenzhang", $con, "id = $wid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}

//获取评论数据
$limit = (($page - 1)*10).',10';
$sql = "select id,userid,intime from qm_wenzhang_pl where wid = $wid and parentid = 0 order by intime desc limit $limit";
$pl_list = dbLoad(dbQuery($sql, $con));

$r_list = array();
if(count($pl_list) > 0){
    foreach($pl_list as $pl_item){
        $r_item = array();

        //评论者信息
        $pl_userid = $pl_item['userid'];
        $sql = "select username,img from qm_users_common where userid = $pl_userid";
        $pl_userinfo = dbLoad(dbQuery($sql, $con), true);

        $r_item['userid'] = $pl_userid;
        $r_item['username'] = getStrFromByte($pl_userinfo['username']);
        $r_item['userimg'] = getItem("img", $pl_userinfo);
        $r_item['pubtime'] = getShowTime($pl_item['intime']);

        //评论内容
        $pl_item_repath = date("Y", $pl_item['intime']).'/'.date("m", $pl_item['intime']).'/'.date("d", $pl_item['intime']).
            '/'.$pl_item['intime'];

        $pl_itempath = $j_path."pl/".$pl_item_repath;
        $text = "";
        if(is_file($pl_itempath.'/text')){
            $text = file_get_contents($pl_itempath.'/text');
        }
        $r_item['text'] = $text;

        //回复数
        $parentid = $pl_item['id'];
        $count_hf = dbCount("qm_wenzhang_pl", $con, "wid = $wid and parentid = $parentid");
        $hf_more = 0;
        if($count_hf > 5){
            $hf_more = $count_hf - 5;
        }
        $r_item['more_hf'] = $hf_more;

        //回复记录
        $hf_list = array();
        if($count_hf > 0){
            $sql = "select userid,userid2,intime from qm_wenzhang_pl where wid = $wid and parentid = $parentid 
                order by intime desc limit 5";
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

                $hf_item['wid'] = $wid;
                $hf_item['id'] = $parentid;
                $hf_list[] = $hf_item;
            }
        }
        $r_item['son'] = $hf_list;

        //是否点过赞
        $count = dbCount("qm_zan", $con, "zanid = $parentid and userid = $userid and type = 2");
        if($count > 0){
            $r_item['status'] = 1;
        }else{
            $r_item['status'] = 0;
        }

        $r_item['id'] = $parentid;
        $r_item['wid'] = $wid;
        $r_list[] = $r_item;
    }
}

$return_list['data'] = json_encode($r_list);
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
