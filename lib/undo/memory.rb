require "forwardable"

module Undo
  class Memory
    extend Forwardable

    def initialize(config, options)
      @config = config
      @options = options
    end

    def write(object)
      build_uuid(object).tap do |uuid|
        storage.store uuid, serializer.serialize(object, options), options
      end
    end

    def read(uuid)
      serializer.deserialize storage.fetch(uuid, options), options
    end

    def delete(uuid)
      storage.delete uuid, options
    end

    private
    attr_reader :config, :options
    def_delegators :config, :storage, :serializer, :uuid_generator

    def build_uuid(object)
      options[:uuid] || uuid_generator.call(object)
    end
  end
end
