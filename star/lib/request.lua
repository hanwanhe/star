-- request.lua
-- @modify 2017-07-14 00:10
-- @author hanwanhe <hanwanhe@qq.com>
-- @desc request instance

local setmetatable = setmetatable

local Request = {}
local mt = {__index = Request}

function Request:new()
  local instance = {
    ngxVar = ngx.var,
    ngxReq = ngx.req
  }
  return setmetatable(instance, mt)
end

return Request