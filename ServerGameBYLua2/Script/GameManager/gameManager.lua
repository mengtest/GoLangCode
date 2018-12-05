---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/1 10:54
---

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--- go 来创建和调用的游戏管理器， 管理器管理很多游戏， 每个游戏管理桌子和玩家
--- 新添加游戏步骤：1, 定义类型 2 AddGame  3 在games.lua里面定义根据不同的游戏定义不同的桌子 4 创建一个新游戏的桌子.lua文件
---
--- 注意：
--- 这里是主逻辑线程才能访问的地方，  普通玩家的线程是访问不到的， 玩家要通过channel去通知主线程要做什么事情，主线程会处理所有玩家的申请
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------


require("games")


-----------------------------------服务器启动-------------------------------------
-- 服务器开始创建各个游戏，这里的游戏都是多人的游戏， 如果是单人游戏，玩家自己创建即可
function GoCallLuaStartGamesServers()
    --CreateAllGoRoutineGameTable()   --创建桌子使用的goroutine函数列表
    GetALLUserUUID()

    AddGame("满贯捕鱼", GameTypeBY , 1)     -- 普通房间
    --AddGame("满贯捕鱼30倍", GameTypeBY30 , 30)    -- 30倍房间
    --AddGame("满贯捕鱼2", GameTypeBY2)
    --AddGame("满贯捕鱼3", GameTypeBY3)

    SetNewTimer("NewTimerBy2Second",2)      -- lua 自己设定计时器
    SetNewClockTimer("NewTimerByAfternoon4", 16)    -- lua 自己设定的固定时间定时器，  16:00
    Logger("--------------StartGamesServers  End--------------------------")
end

-----------------------------------玩家注册，玩家掉线-------------------------------------
-- 服务器启动的时候， 从数据库中读取玩家最后的uid
function GetALLUserUUID()
    --这个要从数据库读取

    --如果读取数据是0，那么就重置
    if ALLUserUUID == 0 then
        ALLUserUUID = 1000000000
    end

end
--有一个新的玩家注册了，那么给他分配一个UID
function GetLastUserID()
    local r = 1     -- math.random(1, 4)        --返回[1,4]的随机整数
    ALLUserUUID = ALLUserUUID + r            -- 玩家的UID 中间会隔一些数字， 防止玩家挨个去猜UID
    return ALLUserUUID
end


-- 根据user uid 返回user的句柄
function GetPlayerByUID(uid)
    return AllPlayerList[uid]
end

-- go通知lua玩家掉线了
function GoCallLuaPlayerNetworkBroken(uid)
    --print(uid .. "  掉线了")
    local player = GetPlayerByUID(uid)
    if player ~= nil then
        player.NetWorkState = false
        player.NetWorkCloseTimer = GetOsTimeMillisecond()
    end
end


-----------------------------------游戏-------------------------------------
--增加一个游戏， 指定这个游戏的类型， 并且创建一个桌子，并启动桌子逻辑
function AddGame(name, gameType, gameScore)
    if AllGamesList.gameType ~= nil then
        Logger("游戏类型["..gameType.."已经添加过了，不用重复添加")
        return
    end

    local game = Game:New(name, gameType,true)
    AllGamesList[gameType] = game

    --Logger("--------------AddGame--------------------------")
    game:CreateTable(gameType,gameScore)
    game.GameScore = gameScore
end

--通过gameID获取是哪个游戏
function GetGameByID(gameTypeID)
    return AllGamesList[gameTypeID]
end


-----------------------------------桌子-------------------------------------
-- 显示当前的状态
function ShowAllGameStates()
    for k, v in pairs(AllGamesList) do
        local game = GetGameByID(k)
        print("游戏"..k.."有桌子数量"..GetTableLen(game.AllTableList)..",有玩家数量"..GetTableLen(AllPlayerList))
    end
end



-- 遍历所有的列表，然后依次run
function GoCallLuaGoRoutineForLuaGameTable()
    --print("----------------当前有"..#GoRoutineAllList.."个桌子")
    for k, game in pairs(AllGamesList) do
        for _, run in pairs(game.GoRunTableAllList) do
            run() -- 执行注册的函数，table run
        end
    end


end
