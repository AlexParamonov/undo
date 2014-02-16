require "virtus"

module Undo
  class Config
    include Virtus.model

    attribute :mutator_methods, Array[Symbol], default: [:update, :delete, :destroy]

    attribute :uuid_generator, Proc, default: ->(config, _) {
      require "securerandom"
      ->(object) { SecureRandom.uuid }
    }
    attribute :serializer, Object, default: ->(config, _) {
      require "undo/serializer/null"
      Undo::Serializer::Null.new
    }
    attribute :storage, Object, default: ->(config, _) {
      require "undo/storage/memory"
      Undo::Storage::Memory.new serializer: config.serializer
    }, lazy: true

    def with(attribute_updates = {}, &block)
      config = attribute_updates.empty? ? self
                                        : self.class.new(attribute_set.get(self).merge attribute_updates)

      block_given? ? block.call(config) : config
    end
  end
end
