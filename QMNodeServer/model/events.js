
var fs = require('fs');

exports.getData = function(callback) {
	fs.readFile('varun/event.json', function(err, data) {
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
