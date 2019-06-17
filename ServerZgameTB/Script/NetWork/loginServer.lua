---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/12/5 14:05
---


----游客登录申请,获取玩家的数据， 判断是否已经登录，
function HandleLoginGSGuest(serverId, buf)
    local msg = CMD_GameServer_pb.CMD_GR_LogonUserID()
    msg:ParseFromString(buf)

    --print("gamekind id: ".. msg.kind_id)
    --print("user_id id: ".. msg.user_id)
    --print("machine_id : ".. msg.machine_id)


    if msg.machine_id == "" then
        print("请求登录 machine_id 不能为空")
        return
    end

    --local isNewPlayer = 0       -- 是否是新用户
    local player
    local MyUser
    local openId = msg.machine_id
    local UserId = RedisGetPlayerLogin(openId)      -- 通过openId 找 UserId ，如果找不到， 说明没有注册过
    if UserId == "" then
        --print("没有账号，创建一个， 并初始化")
        UserId = GetLastUserID()
        UserId = tonumber(UserId)       -- 这里需要转一下到数字
        MyUser = User:New(UserId,openId)
        MyUser.TimeCreateAccount = GetOsDateNow()       -- 记录玩家的创建账号时间

        RedisSavePlayerLogin(openId,UserId)     -- 保存openId 跟UserId的 匹配关系
        --isNewPlayer = 1      -- 是新用户

        player = Player:New(MyUser)
        SetAllPlayerList(player.User.UserId, player)  --创建好之后加入玩家总列表

        RedisSavePlayerAll(player.User)     -- 为了保险，保存一下玩家信息

        sqlSaveUserCreateLogTable(player.User.UserId)       -- 创建一个玩家的日志表
    else
        --print("有账号，那么取出账号的信息")
        UserId = tonumber(UserId)       -- 这里需要转一下到数字
        -- 如果玩家是断线重连的
        if GetPlayerByUID(UserId) ~= nil then      --找到之前有玩家在线
            player = GetPlayerByUID(UserId) -- 把之前的玩家数据取出来
            print("已经登录")
            if player.GameType ~= GameHall and player.NetWorkState == false then
                -- 在游戏中， 并且玩家状态是等待断线重连
                player.NetWorkState = true                      -- 网络恢复正常
                player.NetWorkCloseTimer = 0
                print("把断线重连的player返回去， 玩家本来就坐在这里，不用同步信息给其他玩家， 就是反应他傻了一会后继续游戏了")
                --return player
            else
                -- 玩家在大厅
                -- player会被替换掉，那么之前的连接也到t掉才可以
                print("重复登录，如何处理")
                -- 这里以后增加，t掉玩家的连接的功能
            end
        else
            -- 不是断线重连的就重新建一个玩家数据

            -- redis load
            MyUser = RedisGetUserData(UserId)
            --print("读取用户数据-----------")
            --print(MySerpent.block(MyUser))

            player = Player:New(MyUser)
            SetAllPlayerList(player.User.UserId, player)  --创建好之后加入玩家总列表
        end

    end


    -- 将玩家的uid跟my server进行关联 ，方便以后发送消息
    luaCallGoResisterUID(UserId,serverId)

    -- 发送登录成功
    local sendCmd = CMD_GameServer_pb.CMD_GR_LogonSuccess()

    sendCmd.user_right = UserId          -- 把生成的uid发送给客户端，让客户端以后用这个uid来登录
    sendCmd.server_id =  tonumber(string.sub(ServerIP_Port, string.find(ServerIP_Port,":%d*")+1 ))        -- 这里把服务器的端口号发过去， 作为服务器的id

    --    LuaNetWorkSend( MDM_GR_LOGON, SUB_GR_LOGON_SUCCESS, data, " 这是测试错误")
    LuaNetWorkSendToUser(UserId, MDM_GR_LOGON, SUB_GR_LOGON_SUCCESS, sendCmd, nil, nil)


    -- 发送登录完成， 返回用户的数据
    sendCmd = CMD_Game_pb.tagUserInfo()
    sendCmd.nick_name = player.User.NickName
    sendCmd.score = ScoreGet(player)      -- 推币的金币数量
    sendCmd.exp = player.User.Exp
    sendCmd.user_id = player.User.UserId

    LuaNetWorkSendToUser(UserId, MDM_GR_LOGON, SUB_GR_LOGON_FINISH, sendCmd, nil,nil)

    -- vip登录发放救济金
    VipGiveDole(player)

    -- 统计玩家登录，留存，新增等信息
    SqlSaveStatisticLogin(player.User )

    -- 保存玩家的一最后登录信息
    player.User.TimeLastLogin = GetOsDateNow()       -- 保存玩家最后一次登录时间
    RedisSavePlayerAll(player.User)           -- 保存玩家信息到 redis 数据库




end
