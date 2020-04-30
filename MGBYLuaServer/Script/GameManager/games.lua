---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/1 13:32
---
----------------------------------------------------------------
-----------------------------game管理桌子和玩家-----------------
----------------------------------------------------------------



Game = {}
function Game:New(name,gameTypeId, switch)
    c = {
        Name                = name,
        GameTypeID          = gameTypeId,
        Switch              = switch,               -- 游戏是否开启

        AllTableList        = {},                   -- 所有桌子列表       key tableUid  ,value table          --- 要注意， key 不能用数字，因为占用内存太大， goperlua的问题
        AllTableListNumber  = 0 ,                   -- 所有该游戏的桌子数量
        TableUUID           = 1 ,                   -- tableUid 从1开始

        --GoRunTableAllList = {},                   -- 桌子的run函数在里面                --- 要注意， key 不能用数字，因为占用内存太大， goperlua的问题
        GameScore           = 0 ,                   --  游戏倍率

        GameRoomInfo        = {},                   -- 游戏房间信息(GameRommInfo数据库表相关信息)
    }
    setmetatable(c,self)
    self.__index = self
    return c
end

function Game:Reload(c)
    setmetatable(c, self)
    self.__index = self
    -- 如果热更新有改动成员变量的定义的话， 下面需要进行成员变量的处理
    -- 比如 1 增加了字段， 那么你需要将老数据进行， 新字段的初始化
    -- 比如 2 删除了字段， 那么你需要将老数据进行， 老字段=nil
    -- 比如 3 修改了字段， 那么你需要将老数据进行， 老字段=nil， 新字段初始化或者进行赋值处理
end
----------------------------------------------------------------
-----------------------------管理桌子---------------------------
----------------------------------------------------------------

--- 创建桌子，并启动它， 参数带底分的， 不同底分的房间可以在一起管理，因为逻辑一样的，进入的时候判断一下，引导玩家进入不同底分的桌子
function Game:CreateTable(gameType,gameScore)
    local table_t
    if gameType == GameTypeBY or gameType == GameTypeBY30 then
        table_t =  ByTable:New(self.TableUUID, gameType)
        --printTable(table_t)
    elseif gameType == GameTypeBY2 then

    elseif gameType == GameTypeBY3 then

    elseif gameType == GameTypeXHS then
        table_t = XhsTable:New(self.TableUUID, gameType)
    elseif gameType == GameTypeChat then
        table_t = ChatTable:New(self.TableUUID, gameType)
    end
    if table_t == nil then
        Logger("CreateTable error , gameType"..gameType)
        return nil
    end
    table_t.RoomScore = gameScore
--    Logger("创建了一个新的桌子,type:"..gameType)

    --增加该桌子到总列表中
    self.AllTableList[tostring(self.TableUUID)] = table_t
    self.AllTableListNumber = self.AllTableListNumber + 1
    self.TableUUID = self.TableUUID + 1     -- table uuid 自增

    -- 桌子开始自行启动计算
    table_t:StartTable()

    return table_t

end

--- 根据桌子uid 返回桌子的句柄
function Game:GetTableByUID(tableId)
    return self.AllTableList[tostring(tableId)]
end

--- 桌子回收
function Game:ReleaseTableByUID(tableId)
    if tableId ~= 1 then
        self.AllTableList[tostring(tableId)] = nil
        self.AllTableListNumber = self.AllTableListNumber - 1
        --self.GoRunTableAllList[tostring(tableId)] = nil
        SqlDelGameState(self.GameTypeID, tableId)   -- 把记录桌子状态的redis删掉
        Logger("清理掉桌子"..tableId)
    else
        -- 第一个桌子是保留着的，只是清理一下
        local state ={}
        state["FishNum"] = 0
        state["BulletNum"] = 0
        state["SeatArray"] = 0
        SqlSaveGameState(self.GameTypeID, tableId, state)       -- mysql桌子状态修改一下
    end
    collectgarbage()        -- 强制gc
end


