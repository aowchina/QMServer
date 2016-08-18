
var flags = require('flags');
var http = require('http');
var qs = require('querystring'); 
var https = require('https');
var gim = require('../model/groupImageMaker');
var utils = require('../common/utils');
var imageinfo = require('imageinfo');
var gm = require('gm');
var fs = require('fs-extra');

// var filePath = './tests/80.pic.jpg';

// var fileData = fs.readFileSync(filePath);
// var info = imageinfo(fileData);
// // if (info.mimeType.toString('utf-8').startsWith('image', 0)) 
// console.log(info.mimeType + " : " + info.format);
// if (info.mimeType)
// {
//     console.log(info);
    
//     var rData = utils.getThumbImageDataInfo(info.width, info.height);
//     var imageMagick = gm.subClass({ imageMagick : true });
//     imageMagick(filePath)
//     .thumb(rData.width, rData.height, filePath+'_s.jpg', 100, function(err){
//         if(!err) {
//             console.log('is ok');
//         } else {
//             console.log('convert is failed!');
//         }
//     });
// } else {
//     console.log('file is not a image!');
// }

// var strCmd = 'convert -size 100x100 xc:lightgray \\' + 
//           '\( 75.jpg -resize 48x48 \\\) -geometry +1+1   -composite \\' +
//           '\( 76.jpg -resize 48x48 \\\) -geometry +51+1  -composite \\' +
//           '\( 77.jpg -resize 48x48 \\\) -geometry +1+51  -composite \\' +
//           '\( 78.jpg -resize 48x48 \\\) -geometry +51+51  -composite \\' +
//           'output4.jpg';
// console.log(strCmd);

// var names = ['75.jpg','76.jpg','77.jpg','78.jpg','79.jpg','80.jpg','75.jpg','76.jpg','77.jpg']
// gim.makeIamge(names, 'out.jpg', function(err, data){
//     if (err) {
//         console.log('err:' + err);
//     } else {
//         console.log('data:' + data);
//     }
// });
