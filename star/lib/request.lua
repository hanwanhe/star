-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:22:10
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 13:31:56
-- @desc: request module

local Cookie = require "resty.cookie"
local Request = {}
local mt = {__index = Request}
local ngx = ngx

function Request:new()
  local instance = {
    uri_args = ngx.req.get_uri_args(),
    _cookie = nil
  }
  return setmetatable(instance, mt)
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

function Request:cookie(arg)
  if not self._cookie then 
    local cookie, err = Cookie:new()
    if not cookie then
      ngx.log(ngx.ERR, "failed to new cookie: ", err)
      return nil, err
    end
    self._cookie = cookie
  end
  if(arg and type(arg) == 'table') then 
    return self._cookie:set(arg)
  elseif(arg == nil) then
    return self._cookie:get_all()
  else
    return  self._cookie:get(arg)
  end
end


return Request