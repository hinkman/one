#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-tools-$DATE.log}

apt-get install -y dnsutils >> ${LOG} 2>&1
apt-get install -y mtr  >> ${LOG} 2>&1
