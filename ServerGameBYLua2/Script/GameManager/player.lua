---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/2 16:37
---


--------------------------------------------------------------------------------------
--- player 的数据是玩家的游戏中的数据
--- 这里直接定义成员变量， 但是不写成员函数， 是为了节省内存
--------------------------------------------------------------------------------------

Player = {}
function Player:New(user)
    c = {
        User = user,  -- user数据

        TableID = TABLE_CHAIR_NOBODY ,  -- 桌子id
        ChairID = TABLE_CHAIR_NOBODY,   -- 椅子id

        IsRobot = false,            -- 是不是机器人
        ActivityBulletNum = 0,   --当前已经发射的子弹数量

        GameType = 0 ,     -- 游戏类型

        NetWorkState = true,   -- 网络状态正常
        NetWorkCloseTimer = 0 ,   -- 等待玩家断线重连的时间倒计时
    }
    --setmetatable(c, self)
    --self.__index = self
    return c
end

---- 备用的， 纯数据类，用不到， 如果是带函数的话， 就需要热更新之后重新刷新每个对象了
--function Player:Reload(c)
--    setmetatable(c, self)
--    self.__index = self
--end