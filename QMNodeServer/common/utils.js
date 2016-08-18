var os = require("os");
var util = require('util');
var crypto = require("crypto");
var fs = require('fs');
var nodeUUID = require('node-uuid');
var UUID = require('uuid-js');
var consts  = require('./consts');

var DAY_LENGTH_MS = 86400000;

var getUTCDayCount = function(timestampMS) {
    return Math.floor(timestampMS / DAY_LENGTH_MS);
}
exports.getUTCDayCount = getUTCDayCount;

var UTCDayCountMinus = function(d1, d2) {
    return getUTCDayCount(d1.getTime()) - getUTCDayCount(d2.getTime());
}

exports.UTCDayCountMinus = UTCDayCountMinus;

exports.getTickCount = function() {
	return Math.floor(Date.now() / 1000);
}

exports.getTodayUTC = function() {
	var now = new Date();

	return Math.floor((now.getTime() - now.getTimezoneOffset() * 60000) / 86400000);
}

exports.getUTCDayFromTick = function(tickCount) {
    var now = new Date();
	return Math.floor((tickCount - now.getTimezoneOffset() * 60) / 86400);
}

exports.boundedRoundedRand = function(min,max,round){
	return min + (Math.floor( ((max - min) / round) * Math.random() + 0.5 ) * round);
}

exports.makeLogData = function(key, value){
	return '[' + key + '=' + value + ']';
}

exports.getRandIdxFromProbSumArray = function(arr){
	var dice = Math.random();
	for(var i in arr){
		if (dice < arr[i])
			return i;
	}
	//should never reach
	return arr.length -1;
}

exports.getProbSumArrayFromProbDistro = function(arr){
	var res = [];
	var curSum = 0.0;
	for(var i in arr){
		curSum += arr[i];
		res.push(curSum);
	}
	return res;
}

global.SVR_INCREMENT = global.SVR_INCREMENT ? global.SVR_INCREMENT : Math.floor(Math.random() * 10000);

exports.getUniqueID = function() {
	var ts = Date.now();
	var host = os.hostname();
	var pid = process.pid;
	var increments = global.SVR_INCREMENT++;

	if (global.SVR_INCREMENT >= 0xFFFFFFFF) {
		global.SVR_INCREMENT = 0;
	}

    var ss = util.format("%d:%s:%d:%d", ts, host, pid, increments);
    return crypto.createHash('md5').update(ss).digest("hex");
}

/** 
 * MD5加密 
 * @param data 
 * @returns {*} 
 */  
exports.md5 = function(data) {
    return crypto.createHash('md5').update(data).digest('hex').toLowerCase();  
}

exports.fileMd5 = function(pathFile, callback) {
    if(!(fs.lstatSync(pathFile).isDirectory())) {
        var hash = crypto.createHash('md5');
        
    	var stream = fs.createReadStream(pathFile);
        stream.on('data', function(data) {
            hash.update(data);
        });

        stream.on('end', function() {
            callback(null, hash.digest('hex'));
        });
    } else {
        callback('Is a directory');
    }
}

exports.endcrypt = function(data) {
    var keyData = 116;
    var ret = '';
    for (var i = 0, j=0; i < data.length; i+=2, j++){
        var char = parseInt(data.substr(i, 2), 16);
        char ^= keyData;
        if (char <= 0x0F) {
            ret += '0'    
        }
        ret += char.toString(16);
    }
    return ret.toUpperCase();
}

exports.hexStr2BinaryArray = function(arr) {
    var hexCharCode = [];
    for (var i = 0, j=0; i < data.length; i+=2, j++){
        var char = parseInt(arr.substr(i, 2), 16);
        hexCharCode.push(char.toString(16));
    }
    return hexCharCode;
}

exports.binaryArray2HexStrBySplitter = function(arr, splitter) {
    var hexCharCode = [];
    for(var i = 0; i < arr.length; i++) {
        var strItem = arr[i].toString(16);
        if (strItem.length<=1) {
            strItem = '0' + strItem;
        } else if (strItem.length>2) {
            console.log('error:' + strItem + ':' + str.charCodeAt(i) + ':' + str[i]);
        }
        hexCharCode.push(strItem);
    }
    return hexCharCode.join(splitter);
}

exports.binaryArray2HexStr = function(arr) {
    var hexCharCode = [];
    for(var i = 0; i < arr.length; i++) {
        var strItem = arr[i].toString(16);
        if (strItem.length<=1) {
            strItem = '0' + strItem;
        } else if (strItem.length>2) {
            console.log('error:' + strItem + ':' + str.charCodeAt(i) + ':' + str[i]);
        }
        hexCharCode.push(strItem);
    }
    return hexCharCode.join("");
}

exports.getFileLine = function() {
    // get line number from callstack
    var e = new Error();
    var fields = e.stack.split('\n')[3].split('/');
    var line = fields[fields.length - 1];
    return line.substring(0, line.length - 1);
}

global.SVR_SEQUENCE = global.SVR_SEQUENCE ? global.SVR_SEQUENCE : 0;

exports.getSequence = function() {
	var increments = global.SVR_SEQUENCE++;

	if (global.SVR_SEQUENCE >= 0xFFFFFFFF) {
		global.SVR_SEQUENCE = 0;
	}

	return increments;
}

