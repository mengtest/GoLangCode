package main

import (
	"./mssql"
	"./zLog"
	"database/sql"
	"fmt"
	_ "github.com/denisenkom/go-mssqldb"
	"strings"

)

func DealUserList(id int) {
	var (
		userId     = "dbuser"
		password   = "CEDFE2CDA7DB84AC"
		server     = "172.16.140.89"
		//logDBName1 = "BY_LOG_202001"
		//logDBName2 = "BY_LOG_202002"
		logDBName2019 = "BY_LOG_201905"
		//logDBName2019Copy = "BY_LOG_201905_copy"
		logDBName2019Copy = "DataBaseBY_201904"
		testDBName = "auditdb"


		
	)
	fmt.Println(" --------------开始连接数据库-------------- ")
	testDB := mssql.ConnectDB(userId, password, server, testDBName)
	//logDB1 := mssql.ConnectDB(userId, password, server, logDBName1)
	//logDB2 := mssql.ConnectDB(userId, password, server, logDBName2)
	logDB2019 := mssql.ConnectDB(userId, password, server, logDBName2019)

	idStart:= id * Group
	idEnd :=  (id + 1)* Group
 	//fmt.Println(" --------------开始查询玩家列表--------------")
	//sqlU:= fmt.Sprintf( "select top(%d)* from testdb.dbo.aa_user_chongzhi_new_sortid_match   with(nolock) where id >= %d", Group,idStart)	// 2020充值的用户
	//sqlU:= fmt.Sprintf( "select top(%d)* from testdb.dbo.a1_user_free_new_sortid_match   with(nolock) where id >= %d", Group,idStart)    // 2020免费的用户

	sqlU:= fmt.Sprintf( "select * from %s.dbo.x2019_user_free_match   with(nolock) where id >= %d and id < %d", testDBName, idStart ,  idEnd)    // 2019免费的用户
	//sqlU:= fmt.Sprintf( "select * from %s.dbo.x2019_user_chongzhi_match  with(nolock) where id >= %d and id < %d", testDBName, idStart ,  idEnd)    // 2019审计包含历史上充值用户
	_, rows, _ := mssql.Query(testDB, sqlU)

	for rows.Next() { // 循环遍历
		var userInfo UserList
		err := rows.Scan(&userInfo.id, &userInfo.uid, &userInfo.initDate, &userInfo.lastDate, &userInfo.days, &userInfo.uid2, &userInfo.initDate2, &userInfo.lastDate2, &userInfo.days2, &userInfo.matchType, &userInfo.dayNum) // 赋值到结构体中
		if err != nil {
			zLog.PrintfLogger(" 遍历玩家列表 id %d    , %s \n" , userInfo.id,  err)
			continue
		}

		zLog.PrintfLogger(" --------------开始处理id : %d--------------", userInfo.id)

		// -----------------------------获取一行数据------------------------
		//fmt.Println("", userInfo.id)
		//fmt.Println("", userInfo.uid)
		//fmt.Println("", userInfo.initDate)
		//fmt.Println("", userInfo.lastDate)
		//fmt.Println("", userInfo.days)
		//fmt.Println("", userInfo.uid2)
		//fmt.Println("", userInfo.initDate2)
		//fmt.Println("", userInfo.lastDate2)
		//fmt.Println("", userInfo.days2)
		//fmt.Println("", userInfo.matchType)
		//fmt.Println("", userInfo.dayNum)

		dayList := getTimeList(userInfo.initDate, userInfo.days) // 玩家的日期列表
		dayList2 := getTimeList(userInfo.initDate2, userInfo.days2)
		//fmt.Println("day list: ", dayList[0])
		//fmt.Printf("%v \n ", dayList2)

		// -----------------------------用户所有天数--------------------------------
		for i := 0; i < userInfo.days; i++ { // 按照日期遍历
			day1 := dayList[i]
			day2 := dayList2[i]
			day1 = strings.Replace(day1, "-", "", -1)
			day2 = strings.Replace(day2, "-", "", -1)

			// -----------------------------用户所有表格--------------------------------
			for j := range RecordTimeDict { // 按照表遍历
				table1 := RecordTimeDict[j] + day1
				table2 := RecordTimeDict[j] + day2

				//fmt.Println("day1",day1)
				//fmt.Println("table1",table1)
				//fmt.Println("table2",table2)
				//var dbNow,dbNow2 *sql.DB
				//var dbName string

				//dbNow, dbName := GetMonth(table1,  logDB1,  logDB2)
				//_, dbName2 := GetMonth(table2,  logDB1,  logDB2)

				//fmt.Println("",dbNow)
				//fmt.Println("",dbNow2)

				//// --------------------------这里各个表的所有列名-----------------------
				//tableColumns := fmt.Sprintf(`
				//use %s
				//select stuff((
				//	select
				//		',' + c.name
				//		from sys.tables t with(nolock)
				//		left join sys.columns c with(nolock) on t.object_id=c.object_id
				//		where t.object_id=OBJECT_ID('%s')
				//		order by c.column_id asc
				//		for xml path('')
				//		),1,1,'')  as columns_list;
				//		`, dbName2, table2)
				//
				////fmt.Println(" table:"  ,tableColumns)
				//_, rowsGetColumns, _ := mssql.Query(dbNow2, tableColumns)
				var allKeys string
				//for rowsGetColumns.Next() { // 循环遍历
				//	err := rowsGetColumns.Scan(&allKeys)
				//	if err != nil {
				//		fmt.Printf("  获取列名 id：%d     %s \n ", userInfo.id, err.Error())
				//		fmt.Println("----------------------------------------")
				//		fmt.Println("", tableColumns)
				//		fmt.Println("----------------------------------------")
				//	}
				//	//fmt.Println("", allKeys)
				//}
				//mssql.CloseQuery(rowsGetColumns)
				// ----------------------------开始执行insert------------------------------
				allKeys = GetTableKeys(RecordTimeDict[j])

				// 每个不同的处理方式
				allKeysDeal := GetTableKeysDeal(RecordTimeDict[j], userInfo)

				// 先统一删除数据
				//deleteSql:=  fmt.Sprintf("delete from %s.dbo.%s where UserID = %d ", logDBName2019, table1, userInfo.uid)
				//err,_ := mssql.Exec(logDB2019, deleteSql)
				//if err!= nil{
				//	zLog.PrintfLogger("delete Exec Error %s",err.Error())
				//}

				// 统一的insert语句
				insertSql := fmt.Sprintf("insert into %s.dbo.%s (%s) ", logDBName2019, table1, allKeys)
				selectSql := fmt.Sprintf(" select  %s  from  %s.dbo.%s  WITH(NOLOCK)  where UserID= %d", allKeysDeal, logDBName2019Copy, table2, userInfo.uid2)
				sqlString := insertSql + selectSql
				//zLog.PrintfLogger("sql: %s ",sqlString)
				err,_ = mssql.Exec(logDB2019, sqlString)
				if err!= nil{
					zLog.PrintfLogger("insert Exec Error %s",err.Error())
				}
			}
		}

	}
	mssql.CloseQuery(rows)
	mssql.CloseDB(testDB)
	//mssql.CloseDB(logDB1)
	//mssql.CloseDB(logDB2)
	mssql.CloseDB(logDB2019)

	wg.Done()
}

// 获取当前的月份
func GetMonth(table1 string,  logDB1 *sql.DB, logDB2 *sql.DB) (*sql.DB, string) {
	var dbNow *sql.DB
	var dbName string
	if strings.Contains(table1, "202001") {
		dbNow = logDB1
		dbName = "BY_LOG_202001"
	} else {
		dbNow = logDB2
		dbName = "BY_LOG_202002"
	}
	return dbNow, dbName
}
