if Undo::RUNNING_ON_CI
  require 'coveralls'
  Coveralls.wear!
else
  require 'pry'
end

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../rails_app/config/environment', __FILE__)
require 'rspec'
require_relative 'factories'

ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate(Rails.root.join('db', 'migrate').to_s)

RSpec.configure do |config|
  config.mock_with :rspec do |config|
    config.syntax = [:expect, :should]
  end
  config.include FactoryGirl::Syntax::Methods
end
