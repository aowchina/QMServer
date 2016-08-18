var util = require('util');

function CSError(code, msg) {
    CSError.super_.call(this);
    Error.captureStackTrace(this, this.constructor)
    this.code = code || 99;
    this.message = (msg || 'CS Error') + '[code:' + code + ']';
}

util.inherits(CSError, Error);

CSError.prototype.name = 'CSError';

exports.CSError = CSError;
