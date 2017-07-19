-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-19 22:09:43
-- @desc: app base controller 

local Controller = require('star.lib.controller')  
local Base = {}
setmetatable(Base, {__index = Controller})

function Base:construct()
  Controller.construct(self)
end

return Base