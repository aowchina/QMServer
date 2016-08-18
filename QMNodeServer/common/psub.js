var fs = require('fs');
var redis = require('redis');
var sys = require('util');

var logger = require('../common/logger');
var gproto = require('../model/gproto');

function Redis() {
    var self = this;

    self.createConnection = function(callback) {
        var host = '127.0.0.1';
        var port = 6379;
        var conf = null;
        var pass = '';
        try {
            conf = JSON.parse(fs.readFileSync('./conf/psub.conf').toString());
            host = conf.host;
            port = conf.port;
            pass = conf.pass;
        } catch (e) {
            logger.error('psub.conf parse error:', sys.inspect(e));
        }
        logger.debug('psub redit host :', host, 'port:', port, 'pass:', '*');
        var conn = redis.createClient(port, host);
        if(pass) {
            conn.auth(pass);
        }
        conn.on('error', function(err) {
            logger.error('redis client on error:', sys.inspect(err));
        });
        // logger.info('redis connection created.');    
        callback(conn);
    }
}

function Sub(channel) {
    var self = this;

    self.channel = channel;
    if (!self.channel) {
        self.channel = 'default_channel';
    }
    self.subAddr = null;
    self.init = function() {
        if (self.subAddr) {
            return ;
        }
        var rd = new Redis();
        rd.createConnection(function(conn) {
            self.subAddr = conn;
        });
    }

    self.listen = function(callback) {
        if (self.subAddr == null) {
            // callback('no init');
            return ;
        }
        self.subAddr.subscribe(self.channel);

        self.subAddr.on('ready', function(res) {
            logger.info(self.channel , 'is ready.');
        });
        
        self.subAddr.on('message', function(channel, keyData) {
            try {
                callback(keyData);
            } catch (e){
                logger.error('redis client on error:', sys.inspect(e));
            }
        });
    }
}

function Pub(channel) {
    var self = this;
    
    self.channel = channel;
    self.pubAddr = null;
    self.init = function() {
        if (self.pubAddr) {
            return ;
        }
        var rd = new Redis();
        rd.createConnection(function(conn) {
            self.pubAddr = conn;
        });
    }

    self.pubMsg = function(msg) {
        // console.log('pub msg ' + self.channel + ' ' + msg);
        self.pubAddr.publish(self.channel, msg);
    }

    self.pubJ2S = function(msg) {
        var strMsg = null;
        try {
            strMsg = JSON.stringify(msg);
        } catch (e) {
        }
        self.pubAddr.publish(self.channel, strMsg);
    }
}

exports.Subscribe = Sub;
exports.Publish = Pub;

