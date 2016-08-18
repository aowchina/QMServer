var logger = require('../common/logger');
var sqlog  = require('../common/sqlog');

// 用户大厅登陆：用户ID，注册日期（YYYYMMDD），渠道号
function userLogin(userId, regDate, channel) {
    var sqlStr = 'call p_user_login(?,?,?)';
    var inParams = [userId, regDate, channel];
    sqlog.query(sqlStr, inParams, function(err, res) {
        if (err) {
            logger.error("user login:", err);
        }
    });
}

module.exports = {
    userLogin: userLogin
};

//userLogin('login_test', '20010101', 1);
