---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/12/11 11:18
---

------------------------------------------------------------------------
--- 这是lua直接调用mysql， 特点是写的方便，多用于select查询数据，也可以用于其他语句的顺序执行过程
------------------------------------------------------------------------


MySqlEngine = require('mysql')
MySqlEngineConnect = MySqlEngine.new()

-- mysql数据库连接
function MysqlConnect(h,p,d,u,ps)

    local ok, err = MySqlEngineConnect:connect({ host = h, port = tonumber(p), database = d, user = u, password = ps })

    if ok then
        print("Mysql 数据库 ok!")
        --local res, err = MySqlEngineConnect:query("SELECT * FROM game_state")
        --if err then
        --    print(err)
        --else
        --    printTable(res)
        --end
    end

    return ok

end

-- 执行sql select语句
function MysqlQuery(sql)
    local re,err
    re,err = MySqlEngineConnect:query(sql)
    return re
end


-- 执行sql exec语句
function MysqlExec(sql)
    MySqlEngineConnect:exec(sql)
end

