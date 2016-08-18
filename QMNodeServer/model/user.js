var Pub = require('../common/psub').Publish;

var channel = 'QM';
var pub = new Pub(channel);
pub.init();

exports.send2Server = function(msg) {
    pub.pubMsg(msg);
}