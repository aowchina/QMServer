var util = require('util');
var https = require('https');
var utils = require('../common/utils');
var errno = require('../common/errno');
var consts = require('../common/consts');
var CSError  = require('../common/error').CSError;
var parseXml2Json = require('xml2js').parseString;

// 环境地址
var _host = 'app.cloopen.com';
var _port = 8883;
var _accountId = '8a48b55150b86ee80150c5f18dbd22b0';
var _accountAuthToken = '1741d484fd124321bcc62264dda11c75';
var _imAppId = 'aaf98f89512446e2015142560f8b5882';
var _urlPath = '/2013-12-26/Accounts/' + _accountId + '/SMS/TemplateSMS?sig=';

function httpsRequest(options, content, callback) {
	// console.log(options);
	var req = https.request(options, function(res) {
		res.setEncoding('utf8');
		var resData="";
		res.on('data', function (chunk) {
			resData += chunk;
		});
		
		res.on('end', function(){
			parseXml2Json(resData, function (err, result) {
   	 			console.dir(JSON.stringify(result));
				if (result.Response.statusCode[0]==='000000') {
                    var ret = {};
                    ret[consts.WordComAndOmit.status] = 1;
					callback(null, ret);
				} else {
					callback(new CSError(errno.API_SEND_AUTH_CODE_FAIL, "send authorize code is fail!"));
				}
			});			
		});

		req.on('error', function(e) {
			callback(e.message);
			console.log('problem with request: ' + e.message);
		});
	});
	  
	req.write(content + '\n');   
	req.end(); 
}

exports.sendAuthCode = function(mobile, code, timeStamp, from, callback) {
	var body = {
		'appId': _imAppId,
		'to': mobile,
        'templateId' : 91122,
        'datas': []
	};
    body.datas.push(code);
	var content = JSON.stringify(body);
    console.log(content);

	var strTimeStamp = utils.getDateTimeyyyyMMddHHmmss(timeStamp);

	var b = new Buffer(_accountId + ':' + strTimeStamp);
	var auth = b.toString('base64');
	var sig = _accountId + _accountAuthToken + strTimeStamp;
	var pathp = _urlPath + utils.md5(sig).toUpperCase();

	var options = {
	    method : "post",
	    host: _host,
	    port: _port,
	    path: pathp,
	    headers: {
	    	'Authorization': auth,
	        'Content-Type': 'application/json;charset=utf-8',
	        'Content-Length': content.length
	    }  
	};
	
	httpsRequest(options, content, callback);
}
