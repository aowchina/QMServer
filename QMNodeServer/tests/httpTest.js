var httpHelper = require('../model/httpHelper');

httpHelper.getFile('http://img3.cache.netease.com/video/2013/5/21/20130521150855d82be.jpg', function(err, filename){
    if (err) {
        console.log(err);
    } else {
        console.log(filename);
    }
});