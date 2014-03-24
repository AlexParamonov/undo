require "forwardable"

module Undo
  class Memory
    extend Forwardable
    attr_reader :options

    def initialize(config, options)
      @config = config
      @options = options
      @adapter_options = config.filter options
    end

    def write(object)
      build_uuid(object).tap do |uuid|
        storage.store uuid, serializer.serialize(object, adapter_options), adapter_options
      end
    end

    def read(uuid)
      serializer.deserialize storage.fetch(uuid, adapter_options), adapter_options
    end

    def delete(uuid)
      storage.delete uuid, adapter_options
    end

    private
    attr_reader :config, :adapter_options
    def_delegators :config, :storage, :serializer, :uuid_generator

    def build_uuid(object)
      options[:uuid] || uuid_generator.call(object)
    end
  end
end
