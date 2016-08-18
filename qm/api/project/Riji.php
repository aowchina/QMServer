<?php
/**
 * 项目详情
 * 接口参数: 8段 * 项目id * 页码
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

//验证id
$id = intval(trim($reqlist[8]));
if(!($id > 0 && $id < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证页码
$page = intval(trim($reqlist[9]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
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
$limit = (($page - 1)*10).',10';
$pg_relation = "select gid from qm_relation_pg where pid = ".$id;
$where = "type = 1 and gid in (".$pg_relation.")";
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
        $wz_item['zan'] = dbCount("qm_wenzhang_zan", $con, "wid = ".$wz_item['id']);
        
        //评论数
        $wz_item['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = ".$wz_item['id']);

        //图片地址
        $wz_item_path = $s_path.'files/wenzhang/'.date("Y", $wz_item['ctime']).'/'.date("m", $wz_item['ctime']).
            '/'.date("d", $wz_item['ctime']).'/'.$wz_item['ctime'];

        if(is_file($wz_item_path.'/img')){
            $imglist = json_decode(file_get_contents($wz_item_path.'/img'), true);
        }else{
            $imglist = array();
        }
        $wz_item['imgs'] = $imglist;
        $wz_item['text'] = '';
    }
}else{
    $wz_list = array();
}

$return_list['data'] = json_encode($wz_list);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
