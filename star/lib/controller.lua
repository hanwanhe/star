-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 13:25:54
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



return Controller