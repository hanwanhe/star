local setmetatable = setmetatable
local Controller = {}

function Controller:new(app)
  local instance = {
    app = app,
    request = app.request,
    response = app.response
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function Controller:construct()

end

function Controller:getRequest()
  return self.request 
end

function Controller:getResponse()
  return self.response
end


function Controller:getDB(...)
  return self.app:getDB(...)
end


return Controller