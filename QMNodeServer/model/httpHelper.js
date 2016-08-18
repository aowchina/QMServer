var fs = require('fs-extra');

var https = require('https');
var http = require('http');
var url = require('url');
var buffer = require('buffer');
var request = require('request');
var utils   = require('../common/utils');

function getFileData(urlLink, callback) {
    var req = http.get(urlLink, function(res) {        
        var nread = parseInt(res.headers['content-length']);
        var pos = 0;
        var buf = new buffer.Buffer(nread);
        req.on('data', function(chunk) {
            // var buffer = new Buffer(chunk);
            // fs.appendFile(dirName + "/" + fileName, buffer, function(err){});
            chunk.copy(buf, pos);
            pos += chunk.length;
        });
        
        res.on('end', function() {
            if (res.statusCode != 200) {
                return callback("bad status code " + res.statusCode);
            }
            return callback(null, buf);
        });

    });

    req.setTimeout(1000*10, function() {
        req.abort();
        return callback("query timed out");
    });
 
    req.on('error', function(e) {//get req error
        return callback(e);
    });
}

exports.getFile = function(linkUrl, callback) {
    fs.ensureDirSync('./filedir');
    var filename = "./filedir/" + utils.uuid() + '.jpg';
    if (linkUrl) {
        request(linkUrl, function (error, response, body) {
            if (!error && response.statusCode == 200) {
            } else {
                fs.createReadStream('./default').pipe(fs.createWriteStream(filename));
            }
            callback(null, filename);
        }).pipe(fs.createWriteStream(filename));
    } else {
         fs.createReadStream('./default').pipe(fs.createWriteStream(filename));
         callback(null, filename);
    }
}

exports.getJSON = function(options, callback) {
    var protocolModule = null;
    if ('https' == options.protocol) {
        protocolModule = https;
    } else if ('http' == options.protocol) {
        protocolModule = http;
    } else {
        callback('protocol not supported:' + options.protocol);
        return;
    }
    
    var fullURL = url.format(options);
    var req = protocolModule.get(fullURL, function(res) {
        res.setEncoding('utf8');
        var resBody = "";
        res.on('data', function(c) { resBody += c; });
        res.on('end', function() {
            if (res.statusCode != 200) {
                callback("bad status code " + res.statusCode);
                return;
            }
            //console.log('fb res', resBody);
            var resObj = {};
            try {
                resObj = JSON.parse(resBody);
            } catch (e) {
                callback('json parse err' + e);
                return;
            }
            callback(null, resObj);
        });

    });

    req.setTimeout(options.timeoutMS, function() {
        req.abort();
        callback("query timed out");
    });
 
    req.on('error', function(e) {//get req error
        callback(e);
    });
}
