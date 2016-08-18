# PartnerIMServer
##开发工具
**sublime**, 从[MacX](http://www.macx.cn)下载并安装。
##环境配置
**MACOS**, 下面的所有配置针对Macos操作系统

**HomeBrew**, 按照下面的步骤来安装osx下的brew

	1. sudo su
	2. mkdir /usr/local
	3. curl -L http://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C /usr/local

**NodeJS**, 安装NodeJS运行环境
	
	sudo brew install node
	
**Redis**, 安装redis缓存运行环境

	sudo brew intall redis

**MySQL**，安装SQL数据库

	sudo brew install mysql
**Node相关模块**，在PartnerIMServer的根目录下安装所有相关模块。
	
	npm install

##运行时环境

	1. redis-server &
	2. node websvc/bin/www
	
	
	
	
	
	
	

##开发环境配置方法(另一种选择)

**visual studio code**, 从[微软代码](http://code.visualstudio.com)下载并安装。

	2. npm install -g tsd
	3. tsd query node --action install
	4. tsd query express --action install
