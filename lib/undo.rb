require "undo/version"
require "undo/config"

module Undo
  require "undo/model"

  def self.config(&block)
    @config ||= Undo::Config.new
    yield(@config) if block_given?
    @config
  end
end
