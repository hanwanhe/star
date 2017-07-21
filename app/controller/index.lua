-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-21 23:02:00
-- @desc: index controller

local Base = require('app.controller.base')  
local Index = {}
setmetatable(Index, {__index = Base})

function Index:construct()
  Base.construct(self)
end

function Index:index()
  ngx.sleep(10)
  --get 
  self.response:var_dump(self.request:get())
  self.response:var_dump(self.request:get('user'))
  --post
  self.response:var_dump(self.request:post('age'))
  --cookie
  self.response:var_dump(self.request:cookie())
end

return Index