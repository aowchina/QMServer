var fs = require('fs');
var http = require('http');
var socketio = require('socket.io');
var logger = require('../common/logger');
var consts = require('../common/consts');
var gproto = require('../model/gproto');
var resque = require('../common/resque');
var utils = require('../common/utils');
var Pub = require('../common/psub').Publish;
var Sub = require('../common/psub').Subscribe;
var wsclient = require('./wsclient');
var redisMod = require('../model/redisMod');

const MAX_CLIENT_NUM = 10000;

function WebsocketServer(serverConfig) {
    var self = this;

    self.id = serverConfig.id;
    self.serv_name = serverConfig.serv_name;

    self.host = serverConfig.content.server.host;
    self.port = serverConfig.content.server.port;
    
    //重新定义消息队列名称，是一个有意义的
    self.channel = 'queue_' + self.serv_name + '_' + self.id;

    self.outChannel = serverConfig.content.channel.out;
    self.qrLink = serverConfig.content.channel.qrlink;
    //基准的客户端编号，是为了让proxy可以做分布的
    self.clientIndex = self.id * MAX_CLIENT_NUM;
    self.clientArray = [];
    self.idxMap = {};

    for (var i = 0; i < MAX_CLIENT_NUM; i ++) {
        self.clientArray[i] = null;
    }
    
    self.server = http.createServer(handler).listen(self.port, self.host, function() {
        logger.debug('listening at: http://', self.host, ':', self.port);
    });
    
    global.HTTP_WEBSOCKET_SERVER = self;
}

//当不知道什么原因的时候才会调用这里吧。
function handler(req, res) {
    res.writeHead(200, {'Content-type' : 'text/html'});
    res.write('<h1>Node.js</h1>');
    res.end('<p>Hello World</p>');
}

//启动服务
WebsocketServer.prototype.listen = function(callback) { 
    var self = this;
    
    logger.info('global.HTTP_WEBSOCKET_SERVER.qrLink :', global.HTTP_WEBSOCKET_SERVER.qrLink);
    
    logger.info('wait channel queue :', self.outChannel);
    self.pub = new Pub(self.outChannel);
    self.pub.init();
        
    var socket = socketio.listen(self.server, {origins: '*:*'});
    socket.on('connection', self.onNewConnection);

    logger.info('push channel queue :', self.channel);
    self.sub = new Sub(self.channel);
    self.sub.init();
    self.sub.listen(function(msgInfo) {
        var body = {};
        var msg = {};
        logger.debug('resque msg', msgInfo);
        try {
            var msgData = msgInfo.split(':');
            if (msgData.length>=3) {
                //如果是发给客户端的消息
                if (msgData[0]==consts.WsMsgType.WS_S2C) {
                    body.userId = msgData[1];
                    redisMod.getNotifyMessage(msgData[2], function(err, msgNotify){
                        if (!err) {
                            body.data = msgNotify;
                            self.procResqueMsg(body);
                        } else {
                            logger.error('>>>>>>>>get message is wrong, will be your message maybe some error!');            
                        }
                    });
                } else if (msgData[0]==consts.WsMsgType.WS_S2WS) { //如果是发给本服务的消息
                    logger.debug('发给你的消息需要处理');
                }  else if (msgData[0]==consts.WsMsgType.WS_HTTP2WS) { //从web服务器那边过来的消息，比如二维码扫描登录
                    if(msgData[1]==0) { //通知用户谁扫描了消息
                        try {
                            body.uid = msgData[4]; //扫描用户的ID
                            redisMod.getBriefUserInfo(body.uid, function(err, userInfo){
                                if (!err) {
                                    body.uname = userInfo[0];
                                    body.head=utils.addFdfsPrefix('default');
                                    if (userInfo[2]) {
                                        body.head = utils.addFdfsPrefix(userInfo[2]);
                                    }
                                    var packet = global.TONREN_PROTO.packSimpleMessage(global.PROTO_MESSAGETYPE_DEF.MobileScanQRCodeOp, body);                            
                                    //下面发送消息了
                                    var idx = msgData[3];
                                    var client = self.clientArray[idx%MAX_CLIENT_NUM];
                                    if (client) {
                                        client.send(packet);
                                    } else {
                                        logger.error('clientArray not find', idx);
                                    }                                    
                                } else {
                                    logger.error('uid is not exist, uid :', body.uid);
                                }
                            });
                        } catch (e) {
                            logger.error('error packing response:', msg, util.inspect(e));
                        }                        
                    } else if(msgData[1]==1) {
                        body.uid = msgData[4]; //扫描用户的ID
                        body.token = msgData[5];
                        body.expiredTime = 24 * 60 * 60;    //超时的秒数是
                        try {
                            //下面生成并发送消息
                            var packet = global.TONREN_PROTO.packSimpleMessage(global.PROTO_MESSAGETYPE_DEF.MobileAcceptQRLoginOp, body);                            
                            //下面发送消息了
                            var idx = msgData[3];
                            var client = self.clientArray[idx%MAX_CLIENT_NUM];
                            if (client) {
                                client.clearQRCode(function(){
                                    client.send(packet);
                                });
                            } else {
                                logger.error('clientArray not find', idx);
                            }                            
                        } catch (e) {
                            logger.error('error packing response:', msg, util.inspect(e));
                        } 
                    }
                }
            }
        } catch (e) {
            logger.error("exception:", e.stack);
        }    
    });    
}

