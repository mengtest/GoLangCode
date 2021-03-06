package Lua

import (
	"github.com/yuin/gopher-lua"
	"fmt"
)

//--------------------------------------------------------------------------------
// go 调用 lua的函数
//--------------------------------------------------------------------------------

// ----------------测试用例--------------------------------
func GoCallLuaTest(L *lua.LState, num int)  {
	// 这里是go调用lua的函数
	if err := L.CallByParam(lua.P{
		Fn: L.GetGlobal("Zsw2"),		// lua的函数名字
		NRet: 2,
		Protect: true,
	}, lua.LNumber(num),lua.LNumber(num)); err != nil {		// 参数
		fmt.Println("---------------")
		fmt.Println("",err.Error())
		fmt.Println("----------------")
	}

	ret := L.Get(1) // returned value
	fmt.Println("lua return: ",ret)
	ret = L.Get(2) // returned value
	fmt.Println("lua return: ",ret)
	L.Pop(1)  // remove received value
	L.Pop(1)  // remove received value
}

// -------------------go触发lua函数，不带参数和返回值-------------------
func (m *MyLua) GoCallLuaLogic(funcName string) {
	if err := m.L.CallByParam(lua.P{
		Fn: m.L.GetGlobal(funcName),		// lua的函数名字
		NRet: 0,
		Protect: true,
	}); err != nil {		// 参数
		fmt.Println("GoCallLuaLogic error :",funcName, "      ",err.Error())
	}
}

// -------------------go传递接收到的网络数据包给lua-------------------
func (m *MyLua)GoCallLuaNetWorkReceive(msgId int , subMsgId int ,buf string) {
	if err := m.L.CallByParam(lua.P{
		Fn: m.L.GetGlobal("GoCallLuaNetWorkReceive"),		// lua的函数名字
		NRet: 0,
		Protect: true,
	}, lua.LNumber(msgId), lua.LNumber(subMsgId), lua.LString(buf)); err != nil {		// 参数
		fmt.Println("GoCallLuaNetWorkReceive  error :",msgId , subMsgId, buf, "      ",err.Error())
	}
}

// ------------------------go 给lua传递 1个 int-----------------------------------------------
func (m *MyLua) GoCallLuaLogicInt(funcName string,ii int) {
	if err := m.L.CallByParam(lua.P{
		Fn: m.L.GetGlobal(funcName),		// lua的函数名字
		NRet: 0,
		Protect: true,
	},lua.LNumber(ii)); err != nil {		// 参数
		fmt.Println("GoCallLuaLogicInt error :", funcName ,"      ",err.Error())
	}
}
