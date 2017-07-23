-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-16 22:39:28
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-23 23:39:49
-- @desc: some useful function

local ngx_say = ngx.say
local string = string
local Func = {}

--table merge
function Func.table_merge(...)
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
function Func.var_dump(var)
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
function Func._var_dump_table(var, level)
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

--string and length > 0
function Func.str_exists(var)
  return type(var) == 'string' and string.len(var) > 0
end

return Func
