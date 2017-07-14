-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-14 23:59:14
-- @desc: to execute the `controller` and `method`

local setmetatable = setmetatable
local pcall = pcall
local Controller = require('star.lib.controller')  
local Dispatcher = {}
local mt = {__index = Controller}

function Dispatcher:run(app, controller, method)
  local appName = app.appName 
  local AppController = require(appName..'.controller.'..controller)
  local metaTable = getmetatable(AppController)
  -- load parent 
  if(AppController.extends ~= nil) then
    local ParentController = require(appName..'.controller.'..AppController.extends)
    ParentController.__index = ParentController
    if(metaTable == nil) then
      setmetatable(AppController, ParentController)
      AppController.parent = ParentController
      setmetatable(ParentController, mt)
      ParentController.parent = Controller
    end
  else
    if(metaTable == nil) then
      setmetatable(AppController, mt)
      AppController.parent = Controller
    end
  end
  -- app controller new instance
  appControllerInstance = AppController:new(app)
  appControllerInstance:construct()
  return appControllerInstance[method](appControllerInstance)
end

return Dispatcher