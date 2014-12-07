#!/usr/bin/env bash

for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ] && [ ${file: -3} == ".rb" ]; then
    rubocop --config .linter/.rubocop.yml $file
  fi
done
