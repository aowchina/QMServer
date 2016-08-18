<?php
/**
 * 特惠详情
 * 接口参数: 8段 * 特惠id
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

//验证id
$id = intval(trim($reqlist[8]));
if(!($id > 0 && $id < 4294967296)){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
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

//获取详情数组
$info = array();
$filename = $j_path.'tehui/item/'.$id.'/baseinfo';
if(is_file($filename)){
    $info = json_decode(file_get_contents($filename), true);
}

if(isset($info['id'])){
    $r_list['id'] = $id;
    $r_list['bimg'] = $s_url.getItem("bimg", $info);
    $r_list['oldval'] = getItem("oldval", $info);
    $r_list['newval'] = getItem("newval", $info);
    $r_list['name'] = getItem("name", $info);
    $r_list['fname'] = getItem("fname", $info);
    $r_list['dj'] = getItem("dj", $info);
    $r_list['intro'] = getItem("intro", $info);
    $r_list['detail'] = $s_url.getItem("detail", $info);
    $r_list['hid'] = getItem("hid", $info);

    $img_size = getimagesize($s_path.getItem("detail", $info));
    $r_list['img_width'] = $img_size[0];
    $r_list['img_height'] = $img_size[1];


    // 价格说明
    $r_list['val_desc'] = getItem('val_desc',$info);
    //获取医院信息
    $hid = $r_list['hid'];
    $hinfo = array();
    if(is_file($j_path.'hospital/'.$hid."/baseinfo")){
        $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid."/baseinfo"), true);
    }
    $r_list['hname'] = getItem("name", $hinfo);
    $r_list['himg'] = $s_url.getItem("logo", $hinfo);

    //获取流程
    if(is_file($j_path.'tehui/lc')){
        $r_list['lc'] = file_get_contents($j_path.'tehui/lc');
    }else{
        $r_list['lc'] = "";
    }
    
    if(is_file($j_path.'tehui/lcnote')){
        $r_list['lcnote'] = file_get_contents($j_path.'tehui/lcnote');
    }else{
        $r_list['lcnote'] = "";
    }

    //获取购买的用户
    $sql = "select userid from qm_yuyue where tid = $id order by intime desc group by userid limit 5";
    $ulist = dbLoad(dbQuery($sql, $con));
    if(count($ulist) > 0){
        foreach($ulist as &$u_item){
            $sql = "select img from qm_users_common where userid = ".$u_item['userid'];
            $uinfo = dbLoad(dbQuery($sql, $con), true);
            if($uinfo['img']){
                $u_item['userimg'] = $uinfo['img'];
            }else{
                $u_item['userimg'] = "";
            }
        }
    }else{
        $ulist = array();
    }
    $r_list['users'] = $ulist;

    $return_list['data'] = json_encode($r_list);
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(0, $return_list, false);
}else{
    unLock($dev_path.'lock');
    closeDb($con);
    toExit(11, $return_list);
}

?>
