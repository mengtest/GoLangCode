// Code generated by protoc-gen-go. DO NOT EDIT.
// source: CMD_SHZ_Game.CMD

/*
Package CMD_SHZ is a generated protocol buffer package.

Namespace: MESSAGE

It is generated from these files:
	CMD_SHZ_Game.CMD

It has these top-level messages:
	CMD_S_ERROR
	CMD_C_MainGameStart
	TagLineInfo
	CMD_S_MainGameResult
	CMD_C_DiceGameStart
	CMD_S_DiceGameResult
	CMD_C_MaryGameStart
	TagMaryGameResult
	CMD_S_MaryGameResult
	CMD_C_SwitchGame
	CMD_S_UpdateGameScene
*/
package CMD_SHZ

import proto "github.com/golang/protobuf/proto"
import fmt "fmt"
import math "math"

// Reference imports to suppress errors if they are not otherwise used.
var _ = proto.Marshal
var _ = fmt.Errorf
var _ = math.Inf

// This is a compile-time assertion to ensure that this generated file
// is compatible with the CMD package it is being compiled against.
// A compilation error at this line likely means your copy of the
// CMD package needs to be updated.
const _ = proto.ProtoPackageIsVersion2 // please upgrade the CMD package

type CMD_S_ERROR struct {
	Err              *int32 `protobuf:"varint,1,opt,name=err" json:"err,omitempty"`
	XXX_unrecognized []byte `json:"-"`
}

func (m *CMD_S_ERROR) Reset()                    { *m = CMD_S_ERROR{} }
func (m *CMD_S_ERROR) String() string            { return proto.CompactTextString(m) }
func (*CMD_S_ERROR) ProtoMessage()               {}
func (*CMD_S_ERROR) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{0} }

func (m *CMD_S_ERROR) GetErr() int32 {
	if m != nil && m.Err != nil {
		return *m.Err
	}
	return 0
}

type CMD_C_MainGameStart struct {
	BetScore         *int64  `protobuf:"varint,1,opt,name=bet_score,json=betScore" json:"bet_score,omitempty"`
	LineCount        *uint32 `protobuf:"varint,2,opt,name=line_count,json=lineCount" json:"line_count,omitempty"`
	XXX_unrecognized []byte  `json:"-"`
}

func (m *CMD_C_MainGameStart) Reset()                    { *m = CMD_C_MainGameStart{} }
func (m *CMD_C_MainGameStart) String() string            { return proto.CompactTextString(m) }
func (*CMD_C_MainGameStart) ProtoMessage()               {}
func (*CMD_C_MainGameStart) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{1} }

func (m *CMD_C_MainGameStart) GetBetScore() int64 {
	if m != nil && m.BetScore != nil {
		return *m.BetScore
	}
	return 0
}

func (m *CMD_C_MainGameStart) GetLineCount() uint32 {
	if m != nil && m.LineCount != nil {
		return *m.LineCount
	}
	return 0
}

type TagLineInfo struct {
	LineId           *int32  `protobuf:"varint,1,opt,name=line_id,json=lineId" json:"line_id,omitempty"`
	IconIndex        []int32 `protobuf:"varint,2,rep,name=icon_index,json=iconIndex" json:"icon_index,omitempty"`
	Multiple         *int32  `protobuf:"varint,3,opt,name=multiple" json:"multiple,omitempty"`
	XXX_unrecognized []byte  `json:"-"`
}

func (m *TagLineInfo) Reset()                    { *m = TagLineInfo{} }
func (m *TagLineInfo) String() string            { return proto.CompactTextString(m) }
func (*TagLineInfo) ProtoMessage()               {}
func (*TagLineInfo) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{2} }

func (m *TagLineInfo) GetLineId() int32 {
	if m != nil && m.LineId != nil {
		return *m.LineId
	}
	return 0
}

func (m *TagLineInfo) GetIconIndex() []int32 {
	if m != nil {
		return m.IconIndex
	}
	return nil
}

