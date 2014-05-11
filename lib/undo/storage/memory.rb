module Undo
  module Storage
    class Memory
      def initialize(options = {})
      end

      def store(uuid, object, options = {})
        storage[uuid] = object
      end

      def fetch(uuid, options = {})
        storage.fetch(uuid)
      end

      def delete(uuid, options = {})
        storage.delete(uuid)
      end

      private
      def storage
        @storage ||= {}
      end
    end
  end
end
