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

      @mutator_methods = options.delete :mutator_methods

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
