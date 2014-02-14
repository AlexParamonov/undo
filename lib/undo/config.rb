module Undo
  class Config
    class << self
      attr_writer :mutator_methods, :storage

      def mutator_methods
        Array(@mutator_methods ||= [:update, :delete, :destroy])
      end

      def storage
        @storage ||=
          begin
            require "undo/storage/memory_adapter"
            Undo::Storage::MemoryAdapter.new
          end
      end
    end
  end
end
