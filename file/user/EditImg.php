<?php
/**
 * 修改头像
 * 接口参数: 8段 * userid
 * author wangrui@min-fo.com
 * date 2015-11-13
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
$user_repath = getSubPath($userid, 4, true);
$user_path = $j_path.'user/'.$user_repath;
if(!is_dir($user_path)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证头像
if(count($_FILES) != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(12, $return_list);
}

$up_filename = trim($_FILES['img0']['name']);
$img_suffix = getImgType($up_filename);
if(!($img_suffix == 'png' || $img_suffix == 'jpg' || $img_suffix == 'jpeg')){
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

//验证userid是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and deviceid = '".$deviceid."' and status = 1");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(14, $return_list);
}

//创建上传路径
$now_time = time();
$new_filename = $now_time.".".$img_suffix;
$up_path = $s_path."files/user/".$user_repath;
if(!mkdirs($up_path)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(15, $return_list);
}

if(!move_uploaded_file($_FILES['img0']['tmp_name'], $up_path.$new_filename)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(16, $return_list);
}

$sql = "select img from qm_users_common where userid = $userid";
$user_info = dbLoad(dbQuery($sql, $con), true);

$data['img'] = $s_url."files/user/".$user_repath.$new_filename;
$data['intime'] = time();

if(dbUpdate($data, "qm_users_common", $con, "userid = $userid")){
    $old_img = getItem("img", $user_info);
    if($old_img){
        $old_imgname = str_replace($s_url, $s_path, $old_img);
        if(is_file($old_imgname)){
            unlink($old_imgname);
        }
    }

    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(303, $return_list);
}

?>