exports.getDateTimeString = function(timestamp) {
	var t = new Date(timestamp * 1000);
	return util.format('%d-%d-%d %d:%d:%d', t.getFullYear(), t.getMonth() + 1, t.getDate(), t.getHours(), t.getMinutes(), t.getSeconds());
}

var formatUInt2Lenght2 = function(data) {
    if (data<10) {
        return "0" + data;
    }
    return data + "";
}

exports.getDateTimeyyyyMMddHHmmss = function(timestamp) {
	var t = new Date(timestamp * 1000);
	return util.format('%d%s%s%s%s%s', t.getFullYear(), formatUInt2Lenght2(t.getMonth() + 1), formatUInt2Lenght2(t.getDate()), 
            formatUInt2Lenght2(t.getHours()), formatUInt2Lenght2(t.getMinutes()), formatUInt2Lenght2(t.getSeconds()));
}

exports.getDateTimeYYYYMMDD = function(dateObj) {
    var year = dateObj.getFullYear() + "";
    var month = dateObj.getMonth()+1 + "";
    var day = dateObj.getDate() + "";
    if (parseInt(month) < 10) {
        month = "0" + month;
    }
    if (parseInt(day) < 10) {
        day = "0" + day;
    }

    return (year+month+day);
}

exports.incDateByMin = function(d, span) {
    var ret = d;
    ret += span * 60 * 1000;
    return ret;
}

exports.getTodayUTC = function() {
	var now = new Date();

	return Math.floor((now.getTime() - now.getTimezoneOffset() * 60000) / 86400000);
}

exports.getUTCDayFromTick = function(tickCount) {
    var now = new Date();
	return Math.floor((tickCount - now.getTimezoneOffset() * 60) / 86400);
}

exports.get0TickOfUTCDay = function(day) {
	var now = new Date();
	return day * 86400 + now.getTimezoneOffset() * 60;
}

exports.writeHourLog = function(logFile, fields) {
	if (!logFile) {
		return;
	}

    var args = Array.prototype.slice.call(fields);
    var str = Date.now().toString();

    for (var i = 0; i < args.length; i ++) {
        str += ' ';
        str += args[i];
    }

    str += '\n';

    var hourLog = logFile + '.' + parseInt(Date.now() / 3600000);

    fs.appendFile(hourLog, str);
}

var testConstraints = function (sample, cons) {
    for(var k in cons) {
        if (sample[k] != cons[k]) {
            return false;
        }
    }
    return true;
}

exports.testConstraints = testConstraints;
exports.testConstraints_strict = function (sample, cons) {
    if (!testConstraints(sample, cons)) {
        return false;
    }
    if (!testConstraints(cons, sample)) {
        return false;
    }

    return true;
}

exports.uuid = function () {
    var data = UUID.create().toString();
    // var data = nodeUUID.v1();
    var strArr = data.split('-');
    return strArr.join('');
};

exports.store = function (namespace, data) {
    if (data) {
        return localStorage.setItem(namespace, JSON.stringify(data));
    }
    var store = localStorage.getItem(namespace);
    return (store && JSON.parse(store)) || [];
};

global.USER_SEQUENCE = global.USER_SEQUENCE ? global.USER_SEQUENCE : 0;
global.GROUP_SEQUENCE = global.GROUP_SEQUENCE ? global.GROUP_SEQUENCE : 0;

exports.getGroupSequence = function() {
    if (global.USER_SEQUENCE==0) {
        global.GROUP_SEQUENCE = localStorage.getItem('group_sequence');
    }
	var increments = global.GROUP_SEQUENCE++;
    localStorage.setItem('group_sequence', increments);
	return increments;
}

exports.getUserSequence = function() {
    if (global.USER_SEQUENCE==0) {
        global.USER_SEQUENCE = localStorage.getItem('user_sequence');
    }
	var increments = global.GROUP_SEQUENCE++;
    localStorage.setItem('user_sequence', increments);
	return increments;
}

exports.contains = function(a, obj) {
    for (var i = 0; i < a.length; i++) {
        if (a[i] === obj) {
            return true;
        }
    }
    return false;
}

exports.getThumbImageDataInfo = function(width, height) {
    var maxSize = consts.API_USER.THUMBNAIL_WIDTH;
    var orientSize = width;
    if (width<height) {
        orientSize = height;
    }
    if (orientSize>maxSize) {
        var scale = maxSize / (orientSize*1.0);
        return {width : Number(Math.ceil(width*scale)), height : Number(Math.ceil(height*scale))};
    } else {
        return {width : width, height : height};
    }
}

exports.addFdfsPrefix = function(f) {
    var dataArray = f.split('/');
    if (dataArray.length==0) {
        return f;
    } else if(dataArray.length==1) {
        var filePath = 'http://http.tongren.com:8090' + '/api/getHeaderImage/' + f;
        return filePath;
    } else {
        var filePath = global.DOWN_SERVER + '/' + f;
        // var filePath = 'http://101.201.101.216:8888' + '/' + f;
        return filePath;
    }
}

exports.addFdfsLocalPrefix = function(f) {
    var dataArray = f.split('/');
    if (dataArray.length==0) {
        return f;
    } else if(dataArray.length==1) {
        var filePath = 'http://http.tongren.com:8090' + '/api/getHeaderImage/' + f;
        return filePath;
    } else {
        var filePath = global.DOWN_SERVER + '/' + f;
        return filePath;
    }
}
