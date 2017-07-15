-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:30:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-15 12:34:28
-- @desc: response instance


local setmetatable = setmetatable
local Response = {}
local mt = {__index = Response}

function Response:new()
  local instance = {
  
  }
  return setmetatable(instance, mt)
end

return Response