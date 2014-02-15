module Undo
  module Storage
    class Memory
      def initialize(options = {})
        @serializer = options.fetch :serializer
      end

      def put(uuid, object)
        storage[uuid] = serialize object
      end

      def fetch(uuid)
        deserialize storage.fetch(uuid)
      end

      private
      attr_writer :storage
      attr_reader :serializer

      def storage
        @storage ||= {}
      end

      def serialize(object)
        serializer.to_memory_object object
      end

      def deserialize(data)
        serializer.from_memory_object data
      end
    end
  end
end
