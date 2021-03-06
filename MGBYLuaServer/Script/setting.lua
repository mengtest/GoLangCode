

-----------------------------------------------------------------
-- 服务器地址的定义
-----------------------------------------------------------------
ConstServerAddressLogServer = "192.168.0.218:8330"      -- 日志服务器地址
ConstServerAddressCorrespondServer = "127.0.0.1:8310"   -- 协调服务器地址
ConstServerAddressChatServer = "192.168.101.58"         -- 聊天服的地址

-----------------------------------------------------------------
-- 数据库地址的定义
-----------------------------------------------------------------
---------------------- redis -------------------
ConstRedisAddress = "192.168.101.94:6382"   -- redis 服务器地址
ConstRedisPass = "123456"                -- redis 密码
---------------------- mysql -------------------
ConstMySqlServerIP = "192.168.0.207"
ConstMySqlServerPort = "3307"
ConstMySqlDatabase = "game_by"
ConstMySqlUid = "root"
ConstMySqlPwd = "44"
--------------------- sql server --------------------------
ConstSqlServerIP = "192.168.0.207"
ConstSqlServerDatabase = "DataBase"
ConstSqlServerUid = "sa"
ConstSqlServerPwd = "Aa123456"
--------------------- sql server log --------------------------
ConstSqlServerIP_Log = "192.168.0.207"
ConstSqlServerDatabase_Log = "BY_Log"
ConstSqlServerUid_Log = "sa"
ConstSqlServerPwd_Log = "Aa123456"
------------------sql server 好友 -----------------------
ConstSqlServerIP_Friend= "192.168.0.207"
ConstSqlServerDatabase_Friend = "FriendDB"
ConstSqlServerUid_Friend = "sa"
ConstSqlServerPwd_Friend= "Aa123456"

--------------------------------------------------------------
------------------chatServer 配置-----------------------------
--------------------------------------------------------------
ConstChatServerLoadMessageInDays = 5                                          -----------只加载X天之内的聊天信息



