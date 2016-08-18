var redis = require("redis");
var mysql = require("mysql");
var consistenthash = require("./consistenthash");
var logger  = require('./logger');

function MRIntf() {
    this.cacheClientPool = [];
}

MRIntf.prototype.initConfig = function(confPath) {
    this.cacheHash = new consistent_hash.ConsistentHash(confPath + "cache.conf");
    this.mysqlHash = new consistent_hash.ConsistentHash(confPath + "mysql.conf");
    this.redisConfig = JSON.parse(fs.readFileSync(confPath + "redis.conf"));
}

MRIntf.prototype.getCacheClient = function(userId) {
    var self = this;

    if (!userId) {
        userId = "";
    }

    var CacheClient = function(userId) {
        var client = null;
        if (self.cacheClientPool.length > 0) {
            client = self.cacheClientPool.pop();
            logger.debug("get CacheClient from pool, left:", self.cacheClientPool.length);
        } else {
            var h = self.cacheHash.getInstance(userId);        
            client = redis.createClient(h.node.port, h.node.ip);
            client.on('error', function() {});
            logger.debug("create new CacheClient");
        }

        this.getUser = function(callback) {
            client.hget(cacheKey, userId, function(err, data) {
                if (err) {
                    callback(new error.AowError(error_def.ERR_STORAGE_FAILED, err), null);
                } else {
                    var obj = null;
                    try {
                        obj = JSON.parse(data);
                    } catch (e) {
                        callback(new error.AowError(error_def.ERR_JSON_PARSE_ERROR, 'parse failed:' + data + e));
                        return;
                    }

                    callback(null, obj);
                }
            });
        }

        this.remUser = function(callback) {
            client.hdel(cacheKey, userId, function(err) {
                if (err) {
                    callback(new error.AowError(error_def.ERR_STORAGE_FAILED, err), null);
                } else {
                    callback(null);
                }
            });
        }

        this.setUser = function(value, callback) {
            var d = JSON.stringify(value);
            client.hset(cacheKey, userId, d, function(err) {
                if (err) {
                    callback(new error.AowError(error_def.ERR_STORAGE_FAILED, err), null);
                } else {
                    callback(null);
                }
            });
        }

        this.close = function() {
            self.cacheClientPool.push(client);
            logger.debug("put CacheClient to pool, now:", self.cacheClientPool.length);
        }
    }

    return new CacheClient(userId);
}

MRIntf.prototype.getDBClient = function(userId) {
    var self = this;

    if (!userId) {
        userId = "";
    }

    var DBClient = function(userId) {
        var h = self.mysqlHash.getInstance(userId);

        var client = mysql.createConnection({
            host     : h.node.dbhost,
            user     : h.node.dbuser,
            password : h.node.dbpass,
            database : h.node.dbname
        });
        client.on('error', function(err) {});

        this.query = function(sql, sqlArgs, callback) {
            client.query(sql, sqlArgs, function(err, result) {
                if (err) {
                    callback(new error.AowError(error_def.ERR_STORAGE_FAILED, err), null);
                } else {
                    callback(null, result);
                }
            });
        }

        this.close = function() {
            client.destroy();
        }
    }

    return new DBClient(userId);
}

global.MR_INTERFACE = global.MR_INTERFACE ? global.MR_INTERFACE : new MRIntf();

module.exports = global.MR_INTERFACE;