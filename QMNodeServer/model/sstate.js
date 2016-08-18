var crypto = require('crypto');
var async  = require('async');

var error   = require('../common/error');
var utils   = require('../common/utils');
var consts  = require('../common/consts');
var logger  = require('../common/logger');
var myredis = require('../common/myredis');

function SState() {
}

SState.prototype.setQRcode = function(qrcode, socket, callback) {
    var self = this;

    var client = myredis.getClient();
    client.hset('qrcode', qrcode, socket, function(err) {
        callback(err);
    });
}

SState.prototype.existGroupCode = function(qrcode, callback) {
    var self = this;

    var client = myredis.getClient();
    client.get(qrcode, function(err, code) {
        if (err) {
            callback(null, true);
        } else {
            if(code) {
                callback(null, true);
            } else {
                callback(null, false);
            }
        }
    });
}

SState.prototype.setGroupCode = function(group, callback) {
    var self = this;
    var tsInMs = Date.now();
    var key = 'gpcode_'+ group + '_' + tsInMs/1000;
    var delay = 7 * 24 * 60 * 60;
    var client = myredis.getClient();
    client.setex(key, delay, tsInMs, function(err) {
        return callback(err, key);
    });
}

SState.prototype.getQRcode = function(qrcode, callback) {
    var self = this;

    var client = myredis.getClient();
    client.hget('qrcode', qrcode, function(err, socket) {
        if (err) {
            callback(err);
        } else {
            if(socket) {
                callback(null, socket);
            } else {
                callback({code : -1});
            }
        }
    });
}

SState.prototype.clearQRCode = function(qrcode, callback) {
    var self = this;    
    var client = myredis.getClient();
    client.hdel('qrcode', qrcode, function (err) {
        callback(err);
    });
}

SState.prototype.getUserEndPoint = function(phone, callback) {
    var self = this;

    var client = myredis.getClient();
    var key = 'user_state:$' + phone + '$';
    client.hmget(key, 'connName', 'connId', 'ip', function(err, data) {
        if (err) {
            callback(err);
        } else {
            var serverName = data[0];
            var serverId = data[1] ? parseInt(data[1]) : null;
            var clientIp = data[2];
            callback(null, serverName, serverId, clientIp);
        }
    });
}

SState.prototype.setUserEndPoint = function(phone, connName, connId, clientIp, callback) {
    var self = this;

    var client = myredis.getClient();
    var key = 'user_state:$' + phone + '$';
    client.hmset(key, 'connName', connName, 'connId', connId, 'ip', clientIp, function(err, data) {
        callback(err);
    });
}

SState.prototype.getVerifyCode = function(phone, callback) {
    var self = this;

    var client = myredis.getClient();
    var key = 'user_code:$' + phone + '$';

    client.hmget(key, 'code', 'timeStamp', function(err, data) {
        if (err) {
            callback(err);
        } else {
            if (data && data[0] != null) {
                var code = data[0];
                var timeStamp = data[1];
                
                callback(null, {phone: phone, code: code, timeStamp: timeStamp});
            } else {
                callback({code : -1}, null);
            }
        }
    });
}

SState.prototype.setVerifyCode = function(phone, code, callback) {
    var self = this;

    var client = myredis.getClient();
    var key = 'user_code:$' + phone + '$';
    var timeStamp = new Date().getTime()/1000;
    client.hmset(key, 'code', code, 'timeStamp', timeStamp, function(err, data) {
        if (err) {
            callback(err);
        } else {
            callback(null, {phone : phone, code : code, timeStamp : timeStamp})
        }
    });
}

SState.prototype.clearVerifyCode = function(phone, callback) {
    var self = this;    
    var client = myredis.getClient();
    var key = 'user_code:$' + phone + '$';
    client.del(key, function (err, data) {
        callback(err);
    });
}

// 离线时清除
SState.prototype.clearState = function(phone, connName, connId, callback) {
    var self = this;

    self.getUserEndPoint(phone, function(err, serverName, serverId) {
        if (err) {
            callback(err);
        } else if (serverName == connName && serverId == connId) {
            var client = myredis.getClient();
            var key = 'user_state:$' + phone + '$';
            client.del(key, function (err, data) {
                callback(err);
            });
        } else {
            callback(null);
        }
    });
}

global.SSTATE = global.SSTATE ? global.SSTATE : new SState();

module.exports = global.SSTATE;
