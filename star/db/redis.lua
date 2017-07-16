-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-16 22:59:19
-- @desc: redis module

local Common = require('star.lib.common')
local Redis = {}
local mt = {__index = Redis}
local setmetatable = setmetatable
local default_config = {
  host = '127.0.0.1',
  port = 6379
}

local resty_redis = require 'resty.redis'

function Redis:new(config)
  local red = resty_redis:new()
  config = Common.table_merge(default_config, config)
  red:set_timeout(1000) 
  local ok, err = red:connect(config.host, config.port)
  if not ok then
    return nil, err
  end
  return setmetatable({instance = red}, mt)
end

function Redis:set_keepalive()
  self.instance:set_keepalive(30000, 2)
end


return Redis