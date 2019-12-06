---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.zhengxh
--- DateTime: 2019/11/28 15:45
---

--------------------------------------------------------------------------------------
--- 玩家删除好友
--------------------------------------------------------------------------------------

--- 玩家删除好友
--- @param player   玩家对象
--- @param data     消息数据
function ChatTable:HandleUserDeleteFriend(player, data)
    -- 玩家判定
    if player == nil or player.ChatUser == nil then
        Logger("ChatTable:HandleUserDeleteFriend 玩家不存在")
        return
    end
    -- 解析消息
    local receiveMsg = CMD_GlobalServer_pb.CMD_C_DELETE_FRIEND()
    receiveMsg:ParseFromString(data)

    -- 玩家ID
    local dwUserID = receiveMsg.req_user_id
    -- 要删除的好友ID
    local dwFriendID = receiveMsg.friend_user_id

    -- 响应消息
    local sendMsg = CMD_GlobalServer_pb.CMD_S_DELETE_FRIEND()
    sendMsg.req_user_id     = dwUserID
    sendMsg.friend_user_id  = dwFriendID
    -- 玩家UserID验证
    if player.User.UserID ~= dwUserID then
        sendMsg.result = Enum_ReplyResult.Failed
        LuaNetWorkSendToUser(dwUserID, MAIN_CHAT_SERVICE_CLIENT, SUB_S_DELETE_FRIEND, sendMsg)
        return
    end
    -- 删除UserID验证
    if player.User.UserID == dwFriendID then
        sendMsg.result = Enum_ReplyResult.Failed
        LuaNetWorkSendToUser(dwUserID, MAIN_CHAT_SERVICE_CLIENT, SUB_S_DELETE_FRIEND, sendMsg)
        return
    end
    -- 好友列表判定
    if player:IsInFriendArray(dwFriendID) == 0 then
        sendMsg.result = Enum_ReplyResult.Failed
        LuaNetWorkSendToUser(dwUserID, MAIN_CHAT_SERVICE_CLIENT, SUB_S_DELETE_FRIEND, sendMsg)
        return
    end
    sendMsg.result = Enum_ReplyResult.Successful
    -- 从我的好友列表删除
    player:DelFriendInfo(dwFriendID)
    -- 清空该好友的未读消息
    player:DelFriendUnReadMessage(dwFriendID)
    -- 处理好友关系
    local friendPlayer = GetPlayerByUID(dwFriendID)
    if friendPlayer then
        -- 在线,从好友列表移除
        friendPlayer:DelFriendInfo(dwUserID)
        -- 删除未读消息
        friendPlayer:DelFriendUnReadMessage(dwUserID)
        -- 通知该玩家
        LuaNetWorkSendToUser(dwFriendID, MAIN_CHAT_SERVICE_CLIENT, SUB_S_DELETE_FRIEND, sendMsg)
    else
        -- 不在线,获取该好友聊天信息
        local chatFriendUser = RedisGetPlayerChatInfo(dwFriendID)
        local iIndex = 0
        for i, v in ipairs(chatFriendUser.FriendArray) do
            if v == dwUserID then
                iIndex = i
                break
            end
        end
        -- 从好友列表移除
        table.remove(chatFriendUser.FriendArray, iIndex)
        -- 清空对方发来的未读消息
        if chatFriendUser.UnReadMessageArray[tostring(dwUserID)] ~= nil then
            chatFriendUser.UnReadMessageArray[tostring(dwUserID)] = nil
        end
        -- 保存Redis
        RedisSavePlayerChatInfo(dwFriendID, chatFriendUser)
    end
    -- 通知玩家结果
    LuaNetWorkSendToUser(dwUserID, MAIN_CHAT_SERVICE_CLIENT, SUB_S_DELETE_FRIEND, sendMsg)
end