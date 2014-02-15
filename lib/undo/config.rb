require "virtus"
require "undo/storage/memory_adapter"

module Undo
  class Config
    include Virtus.model

    attribute :storage, Object, default: ->(config, _) { Undo::Storage::MemoryAdapter.new }
    attribute :mutator_methods, Array[Symbol], default: [:update, :delete, :destroy]
    attribute :serializer, Object, default: nil

    def with(attribute_updates = {}, &block)
      return self if attribute_updates.empty?
      self.class.new attribute_set.get(self).merge(attribute_updates)
    end
  end
end
