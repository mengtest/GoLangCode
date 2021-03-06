package main

import (
	"./mssql"
	"./zLog"
	"database/sql"
	"fmt"
	_ "github.com/denisenkom/go-mssqldb"
	"os"
	"strconv"
	"strings"
)

var (
	userId     = "dbuser"
	password   = "CEDFE2CDA7DB84AC"
	server     = "172.16.140.89"
	logDBName1 = "BY_LOG_202001"
	logDBName2 = "BY_LOG_202002"

	//userIdReadOnly     = "dbuser_ro"
	//passwordReadOnly   = "35A20E7966ECDC93"
	//PlatformDBName   = "PlatformDB_202001"
	DataBaseBYDBName02 = "DataBaseBY_202002"
	DataBaseBYDBName12 = "DataBaseBY_201912"
	TestDBName         = "auditdb"

	//TestDB *sql.DB
)



func DealUserList(idStart int) {
	ItemArray := []int{101,102,103,120,131,151,2007,7003, 108,109,110,111}

	dataBaseArray := make([]UserList,0)

	fmt.Println(" --------------开始连接数据库-------------- ")
	//platformDB := mssql.ConnectDB(userId, password, server, PlatformDBName)
	DataBaseBYDB02 := mssql.ConnectDB(userId, password, server, DataBaseBYDBName02)
	DataBaseBYDB12 := mssql.ConnectDB(userId, password, server, DataBaseBYDBName12)
	logDB1 := mssql.ConnectDB(userId, password, server, logDBName1)
	logDB2 := mssql.ConnectDB(userId, password, server, logDBName2)
	TestDB := mssql.ConnectDB(userId, password, server, TestDBName)


	if logDB2 == nil || logDB1 == nil || TestDB == nil || DataBaseBYDB02 == nil || DataBaseBYDB12 == nil {
		zLog.PrintfLogger("数据库连接出现异常，程序终止")
		os.Exit(0)
	}


	//fmt.Println(" --------------开始查询充值列表--------------")
	//daySecond := 86400		// 一天秒数
	//day110 := 1578585600	// 1月10号
	day1:= Group * idStart
	day2:= Group * (idStart + 1)
	sqlU := fmt.Sprintf("select *  from auditdb.dbo.x2020_user_chongzhi_lerp with(nolock) where id >= %d and id < %d ",day1,day2) // 一天
	//sqlU := fmt.Sprintf("select *  from auditdb.dbo.x2020_user_chongzhi_lerp with(nolock) where UserID = 23489483") // 调试
	//sqlU:= fmt.Sprintf( "select  * from PlatformDB_202002.dbo.PPayCoinOrder_2020 with(nolock) where PayStatus=2 and SuccessTime >= 1578585600 and SuccessTime < 1581264000") // 一个月
	//fmt.Println("sql:",sqlU)
	_, rows, _ := mssql.Query(TestDB, sqlU)

	for rows.Next() { // 循环遍历
		var Info UserList
		err := rows.Scan(&Info.id, &Info.UserId, &Info.registerDate, &Info.lastLoginDate,&Info.kindId,&Info.ClientKind,&Info.channelId) // 赋值到结构体中
		if err != nil {
			zLog.PrintfLogger(" 遍历玩家列表 id %d    , %s \n", Info.id, err)
			continue
		}
		dataBaseArray = append(dataBaseArray, Info) //添加到列表
		//fmt.Println("Info.id",Info.id)

	}
	mssql.CloseQuery(rows)

	//zLog.PrintfLogger(" --------------一共有 : %d  条数据--------------", len(dataBaseArray))
	for _, userInfo := range dataBaseArray{
		//zLog.PrintfLogger(" --------------开始处理index : %d     UserId: %d--------------", index, userInfo.UserId)
		zLog.PrintfLogger(" --------------开始处理id : %d--------------", userInfo.id)

		// -----------------------------获取单个 user 行为------------------------
		//dataTimeStr := time.Unix(int64(userInfo.SuccessTime), 0).Format("2006-01-02 15:04:05")
		dataTimeStr := userInfo.registerDate
		dayString := dataTimeStr[0:10]
		dayStart := strings.Replace(dayString, "-", "", -1) // 去掉-， 整理成表的后缀
		dataTimeStr2 := userInfo.lastLoginDate
		dayString2 := dataTimeStr2[0:10]
		day2 := strings.Replace(dayString2, "-", "", -1) // 去掉-， 整理成表的后缀
		dbNow, dbName := GetMonth(dayStart, logDB1, logDB2)
		//dbNow = dbNow
		//fmt.Println("获取时间戳转日期时间", dataTimeStr)
		//fmt.Println("获取时间戳转日期", dataTimeStr[0:10])
		day1N,_ :=strconv.Atoi(dayStart) // 注册日期
		day2N,_ :=strconv.Atoi(day2)     // 流失日期

		changeScore :=0
		changeDiamond :=0
		changeCoin :=0
		changeLottery := 0

		//----------------------------------头部缝合-----------------------------------

		if day1N < 20200109 {
			//zLog.PrintfLogger("----------------------------------头部缝合----------------------------------- %d",userInfo.UserId)
			// 玩家的注册日期在1月9日之前， 用日志库金额， 要缝合1月9号或者之后的首次记录
			dayStart = "20200109"
			dbNow, dbName = GetMonth(dayStart, logDB1, logDB2)
			forwardScore, recordTimeScore := GetForwardScore(dbName, dayStart,dbNow,  userInfo ,DataBaseBYDB02) // 获取玩家的最终金币数量
			forwardDiamond, recordTimeDiamond := GetForwardDiamond(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB02) // 获取玩家的最终数量
			forwardCoin, recordTimeCoin := GetForwardCoin(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB02) // 获取玩家的最终数量
			forwardLottery, recordTimeLottery := GetForwardLottery(logDBName1, dayStart, logDB1, userInfo,DataBaseBYDB02) // 获取玩家的最终数量

			// 历史遗留数据量
			dayStart = "20200108"
			lastAllScore,_ := GetHistoryScore(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB12) // 获取玩家的历史金币数量
			lastAllDiamond,_ := GetHistoryDiamond(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB12) // 获取玩家的历史数量
			lastAllCoin,_ := GetHistoryCoin(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB12) // 获取玩家的历史数量
			lastAllLottery, _ := GetHistoryLottery(dbName, dayStart, dbNow, userInfo, DataBaseBYDB12) // 获取玩家的历史数量

			// 计算插值
			changeScore = forwardScore - lastAllScore
			changeDiamond = forwardDiamond - lastAllDiamond
			changeCoin = forwardCoin - lastAllCoin
			changeLottery = forwardLottery - lastAllLottery
			//fmt.Println("差额changeScore", changeScore)
			//fmt.Println("差额changeDiamond", changeDiamond)
			//fmt.Println("差额changeCoin", changeCoin)
			//fmt.Println("差额changeLottery", changeLottery)

			if forwardScore == -1 || lastAllScore == -1 {
				// 如果有找不到的情况， 那么就不插入了
				changeScore = 0
			}
			if forwardDiamond == -1 || lastAllDiamond == -1 {
				// 如果有找不到的情况， 那么就不插入了
				changeDiamond = 0
			}
			if forwardCoin == -1 || lastAllCoin == -1 {
				// 如果有找不到的情况， 那么就不插入了
				changeCoin = 0
			}
			if forwardLottery == -1 || lastAllLottery == -1 {
				// 如果有找不到的情况， 那么就不插入了
				changeLottery = 0
			}

			// 进行插入校对
			DealScore(changeScore,userInfo, logDB1 ,recordTimeScore, logDB2, forwardScore, -1)		// 进行修改， 在最终的地方，提前一点，进行缝合
			DealDiamond(changeDiamond,userInfo,logDB1 ,recordTimeDiamond, logDB2, forwardDiamond, -1)		// 进行修改， 在最终的地方，提前一点，进行缝合
			DealCoin(changeCoin,userInfo,logDB1 ,recordTimeCoin, logDB2, forwardCoin, -1)		// 进行修改， 在最终的地方，提前一点，进行缝合
			DealLottery(changeLottery, userInfo, logDB1, recordTimeLottery, logDB2, forwardLottery, -1) // 进行修改， 在最开始的地方，提前一点，进行缝合

			// 集中道具处理
			for _,itemId := range ItemArray{
				dayStart = "20200109"
				dbNow, dbName = GetMonth(dayStart, logDB1, logDB2)
				forwardItem, recordTimeItem := GetForwardItem(dbName, dayStart,dbNow,  userInfo, itemId, DataBaseBYDB02) // 获取玩家的最终数量
				// 历史遗留数据量
				dayStart = "20200108"
				lastAllItem,_ := GetHistoryItem(dbName, dayStart,dbNow,  userInfo, itemId, DataBaseBYDB12) // 获取玩家的历史数量
				changeItem := forwardItem - lastAllItem
				if forwardItem == -1 || lastAllItem == -1 {
					// 如果有找不到的情况， 那么就不插入了
					changeItem = 0
				}
				DealItem(itemId,changeItem,userInfo,logDB1 ,recordTimeItem, logDB2, forwardItem, -1)		// 进行修改， 在最终的地方，提前一点，进行缝合
			}


		}else {
			//  新增注册用户，起始是0  ，不用缝合

		}

		//zLog.PrintfLogger("----------------------------------尾部缝合----------------------------------- %d",userInfo.UserId)
		//----------------------------------尾部缝合-----------------------------------
		forwardScore := 0
		forwardDiamond := 0
		forwardCoin := 0
		forwardLottery := 0
		forwardItemArray := make([]int,0)
		if day2N > 20200209{
			// 玩家在2月10日依然留存， 用日志库金额
			dayStart = "20200210"
			dbNow, dbName = GetMonth(dayStart, logDB1, logDB2)
			forwardScore, _ = GetForwardScore(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB02) // 获取玩家的最终金币数量
			forwardDiamond, _ = GetForwardDiamond(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB02) // 获取玩家的最终数量
			forwardCoin, _ = GetForwardCoin(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB02) // 获取玩家的最终数量
			forwardLottery, _ = GetForwardLottery(logDBName1, dayStart, logDB1, userInfo, DataBaseBYDB02) // 获取玩家的最终数量
			for _,itemId := range ItemArray{
				forwardItem, _ := GetForwardItem(dbName, dayStart,dbNow,  userInfo, itemId, DataBaseBYDB02) // 获取玩家的最终数量
				forwardItemArray = append(forwardItemArray,forwardItem)
			}

			// 历史遗留数据量
			dayStart = "20200209"
		}else{
			// 玩家在2月10日前流失了 ， 玩家的结束金额应该是游戏库金额
			forwardScore,forwardDiamond,forwardCoin = GetDataBaseBY(DataBaseBYDB02,userInfo.UserId) // 玩家最终资源
			forwardLottery = GetDataBaseBYLottery(DataBaseBYDB02, userInfo.UserId)                  // 玩家最终资源

			for _,itemId := range ItemArray{
				forwardItem := GetDataBaseBYItem(DataBaseBYDB02,userInfo.UserId, itemId)
				forwardItemArray = append(forwardItemArray,forwardItem)
			}
			dayStart = day2		// 流失的时候
		}
		// 对尾部数据进行缝合
		lastAllScore,recordTimeScore := GetHistoryScore(dbName, dayStart ,dbNow,  userInfo,DataBaseBYDB12)     // 获取玩家的历史金币数量
		lastAllDiamond,recordTimeDiamond := GetHistoryDiamond(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB12) // 获取玩家的历史数量
		lastAllCoin,recordTimeCoin := GetHistoryCoin(dbName, dayStart,dbNow,  userInfo,DataBaseBYDB12) // 获取玩家的历史数量
		lastAllLottery, recordTimeLottery := GetHistoryLottery(dbName, dayStart, dbNow, userInfo, DataBaseBYDB12) // 获取玩家的历史数量

		//fmt.Println("lastAllScore",recordTimeScore)
		//fmt.Println("lastAllScore",recordTimeDiamond)
		//fmt.Println("lastAllScore",recordTimeCoin)
		//fmt.Println("lastAllScore",recordTimeLottery)



		// 计算插值
		changeScore = forwardScore - lastAllScore
		changeDiamond = forwardDiamond - lastAllDiamond
		changeCoin = forwardCoin - lastAllCoin
		changeLottery = forwardLottery - lastAllLottery
		//fmt.Println("差额", changeScore)

		//fmt.Println("尾部缝合差额changeScore", changeScore)
		//fmt.Println("尾部缝合差额changeDiamond", changeDiamond)
		//fmt.Println("尾部缝合差额changeCoin", changeCoin)
		//fmt.Println("尾部缝合差额changeLottery", changeLottery)


		if forwardScore == -1 || lastAllScore == -1 {
			// 如果有找不到的情况， 那么就不插入了
			changeScore = 0
		}
		if forwardDiamond == -1 || lastAllDiamond == -1 {
			// 如果有找不到的情况， 那么就不插入了
			changeDiamond = 0
		}
		if forwardCoin == -1 || lastAllCoin == -1 {
			// 如果有找不到的情况， 那么就不插入了
			changeCoin = 0
		}
		if forwardLottery == -1 || lastAllLottery == -1 {
			// 如果有找不到的情况， 那么就不插入了
			changeLottery = 0
		}

		// 进行插入校对
		DealScore(changeScore,userInfo,logDB1 ,recordTimeScore, logDB2, forwardScore,1)		// 进行修改，在最后的记录上，增加一点时间进行缝合
		DealDiamond(changeDiamond,userInfo,logDB1 ,recordTimeDiamond, logDB2, forwardDiamond, 1)		// 进行修改， 在最终的地方，提前一点，进行缝合
		DealCoin(changeCoin,userInfo,logDB1 ,recordTimeCoin, logDB2, forwardCoin, 1)		// 进行修改， 在最终的地方，提前一点，进行缝合
		DealLottery(changeLottery, userInfo, logDB1, recordTimeLottery, logDB2, forwardLottery, 1)             // 进行修改，在最后的记录上，增加一点时间进行缝合

		// 集中处理道具
		for index,itemId := range ItemArray{
			lastAllItem,recordTimeItem := GetHistoryItem(dbName, dayStart,dbNow,  userInfo, itemId, DataBaseBYDB12) // 获取玩家的历史数量
			changeItem := forwardItemArray[index] - lastAllItem
			//fmt.Println("尾部缝合差额changeItem", changeItem)
			if forwardItemArray[index] == -1 || lastAllItem == -1 {
				// 如果有找不到的情况， 那么就不插入了
				changeItem = 0
			}
			DealItem(itemId,changeItem,userInfo,logDB1 ,recordTimeItem, logDB2, forwardItemArray[index], 1)		// 进行修改， 在最终的地方，提前一点，进行缝合
		}

	}
	//mssql.CloseDB(platformDB)
	mssql.CloseDB(DataBaseBYDB02)
	mssql.CloseDB(DataBaseBYDB12)
	mssql.CloseDB(logDB1)
	mssql.CloseDB(logDB2)
	mssql.CloseDB(TestDB)

	wg.Done()
}

