---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Administrator.
--- DateTime: 2018/12/7 15:32
---


-----------------------DIR-------------------------
RedisDirAllPlayersUUID = "TB:TB_AllPlayers_UUID:"                         -- 所有玩家UUID
--RedisDirServerState = "BY_ServerState:"         -- 各个服务器状态 多少个桌子，多少玩家在线， 网络情况，1分钟记录一次，永久记忆
--RedisDirGameState = "BY_GameState:"                          -- 当前各个服务器，各个游戏的状态，多少鱼，多少子弹，多少椅子有人


RedisDirAllPlayers = "TB:TB_AllPlayers:"                         -- 所有玩家列表
RedisDirAllPlayersLogin = "TB:TB_AllPlayers_OpenId_Uid:"                         -- 所有玩家登录列表
RedisDirSystemTip = "TB:TB_GameManager:GameTip"                         -- 跑马灯
RedisDirSystemMail = "TB:TB_GameManager:GameMail"                         -- 邮件

RedisDirSystemLuckyWheel = "TB:TB_GameManager:GameLuckyWheel"                         -- 幸运轮盘中奖记录

RedisDirStatisticAllPlayerLogin = "TB:StatisticAllPlayerLogin:"                         -- 所有玩家登录的统计，包括，新增，留存，回归，活跃等  , 里面按照日期存，  每个日期是一个json

