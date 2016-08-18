var Sub = require('../common/psub').Subscribe;

var channel = 'queue_wsproxy_0';
var sub = new Sub(channel);
sub.init();    
sub.listen(function(data){
	console.log(data);
});