<?php
/**
 * 首页
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

//获取特惠数据
$filename = $j_path.'tehui/total/1';
if(is_file($filename)){
    $th_list = json_decode(file_get_contents($filename), true);
}else{
    $th_list = array();
}

$th_list = array_slice($th_list, 0, 3);

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
}

//获取主题活动数据
$filename = $j_path.'act/total/list';;
if(is_file($filename)){
    $act_list = json_decode(file_get_contents($filename), true);
}else{
    $act_list = array();
}
if(count($act_list) > 0){
    $act_list = array_slice($act_list, 0, 3);
    foreach($act_list as &$act_item){
        $hid = $act_item['hid'];
        $pid = $act_item['pid'];
        if($hid != 0){
            $sql_in = "select id from qm_tehui where hid = $hid";
        }else{
            $sql_in = "select id from qm_tehui where pid = $pid";
        }
        
        $count = dbCount("qm_yuyue", $con, "tid in (".$sql_in.")");
        $act_item['amount'] = $count;
        
        if($count > 0){
            $sql = "select userid from qm_yuyue where tid in ($sql_in) group by userid order by intime desc limit 3";
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
}

//课程数据
$course_data = array();
if(is_file($j_path.'teacher/list')){
    $teacher_list = json_decode(file_get_contents($j_path.'teacher/list'), true);
    $teacher = $teacher_list[0];
    if(is_file($j_path.'teacher/'.$teacher['id'])){
        $teacher_info = json_decode(file_get_contents($j_path.'teacher/'.$teacher['id']), true);
        $course_filename = $j_path.'course/'.$teacher_info['courseid'];

        if(is_file($course_filename)){
            $course_info = json_decode(file_get_contents($course_filename), true);
            $course_data['course_banner'] = $s_url.$course_info['banner'];
            $course_data['teacher'] = $teacher['id'];
        }
    }
}

//保险数据
$bx_data = array();
$bx_file = $j_path.'baoxian/list';
if(is_file($bx_file)){
    $bx_list = json_decode(file_get_contents($bx_file), true);
    $bx_data = $bx_list[0];
    $bx_data['img'] = $s_url.$bx_data['img'];
}

$lunbo_data = array();
if(count($act_list) > 0){
    foreach($act_list as $a_item){
        $lb_act_item = array();
        $lb_act_item['type'] = 1;
        $lb_act_item['hid'] = $a_item['hid'];
        $lb_act_item['pid'] = $a_item['pid'];
        $lb_act_item['id'] = $a_item['id'];
        $lb_act_item['img'] = $a_item['bimg'];
        $lunbo_data[] = $lb_act_item;
    }
}
if(count($course_data) > 0){
    $lb_course_item = array();
    $lb_course_item['type'] = 2;
    $lb_course_item['hid'] = 0;
    $lb_course_item['pid'] = 0;
    $lb_course_item['id'] = $course_data['teacher'];
    $lb_course_item['img'] = $course_data['course_banner'];
    $lunbo_data[] = $lb_course_item;
}
if(count($bx_data) > 0){
    $lb_bx_item = array();
    $lb_bx_item['type'] = 3;
    $lb_bx_item['hid'] = 0;
    $lb_bx_item['pid'] = 0;
    $lb_bx_item['id'] = $bx_data['teacher'];
    $lb_bx_item['img'] = $bx_data['img'];
    $lunbo_data[] = $lb_bx_item;
}

//获取日记数据
$sql = "select id,title,type,isjing,gid,ctime,userid from qm_wenzhang where type = 1 and isjing = 2 
    order by ctime desc limit 5";
$wz_list = dbLoad(dbQuery($sql, $con));
if(count($wz_list) > 0){
    foreach($wz_list as &$wz_item){
        //小组名
        $gid = $wz_item['gid'];
        $sql = "select name from qm_group where id = $gid";
        $ginfo = dbLoad(dbQuery($sql, $con), true);
        $wz_item['groupname'] = $ginfo['name'];

        //发布者信息
        $userid = $wz_item['userid'];
        $sql = "select username,img from qm_users_common where userid = $userid";
        $uinfo = dbLoad(dbQuery($sql, $con), true);
        $wz_item['username'] = getStrFromByte($uinfo['username']);
        $wz_item['userimg'] = $uinfo['img'];

        //发布时间
        $now_time = time();
        $cha_time = $now_time - $wz_item['ctime'];
        if($cha_time < 60){
            $wz_item['pubtime'] = "刚刚";
        }
        elseif($cha_time < 3600){
            $wz_item['pubtime'] = floor($cha_time / 60)."分钟前";
        }
        elseif($cha_time < (3600 * 24)){
            $wz_item['pubtime'] = floor($cha_time / 3600)."小时前";
        }
        elseif($cha_time < (3600 * 24 * 30)){
            $wz_item['pubtime'] = floor($cha_time / (3600 * 24))."天前";
        }
        else{
            $wz_item['pubtime'] = '一个月前';
        }

        //点赞数
        $wz_item['zan'] = dbCount("qm_zan", $con, "type = 1 and zanid = ".$wz_item['id']);
        
        //评论数
        $wz_item['pl'] = dbCount("qm_wenzhang_pl", $con, "wid = ".$wz_item['id']);

        //图片地址
        $wz_item_path = $s_path.'files/wenzhang/'.date("Y", $wz_item['ctime']).'/'.date("m", $wz_item['ctime']).
            '/'.date("d", $wz_item['ctime']).'/'.$wz_item['ctime'];

        if(is_file($wz_item_path.'/img')){
            $imglist = json_decode(file_get_contents($wz_item_path.'/img'), true);
        }else{
            $imglist = array();
        }
        $wz_item['imgs'] = $imglist;
        $wz_item['text'] = '';
    }
}else{
    $wz_list = array();
}

//获取热门项目
$filename = $j_path.'tehui/type/list';
$pro_list = array();
if(is_file($filename)){
    $pro_list = json_decode(file_get_contents($filename), true);
}
$pro_list = array_slice($pro_list, 0, 9);

//获取产品数据
$filename = $j_path.'tehui/total/1';
if(is_file($filename)){
    $goods_list = json_decode(file_get_contents($filename), true);
}else{
    $goods_list = array();
}

foreach($goods_list as &$goods_item){
    $id = $goods_item['id'];
    $filename = $j_path.'tehui/item/'.$id.'/baseinfo';
    $info = array();
    if(is_file($filename)){
        $info = json_decode(file_get_contents($filename), true);
    }
    
    $goods_item['name'] = getItem('name', $info);
    $goods_item['fname'] = getItem('fname', $info);
    $goods_item['oldval'] = getItem('oldval', $info);
    $goods_item['newval'] = getItem('newval', $info);
    $goods_item['simg'] = $s_url.getItem('simg', $info);

    $count = dbCount("qm_yuyue", $con, 'tid = '.$id.' and status = 2');
    $goods_item['sellout'] = $count;

    //获取医院名
    $hid = $info['hid'];
    $hinfo = array();
    if(is_file($j_path.'hospital/'.$hid.'/baseinfo')){
        $hinfo = json_decode(file_get_contents($j_path.'hospital/'.$hid.'/baseinfo'), true);
    }
    $goods_item['hname'] = getItem('name', $hinfo);
}

$r_list['lunbo'] = $lunbo_data;
$r_list['act'] = $act_list;
$r_list['tehui'] = $th_list;
$r_list['diary'] = $wz_list;
$r_list['project'] = $pro_list;
$r_list['goods'] = $goods_list;

$return_list['data'] = json_encode($r_list);
unLock($dev_path.'lock');
closeDb($con);
toExit(0, $return_list, false);

?>
