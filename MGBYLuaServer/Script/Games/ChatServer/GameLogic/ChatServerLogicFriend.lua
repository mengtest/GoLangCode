---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.
--- DateTime: 2019/10/24 9:27
---这个文件封装ChatServerFace关于friend相关的接口



-----------------------------------------------------------------------------
-------------------这里是关于m_pApplyControllerList（后台好友）相关的接口----
-----------------------------------------------------------------------------

--检查是否在对方的申请列表、被申请列表或已经是好友
---@param pTargetFriends 指定的好友关系
---@param dwUserID 申请的玩家id
function ChatServerLogic:IsCanBeApplyFriend(tTargetFriends, dwUserID)
    if tTargetFriends == nil or #tTargetFriends <= 0 or tTargetFriends:IsExistedApplyFriend(dwUserID)
        or tTargetFriends:IsExistedBeAppliedForFriend(dwUserID) or tTargetFriends:IsExistedFriend(dwUserID) then
        return false;
    end
    return true;
end

--检查申请条件
---@param tApplyControllerCur 后台申请玩家
---@param tFriendUserInfo 被申请玩家的信息
function ChatServerLogic:IsCanApplyFriend(tApplyControllerCur, tFriendUserInfo)
    --判定vip等级
    if tApplyControllerCur.btVipMax > 0 and tFriendUserInfo.btVipLv > tApplyControllerCur.btVipMax or tFriendUserInfo.btVipLv < tApplyControllerCur.btVipMin then
        return false;
    end
    --判定经验等级
    if tApplyControllerCur.btUserLvMax > 0 and tFriendUserInfo.btUserLv > tApplyControllerCur.btUserLvMax or tFriendUserInfo.btUserLv < tApplyControllerCur.btUserLvMin then
        return false;
    end
    --判定炮等级
    if tApplyControllerCur.wGunLvMax > 0 and tFriendUserInfo.wGunLv > tApplyControllerCur.wGunLvMax or tFriendUserInfo.wGunLv < tApplyControllerCur.wGunLvMin then
        return false;
    end
    --判定在线时间
    if tApplyControllerCur.dwOnlineMax > 0 and tFriendUserInfo.dwOnlineTime > tApplyControllerCur.dwOnlineMax or tFriendUserInfo.dwOnlineTime < tApplyControllerCur.dwOnlineMin then
        return false;
    end
    return true;
end

--加载好友数据
---@param dwUserID 玩家id
function ChatServerLogic:DoLoadUserFriendsInfo(dwUserID)
    ---print(string.format("DoLoadUserFriendsInfo:开始加载玩家[%d]的好友列表",dwUserID));
    local tDboData = self:LoadUserFriendsInfo(dwUserID)
    if tDboData == nil then
        return true;
    end
    local tFriendCache = self.FriendMgr:GetFriendRelation(dwUserID);
    local tUserCache = self.UserMgr:FindUserInfoPtrByUserID(dwUserID);
    --printTable(tFriendCache,0,"tFriendCache")
    --printTable(tUserCache,0,"tUserCache")
    if tFriendCache == nil or tUserCache == nil then
        return true;
    end
    --print(string.format("DoLoadUserFriendsInfo:开始写入玩家[%d]的好友列表到内存",dwUserID))
    --tNeedLoadUserInfo记录需要加载的玩家的id
    local tNeedLoadUserInfo = {};
    for _,value in pairs(tDboData) do
        --printTable(value,0,"value")
         ---这里时间字符串要转换为时间戳，统一格式
        local tTimeStamp = tonumber(GetTimeFromString(value.CreateTime))
        ---print('tDboData', tTimeStamp)
        tFriendCache:AddFriend(value.FriendID,tTimeStamp);
        if not self.UserMgr:FindUserInfoByUserID(value.FriendID) then
            table.insert(tNeedLoadUserInfo,value.FriendID);
        end
    end
    --printTable(tNeedLoadUserInfo,0,"tNeedLoadUserInfo")
    if #tNeedLoadUserInfo > 0 then
        self:DoLoadUserInfoList(tNeedLoadUserInfo);
    end
end

