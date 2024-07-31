#!/bin/bash
# скрипт проверяет доступность по списку репозиториев, добавляет все новые файлы и отправляет изменения во все ветки
# usage: ./push.sh message

# git remote add gl git@gitlab.com:stepanovv/code_quality_js.git
# git remote add gh git@github.com:bskydive/code_quality_js.git
# git remote add usb //run/media/bsk/SD29G_EXT4/git-bare/code_quality_js

result=""
errcode=0

git add -A ./
git commit -am 'add files'

push() {

	remote=${1}
	echo "++++++++++PUSH:${remote}:test"

	git remote show ${remote} && {

		echo "++++++++++PUSH:${remote}:start"
		git push ${remote} --all

		errcode=$?
		[[ ${errcode} -ne 0 ]] && result="${result}\n ++++++++++PUSH:${remote}:ERROR:${errcode}"
		[[ ${errcode} -eq 0 ]] && result="${result}\n ++++++++++PUSH:${remote}:OK"

		echo "++++++++++PUSH:${remote}:end"
		return ${errcode}
	} || result="${result}\n ++++++++++PUSH:${remote}:FAILED REMOTE TEST:$?"
}

#push "usb" && \
push "gl"  || exit ${errcode}
push "gh"

echo -e "++++++++++++++++++++++++++++++++++++++++"
echo -e "\n\n${result}\n\n"
echo -e "++++++++++++++++++++++++++++++++++++++++"

exit ${errcode}

