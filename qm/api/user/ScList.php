<?php
/**
 * 我收藏的日记/帖子列表
 * 接口参数: 8段 * userid * 页码
 * author wangrui@min-fo.com
 * date 2015-11-13
 * date 2016-08-09 liujing 图片路径修改
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

//获取文章记录
$limit = (($page - 1)*10).',10';
$sql = "select scid from qm_sc where type = 1 and userid = $userid order by intime desc limit $limit";
$id_list = dbLoad(dbQuery($sql, $con));

$wz_list = array();
if(count($id_list) > 0){
    for($i = 0; $i < count($id_list); $i++){
        $sql = "select id,title,type,isjing,gid,ctime,userid,gid from qm_wenzhang where id = ".$id_list[$i]['scid'];
        $winfo = dbLoad(dbQuery($sql, $con), true);

        if(count($winfo) > 0){
            //小组名
            $gid = $winfo['gid'];
            $sql = "select name from qm_group where id = $gid";
            $ginfo = dbLoad(dbQuery($sql, $con), true);
            $winfo['groupname'] = $ginfo['name'];

            //发布者信息
            $userid = $winfo['userid'];
            $sql = "select username,img from qm_users_common where userid = $userid";
            $uinfo = dbLoad(dbQuery($sql, $con), true);
            $winfo['username'] = getStrFromByte($uinfo['username']);
            $winfo['userimg'] = $uinfo['img'];

            //发布时间
            $now_time = time();
            $cha_time = $now_time - $winfo['ctime'];
            if($cha_time < 60){
                $winfo['pubtime'] = "刚刚";
            }
            elseif($cha_time < 3600){
                $winfo['pubtime'] = floor($cha_time / 60)."分钟前";
            }
            elseif($cha_time < (3600 * 24)){
                $winfo['pubtime'] = floor($cha_time / 3600)."小时前";
            }
            elseif($cha_time < (3600 * 24 * 30)){
                $winfo['pubtime'] = floor($cha_time / (3600 * 24))."天前";
            }
            else{
                $winfo['pubtime'] = '一个月前';
            }

            //点赞数
            $winfo['zan'] = dbCount("qm_zan", $con, "type = 1 and zanid = ".$winfo['id']);
            
            //评论数
            $winfo['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = ".$winfo['id']);

            //图片地址
            $winfo_path = $s_path.'files/wenzhang/'.date("Y", $winfo['ctime']).'/'.date("m", $winfo['ctime']).
                '/'.date("d", $winfo['ctime']).'/'.$winfo['ctime'];
            if($type == 1){
                if(is_file($winfo_path.'/img')){
                    $imglist = json_decode(file_get_contents($winfo_path.'/img'), true);
                    //地址替换
                    foreach($imglist as $key=>$imgitem){
                        $imgitem = $s_url.strstr($imgitem,"files");
                        $imglist[$key] = $imgitem;
                    }
                }else{
                    $imglist = array();
                }
                $winfo['imgs'] = $imglist;
                $winfo['text'] = '';
            }else{
                if(is_file($winfo_path.'/text')){
                    $text = file_get_contents($winfo_path.'/text');
                }else{
                    $text = '';
                }
                $winfo['imgs'] = array();
                $winfo['text'] = mb_substr($text, 0, 20, 'utf-8');
            }

            $wz_list[] = $winfo;
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
