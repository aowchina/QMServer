var fs = require('fs');
var redis = require('redis');
var sys = require('util');

var logger = require('../common/logger');

var _redisConnection = null;
var _redisRawConnection = null;

exports.getClient = function() {
	if (!_redisConnection) {
		var host = '127.0.0.1';
		var port = 6379;
        var pass = '';

		var conf = null;
		try {
			conf = JSON.parse(fs.readFileSync('conf/redis.conf').toString());
			host = conf.host;
			port = conf.port;
            pass = conf.pass;
			console.log(fs.readFileSync('conf/redis.conf').toString());
		} catch (e) {
			
		}

        _redisConnection = redis.createClient(port, host);
        if (pass) {
            _redisConnection.auth(pass);
        }
        _redisConnection.on('error', function(err) {
            console.log('redis client on error:', sys.inspect(err));
        });
        console.log('redis connection created.');
	}

	return _redisConnection;
}

exports.getRawClient = function() {
	if (!_redisRawConnection) {
		var host = '127.0.0.1';
		var port = 6379
        var pass = '';

		var conf = null;
		try {
			conf = JSON.parse(fs.readFileSync('conf/redis.conf').toString());
			host = conf.host;
			port = conf.port;
            pass = conf.pass;
		} catch (e) {
		}

        _redisRawConnection = redis.createClient(port, host, {'return_buffers': true});
        if (pass) {
            _redisRawConnection.auth(pass);
        }
        _redisRawConnection.on('error', function(err) {
            console.log('redis client on error:', sys.inspect(err));
        });
        console.log('redis connection created.');
	}

	return _redisRawConnection;
}