#!/bin/bash

# удаляем стандартный origin, чтобы использовать скрипты pull.sh+push.sh для несокльких реп
repo_name=code_quality_js

git remote
cat .git/config | grep -i url

git remote add bb git@bitbucket.org:stepanovvgm/${repo_name}.git && git remote remove origin
git branch --set-upstream-to=bb/master master

#host1=pc-3
#ping -c3 -q ${host1} || {
#	echo "add ${host1} to /etc/hosts"
#	exit 1
#}
#git remote add ${host1} ssh://bsk@${host1}/doc/coding/BARE/${repo_name} && git remote remove origin
#git remote add local //doc/coding/BARE/${repo_name}

git remote
