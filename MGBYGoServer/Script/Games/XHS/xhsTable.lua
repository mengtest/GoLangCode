---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.zhengxh
--- DateTime: 2019/10/22 16:04
---

--- 桌子对象
XhsTable = BaseTable:New()
--- 创建桌子对象
--- @param tableId      桌子ID
--- @param gameTypeId   游戏类型ID
--- @return o           桌子对象
function XhsTable:New(tableId, gameTypeId)
    -- 重新赋值某些属性值
    o = BaseTable:New()
    o.GameID              = gameTypeId
    o.TableID             = tableId
    o.TableMax            = XHS_TABLE_MAX_PLAYER
    local father = getmetatable(o)
    setmetatable(self, father)

    -- 自己本身成员变量
    o.super = setmetatable({},father)

    setmetatable(o, self)
    self.__index = self
    return o
end

--- 重载桌子
--- @param o 桌子对象
function XhsTable:Reload(o)
    -- 父类重载
    o.super.Reload(self)
    -- 设置元表(这样才可以调用新增的函数)
    setmetatable(o, self)
    self.__index = self
    -- 如果热更新有改动成员变量的定义的话， 下面需要进行成员变量的处理
    -- 比如 1 增加了字段， 那么你需要将老数据进行， 新字段的初始化
    -- 比如 2 删除了字段， 那么你需要将老数据进行， 老字段=nil
    -- 比如 3 修改了字段， 那么你需要将老数据进行， 老字段=nil， 新字段初始化或者进行赋值处理
end

--- 启动桌子
function XhsTable:StartTable()
    -- 初始化桌子
    self:InitTable()
end

--- 初始化桌子
function XhsTable:InitTable()
    return
end

--- 桌子的主循环
function XhsTable:RunTable()
    -- print("小海兽桌子主循环")
    -- 每1秒循环一次
    local tCurTime = os.time()
    if self.LastRunTime == 0 then
        self.LastRunTime = tCurTime
    end
    if self.LastRunTime + 1 > tCurTime then
        return
    end

    -- 循环桌子
    if self:CheckTableEmpty() == false then
        -- 循环玩家
        local sendBuff
        local sendMonster
        for i, player in pairs(self.UserSeatArray) do
            if player ~= nil and player.NetWorkState == true then
                -- 跨天了
                local user = player.User
                if GetTwoTimesDays(self.LastRunTime, tCurTime) > 0 then
                    user.MonsterID           = 0
                    user.MonsterHP           = 0
                    user.MonsterBulletNum    = 0
                    user.TotalCritNum        = 0
                    user.SummonTimes         = 0
                    player.XhsLastSaveGameInfoTime  = 0
                    -- 保存游戏进度

                    -- 同步玩家小海兽信息
                    sendMonster = CMD_XHS_Game_pb.tagSeaMonster()
                    sendMonster.monster_id     = 0
                    sendMonster.monster_hp     = 0
                    sendMonster.bullet_num     = 0
                    sendMonster.summon_times   = 0
                    sendMonster.monster_max_hp = 0
                    sendMonster.left_times     = 0
                    LuaNetWorkSendToUser(player.User.UserID, MDM_GF_GAME, SUB_S_USER_DHS_INFO, sendMonster, nil, nil)
                end

                -- 暴击Buffer修正
                if player.XhsStartBuffTimes > 0 and player.XhsIntervalBuffTimes > 0 and tCurTime > (player.XhsStartBuffTimes + player.XhsIntervalBuffTimes) then
                    player.XhsStartBuffTimes    = 0
                    player.XhsIntervalBuffTimes = 0
                    user.TotalCritNum           = 0

                    -- 发送暴击Buffer结束信息
                    sendBuff = CMD_XHS_Game_pb.CMD_S_TRRIGETER_BUFF()
                    sendBuff.time = 0
                    LuaNetWorkSendToUser(player.User.UserID, MDM_GF_GAME, SUB_S_BUFF_STATE_INFO, sendBuff, nil, nil)
                end
            end
        end
    end
    self.LastRunTime = tCurTime
    return
end

----玩家登陆的时候,发送场景其他消息
--- @param player 玩家对象
function XhsTable:SendTableSceneInfo(player)
    if player == nil then
        Logger("XhsTable:SendTableSceneInfo player 对象nil")
        return
    end
    -- 1.发送玩家进入场景信息
    self:SendUserGameInfo(player)
    return
end

----玩家离开椅子
function XhsTable:PlayerStandUp(seatID,player)
    self.super.PlayerStandUp(self, seatID, player)
end