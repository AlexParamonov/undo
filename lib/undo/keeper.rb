require "forwardable"

module Undo
  class Keeper
    extend Forwardable

    def initialize(config, options)
      @config = config.with options
      @options = config.filter options
    end

    def store(object)
      build_uuid(object).tap do |uuid|
        reflection = serializer.serialize(object, options)
        storage.store uuid, reflection, options
      end
    end

    def restore(uuid)
      reflection = storage.fetch uuid, options
      serializer.deserialize reflection, options
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