func (m *TagLineInfo) GetMultiple() int32 {
	if m != nil && m.Multiple != nil {
		return *m.Multiple
	}
	return 0
}

type CMD_S_MainGameResult struct {
	BetScore          *int64         `protobuf:"varint,1,opt,name=bet_score,json=betScore" json:"bet_score,omitempty"`
	LineCount         *uint32        `protobuf:"varint,2,opt,name=line_count,json=lineCount" json:"line_count,omitempty"`
	WinScore          *int64         `protobuf:"varint,3,opt,name=win_score,json=winScore" json:"win_score,omitempty"`
	ResultType        *int32         `protobuf:"varint,4,opt,name=result_type,json=resultType" json:"result_type,omitempty"`
	BonusGameCount    *uint32        `protobuf:"varint,5,opt,name=bonus_game_count,json=bonusGameCount" json:"bonus_game_count,omitempty"`
	ResultIcon        []int32        `protobuf:"varint,6,rep,name=result_icon,json=resultIcon" json:"result_icon,omitempty"`
	ResultLine        []*TagLineInfo `protobuf:"bytes,7,rep,name=result_line,json=resultLine" json:"result_line,omitempty"`
	PersonalPrizePool *int64         `protobuf:"varint,8,opt,name=personal_prize_pool,json=personalPrizePool" json:"personal_prize_pool,omitempty"`
	XXX_unrecognized  []byte         `json:"-"`
}

func (m *CMD_S_MainGameResult) Reset()                    { *m = CMD_S_MainGameResult{} }
func (m *CMD_S_MainGameResult) String() string            { return proto.CompactTextString(m) }
func (*CMD_S_MainGameResult) ProtoMessage()               {}
func (*CMD_S_MainGameResult) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{3} }

func (m *CMD_S_MainGameResult) GetBetScore() int64 {
	if m != nil && m.BetScore != nil {
		return *m.BetScore
	}
	return 0
}

func (m *CMD_S_MainGameResult) GetLineCount() uint32 {
	if m != nil && m.LineCount != nil {
		return *m.LineCount
	}
	return 0
}

func (m *CMD_S_MainGameResult) GetWinScore() int64 {
	if m != nil && m.WinScore != nil {
		return *m.WinScore
	}
	return 0
}

func (m *CMD_S_MainGameResult) GetResultType() int32 {
	if m != nil && m.ResultType != nil {
		return *m.ResultType
	}
	return 0
}

func (m *CMD_S_MainGameResult) GetBonusGameCount() uint32 {
	if m != nil && m.BonusGameCount != nil {
		return *m.BonusGameCount
	}
	return 0
}

func (m *CMD_S_MainGameResult) GetResultIcon() []int32 {
	if m != nil {
		return m.ResultIcon
	}
	return nil
}

func (m *CMD_S_MainGameResult) GetResultLine() []*TagLineInfo {
	if m != nil {
		return m.ResultLine
	}
	return nil
}

func (m *CMD_S_MainGameResult) GetPersonalPrizePool() int64 {
	if m != nil && m.PersonalPrizePool != nil {
		return *m.PersonalPrizePool
	}
	return 0
}

type CMD_C_DiceGameStart struct {
	BetScore         *int64  `protobuf:"varint,1,opt,name=bet_score,json=betScore" json:"bet_score,omitempty"`
	BetType          *uint32 `protobuf:"varint,2,opt,name=bet_type,json=betType" json:"bet_type,omitempty"`
	XXX_unrecognized []byte  `json:"-"`
}

func (m *CMD_C_DiceGameStart) Reset()                    { *m = CMD_C_DiceGameStart{} }
func (m *CMD_C_DiceGameStart) String() string            { return proto.CompactTextString(m) }
func (*CMD_C_DiceGameStart) ProtoMessage()               {}
func (*CMD_C_DiceGameStart) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{4} }

func (m *CMD_C_DiceGameStart) GetBetScore() int64 {
	if m != nil && m.BetScore != nil {
		return *m.BetScore
	}
	return 0
}

