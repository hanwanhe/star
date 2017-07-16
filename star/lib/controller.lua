-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-16 22:17:16
-- @desc: base controller

local setmetatable = setmetatable
local Controller = {}

function Controller:new(app)
  local instance = {
    app = app,
    request = app.request,
    response = app.response
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Controller:construct()

end


function Controller:select_db(...)
  return self.app:select_db(...)
end


return Controller