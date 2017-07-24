-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-24 23:12:03
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

  local user_model = self:load_model('user')
  ngx.say(user_model:get_name())

end


return Index