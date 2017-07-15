-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-15 21:21:07
-- @desc: to execute the `controller` and `method`

local setmetatable = setmetatable
local pcall = pcall
local require = require
local ngx = ngx
local ngxLog = ngx.log
local Controller = require('star.lib.controller')  
local Dispatcher = {}
local mt = {__index = Controller}

function Dispatcher:run(app, controller, method)
  local appName = app.appName 
  local controllerPath = appName..'.controller.'
  local appControllerPath = controllerPath..controller
  local ok, AppController = pcall(require, appControllerPath)
  if not ok then
    ngxLog(ngx.ERR, appControllerPath.. 'is not founded.')
    Dispatcher:err(app, ngx.HTTP_NOT_FOUND)
    return
  end
  local metaTable = getmetatable(AppController)
  -- load parent 
  if(AppController.extends ~= nil) then
    local parentControllerPath = controllerPath..AppController.extends
    local ok, ParentController = pcall(require, parentControllerPath)
    if not ok then
      ngxLog(ngx.ERR, parentControllerPath.. ' is not founded.')
      Dispatcher:err(app, ngx.HTTP_INTERNAL_SERVER_ERROR)
      return
    end   
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
  if(type(appControllerInstance[method]) == 'function') then
    appControllerInstance:construct()
    appControllerInstance[method](appControllerInstance)
  else
    ngxLog(ngx.ERR, appControllerPath.. ' property `'..method..'` is not a function.')
    Dispatcher:err(app, ngx.HTTP_NOT_FOUND)
  end
  --db keepalive
  app:setDbKeepAlive()
end

function Dispatcher:err(app, status)
  ngx.exit(status)
end

return Dispatcher