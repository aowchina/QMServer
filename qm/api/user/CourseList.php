<?php
/**
 * 我收藏的日记/帖子列表
 * 接口参数: 8段 * userid * 页码
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
$sql = "select courseid,amount,orderid from qm_course_order where status = 1 and userid = $userid order by id desc limit $limit";
$id_list = dbLoad(dbQuery($sql, $con));

$r_list = array();
if(count($id_list) > 0){
    for($i = 0; $i < count($id_list); $i++){
        $field = "a.name,b.id as teacherid from qm_course as a,qm_teacher as b ";
        $where = "where a.id = ".$id_list[$i]['courseid']." and b.courseid = ".$id_list[$i]['courseid'];

        $sql = "select ".$field.$where;
        $winfo = dbLoad(dbQuery($sql, $con), true);

        if(count($winfo) > 0){
            $winfo['courseid'] = $id_list[$i]['courseid'];
            $winfo['amount'] = $id_list[$i]['amount'];
            $winfo['orderid'] = $id_list[$i]['orderid'];

            $r_list[] = $winfo;
        }
    }
}else{
    $r_list = array();
}

$return_list['data'] = json_encode($r_list);
unLock($dev_path.'lock');
unLock($user_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
