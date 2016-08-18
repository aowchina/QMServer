var logger = require('../common/logger');

exports.check = function(deviceType, platformId, channelId, currentVer, callback) {
	logger.info('VER', platformId, channelId, currentVer, deviceType);
    if (deviceType == "android" && currentVer <= "1.0.0") {
        callback(null, {
            newVer : "1.0.0", // 最新版本号
            prompt : "New Partner IM Available Now!",
            force : false, // 是否强制更新
            uri : "https://www.baidu.com"
        });
    } else {
	    callback(null);
    }
}
