var mymysql = require('../common/mymysql');
var CSError = require('../common/error').CSError;
var logger  = require('../common/logger');
var utils   = require('../common/utils');

var gm = require('gm');

function convertToHex(str) {
    var hex = '';
    for(var i=0;i<str.length;i++) {
        hex += ''+str.charCodeAt(i).toString(16);
    }
    return hex;
}

var md5Str = utils.md5('123456');

function endcrypt(password) {
    var keyData = 116;
    var ret = '';
    for (var i = 0, j=0; i < password.length; i+=2, j++){
        var data = parseInt(password.substr(i, 2), 16);
        ret += (data ^ keyData).toString(16);
    }
    return ret.toUpperCase();
}

var aaa = endcrypt(md5Str);

console.log(aaa);


// var cipher = crypto.createCipher('blowfish','eBACovfs13K4I96')

// var plaintext = new Buffer('zzcuio1');
// var text = "zzcuio1";
// var crypted = "";
// crypted += cipher.update(plaintext, '', 'utf8');
// crypted += cipher.final('hex');

// var _lNewDBCIV = 1461112615103798088;
// var _lNewDBCIV = 146103798088;

// crypted = encStr(text, _lNewDBCIV);

// console.log(crypted);

// function encStr(sPlainText, lNewCBCIV) {
//         // allocate the buffer (align to the next 8 byte border plus padding)
//         var strLen = sPlainText.length;
//         //[(strLen << 1) & 0xfffffff8) + 8
//         var dataLen = 16;//(strLen<<1) & 0xfff8 + 8;
//         var buf = new Buffer(dataLen);

//         // copy all bytes of the string into the buffer (use network byte order)
//         var nPos = 0;
//         for (var nI = 0; nI < strLen; nI++) {
//             var cActChar = sPlainText.charAt(nI);
//             buf[nPos++] = (cActChar >> 8) & 0x0ff;
//             buf[nPos++] = cActChar & 0x0ff;
//         }

//         // pad the rest with the PKCS5 scheme
//         var bPadVal = buf.length - (strLen << 1);
//         while (nPos < buf.length) {
//             buf[nPos++] = bPadVal;
//         }
        

//         var encryped = '1446ea2ea01a9b48962f3f394e07ff71e4db95651248da09';

//         // return the binhex string
//         var newCBCIV = new Buffer(8);
//         longToByteArray(lNewCBCIV, newCBCIV, 0);

//         return bytesToBinHex(newCBCIV, 0, 8) + bytesToBinHex(buf, 0, buf.length);
//     }
    
//     function encrypt(buffer){
//             var nLen = buffer.length;
//             var lTemp;
//             for (var nI = 0; nI < nLen; nI +=8)
//             {
//                 // encrypt a temporary 64bit block
//                 lTemp = byteArrayToLong(buffer, nI);
//                 lTemp = encryptBlockCBC(lTemp);
//                 longToByteArray(lTemp, buffer, nI);
//             }
//         }
        
// function bytesToBinHex(data, nStartPos, nNumOfBytes) {
//     var HEXTAB = '0123456789abcdef';        
//     var sbuf = new Buffer(nNumOfBytes << 1);
//     var nPos = 0;
//     for (var nI = 0; nI < nNumOfBytes; nI++)
//     {
//         sbuf[nPos++] = HEXTAB[(data[nI + nStartPos] >> 4) & 0x0f];
//         sbuf[nPos++] = HEXTAB[data[nI + nStartPos] & 0x0f];
//     }
//     return sbuf.toString();
// }
// function longToByteArray(lValue, buffer, nStartIndex) {
//     buffer[nStartIndex] = (lValue >>> 56);
//     buffer[nStartIndex + 1] = ((lValue >>> 48) & 0x0ff);
//     buffer[nStartIndex + 2] = ((lValue >>> 40) & 0x0ff);
//     buffer[nStartIndex + 3] = ((lValue >>> 32) & 0x0ff);
//     buffer[nStartIndex + 4] = ((lValue >>> 24) & 0x0ff);
//     buffer[nStartIndex + 5] = ((lValue >>> 16) & 0x0ff);
//     buffer[nStartIndex + 6] = ((lValue >>> 8) & 0x0ff);
//     buffer[nStartIndex + 7] = lValue;
//     return buffer;
// }
        
