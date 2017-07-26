-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-26 23:14:07
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-26 23:44:45
-- @desc: response module

local Cookie = require "resty.cookie"
local Response = {}
Response.__index = Response


function Response:new(app)
  local instance = {
    app = app
  }
  return setmetatable(instance, self)
end

function Response:exit(status)
  self.app:set_keepalive()
  ngx.exit(status)
end


return Response
