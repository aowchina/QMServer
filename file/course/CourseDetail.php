<?php
/**
 * 课程详情
 * 接口参数: 8段 * 课程id
 * author wangrui@min-fo.com
 * date 2015-11-13
 */
include_once("../functions_mut.php");

//验证参数个数
if(!(count($reqlist) == 9)){
    unLock($dev_path.'lock');
    toExit(6, $return_list);
}

$id = intval(trim($reqlist[8]));
if($id < 1){
	unLock($dev_path.'lock');
    toExit(10, $return_list);
}

$filename = $j_path.'teacher/'.$id;
if(is_file($filename)){
	$r_data = array();

    $teacher_info = json_decode(file_get_contents($filename), true);
    $course_filename = $j_path.'course/'.$teacher_info['courseid'];

    if(is_file($course_filename)){
    	$r_data['teacher_name'] = $teacher_info['name'];
	    $r_data['teacher_intro'] = $teacher_info['intro'];
	    
	    $course_info = json_decode(file_get_contents($course_filename), true);
	    $r_data['course_name'] = $course_info['name'];
	    $r_data['course_intro'] = $course_info['intro'];
	    $r_data['course_price'] = $course_info['price'];
        $r_data['course_banner'] = $s_url.$course_info['banner'];
        $r_data['course_id'] = $course_info['id'];

	    $return_list['data'] = json_encode($r_data);
		unLock($dev_path.'lock');
		toExit(0, $return_list, false);
    }else{
    	unLock($dev_path.'lock');
    	toExit(12, $return_list);
    }
}
else{
    unLock($dev_path.'lock');
    toExit(11, $return_list);
}

?>
