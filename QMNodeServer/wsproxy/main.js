
var flags = require('flags');
var async = require('async');
var fs    = require('fs');

var logger = require('../common/logger');
var gproto = require("../model/gproto");
var resque = require('../common/resque');
var commonconf = require('../common/commonconf')
var wsserver = require('./wsserver');

var server = null;
var serverConfig = {};

function initConf() {
    flags.defineInteger('id', 0, 'server instance id');
    flags.defineString('name', 'wsproxy', 'server name');
    flags.defineString('path', '.', 'root path');
    flags.parse();

    serverConfig.id = flags.get('id');
    serverConfig.path = flags.get('path');
    serverConfig.serv_name = flags.get('name');
    if (serverConfig.path.charAt(serverConfig.path.length - 1) != '/') {
        serverConfig.path += '/';
    }
    
    serverConfig.content = JSON.parse(fs.readFileSync(serverConfig.path+ '/conf/' + serverConfig.serv_name + '.conf', 'utf8').replace(/\$\{SERVER_ID\}/g, serverConfig.id));    
}

function reloadConf() {
    serverConfig.content = JSON.parse(fs.readFileSync(serverConfig.path+ '/conf/' + serverConfig.serv_name + '.conf', 'utf8').replace(/\$\{SERVER_ID\}/g, serverConfig.id));
    logger.debug('reload config:', JSON.stringify(serverConfig, null, 4));
}

function initProxyServer(callback) {
    server = new wsserver.WebSocketServer(serverConfig);
    server.listen(function(err) {
        if (err) {
            logger.error('netServer listen err', err);
            process.exit(1);
        }

        logger.info('net server listen ok');
        callback(err);
    });
    
    global.PROXY_SERVER = server;
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
    logger.info('logger inited.');
    
    // global.FDFS_SERVER = serverConfig.content.fdfs.server;
    
    gproto.init(serverConfig.path);
    logger.info('gproto inited.', serverConfig.path);

    resque.init(serverConfig.path);
    logger.info('resque inited.', serverConfig.path);

    process.on('SIGUSR1', reloadConf);
    logger.info('serverConfig', JSON.stringify(serverConfig, null, 4));

    outMemUsage();

    async.series([
        function(cb) {
            initProxyServer(cb);
        }],
        function(err) {
            if (err) {
                process.exit(1);
            }
        }
    );
}

main();
