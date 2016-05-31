<?php
/**
 * 文章列表
 * 接口参数: 8段 * 操作类型(1是全部，2是精华) * 小组id * 标签id * 页码
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

//验证type
$cz_type = intval(trim($reqlist[8]));
if(!($cz_type == 1 || $cz_type == 2)){
    unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证小组id
$gid = intval(trim($reqlist[9]));
if($gid < 0){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证标签id
$tid = intval(trim($reqlist[10]));
if($tid < 0){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//验证页码
$page = intval(trim($reqlist[11]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
}

//连接db
$con = conDb();
if($con == ''){
    unLock($dev_path.'lock');
    toExit(300, $return_list);
}

//检查连接数
if(!checkDbCon($con)){
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(301, $return_list);
}

//获取日记数据
$where = "isjing = $cz_type";
if($gid > 0){
    $where .= " and gid = ".$gid;
}

if($tid > 0){
    $where .= " and id in (select wid from qm_relation_wt where tid = ".$tid.")";
}

$limit = (($page - 1)*10).',10';
$sql = "select id,title,type,isjing,gid,ctime,userid from qm_wenzhang where $where order by ctime desc limit $limit";
$wz_list = dbLoad(dbQuery($sql, $con));
if(count($wz_list) > 0){
    foreach($wz_list as &$wz_item){
        //小组名
        $gid = $wz_item['gid'];
        $sql = "select name from qm_group where id = $gid";
        $ginfo = dbLoad(dbQuery($sql, $con), true);
        $wz_item['groupname'] = $ginfo['name'];

        //发布者信息
        $userid = $wz_item['userid'];
        $sql = "select username,img from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
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

        //点赞数
        $wz_item['zan'] = dbCount("qm_zan", $con, "zanid = ".$wz_item['id']." and type = 1");
        
        //评论数
        $wz_item['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = ".$wz_item['id']);

        $wz_item_path = $s_path.'files/wenzhang/'.date("Y", $wz_item['ctime']).'/'.date("m", $wz_item['ctime']).
            '/'.date("d", $wz_item['ctime']).'/'.$wz_item['ctime'];

        if($wz_item['type'] == 1){
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
closeDb($con);
toExit(0, $return_list, false);

?>
