-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-29 13:08:07
-- @desc: base controller

local Controller = {}

function Controller:_new(app)
  local instance = {
    app = app,
    request = app.request,
    router = app.router,
    config = app.config,
    func = app.func
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Controller:_construct()

end

function Controller:load_model(...)
  return self.app:load_model(...)
end

function Controller:load_database(...)
  return self.app:load_database()
end

return Controller