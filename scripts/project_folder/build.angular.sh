############################################# BUILD ANGULAR

echo -e "\n# BUILD ANGULAR" > log/build.angular.md
# enable fullTemplateTypeCheck or strictTemplates in tsconfig.json


# logs output don't work because of putting all errors in stderr, copy it manually
# clear console
clear
#npm run build 2>&1>log/build.angular.log
npm run build:analyze 2>log/build.angular.log
# save console output to log/build.angular.log

grep -iE 'error' log/build.angular.log > log/build.angular.errors.log
wc -l log/build.angular.errors.log >> log/build.angular.md

grep 'src' log/build.angular.errors.log | awk -F':' '{print$2}' | sort | uniq > log/build.angular.errors.files.log
wc -l log/build.angular.errors.files.log >> log/build.angular.md

grep -E '(TS|NG)[[:alnum:]]{4,}' log/build.angular.errors.log | awk -F'error' '{print$2}' | awk -F':' '{print$1}' | sort | uniq > log/build.angular.ts-numbers.ts
wc -l log/build.angular.ts-numbers.ts >> log/build.angular.md
#less log/build.angular.ts-numbers.ts

cat log/build.angular.md >> log/log.project.md


