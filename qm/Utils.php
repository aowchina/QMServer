<?php
/* 
 * 公共变量与公共方法
 * author wangrui
 * date 2015-04-27
 */
class Utils{
    private $j_path = "/Users/ewonder/phpWorkspace/QMServer/quanmei/";
    //private $j_path = "/Library/WebServer/Documents/projects/duiwai/1_quanmei/v1.0/server/qm/data/";

    private $exp_rule_name = '/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9]{4,10}$/u';    //规则名称的正则
    private $exp_event_name = '/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9-_]{2,15}$/u';   //赛事名称的正则

    private $exp_mobile_telnum = "/^1[3-5,8]{1}[0-9]{9}$/";  //手机号正则
    private $exp_fixed_telnum = "/^([0-9]{3,4}-)?[0-9]{7,8}$/";  //固定电话正则

    private $exp_zh_name = "/^[\x{4e00}-\x{9fa5}|·]+$/u";    //验证中文姓名正则，允许：汉字，汉字·汉字
    private $exp_en_name = "/^[a-zA-Z·.\s]+$/";              //验证英文姓名正则，允许：英文.英文，英文 英文，英文·英文，英文

    private $exp_zhcn = '/^[\x{4e00}-\x{9fa5}]+$/u';    //验证汉字的正则
    private $exp_engb = '/^[a-zA-Z]+$/';                //验证大小写字母的正则

    //验证医院名称
    public function isName($name, $tag){
        switch($tag){
            case 1:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9\s]{3,20}$/u";    //医院名称
                break;
            case 2:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z\,\，\、\。]{3,80}$/u";       //职称名称
                break;
            case 3:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9\s\,\，\、\。\（\）\(\)]{2,80}$/u";    //主攻方向
                break;
            case 4:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z]{2,8}$/u";    //小组名称
                break;
            case 5:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9\s\,\，\、\。\（\）\(\)]{2,80}$/u";    //小组简介
                break;
            case 6:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z]{2,8}$/u";    //小组的标签名
                break;
            case 7:
                $exp = "/^[\x{4e00}-\x{9fa5}|0-9-]{2,15}$/u";    //价格范围
                break;
            case 8:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9-\,\，\、]{2,15}$/u";    //拆线时间
                break;
            case 9:
                $exp = "/^[\x{4e00}-\x{9fa5}|a-zA-Z0-9-\,\，\、\+\（\）\(\)]{2,30}$/u";    //特惠名称
                break;
            case 10:
                $exp = "/^[0-9]{1,8}+$/";
                break;
        }

        if(preg_match($exp, $name)){
            return true;
        }
        return false;
    }

    //验证图片名与类型
    public function isImg($str){
        $img_name = JFile::getName($str);
        $img_name_list = explode(".", $img_name);
        if(count($img_name_list == 2)){
            if(preg_match("/^[0-9a-zA-Z_]+$/", $img_name_list[0]) && ($img_name_list[1] == 'png' || $img_name_list[1] == 'jpg' || $img_name_list[1] == 'jpeg')){
                return true;
            }
        }
        return false;
    }

    /*--验证姓名相关方法开始--*/
    public function isXingming($str){
        if(preg_match($this->exp_zh_name, $str)){
            return $this->isZhcnName($str);
        }
        elseif(preg_match($this->exp_en_name, $str)){
            return $this->isEngbName($str);
        }
        else{
            return false;
        }
    }

    //验证是否为中文名
    private function isZhcnName($name){
        if(strpos($str, '·')){
            return $this->checkItemName($name, '·', $this->exp_zhcn);
        }
        return true;
    }

    //验证是否为英文名
    private function isEngbName($name){
        if(strpos($name, '·')){
            return $this->checkItemName($name, '·', $this->exp_engb);
        }
        elseif(strpos($str, '.')){
            return $this->checkItemName($name, '.', $this->exp_engb);
        }
        elseif(strpos($str, ' ')){
            return $this->checkItemName($name, ' ', $this->exp_engb);
        }
        return true;
    }

    private function checkItemName($str, $tagstr, $exp){
        $name_list = explode($tagstr, $str);
        if(count($name_list) == 2){
            foreach($name_list as $item){
                if(!preg_match($exp, $item)){
                    return false;
                }
            }
            return true;
        }
        return false;
    }
    /*--验证姓名相关方法结束--*/

    /**
     * 根据 $baseStr，截取 $subAmount 次，每次截取2位，拼接成相对路径
     * @param $baseStr: 被截取的字符串
     * @param $subAmount: 被截取次数
     * @param $includeStr: 是否包括$baseStr
     * author wangrui@min-fo.com
     * date 2015-05-01
     */
    public function getSubPath($baseStr, $subAmount, $includeStr){
        $re_path = '';
        for($i = 0; $i <= $subAmount; $i++){
            $re_path = $re_path.substr($baseStr, $i*2, 2).'/';
        }
        if($includeStr){
            $re_path = $re_path.$baseStr.'/';
        }
        return trim($re_path);
    }

    /*
     * 创建指定目录
     */
    public function mkdirs($dir){    
        return is_dir($dir) or ($this->mkdirs(dirname($dir)) and mkdir($dir, 0777));
    }

    /**
     * 将byte拼接成的字符串转换成原本字符串
     * @param $mByteStr: byte字符串拼接成的字符串
     * @return 还原后的字符串
     * author wangrui@min-fo.com
     * date 2014-09-17
     */
    public function getStrFromByte($mByteStr){
        $str = "";
        $byte_list = explode("#", $mByteStr);
        for($i = 0; $i < count($byte_list); $i++){
            $str .= chr($byte_list[$i]);
        }

        return trim($str);
    }

    /**
     * 获取json文件保存路径
     * author wangrui
     * date 2015-04-27
     */
    public function getJsonPath($tag){
        switch($tag){
            case 1:
                $re_path = 'hospital';
                break;
            case 2:
                $re_path = 'project';
                break;
            case 3:
                $re_path = 'group';
                break;
            case 4:
                $re_path = 'tehui';
                break;
            case 5:
                $re_path = 'act';
                break;
            case 6:
                $re_path = 'doctor';
                break;
            case 7:
                $re_path = 'pl';
                break;
            case 8:
                $re_path = 'teacher';
                break;
            case 9:
                $re_path = 'course';
                break;
            case 10:
                $re_path = 'baoxian';
                break;
        }

        return $this->j_path.$re_path.'/';
    }

    /**
     * 删除指定目录下的所有文件
     * @param $dir: 指定目录
     * author wangrui@min-fo.com
     * date 2014-09-25
     */
    public function delDirFile($dir){
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
    public function delPath($path, $n){
        if($n > 0){
            $path_list = explode("/", $path);
            $this->delDir($path);

            $dir_length = strlen($path_list[count($path_list) - 1]) + 1;  //得到刚刚删除的这个文件夹的文件夹名长度，+1是因为"/"
            $str_length = 0 - $dir_length;                                
            $now_path = substr($path, 0, $str_length);                   //得到删除之后的路径名
            $now_int = $n - 1;
            $this->delPath($now_path, $now_int);
        }
    }

    /**
     * 若文件夹为空，删除文件夹
     * @param $dir: 文件夹名
     * author wangrui@min-fo.com
     * date 2014-09-27
     */
    private function delDir($dir){
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
}
?>