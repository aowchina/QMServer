
var fs = require('fs');

exports.getAnnounce = function(callback) {
	fs.readFile('varun/announce.json', function(err, data) {
		if (err) {
			callback(err);
		} else {
			var r = null;
			var e = null

			try {
				r = JSON.parse(data);
			} catch (err) {
				e = err;
			}

			callback(e, r);
		}
	});
}

exports.getWelcomeMail = function(callback) {
	fs.readFile('varun/welcome.json', function(err, data) {
		if (err) {
			callback(err);
		} else {
			var r = null;
			var e = null

			try {
				r = JSON.parse(data);
			} catch (err) {
				e = err;
			}

			callback(e, r);
		}
	});
}
