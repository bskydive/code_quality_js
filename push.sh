#!/bin/bash

git add -A ./*
git commit -am "${1} add files"
git push gl develop
git push gh develop
git push bb develop