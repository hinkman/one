#!/bin/bash

DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/install-tools-$DATE.log}
PROJECTID=${PROJECTID:-`curl -vL "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google" 2>>${LOG}`}
ZONE=${ZONE:-`curl -vL "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google" 2>>${LOG} | sed -e 's#^.*/\([^/]*\)$#\1#'`}
INSTANCENAME=${INSTANCENAME:-`hostname -s`}

if [ -z ${DBDRIVENAME} ]; then
	read -p "Database drive name [${INSTANCENAME}-db01]: " DBDRIVENAME
fi
DBDRIVENAME=${DBDRIVENAME:-"${INSTANCENAME}-db01"}

if [ -z ${DBDRIVESIZE} ]; then
	read -p "Database drive size (GB) [500]: " DBDRIVESIZE
fi
DBDRIVESIZE=${DBDRIVESIZE:-500}

echo Creating drive...
gcutil --service_version="v1" --project="${PROJECTID}" adddisk "${DBDRIVENAME}" --size_gb="${DBDRIVESIZE}" --zone="${ZONE}" >> ${LOG} 2>&1
sleep 15

echo Attaching drive to instance ${INSTANCENAME}
gcutil --project="${PROJECTID}" attachdisk --zone="${ZONE}" --disk="${DBDRIVENAME}",mode=rw ${INSTANCENAME} >> ${LOG} 2>&1
sleep 15

echo Formatting and mounting drive...
mkdir /mnt/olympus  >> ${LOG} 2>&1
/usr/share/google/safe_format_and_mount -m "mkfs.ext4 -F" /dev/disk/by-id/google-${DBDRIVENAME} /mnt/olympus >> ${LOG} 2>&1
sleep 15

echo Installing Postgres...
echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list 2>>${LOG}
apt-key adv --keyserver keys.gnupg.net --recv-keys ACCC4CF8 >> ${LOG} 2>&1
apt-get update >> ${LOG} 2>&1
apt-get install -y postgresql-9.2 postgresql-client-9.2 postgresql-contrib-9.2 >> ${LOG} 2>&1
