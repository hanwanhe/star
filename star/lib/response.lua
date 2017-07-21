-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:30:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-21 22:53:24
-- @desc: response instance

local Func = require('star.lib.func')
local Response = {}
local mt = {__index = Response}

function Response:new()
  local instance = {
  
  }
  return setmetatable(instance, mt)
end

function Response:var_dump(var)
  return Func.var_dump(var)
end

return Response