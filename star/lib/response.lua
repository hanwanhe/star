-- response.lua
-- @modify 2017-07-14 00:10
-- @author hanwanhe <hanwanhe@qq.com>
-- @desc response instance

local setmetatable = setmetatable
local Response = {}
local mt = {__index = Response}

function Response:new()
  local instance = {
    ngxSay = ngx.say
  }
  return setmetatable(instance, mt)
end

return Response