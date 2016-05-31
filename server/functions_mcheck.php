<?php
/**
 * 验证方法集
 * author wangrui@min-fo.com
 * date 2015-01-07
 */

//是否为医院名
function isHospitalName($str){
    if(preg_match('/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9\(\)\-\（\）]+$/u', $str)){
        return true;
    }
    return false;
}

//是否为信息标题
function isTitle($str){
    if(preg_match('/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9\s\(\)\-\_\,\，\（\）\“\”\+]+$/u', $str)){
        return true;
    }
    return false;
}

//是否为密码
function isPsw($str){
    if(preg_match("/^[0-9a-zA-Z]{6,15}$/", $str)){
        return true;
    }
    return false;
}

//是否为邮箱
function isEmail($str){
    if(preg_match("/^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/ix", $str)){
        return true;
    }
    return false;
}

//是否为手机号
function isMobel($str){
    if(preg_match("/^13[0-9]{1}[0-9]{8}$|14[57]{1}[0-9]{8}$|15[0-9]{1}[0-9]{8}$|18[0-9]{1}[0-9]{8}$/", $str)){
        return true;
    }
    return false;
}

//是否为生日
function isBirthday($str){
    $list = explode("-", $str);

    $year = intval($list[0]);
    $mon = intval($list[1]);
    $day = intval($list[2]);
    
    return checkdate($mon, $day, $year);
}

?>