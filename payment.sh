#!/bin/bash

case "$1" in 
start)
   /usr/bin/screen -dmS PAYMENT /open-ethereum-pool/build/bin/open-ethereum-pool /open-ethereum-pool/payment.json 
   ps -x | grep PAYMENT | grep -v grep | awk '{print $1}' $!>/var/run/PAYMENT.pid
   echo Iniciando Serviço da PAYMENT...
   ;;
stop)
   kill `cat /var/run/PAYMENT.pid`
   rm /var/run/PAYMENT.pid
   echo Parando Serviço da PAYMENT
   ;;
restart)
   $0 stop
   $0 start
   ;;
screen)
   /usr/bin/screen -r PAYMENT
   ;;
status)
   if [ -e /var/run/PAYMENT.pid ]; then
      echo PAYMENT está rodando, pid=`cat /var/run/PAYMENT.pid`
   else
      echo PAYMENT não está rodando
      exit 1
   fi
   ;;
*)
   echo "Uso: $0 {start|stop|status|restart|screen}"
esac

exit 0 
