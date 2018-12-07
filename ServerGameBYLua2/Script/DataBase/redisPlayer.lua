---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/12/7 15:25
---




----------------------------玩家信息-----------------------------
function RedisSavePlayer(User)
    RedisSaveString(RedisDirAllPlayers..User.UserId,User.UserId, ZJson.encode(User))
end

function RedisGetPlayer(uid)
    return  ZJson.decode(RedisGetString(RedisDirAllPlayers..uid, uid))
end

----------------------------玩家登录信息-----------------------------
function RedisSavePlayerLogin(openId,Uid)
    RedisSaveString(RedisDirAllPlayersLogin..openId,openId, Uid)
end

function RedisGetPlayerLogin(openId)
    return  RedisGetString(RedisDirAllPlayersLogin..openId, openId)     -- 返回Uid
end