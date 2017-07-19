-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-19 22:08:34
-- @desc: to execute the `controller` and `method`

local setmetatable = setmetatable
local pcall = pcall
local require = require
local ngx = ngx
local ngx_log = ngx.log
local Controller = require('star.lib.controller')  
local Dispatcher = {}
local mt = {__index = Controller}

function Dispatcher:run(app, controller, method)
  local app_config = require(app.app_name..'.config.app')
  local app_name = app.app_name 
  local controller_path = app_name..'.controller.'
  local app_controller_path = controller_path..controller
  local ok, AppController = pcall(require, app_controller_path)
  if not ok then
    ngx_log(ngx.ERR, app_controller_path.. 'is not founded.')
    Dispatcher:err(app, ngx.HTTP_NOT_FOUND)
    return
  end
  -- app controller new instance
  app_controller_instance = AppController:new(app)
  if(type(app_controller_instance[method]) == 'function') then
    app_controller_instance:construct(app)
    app_controller_instance[method](app_controller_instance)
  else
    ngx_log(ngx.ERR, app_controller_path.. ' property `'..method..'` is not a function.')
    Dispatcher:err(app, ngx.HTTP_NOT_FOUND)
  end
end

function Dispatcher:err(app, status)
  ngx.exit(status)
end

return Dispatcher