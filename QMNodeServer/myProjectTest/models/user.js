var redis = require('../../common/myredis');
var async = require('async');

function register(uid,promoterUid1,callback){
    console.log('register调用啦');
    var conn = redis.getClient();
    var user = {};
    user.uid = uid;
    user.promoterUid1 = promoterUid1;

    getPromoterUid(promoterUid1,function(res) {
        user.promoterUid2 = res;
        getPromoterUid(res,function(res){
            user.promoterUid3 = res;
            conn.hmset('user_'+uid,user,function(err){
                if(err){
                    console.log(err);
                }else{
                    callback(uid+" register success");
                }
            });
        });
    });
 }

 function getUser(uid,callback){
     console.log('model getUser called');
     redis.getClient().hgetall('user_'+uid,function(error,result){
        if(error){
            console.log('failed');
            callback(error,null);
        }else{
            console.log(result);
            callback(null,result);
        }
     });
 }

 function getUserList(callback){
     console.log('model getUserList called');
     var users = [];

     async.waterfall([
         function(cb){
              redis.getClient().keys('user_*',function(error,result){
                    if(error){
                        cb(error,null);
                    }else{
                        cb(null,result);
                    }
              })
         },
         function(cb){
             redis.getClient()
         }
     ],function(error,result){

     });
    
 }



function getPromoterUid(uid,callback){
    var conn = redis.getClient();
    conn.hmget('user_'+uid,'promoterUid1',function(err,res){
        if(err){
            console.log(err);
        }else{
            callback(res);
        }
    });
}

exports.register = register;
exports.getUser = getUser;
exports.getUserList = getUserList;