// 获取当前的月份
func GetMonth(table1 string, logDB1 *sql.DB, logDB2 *sql.DB) (*sql.DB, string) {
	var dbNow *sql.DB
	var dbName string
	if strings.Contains(table1, "202002") {
		dbNow = logDB2
		dbName = "BY_LOG_202002"
	} else {
		dbNow = logDB1
		dbName = "BY_LOG_202001"
	}
	return dbNow, dbName
}


func GetDBNow(dataTimeStr string, logDB1 *sql.DB, logDB2 *sql.DB) (string, *sql.DB, string) {
	dayString := dataTimeStr[0:10]
	day1 := strings.Replace(dayString, "-", "", -1) // 去掉-， 整理成表的后缀
	dbNow, dbName := GetMonth(day1, logDB1, logDB2)
	return day1, dbNow, dbName
}

// 对时间进行检查防止前后越界
func CheckDataTimeStr(nowDataTimeStr string,userInfo UserList) string {
	dataTimeStr := userInfo.registerDate
	dayString := dataTimeStr[0:10]
	dayStart := strings.Replace(dayString, "-", "", -1) // 去掉-， 整理成表的后缀
	dataTimeStr2 := userInfo.lastLoginDate
	dayString2 := dataTimeStr2[0:10]
	day2 := strings.Replace(dayString2, "-", "", -1) // 去掉-， 整理成表的后缀
	//dbNow, dbName := GetMonth(dayStart, logDB1, logDB2)
	//dbNow = dbNow
	//fmt.Println("获取时间戳转日期时间", dataTimeStr)
	//fmt.Println("获取时间戳转日期", dataTimeStr[0:10])
	day1N,_ :=strconv.Atoi(dayStart) // 注册日期
	day2N,_ :=strconv.Atoi(day2)     // 流失日期


	nowDayString := nowDataTimeStr[0:10]
	dayOff := nowDataTimeStr[11:]
	//fmt.Println("dayString",dayString)
	//fmt.Println("dayOff",dayOff)
	day1 := strings.Replace(nowDayString, "-", "", -1) // 去掉-， 整理成表的后缀
	dayNow, _ := strconv.Atoi(day1)
	if dayNow < 20200109 {
		dayNow = 20200109
		nowDayString = "2020-01-09"
	}
	if dayNow > 20200209 {
		dayNow = 20200209
		nowDayString = "2020-02-09"
	}
	result := nowDayString + " " + dayOff

	//  追加判断是否在用户存活期间

	if dayNow < day1N {
		result = userInfo.registerDate
	}
	if dayNow > day2N{
		result = userInfo.lastLoginDate
	}

	//fmt.Println("0000000000000000000000000000=============", result)
	//os.Exit(0)
	return result[:19]

}

