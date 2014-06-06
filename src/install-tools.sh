#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-tools-$DATE.log}

apt-get install -y dnsutils >> ${LOG} 2>&1
apt-get install -y mtr  >> ${LOG} 2>&1
apt-get install -y krb5-{admin-server,kdc}
apt-get install -y libpam-krb5
cat >> /etc/apt/sources.list <EOF
deb http://ftp.de.debian.org/debian sid main
deb http://ftp.de.debian.org/debian experimental main
EOF
