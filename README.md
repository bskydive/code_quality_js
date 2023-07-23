# README

## What is it?

1. The handy tool set to begin code conventions automation
1. Project health check report 
	* [report template RUS](doc/report_template.rus.md)
	* example 1 ENG
		* [disclaimer](doc/example_report/disclaimer.md)
		* [summary](doc/example_report/summary.md)
		* [details](doc/example_report/details.md)
	* [example 2 RUS](doc/wallet/readme.wallet.rus.md)
	* [article RUS](https://gitlab.com/stepanovv/kbo/-/blob/master/public/articles/public/%D0%BA%D0%B0%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%BE%20%D0%BA%D0%BE%D0%B4%D0%B0/%D0%BA%D0%B0%D1%87%D0%B5%D1%81%D1%82%D0%B2%D0%BE_%D0%BA%D0%BE%D0%B4%D0%B0.md)
1. Tools
	* [eslint](https://eslint.org/) - js/ts linter with plugins: typescript, angular, promise, react
	* [tslint](https://github.com/palantir/tslint) - still useful(finnish notation)
	* [stylelint](https://stylelint.io/) - css
	* [cspell](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) - spelling
	* [prettier](https://prettier.io/) - formatter
	* [jscpd](https://www.npmjs.com/package/jscpd) - copy paste
	* [webpack dependency graph](https://github.com/bskydive/webpack-dep-graph)
	* TODO [sonar](https://www.sonarqube.org/) - code quality
	* TODO [Live](https://stackblitz.com/edit/code_quality_js?file=README.md) linting playground

## What is it for?

1. Collect and reuse:
	* working live linters config files
	* typical code review issues based on linter rules
1. Provide an alternative to airbnb/google rule sets. Enterprise rule sets made to fit any project and reduce enabled rules as much as it possible.

## Scripts FAQ

 * grep - search files and text patterns
 * awk - search and combine text line blocks
 * find - search files and text patterns
 * `echo "text1 `$command` text2"` - insert command output into text
 * `wc -l $filename` - lines count in file
 * `$command | wc -l` - lines count in command output
 * `$command1 | $command2` - transmit command1 output to the command2 input
 * `$command > $file` - clear file and add text from the command output
 * `$command >> $file` - add text to the file from command output

## How to use

1. Run scripts from the project folder to avoid npm dependencies installation in linter folder
	* enable fullTemplateTypeCheck or strictTemplates in tsconfig.json
	* uncomment the NX section in scripts if you use it
	* run
		```bash
			cd code_quality_js-folder
			./scripts/project_folder/prepare.sh "absolute_path_to_project"
			cd "absolute_path_to_project"
			npm i
			./scripts/project_folder/run.sh
		```
	* make the screenshots of `dist/report.html` and paste it into `log` folder
	* manually refine and move libs from log/npm.dependencies.log to report/README.md
	* check the [README](./scripts/project_folder/README.md) for harder cases
1. Run scripts from the linters folder to avoid eslint configuration and dependency hell resolution in project folder
	* run
		```bash
			# install libs
			cd code_quality_js-folder
			npm i
			# copy project `src` folder to the linter `src` folder.
			cp your_project_path/src ./src
			# run scripts
			./scripts/linter_folder/run.sh
			# manually edit the eslint.rules.important.log
			./scripts/linter_folder/eslint.important.sh
			# remove mistakes from log/spell.words.important.log
			./scripts/linter_folder/spell.important.sh
		```
	* check the [README](./scripts/linters_folder/README.md) for harder cases

## Issues

 * jscpd hangs
	* disable blame
	* reduce threshold
	* analyze html|ts|css separately

## TODO

 * add [coupling/cohesion graph](https://github.com/bskydive/webpack-dep-graph) to help in folder structure refactoring
 	* shared files with large import count
	* impact, scope of refactoring
	* complexity visualization
 * add [processes analysis](https://github.com/bskydive/process_modeling)
	* files with high "bus factor"
	* people burnout risk
	* team velocity
 * add sonarlint docker
 * Angular code examples
 * Find how to use the live cloud playground https://stackblitz.com/edit/code_quality_js
 * badges
 * jest --coverage
