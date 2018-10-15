package Lua

import (
	"github.com/yuin/gopher-lua"
	"os"
	"bufio"
	"github.com/yuin/gopher-lua/parse"
	"fmt"
	"../GlobalVar"
)
//--------------------------------------------------------------------------------
// lua的接口，包含热更新
//--------------------------------------------------------------------------------


var LuaConnectMyServer map[*lua.LState]*MyServer	// 将lua的句柄跟对应的服务器句柄进行一个哈希，方便以后的lua发送时候回调

type MyLua struct {
	L *lua.LState
}


func NewMyLua() *MyLua {
	l := lua.NewState()
	return &MyLua{L:l}
}

// --------------------全局变量初始化--------------------------
func InitGlobalVar()  {
	LuaConnectMyServer = make(map[* lua.LState]*MyServer)
}



//----------------------对象个体初始化-----------------------
func (m *MyLua)Init()   {
	//L := luaPool.Get()		// 这是用池的方式， 但是玩家数据需要清理重置，以后再考虑吧
	//defer luaPool.Put(L)

	m.InitResister() // 这里是统一的lua函数注册入口

	DoCompiledFile(m.L, GlobalVar.LuaCodeToShare)
	//return m.L
}


//------------------编译lua文件------------------------------
// CompileLua reads the passed lua file from disk and compiles it.
func CompileLua(filePath string) (*lua.FunctionProto, error) {
	file, err := os.Open(filePath)
	defer file.Close()
	if err != nil {
		return nil, err
	}
	reader := bufio.NewReader(file)
	chunk, err := parse.Parse(reader, filePath)
	if err != nil {
		return nil, err
	}
	proto, err := lua.Compile(chunk, filePath)
	if err != nil {
		return nil, err
	}
	return proto, nil
}

// DoCompiledFile takes a FunctionProto, as returned by CompileLua, and runs it in the LState. It is equivalent
// to calling DoFile on the LState with the original source file.
func DoCompiledFile(L *lua.LState, proto *lua.FunctionProto) error {
	lFunc := L.NewFunctionFromProto(proto)
	L.Push(lFunc)
	return L.PCall(0, lua.MultRet, nil)
}


// ----------------------Lua重新加载，Lua的热更新按钮----------------------------------------
func (m *MyLua)GoCallLuaReload() error {
	//fmt.Println("----------lua reload--------------")
	var err error
	err = m.L.CallByParam(lua.P{
		Fn: m.L.GetGlobal("ReloadAll"), //reloadUp  ReloadAll
		NRet: 0,
		Protect: true,
	})
	if err != nil {
		fmt.Println("热更新出错 ",err.Error())
	}
	return err
}

//-----------------------lua 对应的类型列表------------------------------
//Type name	Go type	Type() value	Constants
//LNilType	(constants)	LTNil	LNil
//LBool	(constants)	LTBool	LTrue, LFalse
//LNumber	float64	LTNumber	-
//LString	string	LTString	-
//LFunction	struct pointer	LTFunction	-
//LUserData	struct pointer	LTUserData	-
//LState	struct pointer	LTThread	-
//LTable	struct pointer	LTTable	-
//LChannel	chan LValue	LTChannel	-


