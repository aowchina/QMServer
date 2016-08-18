var Pub = require('../common/psub').Publish;

var channel = 'addOrder';
var pub = new Pub(channel);
pub.init();

exports.send2Server = function(msg) {
    pub.pubMsg(msg);
}