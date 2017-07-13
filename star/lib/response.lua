local setmetatable = setmetatable
local Response = {}
local mt = {__index = Response}

function Response:new()
  local instance = {
    ngx_say = ngx.say
  }
  return setmetatable(instance, mt)
end

return Response