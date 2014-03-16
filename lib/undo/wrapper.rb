require "forwardable"

module Undo
  class Wrapper < SimpleDelegator
    extend Forwardable
    def_delegators :object, :class, :kind_of?
    attr_reader :uuid

    def initialize(object, options = {})
      @object = object
      @mutator_methods = options.delete(:mutator_methods) || []
      @uuid = object.respond_to?(:uuid) ? object.uuid : options.fetch(:uuid)
      @options = options

      super object
    end

    def method_missing(method, *args, &block)
      store if mutator_methods.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :options

    def mutator_methods
      Kernel.Array(@mutator_methods)
    end

    def store
      Undo.store object, options.merge(uuid: uuid)
    end
  end
end
