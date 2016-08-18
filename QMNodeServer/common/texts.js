var fs = require('fs');
var util = require('util');

var _texts = null;

exports.getText = function() {
	if (!_texts) {
		try {
			_texts = JSON.parse(fs.readFileSync('conf/texts.json'));
		} catch (e) {
		}
	}

	if (!_texts) {
		return '';
	}

	var args = Array.prototype.slice.call(arguments);
	if (args.length == 0) {
		return '';
	}

	var tid = args[0];
	if (!_texts.hasOwnProperty(tid)) {
		return '';
	}

	var s = _texts[tid];
	if (args.length == 1) {
		return s;
	} else {
		args.shift();
		args.unshift(s);
		return util.format.apply(null, args);
	}
}
