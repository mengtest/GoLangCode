---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/9 14:04
---

-- GameManagerReceiveCh
-- GameManagerSendCh

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--- 这是玩家和游戏桌子之间的通信
--- 因为玩家都是单独的处理线程，  桌子也是单独的处理线程， 所以为了线程安全，需要通过channel来进行通信
--- 如果是玩家自身的一些单机的，就不用通信了，自己玩吧
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------



-- 游戏管理根据玩家请求，处理消息
local function _dealData(ok,v)
    if ok then
--        printTable(v)
        local result = {}
        local name = v.name -- 名字
        local data = v.data -- 数据
        local player = data.Player
        local game = GetGameByID(player.gameType)
        if game == nil then
            result.error = 1
            GameManagerSendCh:send(result)      -- 找不到游戏类型
            return
        end

        local table = game:GetTableByUID(player.TableID)
        if name ~= "PlayerLoginGame" and table == nil then
            result.error = 1
            GameManagerSendCh:send(result)      -- 找不到桌子
            return
        end
        --Logger("玩家申请游戏管理器消息"..name)

        ---- 玩家申请分配一个桌子----------------
        if name == "PlayerLoginGame" then
            player = game:PlayerLoginGame(player.User)
            result.TableID = player.TableID
            result.ChairID = player.ChairID                 -- 把player桌子id，椅子id的数据 返回去
            table = game:GetTableByUID(player.TableID)
            local playerList = table:GetUsersSeatInTable()
            result.users = {}
            for k,v in pairs(playerList)do
                result.users[k] = {}
                result.users[k].UserId =  v.User.UserId
                result.users[k].ChairID =  k
            end
            GameManagerSendCh:send(result)

        ---- 玩家申请下发场景鱼群----------------
        elseif name == "SendSceneFishes" then

            table:SendSceneFishes(player.User.UserId)       -- 桌子会发送消息给玩家

        ----  玩家申请开火  ----------------
        elseif name == "HandleUserFire" then

            table:FireBullet(player , data.LockFishId )       -- 桌子会发送消息给玩家

        ----  玩家申请抓到鱼  ----------------
        elseif name == "HandleCatchFish" then

            table:LogicCatchFish(player,data.LockFishId,data.BulletId)  -- 桌子会发送消息给玩家
        else

        end



    end
end



-- 游戏管理器监听玩家发送的消息， 如果有消息来，那么分别处理， 处理之后再回给玩家
function MultiThreadChannelPlayerToGameManager()
    channel.select(
            {"|<-", GameManagerReceiveCh, _dealData},
            {"default"}
    )
end


-- 玩家发完消息，就等着游戏管理器给反馈了
function MultiThreadChannelGameManagerToPlayer(name,data)
    local myData = {}
    myData.name = name
    myData.data = data
    GameManagerReceiveCh:send(myData)       -- 玩家给游戏管理器发线程通信
    local ok, v = GameManagerSendCh:receive()            -- 监听游戏管理给的反馈
    return v
end

