var mysql = require('mysql');

var pool = mysql.createPool({
    host: 'localhost',
    user: 'PartnerIM',
    password: 'PartnerIM',
    database: 'im_log',
    port: 3306
});

function query(sql, inParams, callback) {
    pool.getConnection(function(err, conn) {
        if (err) {
            return callback(err);
        }

        conn.query(sql, inParams, function(err, res) {
            if (err) {
                callback(err);
            } else {
                callback(null, res);
            }
            conn.release();
        });
    });
}

function realQuery(sql, inParams, callback) {
    try {
        query(sql, inParams, callback);
    } catch (e) {
        console.log('sql:', e);
    }
}

exports.query = realQuery;

/*
var sql = "select id, name FROM t1";
query(sql, function(err, res) {
    if (err) {
        console.log("error:", err);
    } else {
        console.log("res:", res);
        for (var i = 0; i < res.length; ++i) {
            console.log(res[i]);
            for (var j in res[i]) {
                console.log(j, res[i][j]);
            }
        }

    }
});
*/
