# scripts to run in project folder

To avoid npm dependencies installation in linter folder. 

Before run 
 * enable fullTemplateTypeCheck or strictTemplates in tsconfig.json
 * check that `npm run lint:ng` command works
 * uncomment the NX section in scripts if you use it

* run 
	```bash
		cd typescript-tspqwe-linter_folder
		./scripts/project_folder/prepare.sh "absolute_path_to_project"
		cd "absolute_path_to_project"
		npm i # if needed
		npm i webpack-bundle-analyzer # if needed

		./scripts/project_folder/run.sh
	```
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
 * make the screenshots of `dist/report.html` and paste it into log folder
 * manually refine and move libs from log/npm.dependencies.log to report/README.md
