var child_process = require('child_process');

var _posArray = [
    ['+20+20'],
    ['+1+46', '+91+46'],
    ['+46+1', '+1+91', '+91+91'],
    ['+1+1','+91+1','+1+91','+91+91'],
    ['+31+31','+91+31','+1+91','+61+91','+121+91'],
    ['+1+31','+61+31','+121+31','+1+91','+61+91','+121+91'],
    ['+61+1','+1+61','+61+61','+121+61','+1+121','+61+121','+121+121'],
    ['+31+1','+91+1','+1+61','+61+61','+121+61','+1+121','+61+121','+121+121'],
    ['+1+1','+61+1','+121+1','+1+61','+61+61','+121+61','+1+121','+61+121','+121+121']
];

function makeCmd(names, outFile) {
    var strCmd = 'convert -size 180x180 xc:lightgray \\';
    var items = new Array('\(', '', '-resize', '', '\\\) -geometry', '', '-composite \\');
    var item3 = ['140X140', '88X88', '58X58'];

    var countIcons = names.length>9 ? 9 : names.length;
    if (countIcons==1) {
        items[3] = item3[0];
    } else if(countIcons<=4) {
        items[3] = item3[1];
    } else {
        items[3] = item3[2];
    }
    for(var i=0; i<countIcons; i++) {
        items[1] = names[i];
        items[5] = _posArray[countIcons-1][i];
        strCmd += items.join(' ');
    }
    strCmd += outFile;
    return strCmd;
}

exports.makeIamge = function(names, outFile, callback) {
    var strCmd = makeCmd(names, outFile);
    child_process.exec(strCmd, function(error, stdout, stderr){
        // console.log(strCmd);
        callback(error, outFile);
    });    
}

exports.removeImages = function(names, callback) {
    var strCmd = 'rm ' + names.join(' ');
    child_process.exec(strCmd, function(error, stdout, stderr){
        callback(error);
    });    
}



