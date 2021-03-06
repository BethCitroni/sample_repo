#!/usr/bin/env bash
for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ]; then

    if [ ${file: -3} == ".rb" ]; then
      rubocop --config .linter/.rubocop.yml $file
    fi

    if [ ${file: -3} == ".js" ]; then
      jshint --config=.linter/.jshint $file
    fi

    if [ ${file: -4} == ".css" ]; then
      # csslint $file
      csscomb -c .linter/.csscomb.json -lv $file
    fi

    if [ ${file: -5} == ".html" ]; then
      htmllint --rc .linter/.htmllintrc $file
    fi
  fi
done
