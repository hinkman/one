#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-nameserver-$DATE.log}

echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list
echo "deb http://ftp.de.debian.org/debian experimental main" >> /etc/apt/sources.list
apt-get update >> ${LOG} 2>&1
apt-get install -y dnscache-run  >> ${LOG} 2>&1
echo "1" > /etc/dnscache/env/FORWARDONLY
LOCALIP=`ifconfig -a | head -2 | tail -1 | sed 's/.*addr:\([0-9\.]*\) .*$/\1/'`
echo ${LOCALIP} > /etc/dnscache/env/IP
FIRSTOCT=`echo $LOCALIP | awk -F . '{ print $1 }'`
touch /etc/dnscache/root/ip/${FIRSTOCT}
echo "169.254.169.254"  >  /etc/dnscache/root/servers/@
if [ -z ${LOCALDOMAIN} ]; then
	read -p "Local domain name (required): " LOCALDOMAIN
fi
LOCALDOMAIN=${LOCALDOMAIN:-"localdomain.com"}
echo "127.0.0.1" > /etc/dnscache/root/servers/${LOCALDOMAIN}

# resolv.conf
# domain ${LOCALDOMAIN}
# search ${LOCALDOMAIN} existing...
# echo "nameserver ${LOCALIP}" >> /etc/resolv.conf


apt-get install -y tinydns-run  >> ${LOG} 2>&1
echo "127.0.0.1" > /etc/tinydns/env/IP
echo "&hinkman.com::dev-admin01.hinkman.com.:3600" >> /etc/tinydns/root/data
echo ".hinkman.com:127.0.0.1:a:3600" >> /etc/tinydns/root/data
echo "=dev-admin01.hinkman.com.:10.240.99.77:3600" >> /etc/tinydns/root/data
echo "=robot.hinkman.com.:10.240.69.249:3600" >> /etc/tinydns/root/data
