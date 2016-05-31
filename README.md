# QMServer

###file目录

	功能：大众版本接口
	*客户端调用都在这个里面。
	http://139.196.172.208/qm/api/

###qm目录

	功能：后台功能
	http://139.196.172.208/qm/administrator
	
###server目录

	功能：服务版接口
	*服务人员登录
	*订单绑定
	*查询
	*上传图片
	http://139.196.172.208/qm/serverapi

****Apache应用服务器
数据库配置： 	

	file/functions_mdb.php
	server/functions_mdb.php
	qm/configuration.php
	
静态文件路径配置：

	file/functions_mut.php
	$j_path = "/data/savedata/data_minfo/save_file/quanmei/";   //Josn文件保	存路径
	//$j_path = "/var/www/html/quanmei/";   //Josn文件保存路径
	$s_url = 'http://quanmei.min-fo.com/';                      //后台URL
	$s_path = "/data/pubout/minfo/qm/";                         //后台根目录
	
信息注册、修改、订单状态相关直接操作数据库。其它生成静态页面。
替换原则，每个文件单独生成，然后单个文件替换，在偶然条件会出现状态异常。

需要生成SQL文件。

图片文件的格式检查需要做。
