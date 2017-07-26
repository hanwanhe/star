-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-26 23:44:09
-- @desc: to execute the `controller` and `method`

local pcall = pcall
local require = require
local ngx = ngx
local Controller = require('star.lib.controller')  
local Dispatcher = {}
local mt = {__index = Controller}

function Dispatcher.run(app, controller, method)
  local app_config = require(app.app_name..'.config.app')
  local current_controller_file = app.app_name..'.controller.'..controller
  local ok, CurrentController_or_err = pcall(require, current_controller_file)
  if not ok then
    ngx.log(ngx.ERR, CurrentController_or_err)
    ngx.exit(ngx.HTTP_NOT_FOUND)
    return
  end
  -- new current controller
  current_controller_instance = CurrentController_or_err:new(app)
  method_func = current_controller_instance[method]
  if(type(method_func) == 'function') then
    current_controller_instance:construct(app)
    method_func(current_controller_instance)
    self.app:set_keepalive()
  else
    ngx.log(ngx.ERR, 'no function named ', method, ' in the controller ', current_controller_file) 
    ngx.exit(ngx.HTTP_NOT_FOUND)
  end
end


return Dispatcher