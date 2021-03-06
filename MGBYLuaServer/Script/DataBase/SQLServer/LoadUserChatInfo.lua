---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.zhengxh
--- DateTime: 2019/11/28 16:58
---

------------------------------------------------------------------------------------------
--- 加载玩家聊天数据(从数据库)
------------------------------------------------------------------------------------------

--- 加载玩家数据信息
--- @param  UserID   用户ID
--- @param  chatUser 聊天数据
function LoadUserChatInfoFromSQLServer(UserID, chatUser)
    if chatUser == nil then
        return
    end
    --1.加载申请好友列表 ApplyFriend[只取按时间倒序的前10条]
    local sSql = ""
    sSql = string.format("SELECT TOP(10) DstUserID from ApplyFriend where UserID = %d and Status = 1;", UserID)
    local ret = SqlServerDataBaseFriendQuery(sSql)
    if #ret == 0 then
        --Logger("LoadUserChatInfoFromSQLServer ApplyFriend 没有申请列表")
    else
        for i, v in ipairs(ret) do
            table.insert(chatUser.ApplyFriend, v.DstUserID)
        end
    end

    --2.加载被申请好友列表 ApplyFriend[只取按时间倒序的前10条]
    sSql = string.format("SELECT TOP(10) UserID from ApplyFriend where DstUserID = %d and Status = 1;", UserID)
    ret = SqlServerDataBaseFriendQuery(sSql)
    if #ret == 0 then
        --Logger("LoadUserChatInfoFromSQLServer ApplyFriend 没有被申请列表")
    else
        for i, v in ipairs(ret) do
            table.insert(chatUser.BeApplyFriend, v.UserID)
        end
    end

    --3.加载好友列表 Friends
    sSql = string.format("SELECT FriendID FROM Friends WHERE UserID=%d AND Status = 0;",UserID)
    ret = SqlServerDataBaseFriendQuery(sSql)
    if #ret == 0 then
        --Logger("LoadUserChatInfoFromSQLServer Friends 没有好友")
    else
        for i, v in ipairs(ret) do
            table.insert(chatUser.FriendArray, v.FriendID)
        end
    end

    --4.加载未读消息 UnreadMessage [只加载LoadMessageInDays天数以内的]
    sSql = string.format("SELECT FriendID,Message FROM UnreadMessage WHERE UserID = %d AND MessageCount > 0 AND LastUpdateTime > DATEADD(d,-%d,GETDATE());",
            UserID, LoadMessageInDays)
    ret = SqlServerDataBaseFriendQuery(sSql)
    if #ret == 0 then
        --Logger(string.format("玩家%d没有未读消息",UserID))
    else
        local tbUnReadMessage = {}  -- 第一次拆分后字符串
        local tbFriendMessage = {}  -- 处理好的单个消息信息
        for i, v in ipairs(ret) do
            tbFriendMessage = {}
            if v.FriendID > 0 and v.Message ~= "" then
                -- 第一次拆分消息
                tbUnReadMessage = StringSplitToStringArrayBYZZ(v.Message, "-|+#")
                if #tbUnReadMessage > 0 then
                    for i = 1, #tbUnReadMessage, 3 do
                        table.insert(tbFriendMessage, {
                            tbUnReadMessage[i],             -- 表情
                            tbUnReadMessage[i+1],           -- 发送时间
                            tbUnReadMessage[i+2]            -- 消息内容
                        })
                    end
                end
                -- 写入我的未读消息列表
                chatUser.UnReadMessageArray[tostring(v.FriendID)] = tbFriendMessage
            end
        end
    end
end