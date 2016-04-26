<?php
/**
 * 特惠列表(带筛选)
 * 接口参数: 8段 * 省id * 类别id * type * page
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");

//验证参数个数
if(!(count($reqlist) == 12)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

//验证省id
$pid = intval(trim($reqlist[8]));
if(!($pid >= 0 && $pid < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

//验证类别id
$tid = intval(trim($reqlist[9]));
if(!($tid >= 0 && $tid < 4294967296)){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

//验证type
$type = intval(trim($reqlist[10]));
if(!($type == 0 || $type == 1 || $type == 2)){
    unLock($dev_path.'lock');
    toExit(12, $return_list);
}

//验证页码
$page = intval(trim($reqlist[11]));
if($page < 1){
    unLock($dev_path.'lock');
    toExit(13, $return_list);
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

if($pid == 0 && $type == 0){
    if($tid == 0){
        $filename = $j_path.'tehui/total/'.$page;
    }else{
        $filename = $j_path.'tehui/type/'.$tid.'/'.$page;
    }

    if(is_file($filename)){
        $id_list = json_decode(file_get_contents($filename), true);
    }else{
        $id_list = array();
    }
}else{
    //省份筛选
    if($pid != 0){
        $where = "hid in (select id from qm_hospital where pid = ".$pid.")";
    }else{
        $where = '';
    }

    //类别筛选
    if($tid != 0){
        if($where){
            $where .= " and tid = ".$tid;
        }else{
            $where .= "tid = ".$tid;
        }
    }else{
        $where .= "";
    }

    //类型筛选
    if($type != 0){
        if($type == 1){
            $order = 'order by intime desc';
        }else{
            $order = 'order by newval asc';
        }
    }else{
        $order = "";
    }

    $sql = "select id from qm_tehui where $where $order limit ".(($page - 1)*10).',10';
    $id_list = dbLoad(dbQuery($sql, $con));
}

foreach($id_list as &$id_item){
    $id = $id_item['id'];
    $filename = $j_path.'tehui/item/'.$id.'/baseinfo';
    $info = array();
    if(is_file($filename)){
        $info = json_decode(file_get_contents($filename), true);
    }
    
    $id_item['name'] = getItem('name', $info);
    $id_item['fname'] = getItem('fname', $info);
    $id_item['oldval'] = getItem('oldval', $info);
    $id_item['newval'] = getItem('newval', $info);
    $id_item['simg'] = $s_url.getItem('simg', $info);

    $count = dbCount("qm_yuyue", $con, 'tid = '.$id.' and status = 2');
    $id_item['sellout'] = $count;

    //获取医院名
    $hid = $info['hid'];
    $hinfo = array();
    if(is_file($j_path.'hospital/'.$hid.'/baseinfo')){
        $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid.'/baseinfo'), true);
    }
    $id_item['hname'] = getItem('name', $hinfo);
}

$return_list['data'] = json_encode($id_list);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
