-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 12:05:21
-- @desc: return the `controller` and `method` to be executed from the uri

local table = table
local gmatch = ngx.re.gmatch
local strlower = string.lower


local Router = {}

function Router.parse()
  local uri = ngx.var.uri
  if(uri == '/') then
    return 'index', 'index'
  end
  local match = {}
  for v in gmatch(uri, '/([\\w\\_]+)', 'o') do
    table.insert(match, v[1])
  end
  if(#match == 1) then
    return match[1], 'index'
  else
    return table.concat(match, '.', 1, #match - 1), strlower(match[#match])
  end
end

return Router