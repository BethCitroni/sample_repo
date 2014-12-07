#!/usr/bin/env ruby
require 'English'

# Get diffed files
git_diffs = `git diff --name-only HEAD~1`.each_line.map(&:chomp)

# Ignore deleted or renamed
edited_files = git_diffs.select { |file| File.exist?(file) } || []

results = []

edited_files.each do |file|
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
  results.push( $CHILD_STATUS.success? )
  $stdout.puts(msg)
end

exit(1) if results.include? false
