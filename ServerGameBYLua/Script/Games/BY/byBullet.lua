---
--- Generated by EmmyLua(https:--github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/11/2 16:48
---



Bullet = {}

function Bullet:New(id)
    c = {
        BulletUID = id, --UID
        TempID = 0,
        UserID = 0, -- 所属玩家的id
        FireAngle = 0, -- 发射的角度
        BulletMulriple = 0, -- 倍率
        lockFishID = 0, -- 锁定鱼的ID
        DeadTime = GetOsTimeMillisecond() + 5 * 1000 , -- 过期时间 5秒
    }
    setmetatable(c, self)
    self.__index = self
    return c
end

function Bullet:BulletRun(table)
    if GetOsTimeMillisecond() > self.DeadTime then
        table:DelBullet(self.BulletUID)     -- 生存时间已经到了，销毁
    end
end