// 做平金币
func DealScore(score int,userInfo UserList, logDB1 *sql.DB, dataTimeStr string, logDB2  *sql.DB,  lastAllScore int , addTime int)  {
	if score == 0 {
		return
	}
	if dataTimeStr == ""{
		zLog.PrintfLogger(" 没有插入的时间，没有找到记录, userId: %d  id :%d  addTime: %d", userInfo.UserId, userInfo.id, addTime)
		return
	}
	dataTimeStr = CheckDataTimeStr(dataTimeStr,userInfo)
	dayStart, dbNow, dbName := GetDBNow(dataTimeStr, logDB1, logDB2)
	if score > 0 {
		GetScoreAddSql(userInfo, score, dbNow, dataTimeStr, dbName, dayStart, lastAllScore, addTime)
	}
	if score < 0 {
		GetScoreReduceSql(userInfo, score, dbNow, dataTimeStr, dbName, dayStart, lastAllScore, addTime)
	}
}

// 做平diamond
func DealDiamond(diamond int,userInfo UserList, logDB1 *sql.DB, dataTimeStr string, logDB2  *sql.DB, lastAllDiamond int , addTime int)  {
	if diamond == 0 {
		return
	}
	if dataTimeStr == ""{
		zLog.PrintfLogger(" 没有插入的时间，没有找到记录, userId: %d  id :%d  addTime: %d", userInfo.UserId, userInfo.id, addTime)
		return
	}
	dataTimeStr = CheckDataTimeStr(dataTimeStr,userInfo)
	dayStart, dbNow, dbName := GetDBNow(dataTimeStr, logDB1, logDB2)
	if diamond >0 {
		GetDiamondAddSql(userInfo , diamond, dbNow ,dataTimeStr ,dbName , dayStart , lastAllDiamond,addTime)
	}
	if diamond <0 {
		GetDiamondReduceSql(userInfo, diamond, dbNow, dataTimeStr, dbName, dayStart, lastAllDiamond,addTime)
	}
}
// 做平coin
func DealCoin(coin int,userInfo UserList, logDB1 *sql.DB, dataTimeStr string, logDB2  *sql.DB, lastAllCoin int , addTime int)  {
	if coin == 0 {
		return
	}
	if dataTimeStr == ""{
		zLog.PrintfLogger(" 没有插入的时间，没有找到记录, userId: %d  id :%d  addTime: %d", userInfo.UserId, userInfo.id, addTime)
		return
	}
	dataTimeStr = CheckDataTimeStr(dataTimeStr,userInfo)
	dayStart, dbNow, dbName := GetDBNow(dataTimeStr, logDB1, logDB2)
	if coin >0 {
		GetCoinAddSql(userInfo , coin, dbNow ,dataTimeStr ,dbName , dayStart , lastAllCoin,addTime)
	}
	if coin <0 {
		GetCoinReduceSql(userInfo, coin, dbNow, dataTimeStr, dbName, dayStart, lastAllCoin,addTime)
	}
}
// 做平道具
func DealItem(ItemId int,ItemNum int,userInfo UserList, logDB1 *sql.DB, dataTimeStr string, logDB2  *sql.DB, lastAllItem int , addTime int)  {
	if ItemNum == 0 {
		return
	}
	if dataTimeStr == ""{
		zLog.PrintfLogger(" 没有插入的时间，没有找到记录, userId: %d  id :%d  itemId:%d   addTime: %d", userInfo.UserId, userInfo.id, ItemId, addTime)
		return
	}
	dataTimeStr = CheckDataTimeStr(dataTimeStr,userInfo)
	dayStart, dbNow, dbName := GetDBNow(dataTimeStr, logDB1, logDB2)
	if ItemNum >0 {
		GetItemAddSql(userInfo ,ItemId, ItemNum, dbNow ,dataTimeStr ,dbName , dayStart , lastAllItem,addTime)
	}
	if ItemNum <0 {
		GetItemReduceSql(userInfo, ItemId,ItemNum, dbNow, dataTimeStr, dbName, dayStart, lastAllItem,addTime)
	}
}