func (m *CMD_C_DiceGameStart) GetBetType() uint32 {
	if m != nil && m.BetType != nil {
		return *m.BetType
	}
	return 0
}

type CMD_S_DiceGameResult struct {
	BetScore         *int64 `protobuf:"varint,1,opt,name=bet_score,json=betScore" json:"bet_score,omitempty"`
	BetType          *int32 `protobuf:"varint,2,opt,name=bet_type,json=betType" json:"bet_type,omitempty"`
	DicePoint        *int32 `protobuf:"varint,3,opt,name=dice_point,json=dicePoint" json:"dice_point,omitempty"`
	WinScore         *int64 `protobuf:"varint,4,opt,name=win_score,json=winScore" json:"win_score,omitempty"`
	XXX_unrecognized []byte `json:"-"`
}

func (m *CMD_S_DiceGameResult) Reset()                    { *m = CMD_S_DiceGameResult{} }
func (m *CMD_S_DiceGameResult) String() string            { return proto.CompactTextString(m) }
func (*CMD_S_DiceGameResult) ProtoMessage()               {}
func (*CMD_S_DiceGameResult) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{5} }

func (m *CMD_S_DiceGameResult) GetBetScore() int64 {
	if m != nil && m.BetScore != nil {
		return *m.BetScore
	}
	return 0
}

func (m *CMD_S_DiceGameResult) GetBetType() int32 {
	if m != nil && m.BetType != nil {
		return *m.BetType
	}
	return 0
}

func (m *CMD_S_DiceGameResult) GetDicePoint() int32 {
	if m != nil && m.DicePoint != nil {
		return *m.DicePoint
	}
	return 0
}

func (m *CMD_S_DiceGameResult) GetWinScore() int64 {
	if m != nil && m.WinScore != nil {
		return *m.WinScore
	}
	return 0
}

type CMD_C_MaryGameStart struct {
	XXX_unrecognized []byte `json:"-"`
}

func (m *CMD_C_MaryGameStart) Reset()                    { *m = CMD_C_MaryGameStart{} }
func (m *CMD_C_MaryGameStart) String() string            { return proto.CompactTextString(m) }
func (*CMD_C_MaryGameStart) ProtoMessage()               {}
func (*CMD_C_MaryGameStart) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{6} }

type TagMaryGameResult struct {
	WinScore         *int64  `protobuf:"varint,1,opt,name=win_score,json=winScore" json:"win_score,omitempty"`
	CurrGameCount    *uint32 `protobuf:"varint,2,opt,name=curr_game_count,json=currGameCount" json:"curr_game_count,omitempty"`
	CenterIcon       []int32 `protobuf:"varint,3,rep,name=center_icon,json=centerIcon" json:"center_icon,omitempty"`
	ResultIcon       *int32  `protobuf:"varint,4,opt,name=result_icon,json=resultIcon" json:"result_icon,omitempty"`
	XXX_unrecognized []byte  `json:"-"`
}

func (m *TagMaryGameResult) Reset()                    { *m = TagMaryGameResult{} }
func (m *TagMaryGameResult) String() string            { return proto.CompactTextString(m) }
func (*TagMaryGameResult) ProtoMessage()               {}
func (*TagMaryGameResult) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{7} }

func (m *TagMaryGameResult) GetWinScore() int64 {
	if m != nil && m.WinScore != nil {
		return *m.WinScore
	}
	return 0
}

func (m *TagMaryGameResult) GetCurrGameCount() uint32 {
	if m != nil && m.CurrGameCount != nil {
		return *m.CurrGameCount
	}
	return 0
}

func (m *TagMaryGameResult) GetCenterIcon() []int32 {
	if m != nil {
		return m.CenterIcon
	}
	return nil
}

func (m *TagMaryGameResult) GetResultIcon() int32 {
	if m != nil && m.ResultIcon != nil {
		return *m.ResultIcon
	}
	return 0
}

type CMD_S_MaryGameResult struct {
	MaryResult       []*TagMaryGameResult `protobuf:"bytes,1,rep,name=mary_result,json=maryResult" json:"mary_result,omitempty"`
	XXX_unrecognized []byte               `json:"-"`
}

