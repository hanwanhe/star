-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 17:53:12
-- @desc: index controller

local Base = require('app.controller.base')  
local Index = {}
setmetatable(Index, {__index = Base})

function Index:construct()
  Base.construct(self)
end

function Index:index()
  local request = self.app.request
  ngx.say(request:get('name'))
  ngx.say(request:post('name'))
  ngx.say(request:cookie('name'))

  --redis
  local db = self.app.db
  local redis, err = db:connect('redis', 'default')
  redis.instance:set('name', 'hanwanhe')
  ngx.say(redis.instance:get('name'))
  redis:set_keepalive()
end


return Index