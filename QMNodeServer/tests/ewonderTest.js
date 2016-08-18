
var flags = require('flags');
var http = require('http');
var qs = require('querystring'); 
var https = require('https');
var utils    = require('../common/utils');
var consts = require('../common/consts');

var xml2Json = require('xml2js').parseString;

var fs = require('fs');

flags.defineString('name', 'ewonder', 'my name');

flags.defineStringList('one', []);
flags.parse(['--one=a,b,c,d']);

// exports.name = function() {
// 	console.log(flags.get('one'));
// };

var utf8 = require("utf8");

function sendRequest(content) {
	console.log(content);

	var options = {  
	    method : "post",  
	    host: '127.0.0.1',
 	    port: 80,
 	    path: '/qm/api/public/getSecurityDeposit.php',  
 	    headers: {
            // "Cookie" : "uid=567cfaaebab3efdb072b4bef; skey=2f80d5cf209255f4",
	        'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8;',
	        'Content-Length': content.length
	    }  
	};

	console.log(options);
	var req = http.request(options, function(res) {
		console.log('STATUS: ' + res.statusCode);
		//console.log('HEADERS: ' + JSON.stringify(res.headers));
		
		res.setEncoding('utf8');
		var _data="";

		res.on('data', function (chunk) {
			_data += chunk;
			console.log('BODY: ' + chunk);
		});

		res.on('end', function(){
			console.log("REBOAK:",_data)
		});

		req.on('error', function(e) {
			console.log('problem with request: ' + e.message);
		});
	});
	  
	// write data to request body  
	req.write(content);   
	req.end(); 
}

var WCO = consts.WordComAndOmit;

//=================================>
//login？？？？？
var bodyData = { 
	'b' : {
	}
};
bodyData[WCO.method] = consts.Method2Type['tt'];
bodyData[WCO.body]['msg'] = 'aa';
//=================================<


// bodyData[WCO.method] = consts.Method2Type['login'];
// bodyData[WCO.body][WCO.phoneNumber] = '13511013305';
// bodyData[WCO.body][WCO.password] = utils.md5('123456');
// bodyData[WCO.body][WCO.loginType] = 1;
//=================================<

//=================================>
// delEmotion???
// bodyData[WCO.method] = consts.Method2Type['delEmotion'];
// bodyData[WCO.body][WCO.ids] = ['http://www.ourgame.com', 'http://www.baidu.com'];
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '9c13dd8ccb7a8b97';
//=================================<


//=================================>
// getEmotions???
// bodyData[WCO.method] = consts.Method2Type['getEmotions'];
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '9c13dd8ccb7a8b97';
//=================================<


//=================================>
// setEmotion???
// bodyData[WCO.method] = consts.Method2Type['setEmotion'];
// bodyData[WCO.body][WCO.key] = 'http://www.tongren.com';
// bodyData[WCO.body][WCO.msg] = {
//     me : 'tongren',
//     you : 'mr.zhou'
// };
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '9c13dd8ccb7a8b97';
//=================================<


// var bodyData = {
// 	"k":"v"
// }

// var bodyData = {
// 	"method":"getRegisterVerificationCode",
// 	"body":{
// 		"phoneNumber":"18500150900"
// 	}
// }
// =================================>
// getRegisterVerificationCode???
// bodyData[WCO.method] = consts.Method2Type['getRegisterVerificationCode'];
// bodyData[WCO.body][WCO.phoneNumber] = '18500150900';
// =================================<
//=================================>
// getForgetVerificationCode???
// bodyData[WCO.method] = consts.Method2Type['getForgetVerificationCode'];
// bodyData[WCO.body][WCO.phoneNumber] = '18500150900';
//=================================<

//=================================>
// getUserInfoByPhone???
// bodyData[WCO.method] = consts.Method2Type['getUserInfoByPhone'];
// bodyData[WCO.body][WCO.phoneNumber] = '18500150900';
// bodyData[WCO.body][WCO.verificationCode] = '6418'
//=================================<

