<?php
/**
 * 医院主页
 * 接口参数: 8段 * 医院id
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

//验证医院id
$hid = intval(trim($reqlist[8]));
if(!($hid > 0 && $hid < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$item_path = $j_path.'hospital/'.$hid;
if(!is_file($item_path.'/baseinfo')){
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

$hinfo = json_decode(file_get_contents($item_path.'/baseinfo'), true);
$r_data['id'] = $hid;
$r_data['name'] = getItem("name", $hinfo);
$r_data['logo'] = $s_url.getItem('logo', $hinfo);

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

//获取医院审美
$sql = "select * from qm_pj where hid = $hid order by intime desc";
$pj_list = dbLoad(dbQuery($sql, $con));

if(count($pj_list) > 0){
    $sm = 0;
    $hj = 0;
    $fw = 0;
    for($i = 0; $i < count($pj_list); $i++){
        $sm = $pj_list[$i]['sm'] + $sm;
        $hj = $pj_list[$i]['hj'] + $hj;
        $fw = $pj_list[$i]['fw'] + $fw;
    }

    $r_data['sm'] = number_format($sm / count($pj_list), 1);
    $r_data['hj'] = number_format($hj / count($pj_list), 1);
    $r_data['fw'] = number_format($fw / count($pj_list), 1);

    $count = dbCount("qm_pj", $con, "hid = $hid and hua >= 2");
    $r_data['hp'] = (number_format($count / count($pj_list), 2) * 100)."%";

    foreach($pj_list as &$pj_item){
        $userid = $pj_item['userid'];
        $sql = "select username from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        $pj_item['username'] = getStrFromByte($uinfo['username']);

        $pj_item['stars'] = number_format(($pj_item['sm'] + $pj_item['hj'] + $pj_item['fw']) / 3, 1);

        $pj_item["pubtime"] = date("Y-m-d", $pj_item['intime']);
    }
    $r_data['pl'] = array_slice($pj_list, 0, 3);
}else{
    $r_data['sm'] = '5.0';
    $r_data['hj'] = '5.0';
    $r_data['fw'] = '5.0';
    $r_data['hp'] = '100%';
    $r_data['pl'] = array();
}

//计算医院星级
$r_data['stars'] = number_format(($r_data['sm'] + $r_data['hj'] + $r_data['fw']) / 3, 1);
$r_data['plamount'] = count($pj_list);


$did_list = array();
$filename = $item_path.'/doctor';
if(is_file($filename)){
    $did_list = json_decode(file_get_contents($filename), true);
    $did_list = array_slice($did_list, 0, 2);

    foreach($did_list as &$did_item){
        $did = $did_item['id'];
        $filename2 = $j_path.'doctor/'.$did;
        if(is_file($filename2)){
            $d_info = json_decode(file_get_contents($filename2), true);
            $did_item['name'] = $d_info['name'];
            $did_item['direction'] = $d_info['direction'];
            $did_item['img'] = $s_url.$d_info['img'];
        }else{
            $did_item['name'] = '';
            $did_item['direction'] = '';
            $did_item['img'] = '';
        }
    }
}
$r_data['doctor'] = $did_list;

$return_list['data'] = json_encode($r_data);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);


?>
