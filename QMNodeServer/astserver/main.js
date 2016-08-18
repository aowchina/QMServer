
var flags = require('flags');
var async = require('async');
var fs    = require('fs');

var logger = require('../common/logger');
var astserver = require('./astserver');

var server = null;
var serverConfig = {};

function initConf() {
    flags.defineInteger('id', 0, 'server instance id');
    flags.defineString('name', 'astserver', 'server name');
    flags.defineString('path', '.', 'root path');
    flags.parse();

    serverConfig.id = flags.get('id');
    serverConfig.path = flags.get('path');
    serverConfig.serv_name = flags.get('name');
    if (serverConfig.path.charAt(serverConfig.path.length - 1) != '/') {
        serverConfig.path += '/';
    }
    serverConfig.content = JSON.parse(fs.readFileSync(serverConfig.path+ './conf/' + serverConfig.serv_name + '.conf', 'utf8').replace(/\$\{SERVER_ID\}/g, serverConfig.id));
}

function initialize(callback) {
    server = new astserver.ASTServer(serverConfig);
    server.listen(function(err) {
        if (err) {
            logger.info('astserver listen err', err);
            process.exit(1);
        }

        logger.info('astserver listen ok');
        callback(err);
    });
    global.TR_ASSISTANT_SERVER = server;
}

function outMemUsage() {
    var mem = process.memoryUsage();
    logger.info('==================================================================');
    logger.info('memory, rss:', Math.round(mem.rss / 1024 / 1024), "MB");
    logger.info('memory, heap total:', Math.round(mem.heapTotal / 1024 / 1024), "MB");
    logger.info('memory, heap used:', Math.round(mem.heapUsed / 1024 / 1024), "MB");
    logger.info('==================================================================');
}

var main  = function() {
    initConf();

    process.chdir(serverConfig.path);

    logger.init(serverConfig.content.logger);
    logger.info('logger inited');
    logger.debug('serverConfig', serverConfig);

    //输出内存相关信息
    outMemUsage();

    async.series([
        function(cb) {
            initialize(cb);
        }],
        function(err) {
            if (err) {
                logger.info('error');
                process.exit(1);
            }
        }
    );
}

main();
