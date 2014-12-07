#!/usr/bin/env bash

for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ] && [ ${file: -3} == ".js" ]; then
    jshint --config=.linter/.jshint $file
  fi
done
