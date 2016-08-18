var fs = require('fs');
var async = require('async');
var URL = require('url');

var logger = require('../common/logger');
var consts = require('../common/consts');
var resque = require('../common/resque');
var utils = require('../common/utils');
var commonconf = require('../common/commonconf');
var Sub = require('../common/psub').Subscribe;

var errno    = require('../common/errno');
var CSError  = require('../common/error').CSError;
var Profit = require('./models/Profit');

function ComputeProfitServer(serverConfig) {
    var self = this;

    self.id = serverConfig.id;
    self.serv_name = serverConfig.serv_name;
}

//启动服务
ComputeProfitServer.prototype.listen = function(callback) {
    var self = this;
    
    var channel = 'addOrder';
    // var channel = 'queue_' + self.serv_name + '_' + self.id;
    logger.debug('start sub channel : ' , channel);
    self.sub = new Sub(channel);
    self.sub.init();  
    self.sub.listen(function(data) {
        var order = JSON.parse(data);
        console.log(order);
        Profit.computeProfit(order,function(error,result){
            if(error){
                console.log('failed')
            }else{
                console.log('success');
            }
        });
    });
}

exports.ComputeProfitServer = ComputeProfitServer;