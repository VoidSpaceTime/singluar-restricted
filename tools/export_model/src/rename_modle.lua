
local lib = require 'modellib'
local module = require 'modellib.module'
local ffi = require 'ffi'
local stormlib = require 'map.stormlib'
local uni = require 'map.unicode'


local inputpath = arg[2]

local outpath = arg[3] or arg[2]