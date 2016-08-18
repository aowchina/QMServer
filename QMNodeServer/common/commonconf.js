var path = require('path');
var fs   = require('fs');
var consts   = require('./consts');

var epath = path.resolve(".");
var content = JSON.parse(fs.readFileSync(epath + '/conf/common.conf', 'utf8'));

var WCO = consts.WordComAndOmit;
var serverconf = {
};
serverconf[WCO.download] = content.downurl;

global.SERVER_CONF = serverconf;