---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/10/12 15:00
---

-------------------------------------热更新----------------------------------------
--- 热更新文件列表
--- 记住： module 和 全局的函数都是可以reload 的，类的写法不行，要注意
-----------------------------------------------------------------------------


function ReloadFile(module_name)
    package.loaded[module_name] = nil
    require(module_name)
end


-- 热更新全部的逻辑代码，需要自己控制， 切记玩家数据部分不要加进去，不然会重置玩家数据，如果你是保存型代码，容易导致玩家清档
function ReloadAll()

    Logger("------------------start reload all---------------------------")

     --HotReload
    ReloadFile("Script/HotReload/hotReload")

    -- CSV
    ReloadFile("Script/CSV/mgby_fish_sever")

    -- Protocol
    ReloadFile("Script/Protocol/build/CMD_Game_pb")
    ReloadFile("Script/Protocol/build/CMD_GameServer_pb")

    -- Const
    ReloadFile("Script/Const/Const")
    ReloadFile("Script/Const/Excel")
    ReloadFile("Script/Const/Proto")
    ReloadFile("Script/Const/protocol_cs")
    ReloadFile("Script/Const/protocol_gs")
    ReloadFile("Script/Const/protocol_ls")

    -- Utils
    ReloadFile("Script/Utils/Random")
    ReloadFile("Script/Utils/Time")
    ReloadFile("Script/Utils/zTable")
    ReloadFile("Script/Utils/zRedis")
    ReloadFile("Script/Utils/luaMySql")
    ReloadFile("Script/Utils/zMySql")


    -- DataBase
    ReloadFile("Script/DataBase/redisConst")
    ReloadFile("Script/DataBase/redisGame")
    ReloadFile("Script/DataBase/redisPlayer")
    ReloadFile("Script/DataBase/sqlStatistic")


    -- Logger
    ReloadFile("Script/Logger/logger")

    -- GameCommonLogic
    ReloadFile("Script/GameCommonLogic/commonLogic")


    -- Games
    ReloadFile("Script/Games/BY/byBullet")
    ReloadFile("Script/Games/BY/byFish")
    ReloadFile("Script/Games/BY/byFishDistribute")
    ReloadFile("Script/Games/BY/byTable")
    ReloadFile("Script/Games/BY/byTableFishFunc")


    -- GameManager
    ReloadFile("Script/GameManager/player")
    ReloadFile("Script/GameManager/user")
    ReloadFile("Script/GameManager/games")
    ReloadFile("Script/GameManager/gameManager")


    -- GlobalVar    -- 注意事项： 因为这里有游戏的全局变量，所以不能reload

    -- NetWork
    ReloadFile("Script/NetWork/LoginServer")
    ReloadFile("Script/NetWork/gameFire")
    ReloadFile("Script/NetWork/gameEnter")
    ReloadFile("Script/NetWork/Statistic")
    ReloadFile("Script/NetWork/network")


    --    -- 已经生成的对象需要刷新函数
    for _, game in pairs(AllGamesList) do
        Game:Reload(game)
        -- 捕鱼游戏
        if game.GameTypeID == GameTypeBY or game.GameTypeID == GameTypeBY30 then
            for _, table in pairs(game.AllTableList) do
                -- 遍历所有游戏，所有桌子， 所有鱼，所有子弹，所有生成鱼池， 因为这些都是类， 已经生成的对象需要刷新函数
                ByTable:Reload(table)
                for _, fish in pairs(table.FishArray) do
                    Fish:Reload(fish)
                end
                for _, bullet in pairs(table.BulletArray) do
                    Bullet:Reload(bullet)
                end
                for _, distribute in pairs(table.DistributeArray) do
                    FishDistribute:Reload(distribute)
                end
                for _, bossDistribute in pairs(table.BossDistributeArray) do
                    FishDistribute:Reload(bossDistribute)
                end
            end
        end
        -- 其他游戏
    end

    -- 所有玩家的数据刷新（如果结构定义有修改的话）
    for _,player in pairs(AllPlayerList) do
        User:Reload(player.User)
        Player:Reload(player)
    end

    -- main
    --reloadFile("Script/server")

    --collectgarbage()
end


