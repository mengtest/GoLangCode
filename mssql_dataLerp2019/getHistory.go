package main

import (
	"./mssql"
	"./zLog"
	"database/sql"
	"fmt"
	"strconv"
)

//遗留分数
func GetHistoryScore( dbName string, day1 string ,dbNow *sql.DB,  rechargeInfo UserList, LogDB *sql.DB ,gameDB *sql.DB) (int,string) {
	return GetHistory(dbName,day1,dbNow,rechargeInfo.UserId,"GameScoreChangeRecord","Score", rechargeInfo.id,0,LogDB ,gameDB)
}

//遗留钻石
func GetHistoryDiamond( dbName string, day1 string ,dbNow *sql.DB,  rechargeInfo UserList, LogDB *sql.DB,gameDB *sql.DB) (int,string) {
	return GetHistory(dbName,day1,dbNow,rechargeInfo.UserId,"GameDiamondChangeRecord","Diamond", rechargeInfo.id,0,LogDB ,gameDB)
}
//遗留灵力
func GetHistoryCoin( dbName string, day1 string ,dbNow *sql.DB,  rechargeInfo UserList, LogDB *sql.DB,gameDB *sql.DB) (int,string) {
	return GetHistory(dbName,day1,dbNow,rechargeInfo.UserId,"GameCoinChangeRecord","Coin", rechargeInfo.id,0,LogDB ,gameDB)
}
//遗留Lottery
func GetHistoryLottery( dbName string, day1 string ,dbNow *sql.DB,  rechargeInfo UserList, LogDB *sql.DB,gameDB *sql.DB) (int,string) {
	return GetHistory(dbName,day1,dbNow,rechargeInfo.UserId,"GameLotteryChangeRecord","Lottery", rechargeInfo.id,0,LogDB ,gameDB)
}
//遗留道具
func GetHistoryItem( dbName string, day1 string ,dbNow *sql.DB,  rechargeInfo UserList, itemId int, LogDB *sql.DB,gameDB *sql.DB) (int,string) {
	return GetHistory(dbName,day1,dbNow,rechargeInfo.UserId,"GameItemChangeRecord","ItemIndbNum", rechargeInfo.id,itemId,LogDB ,gameDB)
}


// 获取历史遗留
func GetHistory( dbName string, day1 string , dbGame04 *sql.DB, userId int, tableNameT string, keyName string ,  rechargeId int, itemId int, LogDB *sql.DB, gameDB03 *sql.DB) (int,string) {
	dbNow:= dbGame04
	dayInt,_ := strconv.Atoi(day1)
	tableName := ""

	endTime := "2019-04-01 00:00:00"
	for i:=60;i>0;i-- {

		//num := dayInt - 20200210
		if dayInt==20190400{
			forwardScore,forwardDiamond,forwardCoin := GetDataBaseBY(gameDB03, userId)
			forwardItem := 0
			if itemId>0 {
				forwardItem = GetDataBaseBYItem(gameDB03,userId, itemId)
			}
			forwardLottery := GetDataBaseBYLottery(gameDB03, userId)
			switch keyName {
			case "Lottery":
				return forwardLottery,endTime
			case "Score":
				//zLog.PrintfLogger(" score %d ", forwardScore)
				return forwardScore,endTime
			case "Diamond":
				//zLog.PrintfLogger(" Diamond %d ", forwardDiamond)
				return forwardDiamond,endTime
			case "Coin":
				//zLog.PrintfLogger(" Coin %d ", forwardCoin)
				return forwardCoin,endTime
			case "ItemIndbNum":
				//zLog.PrintfLogger(" ItemIndbNum %d ", forwardItem)
				return forwardItem,endTime
			}

			//zLog.PrintfLogger(" 没有找到 %d ", 0)
			//InsertUserIdWhenCanNotFindOut(userId,keyName, rechargeId,LogDB,itemId)
			return -1,""
		//	dayInt = 20190331	// 跳到1月份
		//}
		//if dayInt == 20190321{
		//	//zLog.PrintfLogger(" dayInt 太往前了，已经要搜到3月21日了, userid: %d  id :%d ", userId, rechargeId)
		//	//InsertUserIdWhenCanNotFindOut(userId,keyName, rechargeId,TestDB,itemId)
		//	return -1,""
		//	//dayInt = 20191230	// 跳到12月份
		}
		tableName = fmt.Sprintf("%s.dbo.%s_%d", dbName, tableNameT,dayInt)
		if dayInt > 20190408{
			// 如果是2019年4月8日之后的数据， 查log库
			tableName = fmt.Sprintf("BY_LOG_201905.dbo.%s_%d",  tableNameT, dayInt)
			dbNow = LogDB
		}
		//if dayInt < 20200100{
		//	tableName = fmt.Sprintf("BY_LOG_201912.dbo.%s_%d",  tableNameT, dayInt)
		//}
		//if dayInt == 20191200{
		//	zLog.PrintfLogger(" dayInt 太往前了，已经要搜到11月份了, userid: %d  id :%d", userId,rechargeId)
		//	InsertUserIdWhenCanNotFindOut(userId,keyName, rechargeId)
		//	return 0
		//}
		dayInt--

		itemAdd :=""
		if itemId>0 {
			itemAdd = fmt.Sprintf(" and ItemID = %d ",itemId)
		}
		sqlStr := fmt.Sprintf("select top(1)%s,RecordTime from %s where RecordTime = (select max(RecordTime) from %s where UserID = %d %s) and UserID = %d %s", keyName,tableName, tableName, userId, itemAdd, userId,itemAdd)
		//zLog.PrintfLogger("获取%s历史sql: %s ", keyName, sqlStr)

		_, rows, _ := mssql.Query(dbNow, sqlStr)
		for rows.Next() { // 循环遍历
			var result int
			var recordTime string
			err := rows.Scan(&result,&recordTime)
			if err != nil {
				zLog.PrintfLogger(" %s历史遗留表 结果 %d  报错：  %s \n", keyName, result, err)
				continue
			}
			//if result >= 0 {
			//	zLog.PrintfLogger("userid : %d,   %s   id:%d 获取数量： %d", userId,  keyName, itemId, result)
				mssql.CloseQuery(rows)
				return result,recordTime
			//}
		}
		mssql.CloseQuery(rows)
	}
	return 0,""
}


// 把没有找到数据的玩家uid insert到表中
func InsertUserIdWhenCanNotFindOut(userId int, keyName string, id int,TestDB *sql.DB, itemId int)  {
	if TestDB == nil{
		return
	}

	sqlStr := fmt.Sprintf("insert into dbo.can_not_find_last_%s(userId,id) values (%d,%d)", keyName, userId, id)
	if itemId>0 {
		sqlStr = fmt.Sprintf("insert into dbo.can_not_find_last_%s(userId,id,itemId) values (%d,%d,%d)", keyName, userId, id, itemId)
	}
	err,_ :=mssql.Exec(TestDB, sqlStr)
	if err!= nil{
		zLog.PrintfLogger(" 没有找到数据的玩家 insert   uid: %d    id: %d ,   %s \n", userId,id, err)
	}
}
