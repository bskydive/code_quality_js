#!/bin/bash

git add -A ./*
git commit -am "${1} add files"
git push gl --all
git push gh --all
git push bb --all