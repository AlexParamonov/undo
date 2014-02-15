require "virtus"

module Undo
  class Config
    include Virtus.model

    attribute :mutator_methods, Array[Symbol], default: [:update, :delete, :destroy]

    attribute :uuid_generator, Proc, default: ->(config, _) {
      require "securerandom"
      ->(object) { SecureRandom.uuid }
    }
    attribute :storage, Object, default: ->(config, _) {
      require "undo/storage/memory_adapter"
      Undo::Storage::MemoryAdapter.new
    }
    attribute :serializer, Object, default: ->(config, _) {
      require "undo/serializer/simple"
      Undo::Serializer::Simple.new
    }

    def with(attribute_updates = {}, &block)
      return self if attribute_updates.empty?
      self.class.new attribute_set.get(self).merge(attribute_updates)
    end
  end
end
