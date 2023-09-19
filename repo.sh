#!/bin.bash

git remote add bb git@bitbucket.org:bskydive/code_quality_js.git && echo "bb added"
git remote add gh git@github.com:bskydive/code_quality_js.git && echo "gh added"
git remote add gl git@gitlab.com:stepanovv/code_quality_js.git && echo "gl added"
git remote show | grep origin && git remote remove origin && echo "origin removed"