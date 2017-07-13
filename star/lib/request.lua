local setmetatable = setmetatable

local Request = {}
local mt = {__index = Request}

function Request:new()
  local instance = {
    ngx_var = ngx.var,
    ngx_req = ngx.req
  }
  return setmetatable(instance, mt)
end

return Request