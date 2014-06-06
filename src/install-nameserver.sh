#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-nameserver-$DATE.log}

cat >> /etc/apt/sources.list <EOF
deb http://ftp.de.debian.org/debian sid main
deb http://ftp.de.debian.org/debian experimental main
EOF
apt-get update >> ${LOG} 2>&1
apt-get install -y dnscache-run  >> ${LOG} 2>&1
apt-get install -y tinydns-run  >> ${LOG} 2>&1
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
echo "127.0.0.1" > /etc/tinydns/env/IP
