---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/10/12 15:00
---

-------------------------------------热更新----------------------------------------
--- 热更新文件列表
-----------------------------------------------------------------------------


local function reloadFile(module_name)
    package.loaded[module_name] = nil
    require(module_name)
end


-- 热更新全部的逻辑代码，需要自己控制， 切记玩家数据部分不要加进去，不然会重置玩家数据，如果你是保存型代码，容易导致玩家清档
function ReloadAll()

    Logger("------------------start reload all---------------------------")

    -- HotReload
    reloadFile("Script/HotReload/hotReload")

    -- CSV
    reloadFile("Script/CSV/mgby_fish_sever")

    -- Protocol
    reloadFile("Script/Protocol/build/CMD_Game_pb")
    reloadFile("Script/Protocol/build/CMD_GameServer_pb")

    -- Const
    reloadFile("Script/Const/Const")
    reloadFile("Script/Const/Excel")
    reloadFile("Script/Const/Proto")
    reloadFile("Script/Const/protocol_cs")
    reloadFile("Script/Const/protocol_gs")
    reloadFile("Script/Const/protocol_ls")

    -- Utils
    reloadFile("Script/Utils/Random")
    reloadFile("Script/Utils/Time")
    reloadFile("Script/Utils/zTable")
    reloadFile("Script/Utils/zRedis")


    -- Logger
    reloadFile("Script/Logger/logger")

    -- GameCommonLogic
    reloadFile("Script/GameCommonLogic/commonLogic")


    -- Games
    reloadFile("Script/Games/BY/byBullet")
    reloadFile("Script/Games/BY/byFish")
    reloadFile("Script/Games/BY/byFishDistribute")
    reloadFile("Script/Games/BY/byTable")

    -- GameManager
    reloadFile("Script/GameManager/player")
    reloadFile("Script/GameManager/user")
    reloadFile("Script/GameManager/games")
    reloadFile("Script/GameManager/gameManager")


    -- GlobalVar    -- 注意事项： 因为这里有游戏的全局变量，所以不能reload

    -- NetWork
    reloadFile("Script/NetWork/LoginServer")
    reloadFile("Script/NetWork/gameFire")
    reloadFile("Script/NetWork/gameEnter")
    reloadFile("Script/NetWork/Statistic")
    reloadFile("Script/NetWork/network")


    -- main
    --reloadFile("Script/server")


end


