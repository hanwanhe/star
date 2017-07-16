-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-16 23:16:14
-- @desc: every request will create one app instance


local setmetatable = setmetatable
local Request = require('star.lib.request')
local Response = require('star.lib.response')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local all_db_modules = {
    redis = require('star.db.redis')
}


local App = {}
local mt = {__index = App}

function App:new(app_name)
  local instance = {
    app_name = app_name,
    request = Request:new(),
    response = Response:new(),
    all_db_loaded = {}
  }
  for db_module, _ in pairs(all_db_modules) do
    instance.all_db_loaded[db_module] = {}
  end
  return setmetatable(instance, mt)
end

function App:run()
  local controler, method = Router.parse(self.request)
  Dispatcher:run(self, controler, method)
end

function App:select_db(db_module, config_group)
  db_module = db_module or 'mysql'
  config_group = config_group or 'default'
  if(self.all_db_loaded[db_module][config_group] ~= nil) then
    return self.all_db_loaded[db_module][config_group].instance, nil
  end 
  if(all_db_modules[db_module] == nil) then
    return nil, 'star.db.'..db_module..' is not exists.'
  end
  local ok, db_config = pcall(require, self.app_name..'.config.db.'..db_module)
  if ok then
    config = db_config[config_group]
  else
    config = {}
  end
  local db = all_db_modules[db_module]:new(config)
  if(db.instance == nil) then
    return nil, 'star.db.'..db_module..' `new` function does not return a table contains `instance` property.'
  end
  --register to allDbloaded for auto free
  if(self.all_db_loaded[db_module][config_group] == nil) then
    self.all_db_loaded[db_module][config_group] = db
  end 
  return db.instance, nil
end

function App:set_db_keepalive()
  for db_module, instances in pairs(self.all_db_loaded) do
    for _, instance in pairs(instances) do
      instance:set_keepalive()
    end
  end
end

return App