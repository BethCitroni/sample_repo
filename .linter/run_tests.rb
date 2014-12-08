#!/usr/bin/env ruby
require 'English'

# Get diffed files
git_diffs = `git diff --name-only HEAD~1`.each_line.map(&:chomp)

# Ignore deleted or renamed
edited_files = git_diffs.select { |file| File.exist?(file) } || []

edited_files.map! do |file|

  name = File.basename(file)

  message = case File.extname(file)
            when '.rb'
              `rubocop ${file} --config .linter/.rubocop.yml`
            when '.js'
              `jshint ${file} --config=.linter/.jshint`
            when '.css'
              `csscomb ${file} -c .linter/.csscomb.json -lv`
            when '.html'
              `htmllint ${file} --rc .linter/.htmllintrc`
            else
              'ok'
            end

  success = $CHILD_STATUS.success?

  $stdout.puts(message) if !success

  { name: name, message: message, success: success }
end

if edited_files.select { |result| !result[:success] }.any?
  $stdout.puts("Errors: #{edited_files.count { |result| !result[:success] }}")
  exit 1
else
  $stdout.puts("No errors")
  exit 0
end
