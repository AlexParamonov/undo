require "undo/version"
require "undo/config"

module Undo
  require "undo/model"

  def self.config
    yield(Undo::Config) if block_given?
    Undo::Config
  end
end