//=================================>
// modiUserNick???
// bodyData[WCO.method] = consts.Method2Type['modiUserNick'];
// bodyData[WCO.body][WCO.nickName] = 'Ewonder Zhou';
// bodyData[WCO.body][WCO.friendId] = '8193';
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '6285afa3c056ca15_1_0bb29393b43634a8';
//=================================<

//=================================>
// isExist???
// bodyData[WCO.method] = consts.Method2Type['isExist'];
// bodyData[WCO.body][WCO.phoneNumber] = '18701336756';
//=================================<

//=================================>
// modifyUserInfo???
// bodyData[WCO.method] = consts.Method2Type['modifyUserInfo'];
// bodyData[WCO.body][WCO.nickName] = 'Ewonder';
// bodyData[WCO.body][WCO.city] = 'Harbin';
// bodyData[WCO.body][WCO.sign] = 'You are my duty!!!';

// bodyData[WCO.userId] = '2049';
// bodyData[WCO.token] = 'b356f2795c5525df_1_07eb3f01cbb30405';
//=================================<
//=================================>
// getOfflineMessage???
// bodyData[WCO.method] = consts.Method2Type['getOfflineMessage'];
// bodyData[WCO.userId] = '629740059154712577';
// bodyData[WCO.token] = '7c8c892e3daceef4';
//=================================<

//=================================>
// getAllFriends???
// bodyData[WCO.method] = consts.Method2Type['getAllFriends'];
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = 'd98c962f3094c6ed';
//=================================<

//=================================>
// quitGroup???
// bodyData[WCO.method] = consts.Method2Type['quitGroup'];
// bodyData[WCO.body][WCO.groupId] = '6145';
// bodyData[WCO.userId] = '8193';
// bodyData[WCO.token] = '02fda3bd2677d47c_1_fa26ea535e313953';
//=================================<

//=================================>
// inviteMember???
// bodyData[WCO.method] = consts.Method2Type['inviteMember'];
// bodyData[WCO.body][WCO.ids] = ['6145','8193'];
// bodyData[WCO.body][WCO.groupId] = '6145';
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '6285afa3c056ca15_1_0bb29393b43634a8';
//=================================<

//=================================>
// dissolveGroup???
// bodyData[WCO.method] = consts.Method2Type['dissolveGroup'];
// bodyData[WCO.body][WCO.groupId] = '100000018433';
// bodyData[WCO.userId] = '6145';
// bodyData[WCO.token] = '5858bfd311c1145d';
//=================================<

//=================================>
// getGroupInfo???
// bodyData[WCO.method] = consts.Method2Type['getGroupInfo'];
// bodyData[WCO.body][WCO.groupId] = '100000019457';
// bodyData[WCO.userId] = '3073';
// bodyData[WCO.token] = '4280cb79ca7ff8ed';
//=================================<

//=================================>
// getGroupBasicInfo???
// bodyData[WCO.method] = consts.Method2Type['getGroupBasicInfo'];
// bodyData[WCO.body][WCO.groupId] = '1259482999561389057';
// bodyData[WCO.userId] = '629740059154712577';
// bodyData[WCO.token] = '7c8c892e3daceef4';
//=================================<

//=================================>
// getGroupList???
// bodyData[WCO.method] = consts.Method2Type['getGroupList'];
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = 'd98c962f3094c6ed';
//=================================<

//=================================>
// groupKickUser???
// bodyData[WCO.method] = consts.Method2Type['groupKickUser'];
// bodyData[WCO.body][WCO.groupId] = '100000019457';
// bodyData[WCO.body][WCO.ids] = ['10241'];
// bodyData[WCO.userId] = '3073';
// bodyData[WCO.token] = '4280cb79ca7ff8ed';
//=================================<

