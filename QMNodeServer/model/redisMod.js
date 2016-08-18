var CSError = require('../common/error').CSError;
var logger  = require('../common/logger');
var myredis = require('../common/myredis');
var errno   = require('../common/errno');
var wlog    = require('../model/wlog');
var Int64   = require('node-int64')

//获取FileInfo
exports.getFileInfo = function(key, callback) {
    var k = 'fm5_' + key;
    myredis.getClient().get(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//设置FileInfo - data 包含文件基本信息 
exports.setFileInfo = function(key, data, callback) {
    var k = 'fm5_' + key;
    myredis.getClient().set(k, data, function(err) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取BlockInfo
exports.getBlockInfo = function(key, callback) {
    var k = 'blk_' + key;
    myredis.getClient().get(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//设置block信息
exports.setBlockInfo = function(key, data, callback) {
    var k = 'blk_' + key;
    myredis.getClient().set(k, data, function(err) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

exports.getBlockData = function(key, callback) {
    var k = key;
    myredis.getRawClient().get(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//设置block信息
exports.appendBlockData = function(key, data, callback) {
    var k = key;
    myredis.getRawClient().append(k, data, function(err) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//设置block信息
exports.removeBlockData = function(key, callback) {
    var k = key;
    myredis.getClient().del(k, function(err) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户id - UserPhoneMap
exports.getNotifyMessage = function(msgid, callback) {
    var k = msgid;
    k = new Buffer(k,'binary');
    myredis.getRawClient().get(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            callback(null, data);
        }
    });
}

//存储用户id - UserPhoneM
exports.pushNotifyMessage = function(msgid, msg, callback) {
    var k = 'notify_' + msgid;
    myredis.getClient().set(k, msg, function(err) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//TODO: Zhichao修改callback参数
//获取自增序列号
exports.genSquenceId=function(key, callback) {
    var k = 'seq_' + key;
    myredis.getClient().incr(k, function(err, data) {
        if (err) {
            myredis.getClient().hmset(k, 25001, function(error) {
                if (err) {
                    callback(error);
                } else {
                    callback(null, 1);
                }
            });
        } else {
            callback(null, Number(data));
        }
    });
}

//##### User #####

//生成分布式唯一userid
//Param shardId: 机器号，共占13bit;
//Incr: 机器自增号
var Long = require("long");

exports.genUserId = function(shardId, callback) {
    var k = 'user_shard_incr_' + shardId;
    myredis.getClient().incr(k, function(err, data) {
        if (err) {
           callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            var tsInMs = Date.now();
            var userid = Long.fromNumber(tsInMs, true);
            userid = userid.sub(Long.fromNumber(1314220021721, true));
            userid = userid.shl(22);
            userid = userid.or(Long.fromNumber(shardId << 10, true));
            userid = userid.or(Long.fromNumber((Number(data) % 1024), true));
            callback(null, userid.toUnsigned().toString());
        }
    });
}

//存储用户基本信息 - User
//userBasic: phone, passwdHash
exports.updateUser = function(userId, userBasic, callback) {
    var k = 'user_' + userId;
    myredis.getClient().hmset(k, userBasic, function(err, data) {
        if (err) {
           callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户基本信息 - User
exports.getUser = function(userId, callback) {
    var k = 'user_' + userId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

function checkNullData(data, callback) {
    if (data==null) {
        callback(new CSError(errno.API_NO_DATA, 'has no data'));
    } else {
        callback(null, data);
    }
}

//获取用户id - UserPhoneMap
exports.getUserid = function(phone, callback) {
    var k = 'user_phone_map_' + phone;
    myredis.getClient().get(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//存储用户id - UserPhoneM
exports.setUserid = function(phone, userId, callback) {
    var k = 'user_phone_map_' + phone;
    myredis.getClient().set(k, userId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//存储用户登录信息 - UserLogin
//loginInfo: loginType, token
exports.setUserLogin = function(userId, loginInfo, ttl, callback) {
    var k = 'user_login_' + userId;
    var multi = myredis.getClient().multi();
    multi.hmset(k, loginInfo);
    multi.expire(k, ttl);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户登录信息 - UserLogin
exports.getUserLogin = function(userId, callback) {
    var k = 'user_login_' + userId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            callback(null, data);
        }
    });
}

//删除用户登录 - removeUserLogin
exports.removeUserLogin = function(userId, callback) {
    var k = 'user_login_' + userId;
    myredis.getClient().del(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//用户是否新设备登录 - UserDevice
exports.checkNewDevice = function(userId, deviceId, callback) {
    var k = 'user_device_' + userId;
    myredis.getClient().sismember(k, deviceId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            callback(null, data);
        }
    });
}

//添加新设备 - DeviceInfo
//deviceInfo: resource, register
exports.addNewDevice = function(userId, deviceId, deviceInfo, callback) {
    var k = 'user_device_' + userId;
    var deviceKey = 'device_info_' + userId + '_' + deviceId;
    var multi = myredis.getClient().multi();
    multi.sadd(k, deviceId);
    multi.hmset(deviceKey, deviceInfo);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户信息 - UserInfo
exports.getUserInfo = function(userId, callback) {
    var k = 'user_info_' + userId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//获取用户简要信息 - UserInfo
exports.getBriefUserInfo = function(userId, callback) {
    var k = 'user_info_' + userId;
    myredis.getClient().hmget(k, 'nick', 'sex', 'headUrl', 'city', 'sign', 'syncVer', 'smallHeadUrl', function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//存储用户信息 - UserInfo
//userInfo: nick, city, sign, sex, smallHeadUrl, headUrl, syncVer
exports.setUserInfo = function(userId, userInfo, callback) {
    var k = 'user_info_' + userId;
    myredis.getClient().hmset(k, userInfo, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户激活码 - UserActivition
exports.getUserActiveCode = function(phone, callback) {
    var k = 'user_active_' + phone;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//存储用户激活码 - UserActivition
//activeInfo: activeCode, reqTime
exports.setUserActiveCode = function(phone, activeInfo, ttl, callback) {
    var k = 'user_active_' + phone;
    var multi = myredis.getClient().multi();
    multi.hmset(k, activeInfo);
    multi.expire(k, ttl);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户重置密码Code - ResetPassword
exports.getResetPasswdCode = function(phone, callback) {
    var k = 'reset_passwd_' + phone;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//存储用户重置密码Code - ResetPassword
//resetInfo: resetCode, reqTime
exports.setResetPasswdCode = function(phone, resetInfo, ttl, callback) {
    var k = 'reset_passwd_' + phone;
    var multi = myredis.getClient().multi();
    multi.hmset(k, resetInfo);
    multi.expire(k, ttl);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//删除用户在线设备 - remmoveUserOnlineDevice
exports.removeUserOnlineDevices = function(userId, session, callback) {
    var k = 'user_online_device_' + userId;
    myredis.getClient().srem(k, session, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取用户在线设备 - UserOnlineDevice
exports.getUserOnlineDevices = function(userId, callback) {
    var k = 'user_online_device_' + userId;
    myredis.getClient().smembers(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//存储用户在线设备 - UserOnlineDevice
exports.setUserOnlineDevice = function(userId, sessionId, callback) {
    var k = 'user_online_device_' + userId;
    myredis.getClient().sadd(k, sessionId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//##### Friend #####

//获取用户好友id - UserFriend
exports.getUserFriendIds = function(userId, callback) {
    var k = 'user_friend_' + userId;
    myredis.getClient().smembers(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            // checkNullData(data, callback);
            callback(null, data);
        }
    });
}

//用户是否好友关系 - UserFriend
exports.checkFriend = function(userId, friendId, callback) {
    var k = 'user_friend_' + userId;
    myredis.getClient().sismember(k, friendId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            callback(null, data);
        }
    });
}

//获取用户好友信息 - FriendInfo
exports.getUserFriendInfo = function(userId, friendId, callback) {
    var k = 'friend_info_' + userId + '_' + friendId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//修改用户好友信息 - FriendInfo
//friendInfo: status, nick
exports.updateFriendInfo = function(userId, friendId, friendInfo, callback) {
    var k = 'friend_info_' + userId + '_' + friendId;
    myredis.getClient().hmset(k, friendInfo, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//增加好友 - FriendInfo
//friendInfo: status, nick
exports.addFriend = function(userId, friendId, friendInfo, callback) {
    var k = 'user_friend_' + userId;
    var friendKey = 'friend_info_' + userId + '_' + friendId;
    var multi = myredis.getClient().multi();
    multi.sadd(k, friendId);
    multi.hmset(friendKey, friendInfo);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//##### Group #####

//生成分布式唯一groupid
//Param shardId: 机器号，共占13bit;
//Incr: 机器自增号
exports.genGroupId = function(shardId, callback) {
    var k = 'group_shard_incr_' + shardId;
    myredis.getClient().incr(k, function(err, data) {
        if (err) {
           callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            var tsInMs = Date.now();
            var groupId = Long.fromNumber(tsInMs, true);
            groupId = groupId.sub(Long.fromNumber(1314220021721, true));
            groupId = groupId.shl(23);
            groupId = groupId.or(Long.fromNumber(shardId << 10, true));
            groupId = groupId.or(Long.fromNumber((Number(data) % 1024), true));
            callback(null, groupId.toUnsigned().toString());            
        }
    });
}

//存储群组Avatar信息
exports.setGroupAvatar = function(groupId, linkAvatar, callback) {
    var k = 'group_' + groupId;
    myredis.getClient().hmset(k, 'avatar', linkAvatar, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取群组的Avatar信息
exports.getGroupAvatar = function(groupId, callback) {
    var k = 'group_' + groupId;
    myredis.getClient().hget(k, 'avatar', function(err, avatar) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            checkNullData(avatar, callback);
        }
    });
}

//存储群信息 - Group
//groupInfo: owner, gname, descrip, maxUser, created, modified, avatar, canInvite, syncVer
exports.setGroupInfo = function(groupId, groupInfo, callback) {
    var k = 'group_' + groupId;
    myredis.getClient().hmset(k, groupInfo, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取群信息 - Group
exports.getGroupInfo = function(groupId, callback) {
    var k = 'group_' + groupId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//删除群信息 - Group
exports.delGroup = function(groupId, callback) {
    var k = 'group_' + groupId;
    myredis.getClient().del(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取群成员id - GroupMember
exports.getGroupMemberIds = function(groupId, callback) {
    var k = 'grp_mem_' + groupId;
    myredis.getClient().lrange(k, 0, -1, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//获取群成员id - GroupMember
exports.getCountGroupMemberIds = function(groupId, count, callback) {
    var k = 'grp_mem_' + groupId;
    myredis.getClient().lrange(k, 0, count, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//增加群成员 - GroupMember,GroupMemberInfo,UserGroupMap
//memberInfo: nick, isUndisturb, isStar, joined
exports.addGroupMember = function(groupId, memberId, memberInfo, callback) {
    var k = 'grp_mem_' + groupId;
    var memKey = 'grp_mem_info_' + groupId + '_' + memberId;
    var mapKey = 'user_grp_map_' + memberId;
    var multi = myredis.getClient().multi();
    multi.rpush(k, memberId);
    multi.hmset(memKey, memberInfo);
    multi.sadd(mapKey, groupId);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//删除群成员 - GroupMember,GroupMemberInfo,UserGroupMap
exports.delGroupMember = function(groupId, memberId, callback) {
    var k = 'grp_mem_' + groupId;
    var memKey = 'grp_mem_info_' + groupId + '_' + memberId;
    var mapKey = 'user_grp_map_' + memberId;
    var multi = myredis.getClient().multi();
    multi.lrem(k, 0, memberId);
    multi.del(memKey);
    multi.srem(mapKey, groupId);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取群成员信息 - GroupMemberInfo
exports.getGroupMemberInfo = function(groupId, memberId, callback) {
    var k = 'grp_mem_info_' + groupId + '_' + memberId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//存储群成员信息 - GroupMemberInfo
//memberInfo: nick, isUndisturb, isStar, joined
exports.updateGroupMemberInfo = function(groupId, memberId, memberInfo, callback) {
    var k = 'grp_mem_info_' + groupId + '_' + memberId;
    myredis.getClient().hmset(k, memberInfo, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//用户是否进群 - UserGroupMap
exports.checkUserInGroup = function(userId, groupId, callback) {
    var k = 'user_grp_map_' + userId;
    myredis.getClient().sismember(k, groupId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            callback(null, data);
        }
    });
}

//获取用户所有群id - UserGroupMap
exports.getUserGroupIds = function(userId, callback) {
    var k = 'user_grp_map_' + userId;
    myredis.getClient().smembers(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//##### offline message #####

//获取离线系统消息id - op_offline_msgs_<uid>
exports.getOpOfflineMsgs = function(userId, callback) {
    var k = 'op_offline_msgs_' + userId;
    myredis.getClient().smembers(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//删除用户离线系统信息 - op_offline_msgs_<uid>
exports.delUserOpOfflineMsg = function(userId, callback) {
    var k = 'op_offline_msgs_' + userId;
    myredis.getClient().del(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取离线系统消息body - op_offline_msg_body
exports.getOpOfflineMsgBody = function(userId, msgId, callback) {
    var k = 'op_offline_msg_body';
    myredis.getRawClient().hget(k, msgId+'_'+userId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//删除离线系统信息body - op_offline_msg_body
exports.delOpOfflineMsgBody = function(userId, msgId, callback) {
    var k = 'op_offline_msg_body';
    myredis.getClient().hdel(k, msgId+'_'+userId, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取并删除群离线消息 - OfflineMessageGroup
//Param: count - 获取数量
exports.getOfflineMsgGroup = function(userId, count, callback) {
    var k = 'offline_msg_group_' + userId;
    var multi = myredis.getClient().multi();
    multi.lrange(k, 0, count-1);
    multi.ltrim(k, count, -1);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//获取并删除好友离线消息 - OfflineMessageFriend
exports.getOfflineMsgFriend = function(userId, count, callback) {
    var k = 'offline_msg_friend_' + userId;
    var multi = myredis.getClient().multi();
    multi.lrange(k, 0, count-1);
    multi.ltrim(k, count, -1);
    multi.exec(function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_MULTI_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//增加个性化表情
exports.setPersonalEmotion = function(userId, url, emoJson, callback) {
    var k = 'per_emot_' + userId;
    myredis.getClient().hset(k, url, emoJson, function(err, data) {
        if (err) {
           callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null);
        }
    });
}

//获取所有个性化表情
exports.getPersonalEmotions = function(userId, callback) {
    var k = 'per_emot_' + userId;
    myredis.getClient().hgetall(k, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//删除个性化表情
exports.delPersonalEmotion = function(userId, url, callback) {
    var k = 'per_emot_' + userId;
    myredis.getClient().hdel(k, url, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            callback(null, data);
        }
    });
}

//获取max seq id
exports.getMaxSeq = function(uidgid, callback) {
    var k = 'history_seq';
    myredis.getClient().hget(k, uidgid + '', function(err, seq) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(seq, callback);
        }
    });
}

//获取max friend seq id
exports.getMaxFriendSeq = function(uid, friendid, callback) {
    var k = 'friend_seq_' + uid;
    myredis.getClient().hget(k, friendid + '', function(err, seq) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(seq, callback);
        }
    });
}

//获取用户最近聊天Session
exports.getUserLatestChatSessions = function(userId, callback) {
    var k = 'lastest_session_' + userId;
    myredis.getClient().zrange(k, 0, 19, 'withscores', function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_GET_FAIL, err.message));
        } else {
            checkNullData(data, callback);
        }
    });
}

//删除用户最近聊天Session
exports.delUserLatestChatSession = function(userId, chatid, chatType, callback) {
    var k = 'lastest_session_' + userId;
    myredis.getClient().zrem(k,  chatid+'_'+chatType, function(err, data) {
        if (err) {
            callback(new CSError(errno.REDIS_SET_FAIL, err.message));
        } else {
            console.log(k + ',' + chatid+'_'+chatType + ", state : " + data);
            callback(null);
        }
    });
}
