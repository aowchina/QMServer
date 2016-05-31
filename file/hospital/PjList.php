<?php
/**
 * 医院主页
 * 接口参数: 8段 * 医院id * type
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

//验证医院id
$hid = intval(trim($reqlist[8]));
if(!($hid > 0 && $hid < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证查询type
$type = intval(trim($reqlist[9]));
if(!($type >= 1 && $type <= 4)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

$item_path = $j_path.'hospital/'.$hid;
if(!is_file($item_path.'/baseinfo')){
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

//获取医院评价记录
switch($type){
    case 1:
        $where = "hid = $hid";
        break;
    case 2:
        $where = "hid = $hid and hua = 3";
        break;
    case 3:
        $where = "hid = $hid and hua = 2";
        break;
    default:
        $where = "hid = $hid and hua = 1";
        break;
}

$sql = "select * from qm_pj where $where order by intime desc";
$pj_list = dbLoad(dbQuery($sql, $con));

if(count($pj_list) > 0){
    foreach($pj_list as &$pj_item){
        $userid = $pj_item['userid'];
        $sql = "select img,username from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        $pj_item['username'] = getStrFromByte($uinfo['username']);
        $pj_item['userimg'] = $uinfo['img'];
        $pj_item["pubtime"] = date("Y-m-d", $pj_item['intime']);

        $pj_item['stars'] = number_format(($pj_item['sm'] + $pj_item['hj'] + $pj_item['fw']) / 3, 1);

        //特惠信息
        $sql = "select tid from qm_yuyue where orderid = '".$pj_item['orderid']."'";
        $tinfo = dbLoad(dbQuery($sql, $con), true);

        $sql = "select fname,name,simg from qm_tehui where id = ".$tinfo['tid'];
        $tinfo = dbLoad(dbQuery($sql, $con), true);

        $pj_item['simg'] = $s_url.$tinfo['simg'];
        $pj_item['name'] = $tinfo['name'];
        $pj_item['fname'] = $tinfo['fname'];
    }
}else{
    $pj_list = array();
}

$return_list['data'] = json_encode($pj_list);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);


?>
