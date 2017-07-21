-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:22:10
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-21 23:01:45
-- @desc: request instance

local Cookie = require "resty.cookie"
local Request = {}
local mt = {__index = Request}
local ngx_var = ngx.var
local ngx_req = ngx.req

function Request:new()
  local cookie = Cookie:new()
  local instance = {
    ngx_var = ngx_var,
    ngx_req = ngx_req,
    uri_args = ngx_req.get_uri_args(),
    _cookie = cookie
  }
  return setmetatable(instance, mt)
end

function Request:get(arg)
  if(type(arg) ~= 'string') then return self.uri_args end 
  return self.uri_args[arg]
end

function Request:read_body()
  self.ngx_req.read_body()
  self.post_args = self.ngx_req.get_post_args()
end

function Request:post(arg)
  if(self.post_args == nil) then self:read_body() end
  if(type(arg) ~= 'string') then return self.post_args end 
  return self.post_args[arg]
end

function Request:cookie(arg)
  if not self._cookie then return nil, 'cookie instantiation failed.' end
  if(arg == nil) then return self._cookie:get_all() end
  if(arg and type(arg) == 'string') then return self._cookie:get(arg) end
  if(arg and type(arg) == 'table') then return self._cookie:set(arg) end
  return nil, 'type error'
end

return Request