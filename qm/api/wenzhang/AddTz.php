<?php
/**
 * 帖子添加
 * 接口参数: 8段 * userid * 小组id * 标签id * title * 文字内容
 * author wangrui@min-fo.com
 * date 2015-11-13
 * date 2016-08-09 liujing 图片路径修改
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");
include_once("../functions_mcheck.php");

//验证参数个数
if(!(count($reqlist) == 13)){
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
    toExit(12, $return_list);
}

//验证小组id
$gid = intval(trim($reqlist[9]));
if($gid <= 0){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(13, $return_list);
}

//验证标签id
$tid = trim($reqlist[10]);
if(!empty($tid)){
    $tid_list = explode(",", $tid);
}else{
    $tid_list = array();
}

//验证信息标题
$title = getStrFromByte(trim($reqlist[11]));
if(!isTitle($title)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(14, $return_list);
}

//验证文字内容
$text = getStrFromByte(trim($reqlist[12]));
if($text == '' || $text == null){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    toExit(15, $return_list);
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
$count = dbCount("qm_users_common", $con, 'userid = '.$userid);
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(18, $return_list);
}

//检查用户是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and status = 1 and deviceid = '$deviceid'");
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(19, $return_list);
}

//验证标签id是否存在
foreach($tid_list as $tid_item){
    $count = dbCount("qm_group_tag", $con, 'id = '.intval($tid_item));
    if($count != 1){
        unLock($dev_path.'lock');
        unLock($user_path.'lock');
        closeDb($con);
        toExit(20, $return_list);
    }
}

//验证gid是否存在
$count = dbCount("qm_group", $con, 'id = '.$gid);
if($count != 1){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(21, $return_list);
}

//锁文章表
$db_lockname = $j_path.'dblock/qm_wenzhang';
if(!file_put_contents($db_lockname, " ", LOCK_EX)){
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    closeDb($con);
    toExit(22, $return_list);
}

$data['userid'] = $userid;
$data['title'] = $title;
$data['type'] = 2;
$data['gid'] = $gid;
$data['isjing'] = 1;
$data['ctime'] = $data['intime'] = time();

if(dbAdd($data, "qm_wenzhang", $con)){
    //生成文件，上传图片
    $item_repath = date("Y", $data['ctime']).'/'.date("m", $data['ctime']).'/'.date("d", $data['ctime']).'/'.$data['ctime'];
    $item_path = $s_path.'files/wenzhang/'.$item_repath;
    mkdirs($item_path);

    file_put_contents($item_path.'/text', $text);

    $imgamount = count($_FILES);
    if($imgamount > 0){
        //文件上传
        for($i = 0; $i < $imgamount; $i++){
            $up_filename = trim($_FILES['img'.$i]['name']);
            $img_suffix = getImgType($up_filename);  //图片后缀
            $new_filename = ($i + 1).".".$img_suffix;
            
            move_uploaded_file($_FILES['img'.$i]['tmp_name'], $item_path.'/'.$new_filename);
            //去掉$s_url，保留相对地址
            $img_array[] = 'files/wenzhang/'.$item_repath.'/'.$new_filename;
        }

        file_put_contents($item_path.'/img', json_encode($img_array));
    }

    //更新json文件
    $sql = "select * from qm_wenzhang where ctime = ".$data['ctime'];
    $wzinfo = dbLoad(dbQuery($sql, $con), true);
    $wid = $wzinfo['id'];
    file_put_contents($item_path.'/baseinfo', json_encode($wzinfo));

    //插入文章-标签关系
    foreach($tid_list as $tid_item){
        $data = array();
        $data['wid'] = $wid;
        $data['tid'] = $tid_item;
        $data['intime'] = time();
        dbAdd($data, 'qm_relation_wt', $con);
    }

    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    unLock($db_lockname);
    closeDb($con);
    toExit(0, $return_list);
}else{
    unLock($dev_path.'lock');
    unLock($user_path.'lock');
    unLock($db_lockname);
    closeDb($con);
    toExit(302, $return_list);
}

?>
