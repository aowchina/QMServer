var gproto = require('../model/gproto');
var net = require('net');
var buffer = require('buffer');
var async = require('async');

gproto.init("../");

function heartbeat() {
    var msg = {
        msgId : MSGID_CONNECT_DEF.MSGID_HEARTBEAT_NTF,
        head :  gproto.makeMsgHead(10),
        body :  null
    }

    var payload = gproto.packMessage(msg.head, null).toBuffer();
    var payloadLen = payload.length;

    console.log('payload:', payload, ', len:', payloadLen);

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8); 

    client.write(sendBuffer);
}

function verifyTest() {
    var msg = {
        msgId : MSGID_CONNECT_DEF.MSGID_VERIFY_REQ,
        head :  gproto.makeMsgHead(11),
        body :  {"userId": "test001", "sessionKey": "test001_session"}
        //body :  {"userId": "test001", "sessionKey": "619e50ef1accfe28ad7ac49699001d7c"}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    client.write(sendBuffer);
}

function initGameTest(serName) {
    var msg = {
        msgId : MSGID_CONNECT_DEF.MSGID_INIT_GAME_REQ,
        head :  gproto.makeMsgHead(null),
        body :  {'type': 'slot', 'name': serName}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("initgame", sendBuffer);
    client.write(sendBuffer);
}

function slotTest() {
    var msg = {
        msgId : MSGID_SLOT_DEF.MSGID_TEST_REQ,
        head :  gproto.makeMsgHead(null),
        body :  {"userId": "atest001"}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("slotTest", sendBuffer);
    client.write(sendBuffer);
}

function slotSpinTest() {
    var msg = {
        msgId : MSGID_SLOT_DEF.MSGID_SPIN_REQ,
        head :  gproto.makeMsgHead(null),
        body :  {"betLines": 15, "betUnit": 5}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("slotSpinTest", sendBuffer);
    client.write(sendBuffer);
}

function slotJoinTableTest() {
    var msg = {
        msgId : MSGID_SLOT_DEF.MSGID_JOIN_TABLE_REQ,
        head :  gproto.makeMsgHead(12),
        body :  {"userId": ''}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("slotJoinTableTest", sendBuffer);
    client.write(sendBuffer);
}

function destroyGameTest() {
    var msg = {
        msgId : MSGID_CONNECT_DEF.MSGID_DESTROY_GAME_REQ,
        head :  gproto.makeMsgHead(null),
        body :  null
    }

    var bodyBuf = null;
    if (msg.body) {
        gproto.packBody(msg.msgId, msg.body);
    }

    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("destroy", sendBuffer);
    client.write(sendBuffer);
}

var client = net.connect({port: 4000},
    function() { //'connect' 监听器
        setTimeout(verifyTest, 300);
        setTimeout(initGameTest, 500, "s4");
        //setTimeout(slotTest, 3000);
        setTimeout(slotJoinTableTest, 700);
        setTimeout(slotSpinTest, 1000);

        //setTimeout(destroyGameTest, 3000);
        //setTimeout(initGameTest, 3000, "s3");
        
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
    var len = data.readInt32BE(0);
    var msgId = data.readInt32BE(4);

    console.log('len:', len, 'msgId:', msgId);
    var payload = new buffer.Buffer(len);
    data.copy(payload, 0, 8, len + 8); 

    var msg = gproto.unpackMessage(payload);
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