// 做平Lottery
func DealLottery(Lottery int, userInfo UserList, logDB1 *sql.DB, dataTimeStr string, logDB2 *sql.DB, lastAllLottery int, addTime int) {
	if Lottery == 0 {
		return
	}
	if dataTimeStr == "" {
		zLog.PrintfLogger(" 没有插入的时间，没有找到记录, userId: %d  id :%d  addTime: %d", userInfo.UserId, userInfo.id, addTime)
		return
	}
	dataTimeStr = CheckDataTimeStr(dataTimeStr,userInfo)
	dayStart, dbNow, dbName := GetDBNow(dataTimeStr, logDB1, logDB2)
	if Lottery > 0 {
		GetLotteryAddSql(userInfo, Lottery, dbNow, dataTimeStr, dbName, dayStart, lastAllLottery, addTime)
	}
	if Lottery < 0 {
		GetLotteryReduceSql(userInfo, Lottery, dbNow, dataTimeStr, dbName, dayStart, lastAllLottery, addTime)
	}
}

// 获取游戏库资源
func GetDataBaseBY(dbNow *sql.DB, userId int )  (int,int,int){

	sqlStr := fmt.Sprintf("select top(1)Score,Diamond,Coin from dbo.GameScoreInfo where UserID = %d ",  userId)
	//zLog.PrintfLogger("获取uid:%d  游戏库资源sql: %s ", userId, sqlStr)

	_, rows, _ := mssql.Query(dbNow, sqlStr)
	for rows.Next() { // 循环遍历
		var Score int
		var Diamond int
		var Coin int
		err := rows.Scan(&Score,&Diamond,&Coin)
		if err != nil {
			zLog.PrintfLogger(" %d 游戏库资源 , %s \n", userId,  err)
			continue
		}
		//if Score >= 0 {
		//	zLog.PrintfLogger("userId : %d,     id:%d 获取数量： %d", userId,   itemId, Score)
			mssql.CloseQuery(rows)
			return Score, Diamond,Coin
		//}
	}
	//mssql.CloseQuery(rows)
	//return Score, Diamond,Coin
	return 0, 0, 0
}

