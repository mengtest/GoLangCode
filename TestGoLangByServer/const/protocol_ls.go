
package _const

const (
	//# 消息类别 = 必须写在DG_MAX之前
	MDM_MB_LOGON             = 100
	MDM_MB_SERVER_LIST       = 101
	MDM_MB_USER_INFO         = 102
	MDM_MB_ACTIVITY          = 103 //# 活动
	MDM_MB_PURCHASE          = 104 //# 充值相关
	MDM_MB_MESSAGE           = 105 //# 消息中心主消息
	MDM_MB_GAME_OPTION       = 106 //# 游戏配置
	MDM_MB_HEARTBEAT         = 107 //# 心跳
	MDM_MB_VIP               = 108 //# VIP
	MDM_MB_GIFT_PACK         = 109 //# 礼包
	MDM_MB_REWARD            = 110 //# 通用奖励
	MDM_MB_MISSION           = 111 //# 任务
	MDM_MB_ACHIEVEMENT_TITLE = 112 //# 称号
	MDM_MB_GUILD             = 113 //# 公会

	//# 登录子消息
	SUB_MB_LOGON_GAMEID                  = 1  //# I D 登录
	SUB_MB_LOGON_ACCOUNTS                = 2  //# 账号登录
	SUB_MB_REGISTER_ACCOUNTS             = 3  //# 注册账号
	SUB_MB_REGISTER_CONFIRMCODE          = 4  //# 申请注册验证码
	SUB_MB_GUESTLOGIN                    = 5  //# 游客登录
	SUB_MB_GUESTBINGDING                 = 6  //# 游客账号绑定
	SUB_MB_LOGON_SUCCESS                 = 7  //# 登录成功
	SUB_MB_LOGON_FAILURE                 = 8  //# 登录失败
	SUB_MB_GUESTBINDING_SUCCESS          = 9  //# 绑定成功
	SUB_MB_GUESTBINDING_FAILURE          = 10 //# 绑定失败
	SUB_MB_UPDATE_NOTIFY                 = 11 //# 升级提示
	SUB_MB_SDKLOGIN                      = 12 //# SDK登陆
	SUB_MB_C_CLIENTVERSION               = 13 //# 获取版本号
	SUB_MB_S_CLIENTVERSION               = 14 //# 获取版本号
	SUB_MB_REGISTER_CONFIRMCODE_RESULT   = 15 //# 申请注册验证码回复
	SUB_MB_REGISTER_ACCOUNTS_RESULT      = 16 //# 账号注册回复
	SUB_MB_LOGON_FINISH                  = 17 //# 登陆完成
	SUB_MB_BACK_HALL                     = 18 //# 切换回大厅
	SUB_MB_ENTER_HALL                    = 19 //# 进入大厅
	SUB_MB_GUEST_REGISTER_ACCOUNT        = 20 //# 游客账号注册
	SUB_MB_GUEST_REGISTER_ACCOUNT_RESULT = 21 //# 注册结果
	SUB_MB_ACTIVE_ACCOUNT                = 22 //# 激活账号
	SUB_MB_C2L_SDKBINDING                = 23 //# SDK绑定
	SUB_MB_L2C_SDKBINDING                = 24 //# SDK绑定返回

	//# 礼包子协议
	SUB_MB_L2C_GIFT_PRODUCT_INFO = 0 //# 礼包产品信息
	SUB_MB_C2L_MY_GIFT_PACK_INFO = 1 //# 请求我的礼包
	SUB_MB_L2C_MY_GIFT_PACK_INFO = 2 //# 请求我的礼包返回

	//# 心跳
	SUB_MB_S_VIP_INFO        = 0 //# VIP信息
	SUB_MB_C_REFRESH_VIP     = 1 //# 请求VIP信息
	SUB_MB_C_UPLOAD_VIP_INFO = 2 //# 上传VIP个人信息
	SUB_MB_S_UPLOAD_VIP_INFO = 3 //# 上传结果

	//# 房间信息
	SUB_MB_LIST_KIND                 = 1 //# 种类列表
	SUB_MB_LIST_SERVER               = 2 //# 房间列表
	SUB_MB_LIST_FINISH               = 3 //# 列表完成
	SUB_MB_C_SERVER_ONLINE_COUNT     = 4 //# 客户端请求服务器人数
	SUB_MB_S_SERVER_ONLINE_COUNT     = 5 //# 服务器返回服务器人数
	SUB_MB_C_ALL_SERVER_ONLINE_TOTAL = 6 //# 客户端请求所有服务器房间的总在线人数
	SUB_MB_S_ALL_SERVER_ONLINE_TOTAL = 7 //# 返回所有服务器房间的总在线人数
	SUB_MB_C_SERVER_TABLE_INFO       = 8 //# 服务器桌子信息
	SUB_MB_S_SERVER_TABLE_INFO       = 9 //# 服务器桌子信息

	//# 用户数据
	SUB_MB_ADD_USER_INFO                   = 1  //# 增加资料 （ 姓名，身份证，手机 ）
	SUB_MB_MODIFY_NICKNAME                 = 2  //# 修改昵称
	SUB_MB_MODIFY_FACE                     = 3  //# 修改头像
	SUB_MB_GETACCOUNTPROTECT               = 4  //# 获取账号保护信息
	SUB_MB_OPERATE_RESULT                  = 5  //# 操作结果
	SUB_MB_USERRUN_INFO                    = 6  //# 玩家动态
	SUB_MB_RANK_DATA_REQ                   = 7  //# 请求排行榜
	SUB_MB_RANK_DATA                       = 8  //# 排行榜列表
	SUB_MB_ONLINE_GIFT                     = 9  //# 在线奖励
	SUB_MB_ONLINE_GIFT_REQ                 = 10 //# 申请在线奖励(在登陆服)
	SUB_MB_ONLINE_GIFT_RESULT              = 11 //# 在线奖励结果(在登陆服)
	SUB_MB_ONLINE_GIFT_TYPE_REQ            = 12 //# 在线奖励列表(在登陆服)
	SUB_MB_ONLINE_GIFT_TYPE_RESULT         = 13 //# 在线奖励列表(在登陆服)
	SUB_MB_C_REFRESH_MONEY                 = 14 //# 请求刷新金币和奖券
	SUB_MB_S_REFRESH_MONEY                 = 15 //# 刷新金币和奖券回复
	SUB_MB_S_FEED_BACK                     = 16 //# 游戏反馈
	SUB_MB_C_FEED_BACK                     = 17 //# 反馈回复
	SUB_MB_C_FEED_BACK_REQUEST             = 18 //# 我的咨询
	SUB_MB_S_FEED_BACK_REQUEST             = 19 //# 我的咨询返回
	SUB_MB_C_CHECK_PHONE_CONFIRM_CODE      = 20 //# 验证手机验证码
	SUB_MB_S_CHECK_PHONE_CONFIRM_CODE      = 21 //# 验证手机验证码回复
	SUB_MB_C_FIND_PASSWORD                 = 22 //# 找回手机密码
	SUB_MB_S_FIND_PASSWORD                 = 23 //# 找回手机验证码结果
	SUB_MB_S_USER_MATERIAL_OBJECT          = 24 //# 用户实物
	SUB_MB_C_UPDATE_USER_MATERIAL_OBJECT   = 25 //# 更新用户实物信息
	SUB_MB_S_UPDATE_USER_MATERIAL_OBJECT   = 26 //# 更新用户实物信息
	SUB_MB_C_REFRESH_USER_MATERIAL_OBJCECT = 27 //# 请求刷新实物信息
	SUB_MB_C_PAKAGE_INFO                   = 28 //# 客户端请求背包信息
	SUB_MB_S_PAKAGE_INFO                   = 29 //# 服务器返回背包信息
	SUB_MB_C_BUY_ITEM                      = 30 //# 客户端请求购买道具
	SUB_MB_S_BUY_ITEM                      = 31 //# 服务器返回购买道具
	SUB_MB_C_SELL_ITEM                     = 32 //# 客户端请求出售道具
	SUB_MB_S_SELL_ITEM                     = 33 //# 服务器返回出售道具
	SUB_MB_C_GIVE_ITEM                     = 34 //# 客户端请求赠送道具
	SUB_MB_S_GIVE_ITEM                     = 35 //# 服务器返回赠送道具
	SUB_MB_C_GET_CURRENT_SERVER            = 36 //# 获取当前服务器
	SUB_MB_S_GET_CURRENT_SERVER            = 37 //# 获取当前服务器
	SUB_MB_C_GIVE_NICKNAME                 = 38 //# 客户端请求赠送对象的昵称
	SUB_MB_S_GIVE_NICKNAME                 = 39 //# 服务器返回赠送对象的昵称
	SUB_MB_C_FIND_ACCOUNT_PASSWORD         = 40 //# 申请找回账号密码
	SUB_MB_S_FIND_ACCOUNT_PASSWORD         = 41 //# 申请找回账号密码回复
	SUB_MB_C_DIAL_RECORD                   = 42 //# 客户端请求中奖记录
	SUB_MB_S_DIAL_RECORD                   = 43 //# 返回
	SUB_MB_C_REQUEST_ARENA                 = 44 //# 请求竞技场数据
	SUB_MB_S_REQUEST_ARENA                 = 45 //# 请求竞技场数据
	SUB_MB_C_FEED_BACK_UPDATE              = 46
	SUB_MB_C_UNLOCK_CANNON_MULTIPLE        = 47 //# 解锁炮倍数
	SUB_MB_S_UNLOCK_CANNON_MULTIPLE        = 48 //# 解锁炮倍数
	SUB_MB_C_REQUEST_ARENA_RANK            = 49 //# 请求竞技场排行
	SUB_MB_S_REQUEST_ARENA_RANK            = 50 //# 请求竞技场排行
	SUB_MB_S_REQUEST_ARENA_RANK_EVERY_DAY  = 51 //# 请求捕鱼达人
	SUB_MB_C_UPLOAD_PASSPORT               = 52 //# 上传身份证
	SUB_MB_S_UPLOAD_PASSPORT               = 53 //# 上传结果
	SUB_MB_S_MATCH_INVITE                  = 54 //# 服务器广播邀战
	SUB_MB_C_FEED_BACK_REQUEST_CONTENT     = 55 //# 我的咨询
	SUB_MB_S_FEED_BACK_REQUEST_CONTENT     = 56 //# 我的咨询返回
	SUB_MB_C_LEVELUP_SITE                  = 57 //# 升级炮座（法阵功能）
	SUB_MB_S_LEVELUP_SITE                  = 58 //# 升级炮座（法阵功能）
	SUB_MB_C_GET_TIMEGIFT                  = 59 //# 获取时间礼包
	SUB_MB_S_GET_TIMEGIFT                  = 60 //# 获取时间礼包
	SUB_MB_C_CLICK_PRAISE                  = 61 //# 点赞
	SUB_MB_S_CLICK_PRAISE                  = 62 //# 点赞
	SUB_MB_C_BREAK_ITEM                    = 63 //# 分解
	SUB_MB_S_BREAK_ITEM                    = 64 //# 分解
	SUB_MB_C_REMOVE_BIND                   = 65 //# 解除绑定
	SUB_MB_S_REMOVE_BIND                   = 66 //# 解除绑定回复
	SUB_MB_S_MODIFY_NICKNAME               = 67 //# 昵称修改返回
	SUB_MB_C_MODIFY_NICKNAME_INFO          = 68 //# 请求昵称修改信息
	SUB_MB_S_MODIFY_NICKNAME_INFO          = 68 //#
	SUB_MB_C_UNLOCK_CANNON_REWARD          = 70 //# 请求加载奖励列表
	SUB_MB_S_UNLOCK_CANNON_REWARD          = 71 //# 解锁炮奖励列表
	SUB_MB_C_GET_UNLOCK_CANNON_REWARD      = 72 //# 获取解锁炮奖励
	SUB_MB_S_GET_UNLOCK_CANNON_REWARD      = 73 //# 获取解锁炮奖励
	SUB_MB_C_UPDATE_NEWGUIDE_STATUS        = 74 //# 更新引导进度
	SUB_MB_C_MODIFY_NICKNAME               = 75 //# 新版本
	SUB_MB_C_SET_GIVE_PASSWORD             = 76 //# 设置赠送密码
	SUB_MB_S_SET_GIVE_PASSWORD             = 77 //# 设置赠送密码
	SUB_MB_C_MODIFY_GIVE_PASSWORD          = 78 //# 修改赠送密码
	SUB_MB_S_MODIFY_GIVE_PASSWORD          = 79 //# 修改赠送密码
	SUB_MB_C_REQUEST_ARENA_ACTIVITY_RANK   = 80 //# 请求竞技场排行
	SUB_MB_S_REQUEST_ARENA_ACTIVITY_RANK   = 81 //# 请求竞技场排行
	SUB_MB_C_LOAD_USER_ARENA_ACTIVITY      = 82 //# 加载活动赛信息
	SUB_MB_S_LOAD_USER_ARENA_ACTIVITY      = 83 //# 加载活动赛信息
	SUB_MB_C_ARENA_BIG_PRIZE_RANK          = 84 //# 请求大奖赛排行
	SUB_MB_S_ARENA_BIG_PRIZE_RANK          = 85 //# 请求大奖赛排行
	SUB_MB_C_ARENA_BIG_PRIZE_MONTH_FIRST   = 86 //# 请求大奖赛月冠军
	SUB_MB_S_ARENA_BIG_PRIZE_MONTH_FIRST   = 87 //# 请求大奖赛月冠军
	SUB_MB_C_USER_BIG_PRIZE_REWARD_LIST    = 88 //# 查看自己大奖赛获得的奖励
	SUB_MB_S_USER_BIG_PRIZE_REWARD_LIST    = 89 //# 查看自己大奖赛获得的奖励
	SUB_MB_C_USER_GET_BIG_PRIZE_REWARD     = 90 //# 领取大奖赛获奖励
	SUB_MB_S_USER_GET_BIG_PRIZE_REWARD     = 91 //# 领取大奖赛获奖励
	SUB_MB_C_USER_GET_BIG_PRIZE_INFO       = 92 //# 获取用户大奖赛信息
	SUB_MB_S_USER_GET_BIG_PRIZE_INFO       = 93 //# 获取用户大奖赛信息
	SUB_MB_C_BUY_BULLET_SKIN               = 94 //# 大厅兑换子弹皮肤
	SUB_MB_S_BUY_BULLET_SKIN               = 95 //#

	SUB_MB_C_GET_CHAT_SERVER_INFO = 100 //# 获取聊天服务器信息
	SUB_MB_S_GET_CHAT_SERVER_INFO = 101 //# 获取聊天服务器信息

	//# 任务相关之协议
	SUB_MB_C_MISSION_UPDATE      = 0
	SUB_MB_S_MISSION_UPDATE      = 1
	SUB_MB_C_LOAD_MISSION        = 2  //# 加载任务
	SUB_MB_S_LOAD_MISSION        = 3  //# 加载任务
	SUB_MB_C_GET_MISSION_REWARD  = 4  //# 领取任务奖励
	SUB_MB_S_GET_MISSION_REWARD  = 5  //# 领取任务奖励
	SUB_MB_C_GET_LIVENESS_REWARD = 6  //# 获取活跃度奖励
	SUB_MB_S_GET_LIVENESS_REWARD = 7  //# 获取活跃度奖励
	SUB_MB_C_RESET_MISSION       = 8  //# 重置任务
	SUB_MB_S_RESET_MISSION       = 9  //# 重置任务
	SUB_MB_C_GET_WEEK_REWARD     = 10 //# 获取周常藏宝阁奖励
	SUB_MB_S_GET_WEEK_REWARD     = 11 //# 获取周常藏宝阁奖励

	//# 运营活动
	SUB_MB_S2C_ACTIVITY                       = 0  //# 活动相关信息
	SUB_MB_C2S_ACTIVITY_SIGN                  = 1  //# 每日签到
	SUB_MB_S2C_ACTIVITY_SIGN_SUCESS           = 2  //# 签到成功
	SUB_MB_S2C_ACTIVITY_SIGN_FAIL             = 3  //# 签到失败
	SUB_MB_C2S_GET_REWARD                     = 4  //# 领取奖励（绑定，首冲）
	SUB_MB_S2C_GET_REWARD                     = 5  //# 领取奖励回复（绑定，首冲）
	SUB_MB_C2S_ACTIVITY_CONFIG                = 6  //# 获取活动信息
	SUB_MB_S2C_ACTIVITY_CONFIG                = 7  //# 活动信息回复
	SUB_MB_S2C_ACTIVITY_CELL_INFO_LIST        = 8  //# 具体活动配置信息
	SUB_MB_S2C_REFRESH_ONE_DAY                = 9  //# 刷新一天新的数据（重置签到，在线奖励等）
	SUB_MB_C2S_ACTIVITY_BUY_GIFT_INFO         = 10 //# 活动夺宝奇兵基本信息
	SUB_MB_C2S_ACTIVITY_BUY_GIFT              = 11 //# 活动夺宝奇兵购买
	SUB_MB_S2C_ACTIVITY_BUY_GIFT              = 12 //# 活动夺宝奇兵购买回复
	SUB_MB_S2C_ACTIVITY_GIFT_ALL              = 13 //# 活动夺宝奇兵礼包信息更新
	SUB_MB_S2C_ACTIVITY_GIFT_PRIZE_ALL        = 14 //# 活动夺宝奇兵礼包广播中奖
	SUB_MB_S2C_ACTIVITY_GIFT_RESTART_ALL      = 15 //# 活动夺宝奇兵礼包重置广播
	SUB_MB_C2S_ACTIVITY_GIFT_PACKAGE          = 16 //# 领取起航礼包
	SUB_MB_S2C_ACTIVITY_GIFT_PACKAGE          = 17 //# 领取起航礼包答复
	SUB_MB_C2S_ACTIVITY_DIAL_INFO             = 18 //# 轮盘奖品信息
	SUB_MB_S2C_ACTIVITY_DIAL_INFO_BACK        = 19 //# 轮盘奖品信息答复
	SUB_MB_C2S_ACTIVITY_PLAY_DIAL             = 20 //# 轮盘抽奖
	SUB_MB_S2C_ACTIVITY_PLAY_DIAL_BACK        = 21 //# 轮盘抽奖答复
	SUB_MB_C2S_ACTIVITY_FRESH_PACKAGE         = 22 //# 新手礼包
	SUB_MB_S2C_ACTIVITY_FRESH_PACKAGE_BACK    = 23 //# 新手礼包答复
	SUB_MB_C_INVITE_INFO                      = 24 //# 查询自己的邀请信息
	SUB_MB_S_INVITE_INFO                      = 25 //# 查询自己的邀请信息回复
	SUB_MB_C_ACCEPT_INVITE                    = 26 //# 接受邀请，领取红包
	SUB_MB_S_ACCEPT_INVITE                    = 27 //# 接受邀请，领取红包结果
	SUB_MB_C_INVITE_REWARD_INFO               = 28 //# 查询自己的邀请奖励信息
	SUB_MB_S_INVITE_REWARD_INFO               = 29 //# 查询自己的邀请奖励信息回复
	SUB_MB_C_GET_INVITE_REWARD                = 30 //# 领取邀请奖励
	SUB_MB_S_GET_INVITE_REWARD                = 31 //# 领取邀请奖励回复
	SUB_MB_C_GET_SIGNDAY_GIFT                 = 32 //# 获取累计签到礼包
	SUB_MB_S_GET_SIGNDAY_GIFT                 = 33 //# 获取累计签到礼包回复
	SUB_MB_C2S_ACTIVITY_PLAY_DIAL_EX          = 34 //# 轮盘抽奖
	SUB_MB_S2C_ACTIVITY_PLAY_DIAL_BACK_EX     = 34 //# 轮盘抽奖答复
	SUB_MB_C_ACTIVITY_SIGN_EX                 = 36 //# 新的每日签到
	SUB_MB_S_ACTIVITY_SIGN_EX                 = 37 //# 新的签到结果
	SUB_MB_C2S_ACTIVITY_FRESH_PACKAGE_EX      = 38 //# 新版本礼包
	SUB_MB_S2C_ACTIVITY_FRESH_PACKAGE_BACK_EX = 39 //# 新版本礼包答复
	SUB_MB_S2C_REFRESH_INTER_DAY              = 40 //# 跨天检测消息，客户端收到应该主动请求相关新数据
	SUB_MB_C2S_ACTIVITY_TOMORROW_PACKAGE      = 41 //# 领取明日礼包
	SUB_MB_S2C_ACTIVITY_TOMORROW_PACKAGE      = 42 //# 领取明日礼包答复
	SUB_MB_S_ARENA_ACTIVITY_CONFIG            = 43 //# 活动赛配置
	SUB_MB_C2S_ACTIVITY_PLAY_DIALMONEY        = 44 //# 轮盘金币奖品信息
	SUB_MB_S2C_ACTIVITY_PLAY_DIALMONEY_BACK   = 45 //# 轮盘金币奖品信息答复
	SUB_MB_C2S_ACTIVITY_PLAY_DIAL_MONEY       = 46 //# 轮盘金币抽奖
	SUB_MB_S2C_ACTIVITY_PLAY_DIAL_BACK_MONEY  = 47 //# 轮盘金币抽奖答复
	SUB_MB_S_ARENA_BIG_PRIZE_CONFIG           = 48 //# 大奖赛配置

	SUB_MB_C2G_PURCHASE_QUERY_UNDEALED_TRADE = 11
	SUB_MB_C2L_PRODUCT_INFO                  = 14
	SUB_MB_C2L_FIRST_PAY_INFO                = 15
)