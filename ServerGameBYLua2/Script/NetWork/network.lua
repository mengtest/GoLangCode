---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/10/12 14:56
---





----------------------------------------------------------------------
---发送消息
----------------------------------------------------------------------
---- 玩家自己的网络发送函数
--function LuaNetWorkSend(myServerId, msgId, subMsgId, sendCmd, err)
--    --return LuaNetWorkSendToUser(0,serverId,msgId,subMsgId,sendCmd,err)      -- userId 如果是0的话， 就是给玩家自己回消息 ，这是在go那边定义的
--    local buffer = ""
--    if sendCmd ~= nil then
--        buffer = sendCmd:SerializeToString()
--    end
--
--    if err == nil then
--        err = ""
--    end
--    return luaCallGoNetWorkSend(0, myServerId,msgId,subMsgId,buffer,err)       -- 返回结果 true 发送成功  false 发送失败
--end




-- 发送消息给其他玩家
function LuaNetWorkSendToUser(userId,msgId,subMsgId,sendCmd,err)
    local buffer = ""
    if sendCmd ~= nil then
        buffer = sendCmd:SerializeToString()
    end

    if err == nil then
        err = ""
    end
    --print("发消息给",userId,msgId,subMsgId)

    local now = GetOsTimeMillisecond()
    if now - ZswLogShowSendMsgLastTime > 1000 then
        ZswLogShowSendMsgLastTime = now
        print("1秒发送消息数量", ZswLogShowSendMsgNum)
        -- 给服务器一分钟统计提供数据
        if ServerStateSendNum == 0 then
            ServerStateSendNum = ZswLogShowSendMsgNum   -- 赋值即可
        else
            ServerStateSendNum =  math.ceil( (ServerStateSendNum+ZswLogShowSendMsgNum)/2 )  -- 求一下平均值
        end

        ZswLogShowSendMsgNum = 0
    else
        ZswLogShowSendMsgNum = ZswLogShowSendMsgNum + 1       -- 没到一秒就加数量
    end

    return luaCallGoNetWorkSend(userId,0,msgId,subMsgId,buffer,err)       -- 返回结果 true 发送成功  false 发送失败
end


----------------------------------------------------------------------
---接收消息
----------------------------------------------------------------------
-- 网络接收函数
function GoCallLuaNetWorkReceive(serverId,userId, msgId, subMsgId, data)
    --Logger("lua收到了消息："..msgId)
    --Logger("lua收到了消息："..subMsgId)
    --Logger("lua收到了消息："..data)
    ReceiveMsg(serverId,userId,msgId,subMsgId,data)

    local now = GetOsTimeMillisecond()
    if now - ZswLogShowReceiveLastTime > 1000 then
        ZswLogShowReceiveLastTime = now
        print("1秒接收消息数量", ZswLogShowReceiveMsgNum)
        -- 给服务器一分钟统计提供数据
        if ServerStateReceiveNum == 0 then
            ServerStateReceiveNum = ZswLogShowReceiveMsgNum   -- 赋值即可
        else
            ServerStateReceiveNum =  math.ceil(  (ServerStateReceiveNum+ZswLogShowReceiveMsgNum)/2)   -- 求一下平均值
        end
        ZswLogShowReceiveMsgNum = 0
    else
        ZswLogShowReceiveMsgNum = ZswLogShowReceiveMsgNum + 1       -- 没到一秒就加数量
    end
--    LuaNetWorkSend(msgId,subMsgId,"lua想发送消息", "")
end


-- 根据命令进行分支处理
function ReceiveMsg(serverId,userId, msgId, subMsgId, data)
    --print("msgId",msgId, "subMsgId",subMsgId)

    if msgId == MDM_MB_LOGON  then
        if subMsgId == SUB_MB_GUESTLOGIN  then
            print("**************游客登录服申请******************* ")
        end
    elseif msgId == MDM_GR_LOGON  then
        if subMsgId == SUB_GR_LOGON_USERID  then
--            print("**************游客登录游戏服申请******************* ")     ----这里是原来的登录， 主要是返回客户端玩家的一些数据
            SevLoginGSGuest(serverId,data)      -- 返回给客户端，玩家的数据，用来显示的

        end
    elseif msgId == MDM_GF_FRAME  then
        if subMsgId == SUB_GF_GAME_OPTION  then
            --print("**************游游客进入游戏房间申请***************** ",userId)      ---- 这里是玩家申请登录游戏的类型，进入游戏房间， 分配桌子坐下开始玩 , 客户端需要申请房间的类型
            SevEnterScene(userId,data)
        end
    elseif msgId == MDM_GF_GAME  then
        if subMsgId == SUB_C_USER_FIRE  then
            --print("**************客户端开火***************** ",userId)
            HandleUserFire(userId,data)
        elseif subMsgId == SUB_C_CATCH_FISH  then
            --print("*************客户端抓鱼***************** ",userId)
            HandleCatchFish(userId,data)

        elseif subMsgId == SUB_S_BOSS_COME  then
            --print("*************暂时用来统计消息的返回时间***************** ",userId)
            HandleStaticsNetWorkTime(userId)
        end
    end
end