var utils = require('../common/utils');
var fs = require('fs')
var FdfsClient = require('fdfs-client');
var debug = require('debug')('fdfs');


var testFile = 'tests/80.jpg';

// utils.fileMd5(testFile, function(err, data){
//     if (err) {
//         console.log(err);
//     } else {
//         console.log("file md5 : " + data);
//     }
// });

var fdfs = new FdfsClient({
    // tracker servers
    trackers: [
        {
            host: '60.205.57.130',
            port: 22122
        }
    ],
    // 默认超时时间10s
    timeout: 1000*30,
    charset: 'utf8',
    logger: {
        log: debug
    }
});

fdfs.on('error', function(err) {
    console.log('======================================');
    console.log(err);
    console.log('======================================');
    // fdfs = createClient();
});
var states = fs.statSync(testFile);

console.log("size : " + states.size);

var rs = fs.createReadStream(testFile);
// var buffer = fs.readFileSync(testFile);
fdfs.upload(rs,  {
    // 指定文件存储的group，不指定则由tracker server分配
    group: 'group1',
    // file bytes, file参数为ReadableStream时必须指定
    size: states.size,
    // 上传文件的后缀，不指定则获取file参数的后缀，不含(.)
    ext: 'file'

}, function(err, fileId) {
    if (!err) {
        console.log(fileId);
    } else {
        console.log(err);
    }
})

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