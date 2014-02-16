source 'https://rubygems.org'

# Specify your gem's dependencies in undo.gemspec
gemspec

group :test do
  gem "pry"
  gem "pry-plus" if "ruby" == RUBY_ENGINE
  gem "coveralls" if !!ENV['CI']
end