---加载玩家申请的添加好友列表
---@param dwUserID 玩家id
function ChatServerLogic:DoLoadUserApplyInfo(dwUserID)
    local tDboData = self:LoadUserApplyInfo(dwUserID);
    if tDboData == nil and next(tDboData) == nil then
        return true;
    end
    local tFriendCache = self.FriendMgr:GetFriendRelation(dwUserID);
    local tUserCache = self.UserMgr:FindUserInfoPtrByUserID(dwUserID);
    if tFriendCache == nil or tUserCache == nil then
        return true;
    end
    --tNeedLoadUserInfo记录需要加载的玩家的id
    ---printTable(tDboData)
    local tNeedLoadUserInfo = {};
    for _,value in pairs(tDboData) do
        ---这里时间字符串要转换为时间戳，统一格式
        local tTimeStamp = tonumber(GetTimeFromString(value.CreateTime))
        tFriendCache:AddApplyFriend(value.DstUserID,tTimeStamp);
        if not self.UserMgr:FindUserInfoByUserID(value.FriendID) then
            table.insert(tNeedLoadUserInfo,value.FriendID);
        end
    end
    if #tNeedLoadUserInfo > 0 then
        self:DoLoadUserInfoList(tNeedLoadUserInfo);
    end
end

---加载玩家被申请加好友的列表
---@param dwUserID 玩家id
function ChatServerLogic:DoLoadUserByApplyInfo(dwUserID)
    local tDboData = self:LoadUserBeApplyInfo(dwUserID);
    if tDboData == nil or next(tDboData) == nil  then
        return true;
    end
    local tFriendCache = self.FriendMgr:GetFriendRelation(dwUserID);
    local tUserCache = self.UserMgr:FindUserInfoPtrByUserID(dwUserID);
    if tFriendCache == nil or tUserCache == nil then
        return true;
    end
    ---print(string.format("DoLoadUserByApplyInfo:加载玩家[%d]被申请加好友的列表",dwUserID));
    --tNeedLoadUserInfo记录需要加载的玩家的id
    local tNeedLoadUserInfo = {};
    for _,value in pairs(tDboData) do
        ---这里时间字符串要转换为时间戳，统一格式
        local tTimeStamp = tonumber(GetTimeFromString(value.CreateTime))
        tFriendCache:AddBeAppliedForFriend(value.UserID,tTimeStamp);
        if not self.UserMgr:FindUserInfoByUserID(value.UserID) then
            table.insert(tNeedLoadUserInfo,value.UserID);
        end
    end
    --printTable(tFriendCache,0,"tFriendCache")
    if #tNeedLoadUserInfo > 0 then
        self:DoLoadUserInfoList(tNeedLoadUserInfo);
    end
end




---加载若干玩家的用户信息
---@param tNeedLoadUserInfo 玩家id的数组列表
function ChatServerLogic:DoLoadUserInfoList(tNeedLoadUserInfo)
    --print("DoLoadUserInfoList:开始加载玩家列表tNeedLoadUserInfo");
    local tDboData = self:LoadUserInfoList(tNeedLoadUserInfo);
    --printTable(tDboData);
    if tDboData == nil then
        return true;
    end
    for _,value in pairs(tDboData) do
        local tUserInfo = ChatServerUserInfo:New();
        tUserInfo.UserId = value.UserID;
        tUserInfo.GameId = value.GameID;
        tUserInfo.FaceId = value.FaceID;
        tUserInfo.VipLevel = value.VipLev;
        tUserInfo.NickName = value.NickName;
        tUserInfo.GuildID = value.GuildID;
        tUserInfo.GuildName = value.GuildName;
        --print()
        tUserInfo.llOffLineTime = GetTimeFromString(value.OffLineTime)
        --printTable(tUserInfo,0,"DoLoadUserInfoList:tUserInfo")
        --print("tUserInfo.Gender="..tUserInfo.Gender);
        --self.UserMgr:AddUser(tUserInfo);
        self.UserMgr:SaveUserInfo2Redis(tUserInfo);
    end
end

---通知前端有新的动态
---@param dwUserID 玩家id
---@param iUnreadCount 未读消息数量
---@param bPull ---
---@param dwFriendID 好友id
function ChatServerLogic:NotifyNewState(dwUserID, iUnreadCount, bPull, dwFriendID)
    bPull = bPull or false;
    dwFriendID = dwFriendID or 0;
    local sendCmd = CMD_GlobalServer_pb.CMD_S_NOTIFY_NEW_CHAT_MESSAGE();
    sendCmd.friend_user_id = dwFriendID;
    sendCmd.is_pull = bPull;
    sendCmd.unread_count = iUnreadCount;
    LuaNetWorkSendToUser(dwUserID, MAIN_CHAT_SERVICE_CLIENT, SUB_S_NOTIFY_NEW_CHAT_MESSAGE, sendCmd, nil);
end

