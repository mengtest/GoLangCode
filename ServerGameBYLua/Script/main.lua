---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/10/9 14:12
---

require("hello")
require("hello2")
require("class_test")

-- 热更新全部的逻辑代码，需要自己控制， 切记玩家数据部分不要加进去，不然会重置玩家数据，如果你是保存型代码，容易导致玩家清档
function ReloadAll()

    reloadFile("hello")
    reloadFile("hello2")
    reloadFile("class_test")


end

function reloadFile(module_name)
    package.loaded[module_name] = nil
    require(module_name)
end


