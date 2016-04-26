<?php
/**
 * 特惠类别列表(带主题活动)
 * 接口参数: 8段
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 8)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
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

//获取特惠类别
$types = array();
$filename = $j_path.'tehui/type/list';
if(is_file($filename)){
    $types = json_decode(file_get_contents($filename), true);
}
$r_list['types'] = $types;

//获取第一个主题活动
$list_filename = $j_path.'act/total/list';;
if(is_file($list_filename)){
    $list = json_decode(file_get_contents($list_filename), true);
}else{
    $list = array();
}

if(count($list) > 0){
    $flist = array_slice($list, 0, 1);
    foreach($flist as &$act_item){
        $hid = $act_item['hid'];
        $pid = $act_item['pid'];
        if($hid != 0){
            $sql_in = "select id from qm_tehui where hid = $hid";
        }else{
            $sql_in = "select id from qm_tehui where pid = $pid";
        }
        
        $count = dbCount("qm_yuyue", $con, "tid in (".$sql_in.") group by userid");
        $act_item['amount'] = $count;
        
        if($count > 0){
            $sql = "select userid from qm_yuyue where tid in (".$sql_in.") group by userid order by intime desc limit 3";
            $user_list = dbLoad(dbQuery($sql, $con));

            foreach($user_list as &$act_useritem){
                $sql = "select img from qm_users_common where userid = ".$act_useritem['userid'];
                $userinfo = dbLoad(dbQuery($sql, $con), true);
                if($userinfo['img']){
                    $act_useritem['userimg'] = $userinfo['img'];
                }else{
                    $act_useritem['userimg'] = "";
                }
            }
            $act_item['yyuser'] = $user_list;
        }else{
            $act_item['yyuser'] = array();
        }

        $act_item['simg'] = $s_url.$act_item['simg'];
        $act_item['bimg'] = $s_url.$act_item['bimg'];
    }
    $flist = $flist[0];
}else{
    $flist = array();
}
$r_list['act_first'] = $flist;

foreach($list as &$a_item){
    $a_item['simg'] = $s_url.$a_item['simg'];
    $a_item['bimg'] = $s_url.$a_item['bimg'];
}
$r_list['act_list'] = $list;

$return_list['data'] = json_encode($r_list);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
