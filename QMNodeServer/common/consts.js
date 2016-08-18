
exports.MAX_STREAK_DAY = 30;                 // 连续天数循环周期

exports.PER_OFFLINE_COUNT = 15;                 // 每次读取的offline message个数

exports.API_USER = {
    MAX_MGET_IDS : 20,
    MIN_PASSORD_LEN : 6,
    MAX_PASSORD_LEN : 15,
    HEAD_IMAGE_WIDTH : 160,
    HEAD_IMAGE_HEIGHT : 160,
    THUMBNAIL_WIDTH : 180,
    THUMBNAIL_HEIGHT : 180
};

exports.API_GROUP = {
    MIN_MEMBERS_NEWGROUP : 3
};


exports.WsMsgType ={
    WS_S2WS : 0,
    WS_WS2S : 1,
    WS_C2S  : 2,
    WS_S2C  : 3,
    WS_HTTP2WS : 4
};

exports.CHATTERTYPE = {
    USER : 0,
    GROUP : 1
};

exports.Event = {
    // connect --> others
    CLIENT_DISCONNECTED: 0,
    // others --> connect
    CLIENT_KICKED: 1,
    // others --> connect
    UPDATE_POS: 2,
    // connect --> others
    FORCE_QUIT: 3
};

exports.ofEventValue = {
    // user infomation modified
    EVENT_USER_INFO: 1
};

exports.UserQuitType = {
	USER_ACTIVE : 0,
	LOST_CONNECTION : 1,
	LOST_HEARTBEAT : 2,
	TABLE_MOVE_OUT : 3
};

exports.PlatformChannelId = {
	DEVICE : 0,
	APPLE : 1,
    GOOGLE_PLAY: 2
}

exports.FriendStatus = {
    STATUS_NONE            : 0,
    STATUS_INVITE_FROM     : 1,
    STATUS_INVITE_TO       : 2,
    STATUS_FRIEND          : 3,
    STATUS_BLACK           : 4,
    STATUS_REMOVE          : 5
};

exports.Type2Method = {
    test : 'tt'
};

exports.Method2Type = {
    tt : 'test'
};

exports.WordComAndOmit = {
    method : 'm',
    error : 'e',
    body : 'b',
    phoneNumber : 'pn',
    msg : 'msg',
    resource : 'rs',
    code : 'cd',
    password : 'pw',
    friendId : 'fid',
    userId : 'u',
    token : 't',
    syncVer : 'sv',
    verificationCode : 'vc',
    nickName : 'nn',
    newPassword : 'np',
    groupId : 'gid',
    ids : 'ids',
    name : 'nm',
    owner : 'owner',
    dnd : 'dnd',
    star : 'star',
    tempId : 'tid',
    key : 'key',
    sex : 'sex',
    sign : 'sign',
    city : 'city',
    expiredTime : 'ep',
    message : 'message',
    status : 's',
    loginType : 'lt',
    sessionKey : 'sk',
    smallHeadUrl : 'shu',
    headUrl : 'headUrl',
    groups: 'gs',
    canInvite : 'ci',
    maxUser : 'mxu',
    createdTime : "ctm",
    description : "dct",
    joined : 'jnd',
    lastId : 'lastId',
    memberCount : 'mcn',
    qrcode : 'qrd',
    sequenceId : 'sid',
    sequenceType : 'stype',
    extInfo : 'ei',
    remarkName : 'rn',
    count : 'cnt',
    chatterId : 'cid',
    timestamp : 'tst',
    state : 'state',
    typeId : 'tid',
    delay : 'dly',
    mininumSeq : 'mms',
    sequence : 'seq',
    hasMinnumSeq : 'hmms',
    download : 'dl',
    proxy : 'pxy',
    api : 'api',
    nick : 'nick'
};