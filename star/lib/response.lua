-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:30:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-14 23:54:22
-- @desc: response instance


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