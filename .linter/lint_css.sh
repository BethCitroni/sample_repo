#!/usr/bin/env bash

for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ] && [ ${file: -4} == ".css" ]; then
    csscomb -c .linter/.csscomb.json -lv $file
  fi
done
