#!/bin/bash

git config --global user.name "root" &&\
git config --global user.email "root@example.com" &&\
git remote set-url origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git &&\
git checkout -b master &&\
ruby ./main.rb
git add .
git commit -m "`date '+%Y%m%d-%H%M%S'`"
git push origin master
