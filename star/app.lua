-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-25 22:39:19
-- @desc: the framework entrance  file

local require = require
local Request = require('star.lib.request')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local Db = require('star.lib.db')
local Func = require('star.lib.func')
local ngx = ngx


local App = {}
App.__index = App

function App:new(app_name)
  local instance = {
    app_name = app_name,
    request = Request:new(),
    db = Db:new(app_name),
    func = Func,
    loaded_model = {}
  }
  return setmetatable(instance, self)
end

function App:load_database(...)
  return self.db:connect(...)
end


function App:load_model(model_name)
  if(self.loaded_model[model_name]) then
    return self.loaded_model[model_name]
  end 
  local ok, Model_or_err = pcall(require, self.app_name..'.model.'..model_name)
  if not ok then
    return nil, Model_or_err
  end
  local model_instance = Model_or_err:new(self)
  model_instance:construct()
  self.loaded_model[model_name] = model_instance
  return model_instance
end

function App:run()
  local controller, method = Router.parse()
  local ok, err = pcall(Dispatcher.run, self, controller, method)
  if not ok then
    ngx.log(ngx.ERR, err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
  end
end


return App