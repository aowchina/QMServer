#服务器说明
###下面所有服务都是基于nodejs
##web服务

	express技术
	可以通过nginx来做前端
	

##wsproxy中转服务
	
	socket.io技术提供基础, web版本的消息中转服务。
	web通过websocket进行连接
	消息会通过redis进行转发路由到消息服务器，消息服务出来以后会应答回来。
	"server" : {
        "host" : "0.0.0.0",      //服务器的IP地址
        "port" : 808${SERVER_ID} //会根据端口和服务器的编号进行组合
    },
    "channel" : {
        "out" : "ws_msg_0"		  //输出的队列
    }
	

##ATServer辅助服务
	
	当用户创建群组或者增加减少用户，这个服务来提供群组的头像生成和设置。
	文件服务器的配置, host表示track server的群组ip地址。
	"fdfs" : {
        "host" : ["10.44.177.240","101.200.214.123"],
        "port" : 22122
    }


