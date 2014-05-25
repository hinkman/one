#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-apache-$DATE.log}
apt-get install -y apache2 >> ${LOG} 2>&1
