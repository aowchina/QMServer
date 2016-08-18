
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
 	    port: 8000,
 	    path: '/api/user/',  
 	    headers: {
            // "Cookie" : "uid=567cfaaebab3efdb072b4bef; skey=2f80d5cf209255f4",
	        'Content-Type': 'application/json',//;charset=utf-8;',
	        'Content-Length': content.length
	    }  
	};

	console.log(options);
	var req = http.request(options, function(res) {
		console.log('STATUS: ' + res.statusCode);
		console.log('HEADERS: ' + JSON.stringify(res.headers));
		
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
bodyData[WCO.body][WCO.userId] = '006';
bodyData[WCO.body][WCO.name] = 'sunny005';

var data = JSON.stringify(bodyData);


console.log(data);

sendRequest(data);
