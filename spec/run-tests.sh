#!/usr/bin/env bash
for file in $(git diff --name-only HEAD~1); do
  if [ -a $file ]; then
    case ${file: -3} in
      ".rb") rubocop $file || exit 1;;

      ".js") jshint $file  || exit 1;;

      *) echo "ok";
    esac
  fi
done
