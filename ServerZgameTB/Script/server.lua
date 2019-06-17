---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/1 14:34
---

-------------------------------------说明----------------------------------------
---本文件是服务器启动的时候加载使用
-----------------------------------------------------------------------------


---------------------------------------CSV----------------------------------------
--
---------------------------------------protocol buffer----------------------------------------
package.path = "Script/Protocol/build/?.lua;"..package.path
package.path = "Script/Protocol/protobuf/?.lua;"..package.path      -- 这里要设置路径， 是因为生成的protocol不包含路径，所以这里设置一下


---------------------------------------Const----------------------------------------
--
--package.path = "Script/NetWork/?.lua;"..package.path
--package.path = "Script/GameCommonLogic/?.lua;"..package.path
--package.path = "Script/HotReload/?.lua;"..package.path
--package.path = "Script/Const/?.lua;"..package.path
--package.path = "Script/Utils/?.lua;"..package.path
--package.path = "Script/GlobalVar/?.lua;"..package.path
--package.path = "Script/GameManager/?.lua;"..package.path
--package.path = "Script/DataBase/?.lua;"..package.path
--package.path = "Script/Games/TB/?.lua;"..package.path

-- 这部分不参与热更新
require("Script/HotReload/hotReload")
require("Script/Utils/dumpTable")
ZJson = require("Script/Utils/Json")
MySerpent = require("Script/Utils/serpent")      -- 使用方法 ： MySerpent.block(tableName)        也是打印table
require("Script/GlobalVar/globalVar")


-- 下面参与热更新，新增加lua文件， 写到reload里面去，不要在这里添加

-- CSV
for _,fileName in ipairs(RequireAndReloadCSVFiles) do
    require(fileName)
end

-- Protocol
for _,fileName in ipairs(RequireAndReloadProtocolFiles) do
    require(fileName)
end

-- Const
for _,fileName in ipairs(RequireAndReloadConstFiles) do
    require(fileName)
end

-- Utils
for _,fileName in ipairs(RequireAndReloadUtilsFiles) do
    require(fileName)
end

-- DataBase
for _,fileName in ipairs(RequireAndReloadDataBaseFiles) do
    require(fileName)
end


-- Games
for _,fileName in ipairs(RequireAndReloadGamesFiles) do
    require(fileName)
end

-- GameManager
for _,fileName in ipairs(RequireAndReloadManagerFiles) do
    require(fileName)
end


-- NetWork
for _,fileName in ipairs(RequireAndReloadNetWorkFiles) do
    require(fileName)
end

