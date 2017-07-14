-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-14 23:56:42
-- @desc: 
local Index = {
  extends = 'base'
}

function Index:construct(app)
  self.parent.construct(self)
end

function Index:index()
  local redis = self:selectDB('redis', 'default')
  redis:set('name', 'hanwanhe')
  ngx.say(redis:get('name'))
end

return Index