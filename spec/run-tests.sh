#!/usr/bin/env bash
for file in $(git diff --name-only HEAD~1); do
    # test if file exists and is ruby
    if [ -a $file ] && [ ${file: -3} == ".rb" ]; then
      # lint file. exit on error.
      rubocop $file || exit 1;
    fi
done
