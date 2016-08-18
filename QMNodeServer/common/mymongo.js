var fs = require('fs');
var mongoose = require('mongoose');

var logger = require('../common/logger');

if (!global.MONGO_INITED) {
	var url = "mongodb://localhost/PartnerIM";

	var conf = null;
	try {
		var mongoConfig = fs.readFileSync('conf/mongo.conf');
		conf = JSON.parse(mongoConfig.toString());
		url = 'mongodb://' + conf.host + '/' + conf.db;
	} catch (e) {
	}

	mongoose.connect(url);
	mongoose.connection.on('open', function() {
		console.log('connection to mongodb established.');
		// logger.info('connection to mongodb established.');
    });
	mongoose.connection.on('error', function(err) {
		// logger.info('mongodb client on error:', err);
    });
	global.MONGO_INITED = true;
}

module.exports = mongoose;
