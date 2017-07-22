-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 10:46:33
-- @desc: the framework entrance  file

local Request = require('star.lib.request')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local Db = require('star.lib.db')
local Func = require('star.lib.func')
local ngx = ngx
local ngx_log = ngx.log


local App = {}
local mt = {__index = App}

function App:new(app_name)
  local instance = {
    app_name = app_name,
    request = Request:new(),
    db = Db:new(app_name),
    func = Func 
  }
  return setmetatable(instance, mt)
end

function App:run()
  local controler, method = Router.parse(self.request)
  local ok, err = pcall(Dispatcher.run, self, controler, method)
  if not ok then
    ngx_log(ngx.ERR, err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
end


return App