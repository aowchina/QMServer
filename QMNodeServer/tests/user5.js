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
        body :  {"userId": "test005", "sessionKey": "test005_session"}
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

function initAppTest(serName) {
    var msg = {
        msgId : MSGID_CONNECT_DEF.MSGID_INIT_APP_REQ,
        head :  gproto.makeMsgHead(null),
        body :  {'type': 'chat', 'name': serName}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("initapp", sendBuffer);
    client.write(sendBuffer);
}

function privateChatTest() {
    var chatInfo = {'type': 2, 'content': 'hello world'};
    var msg = {
        msgId : MSGID_CHAT_DEF.MSGID_PRIVATE_CHAT_REQ,
        head :  gproto.makeMsgHead(null),
        body :  {'toUserId': 'test004', 'chatInfo': chatInfo}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("private chat", sendBuffer);
    client.write(sendBuffer);
}

function publicChatTest() {
    var chatInfo = {'type': 2, 'content': 'hello world, public'};
    var msg = {
        msgId : MSGID_CHAT_DEF.MSGID_PUBLIC_CHAT_NTF,
        head :  gproto.makeMsgHead(null),
        body :  {'fromUserId': 'test005', 'chatInfo': chatInfo}
    }

    var bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    console.log("public chat", sendBuffer);
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

function slotJoinTableTest(seq) {
    var msg = {
        msgId : MSGID_SLOT_DEF.MSGID_JOIN_TABLE_REQ,
        head :  gproto.makeMsgHead(seq),
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

function getDataTest() {
    var msg = {
        msgId : MSGID_SLOT_DEF.MSGID_GET_DATA_REQ,
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

    console.log("getDataTest", sendBuffer);
    client.write(sendBuffer);
}

function quitTableTest() {
    var msg = {
        msgId : MSGID_SLOT_DEF.MSGID_QUIT_TABLE_REQ,
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

    console.log("quitTableTest", sendBuffer);
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
        //setTimeout(initAppTest, 400, "ct01");
        setTimeout(initGameTest, 400, "s3");
        setTimeout(slotJoinTableTest, 500, 2);
        //setTimeout(privateChatTest, 600, 1);
        setTimeout(publicChatTest, 800, 1);
        /*
        setTimeout(slotJoinTableTest, 500, 3);
        setTimeout(slotJoinTableTest, 600, 4);
        setTimeout(slotJoinTableTest, 700, 5);
        setTimeout(slotJoinTableTest, 800, 6);
        */
        //setTimeout(getDataTest, 600);
        setTimeout(slotSpinTest, 800);
        //setTimeout(slotSpinTest, 1000);
        //setTimeout(quitTableTest, 1200);

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

