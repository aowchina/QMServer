var myredis = require('../common/myredis');
var async = require('async');

function modifyJoinedTime(group, callback) {
    var dateNow = Date.now();
    var k = 'grp_mem_' + group;
    myredis.getClient().lrange(k, 0, -1, function(err, data) {
        if (err) {
            callback(err);
        } else {
            var idsl = data.length;
            var s = 0;
            async.whilst(
                function(){ 
                    return s < idsl; 
                }, function(cb){
                    var key = 'grp_mem_info_' + group + '_' + data[s];
                    var datejoin = dateNow + s;
                    s++;
                    myredis.getClient().hgetall(key, function(errInfo, info) {
                        if (!errInfo) {
                            if(info) {
                                info['joined'] = datejoin;
                                myredis.getClient().hmset(key, info, function(errUpdate) {
                                    if (!errUpdate) {
                                        console.log(key);
                                    }
                                    return cb(null);
                                });
                            } else {
                                return cb(null);
                            }
                        } else {
                            console.log(key + ' : err');
                            return cb(null);
                        }

                    });
                },
                function(err){
                    return callback(null);
                }
            );              
        }
    });    
}

function modifyAllJoinedTime() {
    var k = 'group_*';
    myredis.getClient().keys(k, function(err, data) {
        if (err) {
            callback(err);
        } else {
            var idsl = data.length;
            var s = 0;
            async.whilst(
                function(){ 
                    return s < idsl; 
                }, function(cb){
                    var keydata = data[s].split('_');
                    s++;
                    if (keydata.length>2) {
                        return cb(null);
                    }
                    modifyJoinedTime(keydata[1], function(errInfo, info){
                        // console.log(keydata + ' : err');
                        return cb(null);
                    });
                },
                function(err){
                    console.log('modifyAllJoinedTime, is ok');
                }
            );            
        }
    });
};

//这个函数更新所有群组的joined时间啊
// modifyAllJoinedTime();