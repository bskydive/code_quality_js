# prepare project for linting
# usage
# cd typescript-tspqwe-linter
# ./scripts/project_folder/prepare.sh "path_to_project"
log_file="./log/log.project.md"
project_folder=$1
mkdir -p log
[[ -z ${project_folder} ]] && `echo "invalid path to project in cli parameters" | tee -a ${log_file} && exit`
touch ${log_file}

mkdir ${project_folder}/scripts
cp -r ./scripts/project_folder ${project_folder}/scripts/ || (echo \"run script from the code_quality_js root folder\" | tee -a ${log_file} && exit)

cd ${project_folder}
# npm i

# check npm version and add scripts to package.json
# npm v7+ required to add scripts via cli

[[ `npm -v | awk -F'.' '{print $1}'` -lt 7 ]] && echo "npm version `npm -v` less than 7, add scripts manually or switch to node v15+" | tee -a ${log_file}
[[ `npm -v | awk -F'.' '{print $1}'` -lt 7 ]] && exit

npm pkg set scripts."webpack:analyze:view=webpack-bundle-analyzer dist/stats.json" 
# npm pkg set scripts."build" "ng build  --aot --prod",
npm pkg set scripts.ng-safe="node --max_old_space_size=8192 ./node_modules/@angular/cli/bin/ng",
npm pkg set scripts.build:analyze="npm run ng-safe build --stats-json"
npm pkg set scripts.webpack:build="webpack --profile --json > dist/stats.json"
npm pkg set scripts.webpack:analyze:view="webpack-bundle-analyzer dist/stats.json"
npm pkg set scripts.lint:ng="ng lint"

# NX
npm pkg set scripts.build-stats="nx build name --configuration production --stats-json"

