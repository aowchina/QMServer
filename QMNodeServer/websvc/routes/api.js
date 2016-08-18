var fs = require('fs-extra');
var formidable = require('formidable');
var util = require('util');
var express = require('express');
var router = express.Router();

var consts   = require('../../common/consts');
var logger   = require('../../common/logger');
var errno    = require('../../common/errno');
var CSError  = require('../../common/error').CSError;
var utils   = require('../../common/utils');
var version  = require('../../model/version');
// var user     = require('../../model/user');
var authorize = require('../../model/authorize');
var user = require('../../model/user');
var signUp = require('../../model/signUp');

/* GET users listing. */
router.get('/', function(req, res) {
	// res.send('respond with a resource');
	// show a file upload form
	res.writeHead(200, {'content-type': 'text/html'});
	res.end(
		'<form action="/api/uploadFile" enctype="multipart/form-data" method="post">'+
		'<input type="text" name="token" value="813278524ad4e498"><br>'+
		'<input type="text" name="userId" value="25017"><br>'+
        '<input type="text" name="dataType" value="image"><br>'+
		'<input type="file" name="files" multiple="multiple"><br>'+
		'<input type="submit" value="send">'+
		'</form>'
	);	
});

function sendResponse(res, err, data, method) {
    var WCO = consts.WordComAndOmit;
	var error = {};
	// var s = 200;
	if (err) {
		error[WCO.code] = err.code;
		error[WCO.message] = err.message;
    } else {
		error[WCO.code] = 200;
		error[WCO.message] = '';
	}
	var ret = {};
    
    ret[WCO.error] = error;
    
	if(data!=null) {
		ret[WCO.body] = data;
	}
	if (method!=null) {
		ret[WCO.method] = method;
	}
    // console.log(ret);
	res.status(200).json(ret);
}

function checkLogin(req, res, next) {
    var body = req.body;
    var WCO = consts.WordComAndOmit;
	user.verifySession(body[WCO.userId], body[WCO.token], function(err, verify) {
		if (err) {
			return sendResponse(res, err);
		} else {
			if (verify) {
				return next();
			} else {
				return sendResponse(res, new CSError(errno.API_USER_NOT_LOGIN, 'user need login.'));
			}
		}
	});
}

router.get('/data', function(req, res) {
	user.send2Server('aa');
	res.status(200).json({result : 300});
	
	// sendResponse(res, null, {text : 'Hello GET Test!'}, '');
});

function ttMethod(req, res) {
    var body = req.body;
    var WCO = consts.WordComAndOmit;
    
	user.send2Server(body.b.msg);
	
	signUp.signUp(body[WCO.body][WCO.userId],body[WCO.body][WCO.name],function(msg){
		console.log(msg);
	});

	sendResponse(res, null, {text : 'Hello world'}, body[WCO.method]);
}

//所有用户请求的入口，通过json消息中的method方法进行区别调用
router.post('/user', function(req, res) {
	var body = req.body;
	
    var WCO = consts.WordComAndOmit;
    if (!body[WCO.method]) {
        sendResponse(res, new CSError(errno.API_INVALID_API_FORMAT, 'api data format is invalid.'), {}, body[WCO.method]); 
        return; 
    }
    var method = consts.Type2Method[body[WCO.method]];
    var callMethod = method + 'Method(req, res)';
    if (method!=null) {
        eval(callMethod);
    } else {
        sendResponse(res, new CSError(errno.API_INVALID_METHOD, 'api method format is invalid.'), {}, method);
    }
});

router.post('/version/check', function(req, res) {
    var reqBody = req.body;
    version.check(reqBody.deviceType, reqBody.platformId, reqBody.channelId, reqBody.currentVer, function(err, data) {
        sendResponse(res, err, data, 'versionCheck');
    });
});

module.exports = router;
