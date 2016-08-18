var ProtoBuf = require("protobufjs");

var utils = require('../common/utils')

function IMProto() {
    var self = this;
    self.idProtoMap = null;
    self.envPath = null;
}

IMProto.prototype.init = function(envPath) {
    var self = this;
    
    self.idProtoMap = {};
    self.envPath = envPath;
    self.loadProto();
}

IMProto.prototype.loadProto = function() {
    var self = this;

    self.loadMessageProto();
    self.loadFileProto();
}

IMProto.prototype.loadFileProto = function() {
    var self = this;

    var protoPath = self.envPath + '/proto/file.proto';
    global.FILE_MESSAGE_DEF = ProtoBuf.loadProtoFile(protoPath).build('');
    global.PROTO_FILE_MESSAGETYPE_DEF = global.FILE_MESSAGE_DEF.FileMessageType;

    self.idProtoMap[global.PROTO_FILE_MESSAGETYPE_DEF.FileInfoReqOp] = global.FILE_MESSAGE_DEF.FileInfoReq;
    self.idProtoMap[global.PROTO_FILE_MESSAGETYPE_DEF.FileInfoAckOp] = global.FILE_MESSAGE_DEF.FileInfoAck;
    self.idProtoMap[global.PROTO_FILE_MESSAGETYPE_DEF.FileUploadReqOp] = global.FILE_MESSAGE_DEF.FileUploadReq;
    self.idProtoMap[global.PROTO_FILE_MESSAGETYPE_DEF.FileUploadAckOp] = global.FILE_MESSAGE_DEF.FileUploadAck;
    self.idProtoMap[global.PROTO_FILE_MESSAGETYPE_DEF.FileThumbOp] = global.FILE_MESSAGE_DEF.ImageInfo;
}

IMProto.prototype.loadMessageProto = function() {     
    var self = this;

    var protoPath = self.envPath + '/proto/tongren.proto';
    global.PROTO_MESSAGE_DEF = ProtoBuf.loadProtoFile(protoPath).build('');
    global.PROTO_MESSAGETYPE_DEF = global.PROTO_MESSAGE_DEF.MessageType;
    global.PROTO_MESSAGE_BASICTYPE_DEF = global.PROTO_MESSAGE_DEF.MessageBasicType;
    
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.FriendAddOp] = global.PROTO_MESSAGE_DEF.FriendAdd;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.FriendAcceptOp] = global.PROTO_MESSAGE_DEF.FriendAccept;
    
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupKickOp] = global.PROTO_MESSAGE_DEF.GroupKick;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupLeaveOp] = global.PROTO_MESSAGE_DEF.GroupLeave;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupRenameOp] = global.PROTO_MESSAGE_DEF.GroupRename;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupNickOp] = global.PROTO_MESSAGE_DEF.GroupNick;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupDissolveOp] = global.PROTO_MESSAGE_DEF.GroupDissolve;  
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupChangeOwnerOp] = global.PROTO_MESSAGE_DEF.GroupChangeOwner;

    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupInviteOp] = global.PROTO_MESSAGE_DEF.GroupInvite;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupJoinOp] = global.PROTO_MESSAGE_DEF.GroupJoin;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GroupChangeAvatar] = global.PROTO_MESSAGE_DEF.GroupAvatar;
    
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.ModifyUserInfoOp] = global.PROTO_MESSAGE_DEF.ModifyUserInfo;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.Logout] = global.PROTO_MESSAGE_DEF.LogoutOp;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.Connection] = global.PROTO_MESSAGE_DEF.Connect;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.disConnection] = global.PROTO_MESSAGE_DEF.disConnect;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.AckMsg] = global.PROTO_MESSAGE_DEF.Ack;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.Error] = global.PROTO_MESSAGE_DEF.ErrorInfo;

    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.GetQRCodeOp] = global.PROTO_MESSAGE_DEF.GetQRCode;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.MobileScanQRCodeOp] = global.PROTO_MESSAGE_DEF.MobileScanQRCode;
    self.idProtoMap[global.PROTO_MESSAGETYPE_DEF.MobileAcceptQRLoginOp] = global.PROTO_MESSAGE_DEF.MobileAcceptQRLogin;
    
    self.idProtoMap[0x999] = global.PROTO_MESSAGE_DEF.Head;
}

IMProto.prototype.unpackMessage = function(buf) {
    var self = this;

    if (buf == null) {
        return null;
    }

    var protoMsg = global.PROTO_MESSAGE_DEF.PbMessage;
    if (protoMsg == null) {
        return null;
    } else {
        return protoMsg.decode(buf);
    }
}

IMProto.prototype.unpackBody = function(msgId, buf) {
    var self = this;
    
    if (buf == null) {
        return null;
    }

    var protoMsg = self.idProtoMap[msgId];
    if (protoMsg == undefined) {
        throw Error('undefined msg id:' +  msgId);
    } else if (protoMsg == null) {
        return null;
    } else {
        return protoMsg.decode(buf);
    }
}

IMProto.prototype.packSimpleMessage = function(msgid, body, head) {
    var self = this;
    
    var msg = {};
    msg.messageType = msgid;
    if (head) {
        msg.head = head;
    } else {
        msg.head = self.makeMsgHead(utils.uuid());
    }
    msg.timestamp = Date.now();
    if (body) {
        var bodyBuf = self.packBody(msgid, body);
        msg.body = bodyBuf.toBuffer();
    }
    var dataBin = self.packSingleMessage(msg);
    return dataBin.toBuffer();
}

IMProto.prototype.packMessage = function(type, head, msgInfo, body) {
    var self = this;

    var msg = new global.PROTO_MESSAGE_DEF.PbMessage({messageType : type, head: head, timestamp: Date.now(), msgInfo: msgInfo, body: body});
    return msg.encode();
}

IMProto.prototype.packSingleMessage = function(message) {
    var self = this;

    var msg = new global.PROTO_MESSAGE_DEF.PbMessage({messageType : message.messageType, head: message.head, timestamp: message.timestamp, msgInfo: message.msgInfo, body: message.body});
    return msg.encode();
}

IMProto.prototype.packBody = function(msgid, obj) {
    var self = this;

    var ProtoMsg = self.idProtoMap[msgid];
    if (ProtoMsg == undefined) {
        throw Error('undefined msg id:' + msgid);
    } else if (ProtoMsg == null) {
        return null;
    } else {
        var msg = new ProtoMsg(obj);
        return msg.encode();
    }
}

IMProto.prototype.makeMsgHead = function(msgid) {
    var self = this;

    var h = {
        'version' : 3,  //随着proto的版本进行更新啊
        'msgid' : msgid
    };

    return h;
}

global.TONREN_PROTO = global.TONREN_PROTO ? global.TONREN_PROTO : new IMProto();

module.exports = global.TONREN_PROTO;
