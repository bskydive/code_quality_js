# scripts to run in code_quality_js folder

## The hard way

* Run Angular lint/build scripts in isolated env
* You can try to reproduce Angular env from your project in code_quality_js folder

```bash
	# angular config files
	cd code_quality_js
	cp your_project_path/angular.json ./angular.json
	cp your_project_path/angular.json ./tsconfig.json
```
* add dependencies in package.json
* install/update and make all dependencies suitable to your framework version 
	* for ng v9: `npm i -D @angular-eslint/builder@1 @angular-eslint/eslint-plugin@1 @angular-eslint/eslint-plugin-template@1 @angular-eslint/schematics@1 @angular-eslint/template-parser@1`
* add and commit files to git
* Run commands from the `linters.sh` one by one
