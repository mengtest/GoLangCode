---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/12/11 11:18
---

------------------------------------------------------------------------
--- 这是lua直接调用mysql， 特点是写的方便，缺点是性能差， 只用于查询数据，但是一般不用， 因为慢
------------------------------------------------------------------------


MySqlEngine = require('mysql')
MySqlEngineConnect = MySqlEngine.new()

-- mysql数据库连接
function MysqlConnect(host,port, databaseName, userName, passWord)
    local ok, err = MySqlEngineConnect:connect({ host = host, port = tonumber(port), database = databaseName, user = userName, password = passWord })

    if ok then
        print("Mysql is ok")
        --res, err = MySqlEngineConnect:query('SELECT * FROM user')
        --printTable(res)
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

