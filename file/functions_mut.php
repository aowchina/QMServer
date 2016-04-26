<?php

//$j_path = "/data/savedata/data_minfo/save_file/quanmei/";   //Josn文件保存路径
$j_path = "/var/www/html/quanmei/";   //Josn文件保存路径
$s_url = 'http://quanmei.min-fo.com/';                      //后台URL
$s_path = "/var/www/html/qm/";                         //后台根目录

$appid_name_array = array("7000000004"=>"qm");
$appid_key = array("7000000004" => "QUANMEIGUOWANGZHANGGTHREEHAOMINFO");

$return_list = array();    //返回数组
$reqlist = array();        //请求的参数数组

$deviceid = '';            //请求接口的设备号
$dev_path = '';            //请求接口的设备的目录

$userid = 0;               //请求接口的用户的userid
$user_path = '';           //请求接口的用户的个人目录

/*--------------------------------公共验证开始---------------------------------------*/

//验证p0
$p0 = intval(trim($_POST['p0']));
if($p0 < 3){
    toExit(1, $return_list);
}

//验证p1
$p1 = trim($_POST['p1']);
if(!isset($appid_key[$p1])){
    toExit(2, $return_list);
}

//验证p2
$p2 = trim($_POST['p2']);
if(!($p2 == 1 || $p2 == 2)){
    toExit(3, $return_list);
}

$str = "";
$command = "";
$result_list = array();

//验证p3
$p3 = trim($_POST['p3']);
if(empty($p3)){
    toExit(4, $return_list);
}

//解密
$command = "../Alg ".$p2." ".$p3." ".md5($appid_key[$p1]);
$str = exec($command);
$result_list = explode('*', trim($str));

//验证解密后appid
$appid = trim($result_list[0]);
if($appid != $p1){
    toExit(5, $return_list);
}
        
//解密p4-pn
for($i = 4; $i < $p0; $i++){
    $str_tmp = "";
    $command = "";
    $command = "../Alg ".$p2." ".$_POST['p'.$i]." ".md5($appid_key[$p1]);
    $str_tmp = exec($command);
    $str = $str.trim($str_tmp);
}

$reqlist = explode('*', trim($str));

//验证deviceid
$deviceid = trim($reqlist[1]);
if(empty($deviceid) || !preg_match("/^[0-9a-zA-Z]+$/", $deviceid)){
    toExit(7, $return_list);
}

//生成设备号文件锁
$dev_path = $j_path.'device/'.getSubPath($deviceid, 4, true);
if(!mkdirs($dev_path)){
    toExit(8, $return_list);
}
if(!file_put_contents($dev_path.'lock', ' ', LOCK_EX)){
    toExit(9, $return_list);
}


/*--------------------------------公共验证结束---------------------------------------*/

/**
 * 解锁
 * @author wangrui
 */
function unLock($lock_filename){
    if(is_file($lock_filename)){
        unlink($lock_filename);
    }
}

/**
 * 递归创建指定目录
 * @param dir：要创建的目录的绝对路径
 * @return 目录创建是否成功，true成功，false不成功
 * author wangrui@min-fo.com
 */
function mkdirs($dir){    
    return is_dir($dir) or (mkdirs(dirname($dir)) and mkdir($dir, 0777));
}

/**
 * 根据 $baseStr，截取 $subAmount 次，每次截取2位，拼接成相对路径
 * @param $baseStr: 被截取的字符串
 * @param $subAmount: 被截取次数
 * @param $includeStr: 是否包括$baseStr
 * author wangrui@min-fo.com
 * date 2015-05-01
 */
function getSubPath($baseStr, $subAmount, $includeStr){
    $str = md5($baseStr);
    $re_path = '';
    for($i = 0; $i < $subAmount; $i++){
        $re_path = $re_path.substr($str, $i*2, 2).'/';
    }
    if($includeStr){
        $re_path = $re_path.$baseStr.'/';
    }
    return trim($re_path);
}

/**
 * 数据加密
 * @author wangrui
 */
function pswData($data_str){
    $data_len = strlen($data_str);
    $data_array = array();

    if(($data_len % 60) != 0){
        $data_array['cnt'] = ceil($data_len / 60);
    }else{
        $data_array['cnt'] = $data_len / 60; 
    }
    
    for($i = 0; $i < $data_array['cnt']; $i++){
        $sub_data_str = "";
        $sub_data_str = substr($data_str, $i * 60, 60);
        $command = "";
        $command = "../Alg 1 '".$sub_data_str."' ".md5("QUANMEIGUOWANGZHANGGTHREEHAOMINFO");
        $data_array[$i] = exec($command);
    }

    return $data_array;
}

/**
 * 结束前处理
 * @author wangrui
 */
function toExit($errorcode, $return_list, $ispsw = true){
    $return_list['errorcode'] = $errorcode;

    if(isset($return_list['data']) && !empty($return_list['data'])){
        if($ispsw){
            $return_list['active'] = 1;
            $return_list['data'] = pswData($return_list['data']);
        }else{
            $return_list['active'] = 2;
        }
    }else{
        if($ispsw){
            $return_list['active'] = 1;
        }else{
            $return_list['active'] = 2;
        }
        $return_list['data'] = '';
    }

    echo json_encode($return_list);
    exit;
}

function getStrFromByte($mByteStr){
    $str = "";
    $byte_list = explode("#", $mByteStr);
    for($i = 0; $i < count($byte_list) - 1; $i++){
        $str .= chr($byte_list[$i]);
    }

    return trim($str);
}

function getItem($key_name, $total_array){
    if(isset($total_array[$key_name])){
        if($total_array[$key_name]){
            return $total_array[$key_name];
        }
    }
    return "";
}

function getImgType($imgname){
    $list = explode(".", $imgname);
    return $list[count($list) - 1];
}

/**
 * 删除指定目录下的所有文件
 * @param $dir: 指定目录
 * author wangrui@min-fo.com
 * date 2014-09-25
 */
function delDirFile($dir){
    $dh = opendir($dir);
    while($file = readdir($dh)){      
        if($file != "." && $file != ".."){
            $fullpath = $dir."/".$file;
            if (!is_dir($fullpath)){
                unlink($fullpath);
            }
        }
    }
    closedir($dir);
}

/**
 * 删除指定路径
 * @param $path 被删除的路径
 * @param $n 要删除的文件夹个数
 * author wangrui@min-fo.com
 * date 2014-09-27
 */
function delPath($path, $n){
    if($n > 0){
        $path_list = explode("/", $path);
        delDir($path);

        $dir_length = strlen($path_list[count($path_list) - 1]) + 1;  //得到刚刚删除的这个文件夹的文件夹名长度，+1是因为"/"
        $str_length = 0 - $dir_length;                                
        $now_path = substr($path, 0, $str_length);                   //得到删除之后的路径名
        $now_int = $n - 1;
        delPath($now_path, $now_int);
    }
}

/**
 * 若文件夹为空，删除文件夹
 * @param $dir: 文件夹名
 * author wangrui@min-fo.com
 * date 2014-09-27
 */
function delDir($dir){
    $dh = opendir($dir);
    $i = 0;
    while($file = readdir($dh)){
        if($file != "." && $file != ".."){
            $i = 1;
        }
    }
    closedir($dh);
    if($i == 0){
        rmdir($dir);
    }
}

?>