var gproto = require('../model/gproto');
var net = require('net');
var buffer = require('buffer');
var async = require('async');

gproto.init("../");

function verifyTest() {
    var msg = {
        msgId : MSGID_CONNECT_DEF.MSGID_VERIFY_REQ,
        head :  gproto.makeMsgHead(11),
        body :  {"userId": "test001", "sessionKey": "test001_session"}
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

function searchUser(userId) {
    var msg = {
        msgId : MSGID_FRIEND_DEF.MSGID_FRIEND_SEARCH_REQ,
        head :  gproto.makeMsgHead(11),
        body :  {"dstUserId": userId}
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

function inviteFriend(dstUserId, myNickname) {
    var msg = {
        msgId : MSGID_FRIEND_DEF.MSGID_FRIEND_INVITE_REQ,
        head :  gproto.makeMsgHead(11),
        body :  {"dstUserId": dstUserId, myNickname: myNickname}
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

function listFriend(userId) {
    var msg = {
        msgId : MSGID_FRIEND_DEF.MSGID_FRIEND_LIST_REQ,
        head :  gproto.makeMsgHead(11),
        body :  null
    }

    var bodyBuf = null;
    //bodyBuf = gproto.packBody(msg.msgId, msg.body);
    var payload = gproto.packMessage(msg.head, bodyBuf).toBuffer();
    var payloadLen = payload.length;

    var sendBuffer = new buffer.Buffer(8 + payloadLen);
    sendBuffer.writeInt32BE(payloadLen, 0); 
    sendBuffer.writeInt32BE(msg.msgId, 4); 
    payload.copy(sendBuffer, 8, 0, payloadLen); 

    client.write(sendBuffer);
}

function removeFriend(dstUserId, myNickname) {
    var msg = {
        msgId : MSGID_FRIEND_DEF.MSGID_FRIEND_REMOVE_REQ,
        head :  gproto.makeMsgHead(11),
        body :  {"dstUserId": dstUserId, myNickname: myNickname}
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

var client = net.connect({host: "localhost", port: 4000},
    function() { 
        setTimeout(verifyTest, 300);
        //setTimeout(searchUser, 500, "test003");
        //setTimeout(inviteFriend, 600, "test003", 'nickname001');
        //setTimeout(listFriend, 600, "test001");
        setTimeout(removeFriend, 600, "test003", 'nickname001');
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

    //console.log('msg:', msg);
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

