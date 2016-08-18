#IM协议文档


##*登录*
###发送
```json
{
	"method":"login",
	"body":{
		"phoneNumber":"手机号",
		"password":"密码"
	}
}
```
###返回
```json
{
	"method":"login",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"phoneNumber":"18601138127",
		"nickname":"昵称",
		"token":"验证协议有效期",
		"expiredTime":1447990897 //token有效期，过期重新登录
	}
}
```

##*获取注册验证码*
###发送
```json
{
	"method":"getRegisterVerificationCode",
	"body":{
		"phoneNumber":"手机号"
	}
}
```
###返回
```json
{
	"method":"getRegisterVerificationCode",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"verificationCode":"验证码"
	}
}
```


##*注册*
###发送

```json
{
	"method":"register",
	"body":{
		"phoneNumber":"18601138127",
		"nickname":"昵称",
		"verificationCode":"验证码",
		"password":"密码",
	}
}
```

###返回
```json
{
	"method":"regist",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"nickname":"昵称",
		"phoneNumber":"18601138127"
	}
}
```

##*获取忘记密码验证码*

###发送
```json
{
	"method":"getForgetVerificationCode",
	"body":{
		"phoneNumber":"手机号"
	}
}
```
###返回
```json
{
	"method":"getForgetVerificationCode",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"verificationCode":"验证码"
	}
}
```

##*忘记密码*

###发送
```json
{
	"method":"forgetPassword",
	"body":{
		"phoneNumber":"手机号",
		"verificationCode":"验证码",
		"password":"密码"
	}
}
```
###返回
```json
{
	"method":"forgetPassword",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"phoneNumber":"手机号",
	}
}
```

##*好友关系*
###发送
```json
{
	"method":"getAllFriends",
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"getAllFriends",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"friends" : [phone1, phone2]
	},
	'token': token,
	'userId': userId
}
```

##*加好友*
###发送
```json
{
	"method":"addFriend",
	"body":{
		"friend" : phone
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"addFriend",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		'status' : 1, //1 表示成功， 2 表示等待对方同意
		'friend' : phone
	}
}
```

##*确认加好友*
###发送
```json
{
	"method":"acceptAddFriend",
	"body":{
		"friend" : phone
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"acceptAddFriend",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		 "friend" : phone
	}
}
```

##*删除好友*
###发送
```json
{
	"method":"removeFriend",
	"body":{
		"friend" : phone
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"removeFriend",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"phoneNumber":"手机号"，
		 "friend" : phone
	}
}
```

##*获取用户信息*
###发送
```json
{
	"method":"getUserInfo",
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"getUserInfo",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		"phoneNumber":"phone"，
		"nickname" : '',
		'userId': '',
		'city': '',
		'sign': '',
		sex : 0,
		headUrl : ''
	}
}
```

##*修改用户信息*
###发送
```json
{
	"method":"modifyUserInfo",
	"body":{
		"phoneNumber" : phone,
		"nickname" : '',
		'city': '',
		'sign': '',
		sex : 0,
		headUrl : ''		
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"modifyUserInfo",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	}
}
```

##*获取用户头像*
###发送
http://www.huobanim.com:8080/api/getHeaderImage/[headUrl]
###返回
直接获取返回的文件，或者返回错误。

##*上传用户头像*
###发送
	http://www.huobanim.com:8080/api/uploadHeaderImage
	body增加 token | userId
	基于Form上传，
	body里面只有文件。
	不超过2M
###返回
	直接获取返回的文件名称，或者返回错误。
	
##*批量获取用户信息*
###发送
```json
{
	"method":"mGetUserInfo",
	'body' : {
		ids : ['id1', 'id2', 'id3'] //最多一次20个号码
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"mGetUserInfo",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		{
			"phoneNumber":"phone"，
			"nickname" : '',
			'userId': 'id1',
			'city': '',
			'sign': '',
			sex : 0,
			headUrl : ''
		},
		{
			"phoneNumber":"phone"，
			"nickname" : '',
			'userId': 'id3',
			'city': '',
			'sign': '',
			sex : 0,
			headUrl : ''
		}
	}
}
```

##*批量获取用户信息*
###发送
```json
{
	"method":"searchUser",
	'body' : {
		key : 'data'
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"searchUser",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{
		users : [
		{
			"phoneNumber":"phone"，
			"nickname" : '',
			'userId': 'id1',
			'city': '',
			'sign': '',
			sex : 0,
			headUrl : ''
		},
		{
			"phoneNumber":"phone"，
			"nickname" : '',
			'userId': 'id3',
			'city': '',
			'sign': '',
			sex : 0,
			headUrl : ''
		}]
	}
}
```
##*修改密码*
###发送
```json
{
	"method":"modifyPassword",
	"body":{
		"password":"密码"，
		"newPassword"
	},
	'token': token,
	'userId': userId
}
```

###返回
```json
{
	"method":"modifyPassword",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	}
}
```

##*检验号码是否存在*
###发送
```json
{
	"method":"isExist",
	"body":{
		'phoneNumber' : phoneNumber
	}
}
```

###返回
```json
{
	"method":"isExist",
	"error":{
		"code":200,  //200表示成功 其他表示异常
		"msg":"错误信息"  //异常描述，没有异常为空字符串
	},
	"body":{"userId":''}
}
```





