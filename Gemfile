source 'https://rubygems.org'

# Specify your gem's dependencies in undo.gemspec
gemspec

group :test do
  gem 'rails', '4.0.2'
  gem "jdbc-sqlite3", :platform => :jruby
  gem "sqlite3", :platform => [:ruby, :mswin, :mingw]
  gem 'factory_girl'
  gem 'faker'
end

platforms :rbx do
  gem 'racc'
  gem 'rubysl', '~> 2.0'
  gem 'psych'
end
