-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-15 21:29:59
-- @desc: index controller

local ngx = ngx

local Index = {
  extends = 'base'
}

function Index:construct(app)
  self.parent.construct(self)
end

function Index:index()
  local redis = self.app:selectDB('redis', 'default')
  redis:set('name', 'han')
  ngx.say(redis:get('name'))
end

return Index