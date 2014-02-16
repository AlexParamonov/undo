module Undo
  module Storage
    class Memory
      def initialize(options = {})
      end

      def put(uuid, object)
        storage[uuid] = object
      end

      def fetch(uuid)
        storage.fetch(uuid)
      end

      private
      attr_writer :storage

      def storage
        @storage ||= {}
      end
    end
  end
end
