-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 22:47:44
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-17 22:48:33
-- @desc: every request will create one app instance

local setmetatable = setmetatable
local Request = require('star.lib.request')
local Response = require('star.lib.response')
local Router = require('star.lib.router')
local Dispatcher = require('star.lib.dispatcher')
local Db = require('star.lib.db')


local App = {}
local mt = {__index = App}

function App:new(app_name)
  local instance = {
    app_name = app_name,
    request = Request:new(),
    response = Response:new(),
    db = Db:new(app_name),
  }
  return setmetatable(instance, mt)
end

function App:run()
  local controler, method = Router.parse(self.request)
  Dispatcher:run(self, controler, method)
end


return App