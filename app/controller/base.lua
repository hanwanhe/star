-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-15 00:02:01
-- @desc: app base controller 

local Base = {}

function Base:construct()
  ngx.say('i am base constr'..self:getRequest().ngxVar.uri)
end



return Base