//=================================>
// getGroupUserInfo???
// bodyData[WCO.method] = consts.Method2Type['getGroupUserInfo'];
// bodyData[WCO.body][WCO.ids] = ['9217'];
// bodyData[WCO.body][WCO.groupId] = '6145';
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '6285afa3c056ca15_1_0bb29393b43634a8';
//=================================<

//=================================>
// setGroupOwner???
// bodyData[WCO.method] = consts.Method2Type['setGroupOwner'];
// bodyData[WCO.body][WCO.owner] = '9217';
// bodyData[WCO.body][WCO.groupId] = '6145';
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '6285afa3c056ca15_1_0bb29393b43634a8';
//=================================<

//=================================>
// joinGroup???
// bodyData[WCO.method] = consts.Method2Type['joinGroup'];
// bodyData[WCO.body][WCO.groupId] = '100000038913';
// bodyData[WCO.userId] = '3073';
// bodyData[WCO.token] = '4280cb79ca7ff8ed';
//=================================<


// var bodyData = { 
// 	'method' : 'modifyUserInfo',
// 	'body' : {
// 		'nickname' : 'Ewonder Chow',
// 		'city': 'Beijing'
// 	},
// 	'userId': 25026,
// 	'token':'eb622a52268720ea'
// };


// var bodyData = { 
// 	'method' : 'addFriend',
// 	'body' : {
// 		'friend' : '13964297822'
// 	},
// 	'userId': 25007,
// 	'token':'0477e51ea0e908e3'
// };

//=================================>
// logout???
// bodyData[WCO.method] = consts.Method2Type['logout'];
// bodyData[WCO.userId] = '3073';
// bodyData[WCO.token] = '4280cb79ca7ff8ed';
//=================================<

//=================================>
// addFriend???
// bodyData[WCO.method] = consts.Method2Type['addFriend'];
// bodyData[WCO.body][WCO.friendId] = '6145';
// bodyData[WCO.userId] = '6145';
// bodyData[WCO.token] = '5858bfd311c1145d';
//=================================<


//=================================>
// getMessageSync???
// bodyData[WCO.method] = consts.Method2Type['getMessageSync'];
// bodyData[WCO.body][WCO.friendId] = '1025';
// bodyData[WCO.body][WCO.sequenceType] = 0;
// // bodyData[WCO.body][WCO.hasMinnumSeq] = 0;
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = 'd98c962f3094c6ed';
//=================================<

//=================================>
// getGroupQRCode???
// bodyData[WCO.method] = consts.Method2Type['getGroupQRCode'];
// bodyData[WCO.body][WCO.groupId] = '1278163533581900801';
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = '4e907114c5cf74df';
//=================================<

//=================================>
// existGroupCode???
// bodyData[WCO.method] = consts.Method2Type['existGroupCode'];
// bodyData[WCO.body][WCO.code] = 'tongren://gpcode_1278163533581900801_1466842700.449';
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = '219d35e4cccd6931';
//=================================<

//=================================>
// createGroup???
// bodyData[WCO.method] = consts.Method2Type['createGroup'];
// bodyData[WCO.body][WCO.ids] = ['2049','4097','7169'];
// bodyData[WCO.body][WCO.name] = 'myGroup';
// bodyData[WCO.body][WCO.tempId] = '123456';
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = '4e907114c5cf74df';
//=================================<

//=================================>
// inviteMember???
// bodyData[WCO.method] = consts.Method2Type['inviteMember'];
// bodyData[WCO.body][WCO.ids] = ['5121','14337'];
// bodyData[WCO.body][WCO.groupId] = '100000045057';
// bodyData[WCO.userId] = '3073';
// bodyData[WCO.token] = '4280cb79ca7ff8ed';
//=================================<

// var bodyData = { 
// 	'method' : 'acceptAddFriend',
// 	'body' : {
// 		'friend' : '13964297822'
// 	},
// 	'userId': 25007,
// 	'token':'0477e51ea0e908e3'
// };
//=================================>
// acceptAddFriend???
// bodyData[WCO.method] = consts.Method2Type['acceptAddFriend'];
// bodyData[WCO.body][WCO.friendId] = '1025';
// bodyData[WCO.userId] = '2049';
// bodyData[WCO.token] = 'cf60e893c8ad8fb8';
//=================================<

