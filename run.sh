#!/bin/sh

case $1 in
start)
  nohup ./webcron /dev/null 2>&1 >>info.log 2>&1 &
  echo "服務已啟動..."
  sleep 1
  ;;
stop)
  killall webcron
  echo "服務已停止..."
  sleep 1
  ;;
restart)
  killall webcron
  sleep 1
  nohup ./webcron /dev/null 2>&1 >>info.log 2>&1 &
  echo "服務已重啟..."
  sleep 1
  ;;
*)
  echo "$0 {start|stop|restart}"
  exit 4
  ;;
esac