func (m *CMD_S_MaryGameResult) Reset()                    { *m = CMD_S_MaryGameResult{} }
func (m *CMD_S_MaryGameResult) String() string            { return proto.CompactTextString(m) }
func (*CMD_S_MaryGameResult) ProtoMessage()               {}
func (*CMD_S_MaryGameResult) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{8} }

func (m *CMD_S_MaryGameResult) GetMaryResult() []*TagMaryGameResult {
	if m != nil {
		return m.MaryResult
	}
	return nil
}

// 请求切换游戏场景
type CMD_C_SwitchGame struct {
	SwitchGame       *int32 `protobuf:"varint,1,opt,name=switch_game,json=switchGame" json:"switch_game,omitempty"`
	XXX_unrecognized []byte `json:"-"`
}

func (m *CMD_C_SwitchGame) Reset()                    { *m = CMD_C_SwitchGame{} }
func (m *CMD_C_SwitchGame) String() string            { return proto.CompactTextString(m) }
func (*CMD_C_SwitchGame) ProtoMessage()               {}
func (*CMD_C_SwitchGame) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{9} }

func (m *CMD_C_SwitchGame) GetSwitchGame() int32 {
	if m != nil && m.SwitchGame != nil {
		return *m.SwitchGame
	}
	return 0
}

type CMD_S_UpdateGameScene struct {
	CurrGame  *int32 `protobuf:"varint,1,opt,name=curr_game,json=currGame" json:"curr_game,omitempty"`
	UserScore *int64 `protobuf:"varint,2,opt,name=user_score,json=userScore" json:"user_score,omitempty"`
	// 主游戏用
	BetPerLine   *int64   `protobuf:"varint,3,opt,name=bet_per_line,json=betPerLine" json:"bet_per_line,omitempty"`
	LineCount    *int32   `protobuf:"varint,4,opt,name=line_count,json=lineCount" json:"line_count,omitempty"`
	MainWinScore *int64   `protobuf:"varint,5,opt,name=main_win_score,json=mainWinScore" json:"main_win_score,omitempty"`
	BetList      []uint32 `protobuf:"varint,6,rep,name=bet_list,json=betList" json:"bet_list,omitempty"`
	// 比大小用
	BetDice      *int64 `protobuf:"varint,7,opt,name=bet_dice,json=betDice" json:"bet_dice,omitempty"`
	DiceWinScore *int64 `protobuf:"varint,8,opt,name=dice_win_score,json=diceWinScore" json:"dice_win_score,omitempty"`
	// 小玛丽用,
	BetMary                *int64 `protobuf:"varint,9,opt,name=bet_mary,json=betMary" json:"bet_mary,omitempty"`
	PersonalPrizePool      *int64 `protobuf:"varint,10,opt,name=personal_prize_pool,json=personalPrizePool" json:"personal_prize_pool,omitempty"`
	PersonalPrizePoolLimit *int64 `protobuf:"varint,11,opt,name=personal_prize_pool_limit,json=personalPrizePoolLimit" json:"personal_prize_pool_limit,omitempty"`
	XXX_unrecognized       []byte `json:"-"`
}

func (m *CMD_S_UpdateGameScene) Reset()                    { *m = CMD_S_UpdateGameScene{} }
func (m *CMD_S_UpdateGameScene) String() string            { return proto.CompactTextString(m) }
func (*CMD_S_UpdateGameScene) ProtoMessage()               {}
func (*CMD_S_UpdateGameScene) Descriptor() ([]byte, []int) { return fileDescriptor0, []int{10} }

