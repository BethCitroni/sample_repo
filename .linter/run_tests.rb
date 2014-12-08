#!/usr/bin/env ruby
require 'English'

# Get diffed files
git_diffs = `git diff --name-only HEAD~1`.each_line.map(&:chomp)

# Ignore deleted or renamed
edited_files = git_diffs.select { |file| File.exist?(file) } || []

results = edited_files.map do |file|
  msg = case File.extname(file)
        when '.rb'
          `rubocop ${file} --config .linter/.rubocop.yml`
          "Linting Ruby file #{file}"
        when '.js'
          `jshint ${file} --config=.linter/.jshint`
          "Linting JS file #{file}"
        when '.css'
          `csscomb ${file} -c .linter/.csscomb.json -lv`
          "Linting css file #{file}"
        when '.html'
          `htmllint ${file} --rc .linter/.htmllintrc`
          "Linting html file #{file}"
        else
          'ok'
        end
  $stdout.puts(msg)
  $CHILD_STATUS.success?
end

if results.include? false
  $stdout.puts("#{results.count(&:!)} error(s)")
  exit 1
end


