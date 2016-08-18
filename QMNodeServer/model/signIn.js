var async  = require('async');

var CSError = require('../common/error').CSError;
var logger  = require('../common/logger');
var mymongo = require('../common/mymongo');
var consts  = require('../common/consts');
var errno   = require('../common/errno');
var util    = require('../common/utils');

var user = require("./user");
var wlog = require("./wlog");

//var signInMatrixConfig = [
//    {probability: 95, bonus: 100},
//    {probability: 120, bonus: 200},
//    {probability: 105, bonus: 250},
//    {probability: 130, bonus: 300},
//    {probability: 115, bonus: 350},
//    {probability: 120, bonus: 400},
//    {probability: 140, bonus: 500},
//    {probability: 130, bonus: 750},
//    {probability: 30, bonus: 1000},
//    {probability: 15, bonus: 2000}
//];

var signInStreakDayMulti = [1, 1.1, 1.2, 1.3, 1.5, 1.7, 2];
var signInBonusMatrix = [];

//function initMatrix() {
//    for (var i = 0; i < signInMatrixConfig.length; ++i) {
//        for ( var j = 0; j < signInMatrixConfig[i].probability; ++j) {
//            signInBonusMatrix.push(signInMatrixConfig[i].bonus);
//        }
//    }
//}

var SignInSchema = new mymongo.Schema({
    userId : { type : String, index : true, unique: true },
    lastSignInTime : { type: Date, default: "1970-1-1" }
});

var SignIn = mymongo.model('SignIn', SignInSchema);

function findUserById(userId, callback) {
    SignIn.findOne({userId : userId}, function(err, data) {
		if (err) {
			callback(new CSError(errno.MONGO_FIND_FAIL, err.message));
		} else {
            if (!data) {
                var obj = new SignIn();
                obj.userId = userId;
                obj.save(function(err) {
                    if (err) {
                        callback(new CSError(errno.MONGO_SAVE_FAIL, err.message));
                    } else {
                        logger.info('new sign in record for user', userId);
                        callback(null, obj);
                    }
                });
            } else {
                callback(null, data);
            }
		}
	});
}

function getSignInInfo(userId, callback) {
    findUserById(userId, function(err, data) {
        if (err) {
            return callback(err);
        }

        var res = {canSignIn: true};
        var now = new Date();
        if (util.UTCDayCountMinus(now, data.lastSignInTime) == 0) {
            res.canSignIn = false;
        }

        callback(null, res);
    });
}

function signIn(userId, callback) {
    findUserById(userId, function(err, data) {
        if (err) {
            return callback(err);
        }

        var now = new Date();
        if (util.UTCDayCountMinus(now, data.lastSignInTime) == 0) {
            return callback(new CSError(errno.API_USER_SIGNED, 'had signed in today.'));
        }

        user.getLoginStreakDay(userId, function(err, loginStreakDay) {
            if (err) {
                return callback(err);
            }

            var bonusIdx = Math.floor(Math.random() * signInBonusMatrix.length);
            var multiIdx = loginStreakDay % signInStreakDayMulti.length;
            if (multiIdx > 0) {
                multiIdx -= 1;
            }

            var unitBonus = signInBonusMatrix[bonusIdx];
            var multi = signInStreakDayMulti[multiIdx];
            var allBonus = Math.round(unitBonus * multi);
            logger.debug(unitBonus, "*", multi, "=", allBonus);

            data.lastSignInTime = new Date();
            data.save(function(err) {
                if (err) {
                    return callback(new CSError(errno.MONGO_SAVE_FAIL, err.message));
                }

                //user.incChips(userId, allBonus, function(err, totalChips) {
                //    if (err) {
                //        callback(err);
                //    } else {
                //        callback(null, {
                //            unitBonus: unitBonus,
                //            multi: multi,
                //            allBonus: allBonus,
                //        });
                //        wlog.chipChanged("sys", "sign-in", userId, consts.CCType.SIGN_IN, allBonus);
                //    }
                //});
            });
        });
    });
}

//initMatrix();
exports.getSignInInfo = getSignInInfo;
exports.signIn = signIn;

/*
logger.testinit();
getSignInInfo('test001', function(err, data) {
    console.log(err, data);
});

signIn('test001', function(err, data) {
    console.log(err, data);
})
*/