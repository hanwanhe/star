-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-19 23:08:03
-- @desc: index controller

local Base = require('app.controller.base')  
local Index = {}
setmetatable(Index, {__index = Base})

function Index:construct()
  Base.construct(self)
end

function Index:index()
  local var_dump = self.common.var_dump
  --get 
  var_dump(self.request:get())
  var_dump(self.request:get('user'))
  --post
  ngx.say(self.request:post('age'))
end

return Index