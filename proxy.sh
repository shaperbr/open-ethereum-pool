#!/bin/bash

case "$1" in 
start)
   /usr/bin/screen -dmS PROXY /open-ethereum-pool/build/bin/open-ethereum-pool /open-ethereum-pool/proxy.json 
   ps -x | grep PROXY | grep -v grep | awk '{print $1}' $!>/var/run/PROXY.pid
   echo Iniciando Serviço da PROXY...
   ;;
stop)
   kill `cat /var/run/PROXY.pid`
   rm /var/run/PROXY.pid
   echo Parando Serviço da PROXY
   ;;
restart)
   $0 stop
   $0 start
   ;;
screen)
   /usr/bin/screen -r PROXY
   ;;
status)
   if [ -e /var/run/PROXY.pid ]; then
      echo PROXY está rodando, pid=`cat /var/run/PROXY.pid`
   else
      echo PROXY não está rodando
      exit 1
   fi
   ;;
*)
   echo "Uso: $0 {start|stop|status|restart|screen}"
esac

exit 0 
