require "undo/container/json"

module Undo
  module Storage
    class Adapter
      def initialize(options = {})
        @options = options
        @container = options.fetch(:container) { Undo::Container::Json.new }
      end

      def store(uuid, object, options = {}) end
      def fetch(uuid, options = {}) end
      def delete(uuid, options = {}) end

      private
      attr_reader :options, :container

      def pack(object)
        container.pack object
      end

      def unpack(data)
        container.unpack object
      end

      def adapter_options(local_options)
        options.merge local_options
      end
    end
  end
end
