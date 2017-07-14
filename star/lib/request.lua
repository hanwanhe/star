-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:22:10
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-14 23:54:08
-- @desc: request instance


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