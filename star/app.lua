-- app.lua
-- @modify 2017-07-13 23:00
-- @author hanwanhe <hanwanhe@qq.com>
-- @desc per request create one app instance

local setmetatable = setmetatable
local Request = require('star.lib.request')
local Response = require('star.lib.response')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local dbClasses = {
    redis = require 'star.db.redis'
}


local App = {}
local mt = {__index = App}

function App:new(appName)
  local instance = {
    appName = appName,
    request = Request:new(),
    response = Response:new(),
  }
  return setmetatable(instance, mt)
end

function App:run()
  local controler, method = Router.parse(self.request)
  Dispatcher:run(self, controler, method)
end

function App:selectDB(dbClass, configGroup)
  dbClass = dbClass or 'mysql'
  configGroup = configGroup or 'default'

  if(dbClasses[dbClass] == nil) then
    return nil, 'star.db.'..dbClass..' is not exists.'
  end
  local db = dbClasses[dbClass]:new(configGroup)
  if(db.instance == nil) then
    return nil, 'star.db.'..dbClass..' `new` function does not return `instance` prototype.'
  end
  return db.instance, nil
end

return App