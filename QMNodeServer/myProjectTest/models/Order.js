var redis = require('../../common/myredis');
var addOrderPub = require('../addOrderPub');

function addOrder(order,callback){
    console.log('addOrder调用啦');
    var conn = redis.getClient();
    order['money'] = Math.round(Math.random()*10000);
    order['orderid'] = new Date().getTime();

    conn.hmset('order_record_'+order['uid']+'_'+order['orderid'],order,function(err,result){
        if(err){
            console.log(err);
        }else{
            callback('add order success');
            
            addOrderPub.send2Server(JSON.stringify(order));
        }
    });
 }


exports.addOrder = addOrder;