//产生序号
WebsocketServer.prototype.genClientIndex = function(c) {
    var self = this;
    while (true) {
        self.clientIndex++;
        if (self.clientIndex == (self.id+1) * MAX_CLIENT_NUM) {
            self.clientIndex = self.id * MAX_CLIENT_NUM;
        }

        if (self.clientArray[self.clientIndex%MAX_CLIENT_NUM] == null) {
            self.clientArray[self.clientIndex%MAX_CLIENT_NUM] = c;
            return self.clientIndex;
        }
    }
}

//这个函数处理的本地的内容，然后调用Client的关闭函数
WebsocketServer.prototype.closeSocket = function(idx, data) {
    logger.debug('will close socket ', idx);
    var self = this;

    var c = self.clientArray[idx%MAX_CLIENT_NUM];
    if (!c) {
        logger.error('on close, client index:', idx, 'not found');
        return;
    }
    
    c.clearQRCode(function(){
        if (c.userId) {
            try {
                //这个需要单独处理
                var msgId = Number(consts.WsMsgType.WS_WS2S) + ":" + c.userId + ":0:null";
                // console.log('push ' + msgId); 
                //写入redis的消息队列
                self.pub.pubMsg(msgId);
                //如果有需要继续发送的数据
                logger.debug('send close message to server ', msgId);

                if(data) {
                    self.Send2Server(c.userId, data);
                }
                //下面生成并发送消息
                var body = {
                    errorType : global.PROTO_MESSAGE_DEF.ErrorType.KickUserOffline
                };
                var packet = global.TONREN_PROTO.packSimpleMessage(global.PROTO_MESSAGETYPE_DEF.Error, body);
                c.send(packet);
            } catch (e) {
                logger.error("exception:", e.stack);
            }
            logger.debug('closeSocket : uid :', c.userId, ', idx:', idx);
            delete self.idxMap[c.userId];
        }

        c.close();
        self.clientArray[idx%MAX_CLIENT_NUM] = null;
    });
}

WebsocketServer.prototype.procResqueMsgUnicast = function(userId, msg) {
    var self = this;
    var idx = self.idxMap[userId];
    if (undefined === idx) {
        logger.error('idxMap not find uid :', userId);
        return;
    }

    var client = self.clientArray[idx%MAX_CLIENT_NUM];
    if (!client) {
        logger.error('clientArray not find uid :', userId, idx);
        return;
    }

    client.send(msg);
}

WebsocketServer.prototype.procResqueMsg = function(msg) { 
    var self = this;

    if (msg.userId == null || msg.userId == "") {
        for(var u in self.idxMap) {
            self.procResqueMsgUnicast(u, msg);
        }
    } else {
        // console.log(msg.data);
        // var message = global.TONREN_PROTO.unpackMessage(msg.data);
        // console.log(message);

        self.procResqueMsgUnicast(msg.userId, msg.data);
    }
}

WebsocketServer.prototype.Send2Server = function(uid, data) {
    var self = this;
    var msgId = utils.uuid();
    redisMod.pushNotifyMessage(msgId, data, function(err){
        if(!err) {
            msgId = Number(consts.WsMsgType.WS_C2S) + ":" + uid + ":notify_" + msgId;
            logger.debug('push message =>' , msgId);
            // console.log(data);
            // var message = global.TONREN_PROTO.unpackMessage(data);
            // console.log(message);
            //写入redis的消息队列
            self.pub.pubMsg(msgId);
        } 
    });
}

WebsocketServer.prototype.onNewConnection = function(s) {
    var self = this;

    logger.debug("enter on new connection function!");
    
    var self = global.HTTP_WEBSOCKET_SERVER;

    var c = new wsclient.wsclient(s);
    var idx = self.genClientIndex(c);
    c.setIdx(idx);
    logger.debug('gene idx from client! idx :', idx);
    
    c.on('disconnect', function(obj){
        logger.debug('on new connection will disconnect from client! idx :', idx);
        self.closeSocket(idx);
    });
    
    c.on('msg', function(data) {
        try {
            self.Send2Server(c.userId, data);
        } catch (e) {
            logger.error("exception:", e.stack);
        }
    });

    c.on('scheduler', function() {
        logger.debug('on scheduler call!');
    });
    
    c.on('user', function(uid, data){
        try {
            var idxOld = self.idxMap[uid];
            if (idxOld) {
                if (idx!=idxOld) { //如果重新发送登陆消息成功，我不关闭socket的
                    logger.debug('idx not equal old. close socket :', idx, idxOld);
                    self.closeSocket(idxOld, data);
                }
            } else {
                self.Send2Server(uid, data);
            }
        } catch (e) {
            logger.error("exception:", e.stack);
        }
        
        self.idxMap[uid] = idx;
    });

    c.on('error', function(e) {
        if (c.userId){
            logger.error(c.userId, 'error', e);
        } else {
            logger.error('error', e);
        }
        logger.debug('client has some error. will close socket :', e);
        self.closeSocket(idx);
    });
}

exports.WebSocketServer = WebsocketServer;