var fs = require('fs');
var async = require('async');
var URL = require('url');

var logger = require('../common/logger');
var consts = require('../common/consts');
var resque = require('../common/resque');
var utils = require('../common/utils');
var commonconf = require('../common/commonconf');
var Sub = require('../common/psub').Subscribe;
var mymysql = require('../common/mymysql');
var myredis = require('../common/myredis');

var errno    = require('../common/errno');
var CSError  = require('../common/error').CSError;

function ASTServer(serverConfig) {
    var self = this;

    self.id = serverConfig.id;
    self.serv_name = serverConfig.serv_name;
    i = 1;
    self.changeSecurityDeposit = setInterval(function(){
        if(i%3==0||i%5==0||i%7==0){
            myredis.getClient().set('securityDeposit',500000+i,function(err){
                if(err){
                    console.log('securityDeposit set error!')
                }
            });
        }
        i++;
        
    },1000*4);
}

//启动服务
ASTServer.prototype.listen = function(callback) {
    var self = this;
    
    var channel = 'QM';
    // var channel = 'queue_' + self.serv_name + '_' + self.id;
    logger.debug('start sub channel : ' , channel);
    self.sub = new Sub(channel);
    self.sub.init();  
    self.sub.listen(function(data) {
        console.log(data);
        getData(data);
    });
}

function getData(name) {
    var params = [];
    params.push(name);
    var pool = mymysql.getMysqlPool();
    var sql = 'select * from user where name = ?';
    pool.getConnection(function(err, connection) {
        connection.query(sql, params, function(err, rows) {
            connection.release();
            if (err) {
                console.log(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                console.log(rows[0]['age']);
            }
        });
    });
}

exports.ASTServer = ASTServer;