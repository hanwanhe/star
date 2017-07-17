-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-17 22:55:34
-- @desc: base controller

local setmetatable = setmetatable
local Controller = {}

function Controller:new(app)
  local instance = {
    app = app,
    request = app.request,
    response = app.response,
    db = app.db
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Controller:construct()

end



return Controller