// 获取游戏库资源Lottery
func GetDataBaseBYLottery(dbNow *sql.DB, userId int) int {

	sqlStr := fmt.Sprintf("select top(1)Lottery from dbo.GameLotteryInfo where UserID = %d ", userId)
	//zLog.PrintfLogger("获取uid:%d  游戏库资源sql: %s ", userId, sqlStr)

	_, rows, _ := mssql.Query(dbNow, sqlStr)
	for rows.Next() { // 循环遍历
		var Score int
		err := rows.Scan(&Score)
		if err != nil {
			zLog.PrintfLogger(" %d 游戏库资源 , %s \n", userId, err)
			continue
		}
		mssql.CloseQuery(rows)
		return Score
	}
	mssql.CloseQuery(rows)
	return 0
}
// 获取游戏库资源
func GetDataBaseBYItem(dbNow *sql.DB, userId int ,itemId int)  int{
	sqlStr := fmt.Sprintf("select top(1)Total,Used from dbo.UserSkillInfo where UserID = %d and ItemID = %d",  userId,itemId)
	//zLog.PrintfLogger("获取uid:%d  游戏库资源sql: %s ", userId, sqlStr)

	_, rows, _ := mssql.Query(dbNow, sqlStr)
	for rows.Next() { // 循环遍历
		var Num int
		var total int
		var used int
		err := rows.Scan(&total,&used)
		if err != nil {
			zLog.PrintfLogger(" %d 游戏库资源    , %s \n", userId,  err)
			continue
		}
		Num = total - used
	//if Num >= 0 {
	//		zLog.PrintfLogger("userId : %d,    id:%d 获取数量： %d", userId,  itemId, Num)
			mssql.CloseQuery(rows)
			return Num
		//}
	}
return 0

}