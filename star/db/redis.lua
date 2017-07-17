-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-17 23:24:33
-- @desc: redis module

local require = require
local Common = require('star.lib.common')
local Redis = {}
local mt = {__index = Redis}
local setmetatable = setmetatable
local default_config = {
  host = '127.0.0.1',
  port = 6379,
  unix = '',
  pool = '',
  timeout = 1000,
  max_idle_timeout = 30000,
  pool_size = 20,
  password = ''
}

local resty_redis = require 'resty.redis'

function Redis:new(config)
  local red, err = resty_redis:new()
  if not red then
    return nil, err
  end
  config = Common.table_merge(default_config, config)
  red:set_timeout(config.timeout) 
  if(config.unix) then
    local ok, err = red:connect(config.unix, {pool = pool})
  else
    local ok, err = red:connect(config.host, config.port, {pool = pool})
  end 
  if not ok then
    return nil, err
  end
  if(config.password) then
    local count, err = red:get_reused_times()
    if 0 == count then
        ok, err = red:auth(config.password)
        if not ok then
            return nil, err
        end
    elseif err then
        return nil, err
    end
  end

  return setmetatable({instance = red, config = config}, mt), nil
end

function Redis:free()
  self.instance:set_keepalive(self.config.max_idle_timeout, self.config.pool_size)
end


return Redis