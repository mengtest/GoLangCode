---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.zhengxh
--- DateTime: 2019/10/23 10:12
---

--------------------------------------------------------------------------------------
--- 小海兽处理接受处理玩家网络消息
--------------------------------------------------------------------------------------

--- 接受玩家网络消息
--- @param serverId 游戏serverId
--- @param userId   玩家UserId
--- @param msgId    消息主协议
--- @param subMsgId 消息子协议
--- @param data     消息体
--- @param token    token验证
function XhsReceiveMsg(serverId,userId, msgId, subMsgId, data, token)
    -- 数据验证
    local player,game, gameTable = GetPlayer_Game_Table(userId)
    if player == nil or game == nil or gameTable == nil then
        Logger("玩家数据："..player..";game:"..game..";table:"..gameTable)
        return
    end
    -- 消息派发
    if subMsgId == SUB_C_USE_SUMMON_GEM then
        -- 使用召唤石
        gameTable:HandleOnUserUseSummonGem(player,data)
    elseif subMsgId == SUB_C_DHS_USER_FIRE then
        -- 开炮
        gameTable:HandleOnUserFireToXHS(player,data)
    elseif subMsgId == SUB_C_PLAY_PUZZLE_REQ then
        -- 拼图
        gameTable:HandleOnUserPlayPuzzle(player,data)
    elseif subMsgId == SUB_C_PUZZLE_REWARD_REQ then
        -- 领取拼图奖励
        gameTable:HandleOnUserGetPuzzleAward(player,data)
    end
end