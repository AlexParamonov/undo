if Undo::RUNNING_ON_CI
  require 'coveralls'
  Coveralls.wear!
else
  require 'pry'
end

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../rails_app/config/environment', __FILE__)
require 'rspec'

ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate(Rails.root.join('db', 'migrate').to_s)
