-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-16 22:39:28
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-19 23:20:53
-- @desc: some useful function

local ngx_say = ngx.say
local Common = {}

--table merge
function Common.table_merge(...)
  local result = {}
  local args = {...}
  for _, t in ipairs(args) do
    if(type(t) == 'table') then 
      for k, v in pairs(t) do
        result[k] = v 
      end
    end
  end
  return result
end

--variable dump
function Common.var_dump(var)
  if(type(var) == 'table') then
    ngx_say('{')
    for k, v in pairs(var) do 
      if(type(v) == 'table') then v = '#table' end    
      ngx_say('['..k..'] => '..v)
    end
    ngx_say('}')
    return
  end
  ngx_say(var)
end

--table dump, todo 
function Common.var_dump_table(var, level)
  if(type(var) == 'table') then
    ngx_say('{')
    for k, v in pairs(var) do 
      if(type(v) == 'table') then v = '#table' end    
      ngx_say('['..k..'] => '..v)
    end
    ngx_say('}')
    return
  end
  ngx_say(var)
end

return Common
