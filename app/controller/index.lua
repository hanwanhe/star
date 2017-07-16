-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-16 21:57:53
-- @desc: index controller

local ngx = ngx

local Index = {
  extends = 'base'
}

function Index:construct(app)
  self.parent.construct(self)
end

function Index:index()
  --ngx.sleep(10)
  --ngx.say(tostring(ngx.ctx))

end

return Index