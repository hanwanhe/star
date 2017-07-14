-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-14 00:06:52
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-14 23:32:28
-- @desc: get the `controller` and `method` to be executed

local setmetatable = setmetatable
local table = table
local gmatch = ngx.re.gmatch
local strlower = string.lower
local Router = {}

function Router.parse(request)
  local uri = request.ngxVar.uri
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