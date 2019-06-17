---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/10/12 15:00
---

-------------------------------------热更新----------------------------------------
--- 热更新文件列表
--- 记住： module 和 全局的函数都是可以reload 的，类的写法不行，要注意
-----------------------------------------------------------------------------



--------------------------------文件列表-- 为了方便加载和热更的文件名字统一， 那么建立一个表，统一使用这个表里面的文件列表----------------------------------------------

--数据库
RequireAndReloadDataBaseFiles = {}
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/redisConst")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/redisGame")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/redisPlayer")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/redisSystem")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/sqlStatisticAll")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/sqlStatisticDaily")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/sqlStatisticLogin")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/sqlStatisticUser")
table.insert(RequireAndReloadDataBaseFiles, "Script/DataBase/sqlStatisticSystemAction")

-- CSV
RequireAndReloadCSVFiles = {}
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Blood")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Card")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Get_Gold_By_Time")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Lottery")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Lottery_Person_Pool")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Lucky_Wheel")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Point")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Room")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Score_All_Pool")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Score_Person_Pool")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Sign_In_Reward")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Tiger")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/VIP")
table.insert(RequireAndReloadCSVFiles, "Script/CSV/Wheel")


-- Protocol
RequireAndReloadProtocolFiles = {}
table.insert(RequireAndReloadProtocolFiles, "Script/Protocol/build/CMD_Game_pb")
table.insert(RequireAndReloadProtocolFiles, "Script/Protocol/build/CMD_GameServer_pb")
table.insert(RequireAndReloadProtocolFiles, "Script/Protocol/build/CMD_Game_TB_pb")


-- Const
RequireAndReloadConstFiles = {}
table.insert(RequireAndReloadConstFiles, "Script/Const/const")
table.insert(RequireAndReloadConstFiles, "Script/Const/excel")
table.insert(RequireAndReloadConstFiles, "Script/Const/proto")
table.insert(RequireAndReloadConstFiles, "Script/Const/protocol_cs")
table.insert(RequireAndReloadConstFiles, "Script/Const/protocol_gs")
table.insert(RequireAndReloadConstFiles, "Script/Const/protocol_ls")
table.insert(RequireAndReloadConstFiles, "Script/Const/protocol_tb")


-- Utils
RequireAndReloadUtilsFiles = {}
table.insert(RequireAndReloadUtilsFiles, "Script/Utils/luaMySql")
table.insert(RequireAndReloadUtilsFiles, "Script/Utils/zMySql")
table.insert(RequireAndReloadUtilsFiles, "Script/Utils/zRandom")
table.insert(RequireAndReloadUtilsFiles, "Script/Utils/zRedis")
table.insert(RequireAndReloadUtilsFiles, "Script/Utils/zTable")
table.insert(RequireAndReloadUtilsFiles, "Script/Utils/zTime")

-- gameManager
RequireAndReloadManagerFiles = {}
table.insert(RequireAndReloadManagerFiles, "Script/GameCommonLogic/commonLogic")
table.insert(RequireAndReloadManagerFiles, "Script/GameManager/player")
table.insert(RequireAndReloadManagerFiles, "Script/GameManager/user")
table.insert(RequireAndReloadManagerFiles, "Script/GameManager/games")
table.insert(RequireAndReloadManagerFiles, "Script/GameManager/gameManager")


-- game
RequireAndReloadGamesFiles = {}
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/bigCoin")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/blood")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/card")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/cardType")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/coin")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/gameSetting")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/jackpot")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/lottery")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/luckyWheel")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/points")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/pool")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/score")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/statistic")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/tax")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/tbTable")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/tiger")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/tigerDouble")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TB/wheel")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TBSystem/mail")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TBSystem/tip")
table.insert(RequireAndReloadGamesFiles, "Script/Games/TBSystem/vip")



-- network
RequireAndReloadNetWorkFiles = {}
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/network")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/loginServer")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameEnter")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameTBBlood")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameTBCard")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameTBCoin")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameTBTiger")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameTBWheel")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameSystem")
table.insert(RequireAndReloadNetWorkFiles, "Script/NetWork/gameHall")


--------------------------------------热更新---------------------------------------------------
-- 热更新全部的逻辑代码，需要自己控制， 切记玩家数据部分不要加进去，不然会重置玩家数据，如果你是保存型代码，容易导致玩家清档
function ReloadAll()

    Logger("------------------start reload all---------------------------")

     --HotReload
    ReloadFile("Script/HotReload/hotReload")

    -- CSV
    for _,fileName in ipairs(RequireAndReloadCSVFiles) do
        ReloadFile(fileName)
    end

    -- Protocol
    for _,fileName in ipairs(RequireAndReloadProtocolFiles) do
        ReloadFile(fileName)
    end

    -- Const
    for _,fileName in ipairs(RequireAndReloadConstFiles) do
        ReloadFile(fileName)
    end

    -- Utils
    for _,fileName in ipairs(RequireAndReloadUtilsFiles) do
        ReloadFile(fileName)
    end

    -- DataBase
    for _,fileName in ipairs(RequireAndReloadDataBaseFiles) do
        ReloadFile(fileName)
    end


    -- Games
    for _,fileName in ipairs(RequireAndReloadGamesFiles) do
        ReloadFile(fileName)
    end

    -- GameManager
    for _,fileName in ipairs(RequireAndReloadManagerFiles) do
        ReloadFile(fileName)
    end


    -- GlobalVar    -- 注意事项： 因为这里有游戏的全局变量，所以不能reload

    -- NetWork
    for _,fileName in ipairs(RequireAndReloadNetWorkFiles) do
        ReloadFile(fileName)
    end


    ------------------------------------------------------------------------------


    --    -- 已经生成的对象需要刷新函数
    for _, game in pairs(AllGamesList) do
        Game:Reload(game)
        -- 捕鱼游戏

        -- 推币游戏
        if game.GameTypeID == GameTypeTB10 or game.GameTypeID == GameTypeTB100 or game.GameTypeID == GameTypeTB1000 or game.GameTypeID == GameTypeTB10000 then
            for _, table in pairs(game.AllTableList) do
                -- 遍历所有游戏，所有桌子， 所有鱼，所有子弹，所有生成鱼池， 因为这些都是类， 已经生成的对象需要刷新函数
                --print("热更前桌子人数"..table.UserSeatArrayNumber)
                TbTable:Reload(table)
                --print("热更后桌子人数"..table.UserSeatArrayNumber)

            end

        end

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


function ReloadFile(module_name)
    package.loaded[module_name] = nil
    require(module_name)
end