//=================================>
// getServerConfig???
// bodyData[WCO.method] = consts.Method2Type['getServerConfig'];
//=================================<

// var bodyData = { 
// 	'method' : 'removeFriend',
// 	'body' : {
// 		'friend' : '18701336756'
// 	},
// 	'userId': 25004,
// 	'token':'172deca5faa100a6'
// };

// var bodyData = { 
// 	'method' : 'getUserInfo',
// 	'body' : {
// 		'key' : '25004'
// 	},
// 	'userId': 25004,
// 	'token':'730911901895d2b3'
// };
//=================================>
// getUserInfo???
// bodyData[WCO.method] = consts.Method2Type['getUserInfo'];
// bodyData[WCO.body][WCO.userId] = '7169';
// bodyData[WCO.userId] = '7169';
// bodyData[WCO.token] = '6285afa3c056ca15_1_0bb29393b43634a8';
//=================================<

//=================================>
// mGetUserInfo???
// bodyData[WCO.method] = consts.Method2Type['mGetUserInfo'];
// bodyData[WCO.body][WCO.ids] = ['8193', '18601138127', '8888'];
// bodyData[WCO.userId] = '3073';
// bodyData[WCO.token] = '4280cb79ca7ff8ed';
//=================================<

// var bodyData = { 
// 	'method' : 'mGetUserInfo',
// 	'body' : {
// 		'ids' : ['25021','25019']
// 	},
// 	'userId': 25026,
// 	'token':'eb622a52268720ea'
// };
// var stringd = '小';
// var d = stringd.toString("utf8");;

// var bodyData = { 
// 	'method' : 'searchUser',
// 	'body' : {
// 		'key' : '18'
// 	},
// 	'userId': 25013,
// 	'token':'f0efa189084f1d0a'
// };

// var bodyData = { 
// 	'method' : 'isExist',
// 	'body' : {
// 		'phoneNumber' : '18601138127'
// 	}
// };


// var bodyData = { 
// 	'method' : 'modifyPassword',
// 	'body' : {
// 		'password' : '123456',
// 		'newPassword' : '123456'
// 	},
// 	'userId': 25013,
// 	'token':'f0efa189084f1d0a'
// };

// var bodyData = { 
// 	'method' : 'modifyUserInfo',
// 	'body' : {
// 		'nickname' : 'Ewonder Chow',
// 		'city': 'Beijing'
// 	},
// 	'userId': 25026,
// 	'token':'eb622a52268720ea'
// };

// var bodyData = { 
// 	'method' : 'getUserInfo',
// 	'body' : {
// 		'key' : '25021'
// 	},
// 	'userId': 25026,
// 	'token':'eb622a52268720ea'
// };

// var bodyData = {
// 	"appId": 'aaf98f89512446e2015142560f8b5882',
// 	'verifyCode':'0708',
// 	'playTimes':'2',
// 	'to': '18500150900',
// 	'displayNum':'13511013305',
// 	'maxCallTime':'60'
// };

// var bodyData = {
// 	"method":"forgetPassword",
// 	"body":{
// 		"phoneNumber":"18500150900",
// 		"verificationCode":"6441",
// 		"password":"123456"
// 	}
// }

// var bodyData = { 
// 	'method' : 'register',
// 	'body' : {
// 		'phoneNumber' : '13511013305',
// 		'nickname' : 'Zhou',
// 		'verificationCode': '7885',
// 		'password' : '123456'
// 	}
// };
//=================================>
// register???
// bodyData[WCO.method] = consts.Method2Type['register'];
// bodyData[WCO.body][WCO.phoneNumber] = '18500150900';
// bodyData[WCO.body][WCO.nickName] = 'Me';
// bodyData[WCO.body][WCO.verificationCode] = '6790';
// bodyData[WCO.body][WCO.password] = '123456';
// //=================================<

