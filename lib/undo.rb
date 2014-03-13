require "undo/version"
require "undo/config"
require "undo/wrapper"

module Undo
  def self.configure(&block)
    block_given? ? block.call(config) : config
  end

  def self.store(object, options = {})
    config.with(options) do |config|
      uuid(object, options).tap do |uuid|
        config.storage.put uuid, config.serializer.serialize(object)
      end
    end
  end

  def self.restore(uuid, options = {})
    config.with(options) do |config|
      config.serializer.deserialize config.storage.fetch(uuid)
    end
  end

  def self.wrap(object, options = {})
    config.with(options) do |config|
      Wrapper.new(
        object,
        uuid(object, options),
        mutator_methods: config.mutator_methods
      )
    end
  end

  private
  def self.uuid(object, options = {})
    options[:uuid] || config.uuid_generator.call(object)
  end

  def self.config
    @config ||= Undo::Config.new
  end

  private_class_method :uuid, :config
end
