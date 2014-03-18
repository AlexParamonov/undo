require "undo/config"
require "undo/wrapper"

module Undo
  def self.configure(&block)
    block_given? ? block.call(config) : config
  end

  def self.store(object, options = {})
    config.with(options) do |config|
      config.build_uuid(object, options).tap do |uuid|
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
    config.with(options) do |config|
      uuid = config.build_uuid(object, options)
      Wrapper.new uuid, object, config.attributes.merge(options)
    end
  end

  private
  def self.config
    @config ||= Undo::Config.new
  end

  private_class_method :config
end
