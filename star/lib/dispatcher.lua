local setmetatable = setmetatable
local base_controller = require('frame.lib.controller')  
local Dispatcher = {}
local mt = {__index = base_controller}

function Dispatcher:run(app, controller, method)
  local app_name = app.app_name 
  local app_controller = require(app_name..'.controller.'..controller)
  local meta_table = getmetatable(app_controller)
  -- load parent 
  if(app_controller.extends ~= nil) then
    local parent_controller = require(app_name..'.controller.'..app_controller.extends)
    parent_controller.__index = parent_controller
    if(meta_table == nil) then
      setmetatable(app_controller, parent_controller)
      app_controller.parent = parent_controller
      setmetatable(parent_controller, mt)
      parent_controller.parent = base_controller
    end
  else
    if(meta_table == nil) then
      setmetatable(app_controller, mt)
      app_controller.parent = base_controller
    end
  end
  -- app controller new instance
  app_controller_instance = app_controller:new(app)
  app_controller_instance:construct()
  return app_controller_instance[method](app_controller_instance)
end

return Dispatcher