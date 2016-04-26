<?php
/**
 * 筛选特惠
 * 接口参数: 8段 * userid * 筛选的字符串 * 页码
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

//验证筛选字符串
$str = getStrFromByte(trim($reqlist[9]));
if(empty($str)){
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

//获取特惠数据
$condition = mysql_real_escape_string($str, $con);
$limit = (($page - 1)*10).',10';
$sql = "select id from qm_tehui where name like '%".$condition."%' order by intime desc limit $limit";
$th_list = dbLoad(dbQuery($sql, $con));
if(count($th_list) > 0){
    foreach($th_list as &$th_item){
        $id = $th_item['id'];
        $filename = $j_path.'tehui/item/'.$id.'/baseinfo';
        $info = array();
        if(is_file($filename)){
            $info = json_decode(file_get_contents($filename), true);
        }
        
        $th_item['name'] = getItem('name', $info);
        $th_item['fname'] = getItem('fname', $info);
        $th_item['oldval'] = getItem('oldval', $info);
        $th_item['newval'] = getItem('newval', $info);
        $th_item['simg'] = $s_url.getItem('simg', $info);

        $count = dbCount("qm_yuyue", $con, 'tid = '.$id.' and status = 2');
        $th_item['sellout'] = $count;

        //获取医院名
        $hid = $info['hid'];
        $hinfo = array();
        if(is_file($j_path.'hospital/'.$hid.'/baseinfo')){
            $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid.'/baseinfo'), true);
        }
        $th_item['hname'] = getItem('name', $hinfo);
    }
}else{
    $th_list = array();
}

$return_list['data'] = json_encode($th_list);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
