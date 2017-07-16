-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-16 22:39:28
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-16 23:11:17
-- @desc: some useful function


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

return Common
