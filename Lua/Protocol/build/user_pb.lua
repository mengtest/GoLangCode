-- Generated By protoc-gen-lua Do not Edit

local protobuf = require "protobuf"
module('user_pb')



local FRIEND = protobuf.Descriptor();
local FRIEND_NAME_FIELD = protobuf.FieldDescriptor();
local FRIEND_ADDRESS_FIELD = protobuf.FieldDescriptor();

FRIEND_NAME_FIELD.name = "name"
FRIEND_NAME_FIELD.full_name = ".tutorial.Friend.name"
FRIEND_NAME_FIELD.number = 1
FRIEND_NAME_FIELD.index = 0
FRIEND_NAME_FIELD.label = 1
FRIEND_NAME_FIELD.has_default_value = false
FRIEND_NAME_FIELD.default_value = ""
FRIEND_NAME_FIELD.type = 9
FRIEND_NAME_FIELD.cpp_type = 9

FRIEND_ADDRESS_FIELD.name = "address"
FRIEND_ADDRESS_FIELD.full_name = ".tutorial.Friend.address"
FRIEND_ADDRESS_FIELD.number = 2
FRIEND_ADDRESS_FIELD.index = 1
FRIEND_ADDRESS_FIELD.label = 1
FRIEND_ADDRESS_FIELD.has_default_value = false
FRIEND_ADDRESS_FIELD.default_value = ""
FRIEND_ADDRESS_FIELD.type = 9
FRIEND_ADDRESS_FIELD.cpp_type = 9

FRIEND.name = "Friend"
FRIEND.full_name = ".tutorial.Friend"
FRIEND.nested_types = {}
FRIEND.enum_types = {}
FRIEND.fields = {FRIEND_NAME_FIELD, FRIEND_ADDRESS_FIELD}
FRIEND.is_extendable = false
FRIEND.extensions = {}

Friend = protobuf.Message(FRIEND)

