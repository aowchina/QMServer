var buffer = require('buffer');
var express = require('express');
var router = express.Router();

var errno    = require('../../common/errno');
var CSError  = require('../../common/error').CSError;

var consts  = require('../../common/consts');
var utils   = require('../../common/utils');
var logger  = require('../../common/logger');

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'QM Node Server welcome you!' });
});

module.exports = router;