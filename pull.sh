#!/bin/bash

# скрипт проверяет доступность по списку репозиториев и заливат изменения из master в текущую ветку

# usage:
# ./remote_git_init.sh # once
# ./pull.sh message

result=""
errcode=0

pull() {

	remote=${1}
	branch=${2}
	[[ -z ${2} ]] && branch=master

	echo "----------PULL:${remote}:test"

	git remote show ${remote} && {

		echo "----------PULL:${remote}:start"
		git pull ${remote} ${branch}

		errcode=$?
		[[ ${errcode} -ne 0 ]] && result="${result}\n ----------PULL:${remote}:ERROR:${errcode}"
		[[ ${errcode} -eq 0 ]] && result="${result}\n ----------PULL:${remote}:OK"
		echo "----------PULL:${remote}:end"

		return ${errcode}
	} || result="${result}\n ----------PULL:${remote}:FAILED REMOTE TEST:$?"

	return 0
}

# делаем хотя бы один pull
pull "gl" || exit ${errcode}
pull "gh"
pull "bb"
# pull "usb"
# pull "local"

echo -e "----------------------------------------"
echo -e "\n\n${result}\n\n"
echo -e "----------------------------------------"

#exit ${errcode}
