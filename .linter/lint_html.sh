#!/usr/bin/env bash

for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ] && [ ${file: -5} == ".html" ]; then
    htmllint --rc .linter/.htmllintrc $file
  fi
done
