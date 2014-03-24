require "undo/config"
require "undo/wrapper"
require "undo/memory"

module Undo
  def self.configure
    yield config
  end

  def self.store(object, options = {})
    memory(options).write object
  end

  def self.restore(uuid, options = {})
    memory(options).read uuid
  end

  def self.delete(uuid, options = {})
    memory(options).delete uuid
  end

  def self.wrap(object, options = {})
    Wrapper.new object, options
  end

  private
  def self.config
    @config ||= Undo::Config.new
  end

  def self.memory(options)
    Memory.new(
      config.with(options),
      config.filter(options)
    )
  end

  private_class_method :config
end
