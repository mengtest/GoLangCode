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



--local CMD_GameServer_pb = require("CMD_GameServer_pb")
--local CMD_Game_pb = require("CMD_Game_pb")

--MyPlayer = nil -- 这是全局的玩家句柄，因为每一个LState是一个单独的lua空间，所以每个玩家都拥有自己单独的MyPlayer句柄


----客户端申请进入大厅 , 玩家申请登录游戏房间， 分配桌子，坐下
function SevEnterScene(userId, buf)
--    print("------------客户端申请进入大厅-------------")
    local msg = CMD_GameServer_pb.CMD_GF_GameOption()
    msg:ParseFromString(buf)

--    print("客户端申请进入大厅, GetClientVersion:"..msg.client_version)
    --玩家登陆游戏，分配桌子
    local gameType = GameTypeBY     -- 申请登录的游戏类型

    local MyUser = User:New()
    ---- 以后增加判断，先读数据库，如果没有，创建新的玩家，如果有，读数据库

    MyUser.FaceId = 0
    MyUser.Gender = 0
    MyUser.UserId = userId
    MyUser.GameId = 320395999
    MyUser.Exp = 254
    MyUser.Loveliness = 0
    MyUser.Score = 100000009
    MyUser.NickName = "玩家"..MyUser.UserId
    MyUser.Level = 1
    MyUser.VipLevel = 0
    MyUser.AccountLevel = 3
    MyUser.SiteLevel = 0
    MyUser.CurLevelExp = 0
    MyUser.NextLevelExp = 457
    MyUser.PayTotal = 0
    MyUser.Diamond = 29

    local oldPlayer = Player:New(MyUser)
    oldPlayer.GameType = gameType


    --local data = {}
    --data.Player = MyPlayer
    --MyPlayer.GameType = gameType
    --local result = MultiThreadChannelGameManagerToPlayer("PlayerLoginGame",data)    -- 申请分配一个桌子， 返回的数据中带有桌子和椅子的id了

    local game = GetGameByID(gameType)
    if game == nil then
        LuaNetWorkSendToUser(userId,MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "请求登录游戏类型不正确", nil)
        return
    end

    local player = game:PlayerLoginGame(oldPlayer)
    --result.TableID = player.TableID
    --result.ChairID = player.ChairID                 -- 把player桌子id，椅子id的数据 返回去
    local table = game:GetTableByUID(player.TableID)
    if table == nil then
        LuaNetWorkSendToUser(userId, MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "没找到正确的桌子", nil)
        return
    end
    --local playerList = table:GetUsersSeatInTable()
    --result.users = {}
    --for k,v in pairs(table.UserSeatArray)do      -- 把桌子的其他玩家数据也发回去
    --    result.users[k] = {}
    --    result.users[k].UserId =  v.User.UserId
    --    result.users[k].ChairID =  k
    --end




    --
    --if result.error ~= nil then
    --    LuaNetWorkSend(connId,MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "请求登录游戏类型不正确")
    --    return
    --end


    --MyPlayer.TableID = result.TableID       -- 桌子传递回来的桌子椅子id
    --MyPlayer.ChairID = result.ChairID
    --printTable(result)
    --print("-----------------------------------------------------")

    --local table = MyGame:PlayerLoginGame(MyUser)
    local sendCmd = CMD_Game_pb.CMD_S_ENTER_SCENE()
    sendCmd.scene_id = player.GameType
    sendCmd.table_id = player.TableID
    for index, player in pairs(table.UserSeatArray) do       -- 从桌子传递过来的其他玩家信息，原来坐着的玩家信息
        if player ~= nil then
            local uu = sendCmd.table_users:add()
            uu.user_id = player.User.UserId
            uu.chair_id = index
        end
    end

    LuaNetWorkSendToUser(userId,MDM_GF_GAME, SUB_S_ENTER_SCENE, sendCmd, nil, nil) --进入房间
    --
    ----LuaNetWorkSend( MDM_GF_FRAME, SUB_GF_GAME_STATUS , nil, nil)--更新游戏状态
    ----LuaNetWorkSend( MDM_GF_FRAME, SUB_GF_SYSTEM_MESSAGE , nil, nil)--系统消息
    ----LuaNetWorkSend( MDM_GF_FRAME, SUB_GF_USER_SKILL , nil, nil)--玩家技能
    --
    --table:SendSceneFishes()


    table:SendSceneFishes(player.User.UserId)

    --result = MultiThreadChannelGameManagerToPlayer("SendSceneFishes",data)      -- 同步一下渔场的所有鱼
    --if result.error ~= nil then
    --    LuaNetWorkSend(connId, MDM_GR_LOGON, SUB_GR_LOGON_FAILURE, nil, "没找到正确的桌子")
    --    return
    --end
--    print("同步一下渔场的所有鱼")
end