---加载屏蔽词库
function ChatServerLogic:OnLoadConfineContent()
    self.m_tConfineContent = {};
    local tDbo = self:LoadConfineContent();
    if tDbo == nil or next(tDbo) == nil then
        return;
    end
    local sKey = "";
    local sContent = "";
    for _,value in ipairs(tDbo) do
        sContent = value["string"];
        --printTable(sContent);
        ---将字符串的第一个字符作为key值
        if string.len(sContent) <= 1 then
            if self.m_tConfineContent[sContent] == nil then
                self.m_tConfineContent[sContent] = {};
            end
            table.insert(self.m_tConfineContent[sContent],sContent);
        else
            sKey = string.sub(sContent,1,1);
            if self.m_tConfineContent[sKey] == nil then
                self.m_tConfineContent[sKey] = {};
            end
            table.insert(self.m_tConfineContent[sKey],sContent);
        end
    end
    ---对敏感词排序，长的排前面
    local function sortConfineContent(sContent1,sContent2)
        return string.len(sContent1) > string.len(sContent2)
    end
    --local sKey = nil;
    for key,_ in pairs(self.m_tConfineContent) do
        table.sort(self.m_tConfineContent[key],sortConfineContent)
        --if sKey == nil and table.getn(self.m_tConfineContent[key]) > 3 then
            --sKey = key;
        --end
    end
    --printTable(self.m_tConfineContent[sKey],0,string.format("ConfineContent[%s]",sKey))
    return ;
end




--------- 加载聊天消息

---加载玩家的未读消息
---@param dwUserID 玩家id
function ChatServerLogic:DoLoadUserUnreadMsg(dwUserID)
    --- print(string.format("DoLoadUserUnreadMsg:加载玩家[%d]未读消息",dwUserID));
    if dwUserID == nil or dwUserID <= 0 then
        return false;
    end
    --- 先找人没找到就不用去查询数据库了,优化执行
    local tUnreadMsgCache = self.FriendMgr:GetUnreadMessageCache(dwUserID);
    --printTable(tUnreadMsgCache,0,"tUnreadMsgCache")
    if tUnreadMsgCache == nil then
        return false;
    end
    ---从数据库加载用户未读的信息
    local tDboData = self:LoadUserUnreadMsg(dwUserID)
    if tDboData == nil then
        --这里也必须返回处理标记位
        tUnreadMsgCache:UnlockState();
        return true;
    end

    ---printTable(tDboData,0,"DoLoadUserUnreadMsg.tDboData")
    for key,tDboUnreadMsg in pairs(tDboData) do
        local tFinalMessage = {};--这个table是缓存最终写入内存中玩家未读消息的数据表
        local tVecMessage = {};
        --printTable(tDboUnreadMsg,0,"tDboUnreadMsg")
        tVecMessage = SplitString(tDboUnreadMsg.Message,MESSAGE_SPARATE,8 );
        --printTable(tVecMessage,0,"tVecMessage")
        if tVecMessage ~= nil and #tVecMessage > 0 then
            for _,tBaseMessage in ipairs(tVecMessage) do
                local tMessageData = {};
                tMessageData = SplitString(tBaseMessage,MESSAGE_FIELD_SPARATE,tMessageData);
                if tMessageData ~= nil and #tMessageData == 3 then
                    local tUnReadMsg =  ChatServerMessage:New(dwUserID);
                    tUnReadMsg.dwEmotion = tonumber(tMessageData[1]);
                    tUnReadMsg.tTimeStamp = tonumber(tMessageData[2]);
                    tUnReadMsg.sAfterFilterContent = tMessageData[3];
                    table.insert(tFinalMessage,tUnReadMsg);
                end
            end
        end
        tUnreadMsgCache:AddUnreadMessage(tDboUnreadMsg.FriendID,tFinalMessage);
        --tUnReadMsg.tTimeStamp
        --[[local tUnReadMsg = {};
        tUnReadMsg.dwFiendID = tDboUnreadMsg.FriendID;
        tUnReadMsg.sMessage = tDboUnreadMsg.Message;
        table.insert(tMessage.tUnReadMsg,tUnReadMsg)]]--
    end
    tUnreadMsgCache:UnlockState();
    if  tUnreadMsgCache:IsThereAnyMessage() then
        ---  print(string.format("DoLoadUserUnreadMsg:玩家[%d]有未读消息",dwUserID));
        if self.UserMgr:FindUserInfoPtrByUserID(dwUserID) then
            self:NotifyNewState(dwUserID,1);
        end
    end
    return true;
end