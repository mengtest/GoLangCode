---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/6 16:54
---

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--- 这是每个玩家的连接接收到网络消息之后的处理， 当涉及到多人游戏的时候， 需要通过MultiThreadChannelGameManagerToPlayer 来和游戏桌子逻辑进行数据交互，因为多线程需要保证线程安全
---
--- 如果自己单人游戏就不用了， 直接把处理游戏的逻辑写在这里就好了。
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------



--local CMD_Game_pb = require("CMD_Game_pb")


----客户端开火
function HandleUserFire(userId, buf)
    local msg = CMD_Game_pb.CMD_C_USER_FIRE()
    msg:ParseFromString(buf)


    local player,game,table = GetPlayer_Game_Table(userId)
    if player ==nil or game ==nil or table ==nil then
        --Logger("玩家数据："..player.."game:"..game.."table:"..table)
        return
    end
    table:HandleUserFire(player , msg.lock_fish_id )       -- 桌子会发送消息给玩家



    --local data = {}
    --data.Player = MyPlayer
    --data.LockFishId =  msg.lock_fish_id     -- 要打击的鱼id
    --local result = MultiThreadChannelGameManagerToPlayer("HandleUserFire",data)
    --if result.error ~= nil then
    --    LuaNetWorkSendToUser(userId, MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "没找到正确的桌子")
    --    return
    --end

    --print("开火完成")

end

--- 客户端抓鱼
function HandleCatchFish(userId, buf)
    local msg = CMD_Game_pb.CMD_C_CATCH_FISH()
    msg:ParseFromString(buf)

    if msg.fish_uid == 0 then
        return   -- 鱼的uid不为0
    end


    local player,game,table = GetPlayer_Game_Table(userId)
    if player ==nil or game ==nil or table ==nil then
        --Logger("玩家数据："..player.."game:"..game.."table:"..table)
        return
    end

    local LockFishIdList = {}      -- 要打击的鱼id
    LockFishIdList[1] =  msg.fish_uid     -- 要打击的鱼id
    table:LogicCatchFish(player,LockFishIdList, msg.bullet_id)


    --local data = {}
    --data.Player = MyPlayer
    --data.LockFishIdList = {}      -- 要打击的鱼id
    --data.LockFishIdList[1] =  msg.fish_uid     -- 要打击的鱼id
    --data.BulletId =  msg.bullet_id
    --local result = MultiThreadChannelGameManagerToPlayer("HandleCatchFish",data)
    --if result.error ~= nil then
    --    LuaNetWorkSendToUser(userId,MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "没找到正确的桌子")
    --    return
    --end
--    print("抓鱼完成")
end


--- 通用函数，获取玩家的数据
function GetPlayer_Game_Table(userId)
    local player = GetPlayerByUID(userId)
    if player == nil then
        LuaNetWorkSendToUser(userId,MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "玩家没有正常登录")
        return nil,nil,nil
    end

    local game = GetGameByID(player.GameType)
    if game == nil then
        LuaNetWorkSendToUser(userId,MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "请求登录游戏类型不正确")
        return nil,nil,nil
    end

    --local player = game:PlayerLoginGame(oldPlayer)
    --result.TableID = player.TableID
    --result.ChairID = player.ChairID                 -- 把player桌子id，椅子id的数据 返回去
    local table = game:GetTableByUID(player.TableID)
    if table == nil then
        LuaNetWorkSendToUser(userId, MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "没找到正确的桌子")
        return nil,nil,nil
    end

    return player,game, table
end

--------------------------------------------客户端----------------------------------------
--- 服务器下发新生成鱼
function handleNewFish(userId, buf)
    local msg = CMD_Game_pb.CMD_S_DISTRIBUTE_FISH()
    msg:ParseFromString(buf)

    local fishs = msg.fishs
    local fish_num = 0
    for k, v in ipairs(fishs) do
        --print("新生成鱼",v.uid)
        fish_num = fish_num + 1
        doFire(userId, v.uid)       -- 这里测试的时候，下发鱼就开枪
    end
    --print("玩家:",userId , "收到鱼数量:", fish_num )
end


--- 申请开火
function doFire(userId,fish_id)
    local sendCmd = CMD_Game_pb.CMD_C_USER_FIRE()
    sendCmd.lock_fish_id = fish_id

    LuaNetWorkSendToUser(userId,MDM_GF_GAME, SUB_C_USER_FIRE, sendCmd, nil) --进入房间
end



--- 服务器返回开火成功
function handleUserFireSuccess(userId, buf)

    local msg = CMD_Game_pb.CMD_S_USER_FIRE()
    msg:ParseFromString(buf)


    local player = GetPlayerByUID(userId)
    local chair_id = player.ChairID
    if chair_id == msg.chair_id then

        ---申请抓鱼
        local sendCmd = CMD_Game_pb.CMD_C_CATCH_FISH()
        sendCmd.fish_uid = msg.lock_fish_id
        sendCmd.bullet_id = msg.bullet_id
        sendCmd.chair_id = chair_id

        LuaNetWorkSendToUser(userId,MDM_GF_GAME, SUB_C_CATCH_FISH, sendCmd, nil)
    end

end


--- 服务器返回抓鱼成功
function handleCatchFishSuccess(userId, buf)

    local msg = CMD_Game_pb.CMD_S_CATCH_FISH()
    msg:ParseFromString(buf)

    local num = 0
    local score = 0

    for k,v in ipairs(msg.catch_fishs) do
        --v.fish_uid
        num = num +1
        print(" 捕鱼",v.fish_uid)
        --score = score + v.fish_score
    end

    local player = GetPlayerByUID(userId)
    local chair_id = player.ChairID
    if msg.chair_id == chair_id then
        print("捕鱼成功",num, "得分",score)
    end



end

