---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.
--- DateTime: 2019/4/15 18:58
---

--------------------------------------------------------------------------------------
--- 翻牌的协议
--------------------------------------------------------------------------------------



--
--------------------------------------获得金币------------------------------------------------------------
--local function CalcCreateCoin_Card(sendCmd, count, player)
--    local gameTable = player:GetTable()
--    -- 以后增加竞技赛积分
--
--    -- 奖券的随机出现， 小金币
--    if gameTable.cbCloseLottery == 0 and player.User.cbConfineLottery == 0 then
--        -- 没有关闭奖券 ，玩家也没有被限制获得奖券
--        local dwUID, cbType, cbValue = LotteryGetSpCoin(player, count)    -- 随机奖券
--        -- 是奖券
--        if cbType ~= COIN_TYPE_NORMAL then
--            -- 增加到协议中
--            local coin = sendCmd.coin_data:add()
--            coin.coin_uid = dwUID
--            coin.lottery_type = cbType
--            coin.lottery_value = cbValue
--
--            CoinAddRemainTableGold(player,1)
--        end
--    end
--
--    -- 台面剩余金币增加
--    CoinAddRemainTableGold(player,count)
--
--    -- 个人库存减少 -- 全局库存减少
--    PoolReducePersonAndAll(player,count)
--
--
--    return sendCmd
--
--end
--



---------------------------------------------主协议入口-----------------------------------------------------



-- 翻牌
function HandleGameCard(userId, data)
    local player, game, gameTable = GetPlayer_Game_Table(userId)

    local msg = CMD_Game_TB_pb.CMD_C_GAME_CARD()
    msg:ParseFromString(data)

    ---- 投币数量不足5
    --if player.m_mapUserPokerLastTriggerCoinNum < 5 then
    --    LuaNetWorkSendToUser(userId, MDM_GF_GAME_TB, SUB_C_GAME_CARD, nil, userId .. "投币数量不足" .. player.m_mapUserPokerLastTriggerCoinNum, nil)
    --    return
    --end

    -- 判断触发间隔
    --local m_dwPokerCD = 4000;
    --local llCurrTime = GetOsTimeMillisecond()
    --
    --if llCurrTime - player.m_mapUserPokerLastTimeStamp <= m_dwPokerCD then
    --    LuaNetWorkSendToUser(userId, MDM_GF_GAME_TB, SUB_C_GAME_CARD, nil, userId .. "间隔时间太短" .. player.m_mapUserPokerLastTimeStamp, nil)
    --    return
    --end

    -- 回复客户端协议
    local sendCmd = CMD_Game_TB_pb.CMD_S_GAME_CARD()
    sendCmd.card_num = msg.card_num         -- 客户端发过来的

    local iAddCoin = 0 -- 获得金币数量



    --更新时间戳和触发计数
    player.m_mapUserPokerLastTimeStamp = GetOsTimeMillisecond()
    player.m_mapUserPokerTriggerTimes = player.m_mapUserPokerTriggerTimes + 1

    --置零投币数,5币 抽一次牌
    if player.m_mapUserPokerLastTriggerCoinNum >= 5 then
        player.m_mapUserPokerLastTriggerCoinNum = player.m_mapUserPokerLastTriggerCoinNum - 5
    end

    --print(" 翻牌的计算调试输出 ---------")
    --print("iRand  "..iRand)
    --print("iCardWinPro  "..iCardWinPro)
    --print("player.m_mapUserPokerLastTriggerCoinNum  "..player.m_mapUserPokerLastTriggerCoinNum)

    local iCardWinPro = GetCardWinPro(player)   -- 获取翻牌几率


    if player.m_mapUserPokerLastTriggerCoinNum < 5 then
        iCardWinPro = ""        -- 如果投币数量小于5， 那么必然不中
    end


    -- 这里原来还有一个限制中奖的情况
    if iCardWinPro == "BloodBingo" then
        -- 开启热血模式
        player.BloodOpen = 1     -- 开启热血模式
        sendCmd.result_type = CARD_TYPE_WANG
        sendCmd = RandWang(sendCmd)
        SqlSaveUserCardLog(player,CARD_TYPE_WANG , 0,0)   -- 记录一下中奖的流水

    elseif iCardWinPro == "CardBingo" then

        -- 获得翻出来牌的类型
        local cbWinType = 0
        cbWinType, iAddCoin =  CalcCardWinPro(player)      -- 计算一下赢什么的几率

        print("随机到的牌型为："..cbWinType)
        --player.m_llCardLastAward = iAddGold

        if cbWinType == CARD_TYPE_DUIZI then
            sendCmd = RandCardDuiZi(sendCmd)
        elseif cbWinType == CARD_TYPE_DOUBLE_DUIZI then
            sendCmd = RandCardDoubleDuiZi(sendCmd)
        elseif cbWinType == CARD_TYPE_SANTIAO then
            sendCmd = RandCardSanTiao(sendCmd)
        elseif cbWinType == CARD_TYPE_SHUNZI then
            sendCmd = RandCardShunZi(sendCmd)
        elseif cbWinType == CARD_TYPE_TONGHUA then
            sendCmd = RandTongHua(sendCmd)
        elseif cbWinType == CARD_TYPE_HULU then
            sendCmd = RandCardHuLu(sendCmd)
        elseif cbWinType == CARD_TYPE_TIEZHI then
            sendCmd = RandCardTieZhi(sendCmd)
        elseif cbWinType == CARD_TYPE_TONGHUASHUN then
            sendCmd = RandTongHuaShunZi(sendCmd)
        else
            print("中奖类型出错了。。。。。。。。。。。")
        end

        --print("调试输出 sendCmd")
        --print(sendCmd)
        --print(sendCmd.result_type)
        --print(cbWinType)
        --print("****************************")

        sendCmd.result_type = cbWinType
        if cbWinType ~= CARD_TYPE_WANG then
            -- 计算产出金币
            local lottery_value = 0
            sendCmd, lottery_value = CoinCreateNewGold(sendCmd, iAddCoin, player)
            SqlSaveUserCardLog(player,cbWinType , iAddCoin,lottery_value)       -- 记录一下中奖的流水

            SqlSaveSystemLogCard(gameTable , cbWinType, iAddCoin , player.User.UserId)
        end

        -- 日志记录
    else
        -- 没有中奖
        sendCmd = RandFail(sendCmd)
        sendCmd.result_type = CARD_TYPE_FAIL
    end

    sendCmd.gold_num = iAddCoin
    sendCmd.small_pool_add_num = iAddCoin
    LuaNetWorkSendToUser(player.User.UserId, MDM_GF_GAME_TB, SUB_S_GAME_CARD, sendCmd, nil, nil)


    --print("保存玩家信息")
    -- 保存玩家信息
    RedisSavePlayerAll(player.User)

end