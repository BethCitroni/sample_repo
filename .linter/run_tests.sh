#!/usr/bin/env bash
for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ]; then

    if [ ${file: -3} == ".rb" ]; then
      rubocop $file
    fi

    if [ ${file: -3} == ".js" ]; then
      jshint $file
    fi

    if [ ${file: -4} == ".css" ]; then
      csslint $file
    fi

    if [ ${file: -5} == ".html" ]; then
      htmllint $file
    fi
  fi
done
