require "forwardable"

module Undo
  class Wrapper < SimpleDelegator
    extend Forwardable
    def_delegators :object, :class, :kind_of?
    attr_reader :uuid

    def initialize(uuid, object, options = {})
      @uuid = uuid
      @object = object
      @mutator_methods = Kernel.Array(options.delete :mutator_methods)
      @options = options

      super object
    end

    def method_missing(method, *args, &block)
      store if mutator_methods.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :options, :mutator_methods

    def store
      Undo.store object, options.merge(uuid: uuid)
    end
  end
end
