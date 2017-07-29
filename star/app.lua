-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-29 11:34:25
-- @desc: the framework entrance  file

local ngx = ngx
local require = require
local pcall = pcall
local Request = require('star.lib.request')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local Func = require('star.lib.func')
local all_db_modules = {
  redis = require('star.db.redis')
}

local App = {}
App.__index = App

-- create a new app instance
function App:new(app_name)
  local instance = {
    app_name = app_name,
    request = Request:new(),
    router = Router:new(),
    func = Func,
    loaded_model = {},
  }
  return setmetatable(instance, self)
end

-- connnect db
function App:load_database(module_name, config_group)
  module_name = module_name or 'mysql'
  config_group = config_group or 'default'
  local db_module = all_db_modules[module_name]
  if(db_module == nil) then
    return nil, 'no db module named '..module_name
  end
  local config = {}
  local ok, config_module = pcall(require, self.app_name..'.config.db.'.. module_name)
  if ok and type(config_module[config_group]) == 'table' then
    config = config_module[config_group]
  end
  local db, err = db_module:new(config)
  if not db then
    return nil, err
  end
  return db, nil
end


-- create a new model instance
function App:load_model(model_name)
  if(self.loaded_model[model_name]) then
    return self.loaded_model[model_name]
  end 
  local ok, Model_or_err = pcall(require, self.app_name..'.model.'..model_name)
  if not ok then
    local err = Model_or_err
    return nil, err
  end
  local Model = Model_or_err
  local model_instance = Model:_new(self)
  model_instance:_construct()
  self.loaded_model[model_name] = model_instance
  return model_instance
end

-- app insatance execute
function App:run()
  local controller, method = self.router:parse()
  local ok, err = pcall(Dispatcher.run, self, controller, method)
  if not ok then
    ngx.log(ngx.ERR, err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
end


return App