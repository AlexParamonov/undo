require "undo/version"
require "undo/config"

module Undo
  require "undo/model"
  require "undo/serializer/null"

  def self.configure(&block)
    yield(config) if block_given?
    config
  end

  def self.config
    @config ||= Undo::Config.new
  end

  def self.wrap(object, *args)
    Model.new object, *args
  end

  def self.restore(uuid, options = {})
    config.with(options).storage.fetch uuid
  end
end
