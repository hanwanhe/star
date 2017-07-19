#!/bin/sh
# @Author: hanwanhe <hanwanhe@qq.com>
# @Date:   2017-07-15 14:08:59
# @Last Modified by:   hanwanhe <hanwanhe@qq.com>
# @Last Modified time: 2017-07-19 22:46:19
# @desc: server controller script

openrestyInstallPath=/usr/local/openresty
nginx="${openrestyInstallPath}/nginx/sbin/nginx -c conf/nginx.conf -p `pwd` "
cmd="$1"
option="$2"


function usage(){
  echo "usage: star.sh server start|stop|reload|restart"
  exit 1
}


function my_exit(){
  echo $1
  exit 1
}

function server(){
  if [ ! -x "./logs" ]; then
    mkdir "./logs"
  fi
  option=$1
  case  "$option"  in
    "start")
    ${nginx}
    ;;
    "stop")
    ${nginx} -s stop
    ;;
    "reload")
    ${nginx} -s reload
    ;;
    "restart")
    server stop
    sleep 3
    server start
    option='restart'
    ;;
    *)
    usage "server"
    ;;
  esac
  if [ $? != 0 ] ;then
    my_exit "server $option failed!"
  else
    echo "server $option success!"
  fi
}

if [ "$cmd" = "server" ];then
  server $option
else
  usage
fi


