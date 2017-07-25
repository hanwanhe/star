-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-24 22:46:01
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-25 22:20:30
-- @desc: base model

local Model = {}

function Model:new(app)
  local instance = {
    app = app,
    request = app.request
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Model:construct()

end

function Model:load_model(...)
  return self.app:load_model(...)
end

return Model