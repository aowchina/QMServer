<?php

/**
* 文章举报
 * 接口参数: 8段 * userid * id
 * author liujing
 * date 2016-08-03
 */
include_once("../functions_mut.php");
include_once("../functions_mdb.php");
include_once("../Jpush.php");

//验证参数个数
if(!(count($reqlist) == 10)){
	unLock($dev_path.'lock');
	toExit(6, $return_list);
}

//验证userid
$userid = intval(trim($reqlist[8]));
if(!($userid >= 100000 && $userid <= 999999999)){
	unLock($dev_path.'lock');
	toExit(10, $return_list);
}

//userid打锁
$user_path = $j_path.'user/'.getSubPath($userid, 4, true);
if(!is_dir($user_path)){
	unLock($dev_path.'lock');
	toExit(11, $return_list);
}
if(!file_put_contents($user_path.'lock', " ", LOCK_EX)){
	unLock($dev_path.'lock');
	toExit(11, $return_list);
}

//验证id
$id = trim($reqlist[9]);
if($id < 1){
	unLock($dev_path.'lock');
	unLock($user_path.'lock');
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

//检查用户是否已登录
$count = dbCount("qm_users_login", $con, "userid = $userid and status = 1 and deviceid = '$deviceid'");
if($count != 1){
	unLock($dev_path.'lock');
	unLock($user_path.'lock');
	closeDb($con);
	toExit(14, $return_list);
}

$tablename = "qm_wenzhang";

$count = dbCount($tablename, $con, "id = $id");
if($count != 1){
	unLock($dev_path.'lock');
	unLock($user_path.'lock');
	closeDb($con);
	toExit(15, $return_list);
	//文	章不存在
}

$tablename2 = "qm_report_wenzhang";
//验证是否举报过
$count = dbCount($tablename2, $con, "reporterId = $userid and articleId = $id");
if($count > 0){
	unLock($dev_path.'lock');
	unLock($user_path.'lock');
	closeDb($con);
	toExit(16, $return_list);
	//该	用户已经举报过
}

$sql = "select userid from qm_wenzhang where id = $id";
//查作者
$authorId = dbLoad(dbQuery($sql, $con), true);

$data['articleId'] = $id;
$data['reporterId'] = $userid;
$data['intime'] = time();
$data['authorId'] = $authorId['userid'];

if(dbAdd($data, $tablename2, $con)){
	
	//是	否要推送给被举报文章的userid
	/**$sql = "select deviceid from qm_users_login where userid = $authorId and status = 1";
	$dinfo = dbLoad(dbQuery($sql, $con), true);
	if($dinfo['deviceid']){
		$jpush_filename = $j_path.'device/'.getSubPath($dinfo['deviceid'], 4, true)."jpush";
		if(is_file($jpush_filename)){
			$jpushid = file_get_contents($jpush_filename);
			if($jpushid){
				$jp = new Jpush();
				$str = '您收到一个举报';
				$jp->push(array('registration_id'=>array($jpushid)), $str);
			}
		}
	}**/
	
	
	unLock($dev_path.'lock');
	unLock($user_path.'lock');
	closeDb($con);
	toExit(0, $return_list);
}
else{
	unLock($dev_path.'lock');
	unLock($user_path.'lock');
	closeDb($con);
	toExit(302, $return_list);
}

?>
