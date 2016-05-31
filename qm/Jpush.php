<?php
/* 
 * 极光推送工具类
 * author wangrui
 * date 2015-04-27
 */
class Jpush{
    private $app_key = 'bd95a381727b3c334a617d49';        //待发送的应用程序(appKey)，只能填一个。
    private $master_secret = '6afdd811d8b15c761ff79c60';  //主密码
    private $url = "https://api.jpush.cn/v3/push";        //推送的地址
    //private $url = 'https://api.jpush.cn/v3/push/validate';
    //private $url = 'https://report.jpush.cn/v3/received?msg_ids=1916108235';

    public function push($receiver = 'all', $content = '', $m_time='86400'){
        $base64 = base64_encode("$this->app_key:$this->master_secret");
        $header = array("Authorization:Basic $base64","Content-Type:application/json");
        $data = array();
        $data['platform'] = 'all';          //目标用户终端手机的平台类型android,ios,winphone
        $data['audience'] = $receiver;      //目标用户
       
        $data['notification'] = array(
                 //安卓自定义
                "android"=>array(
                        "alert"=>$content,
                        "title"=>"",
                        "builder_id"=>1
                ),
                //ios的自定义
                "ios"=>array(
                        "alert"=>$content,
                        "badge"=>"+1",
                        "sound"=>""
                )
        );

        //附加选项
        $data['options'] = array(
                "sendno"=>time(),
                "time_to_live"=>$m_time, //保存离线时间的秒数默认为一天
                "apns_production"=>false, //布尔类型   指定 APNS 通知发送环境：0开发环境，1生产环境。或者传递false和true
        );
        $param = json_encode($data);
        $res = $this->push_curl($param,$header);
         
        if($res){       //得到返回值--成功已否后面判断
            var_dump($res);exit;
            //file_put_contents('/data/savedata/data_minfo/save_file/quanmei/dblock/j_error.txt', $res);
        }else{          //未得到返回值--返回失败
            
            //file_put_contents('/data/savedata/data_minfo/save_file/quanmei/dblock/j_error.txt', '123');
        }
    }

    //推送的Curl方法
    public function push_curl($param="",$header="") {
        if (empty($param)) { return false; }
        $postUrl = $this->url;
        $curlPost = $param;
        $ch = curl_init();                                      //初始化curl
        curl_setopt($ch, CURLOPT_URL,$postUrl);                 //抓取指定网页
        curl_setopt($ch, CURLOPT_HEADER, 0);                    //设置header
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);            //要求结果为字符串且输出到屏幕上
        curl_setopt($ch, CURLOPT_POST, 1);                      //post提交方式
        curl_setopt($ch, CURLOPT_POSTFIELDS, $curlPost);
        curl_setopt($ch, CURLOPT_HTTPHEADER,$header);           // 增加 HTTP Header（头）里的字段
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);        // 终止从服务端进行验证
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        $data = curl_exec($ch);                                 //运行curl
        curl_close($ch);
        return $data;
    }
}
?>