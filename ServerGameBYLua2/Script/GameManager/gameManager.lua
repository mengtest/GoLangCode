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





-----------------------------------服务器启动-------------------------------------
-- 服务器开始创建各个游戏，这里的游戏都是多人的游戏， 如果是单人游戏，玩家自己创建即可
function GoCallLuaStartGamesServers()
    --CreateAllGoRoutineGameTable()   --创建桌子使用的goroutine函数列表
    --GetALLUserUUID()        -- 是一个UUID是不是需要初始化的判断

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
--function GetALLUserUUID()
--    --这个要从数据库读取
--    local uuid = RedisGetAllPlayersUUID()
--    --print("ALLUserUUID",ALLUserUUID)
--    --如果读取数据是空，那么就重置
--    if uuid == "" then
--        uuid = 1000000000
--        RedisSaveAllPlayersUUID(uuid)
--        print("初始化一下 ALLUserUUID",uuid)
--    end
--    --print("ALLUserUUID",ALLUserUUID)
--end

--有一个新的玩家注册了，那么给他分配一个UID
function GetLastUserID()
    local r = 1     -- math.random(1, 4)        --返回[1,4]的随机整数

    local uuid = RedisMultiProcessGetAllPlayersUUID(r)     -- 分布式申请UUID
    --Logger("给玩家分配新uid  ALLUserUUID "..uuid)
    return uuid
end


-- 根据user uid 返回user的句柄
function GetPlayerByUID(uid)
    return AllPlayerList[tostring(uid)]
end
function SetAllPlayerList(userId,value)
    AllPlayerList[tostring(userId)] = value
end

-- go通知lua玩家掉线了
function GoCallLuaPlayerNetworkBroken(uid)
    --Logger("go 通知："..uid .. "  掉线了")
    local player = GetPlayerByUID(uid)

    if player ~= nil then
        local game = GetGameByID(player.GameType)
        --printTable(game)
        if game ~= nil then
            game:PlayerLogOutGame(player)
            --player.NetWorkState = false
            --player.NetWorkCloseTimer = GetOsTimeMillisecond()

        end
    end
end


-----------------------------------游戏-------------------------------------
--增加一个游戏， 指定这个游戏的类型， 并且创建一个桌子，并启动桌子逻辑
function AddGame(name, gameType, gameScore)
    if GetGameByID(gameType) ~= nil then
        Logger("游戏类型["..gameType.."已经添加过了，不用重复添加")
        return
    end

    local game = Game:New(name, gameType,true)
    SetAllGamesList(gameType, game)         -- 加入到游戏总列表中

    --Logger("--------------AddGame--------------------------")
    game:CreateTable(gameType,gameScore)
    game.GameScore = gameScore
end

--通过gameID获取是哪个游戏
function GetGameByID(gameType)
    return AllGamesList[tostring(gameType)]
end

function SetAllGamesList(gameType,value)
    AllGamesList[tostring(gameType)] = value
end

-----------------------------------桌子-------------------------------------
-- 显示当前的状态
function ShowAllGameStates()
    for k, v in pairs(AllGamesList) do
        local game = GetGameByID(k)
        print("游戏"..k.."有桌子数量"..GetTableLen(game.AllTableList)..",有玩家数量"..GetTableLen(AllPlayerList))
    end

    --print("用来看reload的excel是否生效：",FishServerExcel["101"].type)

end



-- 遍历所有的列表，然后依次run
function GoCallLuaGoRoutineForLuaGameTable()
    --print("----------------当前有"..#GoRoutineAllList.."个桌子")
    for gameType, game in pairs(AllGamesList) do
        for tableId, run in pairs(game.GoRunTableAllList) do
            --local key = gameType .. "_".. tableId
            --if AllGamesListRunCurrentTableIndex[key] == nil then
                -- 没有run过
                run() -- 执行注册的函数，table run
                --AllGamesListRunCurrentTableIndex[key] = true   -- 记录一下已经run过了
                --return          -- run一次就退出
            --end
        end
    end

    -- 全部都run过了，重置一下
    AllGamesListRunCurrentTableIndex = {}
    --print("全部都run过了，重置一下")
end
