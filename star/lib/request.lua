-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:22:10
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-29 11:59:52
-- @desc: request module

local ngx = ngx
local Request = {}
Request.__index = Request


function Request:new()
  local instance = {
    uri_args = ngx.req.get_uri_args()
  }
  return setmetatable(instance, self)
end

function Request:get(arg)
  if(type(arg) ~= 'string') then return self.uri_args end 
  return self.uri_args[arg]
end

function Request:read_body()
  ngx.req.read_body()
  self.post_args = ngx.req.get_post_args()
end

function Request:post(arg)
  if(self.post_args == nil) then self:read_body() end
  if(type(arg) ~= 'string') then return self.post_args end 
  return self.post_args[arg]
end


return Request