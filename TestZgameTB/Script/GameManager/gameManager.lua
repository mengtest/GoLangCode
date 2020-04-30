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
function GoCallLuaStartGamesServers(serverId)


    -- 开始连接服务器
    SendLoginGSGuest(serverId)


    --Logger("--------------StartGamesServers  End--------------------------")
end



-- 根据user uid 返回user的句柄
function GetPlayerByUID(uid)
    return AllPlayerList[tostring(uid)]     --- 这里一定要注意， goperlua在用数字作为key的时候会默认为数组，内存消耗惊人， 所以要用string
end
function SetAllPlayerList(userId,value)
    AllPlayerList[tostring(userId)] = value
end

-- go通知lua玩家掉线了
function GoCallLuaPlayerNetworkBroken(uid)
    --Logger("go 通知："..uid .. "  掉线了")
    local player = GetPlayerByUID(uid)

    print("玩家被t了"..player.User.UserId)

    SetAllPlayerList(player.User.UserId, nil)

    --if player ~= nil then
    --    local game = GetGameByID(player.GameType)
    --    --printTable(game)
    --    if game ~= nil then
    --        game:PlayerLogOutGame(player)
    --        --player.NetWorkState = false
    --        --player.NetWorkCloseTimer = GetOsTimeMillisecond()
    --
    --    end
    --end
end
