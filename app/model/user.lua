-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-24 22:49:08
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-24 23:13:10
-- @desc: user model

local Model = require('star.lib.model')  
local User = {}
setmetatable(User, {__index = Model})

function User:get_name()
  --redis
  local db = self.app.db
  local redis, err = db:connect('redis', 'default')
  --redis.sock:set('name', 'hanwanhe@')
  local name = redis.sock:get('name')
  redis:set_keepalive()
  return name
end

return User


