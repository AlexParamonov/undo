require "forwardable"

module Undo
  class Wrapper < SimpleDelegator
    extend Forwardable
    def_delegators :object, :class, :kind_of?
    attr_reader :undo_uuid

    def initialize(object, memory, options = {})
      @object = object
      @memory = memory

      @mutation_methods = options.fetch :mutation_methods

      super object
    end

    def method_missing(method, *args, &block)
      store if mutation_methods.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :options, :mutation_methods

    def store
      @undo_uuid = memory.write object
    end
  end
end
