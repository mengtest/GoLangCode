---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by soonyo.
--- DateTime: 2019/4/20 15:59
---


-------------------------------------------------
--- 税率
-------------------------------------------------




-- 获取税率
function GetRevenueRatio(gameTable, income)
    local taxRate = GetExcelValue(TBRoomExcel , gameTable.RoomScore, "tax")
    return taxRate * income /10000

end


