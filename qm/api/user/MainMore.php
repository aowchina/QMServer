<?php
/**
 * 个人中心首页
 * 接口参数: 8段 * userid
 * author wangrui@min-fo.com
 * date 2015-11-13
 * date 2016-08-09 liujing 图片路径修改
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 9)){
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

//验证userid是否存在
$count = dbCount("qm_users_common", $con, "userid = $userid");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(12, $return_list);
}

//获取基本信息
$sql = "select username,birthday,sex,cid,img from qm_users_common where userid = $userid";
$user_info = dbLoad(dbQuery($sql, $con), true);

$r_info['userid'] = $userid;
$r_info['username'] = getStrFromByte($user_info['username']);
$r_info['userimg'] = getItem('img', $user_info);

//年龄
$birthday = getItem('birthday', $user_info);
if($birthday){
    $birthday_y = substr($birthday, 0, 4);
    $now_y = date("Y", time());
    $r_info['age'] = $now_y - $birthday_y;
}else{
    $r_info['age'] = "暂未设置";
}

//性别
$sex = getItem("sex", $user_info);
if($sex){
    if($sex == 1){
        $r_info["sex"] = "男";
    }else{
        $r_info["sex"] = "女";
    }
}else{
    $r_info['sex'] = "暂未设置";
}

//城市
$cid = getItem("cid", $user_info);
if($cid){
    $sql = "select name from qm_city where id = $cid";
    $c_info = dbLoad(dbQuery($sql, $con), true);
    $r_info['city'] = $c_info['name'];
}else{
    $r_info['city'] = "暂未设置";
}

//积分 = 发帖数 * 2 + 评论数 * 1
$count_t = dbCount("qm_wenzhang", $con, "userid = $userid");
$count_p = dbCount("qm_wenzhang_pl", $con, "userid = $userid or userid2 = $userid");
$point = $count_t * 2 + $count_p;
$r_info['star'] = getStar($point);

//登录次数
$count_login = 0;
if(is_file($user_path['logininfo'])){
    $login_info = json_decode(file_get_contents($user_path['logininfo']), true);
    $count_login = count($login_info);
}
$r_info['level'] = getLevel($count_login);

//加入的小组
$sql = "select gid from qm_group_user where userid = $userid";
$gid_list = dbLoad(dbQuery($sql, $con));
if(count($gid_list) > 0){
    foreach($gid_list as &$gid_item){
        $gid = $gid_item['gid'];
        $filename = $j_path.'group/'.$gid.'/baseinfo';
        if(is_file($filename)){
            $info = json_decode(file_get_contents($filename), true);
        }else{
            $info = array();
        }

        unset($gid_item['gid']);
        $gid_item['id'] = $gid;
        $gid_item['name'] = getItem('name', $info);
        $gid_item['icon'] = $s_url.getItem('icon', $info);
    }
}else{
    $gid_list = array();
}
$r_info['group'] = $gid_list;

//获取背景图
if(is_file($s_path.'files/user/'.getSubPath($userid, 4, true).'bg')){
    $r_info['bgimg'] = file_get_contents($s_path.'files/user/'.getSubPath($userid, 4, true).'bg');
    //替换图片路径
    $r_info['bgimg'] = $s_url.strstr($r_info['bgimg'],"files");
}else{
    $r_info['bgimg'] = "";
}

$return_list['data'] = json_encode($r_info);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list);

//核算用户等级
function getLevel($login_numbers){
    $level = 1;
    if($login_numbers >= 10 && $login_numbers <= 29){
        $level = 2;
    }elseif($login_numbers >= 30 && $login_numbers <= 99){
        $level = 3;
    }elseif($login_numbers >= 100 && $login_numbers <= 199){
        $level = 4;
    }elseif($login_numbers >= 200 && $login_numbers <= 299){
        $level = 5;
    }elseif($login_numbers >= 300 && $login_numbers <= 599){
        $level = 6;
    }elseif($login_numbers >= 600 && $login_numbers <= 999){
        $level = 7;
    }elseif($login_numbers >= 1000 && $login_numbers <= 1399){
        $level = 8;
    }elseif($login_numbers >= 1400 && $login_numbers <= 1999){
        $level = 9;
    }elseif($login_numbers >= 2000){
        $level = 10;
    }
    return $level;
}

//核算用户星级
function getStar($point){
    $star = 0;
    if($point >= 0 && $point <= 19){
        $star = 0;
    }elseif($point >= 20 && $point <= 199){
        $star = 1;
    }elseif($point >= 200 && $point <= 499){
        $star = 2;
    }elseif($point >= 500 && $point <= 999){
        $star = 3;
    }elseif($point >= 1000 && $point <= 2999){
        $star = 4;
    }elseif($point >= 3000 && $point <= 4999){
        $star = 5;
    }elseif($point >= 5000 && $point <= 9999){
        $star = 6;
    }elseif($point >= 10000 && $point <= 49999){
        $star = 7;
    }elseif($point >= 50000 && $point <= 99999){
        $star = 8;
    }elseif($point >= 100000 && $point <= 499999){
        $star = 9;
    }elseif($point >= 500000 && $point <= 1999999){
        $star = 10;
    }else{
        $star = 11;
    }
    return $star;
}

?>
