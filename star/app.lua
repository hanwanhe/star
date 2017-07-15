-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-15 12:37:43
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
    ngxLog = ngx.log 
  }
  return setmetatable(instance, mt)
end

function App:run()
  local controler, method = Router.parse()
  Dispatcher:run(self, controler, method)
end

function App:selectDB(dbModule, configGroup)
  dbModule = dbModule or 'mysql'
  configGroup = configGroup or 'default'

  if(allDbModules[dbModule] == nil) then
    return nil, 'star.db.'..dbModule..' is not exists.'
  end
  local db = allDbModules[dbModule]:new(configGroup)
  if(db.instance == nil) then
    return nil, 'star.db.'..dbModule..' `new` function does not return a table contains `instance` property.'
  end
  return db.instance, nil
end


return App