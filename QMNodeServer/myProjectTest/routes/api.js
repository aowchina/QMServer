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
var user = require('../models/user');
var Order = require('../models/Order');
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


function register(req,res){
	var body = req.body;
	var WCO = consts.WordComAndOmit;
	var uid = body[WCO.body]['uid'];
	var promoterUid1 = body[WCO.body]['promoterUid1'];
	user.register(uid,promoterUid1,function(result) {
		res.status(200).end(result);
	});
}

function getUserList(req,res){
	console.log('getUserList called...');
	var body = req.body;
	var WCO = consts.WordComAndOmit;
	user.getUserList(function(error,result) {
		if(error){
			res.status(200).end('failed');
		}else{
			res.status(200).end(result.toString());
		}
	});
}

function getUser(req,res){
	console.log('getUser called...');
	var body = req.body;
	var WCO = consts.WordComAndOmit;
	var uid = body[WCO.body]['uid'];
	user.getUser(uid,function(error,result){
		if(error){
			res.status(200).end('failed');
		}else{
			res.status(200).end(JSON.stringify(result));
		}
		
	});
}


function addOrder(req,res){
	var body = req.body;
	var WCO = consts.WordComAndOmit;
	var order = {};
	order['uid'] = body[WCO.body]['uid'];
	order['time'] = body[WCO.body]['time'];
	Order.addOrder(order,function(result){
		res.status(200).end(result);
	});
	
}

router.post('/user',function(req,res){
	console.log('post调用了');
	var body = req.body;
	console.log(req.body);
	
    var WCO = consts.WordComAndOmit;
    if (!body[WCO.method]) {
        sendResponse(res, new CSError(errno.API_INVALID_API_FORMAT, 'api data format is invalid.'), {}, body[WCO.method]); 
        return; 
    }
    var method = body[WCO.method];
    var callMethod = method + '(req, res)';
    if (method!=null) {
        eval(callMethod);
    } else {
        sendResponse(res, new CSError(errno.API_INVALID_METHOD, 'api method format is invalid.'), {}, method);
    }
});

router.get('/data', function(req, res) {
	res.status(200).json({result : 400});
});




module.exports = router;
