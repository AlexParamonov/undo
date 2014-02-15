module Undo
  class Model < SimpleDelegator
    def initialize(object, options = {})
      @object = object
      @config = config.with options
      super object
    end

    def uuid
      @uuid ||= object.respond_to?(:uuid) ? object.uuid : generate_uuid
    end

    def method_missing(method, *args, &block)
      store if config.mutator_methods.include? method
      super method, *args, &block
    end

    private
    attr_reader :object

    def generate_uuid
      SecureRandom.uuid
    end

    def store
      config.storage.put uuid, object
    end

    def config
      @config ||= Undo.config
    end
  end
end
