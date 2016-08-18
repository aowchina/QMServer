var redisMod = require('../model/redisMod');
var async = require('async');
var utils = require('../common/utils');

var v18 = 0;
var v19 = 0;
var idsl = 10000 * 10;
var s = 0;

console.log(utils.getDateTimeString(Date.now()*0.001));
async.whilst(
    function(){ 
        return s < idsl; 
    }, function(_cb){
        redisMod.genGroupId(1, function(err, data){
            if (data.length==18) {
                v18++;
            } else if(data.length==19) {
                v19++;
            }
            s++;
            _cb(null);
        });
    },
    function(err){
        console.log('v18 : ' + v18);
        console.log('v19 : ' + v19);
        console.log(utils.getDateTimeString(Date.now()*0.001));
    }
);


//625931804737537033
//625931965765256202
//625932069213570059
// exit(0);