#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-tools-$DATE.log}

apt-get install -y krb5-{admin-server,kdc}  >> ${LOG} 2>&1
# apt-get install -y libpam-krb5  >> ${LOG} 2>&1

# krb5_newrealm (with master pass)

# cleanup /etc/krb5.conf (add domain/dns map, add logging)
# mkdir /var/log/kerberos
# invoke-rc.d krb5-admin-server restart
# invoke-rc.d krb5-kdc restart
