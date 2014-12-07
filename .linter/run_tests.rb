#!/usr/bin/env ruby
require "English"

# Get diffed files
git_diff = `git diff --name-only HEAD~1`

# Ignore deleted or renamed
edited_files = git_diff.each_line.map(&:chomp).select! { |file| File.exists?(file) } || []


edited_files.map! do |file|
  case File.extname(file)
  when ".rb"
    `rubocop ${file} --config .linter/.rubocop.yml`
  when ".js"
    `jshint ${file} --config=.linter/.jshint`
  when ".css"
    `csscomb ${file} -c .linter/.csscomb.json -lv`
  when ".html"
    `htmllint ${file} --rc .linter/.htmllintrc`
  else
    "ok"
  end
  $CHILD_STATUS.success?
end

exit(1) if edited_files.include? false