----- 然后注册TableRun
--function Game:FindGoRoutineAndRegisterTableRun(tableId,func)
--    self.GoRunTableAllList[tostring(tableId)] = func  --注册TableRun函数
--end


----------------------------------------------------------------
-----------------------------管理玩家---------------------------
----------------------------------------------------------------


--- 有玩家登陆游戏，想进入对应分数的房间
function Game:PlayerLoginGame(oldPlayer)
    local player
    -- 如果玩家是断线重连的
    if GetPlayerByUID(oldPlayer.User.UserID) ~= nil then      --找到之前有玩家在线
        player = GetPlayerByUID(oldPlayer.User.UserID) -- 把之前的玩家数据取出来
        if oldPlayer.GameType == player.GameType and oldPlayer.NetWorkState == false then
            -- 同一个游戏， 并且玩家状态是等待断线重连
            player.NetWorkState = true                      -- 网络恢复正常
            player.NetWorkCloseTimer = 0
            print("把断线重连的player返回去， 玩家本来就坐在这里，不用同步信息给其他玩家， 就是反应他傻了一会后继续游戏了")
            return player
        else
            -- 不是同一个游戏，或者有玩家在里面玩呢
            -- player会被替换掉，那么之前的连接也到t掉才可以

            -- 这里以后增加，t掉玩家的连接的功能
        end

    end

    -- 不是断线重连的就重新建一个玩家数据
    player = Player:New(oldPlayer.User)
    player.GameType = oldPlayer.GameType            -- 设定游戏类型
    SetAllPlayerList(oldPlayer.User.UserID, player)  --创建好之后加入玩家总列表



    --然后找一个有空位的桌子让玩家加入游戏
    for k, table in pairs(self.AllTableList) do
        if table.RoomScore == self.GameScore then    -- 进入底分一致的桌子
            local seatId = table:GetEmptySeatInTable()
            if seatId > 0 then
                --print("有空座位")
                table:InitTable()    -- 看看是不是空桌子，如果是，需要初始化
                table:PlayerSeat(seatId,player)
                player.TableID = table.TableID
                player.ChairID = seatId

                self:SendYouLoginToOthers(player,table)-- 发消息给同桌子的其他玩家，告诉他们你登录了
                return player
            end
        else
            Logger("有底分不一致的情况？"..k)
        end
    end

    --没有空座位的房间了，创建一个
--    print("没有空座位的房间了，创建一个吧,  score".. self.GameTypeID)
    local gameType = self.AllTableList["1"].GameID
    local table = self:CreateTable(gameType, self.GameScore)
    local seatId = table:GetEmptySeatInTable()  --获取空椅位
    table:InitTable()
    table:PlayerSeat(seatId,player)     --让玩家坐下.
    player.TableID = table.TableID
    player.ChairID = seatId
    self:SendYouLoginToOthers(player,table)-- 发消息给同桌子的其他玩家，告诉他们你登录了
    return player

end


--- 发消息给同桌子的其他玩家，告诉他们你登录了
function Game:SendYouLoginToOthers(player,table)
--    print("玩家",player.User.UserID, "桌子",table.TableID,"椅子",player.ChairID)

    --local CMD_Game_pb = require("CMD_Game_pb")
    local sendCmd = CMD_Game_pb.CMD_S_OTHER_ENTER_SCENE()
    sendCmd.user_info.user_id = player.User.UserID
    sendCmd.user_info.chair_id = player.ChairID
    sendCmd.user_info.table_id = player.TableID
    table:SendMsgToOtherUsers(player.User.UserID, sendCmd, MDM_GF_GAME, SUB_S_OTHER_ENTER_SCENE)
end



----玩家登出
function Game:PlayerLogOutGame(player)
    --Logger("玩家登出 "..player.User.UserID.. "    桌子 "..player.TableID)
    local table = self:GetTableByUID(player.TableID)
    if table ~= nil then
        table:PlayerStandUp(player.ChairID, player)        -- 玩家离开桌子
        --Logger("玩家"..player.User.UserID.."离开桌子 "..player.TableID.."椅子"..player.ChairID)
    end
end