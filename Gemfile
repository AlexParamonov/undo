source 'https://rubygems.org'
gemspec

group :test do
  if !!ENV['CI']
    gem "pry"
  else
    gem "pry-plus" if "ruby" == RUBY_ENGINE
    gem "coveralls"
  end
end
