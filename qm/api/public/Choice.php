<?php
/**
 * 筛选特惠/文章
 * 接口参数: 8段 * userid * 筛选的字符串
 * author wangrui@min-fo.com
 * date 2015-11-13
 * date 2016-08-09 liujing 图片路径修改
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if (!(count($reqlist) == 10)) {
    unLock($dev_path . 'lock');
    toExit(6, $return_list);
}

//验证筛选字符串
$str = getStrFromByte(trim($reqlist[9]));
if (empty($str)) {
    unLock($dev_path . 'lock');
    toExit(10, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if (!($userid == 0 || ($userid >= 100000 && $userid <= 999999999))) {
    unLock($dev_path . 'lock');
    toExit(11, $return_list);
}
//userid打锁
$user_repath = getSubPath($userid, 4, true);
$user_path = $j_path . 'user/' . $user_repath;
if ($userid != 0) {
    if (!is_dir($user_path)) {
        unLock($dev_path . 'lock');
        toExit(12, $return_list);
    }
    if (!file_put_contents($user_path . 'lock', " ", LOCK_EX)) {
        unLock($dev_path . 'lock');
        toExit(12, $return_list);
    }
}

//连接db
$con = conDb();
if ($con == '') {
    unLock($dev_path . 'lock');
    unLock($user_path . 'lock');
    toExit(300, $return_list);
}

//检查连接数
if (!checkDbCon($con)) {
    unLock($dev_path . 'lock');
    unLock($user_path . 'lock');
    closeDb($con);
    toExit(301, $return_list);
}

//获取特惠数据
$condition = mysql_real_escape_string($str, $con);
$sql = "select id from qm_tehui where name like '%" . $condition . "%' or fname like '%" . $condition . "%' order by intime desc limit 4";

$th_list = dbLoad(dbQuery($sql, $con));
if (count($th_list) > 0) {
    foreach ($th_list as &$th_item) {
        $id = $th_item['id'];
        $filename = $j_path . 'tehui/item/' . $id . '/baseinfo';
        $info = array();
        if (is_file($filename)) {
            $info = json_decode(file_get_contents($filename), true);
        }

        $th_item['name'] = getItem('name', $info);
        $th_item['fname'] = getItem('fname', $info);
        $th_item['oldval'] = getItem('oldval', $info);
        $th_item['newval'] = getItem('newval', $info);
        $th_item['simg'] = $s_url . getItem('simg', $info);

        $count = dbCount("qm_yuyue", $con, 'tid = ' . $id . ' and status = 2');
        $th_item['sellout'] = $count;

        //获取医院名
        $hid = $info['hid'];
        $hinfo = array();
        if (is_file($j_path . 'hospital/' . $hid . '/baseinfo')) {
            $hinfo = json_decode(file_get_contents($j_path . 'hospital/' . $hid . '/baseinfo'), true);
        }
        $th_item['hname'] = getItem('name', $hinfo);

    }
} else {
    $th_list = array();
}
$r_data['th'] = $th_list;

$count = dbCount("qm_tehui", $con, "name like '%" . $condition . "%' or fname like '%" . $condition . "%'");
$r_data['th_amount'] = $count;

//获取日记
$condition_rj = "type = 1 and title like '%" . $condition . "%'";
$count = dbCount("qm_wenzhang", $con, $condition_rj);
$r_data['rj_amount'] = $count;

$rj_list = array();
if ($count > 0) {
    $sql = "select id,title,type,isjing,gid,ctime,userid from qm_wenzhang where $condition_rj order by ctime desc limit 5";
    $rj_list = dbLoad(dbQuery($sql, $con));
    foreach ($rj_list as &$rj_item) {
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
        if ($cha_time < 60) {
            $rj_item['pubtime'] = "刚刚";
        } elseif ($cha_time < 3600) {
            $rj_item['pubtime'] = floor($cha_time / 60) . "分钟前";
        } elseif ($cha_time < (3600 * 24)) {
            $rj_item['pubtime'] = floor($cha_time / 3600) . "小时前";
        } elseif ($cha_time < (3600 * 24 * 30)) {
            $rj_item['pubtime'] = floor($cha_time / (3600 * 24)) . "天前";
        } else {
            $rj_item['pubtime'] = '一个月前';
        }

        //点赞数
        $rj_item['zan'] = dbCount("qm_zan", $con, "zanid = " . $rj_item['id']);

        //评论数
        $rj_item['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = " . $rj_item['id']);

        $rj_item_path = $s_path . 'files/wenzhang/' . date("Y", $rj_item['ctime']) . '/' . date("m", $rj_item['ctime']) .
            '/' . date("d", $rj_item['ctime']) . '/' . $rj_item['ctime'];

        if (is_file($rj_item_path . '/img')) {
            $imglist = json_decode(file_get_contents($rj_item_path . '/img'), true);
            //地址替换
            foreach($imglist as $key=>$imgitem){
                $imgitem = $s_url.strstr($imgitem,"files");
                $imglist[$key] = $imgitem;
            }
        } else {
            $imglist = array();
        }
        $rj_item['imgs'] = $imglist;
        $rj_item['text'] = '';
    }
}
$r_data['rj'] = $rj_list;

//获取帖子
$condition_tz = "type = 2 and title like '%" . $condition . "%'";
$count = dbCount("qm_wenzhang", $con, $condition_tz);
$r_data['tz_amount'] = $count;

$tz_list = array();
if ($count > 0) {
    $sql = "select id,title,type,isjing,gid,ctime,userid from qm_wenzhang where $condition_tz order by ctime desc limit 5";
    $tz_list = dbLoad(dbQuery($sql, $con));
    foreach ($tz_list as &$tz_item) {
        //小组名
        $gid = $tz_item['gid'];
        $sql = "select name from qm_group where id = $gid";
        $ginfo = dbLoad(dbQuery($sql, $con), true);
        $tz_item['groupname'] = $ginfo['name'];

        //发布者信息
        $userid = $tz_item['userid'];
        $sql = "select username,img from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        $tz_item['username'] = getStrFromByte($uinfo['username']);
        $tz_item['userimg'] = $uinfo['img'];

        //发布时间
        $now_time = time();
        $cha_time = $now_time - $tz_item['ctime'];
        if ($cha_time < 60) {
            $tz_item['pubtime'] = "刚刚";
        } elseif ($cha_time < 3600) {
            $tz_item['pubtime'] = floor($cha_time / 60) . "分钟前";
        } elseif ($cha_time < (3600 * 24)) {
            $tz_item['pubtime'] = floor($cha_time / 3600) . "小时前";
        } elseif ($cha_time < (3600 * 24 * 30)) {
            $tz_item['pubtime'] = floor($cha_time / (3600 * 24)) . "天前";
        } else {
            $tz_item['pubtime'] = '一个月前';
        }

        //点赞数
        $tz_item['zan'] = dbCount("qm_zan", $con, "zanid = " . $tz_item['id']);

        //评论数
        $tz_item['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = " . $tz_item['id']);

        $tz_item_path = $s_path . 'files/wenzhang/' . date("Y", $tz_item['ctime']) . '/' . date("m", $tz_item['ctime']) .
            '/' . date("d", $tz_item['ctime']) . '/' . $tz_item['ctime'];

        if (is_file($tz_item_path . '/text')) {
            $text = file_get_contents($tz_item_path . '/text');
        } else {
            $text = '';
        }
        $tz_item['imgs'] = array();
        $tz_item['text'] = mb_substr($text, 0, 20, 'utf-8');
    }
}
$r_data['tz'] = $tz_list;

$return_list['data'] = json_encode($r_data);
unLock($dev_path . 'lock');
unLock($user_path . 'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
