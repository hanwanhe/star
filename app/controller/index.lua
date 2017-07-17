-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-17 23:22:41
-- @desc: index controller

local ngx = ngx

local Index = {
  extends = 'base'
}

function Index:construct(app)
  self.parent.construct(self)
end

function Index:index()
  local redis, err = self.db:create('redis', 'default')
  if redis then
    ngx.say(err)
  end
end

return Index