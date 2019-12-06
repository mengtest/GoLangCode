--- databaseBY 数据库查询相关
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.
--- DateTime: 2019/10/25 15:41
---

--- 加载用户信息
---@param type 查询类型
---@param where 查询条件 可以是UserId,GameID,昵称
---@return 返回查询结果
function ChatServerLogic:OnLoadUserInfo(type, where)
    local whereStr ='' --根据不同的类型进行查询
    local sSql = ''
    if type == Enum_DBSearchType.UserID then
        if where  == 0 then
            return nil
        end
        whereStr = string.format("  UserID = %d ",where)
    elseif type == Enum_DBSearchType.GameID then
        -- 同时有gameid 查询 又有 昵称查询
        whereStr = string.format("  GameID = %d ",where)
    elseif type == Enum_DBSearchType.Nick  then
        whereStr = string.format("  NickName =  '%s' ",where)
    else
        return nil
    end
    sSql = "select A.UserID, A.GameID, A.NickName, A.FaceID, A.VipLev, A.AccountLev, A.Lev, A.OnLineTimeCount,A.OffLineTime,ISNULL(B.GuildID, 0) as GuildID, ISNULL(C.GuildName, N'') as GuildName from  "
    sSql = sSql .. string.format("(select UserID, GameID, NickName, FaceID, VipLev, AccountLev, Lev, OnLineTimeCount ,OffLineTime from AccountsInfo with(nolock) where  %s) A left join GuildUserInfo B with(nolock) on B.UserID = A.UserID  ", whereStr)
    sSql = sSql .. "LEFT JOIN GuildInfo C with(nolock) on C.GuildID = B.GuildID; "
    return SqlServerDataBaseBYQuery(sSql)
end

--- 根据数据库信息加载用户信息
---@param userT 数据库返回的单个结构体  为上面那个方法定制
---@return ChatServerUserInfo
function ChatServerLogic:NewUserInfoByDBData(userT)
    local newUserInfo = nil
        --取第一个下标
    if userT  ~= nil then
        newUserInfo = ChatServerUserInfo:New()
        newUserInfo.UserId = userT.UserID   -- 玩家ID
        newUserInfo.GameId = userT.GameID   -- 游戏ID
        newUserInfo.FaceId = userT.FaceID  -- 头像ID
        newUserInfo.VipLevel = userT.VipLev  -- vip等级
        newUserInfo.Level = userT.AccountLev  -- 用户等级
        newUserInfo.SiteLevel = userT.Lev   -- 炮等级
        newUserInfo.NickName = userT.NickName -- 昵称
        newUserInfo.OnlineTime = userT.OnLineTimeCount -- 在线时长
        newUserInfo.GuildID= userT.GuildID           -- 公会id
        ---print('----------------------------------' .. newUserInfo.GuildID)
        newUserInfo.GuildName = userT.GuildName        -- 公会名称
        newUserInfo.llOffLineTime =  userT.OffLineTime
        --添加用戶信息 并請求
    end
    return newUserInfo
end


--- 加载聊天时候的屏蔽字
---@return table string 类型列表
function ChatServerLogic:LoadConfineContent()
    local sSql = "select string from ConfineContent with(nolock)"
    return SqlServerDataBaseBYQuery(sSql)
end


---加载若干玩家的用户信息
---@param tNeedLoadUserInfo 玩家id的数组列表
function ChatServerLogic:LoadUserInfoList(tNeedLoadUserInfo)
    --printTable(tNeedLoadUserInfo,nil,"开始加载玩家列表tNeedLoadUserInfo")
    local sSql = "select A.UserID, A.GameID, A.NickName, A.FaceID, A.VipLev, A.AccountLev, A.Lev, A.OnLineTimeCount,A.OffLineTime ,ISNULL(B.GuildID, 0) as GuildID, ISNULL(C.GuildName, N'') as GuildName \
						from (select UserID, GameID, NickName, FaceID, VipLev, AccountLev, Lev, OnLineTimeCount,OffLineTime from AccountsInfo with(nolock) where UserID in(";
    if tNeedLoadUserInfo == nil or #tNeedLoadUserInfo <= 0 then
        return nil;
    end
    local nCount = 0;
    for _,userid in ipairs(tNeedLoadUserInfo) do
        nCount = nCount + 1;
        if nCount == 1 then
            sSql = string.format("%s%d",sSql,userid);
        else
            sSql = string.format("%s,%d",sSql,userid);
        end
    end
    sSql = string.format("%s%s",sSql,")) A left join GuildUserInfo B with(nolock) on B.UserID = A.UserID LEFT JOIN GuildInfo C with(nolock) on C.GuildID = B.GuildID");
    return SqlServerDataBaseBYQuery(sSql)
end


--- 更新用户离线时间
function ChatServerLogic:SaveUserOffLineTime(dwUserID)
    local sSql = string.format("update AccountsInfo with(updlock) set OffLineTime=GETDATE()  where UserID = %d", dwUserID);
    SqlServerDataBaseBYExec(sSql)
end