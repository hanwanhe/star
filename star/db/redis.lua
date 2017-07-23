-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-23 23:40:09
-- @desc: redis module

local string = string
local Func = require('star.lib.func')
local Redis = {}
Redis.__index = Redis

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
  config = Func.table_merge(default_config, config)
  red:set_timeout(config.timeout) 
  local ok, err
  if(Func.str_exists(config.unix)) then
    ok, err = red:connect(config.unix, {pool = pool})
  else
    ok, err = red:connect(config.host, config.port, {pool = pool})
  end 
  if not ok then
    return nil, err
  end
  if(Func.str_exists(config.password)) then
    local count, err = red:get_reused_times()
    if 0 == count then
        local ok, err = red:auth(config.password)
        if not ok then
            return nil, err
        end
    elseif err then
        return nil, err
    end
  end
  return setmetatable({sock = red, config = config}, self), nil
end


function Redis:set_keepalive()
  self.instance:set_keepalive(self.config.max_idle_timeout, self.config.pool_size)
end


return Redis