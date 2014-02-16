source 'https://rubygems.org'
gemspec

group :test do
  if !!ENV['CI']
    gem "coveralls"
  else
    gem "pry"
    gem "pry-plus" if "ruby" == RUBY_ENGINE
  end
end
