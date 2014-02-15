require "virtus"

module Undo
  class Config
    include Virtus.model

    attribute :mutator_methods, Array[Symbol], default: [:update, :delete, :destroy]

    attribute :uuid_generator, Proc, default: ->(config, _) {
      require "securerandom"
      ->(object) { SecureRandom.uuid }
    }
    attribute :serializer, Object, default: nil

    attribute :storage, Object, default: ->(config, _) {
      require "undo/storage/memory"
      Undo::Storage::Memory.new serializer: config.serializer
    }, lazy: true

    def with(attribute_updates = {}, &block)
      return self if attribute_updates.empty?
      self.class.new attribute_set.get(self).merge(attribute_updates)
    end
  end
end
