var gproto = require('../model/gproto');
var utils = require('../common/utils');
var net = require('net');
var buffer = require('buffer');
var async = require('async');

gproto.init("/Users/zhouzc/Documents/workspace/PartnerIM/PartnerIMServer");

function connectTest(){
    var msg = {};
    var body = {
        token : 'f05ffda76f1a3a2b',
        uid : 100000
    };
    var buf = global.TONREN_PROTO.packBody(global.PROTO_MESSAGETYPE_DEF.Connection, body);
    msg.body = buf.toBuffer();
    msg.timestamp = 1462961289295;
    msg.msgType = global.PROTO_MESSAGETYPE_DEF.Connection;
    msg.head = global.TONREN_PROTO.makeMsgHead('38118BE8FBF57BBD3D897B531AD453AD');
    var buff = global.TONREN_PROTO.packSingleMessage(msg);
    var packet = buff.toBuffer();
    
    var packetLen = packet.length;

    console.log('payload:', msg, ', len:', packetLen);

    var sendBuffer = new buffer.Buffer(4 + packetLen);
    sendBuffer.writeUInt16BE(msg.messageType, 0);
    sendBuffer.writeUInt16BE(packetLen, 2); 
    packet.copy(sendBuffer, 4);

    var hexStr = utils.binaryArray2HexStrBySplitter(sendBuffer,' ');
    console.log(hexStr);
    
    client.write(sendBuffer);
}

function headerTest(){
    var head = global.TONREN_PROTO.makeMsgHead('F725783F521B65F34A51E9825AB0E937');
    var buf = global.TONREN_PROTO.packBody(0x999, head);
    head = buf.toBuffer();
    
    var packetLen = head.length;
    var packBuffer = new buffer.Buffer(packetLen);
    packBuffer[0] = head[0];
    packBuffer[1] = head[1];
    packBuffer[2] = head[2];
    head.copy(packBuffer, 3, 4, packetLen);
    packBuffer[packetLen-1] = head[3];
    
    // packet.copy(sendBuffer, 4);
    

    var hexStr = utils.binaryArray2HexStrBySplitter(packBuffer,' ');
    console.log(hexStr);
    
    // client.write(sendBuffer);
}

function sendBinMessage(type){
    var data = '0312323436434543423223804432322d383131352d323237302d304636334336423732234144242818a9122a160a663035666664613736663161336132621010a08d0';
    // hexStr2BinaryArray
}

var client = net.connect({host: '101.201.154.112', port: 5200}, function() { //'connect' 监听器
        console.log('client connected');
        setTimeout(headerTest, 300);
        
        /*
        async.series([
            function(cb) {
                verifyTest(cb);
            },
            function(cb) {
                initGameTest(cb);
            }
        ],
        function(err) {
        }
        );
        */
});

client.on('data', function(data) {
    var msgId = data.readUInt16BE(0);
    var len = data.readUInt16BE(2);

    console.log('len:', len, 'msgId:', msgId);
    
    var message = new buffer.Buffer(len);
    data.copy(message, 0, 4, len+4); 

    var msg = gproto.unpackMessage(message);
    if (msg.body) {
        msg.body = gproto.unpackBody(msgId, msg.body);
    }

    console.log('got msg %d\n%s', msgId, JSON.stringify(msg, null, 4));

    //client.end();
});

client.on('end', function() {
    console.log('client end.');
});

client.on('close', function() {
    console.log('client close');
});

client.on('error', function() {
    console.log('client error');
});

