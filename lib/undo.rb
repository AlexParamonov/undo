require "undo/version"
require "undo/config"
require "undo/keeper"

module Undo
  def self.configure
    yield config
  end

  def self.store(object, options = {})
    keeper(options).store object
  end

  def self.restore(uuid, options = {})
    keeper(options).restore uuid
  end

  def self.delete(uuid, options = {})
    keeper(options).delete uuid
  end

  private
  def self.config
    @config ||= Undo::Config.new
  end

  def self.keeper(options)
    Keeper.new(config, options)
  end

  private_class_method :config, :keeper
end
