-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-16 22:17:41
-- @desc: 
local _M = {}
local mt = {__index = _M}
local setmetatable = setmetatable


local redis = require 'resty.redis'

function _M:new(name)
  local red = redis:new()
  red:set_timeout(1000) 
  local ok, err = red:connect('127.0.0.1', 6379)
  if not ok then
    return nil, err
  end
  return setmetatable({instance = red}, mt)
end

function _M:set_keepalive()
  self.instance:set_keepalive(30000, 2)
end


return _M