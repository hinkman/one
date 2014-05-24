#!/bin/bash

#VARS
TAGS=`curl -s "http://metadata.google.internal/computeMetadata/v1/instance/tags" -H "Metadata-Flavor: Google" | sed -e 's/[",[]/ /g; s/]//'`
INSTANCENAME=`hostname -s`

echo $INSTANCENAME

if [ -z $GITHUBUSER ]; then
	read -p "GitHub username: " GITHUBUSER
fi

if [ -z $GITHUBPASS ]; then
	read -s -p "GitHub Password: " GITHUBPASS
fi
echo

for tag in $TAGS ; do
  case $tag in
  	apache )
		echo "Installing apache"
		curl -sLk -u ${GITHUBUSER}:${GITHUBPASS} -H 'Accept: application/vnd.github.v3.raw' https://api.github.com/repos/hinkman/one/contents/src/install-apache.sh | sudo bash;;

  	dns )
		echo "Installing dns/net tools"
		curl -sLk -u ${GITHUBUSER}:${GITHUBPASS} -H 'Accept: application/vnd.github.v3.raw' https://api.github.com/repos/hinkman/one/contents/src/install-tools.sh | sudo bash;;

	* )
		echo "invalid tag $tag";;
  esac
done