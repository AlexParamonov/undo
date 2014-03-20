require "forwardable"

module Undo
  class Wrapper < SimpleDelegator
    extend Forwardable
    def_delegators :object, :class, :kind_of?
    attr_reader :uuid

    def initialize(object, uuid, options = {})
      @object = object
      @uuid = uuid
      @options = options

      @mutation_methods = options.delete :mutation_methods

      super object
    end

    def method_missing(method, *args, &block)
      store if mutation_methods.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :options, :mutation_methods

    def store
      Undo.store object, options.merge(uuid: uuid)
    end
  end
end
