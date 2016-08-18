var redis = require('../../common/myredis');
var async = require('async');
var conn = redis.getClient();

function computeProfit(order,callback){
    console.log('models/computeProfit调用啦'+order['uid']);

    async.series([
                function(cb){
                    conn.hgetall('profit_percentage',function(error,result){
                        if(error){
                            cb('computeProfit call failed',null);
                        }else{
                            cb(null,JSON.stringify(result));
                        }
                    });
                },
                function(cb){
                     conn.hgetall('user_'+order['uid'],function(error,result){
                        if(error){
                            cb('computeProfit call failed',null);
                        }else{
                            cb(null,JSON.stringify(result));
                        }
                     });
                }
            ],function(error,result){
                if(error){
                    callback(error,null);
                }else{
                    addProfitRecord(order,result,callback);
                }
            });
 }

 function addProfitRecord(order,result,callback){
     var profit = JSON.parse(result[0]);
     var user_relation = JSON.parse(result[1]);
     var flag = true;
     for(var i = 0;i<3;i++){
         if(user_relation['promoterUid'+(i+1)]){
             var record = {};
             record['uid'] = user_relation['promoterUid'+(i+1)];
             record['level'] = 1;
             record['orderid'] = order['orderid'];
             record['profit'] = order['money']*profit[i+1+''];
             record['time'] = order['time'];
             record['customerid'] = order['uid'];

             conn.hmset('profit_record_'+record['uid']+'_'+record['orderid'],record,function(error,result){
                    if(error){
                        flag = false;
                    }
             });
         }
     }
      if(flag){
             callback(null,'success');
         }else{
             callback('failed',null);
         }

 }

exports.computeProfit = computeProfit;