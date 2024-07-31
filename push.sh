#!/bin/bash

# скрипт проверяет доступность по списку репозиториев, добавляет все новые файлы и отправляет изменения в master из текущей ветки

# usage:
# ./remote_git_init.sh # once
# ./push.sh message

result=""
errcode=0
message='content'
[[ -z $1 ]] || message=$1

push() {

	remote=${1}
	branch=${2}
	[[ -z ${2} ]] && branch=master

	echo "++++++++++PUSH:${remote}:test"

	git remote show ${remote} && {

		echo "++++++++++PUSH:${remote}:start"
		git push ${remote} ${branch}

		errcode=$?
		[[ ${errcode} -ne 0 ]] && result="${result}\n ++++++++++PUSH:${remote}:ERROR:${errcode}"
		[[ ${errcode} -eq 0 ]] && result="${result}\n ++++++++++PUSH:${remote}:OK"

		echo "++++++++++PUSH:${remote}:end"
		return ${errcode}
	} || result="${result}\n ++++++++++PUSH:${remote}:FAILED REMOTE TEST:$?"
}

git add -A ./
git commit -am ${message}

push "gl" || exit ${errcode}
push "gh"
# push "local"
# push "usb"


echo -e "++++++++++++++++++++++++++++++++++++++++"
echo -e "\n\n${result}\n\n"
echo -e "++++++++++++++++++++++++++++++++++++++++"

#exit ${errcode}
