if !!ENV['CI']
  require 'coveralls'
  Coveralls.wear!
else
  require 'pry'
end

ENV['RAILS_ENV'] ||= 'test'
require 'rspec'
require 'undo'

$: << File.expand_path('../lib', File.dirname(__FILE__))
