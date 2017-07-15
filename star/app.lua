-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-15 21:56:49
-- @desc: every request will create one app instance


local setmetatable = setmetatable
local Request = require('star.lib.request')
local Response = require('star.lib.response')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local allDbModules = {
    redis = require('star.db.redis')
}


local App = {}
local mt = {__index = App}

function App:new(appName)
  local instance = {
    appName = appName,
    request = Request:new(),
    response = Response:new(),
    allDbloaded = {}
  }
  for dbModule, _ in pairs(allDbModules) do
    instance.allDbloaded[dbModule] = {}
  end
  return setmetatable(instance, mt)
end

function App:run()
  local controler, method = Router.parse()
  Dispatcher:run(self, controler, method)
end

function App:selectDB(dbModule, configGroup)
  dbModule = dbModule or 'mysql'
  configGroup = configGroup or 'default'
  if(self.allDbloaded[dbModule][configGroup] ~= nil) then
    return self.allDbloaded[dbModule][configGroup].instance, nil
  end 
  if(allDbModules[dbModule] == nil) then
    return nil, 'star.db.'..dbModule..' is not exists.'
  end
  local db = allDbModules[dbModule]:new(configGroup)
  if(db.instance == nil) then
    return nil, 'star.db.'..dbModule..' `new` function does not return a table contains `instance` property.'
  end
  --register to allDbloaded for auto free
  if(self.allDbloaded[dbModule][configGroup] == nil) then
    self.allDbloaded[dbModule][configGroup] = db
  end 
  return db.instance, nil
end

function App:setDbKeepAlive()
  for dbModule, instances in pairs(self.allDbloaded) do
    for _, instance in pairs(instances) do
      instance:setKeepAlive()
    end
  end
end

return App