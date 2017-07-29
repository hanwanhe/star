-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-29 13:06:20
-- @desc: index controller

local Base = require('app.controller.base')  
local Index = {}
setmetatable(Index, {__index = Base})
function Index:_construct()
  Base._construct(self)
end


function Index:index()
  ngx.say(self.request:get('name'))
  ngx.say(self.request:post('name'))
  ngx.say(self.router.controller)
  ngx.say(self.router.method)
  local user_model = self:load_model('user')
  ngx.say(user_model:get_name())
  ngx.say(self.config.name)
end


return Index