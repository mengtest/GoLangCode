---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.
--- DateTime: 2019/4/20 17:45
---


---------------------------------------------------------------------------
----------------------------大金币----------------------------------------
---------------------------------------------------------------------------

-- 大金币UUID
function CoinCreateBigCoinUID(player)
    player.User.GoldBigCoinUUID = player.User.GoldBigCoinUUID + 1
    return player.User.GoldBigCoinUUID
end


-- 生成一个大金币的数据结构
local function CoinGenerateBigCoin(player, bigCoinNumber, bigCoinType, lotteryValue, sendCmd)

    -- 生成一个大金币， 并且保存起来，用来做校验
    local bigCoin={}
    bigCoin.dwValue = bigCoinNumber         -- 等值的普通金币个数
    bigCoin.eBigCoinType = bigCoinType
    bigCoin.dUID = CoinCreateBigCoinUID(player)
    bigCoin.llLotteryValue = lotteryValue
    --print("GetBigCoin   ".. bigCoin.dUID)
    --printTable(self.m_mapBigCoinData)

    CoinAddBigCoinList(player,bigCoin.dUID,bigCoin)-- 把新创建的大金币加入到大金币的列表中， 为了推下来的时候做校验

    -- 给客户端传递大金币数据
    sendCmd.big_coin_data.big_coin_uid = bigCoin.dUID
    sendCmd.big_coin_data.big_coin_value = bigCoinNumber
    sendCmd.big_coin_data.big_coin_lottery_value = lotteryValue
    sendCmd.big_coin_data.big_coin_type = bigCoinType
    sendCmd.big_coin_data.draw_value = 0



    return sendCmd
end



---------------------------大金币-----------------------------------------------------

-- 创建大金币
function CoinCreateNewBigGold(bigCoinNumber, player, sendCmd, bigCoinType)
    if bigCoinNumber <= 0 then
        sendCmd.big_coin_data.big_coin_uid = 0
        sendCmd.big_coin_data.big_coin_value = 0
        return sendCmd
    end

    local gameTable = player:GetTable()
    local lotteryValue = 0          -- 出产奖券的面值
    if gameTable.cbCloseLottery == 0 and player.User.cbConfineLottery == 0 then
        local dwUID, cbType, cbValue = LotteryGetSpCoin(player, bigCoinNumber)
        if cbType ~= COIN_TYPE_NORMAL then
            lotteryValue = cbValue      -- 奖券的面值
        end
    end

    sendCmd = CoinGenerateBigCoin(player, bigCoinNumber, bigCoinType, lotteryValue, sendCmd)

    CoinAddRemainTableGold(player,1)            --大金币导致桌面金币增加

    -- 个人库存减少 -- 全局库存减少
    PoolReducePersonAndAll(player,bigCoinNumber)


    -- 判断小奖池积分赛
    PointCheckGetPoints(player,bigCoinNumber)

    return sendCmd
end







-------------------------------------------------------------------------------
--- 大金币的数组, 每生成一个就加入到list中去，做校验
-------------------------------------------------------------------------------

function BigCoinListGet(player)
    if player.GameType == GameTypeTB10 then
        return player.User.GoldBigCoinList10
    elseif player.GameType == GameTypeTB100 then
        return player.User.GoldBigCoinList100
    elseif player.GameType == GameTypeTB1000 then
        return player.User.GoldBigCoinList1000
    elseif player.GameType == GameTypeTB10000 then
        return player.User.GoldBigCoinList10000
    end

end

function CoinGetBigCoinList(player, big_coin_uid)
    local listT = BigCoinListGet(player)
    return listT[tostring(big_coin_uid)]
end

-- 把新创建的大金币加入到大金币的列表中， 为了推下来的时候做校验
function CoinAddBigCoinList(player,big_coin_uid,bigCoin)
    local listT = BigCoinListGet(player)
    listT[tostring(big_coin_uid)] = bigCoin
end

-- 大币列表删除，因为获得了
function CoinRemoveBigCoinList(player, big_coin_uid)
    local listT = BigCoinListGet(player)
    listT[tostring(big_coin_uid)] = nil
end

