var redis   = require('redis');
var client  = redis.createClient('6379', '127.0.0.1');

client.on('error',function(error){
    console.log(error);
});

client.auth('123456');

client.get('haha',function(error,result){
    if(error){
        console.log(error);
    }else{
       console.log(result);
    }
});



//string

// client.get('user',function(error,result){
//     if(error){
//         console.log(error);
//     }else{
//        console.log(result);
//     }
// });

// client.set('phone','15301319969',function(error,result){
//     if(error){console.log(error);}
//     else{
//         console.log(result);
//     }
// });

//hash

// client.hgetall('movie',function(error,result){
//     if(error){
//         console.log(error);
//     }else{
//         console.log(result['tags']);
//     }
// });

// client.hmset('movie','title','控方证人','tags','悬疑，多次反转',
//     function(error,result){
//         if(error){console.log(error);}
//         else{
//             client.bgsave();
//             console.log(result);
//         }
// });