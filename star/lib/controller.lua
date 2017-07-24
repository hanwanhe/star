-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-24 23:24:49
-- @desc: base controller

local Controller = {}

function Controller:new(app)
  local instance = {
    app = app
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Controller:construct()

end

function Controller:load_model(model_name)
  local model = require(self.app.app_name..'.model.'..model_name)
  local model_instance = model:new(self.app)
  model_instance:construct()
  return model_instance
end

return Controller