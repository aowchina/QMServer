var Pub = require('../common/psub').Publish;
var logger = require('../common/logger');
logger.initConsole();
logger.info('logger inited');

function testProxy() {
    return 'queue_wsproxy_0';
}

function testAst() {
    return 'queue_astserver_0';
}

var channel = testAst();
var pub = new Pub(channel);
pub.init();

pub.pubMsg('nat_2:630715987607440385');

