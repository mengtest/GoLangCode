---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.
--- DateTime: 2019/6/12 16:48
---

------------------------------------------------------------------
--- 幸运轮盘的中奖历史记录
------------------------------------------------------------------

-- 获取中奖历史记录
function LuckyWheelHistoryListGet(sendCmd)
    -- 从redis里面获取
    local history_redis = RedisGetLuckyWheel()
    print("LuckyWheelHistoryListGet")
    print(history_redis)
    if history_redis == "null" then
        return sendCmd
    end

    local history_list = ZJson.decode(history_redis)     -- 解开json，里面是一个列表
    local history_num = 0
    for _, history_json in pairs(history_list) do
        local history_data = ZJson.decode(history_json)
    --end
    --for i in ipairs(history_redis) do
        if history_num < 8 then
            local history =  sendCmd.history:add()
            history.nick_name = history_data.nick_name
            history.wheel_result = history_data.wheel_result
        end
        history_num = history_num + 1

        if history_num > 8 then
            RedisDelLuckyWheel()        -- 如果记录太多了，那么删掉最后一条，退出
            return sendCmd
        end
    end
    return sendCmd
end

-- 增加新的记录到历史中
function LuckyWheelHistoryListAdd(nick_name,wheel_result)
    --local history_redis = RedisGetLuckyWheel()
    --if history_redis == nil then
    --    history_redis = {}
    --end
    local item = {}
    item.nick_name = nick_name
    item.wheel_result = wheel_result
    --table.insert(history_redis,0, item)
    --
    --if #history_redis > 8 then
    --    table.remove(history_redis,#history_redis)
    --end

    --print("增加记录到历史中")
    --print(MySerpent.block(history_redis))
    RedisSaveLuckyWheel(ZJson.encode(item))       -- 把结果保存起来
end