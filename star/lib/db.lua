-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-17 21:45:41
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-22 17:31:51
-- @desc: db module

local setmetatable = setmetatable
local require = require
local all_db_modules = {
  redis = require('star.db.redis')
}

local DB = {}
DB.__index = DB

function DB:new(app_name)
  local instance = {
    app_name = app_name,
    loaded = {}
  }
  return setmetatable(instance, self)
end

function DB:connect(module_name, config_group)
  module_name = module_name or 'mysql'
  config_group = config_group or 'default'
  local db_module = all_db_modules[module_name]
  if(db_module == nil) then
    return nil, 'no db module named '..module_name
  end
  if(self.loaded[module_name] == nil) then
    self.loaded[module_name] = {}
  end
  if(self.loaded[module_name][config_group]) then
    return self.loaded[module_name][config_group], nil
  end
  local config = {}
  local ok, config_module = pcall(require, self.app_name..'.config.db.'.. module_name)
  if ok and type(config_module[config_group]) == 'table' then
    config = config_module[config_group]
  end
  ngx.say('helo')
  local db, err = db_module:new(config)
  if not db then
    return nil, err
  end
  self.loaded[module_name][config_group] = db
  return db, nil
end



return DB
