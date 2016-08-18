var sys = require('util');
var buffer = require('buffer');
var events = require('events');
var machina = require('machina');
var socketio = require('socket.io');
var gproto = require("../model/gproto");
var logger = require('../common/logger');
var user = require('../model/user');
var utils = require('../common/utils');
var qrCode = require('../model/qrCode');
var sstate  = require('../model/sstate');

var MAX_MSG_LEN = 1024 * 1024;

var wsclient = function(socket)
{
    var self = this;
    self.heartbeatInterval = 3 * 60 * 1000;
    events.EventEmitter.call(self);

    self.buf = null;
    self.userId = null;
    self.QRCode = null;     //未登录之前的二维码
    self.token = null;
    self.verified = false;
    self.logout = false;
    self.duplicated = false;
    self.kicked = false;
    self.lostHeartbeat = false;
    self.remoteAddr = socket.handshake.address;
    self._idx = 0;
    console.log(self.remoteAddr);

    self.gameInfo = null;
    self.appInfo = [];

    self.lastActive = Date.now();
    self.activeUpdate = function () {
        self.lastActive = Date.now();
    }

    self.checkActiveIntervalId = setInterval(function () {
        var now = Date.now();
        if (now - self.lastActive > self.heartbeatInterval) {
            self.lostHeartbeat = true;
            self.emit('error', 'lost heartbeat.');
        }
    }, 1000 * 5);
    
    self.getQRCode = function() {
        return self.QRCode;
    }
    
    self.clearQRCode = function(callback) {
        if (self.QRCode) {  
            sstate.clearQRCode(self.QRCode, function(err){
                console.log('clear QRCode : ' + self.QRCode);
                self.QRCode=null;
                return callback();
            });
        } else {
            callback();
        }
    }
    
    self.getUserId = function() {
        return self.userId;
    }

    self.close = function() {
        console.log("enter client close function!");
        clearInterval(self.checkActiveIntervalId);        
        socket.disconnect();
    };
    
    self.setIdx = function(idx) {
        return self._idx = idx;
    }

    self.send = function(data) {
        self.activeUpdate();
        // console.log(data);
        // var message = global.TONREN_PROTO.unpackMessage(data);
        // console.log(message);
        return socket.emit('message', data);
    }

    socket.on('error', function(e) {
        self.emit('error', e);
    });
    
	
    //监听用户退出
    socket.on('disconnect', function(obj){
        console.log('this is a disconnect!');
        self.emit('disconnect', socket.id);
    });
	
    //监听用户发布聊天内容
    socket.on('message', function(data){
        self.fsm.handle('msg', data);
    });

    self.fsm = new machina.Fsm({
        initialState : 'unverified',
        states: {
            'unverified' : {
                verify : function (){
                    this.transition('verified');
                },
                msg : function(data) {
                    self.activeUpdate();
                    var message = global.TONREN_PROTO.unpackMessage(data);
                    if (message) {
                        if (message.messageType==global.PROTO_MESSAGETYPE_DEF.Connection) {
                            var body = global.TONREN_PROTO.unpackBody(global.PROTO_MESSAGETYPE_DEF.Connection, message.body);
                            if (body) {
                                var params = {
                                    uid : body.uid.toString(),
                                    sessionKey : body.token
                        	    };
                            	user.verifySession(params.uid, params.sessionKey, function(err, verified) {
                                    if (verified) {
                                        self.verified = true;
                                        self.userId = params.uid;
                                        self.fsm.handle('verify');
                                        self.emit('user', self.userId, data);
                                    } else {
                                        logger.debug('verify is not ok!', err);
                                        var bodyError = {
                                            errorType : 1
                                        };
                                        var packet = global.TONREN_PROTO.packSimpleMessage(global.PROTO_MESSAGETYPE_DEF.Error, bodyError, message.head);   
                                        socket.emit('message', packet);
                                    }
                            	});
                            } else {
                                logger.error('connection format is wrong!');                                
                            }
                        } else if (message.messageType==global.PROTO_MESSAGETYPE_DEF.GetQRCodeOp){ //获取二维码
                            var packet = null;
                            qrCode.getWebQRCode(self.QRCode, self._idx, function(err, code){
                                if (err) {
                                    packet = global.TONREN_PROTO.packSimpleMessage(global.PROTO_MESSAGETYPE_DEF.Error, bodyError, message.head);   
                                    self.QRCode = null;
                                } else {                                    
                                    var bodyCode = {
                                        code : global.HTTP_WEBSOCKET_SERVER.qrLink + code
                                    };
                                    var buf = global.TONREN_PROTO.packBody(global.PROTO_MESSAGETYPE_DEF.GetQRCodeOp, bodyCode);
                                    bodyCode = buf.toBuffer();
                                    var body = {
                                        messageType : global.PROTO_MESSAGETYPE_DEF.GetQRCodeOp,
                                        body : bodyCode
                                    }

                                    packet = global.TONREN_PROTO.packSimpleMessage(global.PROTO_MESSAGETYPE_DEF.AckMsg, body, message.head);   
                                    self.QRCode = code;
                                }
                                socket.emit('message', packet);
                            });
                        } else {
                            logger.error('not verified');
                        }
                    } else {
                        logger.error('data is not valid message!');                        
                    }
                },
                '*' : function() {
                    logger.error('not verified');
                }
            },
            'verified' : {
                _onEnter : function() {
                    ;
                }, 
                msg : function(data) {
                    self.activeUpdate();
                    self.emit('msg', data);
                }
            }
        }
    });
}

sys.inherits(wsclient, events.EventEmitter);
exports.wsclient = wsclient;
