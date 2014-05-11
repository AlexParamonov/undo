require "virtus"
require "undo/serializer/null"
require "undo/storage/memory"
require "securerandom"

module Undo
  class Config
    include Virtus.model

    attribute :serializer,      Object,  default: Undo::Serializer::Null.new
    attribute :storage,         Object,  default: Undo::Storage::Memory.new
    attribute :uuid_generator,  Proc,    default: :default_uuid_generator

    def with(attribute_updates = {})
      self.class.new attributes.merge attribute_updates
    end

    def filter(options)
      attribute_names = attribute_set.map(&:name)
      options.reject { |key, _| attribute_names.include? key.to_sym }
    end

    private
    def default_uuid_generator
      -> object { SecureRandom.uuid }
    end
  end
end