func (m *CMD_S_UpdateGameScene) GetCurrGame() int32 {
	if m != nil && m.CurrGame != nil {
		return *m.CurrGame
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetUserScore() int64 {
	if m != nil && m.UserScore != nil {
		return *m.UserScore
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetBetPerLine() int64 {
	if m != nil && m.BetPerLine != nil {
		return *m.BetPerLine
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetLineCount() int32 {
	if m != nil && m.LineCount != nil {
		return *m.LineCount
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetMainWinScore() int64 {
	if m != nil && m.MainWinScore != nil {
		return *m.MainWinScore
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetBetList() []uint32 {
	if m != nil {
		return m.BetList
	}
	return nil
}

func (m *CMD_S_UpdateGameScene) GetBetDice() int64 {
	if m != nil && m.BetDice != nil {
		return *m.BetDice
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetDiceWinScore() int64 {
	if m != nil && m.DiceWinScore != nil {
		return *m.DiceWinScore
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetBetMary() int64 {
	if m != nil && m.BetMary != nil {
		return *m.BetMary
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetPersonalPrizePool() int64 {
	if m != nil && m.PersonalPrizePool != nil {
		return *m.PersonalPrizePool
	}
	return 0
}

func (m *CMD_S_UpdateGameScene) GetPersonalPrizePoolLimit() int64 {
	if m != nil && m.PersonalPrizePoolLimit != nil {
		return *m.PersonalPrizePoolLimit
	}
	return 0
}

func init() {
	proto.RegisterType((*CMD_S_ERROR)(nil), "CMD_SHZ.CMD_S_ERROR")
	proto.RegisterType((*CMD_C_MainGameStart)(nil), "CMD_SHZ.CMD_C_MainGameStart")
	proto.RegisterType((*TagLineInfo)(nil), "CMD_SHZ.tagLineInfo")
	proto.RegisterType((*CMD_S_MainGameResult)(nil), "CMD_SHZ.CMD_S_MainGameResult")
	proto.RegisterType((*CMD_C_DiceGameStart)(nil), "CMD_SHZ.CMD_C_DiceGameStart")
	proto.RegisterType((*CMD_S_DiceGameResult)(nil), "CMD_SHZ.CMD_S_DiceGameResult")
	proto.RegisterType((*CMD_C_MaryGameStart)(nil), "CMD_SHZ.CMD_C_MaryGameStart")
	proto.RegisterType((*TagMaryGameResult)(nil), "CMD_SHZ.tagMaryGameResult")
	proto.RegisterType((*CMD_S_MaryGameResult)(nil), "CMD_SHZ.CMD_S_MaryGameResult")
	proto.RegisterType((*CMD_C_SwitchGame)(nil), "CMD_SHZ.CMD_C_SwitchGame")
	proto.RegisterType((*CMD_S_UpdateGameScene)(nil), "CMD_SHZ.CMD_S_UpdateGameScene")
}

func init() { proto.RegisterFile("CMD_SHZ_Game.CMD", fileDescriptor0) }

var fileDescriptor0 = []byte{
	// 672 bytes of a gzipped FileDescriptorProto
	0x1f, 0x8b, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0xff, 0xa4, 0x53, 0xdd, 0x6e, 0x13, 0x3d,
	0x10, 0xd5, 0x66, 0x9b, 0x26, 0x99, 0xb4, 0xfd, 0xda, 0x6d, 0xfb, 0xe1, 0x16, 0xa1, 0x46, 0x2b,
	0x84, 0x72, 0x95, 0x0b, 0x10, 0x17, 0x88, 0x3b, 0x5a, 0x44, 0x23, 0xb5, 0x22, 0x6c, 0x40, 0x48,
	0xdc, 0x58, 0x9b, 0xcd, 0x50, 0x2c, 0x6d, 0xec, 0x95, 0xd7, 0x51, 0x09, 0x8f, 0xc0, 0x23, 0x20,
	0x9e, 0x86, 0x27, 0x43, 0x63, 0xef, 0x4f, 0x36, 0x50, 0xa9, 0x12, 0x77, 0xf6, 0xf1, 0xcc, 0x78,
	0xe6, 0x9c, 0x33, 0x10, 0x9c, 0x5f, 0x5f, 0xf0, 0xe9, 0xe5, 0x27, 0xfe, 0x26, 0x5e, 0xe0, 0x28,
	0xd3, 0xca, 0xa8, 0xa0, 0x53, 0x60, 0xe1, 0x19, 0xf4, 0xed, 0x91, 0xbf, 0x8e, 0xa2, 0xb7, 0x51,
	0xb0, 0x0f, 0x3e, 0x6a, 0xcd, 0xbc, 0x81, 0x37, 0x6c, 0x47, 0x74, 0x0c, 0xdf, 0xc1, 0x21, 0x05,
	0x9c, 0xf3, 0xeb, 0x58, 0x48, 0xaa, 0x30, 0x35, 0xb1, 0x36, 0xc1, 0x43, 0xe8, 0xcd, 0xd0, 0xf0,
	0x3c, 0x51, 0x1a, 0x6d, 0xb8, 0x1f, 0x75, 0x67, 0x68, 0xa6, 0x74, 0x0f, 0x1e, 0x01, 0xa4, 0x42,
	0x22, 0x4f, 0xd4, 0x52, 0x1a, 0xd6, 0x1a, 0x78, 0xc3, 0xdd, 0xa8, 0x47, 0xc8, 0x39, 0x01, 0x61,
	0x0c, 0x7d, 0x13, 0xdf, 0x5c, 0x09, 0x89, 0x63, 0xf9, 0x59, 0x05, 0x0f, 0xa0, 0x63, 0xa3, 0xc5,
	0xbc, 0xf8, 0x77, 0x9b, 0xae, 0xe3, 0x39, 0x95, 0x11, 0x89, 0x92, 0x5c, 0xc8, 0x39, 0x7e, 0x65,
	0xad, 0x81, 0x3f, 0x6c, 0x47, 0x3d, 0x42, 0xc6, 0x04, 0x04, 0xa7, 0xd0, 0x5d, 0x2c, 0x53, 0x23,
	0xb2, 0x14, 0x99, 0x6f, 0x13, 0xab, 0x7b, 0xf8, 0xab, 0x05, 0x47, 0x6e, 0xae, 0xb2, 0xed, 0x08,
	0xf3, 0x65, 0xfa, 0x4f, 0x7d, 0x53, 0xee, 0xad, 0x90, 0x45, 0xae, 0xef, 0x72, 0x6f, 0x85, 0x74,
	0xb9, 0x67, 0xd0, 0xd7, 0xf6, 0x0b, 0x6e, 0x56, 0x19, 0xb2, 0x2d, 0xdb, 0x10, 0x38, 0xe8, 0xfd,
	0x2a, 0xc3, 0x60, 0x08, 0xfb, 0x33, 0x25, 0x97, 0x39, 0xbf, 0x89, 0x17, 0xe5, 0x17, 0x6d, 0xfb,
	0xc5, 0x9e, 0xc5, 0xa9, 0x49, 0xf7, 0x4f, 0x5d, 0x8a, 0x86, 0x65, 0xdb, 0x76, 0xf0, 0xa2, 0xd4,
	0x38, 0x51, 0x32, 0x78, 0x5e, 0x05, 0x50, 0x73, 0xac, 0x33, 0xf0, 0x87, 0xfd, 0xa7, 0x47, 0xa3,
	0x42, 0xd3, 0xd1, 0x1a, 0xb9, 0x65, 0x1a, 0xdd, 0x83, 0x11, 0x1c, 0x66, 0xa8, 0x73, 0x25, 0xe3,
	0x94, 0x67, 0x5a, 0x7c, 0x43, 0x9e, 0x29, 0x95, 0xb2, 0xae, 0x9d, 0xe4, 0xa0, 0x7c, 0x9a, 0xd0,
	0xcb, 0x44, 0xa9, 0x34, 0xbc, 0x2e, 0xa5, 0xbf, 0x10, 0x09, 0xde, 0x53, 0xfa, 0x13, 0xa0, 0xb3,
	0xe3, 0xc0, 0x11, 0xd8, 0x99, 0xa1, 0x25, 0x20, 0xfc, 0xee, 0x95, 0x9a, 0x94, 0xf5, 0xee, 0xa3,
	0xc9, 0x66, 0xc1, 0x76, 0x55, 0x90, 0xe4, 0x9a, 0x8b, 0x84, 0xa6, 0x10, 0xd2, 0x14, 0x16, 0xe8,
	0x11, 0x32, 0x21, 0xa0, 0x29, 0xd7, 0x56, 0x53, 0xae, 0xf0, 0xb8, 0xb6, 0xb5, 0x5e, 0x55, 0xb3,
	0x85, 0x3f, 0x3c, 0x38, 0x30, 0xf1, 0x4d, 0x09, 0xd6, 0x0d, 0xd6, 0x95, 0xbc, 0x0d, 0xe1, 0x9f,
	0xc0, 0x7f, 0xc9, 0x52, 0xeb, 0x75, 0x59, 0xdd, 0xe0, 0xbb, 0x04, 0x37, 0x54, 0x4d, 0x50, 0x1a,
	0xd4, 0x4e, 0x55, 0xdf, 0xa9, 0xea, 0x20, 0xab, 0xea, 0x86, 0xec, 0x0d, 0x07, 0x51, 0x40, 0x38,
	0xad, 0x3d, 0xdd, 0x68, 0xef, 0x25, 0xf4, 0x17, 0xb1, 0x5e, 0x71, 0x17, 0xca, 0x3c, 0x6b, 0x87,
	0xd3, 0x75, 0x3b, 0x34, 0x13, 0x22, 0xa0, 0x70, 0x77, 0x0e, 0x9f, 0xc1, 0xbe, 0x23, 0x62, 0x7a,
	0x2b, 0x4c, 0xf2, 0x85, 0xa2, 0xa8, 0x93, 0xdc, 0xde, 0xec, 0x50, 0xc5, 0x56, 0x42, 0x5e, 0x05,
	0x84, 0x3f, 0x7d, 0x38, 0x76, 0xad, 0x7c, 0xc8, 0xe6, 0xb1, 0x71, 0xe6, 0x48, 0x50, 0x22, 0x51,
	0x55, 0xb1, 0x51, 0x24, 0x76, 0x4b, 0x1e, 0x48, 0xb0, 0x65, 0x8e, 0xba, 0x20, 0xb2, 0x65, 0x89,
	0xec, 0x11, 0xe2, 0x98, 0x1c, 0xc0, 0x0e, 0x49, 0x9d, 0xa1, 0x76, 0xbe, 0x76, 0x2b, 0x06, 0x33,
	0x34, 0x13, 0xd4, 0xd6, 0xc1, 0xcd, 0x05, 0x75, 0x0c, 0xad, 0x2d, 0xe8, 0x63, 0xd8, 0x5b, 0xc4,
	0x42, 0xf2, 0x5a, 0xac, 0xb6, 0x2d, 0xb1, 0x43, 0xe8, 0xc7, 0x52, 0xb0, 0xc2, 0x51, 0xa9, 0xc8,
	0x8d, 0xdd, 0x2d, 0x67, 0xd1, 0x2b, 0x91, 0x9b, 0xf2, 0x89, 0x3c, 0xc4, 0x3a, 0x36, 0x95, 0x9e,
	0xc8, 0xae, 0x54, 0xdb, 0x9a, 0xad, 0xae, 0xed, 0xf6, 0x66, 0x87, 0xd0, 0xcd, 0xda, 0xc4, 0x2f,
	0xeb, 0x55, 0x05, 0x88, 0xfe, 0xbb, 0xb6, 0x0f, 0xee, 0xd8, 0xbe, 0xe0, 0x05, 0x9c, 0xfc, 0x25,
	0x9e, 0xa7, 0x62, 0x21, 0x0c, 0xeb, 0xdb, 0xac, 0xff, 0xff, 0xc8, 0xba, 0xa2, 0xd7, 0x57, 0xad,
	0x4b, 0xff, 0x77, 0x00, 0x00, 0x00, 0xff, 0xff, 0xf6, 0x33, 0xb8, 0x04, 0xf6, 0x05, 0x00, 0x00,
}
