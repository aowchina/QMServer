
var net = require('net');

function MgmtServer() {
}

MgmtServer.prototype.init = function(conf, appMgmt) {
    var self = this;

    self.appMgmt = appMgmt;

    this.mgmtServer = net.createServer(function(stream) {
        stream.setEncoding('utf-8');

        stream.on('error', function(err) {
            // moving on
        });

        stream.on('data', function(data) {
            var cmdline = data.trim().split(" ");
            var cmd = cmdline.shift();

            switch(cmd) {
                case "quit":
                    stream.end();
                    break;

                default:
                    if (self.appMgmt) {
                        self.appMgmt.processMgmt(cmd, cmdline, function(err, data) {
                            if (err) {
                                stream.write("ERROR: " + err.message + "\n");
                            } else {
                                if (data) {
                                    stream.write(data + "\n");
                                }
                            }
                        });
                    } else {
                        stream.write("ERROR\n");
                    }
            }
        });
    });

    this.mgmtServer.listen(conf.port, conf.host);
}

global.MGMT = global.MGMT ? global.MGMT : new MgmtServer();

module.exports = global.MGMT;
