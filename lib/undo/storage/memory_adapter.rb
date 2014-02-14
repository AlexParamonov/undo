module Undo
  module Storage
    class MemoryAdapter
      def put(uuid, object)
        storage[uuid] = object
      end

      def fetch(uuid)
        storage.fetch uuid
      end

      private
      def storage
        @storage ||= {}
      end
    end
  end
end
