var express = require('express');
var path = require('path');
var fs    = require('fs');
var morgan = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var logger = require('../common/logger');
var commonconf = require('../common/commonconf')

var epath = path.resolve(".");
var content = JSON.parse(fs.readFileSync(epath + '/conf/websvc.conf', 'utf8'));

logger.init(content.logger);
logger.info('logger inited.');

var routes = require('./routes/index');
var api = require('./routes/api');

var app = express();

app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods","POST,GET,OPTIONS");
    res.header("X-Powered-By",' 3.2.1')
    res.header("Content-Type", "application/json;charset=utf-8");
    next();
});

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(morgan('combined'));

app.use(bodyParser.urlencoded({ extended: true }));
app.use('/api', bodyParser.json());

app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/static', express.static('wwwroot/static'));

app.use('/', routes);
app.use('/api', api);

/// catch 404 and forwarding to error handler
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// development error handler
// will print stacktrace
function errorDevHandler(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', { 
      message: err.message,
      error: err
    });
}

// production error handler
function errorHandler(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', { 
      message: err.message,
      error: {}
    });
}

if (app.get('env') === 'development') {
    app.use(errorDevHandler);
} else {    
    app.use(errorHandler);
}

module.exports = app;
