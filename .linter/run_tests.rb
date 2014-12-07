require "English"

# Get diffed files
git_diff = `git diff --name-only HEAD~1`

# Ignore deleted or renamed
edited_files = git_diff.each_line.map(&:chomp).select! { |file| if File.exists?(file) }


edited_files.map! do |file|
  case File.extname(file)
  when ".rb"
    `rubocop ${file}`
  when ".js"
    `jshint ${file}`
  else
    "ok"
  end
  $CHILD_STATUS.success?
end

