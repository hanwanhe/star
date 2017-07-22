-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 10:29:42
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
  local controller_path = app.app_name..'.controller.'
  local current_controller_file = controller_path..controller
  local ok, CurrentController_or_err = pcall(require, current_controller_file)
  if not ok then
    ngx_log(ngx.ERR, CurrentController_or_err)
    Dispatcher:err(app, ngx.HTTP_NOT_FOUND)
    return
  end
  -- new current controller
  current_controller_instance = CurrentController_or_err:new(app)
  method_func = rawget(current_controller_instance, method)
  if(type(method_func) == 'function') then
    current_controller_instance:construct(app)
    method_func(current_controller_instance)
  else
    ngx_log(ngx.ERR, 'no function named ', method, ' in the controller ', current_controller_file)
    Dispatcher:err(app, ngx.HTTP_NOT_FOUND)
  end
end

function Dispatcher:err(app, status)
  ngx.exit(status)
end

return Dispatcher