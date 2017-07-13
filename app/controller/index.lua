local Index = {
  extends = 'base'
}

function Index:construct(app)
  self.parent.construct(self)
end

function Index:index()
  local redis = self:getDB('redis', 'default')
  redis:set('name', 'hanwanhe')
  ngx.say(redis:get('name'))
end

return Index