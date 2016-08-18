
var log4js = require("log4js");

function Logger() {
    var self = this;
    self.inited = false;
}

Logger.prototype.init = function(config) {
    var self = this;

    if (self.inited) {
        return ;
    }

    log4js.configure(config);
    self.mainLogger = log4js.getLogger("MAIN");
    self.inited = true;
}

Logger.prototype.initConsole = function() {
    var self = this;

    self.init({
        "levels" : {
            "MAIN" : "debug"
        },
        "appenders" : [
            {
                "category"   : "MAIN",
                "type"       : "console",
                "layout"     : 
                {
                    "type"   : "pattern",
                    "pattern": "[%d] %p %m"
                } 
            }
        ]
    });
}

var levels = ['Debug','Info','Warn','Error','Fatal'];
levels.forEach(
    function(levelString) {
        Logger.prototype[levelString.toLowerCase()] = function (/* id, content */) {
            var self = this;

            if (!self.mainLogger['is'+levelString+'Enabled']()) {
                return;
            }

            var args = Array.prototype.slice.call(arguments);
            var str = '';

            for (var i = 0; i < args.length; i ++) {
                var arg = args[i];
                if (i > 0) {
                    str += ' ';
                    if (typeof arg == 'object') {
                        str += JSON.stringify(arg);    
                    } else {
                        str += arg;
                    }
                } else {
                    if (typeof arg == 'object') {
                        str = JSON.stringify(arg);    
                    } else {
                        str = arg;
                    }
                }
            }

            self.mainLogger[levelString.toLowerCase()](str);
        };
    }
);

var testcfg = {
    "levels" : {
        "MAIN" : "debug",
        "DETAIL" : "info"
    },
    "appenders" : [
        {
            "category"   : "MAIN",
            "type"       : "file",
            "filename"   : "../log/debug.log",
            "maxLogSize" : 10485760,
            "backups"    : 9,
            "layout"     :
            {
                "type"   : "pattern",
                "pattern": "[%d] %p %m"
            }
        },
        {
            "category"   : "MAIN",
            "type"       : "console",
            "layout"     :
            {
                "type"   : "pattern",
                "pattern": "[%d] %p %m"
            }
        }
    ]
};
Logger.prototype.testinit = function() {
    var self = this;

    if (self.inited) {
        return ;
    }

    log4js.configure(testcfg);
    self.mainLogger = log4js.getLogger("MAIN");
    self.inited = true;
}

global.LOGGER = global.LOGGER ? global.LOGGER : new Logger();

module.exports = global.LOGGER;
