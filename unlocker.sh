#!/bin/bash

case "$1" in 
start)
   /usr/bin/screen -dmS UNLOCKER /open-ethereum-pool/build/bin/open-ethereum-pool /open-ethereum-pool/unlocker.json 
   ps -x | grep UNLOCKER | grep -v grep | awk '{print $1}' $!>/var/run/UNLOCKER.pid
   echo Iniciando Serviço da UNLOCKER...
   ;;
stop)
   kill `cat /var/run/UNLOCKER.pid`
   rm /var/run/UNLOCKER.pid
   echo Parando Serviço da UNLOCKER
   ;;
restart)
   $0 stop
   $0 start
   ;;
screen)
   /usr/bin/screen -r UNLOCKER
   ;;
status)
   if [ -e /var/run/UNLOCKER.pid ]; then
      echo UNLOCKER está rodando, pid=`cat /var/run/UNLOCKER.pid`
   else
      echo UNLOCKER não está rodando
      exit 1
   fi
   ;;
*)
   echo "Uso: $0 {start|stop|status|restart|screen}"
esac

exit 0 
