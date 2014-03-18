require "undo/config"
require "undo/wrapper"

module Undo
  def self.configure(&block)
    block_given? ? block.call(config) : config
  end

  def self.store(object, options = {})
    config.with(options) do |config|
      uuid(object, options).tap do |uuid|
        config.storage.store uuid,
                             config.serializer.serialize(object, config.filter(options))
      end
    end
  end

  def self.restore(uuid, options = {})
    config.with(options) do |config|
      config.serializer.deserialize config.storage.fetch(uuid),
                                    config.filter(options)
    end
  end

  def self.delete(uuid, options = {})
    config.with(options) do |config|
      config.storage.delete(uuid)
    end
  end

  def self.wrap(object, options = {})
    options[:uuid] ||= uuid object, options
    config.with(options) do |config|
      Wrapper.new object, options.merge(mutator_methods: config.mutator_methods)
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