//=================================>
// modifyPassword???
// bodyData[WCO.method] = consts.Method2Type['modifyPassword'];
// bodyData[WCO.body][WCO.password] = '123456';
// bodyData[WCO.body][WCO.newPassword] = '123456';
// bodyData[WCO.userId] = '630715987607440385';
// bodyData[WCO.token] = '219d35e4cccd6931';
// //=================================<

//=================================>
// forgetPassword???
// bodyData[WCO.method] = consts.Method2Type['forgetPassword'];
// bodyData[WCO.body][WCO.phoneNumber] = '13511013305';
// bodyData[WCO.body][WCO.verificationCode] = '5370';
// bodyData[WCO.body][WCO.password] = '345678';
// //=================================<

// console.log( bodyData.body.userIds.length  + 'nge ' );

// https://sandboxapp.cloopen.com:8883
var data = JSON.stringify(bodyData);
// var udata = utf8.encode(data);
// data = utils.uuid();
// var strArr = data.split('-');
// data = strArr.join('') 

console.log(data);

var databody='p0=5&p1=7000000004&p2=2&p3=7ghmTh3zod4r6eWaXxhdZBrnAgHqMqiDfFjInJBZCYuZcgkWRtALBeJP23vVG6H7LRyOhR2qkhsE8NdJf%2bPZUQ%3d%3d&p4=g%2bf1%2bsrXwy2IqC%2fS541htMOytv5dTdkYy9kmq0E4Qu74aNGDMM%2bGcCGW9R2JiA02Kox87fuoatg7BBanpGmH1g%3d%3d';
sendRequest(databody);
// 
// var testFile = '/Users/zhouzc/Documents/workspace/PartnerIM/PartnerIMServer/tests/75.pic.jpg';

// utils.fileMd5(testFile, function(err, data){
//     if (err) {
//         console.log(err);
//     } else {
//         console.log("file md5 : " + data);
//     }
// });

// var fs = require('fs')
// var FdfsClient = require('fdfs-client');
// var debug = require('debug')('fdfs');
// var fdfs = new FdfsClient({
//     // tracker servers
//     trackers: [
//         {
//             host: '101.200.214.123',
//             port: 22122
//         }
//     ],
//     // 默认超时时间10s
//     timeout: 1000*30,
//     charset: 'utf8',
//     logger: {
//         log: debug
//     }
// });
// var states = fs.statSync(testFile);

// console.log("size : " + states.size);

// var rs = fs.createReadStream(testFile);
// // var buffer = fs.readFileSync(testFile);
// fdfs.upload(rs,  {
//     // 指定文件存储的group，不指定则由tracker server分配
//     group: 'group1',
//     // file bytes, file参数为ReadableStream时必须指定
//     size: states.size,
//     // 上传文件的后缀，不指定则获取file参数的后缀，不含(.)
//     ext: 'file'

// }, function(err, fileId) {
//     if (!err) {
//         console.log(fileId);
//     } else {
//         console.log(err);
//     }
// })

// fs.readFile(testFile, 'utf-8' , function(err, buf){ 
//     if(!err){ 
//         fdfs.upload(buf, {
//             size: states.size,
//             ext: 'file'

//         }, function(err, fileId) {
//             if (!err) {
//                 console.log(fileId);
//             } else {
//                 console.log(err);
//             }
//         });
//     } else {
//         console.log(err);
//     }
// });


// fdfs.upload(buffer, {
//     // 指定文件存储的group，不指定则由tracker server分配
//     group: 'group1',
//     // file bytes, file参数为ReadableStream时必须指定
//     size: states.size,
//     // 上传文件的后缀，不指定则获取file参数的后缀，不含(.)
//     ext: 'file'

