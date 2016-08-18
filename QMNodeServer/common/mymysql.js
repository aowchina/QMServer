var fs = require('fs');
var mysql = require('mysql');

var logger = require('../common/logger');

var _mysqlPool = null;

exports.getMysqlPool = function() {
    if (_mysqlPool == null) {
        var host = '127.0.0.1', port = 3306, user = 'root', password = '123456', database = 'user';
        var conf = null;
        try {
            var config = fs.readFileSync('conf/mysql.conf');
            conf = JSON.parse(config.toString());
            host = conf.host;
            port = conf.port;
            user = conf.user;
            password = conf.password;
            database = conf.database;
        } catch (e) {
        }

        _mysqlPool  = mysql.createPool({
            connectionLimit : 10,
            host            : host,
            port            : port,
            user            : user,
            password        : password,
            database        : database
        });

        logger.debug('mysql pool created.');
    }

    return _mysqlPool;
}