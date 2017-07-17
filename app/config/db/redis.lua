-- @Author: hanwanhe <hanwanhe@qq.com>
-- @Date:   2017-07-16 22:57:01
-- @Last Modified by: hanwanhe <hanwanhe@qq.com>
-- @Last Modified time: 2017-07-17 23:22:16
-- @desc: redis config file

return {
  default = {
    host = '127.0.0.1',
    port = 6379,
    unix = '',
    pool = '',
    timeout = 1000,
    max_idle_timeout = 30000,
    pool_size = 20,
    password = ''
  }

}
