var sys = require('util');
var redis = require('redis');
var fs = require('fs');

var logger = require("../common/logger");

function Resque(envPath) {
	var self = this;

	self.envPath = envPath;
	self.queueConf = null;
	self.redisClients = {};
}

Resque.prototype.init = function() {
	var self = this;

	var f = fs.readFileSync(self.envPath + '/conf/resque.conf');
	self.queueConf = JSON.parse(f.toString());
}

Resque.prototype.getRedisConnection = function(serverName, serverId) {
	var self = this;

	var k = 'queue_' + serverName + '_' + serverId;
	var c = self.redisClients[k];
	if (!c) {
		var redisAddr = null;
		if (!self.queueConf[serverName]) {
			redisAddr = self.queueConf['_default'];
		} else {//has serverName
			var subConf = self.queueConf[serverName];
			if (!subConf[serverId]) {
				redisAddr = subConf["_default"];
			} else {// has serverId
				redisAddr = subConf[serverId];
			}
		}

		if (!redisAddr) {
			logger.error('queue for:', serverName, serverId, 'no config');
			return null;
		}

		c = redis.createClient(redisAddr.port, redisAddr.host);
        if (redisAddr.pass) {
            c.auth(redisAddr.pass);
        }
		c.on("error", function (err) {
			logger.info('queue for:', serverName, serverId, 'on error:', sys.inspect(err));
		});
		self.redisClients[k] = c;
	}

	return c;
}

Resque.prototype.send = function(serverName, serverId, msg) {
	var self = this;

	var c = self.getRedisConnection(serverName, serverId);
	if (c) {
		var k = 'queue_' + serverName + '_' + serverId;
		c.lpush(k, JSON.stringify(msg), function(e, res) {
			if (e) {
				logger.error('lpush to ', k, 'error:', sys.inspect(e), 'sending:', msg);
			} else {
				//logger.debug('msg sent to:', k, msg);
			}
		});		
	}
}

Resque.prototype.listen = function(serverName, serverId, callback) {
	var self = this;

	var c = self.getRedisConnection(serverName, serverId);
	if (c) {
		c.on("ready", function () {
			var k = 'queue_' + serverName + '_' + serverId;
			c.brpop(k, 0, function(err, res) {
				if (!err) {
					var m = res[1];
					var msg = null;
					try {
						msg = JSON.parse(m);
					} catch (e) {
						logger.error('bad msg from ', k, m);
					}

					if (msg) {
						callback(msg);						
					}

					c.emit("ready");
				} else {
					logger.error('brpop from ', k, 'error:', sys.inspect(err));
				}
			});
		});
	}
}

exports.init = function(envPath) {
	if (!global.MSG_QUEUE) {
		var r = new Resque(envPath);
		r.init();
		global.MSG_QUEUE = r;
	}
}

exports.listen = function(serverName, serverId, callback) {
    logger.debug('listen:', serverName, serverId);
	global.MSG_QUEUE.listen(serverName, serverId, callback);
}

exports.send = function(serverName, serverId, msg) {
	global.MSG_QUEUE.send(serverName, serverId, msg);
}
