#!/bin/bash

#VARS
DATE=${DATE:-`date +%Y%m%d%H%M%S`}
LOG=${LOG:-/tmp/bootstrap-$DATE.log}
export DATE LOG

TAGS=`curl -v "http://metadata.google.internal/computeMetadata/v1/instance/tags" -H "Metadata-Flavor: Google" 2>>${LOG} | sed -e 's/[",[]/ /g; s/]//'`
INSTANCENAME=`hostname -s`

echo Instance: ${INSTANCENAME}

if [ -z ${GITHUBUSER} ]; then
	read -p "GitHub username: " GITHUBUSER
fi

if [ -z ${GITHUBPASS} ]; then
	read -s -p "GitHub Password: " GITHUBPASS
fi
echo

for tag in ${TAGS} ; do
  case ${tag} in
  	apache )
		echo "Installing apache"
		curl -vLk -u ${GITHUBUSER}:${GITHUBPASS} -H 'Accept: application/vnd.github.v3.raw' https://api.github.com/repos/hinkman/one/contents/src/install-apache.sh 2>>${LOG} | bash;;

  	tools )
		echo "Installing dns/net tools"
		curl -vLk -u ${GITHUBUSER}:${GITHUBPASS} -H 'Accept: application/vnd.github.v3.raw' https://api.github.com/repos/hinkman/one/contents/src/install-tools.sh 2>>${LOG} | bash;;

	* )
		echo "invalid tag $tag";;
  esac
done
