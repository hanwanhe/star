-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-29 09:26:18
-- @desc: base controller

local Controller = {}

function Controller:new(app)
  local instance = {
    app = app,
    request = app.request,
    router = app.router
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Controller:construct()

end

function Controller:load_model(...)
  return self.app:load_model(...)
end

function Controller:load_database(...)
  return self.app:load_database()
end

return Controller