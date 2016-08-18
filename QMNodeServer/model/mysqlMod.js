var CSError = require('../common/error').CSError;
var logger  = require('../common/logger');
var errno   = require('../common/errno');
var wlog    = require('../model/wlog');
var mymysql = require('../common/mymysql');
var crc = require('crc');

var _SPLIT_TABLE_NUM = 16;

var _SQL_OFFLINE_MESSAGE_GROUP_SELECT = 'SELECT * FROM group_msg_log_SPLITNUM WHERE msgid IN ';
var _SQL_OFFLINE_MESSAGE_SELECT = 'SELECT * FROM msg_log_SPLITNUM WHERE usr=? AND msgid IN ';
var _SQL_GROUP_HISTORY_MESSAGE_SELECT = 'SELECT * FROM group_msg_log_SPLITNUM WHERE gid=? AND seq<? AND seq>0 ORDER BY seq DESC LIMIT ?';
var _SQL_FRIEND_HISTORY_MESSAGE_BY_CHATTER_SELECT = 'SELECT * FROM msg_log_SPLITNUM WHERE chatter=? AND usr=? AND seq<? AND seq>0 ORDER BY seq DESC LIMIT ?';
var _SQL_FRIEND_HISTORY_MESSAGE_SELECT = 'SELECT * FROM msg_log_SPLITNUM WHERE usr=? AND seq<? AND seq>0 ORDER BY seq DESC LIMIT ?';

function getTableId(uidgid) {
    return crc.crc32(uidgid+'') % _SPLIT_TABLE_NUM;
}

function getOfflineMsgGroup(msgidArray, gid, callback) {
    if(msgidArray.length == 0) {
        callback(null, []);
    }

    var pool = mymysql.getMysqlPool();
    var sql = _SQL_OFFLINE_MESSAGE_GROUP_SELECT + '(';
    sql = sql.replace('SPLITNUM', getTableId(gid)+'');
    for (var i=0; i<msgidArray.length; i++) {
        sql += '?,';
    }
    
    var tmpSql = sql.substring(0, sql.length-1);
    sql = tmpSql + ')';
    
    pool.getConnection(function(err, connection) {
        connection.query(sql, msgidArray, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

function getOfflineMsg(msgidArray, uid, callback) {
    if(msgidArray.length == 0) {
        callback(null, '');
    }

    var pool = mymysql.getMysqlPool();
    var sql = _SQL_OFFLINE_MESSAGE_SELECT + '(';
    sql = sql.replace('SPLITNUM', getTableId(uid)+'');
    for (var i=0; i<msgidArray.length; i++) {
        sql += '?,';
    }
    
    var tmpSql = sql.substring(0, sql.length-1);
    sql = tmpSql + ')';    
    msgidArray.unshift(uid);
    pool.getConnection(function(err, connection) {
        connection.query(sql, msgidArray, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

function getHistoryMsgGroup(gid, seq, cnt, callback) {
    var sqlParam = [gid, Number(seq), Number(cnt)];
    var pool = mymysql.getMysqlPool();
    pool.getConnection(function(err, connection) {
        var sql = _SQL_GROUP_HISTORY_MESSAGE_SELECT;
        sql = sql.replace('SPLITNUM', getTableId(gid)+'');
        connection.query(sql, sqlParam, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

function getHistoryMsgFriendByChatter(usr, chatter, seq, cnt, callback) {
    var sqlParam = [chatter, usr, Number(seq), Number(cnt)];
    var pool = mymysql.getMysqlPool();
    pool.getConnection(function(err, connection) {
        var sql = _SQL_FRIEND_HISTORY_MESSAGE_BY_CHATTER_SELECT;
        sql = sql.replace('SPLITNUM', getTableId(usr)+'');
        connection.query(sql, sqlParam, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

function getHistoryMsgFriend(usr, seq, cnt, callback) {
    var sqlParam = [usr, Number(seq), Number(cnt)];
    var pool = mymysql.getMysqlPool();
    pool.getConnection(function(err, connection) {
        var sql = _SQL_FRIEND_HISTORY_MESSAGE_SELECT;
        sql = sql.replace('SPLITNUM', getTableId(usr)+'');
        connection.query(sql, sqlParam, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

var _SQL_GROUP_MIN_SELECT = 'SELECT seq FROM group_msg_log_SPLITNUM WHERE gid=? AND seq>0 ORDER BY seq ASC LIMIT 1';
var _SQL_FRIEND_MIN_BY_CHATTER_SELECT = 'SELECT seq FROM msg_log_SPLITNUM WHERE chatter=? AND usr=? AND seq>0 ORDER BY seq ASC LIMIT 1';

function getMinSeqFriendByChatter(usr, chatter, callback) {
    var sqlParam = [chatter, usr];
    var pool = mymysql.getMysqlPool();
    pool.getConnection(function(err, connection) {
        var sql = _SQL_FRIEND_MIN_BY_CHATTER_SELECT;
        sql = sql.replace('SPLITNUM', getTableId(usr)+'');
        connection.query(sql, sqlParam, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

function getMinSeqGroup(gid, callback) {
    var sqlParam = [gid];
    var pool = mymysql.getMysqlPool();
    pool.getConnection(function(err, connection) {
        var sql = _SQL_GROUP_MIN_SELECT;
        sql = sql.replace('SPLITNUM', getTableId(gid)+'');
        connection.query(sql, sqlParam, function(err, rows) {
            connection.release();
            if (err) {
                callback(new CSError(errno.MYSQL_FIND_FAIL, err.message));
            } else {
                callback(null, rows);
            }
        });
    });
}

exports.getTableId = getTableId;
exports.getOfflineMsgGroup = getOfflineMsgGroup;
exports.getOfflineMsg = getOfflineMsg;
exports.getHistoryMsgGroup = getHistoryMsgGroup;
exports.getHistoryMsgFriendByChatter = getHistoryMsgFriendByChatter;
exports.getHistoryMsgFriend = getHistoryMsgFriend;

exports.getMinSeqFriendByChatter = getMinSeqFriendByChatter;
exports.getMinSeqGroup = getMinSeqGroup;
