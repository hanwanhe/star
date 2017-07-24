-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-24 22:46:01
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-24 22:47:20
-- @desc: base model

local Model = {}

function Model:new(app)
  local instance = {
    app = app
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Model:construct()

end


return Model