// }, function(err, fileId) {
//     if (!err) {
//         console.log(fileId);
//     } else {
//         console.log(err);
//     }
// })

// fs.readFile('/Users/zhouzc/Documents/workspace/PartnerIM/PartnerIMServer/tests/pptv.dmg','utf-8',function(err, data){  
//     if(err){  
//         console.log(err + " : " + data);  
//     }else{  
//         var buf = new Buffer(8 * 1024);
//     }  
// }) 

// sendRequest(data);
// var redisMod = require('../model/redisMod');
// var k = 'notify_a993f9c0087211e6ad4e2d57263dbf42';

// redisMod.getNotifyMessage(k, function(err, data) {
//     if (!err) {
//         for (var i=0;i<data.length;i++) {
//             console.log(data[i].toString(16));
//         }
//         console.log(data.length);
//         console.log(data[data.length-1]);
//         // var dataStr = data.toString();
//         // console.log(dataStr);
//         var data2Str = utils.binaryArray2HexStr(data);
//         console.log(data2Str);
//     } 
// });


// var headUrl = 'userId' + '_' + Math.ceil(new Date().getTime()/1000) + '_' + utils.getSequence();
// console.log(headUrl);
// headUrl = 'userId' + '_' + Math.ceil(new Date().getTime()/1000) + '_' + utils.getSequence();
// console.log(headUrl);
// var sqlite3 = require('sqlite3').verbose();
// var async = require('async');
// var str = "";

// function selectFromDB(dbName, operation, callback) {
//     var db = new sqlite3.Database(dbName, function () {
//         db.all(operation, function (err, res) {
//         	db.close();
//             if (!err) {
//                 // str = JSON.stringify(res);
//                 return callback(null, res);
//             } else {
//                 return callback(err);
//             }
//         });
//     }); 
// }

// selectFromDB(
// 	'/Users/ewonder/Documents/workspace/PartnerIM/PartnerIMServer/tests/db_weather.db', 
// 	"select _id as province_id, name from provinces", 
// 	function (err, data){
//     if (err) {
//         console.log(err);
//     }
//     else {
//     	var cityArray = {};

//     	// console.log(data);
//     	data.forEach(function(item){
//     		// cityArray.push(cityItem);
//     		var sql = 'select name from citys where province_id=' + (item['province_id']-1).toString();
//     		// console.log(sql);
//     		selectFromDB(
//     			'/Users/ewonder/Documents/workspace/PartnerIM/PartnerIMServer/tests/db_weather.db',
//     			sql.toString(),
//     			function(uerr, udata) {
//     				// console.log(udata);
// 			    	var cityItem = {
// 			    		'province' : item['name'],
// 			    		'citys' : {}
// 			    	};
// 			    	// var curCity = '';
// 			    	var dataCitys = {};
// 			    	udata.forEach(function (row) {
// 			    		var citys = row.name.split('.');
// 			    		if (citys.length==2) {
// 			    			console.log(citys[1]);
// 	            			dataCitys[citys[0]].push(citys[1]);	
// 			    		} else {
// 			    			// curCity = citys[0];
// 			    			dataCitys[citys[0]] = [];
// 			    			dataCitys[citys[0]].push(citys[0]);   			
// 			    		}


//         			});
// 		    		// cityItem['province'] = item['name'];
//     				// cityItem['citys'] = JSON.stringify(udata);
//     				cityArray[item['name']] = dataCitys;
//     				// console.log(cityArray);
//     			}
//     		);
// 		});

//     	setTimeout(function(){
//     		console.log(JSON.stringify(cityArray, 2));
//   		}, 3000);
//     } 
// });

// module.exports = ewonderTest;

// db.users.find( { nickname: /明/i } );

// db.users.find( {nickname : { $regex: '明', $options: 'i' }});

// db.users.find( { $or : [{userId : 明}, {phone : 明}, {nickname: { $regex: 明, $options: 'i' }}]});

// db.users.find({nickname : { $regex : '明', $options: 'i'}});
