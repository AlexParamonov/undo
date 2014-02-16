require "undo/version"
require "undo/config"

module Undo
  require "undo/model"

  def self.configure(&block)
    block_given? ? block.call(config) : config
  end

  def self.config
    @config ||= Undo::Config.new
  end

  def self.wrap(object, *args)
    Model.new object, *args
  end

  def self.restore(uuid, options = {})
    config.with(options) do |config|
      config.serializer.deserialize config.storage.fetch uuid
    end
  end
end