// function byteArrayToLong(buffer, nStartIndex) {
//     return ((buffer[nStartIndex]) << 56) |
//             ((buffer[nStartIndex + 1] & 0x0ff) << 48) |
//             ((buffer[nStartIndex + 2] & 0x0ff) << 40) |
//             ((buffer[nStartIndex + 3] & 0x0ff) << 32) |
//             ((buffer[nStartIndex + 4] & 0x0ff) << 24) |
//             ((buffer[nStartIndex + 5] & 0x0ff) << 16) |
//             ((buffer[nStartIndex + 6] & 0x0ff) << 8) |
//             (buffer[nStartIndex + 7] & 0x0ff);
// }

// function intArrayToLong(buffer, nStartIndex) {
//     return ((buffer[nStartIndex]) << 32) | ((buffer[nStartIndex + 1]) & 0x0ffffffff);
// }

    // var mysql = mymysql.getDBClient();
    // mysql.query('CALL (1, @a, @b);', function(err, rows, fields) {
    //     if (err) {
    //        throw err;
    //     }
    //     var results = rows[0];
    //     var row = results[0];
    //     console.log("userName：",row.uName, "　　count：", row.totalCount);
    // });    
    // var sqlstmt = 'CALL sp_popUserId(@a)';

    var mysql = mymysql.getDBClient();
    mysql.query('CALL proPopUserId(@a)', function(err, rows) {
        mysql.close();
        if (err) {
            // callback(new CSError(errno.REDIS_GET_FAIL, err.message));
            console.log('error', err);
        } else {
            var results = rows[0];
            var row = results[0];
            console.log('info', row.ofUserId);
        }
    });
    
// mysql.query('select nextUserId from ofUserIdPump', '', function(err, data) {
//             if (err) {
//                 logger.error('pop userId:', err);
//                 callback(new CSError(errno.MONGO_FIND_FAIL, err.message));
//             } else {
//                 if (!doc) {
//                     initUserIdPump(function(err, data) {
//                         callback(null, data.nextUserId);
//                     });
//                 } else {
//                     callback(null, doc.nextUserId);
//                 }
//             }
//         }
//     );

// CREATE PROCEDURE sp_popUserId(OUT ofUserId INT)
// BEGIN
// UPDATE ofUserIdPump SET nextUserId = nextUserId + 1;
// SELECT nextUserId INTO ofUserId FROM ofUserIdPump;
// SELECT ofUserId;
// END;
    
    // mysql.query('update ofUserIdPump set nextUserId = nextUserId + 1', '', function(err, data) {
    //     if (err) {
    //          logger.info('error', err.message);
    //     } else {
    //         if (data && data.length>0) {
    //             console.log(data[0].nextUserId);
    //         } else {
    //             mysql.query('select nextUserId from ofUserIdPump', '', function(errUpdate, result) {
    //                 if (err) {
    //                     logger.info('error', errUpdate.message);
    //                 } else {
    //                     if (result.affectedRows>0) {
    //                         logger.info('info', {nextUserId : 25001});                            
    //                     }
    //                 }                
    //             });
    //         }
    //     }
    // });    
    
    
        //下面这个是处理缩略图的代码    
    // var imageMagick = gm.subClass({ imageMagick : true });
    // var path = '/Users/ewonder/Documents/workspace/PartnerIM/PartnerIMServer/tests/';
    // var file = '78.pic.jpg';
    // var pathFile = path + file;
    
    // console.log(pathFile);
    
    // imageMagick(pathFile)
    // .thumb(80, 80, path + 'thumb_' + file, 100, function(err){
    //     if (err) {
    //         console.log(err);
    //     } else {
    //         console.log('ok');
    //     }
    // });
    
    
    // imageMagick(pathFile)
    // .resize(80, 80, '!') //加('!')强行把图片缩放成对应尺寸150*150！
    // .noProfile()
    // .write(path + 'thumb_' + file, function(err){
    //     if (err) {
    //         console.log(err);
    //     } else {
    //         console.log('ok');
    //     }
    // });