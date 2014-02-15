require "undo/version"
require "undo/config"

module Undo
  require "undo/model"

  def self.config(&block)
    @config ||= Undo::Config.new
    yield(@config) if block_given?
    @config
  end

  def self.wrap(object, *args)
    Model.new object, *args
  end

  def self.restore(uuid, options = {})
    config.with(options).storage.fetch uuid
  end
end
