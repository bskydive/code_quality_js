# scripts to run in project folder

 * if you can't run `npm run build:analyze:view`: add this lines to the webpack.conf.js dev/prod section and build project 
	```js
		const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

		plugins: [
		new BundleAnalyzerPlugin({
			analyzerMode: 'static',
			openAnalyzer: false,
			generateStatsFile: true
		}),
	```
* workaround to fix duplicate linter versions and configs: `rm -rf node_modules`
* Running external linter
	* `export LINTER_PATH="code_quality_js-path"`
	* `eslint -c ${LINTER_PATH}/.eslintrc.js --resolve-plugins-relative-to ${LINTER_PATH}/ .`
	* `stylelint --config ${LINTER_PATH}/.stylelintrc.json --syntax css-in-js ./**/*.tsx | grep ' ⚠ ' | colrm 1 10 | tr -s ' ' | sort | uniq | less`
	* `cspell -uc ${LINTER_PATH}/.cspell.json ./*.* | awk -F 'Unknown word ' '{print $2}' | tr -d '()' > .cspell-dict-exclude.txt`


## Using with existed eslint in project

3. Disabling linter rules in IDE and CLI:
 	* `// prettier-ignore` before line/class/method
	* eslint
	```ts
	/* eslint-disable */

	/* eslint-enable */
	```
	* `tslint`
	```ts
	/* tslint:disable */
	```
4. Enable external linters in IDE:
	* remove local eslint

		```bash
			rm .eslintrc.js
			npm rm eslint @angular-eslint/builder @angular-eslint/eslint-plugin @angular-eslint/eslint-plugin-template @angular-eslint/schematics @angular-eslint/template-parser @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-compat
		```
	* revert `package*.json` changes
	* Don't forgot to repair local `.eslintrc` before commit!
	* instal  linters globally
	```bash
		npm i -g \
		typescript \
		tslint \
		eslint \
		stylelint \
		npm-run-all \
		cspell
	```
	* use project related IDE config `./.vscode/*`
	* enable using global eslint in IDE

5. Install eslint in your project

	```bash
		npm i webpack eslint @angular-eslint/builder @angular-eslint/eslint-plugin @angular-eslint/eslint-plugin-template @angular-eslint/schematics @angular-eslint/template-parser eslint-config-prettier eslint-config-standard eslint-import-resolver-typescript eslint-plugin-compat eslint-plugin-flowtype eslint-plugin-import eslint-plugin-jsx-a11y eslint-plugin-node eslint-plugin-prettier eslint-plugin-promise eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-rxjs @typescript-eslint/eslint-plugin @typescript-eslint/parser 
		
		# to add functional plugin
		npm i eslint@latest @typescript-eslint/eslint-plugin@latest @typescript-eslint/parser@latest tsutils eslint-plugin-functional
	```
