#!/bin/bash

case "$1" in 
start)
   /usr/bin/screen -dmS API /open-ethereum-pool/build/bin/open-ethereum-pool /open-ethereum-pool/api.json 
   ps -x | grep API | grep -v grep | awk '{print $1}' $!>/var/run/API.pid
   echo Iniciando Serviço da API...
   ;;
stop)
   kill `cat /var/run/API.pid`
   rm /var/run/API.pid
   echo Parando Serviço da API
   ;;
restart)
   $0 stop
   $0 start
   ;;
screen)
   /usr/bin/screen -r API
   ;;
status)
   if [ -e /var/run/API.pid ]; then
      echo API está rodando, pid=`cat /var/run/API.pid`
   else
      echo API não está rodando
      exit 1
   fi
   ;;
*)
   echo "Uso: $0 {start|stop|status|restart|screen}"
esac

exit 0 
