-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-29 11:28:35
-- @desc: to execute the `controller` and `method`

local pcall = pcall
local require = require
local ngx = ngx
local Dispatcher = {}

function Dispatcher.run(app, controller, method)
  local current_controller_file = app.app_name..'.controller.'..controller
  local ok, CurrentController_or_err = pcall(require, current_controller_file)
  if not ok then
    local err = CurrentController_or_err
    ngx.log(ngx.ERR, err)
    ngx.exit(ngx.HTTP_NOT_FOUND)
    return
  end
  -- new current controller
  local CurrentController = CurrentController_or_err
  local ok, current_controller_instance = pcall(CurrentController._new, CurrentController, app)
  if not ok then
    ngx.log(ngx.ERR, 'please make sure your controller extends the star.lib.controller')
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
  method_func = current_controller_instance[method]
  if(type(method_func) == 'function') then
    current_controller_instance:_construct(app)
    method_func(current_controller_instance)
  else
    ngx.log(ngx.ERR, 'no method named ', method, ' in the controller ', current_controller_file) 
    ngx.exit(ngx.HTTP_NOT_FOUND)
  end
end


return Dispatcher