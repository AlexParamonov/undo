require "forwardable"

module Undo
  class Wrapper < SimpleDelegator
    extend Forwardable
    def_delegators :object, :class, :kind_of?
    attr_reader :uuid

    def initialize(object, uuid, options = {})
      @object = object
      @mutator_methods = options.fetch :mutator_methods, []
      @uuid = object.respond_to?(:uuid) ? object.uuid : uuid

      super object
    end

    def method_missing(method, *args, &block)
      store if mutator_methods.include? method
      super method, *args, &block
    end

    private
    attr_reader :object, :mutator_methods

    def store
      Undo.store object, uuid: uuid
    end
  end
end
