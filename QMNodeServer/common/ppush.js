var fs = require('fs');
var sys = require('util');
var logger = require('../common/logger');
var JPush = require("../lib/JPush/JPush.js");

var _client = null;
if (!global.JPUSH_INITED) {
    _client = JPush.buildClient('6115625977de91897dcf5b6c', '7920a8f375dd284b2b1f7748', null, false);
	global.JPUSH_INITED = true;
}

function Notification(userId) {
    _client.push().setPlatform(JPush.ALL)
    .setAudience(JPush.alias(userId))
    .setNotification('Hi, Huoban', JPush.ios('ios alert', 'happy', 2))
    .send(function(err, res) {
        if (err) {
            if (err instanceof JPush.APIConnectionError) {
                console.log(err.message);
            } else if (err instanceof  JPush.APIRequestError) {
                console.log(err.message);
            }
        } else {
            console.log('Sendno: ' + res.sendno);
            console.log('Msg_id: ' + res.msg_id);
        }
    });
}

function Message(userId, msg) {
    _client.push().setPlatform(JPush.ALL)
    .setAudience(JPush.alias(userId))
    .setNotification('Hi, Tongren', JPush.ios('ios alert'), JPush.android('android alert', null, 1))
    .setMessage(msg)
    .setOptions(null, 60)
    .send(function(err, res) {
        if (err) {
            if (err instanceof JPush.APIConnectionError) {
                console.log(err.message);
                //Response Timeout means your request to the server may have already received, please check whether or not to push
                console.log(err.isResponseTimeout);
            } else if (err instanceof  JPush.APIRequestError) {
                console.log(err.message);
            }
        } else {
            console.log('Sendno: ' + res.sendno);
            console.log('Msg_id: ' + res.msg_id);
        }
    });
}

// setTimeout(Message, 1000, '630715987607440385', 'this is a test message');

exports.pushNotification = Notification;
exports.pushMessage = Message;