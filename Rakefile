require "bundler/gem_tasks"

require 'rspec/core/rake_task'
namespace :ci do
  desc "Run tests on CI"
  RSpec::Core::RakeTask.new('all') do |t|
    t.rspec_opts = '-fprogress'
    t.verbose = true
  end
end
